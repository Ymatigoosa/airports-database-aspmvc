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
    public class PlaneController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /Plane/
        public ActionResult Index()
        {
            var plane = db.plane.Include(p => p.airline1).Include(p => p.plane_model);
            return View(plane.ToList());
        }

        // GET: /Plane/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane plane = db.plane.Find(id);
            if (plane == null)
            {
                return HttpNotFound();
            }
            return View(plane);
        }

        // GET: /Plane/Create
        public ActionResult Create()
        {
            ViewBag.airline = new SelectList(db.airline, "id", "name");
            ViewBag.model = new SelectList(db.plane_model, "id", "name");
            return View();
        }

        // POST: /Plane/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,airline,model")] plane plane)
        {
            if (ModelState.IsValid)
            {
                db.plane.Add(plane);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.airline = new SelectList(db.airline, "id", "name", plane.airline);
            ViewBag.model = new SelectList(db.plane_model, "id", "name", plane.model);
            return View(plane);
        }

        // GET: /Plane/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane plane = db.plane.Find(id);
            if (plane == null)
            {
                return HttpNotFound();
            }
            ViewBag.airline = new SelectList(db.airline, "id", "name", plane.airline);
            ViewBag.model = new SelectList(db.plane_model, "id", "name", plane.model);
            return View(plane);
        }

        // POST: /Plane/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,airline,model")] plane plane)
        {
            if (ModelState.IsValid)
            {
                db.Entry(plane).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.airline = new SelectList(db.airline, "id", "name", plane.airline);
            ViewBag.model = new SelectList(db.plane_model, "id", "name", plane.model);
            return View(plane);
        }

        // GET: /Plane/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane plane = db.plane.Find(id);
            if (plane == null)
            {
                return HttpNotFound();
            }
            return View(plane);
        }

        // POST: /Plane/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            plane plane = db.plane.Find(id);
            db.plane.Remove(plane);
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
