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
    public class BaggageController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /Baggage/
        public ActionResult Index()
        {
            var baggage = db.baggage.Include(b => b.passenger);
            return View(baggage.ToList());
        }

        // GET: /Baggage/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            baggage baggage = db.baggage.Find(id);
            if (baggage == null)
            {
                return HttpNotFound();
            }
            return View(baggage);
        }

        // GET: /Baggage/Create
        public ActionResult Create()
        {
            ViewBag.owned_by = new SelectList(db.passenger, "id", "name");
            return View();
        }

        // POST: /Baggage/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,comment,owned_by,receipt_date,return_date")] baggage baggage)
        {
            if (ModelState.IsValid)
            {
                db.baggage.Add(baggage);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.owned_by = new SelectList(db.passenger, "id", "name", baggage.owned_by);
            return View(baggage);
        }

        // GET: /Baggage/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            baggage baggage = db.baggage.Find(id);
            if (baggage == null)
            {
                return HttpNotFound();
            }
            ViewBag.owned_by = new SelectList(db.passenger, "id", "name", baggage.owned_by);
            return View(baggage);
        }

        // POST: /Baggage/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,comment,owned_by,receipt_date,return_date")] baggage baggage)
        {
            if (ModelState.IsValid)
            {
                db.Entry(baggage).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.owned_by = new SelectList(db.passenger, "id", "name", baggage.owned_by);
            return View(baggage);
        }

        // GET: /Baggage/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            baggage baggage = db.baggage.Find(id);
            if (baggage == null)
            {
                return HttpNotFound();
            }
            return View(baggage);
        }

        // POST: /Baggage/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            baggage baggage = db.baggage.Find(id);
            db.baggage.Remove(baggage);
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
