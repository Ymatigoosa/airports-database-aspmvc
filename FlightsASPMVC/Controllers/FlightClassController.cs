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
    public class FlightClassController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /FlightClass/
        public ActionResult Index()
        {
            var flight_class = db.flight_class.Include(f => f.airport).Include(f => f.airport1);
            return View(flight_class.ToList());
        }

        // GET: /FlightClass/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flight_class flight_class = db.flight_class.Find(id);
            if (flight_class == null)
            {
                return HttpNotFound();
            }
            return View(flight_class);
        }

        // GET: /FlightClass/Create
        public ActionResult Create()
        {
            ViewBag.to = new SelectList(db.airport, "id", "id");
            ViewBag.from = new SelectList(db.airport, "id", "id");
            return View();
        }

        // POST: /FlightClass/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,from,to,periodicity_type,period,time_of_departure,travel_time,range,type,common_price,premium_price")] flight_class flight_class)
        {
            if (ModelState.IsValid)
            {
                db.flight_class.Add(flight_class);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.to = new SelectList(db.airport, "id", "id", flight_class.to);
            ViewBag.from = new SelectList(db.airport, "id", "id", flight_class.from);
            return View(flight_class);
        }

        // GET: /FlightClass/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flight_class flight_class = db.flight_class.Find(id);
            if (flight_class == null)
            {
                return HttpNotFound();
            }
            ViewBag.to = new SelectList(db.airport, "id", "id", flight_class.to);
            ViewBag.from = new SelectList(db.airport, "id", "id", flight_class.from);
            return View(flight_class);
        }

        // POST: /FlightClass/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,from,to,periodicity_type,period,time_of_departure,travel_time,range,type,common_price,premium_price")] flight_class flight_class)
        {
            if (ModelState.IsValid)
            {
                db.Entry(flight_class).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.to = new SelectList(db.airport, "id", "id", flight_class.to);
            ViewBag.from = new SelectList(db.airport, "id", "id", flight_class.from);
            return View(flight_class);
        }

        // GET: /FlightClass/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flight_class flight_class = db.flight_class.Find(id);
            if (flight_class == null)
            {
                return HttpNotFound();
            }
            return View(flight_class);
        }

        // POST: /FlightClass/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            flight_class flight_class = db.flight_class.Find(id);
            db.flight_class.Remove(flight_class);
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
