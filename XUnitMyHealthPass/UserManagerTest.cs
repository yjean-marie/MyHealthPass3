using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xunit;
using MyHealthPass3.BusinessLogicLayer;

namespace XUnitMyHealthPass
{
    public class UserManagerTest
    {
        [Fact]
        public void RegisterSuccess()
        {
            var userManager = new UserManager();
            Assert.Equal(1, userManager.Register("email@domain.com", "Password#1", "http://localhost:44304/"));
        }
        //[Fact]
        //public void RegisterEmailFormatFailure()
        //{
        //    var userManager = new UserManager();
        //    Assert.Equal(-1, userManager.Register("email@@domain..com", "password1"));
        //}

        //[Fact]
        //public void RegisterEmailExistsFailure()
        //{
        //    var userManager = new UserManager();
        //    userManager.Register("email@domain.com", "password1");
        //    Assert.Equal(-2, userManager.Register("email@domain.com", "password1"));
        //}
        [Fact]
        public void ValidPasswordFormatTest()
        {
            var userManager = new UserManager();
            Assert.False(userManager.ValidPasswordCheck("paassword", "http://localhost:44304/"));
        }
        [Fact]
        public void ValidPasswordFormatTest1()
        {
            var userManager = new UserManager();
            Assert.False(userManager.ValidPasswordCheck("password1", "http://localhost:44304/"));
        }
        [Fact]
        public void ValidPasswordFormatTest2()
        {
            var userManager = new UserManager();
            Assert.False(userManager.ValidPasswordCheck("Password1", "http://localhost:44304/"));
        }
        [Fact]
        public void ValidPasswordFormatTest3()
        {
            var userManager = new UserManager();
            Assert.False(userManager.ValidPasswordCheck("p", "http://localhost:44304/"));
        }
        [Fact]
        public void ValidPasswordFormatTest4()
        {
            var userManager = new UserManager();
            Assert.True(userManager.ValidPasswordCheck("Password#1", "http://localhost:44304/"));
        }
        [Fact]
        public void ValidPasswordFormatTest5()
        {
            var userManager = new UserManager();
            Assert.False(userManager.ValidPasswordCheck("Password#1", "http://localhost:443042/"));
        }
    }
}
