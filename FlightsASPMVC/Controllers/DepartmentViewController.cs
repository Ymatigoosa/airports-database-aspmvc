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
    public class DepartmentViewController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /DepartmentView/
        public ActionResult Index()
        {
            return View(db.department_view.ToList());
        }

        // GET: /DepartmentView/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            department_view department_view = db.department_view.Find(id);
            if (department_view == null)
            {
                return HttpNotFound();
            }
            return View(department_view);
        }

        // GET: /DepartmentView/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /DepartmentView/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,departnent_name,head_name,head_lastname,brigades")] department_view department_view)
        {
            if (ModelState.IsValid)
            {
                db.department_view.Add(department_view);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(department_view);
        }

        // GET: /DepartmentView/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            department_view department_view = db.department_view.Find(id);
            if (department_view == null)
            {
                return HttpNotFound();
            }
            return View(department_view);
        }

        // POST: /DepartmentView/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,departnent_name,head_name,head_lastname,brigades")] department_view department_view)
        {
            if (ModelState.IsValid)
            {
                db.Entry(department_view).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(department_view);
        }

        // GET: /DepartmentView/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            department_view department_view = db.department_view.Find(id);
            if (department_view == null)
            {
                return HttpNotFound();
            }
            return View(department_view);
        }

        // POST: /DepartmentView/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            department_view department_view = db.department_view.Find(id);
            db.department_view.Remove(department_view);
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
