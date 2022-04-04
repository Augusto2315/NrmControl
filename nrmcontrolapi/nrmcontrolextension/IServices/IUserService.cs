using nrmcontrolextension.Filters;
using nrmcontrolextension.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace nrmcontrolextension.IServices
{
    public interface IUserService
    {
        public Task<List<User>> GetUsers(UserFilter userFilter);
        public Task<User> SaveUser(User user);
        public Task<bool> ValidateLogin(User user);
        public Task<bool> DeleteUser(User user);
    }
}
