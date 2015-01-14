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
    public class PlaneModelController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /PlaneModel/
        public ActionResult Index()
        {
            return View(db.plane_model.ToList());
        }

        // GET: /PlaneModel/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_model plane_model = db.plane_model.Find(id);
            if (plane_model == null)
            {
                return HttpNotFound();
            }
            return View(plane_model);
        }

        // GET: /PlaneModel/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /PlaneModel/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,passenger_capacity,name")] plane_model plane_model)
        {
            if (ModelState.IsValid)
            {
                db.plane_model.Add(plane_model);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(plane_model);
        }

        // GET: /PlaneModel/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_model plane_model = db.plane_model.Find(id);
            if (plane_model == null)
            {
                return HttpNotFound();
            }
            return View(plane_model);
        }

        // POST: /PlaneModel/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,passenger_capacity,name")] plane_model plane_model)
        {
            if (ModelState.IsValid)
            {
                db.Entry(plane_model).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(plane_model);
        }

        // GET: /PlaneModel/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            plane_model plane_model = db.plane_model.Find(id);
            if (plane_model == null)
            {
                return HttpNotFound();
            }
            return View(plane_model);
        }

        // POST: /PlaneModel/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            plane_model plane_model = db.plane_model.Find(id);
            db.plane_model.Remove(plane_model);
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
