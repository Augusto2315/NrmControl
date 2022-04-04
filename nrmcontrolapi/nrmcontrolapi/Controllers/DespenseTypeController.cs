using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using nrmcontrolextension.IServices;
using nrmcontrolextension.Models;

namespace nrmcontrolapi.Controllers
{
    [Route("api/despenseType")]
    [Authorize]
    public class DespenseTypeController : Controller
    {

        private IDespenseTypeService _despenseTypeService;

        public DespenseTypeController(IDespenseTypeService despenseTypeService)
        {
            this._despenseTypeService = despenseTypeService;
        }

        [HttpGet()]
        public async Task<IActionResult> Get()
        {
            try
            {
                return Ok(await _despenseTypeService.GetDespenseTypes());
            }
            catch (Exception ex)
            {
                return Problem(ex.Message);
            }
        }

        [HttpPost()]
        public async Task<IActionResult> Post([FromBody] DespenseType despenseType)
        {
            try
            {
                return Ok(await _despenseTypeService.InsertDespenseType(despenseType));
            }
            catch (Exception ex)
            {
                return Problem(ex.Message);
            }
        }
    }
}
