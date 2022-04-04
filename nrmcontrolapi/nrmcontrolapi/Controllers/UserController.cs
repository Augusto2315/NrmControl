using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using nrmcontrolextension.Filters;
using nrmcontrolextension.IServices;
using nrmcontrolextension.Models;

namespace nrmcontrolapi.Controllers
{
    [Route("api/user")]
    [Authorize]
    public class UserController : Controller
    {
        private IUserService _UserService;

        public UserController(IUserService userService)
        {
            this._UserService = userService;
        }

        [HttpGet()]
        public async Task<IActionResult> Get()
        {
            UserFilter userFilter = new UserFilter();
            try
            {
                return Ok(await _UserService.GetUsers(userFilter));
            }
            catch (Exception ex)
            {
                return Problem(ex.Message);
            }
        }

        [HttpGet("{userId}")]
        public async Task<IActionResult> Get(string userId)
        {
            UserFilter userFilter = new UserFilter();
            if (!string.IsNullOrEmpty(userId))
            {
                userFilter.UserId = userId;
            }
            try
            {
                return Ok(await _UserService.GetUsers(userFilter));
            }
            catch (Exception ex)
            {
                return Problem(ex.Message);
            }
        }

        [HttpPost()]
        public async Task<IActionResult> Post([FromBody] User user)
        {
            try
            {
                return Ok(await _UserService.SaveUser(user));
            }
            catch (Exception ex)
            {
                return Problem(ex.Message);
            }
        }

        [HttpPost()]
        [Route("login")]
        public async Task<IActionResult> ValidateLogin([FromBody] User user)
        {
            try
            {
                return Ok(await _UserService.ValidateLogin(user));
            }
            catch (UnauthorizedAccessException ex)
            {
                return Unauthorized(new { Detail = ex.Message });
            }
            catch (Exception ex)
            {
                return Problem(ex.Message);
            }
        }


        [HttpDelete("{userId}")]
        public async Task<IActionResult> Delete(string userId)
        {
            User user = new User(false, userId, string.Empty);

            try
            {
                return Ok(await _UserService.DeleteUser(user));
            }
            catch (Exception ex)
            {
                return Problem(ex.Message);
            }
        }
    }
}
