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
    public class EmployeeListViewController : Controller
    {
        private airportEntities1 db = new airportEntities1();

        // GET: /EmployeeListView/
        public ActionResult Index()
        {
            return View(db.employee_list.ToList());
        }

        // GET: /EmployeeListView/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            employee_list employee_list = db.employee_list.Find(id);
            if (employee_list == null)
            {
                return HttpNotFound();
            }
            return View(employee_list);
        }

        // GET: /EmployeeListView/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: /EmployeeListView/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="id,name,lastname,patronymic,phone,additional_phone,comment,type,brigade,airport,salary,childrencount,sex")] employee_list employee_list)
        {
            if (ModelState.IsValid)
            {
                db.employee_list.Add(employee_list);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(employee_list);
        }

        // GET: /EmployeeListView/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            employee_list employee_list = db.employee_list.Find(id);
            if (employee_list == null)
            {
                return HttpNotFound();
            }
            return View(employee_list);
        }

        // POST: /EmployeeListView/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="id,name,lastname,patronymic,phone,additional_phone,comment,type,brigade,airport,salary,childrencount,sex")] employee_list employee_list)
        {
            if (ModelState.IsValid)
            {
                db.Entry(employee_list).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(employee_list);
        }

        // GET: /EmployeeListView/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            employee_list employee_list = db.employee_list.Find(id);
            if (employee_list == null)
            {
                return HttpNotFound();
            }
            return View(employee_list);
        }

        // POST: /EmployeeListView/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            employee_list employee_list = db.employee_list.Find(id);
            db.employee_list.Remove(employee_list);
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
