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
    public class FlightController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /Flight/
        public ActionResult Index()
        {
            var flight = db.flight.Include(f => f.brigade).Include(f => f.flight_class1).Include(f => f.plane1);
            return View(flight.ToList());
        }

        // GET: /Flight/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flight flight = db.flight.Find(id);
            if (flight == null)
            {
                return HttpNotFound();
            }
            return View(flight);
        }

        // GET: /Flight/Create
        public ActionResult Create()
        {
            ViewBag.team = new SelectList(db.brigade, "id", "comment");
            ViewBag.flight_class = new SelectList(db.flight_class, "id", "periodicity_type");
            ViewBag.plane = new SelectList(db.plane, "id", "id");
            return View();
        }

        // POST: /Flight/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,team,flight_class,plane")] flight flight)
        {
            if (ModelState.IsValid)
            {
                db.flight.Add(flight);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.team = new SelectList(db.brigade, "id", "comment", flight.team);
            ViewBag.flight_class = new SelectList(db.flight_class, "id", "periodicity_type", flight.flight_class);
            ViewBag.plane = new SelectList(db.plane, "id", "id", flight.plane);
            return View(flight);
        }

        // GET: /Flight/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flight flight = db.flight.Find(id);
            if (flight == null)
            {
                return HttpNotFound();
            }
            ViewBag.team = new SelectList(db.brigade, "id", "comment", flight.team);
            ViewBag.flight_class = new SelectList(db.flight_class, "id", "periodicity_type", flight.flight_class);
            ViewBag.plane = new SelectList(db.plane, "id", "id", flight.plane);
            return View(flight);
        }

        // POST: /Flight/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,team,flight_class,plane")] flight flight)
        {
            if (ModelState.IsValid)
            {
                db.Entry(flight).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.team = new SelectList(db.brigade, "id", "comment", flight.team);
            ViewBag.flight_class = new SelectList(db.flight_class, "id", "periodicity_type", flight.flight_class);
            ViewBag.plane = new SelectList(db.plane, "id", "id", flight.plane);
            return View(flight);
        }

        // GET: /Flight/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            flight flight = db.flight.Find(id);
            if (flight == null)
            {
                return HttpNotFound();
            }
            return View(flight);
        }

        // POST: /Flight/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            flight flight = db.flight.Find(id);
            db.flight.Remove(flight);
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
