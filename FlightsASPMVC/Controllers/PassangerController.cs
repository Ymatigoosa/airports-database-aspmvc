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
    public class PassangerController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /Passanger/
        public ActionResult Index()
        {
            var passenger = db.passenger.Include(p => p.city1);
            return View(passenger.ToList());
        }

        // GET: /Passanger/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            passenger passenger = db.passenger.Find(id);
            if (passenger == null)
            {
                return HttpNotFound();
            }
            return View(passenger);
        }

        // GET: /Passanger/Create
        public ActionResult Create()
        {
            ViewBag.city = new SelectList(db.city, "id", "name");
            return View();
        }

        // POST: /Passanger/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,name,lastname,patronymic,phone,additional_phone,comment,city,age,passport_num,internationlal_passport_num")] passenger passenger)
        {
            if (ModelState.IsValid)
            {
                db.passenger.Add(passenger);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.city = new SelectList(db.city, "id", "name", passenger.city);
            return View(passenger);
        }

        // GET: /Passanger/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            passenger passenger = db.passenger.Find(id);
            if (passenger == null)
            {
                return HttpNotFound();
            }
            ViewBag.city = new SelectList(db.city, "id", "name", passenger.city);
            return View(passenger);
        }

        // POST: /Passanger/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,name,lastname,patronymic,phone,additional_phone,comment,city,age,passport_num,internationlal_passport_num")] passenger passenger)
        {
            if (ModelState.IsValid)
            {
                db.Entry(passenger).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.city = new SelectList(db.city, "id", "name", passenger.city);
            return View(passenger);
        }

        // GET: /Passanger/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            passenger passenger = db.passenger.Find(id);
            if (passenger == null)
            {
                return HttpNotFound();
            }
            return View(passenger);
        }

        // POST: /Passanger/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            passenger passenger = db.passenger.Find(id);
            db.passenger.Remove(passenger);
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
