using MyHealthPass3.DataAccessLayer;
using MyHealthPass3.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace MyHealthPass3.BusinessLogicLayer
{
    public class UserManager
    {
        private MyHealthPassContainer myHealthPassDb = new MyHealthPassContainer();
        public int Register(string email, string password, string url)
        {
            if (ValidEmailFormatCheck(email))
            {
                if (!EmailExistsCheck(email))
                {
                    if (ValidPasswordCheck(password, url))
                    {
                        //insert into 
                        myHealthPassDb.Users.Add(new User
                        {
                            Email = email,
                            PasswordHash = PBKDF2.CreateHash(password),
                            LastUpdated = DateTime.Now,
                            DateCreated = DateTime.Now,
                            IsLocked = false,
                            IsLockedOut = false,
                            IsDeleted = false,
                            LockoutTimeStamp = null

                        });
                        myHealthPassDb.SaveChanges();
                        return 1;
                    }
                    else return -3;
                }
                else return -2;
            }
            else return -1;
           
        }
        public bool ValidEmailFormatCheck(string email)
        {
            var foo = new EmailAddressAttribute();
            return foo.IsValid(email);
        }
        public bool EmailExistsCheck(string email)
        {
            return myHealthPassDb.Users.Where(a => a.Email == email).Any();
        }
        public bool ValidPasswordCheck(string password, string url)
        {
            var ClientDetails = myHealthPassDb.Clients.Where(a => a.ClientCorsOrigins.Where(b => b.Origin == url).Any()).FirstOrDefault();
            if (ClientDetails != null)
            {
                if (password.Length > ClientDetails.PasswordMinLength)
                {
                    if (!(ClientDetails.PasswordRequireCaps && !password.Any(char.IsUpper)))
                    {
                        if (!(ClientDetails.PasswordRequireDigit && !password.Any(char.IsDigit)))
                        {
                            if (!(ClientDetails.PasswordRequireDigit && !password.Any(ch => !Char.IsLetterOrDigit(ch))))
                            {
                                return true;
                            }
                        }
                    }
                }
            }
            return false;
        }


    }
}