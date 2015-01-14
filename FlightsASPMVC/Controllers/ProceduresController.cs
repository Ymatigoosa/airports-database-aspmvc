using FlightsASPMVC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FlightsASPMVC.Controllers
{
    public class ProceduresController : BaseController
    {
        private airportEntities1 db = new airportEntities1();

        //
        // GET: /Procedures/
        public ActionResult FlightAdd()
        {
            ViewBag.brigade = new SelectList(db.brigade, "id", "comment");
            ViewBag.flight_class = new SelectList(db.flight_class, "id", "id");
            ViewBag.plane = new SelectList(db.plane, "id", "id");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult FlightAdd(FlightAddInputViewModel m)
        {
            if (ModelState.IsValid)
            {
                try 
                {
                    db.flight_add(m.team_id, m.flight_class_id, m.plane_id, m.sortie_time, m.landing_time);
                    Success("succesful called", true);
                }
                catch 
                {
                    Danger("called with errors", true);
                }
                
            }
            ViewBag.brigade = new SelectList(db.brigade, "id", "comment");
            ViewBag.flight_class = new SelectList(db.flight_class, "id", "id");
            ViewBag.plane = new SelectList(db.plane, "id", "id");
            return View(m);
        }


        public ActionResult FlightChangePlane()
        {
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            ViewBag.plane = new SelectList(db.plane, "id", "id");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult FlightChangePlane(FlightChangePlaneInputViewModel m)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    db.flight_change_plane(m.flight_id, m.plane_id);
                    Success("succesful called", true);
                }
                catch
                {
                    Danger("called with errors", true);
                }

            }
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            ViewBag.plane = new SelectList(db.plane, "id", "id");
            return View(m);
        }


        public ActionResult FlightChangeTeam()
        {
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            ViewBag.brigade = new SelectList(db.brigade, "id", "comment");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult FlightChangeTeam(FlightChangeTeamInputViewModel m)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    db.flight_change_team(m.flight_id, m.team_id);
                    Success("succesful called", true);
                }
                catch
                {
                    Danger("called with errors", true);
                }

            }
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            ViewBag.brigade = new SelectList(db.brigade, "id", "comment");
            return View(m);
        }


        public ActionResult FlightGenerateNext()
        {
            ViewBag.brigade = new SelectList(db.brigade, "id", "comment");
            ViewBag.flight_class = new SelectList(db.flight_class, "id", "id");
            ViewBag.plane = new SelectList(db.plane, "id", "id");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult FlightGenerateNext(FlightGenerateNextInputViewModel m)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    db.flight_generate_next(m.flight_class_id, m.start_time, m.team_id, m.plane_id);
                    Success("succesful called", true);
                }
                catch
                {
                    Danger("called with errors", true);
                }

            }
            ViewBag.brigade = new SelectList(db.brigade, "id", "comment");
            ViewBag.flight_class = new SelectList(db.flight_class, "id", "id");
            ViewBag.plane = new SelectList(db.plane, "id", "id");
            return View(m);
        }


        public ActionResult FlightLandingDo()
        {
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult FlightLandingDo(FlightLandingDoInputViewModel m)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    db.flight_landing_do(m.flight_id);
                    Success("succesful called", true);
                }
                catch
                {
                    Danger("called with errors", true);
                }

            }
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            return View(m);
        }

        public ActionResult FlightLandingMove()
        {
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult FlightLandingMove(FlightLandingMoveInputViewModel m)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    db.flight_landing_move(m.flight_id, m.delta, m.reasont);
                    Success("succesful called", true);
                }
                catch
                {
                    Danger("called with errors", true);
                }

            }
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            return View(m);
        }

        public ActionResult FlightSortieCancel()
        {
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult FlightSortieCancel(FlightSortieCancelInputViewModel m)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    db.flight_sortie_cancele(m.flight_id, m.reasont);
                    Success("succesful called", true);
                }
                catch
                {
                    Danger("called with errors", true);
                }

            }
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            return View(m);
        }

        public ActionResult FlightSortieDo()
        {
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult FlightSortieDo(FlightSortieDoInputViewModel m)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    db.flight_sortie_do(m.flight_id);
                    Success("succesful called", true);
                }
                catch
                {
                    Danger("called with errors", true);
                }

            }
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            return View(m);
        }

        public ActionResult FlightSortieMove()
        {
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult FlightSortieMove(FlightSortieMoveInputViewModel m)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    db.flight_sortie_move(m.flight_id, m.delta, m.reasont);
                    Success("succesful called", true);
                }
                catch
                {
                    Danger("called with errors", true);
                }

            }
            ViewBag.flight = new SelectList(db.flight, "id", "id");
            return View(m);
        }
	}
}