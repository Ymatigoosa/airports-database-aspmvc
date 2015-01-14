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
    public class FlightInADayViewController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /FlightInADayView/
        public ActionResult Index()
        {
            return View(db.flights_by_airline_in_day.ToList());
        }

        // GET: /FlightInADayView/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flights_by_airline_in_day flights_by_airline_in_day = db.flights_by_airline_in_day.Find(id);
            if (flights_by_airline_in_day == null)
            {
                return HttpNotFound();
            }
            return View(flights_by_airline_in_day);
        }

        // GET: /FlightInADayView/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /FlightInADayView/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,airline_name,sortie,sortie_count")] flights_by_airline_in_day flights_by_airline_in_day)
        {
            if (ModelState.IsValid)
            {
                db.flights_by_airline_in_day.Add(flights_by_airline_in_day);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(flights_by_airline_in_day);
        }

        // GET: /FlightInADayView/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flights_by_airline_in_day flights_by_airline_in_day = db.flights_by_airline_in_day.Find(id);
            if (flights_by_airline_in_day == null)
            {
                return HttpNotFound();
            }
            return View(flights_by_airline_in_day);
        }

        // POST: /FlightInADayView/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,airline_name,sortie,sortie_count")] flights_by_airline_in_day flights_by_airline_in_day)
        {
            if (ModelState.IsValid)
            {
                db.Entry(flights_by_airline_in_day).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(flights_by_airline_in_day);
        }

        // GET: /FlightInADayView/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flights_by_airline_in_day flights_by_airline_in_day = db.flights_by_airline_in_day.Find(id);
            if (flights_by_airline_in_day == null)
            {
                return HttpNotFound();
            }
            return View(flights_by_airline_in_day);
        }

        // POST: /FlightInADayView/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            flights_by_airline_in_day flights_by_airline_in_day = db.flights_by_airline_in_day.Find(id);
            db.flights_by_airline_in_day.Remove(flights_by_airline_in_day);
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
