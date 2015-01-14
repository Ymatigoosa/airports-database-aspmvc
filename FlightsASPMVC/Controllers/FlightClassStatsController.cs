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
    public class FlightClassStatsController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /FlightClassStats/
        public ActionResult Index()
        {
            return View(db.flight_class_stat.ToList());
        }

        // GET: /FlightClassStats/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flight_class_stat flight_class_stat = db.flight_class_stat.Find(id);
            if (flight_class_stat == null)
            {
                return HttpNotFound();
            }
            return View(flight_class_stat);
        }

        // GET: /FlightClassStats/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /FlightClassStats/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,plane_id,plane_model_name,team,avg_passenger_capacity,avg_bought,avg_free,avg_sortie_delta_time,avg_delta_time")] flight_class_stat flight_class_stat)
        {
            if (ModelState.IsValid)
            {
                db.flight_class_stat.Add(flight_class_stat);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(flight_class_stat);
        }

        // GET: /FlightClassStats/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flight_class_stat flight_class_stat = db.flight_class_stat.Find(id);
            if (flight_class_stat == null)
            {
                return HttpNotFound();
            }
            return View(flight_class_stat);
        }

        // POST: /FlightClassStats/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,plane_id,plane_model_name,team,avg_passenger_capacity,avg_bought,avg_free,avg_sortie_delta_time,avg_delta_time")] flight_class_stat flight_class_stat)
        {
            if (ModelState.IsValid)
            {
                db.Entry(flight_class_stat).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(flight_class_stat);
        }

        // GET: /FlightClassStats/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flight_class_stat flight_class_stat = db.flight_class_stat.Find(id);
            if (flight_class_stat == null)
            {
                return HttpNotFound();
            }
            return View(flight_class_stat);
        }

        // POST: /FlightClassStats/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            flight_class_stat flight_class_stat = db.flight_class_stat.Find(id);
            db.flight_class_stat.Remove(flight_class_stat);
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
