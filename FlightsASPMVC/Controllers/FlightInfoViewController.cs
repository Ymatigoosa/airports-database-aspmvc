using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FlightsASPMVC.Models;

namespace FlightsASPMVC.Controllers
{
    public class FlightInfoViewController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /FlightInfoView/
        public ActionResult Index()
        {
            return View(db.flight_info.ToList());
        }

        // GET: /FlightInfoView/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flight_info flight_info = db.flight_info.Find(id);
            if (flight_info == null)
            {
                return HttpNotFound();
            }
            return View(flight_info);
        }

        // GET: /FlightInfoView/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /FlightInfoView/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,plane_id,plane_model_name,team,passenger_capacity,bought,free,sortie_start,sortie_delta_time,landing_start,landing_delta_time,flight_class,from,to,periodicity_type,time_of_departure,travel_time,range,type,common_price,premium_price,airline_name")] flight_info flight_info)
        {
            if (ModelState.IsValid)
            {
                db.flight_info.Add(flight_info);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(flight_info);
        }

        // GET: /FlightInfoView/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flight_info flight_info = db.flight_info.Find(id);
            if (flight_info == null)
            {
                return HttpNotFound();
            }
            return View(flight_info);
        }

        // POST: /FlightInfoView/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,plane_id,plane_model_name,team,passenger_capacity,bought,free,sortie_start,sortie_delta_time,landing_start,landing_delta_time,flight_class,from,to,periodicity_type,time_of_departure,travel_time,range,type,common_price,premium_price,airline_name")] flight_info flight_info)
        {
            if (ModelState.IsValid)
            {
                db.Entry(flight_info).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(flight_info);
        }

        // GET: /FlightInfoView/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flight_info flight_info = db.flight_info.Find(id);
            if (flight_info == null)
            {
                return HttpNotFound();
            }
            return View(flight_info);
        }

        // POST: /FlightInfoView/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            flight_info flight_info = db.flight_info.Find(id);
            db.flight_info.Remove(flight_info);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
