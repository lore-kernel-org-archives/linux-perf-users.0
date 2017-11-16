From: Jaroslav Skarvada <jskarvad@redhat.com>
Subject: Re: [PATCH] perf: Add Python 3 support
Date: Thu, 16 Nov 2017 16:36:41 -0500 (EST)
Message-ID: <1976484674.42061181.1510868201505.JavaMail.zimbra@redhat.com>
References: <20171020223614.30787-1-jskarvad@redhat.com> <20171107144646.GG3216@kernel.org> <20171107145307.GH3216@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_Part_42061179_414787436.1510868201499"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60717 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750899AbdKPVgl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Nov 2017 16:36:41 -0500
In-Reply-To: <20171107145307.GH3216@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, Jiri Kastner <jkastner@redhat.com>, Jiri Olsa <jolsa@kernel.org>, John Kacur <jkacur@redhat.com>, linux-perf-users@vger.kernel.org

------=_Part_42061179_414787436.1510868201499
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



----- Original Message -----
> Em Tue, Nov 07, 2017 at 11:46:46AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Sat, Oct 21, 2017 at 12:36:14AM +0200, Jaroslav =C5=A0karvada escrev=
eu:
> > > Added Python 3 support while keeping Python < 3 compatibility.
> > >=20
> > > Signed-off-by: Jaroslav =C5=A0karvada <jskarvad@redhat.com>
> > > ---
> > >  .../perf/scripts/python/Perf-Trace-Util/Context.c  |  34 ++++-
> > >  tools/perf/util/python.c                           |  95 ++++++++++-=
--
> > >  .../util/scripting-engines/trace-event-python.c    | 147
> > >  +++++++++++++++------
> > >  tools/perf/util/setup.py                           |   6 +-
> > >  4 files changed, 215 insertions(+), 67 deletions(-)
> >=20
> > I'll add more of those ifdefs, as the support doesn't get built when yo=
u
> > uninstall the python2-devel package, leaving just the python3-devel one=
:
> >=20
> > [acme@jouet linux]$ cat /tmp/build/perf/feature/test-libpython.make.out=
put
> > test-libpython.c:2:10: fatal error: Python.h: No such file or directory
> >  #include <Python.h>
> >           ^~~~~~~~~~
> > compilation terminated.
> > [acme@jouet linux]$
>=20
> We'll gonna have to do something more involved, touching giw
> tools/perf/Makefile.config
> figures out the python-config binaries...
>=20
> Can you try to build perf with your patch and without python2-devel
> installed, just with python3-devel to see if you reproduce what I'm
> experiencing?
>

Sorry for delay. I am not able to reproduce the problem. It builds OK for m=
e
with python2-devel only, with python3-devel only and with both python2/3-de=
vel
packages installed. I am building it with:
$ make -C tools/perf
$ make -C tools/perf install

I am attaching updated patch that applies onto 4.15

Jaroslav

> - Arnaldo
> =20
> > - Arnaldo
> > =20
> > > diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> > > b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> > > index fcd1dd66..1a0d2775 100644
> > > --- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> > > +++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> > > @@ -23,7 +23,17 @@
> > >  #include "../../../perf.h"
> > >  #include "../../../util/trace-event.h"
> > > =20
> > > +#if PY_MAJOR_VERSION < 3
> > > +#define _PyCapsule_GetPointer(arg1, arg2) \
> > > +  PyCObject_AsVoidPtr(arg1)
> > > +
> > >  PyMODINIT_FUNC initperf_trace_context(void);
> > > +#else
> > > +#define _PyCapsule_GetPointer(arg1, arg2) \
> > > +  PyCapsule_GetPointer((arg1), (arg2))
> > > +
> > > +PyMODINIT_FUNC PyInit_perf_trace_context(void);
> > > +#endif
> > > =20
> > >  static PyObject *perf_trace_context_common_pc(PyObject *obj, PyObjec=
t
> > >  *args)
> > >  {
> > > @@ -34,7 +44,7 @@ static PyObject *perf_trace_context_common_pc(PyObj=
ect
> > > *obj, PyObject *args)
> > >  =09if (!PyArg_ParseTuple(args, "O", &context))
> > >  =09=09return NULL;
> > > =20
> > > -=09scripting_context =3D PyCObject_AsVoidPtr(context);
> > > +=09scripting_context =3D _PyCapsule_GetPointer(context, NULL);
> > >  =09retval =3D common_pc(scripting_context);
> > > =20
> > >  =09return Py_BuildValue("i", retval);
> > > @@ -50,7 +60,7 @@ static PyObject
> > > *perf_trace_context_common_flags(PyObject *obj,
> > >  =09if (!PyArg_ParseTuple(args, "O", &context))
> > >  =09=09return NULL;
> > > =20
> > > -=09scripting_context =3D PyCObject_AsVoidPtr(context);
> > > +=09scripting_context =3D _PyCapsule_GetPointer(context, NULL);
> > >  =09retval =3D common_flags(scripting_context);
> > > =20
> > >  =09return Py_BuildValue("i", retval);
> > > @@ -66,7 +76,7 @@ static PyObject
> > > *perf_trace_context_common_lock_depth(PyObject *obj,
> > >  =09if (!PyArg_ParseTuple(args, "O", &context))
> > >  =09=09return NULL;
> > > =20
> > > -=09scripting_context =3D PyCObject_AsVoidPtr(context);
> > > +=09scripting_context =3D _PyCapsule_GetPointer(context, NULL);
> > >  =09retval =3D common_lock_depth(scripting_context);
> > > =20
> > >  =09return Py_BuildValue("i", retval);
> > > @@ -82,7 +92,25 @@ static PyMethodDef ContextMethods[] =3D {
> > >  =09{ NULL, NULL, 0, NULL}
> > >  };
> > > =20
> > > +#if PY_MAJOR_VERSION < 3
> > >  PyMODINIT_FUNC initperf_trace_context(void)
> > >  {
> > >  =09(void) Py_InitModule("perf_trace_context", ContextMethods);
> > >  }
> > > +#else
> > > +PyMODINIT_FUNC PyInit_perf_trace_context(void)
> > > +{
> > > +=09static struct PyModuleDef moduledef =3D {
> > > +=09=09PyModuleDef_HEAD_INIT,
> > > +=09=09"perf_trace_context",=09/* m_name */
> > > +=09=09"",=09=09=09/* m_doc */
> > > +=09=09-1,=09=09=09/* m_size */
> > > +=09=09ContextMethods,=09=09/* m_methods */
> > > +=09=09NULL,=09=09=09/* m_reload */
> > > +=09=09NULL,=09=09=09/* m_traverse */
> > > +=09=09NULL,=09=09=09/* m_clear */
> > > +=09=09NULL,=09=09=09/* m_free */
> > > +=09};
> > > +=09return PyModule_Create(&moduledef);
> > > +}
> > > +#endif
> > > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > > index c129e991..37fa07ec 100644
> > > --- a/tools/perf/util/python.c
> > > +++ b/tools/perf/util/python.c
> > > @@ -11,6 +11,30 @@
> > >  #include "print_binary.h"
> > >  #include "thread_map.h"
> > > =20
> > > +#if PY_MAJOR_VERSION < 3
> > > +#define _PyUnicode_FromString(arg) \
> > > +  PyString_FromString(arg)
> > > +#define _PyUnicode_AsString(arg) \
> > > +  PyString_AsString(arg)
> > > +#define _PyUnicode_FromFormat(...) \
> > > +  PyString_FromFormat(__VA_ARGS__)
> > > +#define _PyLong_FromLong(arg) \
> > > +  PyInt_FromLong(arg)
> > > +
> > > +#else
> > > +
> > > +#define _PyUnicode_FromString(arg) \
> > > +  PyUnicode_FromString(arg)
> > > +#define _PyUnicode_FromFormat(...) \
> > > +  PyUnicode_FromFormat(__VA_ARGS__)
> > > +#define _PyLong_FromLong(arg) \
> > > +  PyLong_FromLong(arg)
> > > +#endif
> > > +
> > > +#ifndef Py_TYPE
> > > +#define Py_TYPE(ob) (((PyObject*)(ob))->ob_type)
> > > +#endif
> > > +
> > >  /*
> > >   * Provide these two so that we don't have to link against callchain=
.c
> > >   and
> > >   * start dragging hist.c, etc.
> > > @@ -48,7 +72,11 @@ int eprintf(int level, int var, const char *fmt, .=
..)
> > >  # define PyVarObject_HEAD_INIT(type, size) PyObject_HEAD_INIT(type)
> > >  size,
> > >  #endif
> > > =20
> > > +#if PY_MAJOR_VERSION < 3
> > >  PyMODINIT_FUNC initperf(void);
> > > +#else
> > > +PyMODINIT_FUNC PyInit_perf(void);
> > > +#endif
> > > =20
> > >  #define member_def(type, member, ptype, help) \
> > >  =09{ #member, ptype, \
> > > @@ -106,7 +134,7 @@ static PyObject *pyrf_mmap_event__repr(struct
> > > pyrf_event *pevent)
> > >  =09=09     pevent->event.mmap.pgoff, pevent->event.mmap.filename) < =
0) {
> > >  =09=09ret =3D PyErr_NoMemory();
> > >  =09} else {
> > > -=09=09ret =3D PyString_FromString(s);
> > > +=09=09ret =3D _PyUnicode_FromString(s);
> > >  =09=09free(s);
> > >  =09}
> > >  =09return ret;
> > > @@ -137,7 +165,7 @@ static PyMemberDef pyrf_task_event__members[] =3D=
 {
> > > =20
> > >  static PyObject *pyrf_task_event__repr(struct pyrf_event *pevent)
> > >  {
> > > -=09return PyString_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %=
u, "
> > > +=09return _PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid:=
 %u, "
> > >  =09=09=09=09   "ptid: %u, time: %" PRIu64 "}",
> > >  =09=09=09=09   pevent->event.header.type =3D=3D PERF_RECORD_FORK ? "=
fork" : "exit",
> > >  =09=09=09=09   pevent->event.fork.pid,
> > > @@ -170,7 +198,7 @@ static PyMemberDef pyrf_comm_event__members[] =3D=
 {
> > > =20
> > >  static PyObject *pyrf_comm_event__repr(struct pyrf_event *pevent)
> > >  {
> > > -=09return PyString_FromFormat("{ type: comm, pid: %u, tid: %u, comm:=
 %s
> > > }",
> > > +=09return _PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, com=
m: %s
> > > }",
> > >  =09=09=09=09   pevent->event.comm.pid,
> > >  =09=09=09=09   pevent->event.comm.tid,
> > >  =09=09=09=09   pevent->event.comm.comm);
> > > @@ -201,7 +229,7 @@ static PyObject *pyrf_throttle_event__repr(struct
> > > pyrf_event *pevent)
> > >  {
> > >  =09struct throttle_event *te =3D (struct throttle_event
> > >  =09*)(&pevent->event.header + 1);
> > > =20
> > > -=09return PyString_FromFormat("{ type: %sthrottle, time: %" PRIu64 "=
, id:
> > > %" PRIu64
> > > +=09return _PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRIu64=
 ",
> > > id: %" PRIu64
> > >  =09=09=09=09   ", stream_id: %" PRIu64 " }",
> > >  =09=09=09=09   pevent->event.header.type =3D=3D PERF_RECORD_THROTTLE=
 ? "" : "un",
> > >  =09=09=09=09   te->time, te->id, te->stream_id);
> > > @@ -236,7 +264,7 @@ static PyObject *pyrf_lost_event__repr(struct
> > > pyrf_event *pevent)
> > >  =09=09     pevent->event.lost.id, pevent->event.lost.lost) < 0) {
> > >  =09=09ret =3D PyErr_NoMemory();
> > >  =09} else {
> > > -=09=09ret =3D PyString_FromString(s);
> > > +=09=09ret =3D _PyUnicode_FromString(s);
> > >  =09=09free(s);
> > >  =09}
> > >  =09return ret;
> > > @@ -263,7 +291,7 @@ static PyMemberDef pyrf_read_event__members[] =3D=
 {
> > > =20
> > >  static PyObject *pyrf_read_event__repr(struct pyrf_event *pevent)
> > >  {
> > > -=09return PyString_FromFormat("{ type: read, pid: %u, tid: %u }",
> > > +=09return _PyUnicode_FromFormat("{ type: read, pid: %u, tid: %u }",
> > >  =09=09=09=09   pevent->event.read.pid,
> > >  =09=09=09=09   pevent->event.read.tid);
> > >  =09/*
> > > @@ -298,7 +326,7 @@ static PyObject *pyrf_sample_event__repr(struct
> > > pyrf_event *pevent)
> > >  =09if (asprintf(&s, "{ type: sample }") < 0) {
> > >  =09=09ret =3D PyErr_NoMemory();
> > >  =09} else {
> > > -=09=09ret =3D PyString_FromString(s);
> > > +=09=09ret =3D _PyUnicode_FromString(s);
> > >  =09=09free(s);
> > >  =09}
> > >  =09return ret;
> > > @@ -329,7 +357,7 @@ tracepoint_field(struct pyrf_event *pe, struct
> > > format_field *field)
> > >  =09=09}
> > >  =09=09if (field->flags & FIELD_IS_STRING &&
> > >  =09=09    is_printable_array(data + offset, len)) {
> > > -=09=09=09ret =3D PyString_FromString((char *)data + offset);
> > > +=09=09=09ret =3D _PyUnicode_FromString((char *)data + offset);
> > >  =09=09} else {
> > >  =09=09=09ret =3D PyByteArray_FromStringAndSize((const char *) data +=
 offset,
> > >  =09=09=09len);
> > >  =09=09=09field->flags &=3D ~FIELD_IS_STRING;
> > > @@ -351,7 +379,7 @@ tracepoint_field(struct pyrf_event *pe, struct
> > > format_field *field)
> > >  static PyObject*
> > >  get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
> > >  {
> > > -=09const char *str =3D PyString_AsString(PyObject_Str(attr_name));
> > > +=09const char *str =3D _PyUnicode_AsString(PyObject_Str(attr_name));
> > >  =09struct perf_evsel *evsel =3D pevent->evsel;
> > >  =09struct format_field *field;
> > > =20
> > > @@ -415,7 +443,7 @@ static PyObject
> > > *pyrf_context_switch_event__repr(struct pyrf_event *pevent)
> > >  =09=09     !!(pevent->event.header.misc & PERF_RECORD_MISC_SWITCH_OU=
T)) < 0)
> > >  =09=09     {
> > >  =09=09ret =3D PyErr_NoMemory();
> > >  =09} else {
> > > -=09=09ret =3D PyString_FromString(s);
> > > +=09=09ret =3D _PyUnicode_FromString(s);
> > >  =09=09free(s);
> > >  =09}
> > >  =09return ret;
> > > @@ -527,7 +555,7 @@ static int pyrf_cpu_map__init(struct pyrf_cpu_map
> > > *pcpus,
> > >  static void pyrf_cpu_map__delete(struct pyrf_cpu_map *pcpus)
> > >  {
> > >  =09cpu_map__put(pcpus->cpus);
> > > -=09pcpus->ob_type->tp_free((PyObject*)pcpus);
> > > +=09Py_TYPE(pcpus)->tp_free((PyObject*)pcpus);
> > >  }
> > > =20
> > >  static Py_ssize_t pyrf_cpu_map__length(PyObject *obj)
> > > @@ -596,7 +624,7 @@ static int pyrf_thread_map__init(struct
> > > pyrf_thread_map *pthreads,
> > >  static void pyrf_thread_map__delete(struct pyrf_thread_map *pthreads=
)
> > >  {
> > >  =09thread_map__put(pthreads->threads);
> > > -=09pthreads->ob_type->tp_free((PyObject*)pthreads);
> > > +=09Py_TYPE(pthreads)->tp_free((PyObject*)pthreads);
> > >  }
> > > =20
> > >  static Py_ssize_t pyrf_thread_map__length(PyObject *obj)
> > > @@ -758,7 +786,7 @@ static int pyrf_evsel__init(struct pyrf_evsel
> > > *pevsel,
> > >  static void pyrf_evsel__delete(struct pyrf_evsel *pevsel)
> > >  {
> > >  =09perf_evsel__exit(&pevsel->evsel);
> > > -=09pevsel->ob_type->tp_free((PyObject*)pevsel);
> > > +=09Py_TYPE(pevsel)->tp_free((PyObject*)pevsel);
> > >  }
> > > =20
> > >  static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
> > > @@ -849,7 +877,7 @@ static int pyrf_evlist__init(struct pyrf_evlist
> > > *pevlist,
> > >  static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
> > >  {
> > >  =09perf_evlist__exit(&pevlist->evlist);
> > > -=09pevlist->ob_type->tp_free((PyObject*)pevlist);
> > > +=09Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
> > >  }
> > > =20
> > >  static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
> > > @@ -901,12 +929,16 @@ static PyObject *pyrf_evlist__get_pollfd(struct
> > > pyrf_evlist *pevlist,
> > > =20
> > >  =09for (i =3D 0; i < evlist->pollfd.nr; ++i) {
> > >  =09=09PyObject *file;
> > > +#if PY_MAJOR_VERSION < 3
> > >  =09=09FILE *fp =3D fdopen(evlist->pollfd.entries[i].fd, "r");
> > > =20
> > >  =09=09if (fp =3D=3D NULL)
> > >  =09=09=09goto free_list;
> > > =20
> > >  =09=09file =3D PyFile_FromFile(fp, "perf", "r", NULL);
> > > +#else
> > > +=09=09file =3D PyFile_FromFd(evlist->pollfd.entries[i].fd, "perf", "=
r", -1,
> > > NULL, NULL, NULL, 1);
> > > +#endif
> > >  =09=09if (file =3D=3D NULL)
> > >  =09=09=09goto free_list;
> > > =20
> > > @@ -1193,9 +1225,9 @@ static PyObject *pyrf__tracepoint(struct pyrf_e=
vsel
> > > *pevsel,
> > > =20
> > >  =09tp_format =3D trace_event__tp_format(sys, name);
> > >  =09if (IS_ERR(tp_format))
> > > -=09=09return PyInt_FromLong(-1);
> > > +=09=09return _PyLong_FromLong(-1);
> > > =20
> > > -=09return PyInt_FromLong(tp_format->id);
> > > +=09return _PyLong_FromLong(tp_format->id);
> > >  }
> > > =20
> > >  static PyMethodDef perf__methods[] =3D {
> > > @@ -1208,11 +1240,31 @@ static PyMethodDef perf__methods[] =3D {
> > >  =09{ .ml_name =3D NULL, }
> > >  };
> > > =20
> > > +#if PY_MAJOR_VERSION < 3
> > >  PyMODINIT_FUNC initperf(void)
> > > +#else
> > > +PyMODINIT_FUNC PyInit_perf(void)
> > > +#endif
> > >  {
> > >  =09PyObject *obj;
> > >  =09int i;
> > > -=09PyObject *dict, *module =3D Py_InitModule("perf", perf__methods);
> > > +=09PyObject *dict;
> > > +#if PY_MAJOR_VERSION < 3
> > > +=09PyObject *module =3D Py_InitModule("perf", perf__methods);
> > > +#else
> > > +=09static struct PyModuleDef moduledef =3D {
> > > +=09=09PyModuleDef_HEAD_INIT,
> > > +=09=09"perf",=09=09=09/* m_name */
> > > +=09=09"",=09=09=09/* m_doc */
> > > +=09=09-1,=09=09=09/* m_size */
> > > +=09=09perf__methods,=09=09/* m_methods */
> > > +=09=09NULL,=09=09=09/* m_reload */
> > > +=09=09NULL,=09=09=09/* m_traverse */
> > > +=09=09NULL,=09=09=09/* m_clear */
> > > +=09=09NULL,=09=09=09/* m_free */
> > > +=09};
> > > +=09PyObject *module =3D PyModule_Create(&moduledef);
> > > +#endif
> > > =20
> > >  =09if (module =3D=3D NULL ||
> > >  =09    pyrf_event__setup_types() < 0 ||
> > > @@ -1220,7 +1272,11 @@ PyMODINIT_FUNC initperf(void)
> > >  =09    pyrf_evsel__setup_types() < 0 ||
> > >  =09    pyrf_thread_map__setup_types() < 0 ||
> > >  =09    pyrf_cpu_map__setup_types() < 0)
> > > +#if PY_MAJOR_VERSION < 3
> > >  =09=09return;
> > > +#else
> > > +=09=09return module;
> > > +#endif
> > > =20
> > >  =09/* The page_size is placed in util object. */
> > >  =09page_size =3D sysconf(_SC_PAGE_SIZE);
> > > @@ -1269,7 +1325,7 @@ PyMODINIT_FUNC initperf(void)
> > >  =09=09goto error;
> > > =20
> > >  =09for (i =3D 0; perf__constants[i].name !=3D NULL; i++) {
> > > -=09=09obj =3D PyInt_FromLong(perf__constants[i].value);
> > > +=09=09obj =3D _PyLong_FromLong(perf__constants[i].value);
> > >  =09=09if (obj =3D=3D NULL)
> > >  =09=09=09goto error;
> > >  =09=09PyDict_SetItemString(dict, perf__constants[i].name, obj);
> > > @@ -1279,6 +1335,9 @@ PyMODINIT_FUNC initperf(void)
> > >  error:
> > >  =09if (PyErr_Occurred())
> > >  =09=09PyErr_SetString(PyExc_ImportError, "perf: Init failed!");
> > > +#if PY_MAJOR_VERSION >=3D 3
> > > +=09return module;
> > > +#endif
> > >  }
> > > =20
> > >  /*
> > > diff --git a/tools/perf/util/scripting-engines/trace-event-python.c
> > > b/tools/perf/util/scripting-engines/trace-event-python.c
> > > index c7187f06..3a868834 100644
> > > --- a/tools/perf/util/scripting-engines/trace-event-python.c
> > > +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> > > @@ -50,7 +50,37 @@
> > >  #include "print_binary.h"
> > >  #include "stat.h"
> > > =20
> > > +#if PY_MAJOR_VERSION < 3
> > > +#define _PyUnicode_FromString(arg) \
> > > +  PyString_FromString(arg)
> > > +#define _PyUnicode_FromStringAndSize(arg1, arg2) \
> > > +  PyString_FromStringAndSize((arg1), (arg2))
> > > +#define _PyBytes_FromStringAndSize(arg1, arg2) \
> > > +  PyString_FromStringAndSize((arg1), (arg2))
> > > +#define _PyLong_FromLong(arg) \
> > > +  PyInt_FromLong(arg)
> > > +#define _PyLong_AsLong(arg) \
> > > +  PyInt_AsLong(arg)
> > > +#define _PyCapsule_New(arg1, arg2, arg3) \
> > > +  PyCObject_FromVoidPtr((arg1), (arg2))
> > > +
> > >  PyMODINIT_FUNC initperf_trace_context(void);
> > > +#else
> > > +#define _PyUnicode_FromString(arg) \
> > > +  PyUnicode_FromString(arg)
> > > +#define _PyUnicode_FromStringAndSize(arg1, arg2) \
> > > +  PyUnicode_FromStringAndSize((arg1), (arg2))
> > > +#define _PyBytes_FromStringAndSize(arg1, arg2) \
> > > +  PyBytes_FromStringAndSize((arg1), (arg2))
> > > +#define _PyLong_FromLong(arg) \
> > > +  PyLong_FromLong(arg)
> > > +#define _PyLong_AsLong(arg) \
> > > +  PyLong_AsLong(arg)
> > > +#define _PyCapsule_New(arg1, arg2, arg3) \
> > > +  PyCapsule_New((arg1), (arg2), (arg3))
> > > +
> > > +PyMODINIT_FUNC PyInit_perf_trace_context(void);
> > > +#endif
> > > =20
> > >  #define TRACE_EVENT_TYPE_MAX=09=09=09=09\
> > >  =09((1 << (sizeof(unsigned short) * 8)) - 1)
> > > @@ -136,7 +166,7 @@ static int get_argument_count(PyObject *handler)
> > >  =09=09PyObject *arg_count_obj =3D PyObject_GetAttrString(code_obj,
> > >  =09=09=09"co_argcount");
> > >  =09=09if (arg_count_obj) {
> > > -=09=09=09arg_count =3D (int) PyInt_AsLong(arg_count_obj);
> > > +=09=09=09arg_count =3D (int) _PyLong_AsLong(arg_count_obj);
> > >  =09=09=09Py_DECREF(arg_count_obj);
> > >  =09=09}
> > >  =09=09Py_DECREF(code_obj);
> > > @@ -183,10 +213,10 @@ static void define_value(enum print_arg_type
> > > field_type,
> > > =20
> > >  =09value =3D eval_flag(field_value);
> > > =20
> > > -=09PyTuple_SetItem(t, n++, PyString_FromString(ev_name));
> > > -=09PyTuple_SetItem(t, n++, PyString_FromString(field_name));
> > > -=09PyTuple_SetItem(t, n++, PyInt_FromLong(value));
> > > -=09PyTuple_SetItem(t, n++, PyString_FromString(field_str));
> > > +=09PyTuple_SetItem(t, n++, _PyUnicode_FromString(ev_name));
> > > +=09PyTuple_SetItem(t, n++, _PyUnicode_FromString(field_name));
> > > +=09PyTuple_SetItem(t, n++, _PyLong_FromLong(value));
> > > +=09PyTuple_SetItem(t, n++, _PyUnicode_FromString(field_str));
> > > =20
> > >  =09try_call_object(handler_name, t);
> > > =20
> > > @@ -224,10 +254,10 @@ static void define_field(enum print_arg_type
> > > field_type,
> > >  =09if (!t)
> > >  =09=09Py_FatalError("couldn't create Python tuple");
> > > =20
> > > -=09PyTuple_SetItem(t, n++, PyString_FromString(ev_name));
> > > -=09PyTuple_SetItem(t, n++, PyString_FromString(field_name));
> > > +=09PyTuple_SetItem(t, n++, _PyUnicode_FromString(ev_name));
> > > +=09PyTuple_SetItem(t, n++, _PyUnicode_FromString(field_name));
> > >  =09if (field_type =3D=3D PRINT_FLAGS)
> > > -=09=09PyTuple_SetItem(t, n++, PyString_FromString(delim));
> > > +=09=09PyTuple_SetItem(t, n++, _PyUnicode_FromString(delim));
> > > =20
> > >  =09try_call_object(handler_name, t);
> > > =20
> > > @@ -326,12 +356,12 @@ static PyObject *get_field_numeric_entry(struct
> > > event_format *event,
> > >  =09=09if (field->flags & FIELD_IS_SIGNED) {
> > >  =09=09=09if ((long long)val >=3D LONG_MIN &&
> > >  =09=09=09=09=09(long long)val <=3D LONG_MAX)
> > > -=09=09=09=09obj =3D PyInt_FromLong(val);
> > > +=09=09=09=09obj =3D _PyLong_FromLong(val);
> > >  =09=09=09else
> > >  =09=09=09=09obj =3D PyLong_FromLongLong(val);
> > >  =09=09} else {
> > >  =09=09=09if (val <=3D LONG_MAX)
> > > -=09=09=09=09obj =3D PyInt_FromLong(val);
> > > +=09=09=09=09obj =3D _PyLong_FromLong(val);
> > >  =09=09=09else
> > >  =09=09=09=09obj =3D PyLong_FromUnsignedLongLong(val);
> > >  =09=09}
> > > @@ -390,9 +420,9 @@ static PyObject *python_process_callchain(struct
> > > perf_sample *sample,
> > >  =09=09=09pydict_set_item_string_decref(pysym, "end",
> > >  =09=09=09=09=09PyLong_FromUnsignedLongLong(node->sym->end));
> > >  =09=09=09pydict_set_item_string_decref(pysym, "binding",
> > > -=09=09=09=09=09PyInt_FromLong(node->sym->binding));
> > > +=09=09=09=09=09_PyLong_FromLong(node->sym->binding));
> > >  =09=09=09pydict_set_item_string_decref(pysym, "name",
> > > -=09=09=09=09=09PyString_FromStringAndSize(node->sym->name,
> > > +=09=09=09=09=09_PyUnicode_FromStringAndSize(node->sym->name,
> > >  =09=09=09=09=09=09=09node->sym->namelen));
> > >  =09=09=09pydict_set_item_string_decref(pyelem, "sym", pysym);
> > >  =09=09}
> > > @@ -407,7 +437,7 @@ static PyObject *python_process_callchain(struct
> > > perf_sample *sample,
> > >  =09=09=09=09=09dsoname =3D map->dso->name;
> > >  =09=09=09}
> > >  =09=09=09pydict_set_item_string_decref(pyelem, "dso",
> > > -=09=09=09=09=09PyString_FromString(dsoname));
> > > +=09=09=09=09=09_PyUnicode_FromString(dsoname));
> > >  =09=09}
> > > =20
> > >  =09=09callchain_cursor_advance(&callchain_cursor);
> > > @@ -484,16 +514,16 @@ static PyObject *get_perf_sample_dict(struct
> > > perf_sample *sample,
> > >  =09if (!dict_sample)
> > >  =09=09Py_FatalError("couldn't create Python dictionary");
> > > =20
> > > -=09pydict_set_item_string_decref(dict, "ev_name",
> > > PyString_FromString(perf_evsel__name(evsel)));
> > > -=09pydict_set_item_string_decref(dict, "attr", PyString_FromStringAn=
dSize(
> > > +=09pydict_set_item_string_decref(dict, "ev_name",
> > > _PyUnicode_FromString(perf_evsel__name(evsel)));
> > > +=09pydict_set_item_string_decref(dict, "attr",
> > > _PyUnicode_FromStringAndSize(
> > >  =09=09=09(const char *)&evsel->attr, sizeof(evsel->attr)));
> > > =20
> > >  =09pydict_set_item_string_decref(dict_sample, "pid",
> > > -=09=09=09PyInt_FromLong(sample->pid));
> > > +=09=09=09_PyLong_FromLong(sample->pid));
> > >  =09pydict_set_item_string_decref(dict_sample, "tid",
> > > -=09=09=09PyInt_FromLong(sample->tid));
> > > +=09=09=09_PyLong_FromLong(sample->tid));
> > >  =09pydict_set_item_string_decref(dict_sample, "cpu",
> > > -=09=09=09PyInt_FromLong(sample->cpu));
> > > +=09=09=09_PyLong_FromLong(sample->cpu));
> > >  =09pydict_set_item_string_decref(dict_sample, "ip",
> > >  =09=09=09PyLong_FromUnsignedLongLong(sample->ip));
> > >  =09pydict_set_item_string_decref(dict_sample, "time",
> > > @@ -503,17 +533,17 @@ static PyObject *get_perf_sample_dict(struct
> > > perf_sample *sample,
> > >  =09set_sample_read_in_dict(dict_sample, sample, evsel);
> > >  =09pydict_set_item_string_decref(dict, "sample", dict_sample);
> > > =20
> > > -=09pydict_set_item_string_decref(dict, "raw_buf",
> > > PyString_FromStringAndSize(
> > > +=09pydict_set_item_string_decref(dict, "raw_buf",
> > > _PyBytes_FromStringAndSize(
> > >  =09=09=09(const char *)sample->raw_data, sample->raw_size));
> > >  =09pydict_set_item_string_decref(dict, "comm",
> > > -=09=09=09PyString_FromString(thread__comm_str(al->thread)));
> > > +=09=09=09_PyUnicode_FromString(thread__comm_str(al->thread)));
> > >  =09if (al->map) {
> > >  =09=09pydict_set_item_string_decref(dict, "dso",
> > > -=09=09=09PyString_FromString(al->map->dso->name));
> > > +=09=09=09_PyUnicode_FromString(al->map->dso->name));
> > >  =09}
> > >  =09if (al->sym) {
> > >  =09=09pydict_set_item_string_decref(dict, "symbol",
> > > -=09=09=09PyString_FromString(al->sym->name));
> > > +=09=09=09_PyUnicode_FromString(al->sym->name));
> > >  =09}
> > > =20
> > >  =09pydict_set_item_string_decref(dict, "callchain", callchain);
> > > @@ -573,9 +603,9 @@ static void python_process_tracepoint(struct
> > > perf_sample *sample,
> > >  =09scripting_context->event_data =3D data;
> > >  =09scripting_context->pevent =3D evsel->tp_format->pevent;
> > > =20
> > > -=09context =3D PyCObject_FromVoidPtr(scripting_context, NULL);
> > > +=09context =3D _PyCapsule_New(scripting_context, NULL, NULL);
> > > =20
> > > -=09PyTuple_SetItem(t, n++, PyString_FromString(handler_name));
> > > +=09PyTuple_SetItem(t, n++, _PyUnicode_FromString(handler_name));
> > >  =09PyTuple_SetItem(t, n++, context);
> > > =20
> > >  =09/* ip unwinding */
> > > @@ -584,18 +614,18 @@ static void python_process_tracepoint(struct
> > > perf_sample *sample,
> > >  =09Py_INCREF(callchain);
> > > =20
> > >  =09if (!dict) {
> > > -=09=09PyTuple_SetItem(t, n++, PyInt_FromLong(cpu));
> > > -=09=09PyTuple_SetItem(t, n++, PyInt_FromLong(s));
> > > -=09=09PyTuple_SetItem(t, n++, PyInt_FromLong(ns));
> > > -=09=09PyTuple_SetItem(t, n++, PyInt_FromLong(pid));
> > > -=09=09PyTuple_SetItem(t, n++, PyString_FromString(comm));
> > > +=09=09PyTuple_SetItem(t, n++, _PyLong_FromLong(cpu));
> > > +=09=09PyTuple_SetItem(t, n++, _PyLong_FromLong(s));
> > > +=09=09PyTuple_SetItem(t, n++, _PyLong_FromLong(ns));
> > > +=09=09PyTuple_SetItem(t, n++, _PyLong_FromLong(pid));
> > > +=09=09PyTuple_SetItem(t, n++, _PyUnicode_FromString(comm));
> > >  =09=09PyTuple_SetItem(t, n++, callchain);
> > >  =09} else {
> > > -=09=09pydict_set_item_string_decref(dict, "common_cpu",
> > > PyInt_FromLong(cpu));
> > > -=09=09pydict_set_item_string_decref(dict, "common_s", PyInt_FromLong=
(s));
> > > -=09=09pydict_set_item_string_decref(dict, "common_ns", PyInt_FromLon=
g(ns));
> > > -=09=09pydict_set_item_string_decref(dict, "common_pid",
> > > PyInt_FromLong(pid));
> > > -=09=09pydict_set_item_string_decref(dict, "common_comm",
> > > PyString_FromString(comm));
> > > +=09=09pydict_set_item_string_decref(dict, "common_cpu",
> > > _PyLong_FromLong(cpu));
> > > +=09=09pydict_set_item_string_decref(dict, "common_s", _PyLong_FromLo=
ng(s));
> > > +=09=09pydict_set_item_string_decref(dict, "common_ns",
> > > _PyLong_FromLong(ns));
> > > +=09=09pydict_set_item_string_decref(dict, "common_pid",
> > > _PyLong_FromLong(pid));
> > > +=09=09pydict_set_item_string_decref(dict, "common_comm",
> > > _PyUnicode_FromString(comm));
> > >  =09=09pydict_set_item_string_decref(dict, "common_callchain", callch=
ain);
> > >  =09}
> > >  =09for (field =3D event->format.fields; field; field =3D field->next=
) {
> > > @@ -614,7 +644,7 @@ static void python_process_tracepoint(struct
> > > perf_sample *sample,
> > >  =09=09=09}
> > >  =09=09=09if (field->flags & FIELD_IS_STRING &&
> > >  =09=09=09    is_printable_array(data + offset, len)) {
> > > -=09=09=09=09obj =3D PyString_FromString((char *) data + offset);
> > > +=09=09=09=09obj =3D _PyUnicode_FromString((char *) data + offset);
> > >  =09=09=09} else {
> > >  =09=09=09=09obj =3D PyByteArray_FromStringAndSize((const char *) dat=
a + offset,
> > >  =09=09=09=09len);
> > >  =09=09=09=09field->flags &=3D ~FIELD_IS_STRING;
> > > @@ -667,7 +697,7 @@ static PyObject *tuple_new(unsigned int sz)
> > >  static int tuple_set_u64(PyObject *t, unsigned int pos, u64 val)
> > >  {
> > >  #if BITS_PER_LONG =3D=3D 64
> > > -=09return PyTuple_SetItem(t, pos, PyInt_FromLong(val));
> > > +=09return PyTuple_SetItem(t, pos, _PyLong_FromLong(val));
> > >  #endif
> > >  #if BITS_PER_LONG =3D=3D 32
> > >  =09return PyTuple_SetItem(t, pos, PyLong_FromLongLong(val));
> > > @@ -676,12 +706,12 @@ static int tuple_set_u64(PyObject *t, unsigned =
int
> > > pos, u64 val)
> > > =20
> > >  static int tuple_set_s32(PyObject *t, unsigned int pos, s32 val)
> > >  {
> > > -=09return PyTuple_SetItem(t, pos, PyInt_FromLong(val));
> > > +=09return PyTuple_SetItem(t, pos, _PyLong_FromLong(val));
> > >  }
> > > =20
> > >  static int tuple_set_string(PyObject *t, unsigned int pos, const cha=
r
> > >  *s)
> > >  {
> > > -=09return PyTuple_SetItem(t, pos, PyString_FromString(s));
> > > +=09return PyTuple_SetItem(t, pos, _PyUnicode_FromString(s));
> > >  }
> > > =20
> > >  static int python_export_evsel(struct db_export *dbe, struct perf_ev=
sel
> > >  *evsel)
> > > @@ -1028,8 +1058,8 @@ process_stat(struct perf_evsel *counter, int cp=
u,
> > > int thread, u64 tstamp,
> > >  =09=09return;
> > >  =09}
> > > =20
> > > -=09PyTuple_SetItem(t, n++, PyInt_FromLong(cpu));
> > > -=09PyTuple_SetItem(t, n++, PyInt_FromLong(thread));
> > > +=09PyTuple_SetItem(t, n++, _PyLong_FromLong(cpu));
> > > +=09PyTuple_SetItem(t, n++, _PyLong_FromLong(thread));
> > > =20
> > >  =09tuple_set_u64(t, n++, tstamp);
> > >  =09tuple_set_u64(t, n++, count->val);
> > > @@ -1211,27 +1241,58 @@ static void set_table_handlers(struct tables
> > > *tables)
> > >  =09SET_TABLE_HANDLER(call_return);
> > >  }
> > > =20
> > > +#if PY_MAJOR_VERSION < 3
> > > +static void _free_command_line(const char **command_line, int num)
> > > +{
> > > +=09free(command_line);
> > > +}
> > > +#else
> > > +static void _free_command_line(wchar_t **command_line, int num)
> > > +{
> > > +=09int i;
> > > +=09for (i =3D 0; i < num; i++)
> > > +=09=09PyMem_RawFree(command_line[i]);
> > > +=09free(command_line);
> > > +}
> > > +#endif
> > > +
> > > +
> > >  /*
> > >   * Start trace script
> > >   */
> > >  static int python_start_script(const char *script, int argc, const c=
har
> > >  **argv)
> > >  {
> > >  =09struct tables *tables =3D &tables_global;
> > > +#if PY_MAJOR_VERSION < 3
> > >  =09const char **command_line;
> > > +#else
> > > +=09wchar_t **command_line;
> > > +#endif
> > >  =09char buf[PATH_MAX];
> > >  =09int i, err =3D 0;
> > >  =09FILE *fp;
> > > =20
> > > +#if PY_MAJOR_VERSION < 3
> > >  =09command_line =3D malloc((argc + 1) * sizeof(const char *));
> > >  =09command_line[0] =3D script;
> > >  =09for (i =3D 1; i < argc + 1; i++)
> > >  =09=09command_line[i] =3D argv[i - 1];
> > > +#else
> > > +=09command_line =3D malloc((argc + 1) * sizeof(wchar_t *));
> > > +=09command_line[0] =3D Py_DecodeLocale(script, NULL);
> > > +=09for (i =3D 1; i < argc + 1; i++)
> > > +=09=09command_line[i] =3D Py_DecodeLocale(argv[i - 1], NULL);
> > > +#endif
> > > =20
> > >  =09Py_Initialize();
> > > =20
> > > +#if PY_MAJOR_VERSION < 3
> > >  =09initperf_trace_context();
> > > -
> > >  =09PySys_SetArgv(argc + 1, (char **)command_line);
> > > +#else
> > > +=09PyInit_perf_trace_context();
> > > +=09PySys_SetArgv(argc + 1, command_line);
> > > +#endif
> > > =20
> > >  =09fp =3D fopen(script, "r");
> > >  =09if (!fp) {
> > > @@ -1261,12 +1322,12 @@ static int python_start_script(const char
> > > *script, int argc, const char **argv)
> > >  =09=09=09goto error;
> > >  =09}
> > > =20
> > > -=09free(command_line);
> > > +=09_free_command_line(command_line, argc + 1);
> > > =20
> > >  =09return err;
> > >  error:
> > >  =09Py_Finalize();
> > > -=09free(command_line);
> > > +=09_free_command_line(command_line, argc + 1);
> > > =20
> > >  =09return err;
> > >  }
> > > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > > index af415feb..6891635b 100644
> > > --- a/tools/perf/util/setup.py
> > > +++ b/tools/perf/util/setup.py
> > > @@ -1,4 +1,4 @@
> > > -#!/usr/bin/python2
> > > +#!/usr/bin/python
> > > =20
> > >  from os import getenv
> > > =20
> > > @@ -35,11 +35,11 @@ build_tmp =3D getenv('PYTHON_EXTBUILD_TMP')
> > >  libtraceevent =3D getenv('LIBTRACEEVENT')
> > >  libapikfs =3D getenv('LIBAPI')
> > > =20
> > > -ext_sources =3D [f.strip() for f in file('util/python-ext-sources')
> > > +ext_sources =3D [f.strip() for f in open('util/python-ext-sources')
> > >  =09=09=09=09if len(f.strip()) > 0 and f[0] !=3D '#']
> > > =20
> > >  # use full paths with source files
> > > -ext_sources =3D map(lambda x: '%s/%s' % (src_perf, x) , ext_sources)
> > > +ext_sources =3D list(map(lambda x: '%s/%s' % (src_perf, x) , ext_sou=
rces))
> > > =20
> > >  perf =3D Extension('perf',
> > >  =09=09  sources =3D ext_sources,
> > > --
> > > 2.13.6
> > >=20
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > > linux-perf-users" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-user=
s"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

------=_Part_42061179_414787436.1510868201499
Content-Type: text/x-patch; name=kernel-4.15-perf-python3-port.patch
Content-Disposition: attachment; filename=kernel-4.15-perf-python3-port.patch
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvc2NyaXB0cy9weXRob24vUGVyZi1UcmFjZS1VdGlsL0Nv
bnRleHQuYyBiL3Rvb2xzL3BlcmYvc2NyaXB0cy9weXRob24vUGVyZi1UcmFjZS1VdGlsL0NvbnRl
eHQuYwppbmRleCBmY2QxZGQ2Li4xYTBkMjc3IDEwMDY0NAotLS0gYS90b29scy9wZXJmL3Njcmlw
dHMvcHl0aG9uL1BlcmYtVHJhY2UtVXRpbC9Db250ZXh0LmMKKysrIGIvdG9vbHMvcGVyZi9zY3Jp
cHRzL3B5dGhvbi9QZXJmLVRyYWNlLVV0aWwvQ29udGV4dC5jCkBAIC0yMyw3ICsyMywxNyBAQAog
I2luY2x1ZGUgIi4uLy4uLy4uL3BlcmYuaCIKICNpbmNsdWRlICIuLi8uLi8uLi91dGlsL3RyYWNl
LWV2ZW50LmgiCiAKKyNpZiBQWV9NQUpPUl9WRVJTSU9OIDwgMworI2RlZmluZSBfUHlDYXBzdWxl
X0dldFBvaW50ZXIoYXJnMSwgYXJnMikgXAorICBQeUNPYmplY3RfQXNWb2lkUHRyKGFyZzEpCisK
IFB5TU9ESU5JVF9GVU5DIGluaXRwZXJmX3RyYWNlX2NvbnRleHQodm9pZCk7CisjZWxzZQorI2Rl
ZmluZSBfUHlDYXBzdWxlX0dldFBvaW50ZXIoYXJnMSwgYXJnMikgXAorICBQeUNhcHN1bGVfR2V0
UG9pbnRlcigoYXJnMSksIChhcmcyKSkKKworUHlNT0RJTklUX0ZVTkMgUHlJbml0X3BlcmZfdHJh
Y2VfY29udGV4dCh2b2lkKTsKKyNlbmRpZgogCiBzdGF0aWMgUHlPYmplY3QgKnBlcmZfdHJhY2Vf
Y29udGV4dF9jb21tb25fcGMoUHlPYmplY3QgKm9iaiwgUHlPYmplY3QgKmFyZ3MpCiB7CkBAIC0z
NCw3ICs0NCw3IEBAIHN0YXRpYyBQeU9iamVjdCAqcGVyZl90cmFjZV9jb250ZXh0X2NvbW1vbl9w
YyhQeU9iamVjdCAqb2JqLCBQeU9iamVjdCAqYXJncykKIAlpZiAoIVB5QXJnX1BhcnNlVHVwbGUo
YXJncywgIk8iLCAmY29udGV4dCkpCiAJCXJldHVybiBOVUxMOwogCi0Jc2NyaXB0aW5nX2NvbnRl
eHQgPSBQeUNPYmplY3RfQXNWb2lkUHRyKGNvbnRleHQpOworCXNjcmlwdGluZ19jb250ZXh0ID0g
X1B5Q2Fwc3VsZV9HZXRQb2ludGVyKGNvbnRleHQsIE5VTEwpOwogCXJldHZhbCA9IGNvbW1vbl9w
YyhzY3JpcHRpbmdfY29udGV4dCk7CiAKIAlyZXR1cm4gUHlfQnVpbGRWYWx1ZSgiaSIsIHJldHZh
bCk7CkBAIC01MCw3ICs2MCw3IEBAIHN0YXRpYyBQeU9iamVjdCAqcGVyZl90cmFjZV9jb250ZXh0
X2NvbW1vbl9mbGFncyhQeU9iamVjdCAqb2JqLAogCWlmICghUHlBcmdfUGFyc2VUdXBsZShhcmdz
LCAiTyIsICZjb250ZXh0KSkKIAkJcmV0dXJuIE5VTEw7CiAKLQlzY3JpcHRpbmdfY29udGV4dCA9
IFB5Q09iamVjdF9Bc1ZvaWRQdHIoY29udGV4dCk7CisJc2NyaXB0aW5nX2NvbnRleHQgPSBfUHlD
YXBzdWxlX0dldFBvaW50ZXIoY29udGV4dCwgTlVMTCk7CiAJcmV0dmFsID0gY29tbW9uX2ZsYWdz
KHNjcmlwdGluZ19jb250ZXh0KTsKIAogCXJldHVybiBQeV9CdWlsZFZhbHVlKCJpIiwgcmV0dmFs
KTsKQEAgLTY2LDcgKzc2LDcgQEAgc3RhdGljIFB5T2JqZWN0ICpwZXJmX3RyYWNlX2NvbnRleHRf
Y29tbW9uX2xvY2tfZGVwdGgoUHlPYmplY3QgKm9iaiwKIAlpZiAoIVB5QXJnX1BhcnNlVHVwbGUo
YXJncywgIk8iLCAmY29udGV4dCkpCiAJCXJldHVybiBOVUxMOwogCi0Jc2NyaXB0aW5nX2NvbnRl
eHQgPSBQeUNPYmplY3RfQXNWb2lkUHRyKGNvbnRleHQpOworCXNjcmlwdGluZ19jb250ZXh0ID0g
X1B5Q2Fwc3VsZV9HZXRQb2ludGVyKGNvbnRleHQsIE5VTEwpOwogCXJldHZhbCA9IGNvbW1vbl9s
b2NrX2RlcHRoKHNjcmlwdGluZ19jb250ZXh0KTsKIAogCXJldHVybiBQeV9CdWlsZFZhbHVlKCJp
IiwgcmV0dmFsKTsKQEAgLTgyLDcgKzkyLDI1IEBAIHN0YXRpYyBQeU9iamVjdCAqcGVyZl90cmFj
ZV9jb250ZXh0X2NvbW1vbl9sb2NrX2RlcHRoKFB5T2JqZWN0ICpvYmosCiAJeyBOVUxMLCBOVUxM
LCAwLCBOVUxMfQogfTsKIAorI2lmIFBZX01BSk9SX1ZFUlNJT04gPCAzCiBQeU1PRElOSVRfRlVO
QyBpbml0cGVyZl90cmFjZV9jb250ZXh0KHZvaWQpCiB7CiAJKHZvaWQpIFB5X0luaXRNb2R1bGUo
InBlcmZfdHJhY2VfY29udGV4dCIsIENvbnRleHRNZXRob2RzKTsKIH0KKyNlbHNlCitQeU1PRElO
SVRfRlVOQyBQeUluaXRfcGVyZl90cmFjZV9jb250ZXh0KHZvaWQpCit7CisJc3RhdGljIHN0cnVj
dCBQeU1vZHVsZURlZiBtb2R1bGVkZWYgPSB7CisJCVB5TW9kdWxlRGVmX0hFQURfSU5JVCwKKwkJ
InBlcmZfdHJhY2VfY29udGV4dCIsCS8qIG1fbmFtZSAqLworCQkiIiwJCQkvKiBtX2RvYyAqLwor
CQktMSwJCQkvKiBtX3NpemUgKi8KKwkJQ29udGV4dE1ldGhvZHMsCQkvKiBtX21ldGhvZHMgKi8K
KwkJTlVMTCwJCQkvKiBtX3JlbG9hZCAqLworCQlOVUxMLAkJCS8qIG1fdHJhdmVyc2UgKi8KKwkJ
TlVMTCwJCQkvKiBtX2NsZWFyICovCisJCU5VTEwsCQkJLyogbV9mcmVlICovCisJfTsKKwlyZXR1
cm4gUHlNb2R1bGVfQ3JlYXRlKCZtb2R1bGVkZWYpOworfQorI2VuZGlmCmRpZmYgLS1naXQgYS90
b29scy9wZXJmL3V0aWwvcHl0aG9uLmMgYi90b29scy9wZXJmL3V0aWwvcHl0aG9uLmMKaW5kZXgg
OGU0OWQ5Yy4uMTY2MjBjMyAxMDA2NDQKLS0tIGEvdG9vbHMvcGVyZi91dGlsL3B5dGhvbi5jCisr
KyBiL3Rvb2xzL3BlcmYvdXRpbC9weXRob24uYwpAQCAtMTIsNiArMTIsMzAgQEAKICNpbmNsdWRl
ICJwcmludF9iaW5hcnkuaCIKICNpbmNsdWRlICJ0aHJlYWRfbWFwLmgiCiAKKyNpZiBQWV9NQUpP
Ul9WRVJTSU9OIDwgMworI2RlZmluZSBfUHlVbmljb2RlX0Zyb21TdHJpbmcoYXJnKSBcCisgIFB5
U3RyaW5nX0Zyb21TdHJpbmcoYXJnKQorI2RlZmluZSBfUHlVbmljb2RlX0FzU3RyaW5nKGFyZykg
XAorICBQeVN0cmluZ19Bc1N0cmluZyhhcmcpCisjZGVmaW5lIF9QeVVuaWNvZGVfRnJvbUZvcm1h
dCguLi4pIFwKKyAgUHlTdHJpbmdfRnJvbUZvcm1hdChfX1ZBX0FSR1NfXykKKyNkZWZpbmUgX1B5
TG9uZ19Gcm9tTG9uZyhhcmcpIFwKKyAgUHlJbnRfRnJvbUxvbmcoYXJnKQorCisjZWxzZQorCisj
ZGVmaW5lIF9QeVVuaWNvZGVfRnJvbVN0cmluZyhhcmcpIFwKKyAgUHlVbmljb2RlX0Zyb21TdHJp
bmcoYXJnKQorI2RlZmluZSBfUHlVbmljb2RlX0Zyb21Gb3JtYXQoLi4uKSBcCisgIFB5VW5pY29k
ZV9Gcm9tRm9ybWF0KF9fVkFfQVJHU19fKQorI2RlZmluZSBfUHlMb25nX0Zyb21Mb25nKGFyZykg
XAorICBQeUxvbmdfRnJvbUxvbmcoYXJnKQorI2VuZGlmCisKKyNpZm5kZWYgUHlfVFlQRQorI2Rl
ZmluZSBQeV9UWVBFKG9iKSAoKChQeU9iamVjdCopKG9iKSktPm9iX3R5cGUpCisjZW5kaWYKKwog
LyoKICAqIFByb3ZpZGUgdGhlc2UgdHdvIHNvIHRoYXQgd2UgZG9uJ3QgaGF2ZSB0byBsaW5rIGFn
YWluc3QgY2FsbGNoYWluLmMgYW5kCiAgKiBzdGFydCBkcmFnZ2luZyBoaXN0LmMsIGV0Yy4KQEAg
LTQ5LDcgKzczLDExIEBAIGludCBlcHJpbnRmKGludCBsZXZlbCwgaW50IHZhciwgY29uc3QgY2hh
ciAqZm10LCAuLi4pCiAjIGRlZmluZSBQeVZhck9iamVjdF9IRUFEX0lOSVQodHlwZSwgc2l6ZSkg
UHlPYmplY3RfSEVBRF9JTklUKHR5cGUpIHNpemUsCiAjZW5kaWYKIAorI2lmIFBZX01BSk9SX1ZF
UlNJT04gPCAzCiBQeU1PRElOSVRfRlVOQyBpbml0cGVyZih2b2lkKTsKKyNlbHNlCitQeU1PRElO
SVRfRlVOQyBQeUluaXRfcGVyZih2b2lkKTsKKyNlbmRpZgogCiAjZGVmaW5lIG1lbWJlcl9kZWYo
dHlwZSwgbWVtYmVyLCBwdHlwZSwgaGVscCkgXAogCXsgI21lbWJlciwgcHR5cGUsIFwKQEAgLTEw
Nyw3ICsxMzUsNyBAQCBzdGF0aWMgUHlPYmplY3QgKnB5cmZfbW1hcF9ldmVudF9fcmVwcihzdHJ1
Y3QgcHlyZl9ldmVudCAqcGV2ZW50KQogCQkgICAgIHBldmVudC0+ZXZlbnQubW1hcC5wZ29mZiwg
cGV2ZW50LT5ldmVudC5tbWFwLmZpbGVuYW1lKSA8IDApIHsKIAkJcmV0ID0gUHlFcnJfTm9NZW1v
cnkoKTsKIAl9IGVsc2UgewotCQlyZXQgPSBQeVN0cmluZ19Gcm9tU3RyaW5nKHMpOworCQlyZXQg
PSBfUHlVbmljb2RlX0Zyb21TdHJpbmcocyk7CiAJCWZyZWUocyk7CiAJfQogCXJldHVybiByZXQ7
CkBAIC0xMzgsNyArMTY2LDcgQEAgc3RhdGljIFB5T2JqZWN0ICpweXJmX21tYXBfZXZlbnRfX3Jl
cHIoc3RydWN0IHB5cmZfZXZlbnQgKnBldmVudCkKIAogc3RhdGljIFB5T2JqZWN0ICpweXJmX3Rh
c2tfZXZlbnRfX3JlcHIoc3RydWN0IHB5cmZfZXZlbnQgKnBldmVudCkKIHsKLQlyZXR1cm4gUHlT
dHJpbmdfRnJvbUZvcm1hdCgieyB0eXBlOiAlcywgcGlkOiAldSwgcHBpZDogJXUsIHRpZDogJXUs
ICIKKwlyZXR1cm4gX1B5VW5pY29kZV9Gcm9tRm9ybWF0KCJ7IHR5cGU6ICVzLCBwaWQ6ICV1LCBw
cGlkOiAldSwgdGlkOiAldSwgIgogCQkJCSAgICJwdGlkOiAldSwgdGltZTogJSIgUFJJdTY0ICJ9
IiwKIAkJCQkgICBwZXZlbnQtPmV2ZW50LmhlYWRlci50eXBlID09IFBFUkZfUkVDT1JEX0ZPUksg
PyAiZm9yayIgOiAiZXhpdCIsCiAJCQkJICAgcGV2ZW50LT5ldmVudC5mb3JrLnBpZCwKQEAgLTE3
MSw3ICsxOTksNyBAQCBzdGF0aWMgUHlPYmplY3QgKnB5cmZfdGFza19ldmVudF9fcmVwcihzdHJ1
Y3QgcHlyZl9ldmVudCAqcGV2ZW50KQogCiBzdGF0aWMgUHlPYmplY3QgKnB5cmZfY29tbV9ldmVu
dF9fcmVwcihzdHJ1Y3QgcHlyZl9ldmVudCAqcGV2ZW50KQogewotCXJldHVybiBQeVN0cmluZ19G
cm9tRm9ybWF0KCJ7IHR5cGU6IGNvbW0sIHBpZDogJXUsIHRpZDogJXUsIGNvbW06ICVzIH0iLAor
CXJldHVybiBfUHlVbmljb2RlX0Zyb21Gb3JtYXQoInsgdHlwZTogY29tbSwgcGlkOiAldSwgdGlk
OiAldSwgY29tbTogJXMgfSIsCiAJCQkJICAgcGV2ZW50LT5ldmVudC5jb21tLnBpZCwKIAkJCQkg
ICBwZXZlbnQtPmV2ZW50LmNvbW0udGlkLAogCQkJCSAgIHBldmVudC0+ZXZlbnQuY29tbS5jb21t
KTsKQEAgLTIwMiw3ICsyMzAsNyBAQCBzdGF0aWMgUHlPYmplY3QgKnB5cmZfdGhyb3R0bGVfZXZl
bnRfX3JlcHIoc3RydWN0IHB5cmZfZXZlbnQgKnBldmVudCkKIHsKIAlzdHJ1Y3QgdGhyb3R0bGVf
ZXZlbnQgKnRlID0gKHN0cnVjdCB0aHJvdHRsZV9ldmVudCAqKSgmcGV2ZW50LT5ldmVudC5oZWFk
ZXIgKyAxKTsKIAotCXJldHVybiBQeVN0cmluZ19Gcm9tRm9ybWF0KCJ7IHR5cGU6ICVzdGhyb3R0
bGUsIHRpbWU6ICUiIFBSSXU2NCAiLCBpZDogJSIgUFJJdTY0CisJcmV0dXJuIF9QeVVuaWNvZGVf
RnJvbUZvcm1hdCgieyB0eXBlOiAlc3Rocm90dGxlLCB0aW1lOiAlIiBQUkl1NjQgIiwgaWQ6ICUi
IFBSSXU2NAogCQkJCSAgICIsIHN0cmVhbV9pZDogJSIgUFJJdTY0ICIgfSIsCiAJCQkJICAgcGV2
ZW50LT5ldmVudC5oZWFkZXIudHlwZSA9PSBQRVJGX1JFQ09SRF9USFJPVFRMRSA/ICIiIDogInVu
IiwKIAkJCQkgICB0ZS0+dGltZSwgdGUtPmlkLCB0ZS0+c3RyZWFtX2lkKTsKQEAgLTIzNyw3ICsy
NjUsNyBAQCBzdGF0aWMgUHlPYmplY3QgKnB5cmZfbG9zdF9ldmVudF9fcmVwcihzdHJ1Y3QgcHly
Zl9ldmVudCAqcGV2ZW50KQogCQkgICAgIHBldmVudC0+ZXZlbnQubG9zdC5pZCwgcGV2ZW50LT5l
dmVudC5sb3N0Lmxvc3QpIDwgMCkgewogCQlyZXQgPSBQeUVycl9Ob01lbW9yeSgpOwogCX0gZWxz
ZSB7Ci0JCXJldCA9IFB5U3RyaW5nX0Zyb21TdHJpbmcocyk7CisJCXJldCA9IF9QeVVuaWNvZGVf
RnJvbVN0cmluZyhzKTsKIAkJZnJlZShzKTsKIAl9CiAJcmV0dXJuIHJldDsKQEAgLTI2NCw3ICsy
OTIsNyBAQCBzdGF0aWMgUHlPYmplY3QgKnB5cmZfbG9zdF9ldmVudF9fcmVwcihzdHJ1Y3QgcHly
Zl9ldmVudCAqcGV2ZW50KQogCiBzdGF0aWMgUHlPYmplY3QgKnB5cmZfcmVhZF9ldmVudF9fcmVw
cihzdHJ1Y3QgcHlyZl9ldmVudCAqcGV2ZW50KQogewotCXJldHVybiBQeVN0cmluZ19Gcm9tRm9y
bWF0KCJ7IHR5cGU6IHJlYWQsIHBpZDogJXUsIHRpZDogJXUgfSIsCisJcmV0dXJuIF9QeVVuaWNv
ZGVfRnJvbUZvcm1hdCgieyB0eXBlOiByZWFkLCBwaWQ6ICV1LCB0aWQ6ICV1IH0iLAogCQkJCSAg
IHBldmVudC0+ZXZlbnQucmVhZC5waWQsCiAJCQkJICAgcGV2ZW50LT5ldmVudC5yZWFkLnRpZCk7
CiAJLyoKQEAgLTI5OSw3ICszMjcsNyBAQCBzdGF0aWMgUHlPYmplY3QgKnB5cmZfc2FtcGxlX2V2
ZW50X19yZXByKHN0cnVjdCBweXJmX2V2ZW50ICpwZXZlbnQpCiAJaWYgKGFzcHJpbnRmKCZzLCAi
eyB0eXBlOiBzYW1wbGUgfSIpIDwgMCkgewogCQlyZXQgPSBQeUVycl9Ob01lbW9yeSgpOwogCX0g
ZWxzZSB7Ci0JCXJldCA9IFB5U3RyaW5nX0Zyb21TdHJpbmcocyk7CisJCXJldCA9IF9QeVVuaWNv
ZGVfRnJvbVN0cmluZyhzKTsKIAkJZnJlZShzKTsKIAl9CiAJcmV0dXJuIHJldDsKQEAgLTMzMCw3
ICszNTgsNyBAQCBzdGF0aWMgYm9vbCBpc190cmFjZXBvaW50KHN0cnVjdCBweXJmX2V2ZW50ICpw
ZXZlbnQpCiAJCX0KIAkJaWYgKGZpZWxkLT5mbGFncyAmIEZJRUxEX0lTX1NUUklORyAmJgogCQkg
ICAgaXNfcHJpbnRhYmxlX2FycmF5KGRhdGEgKyBvZmZzZXQsIGxlbikpIHsKLQkJCXJldCA9IFB5
U3RyaW5nX0Zyb21TdHJpbmcoKGNoYXIgKilkYXRhICsgb2Zmc2V0KTsKKwkJCXJldCA9IF9QeVVu
aWNvZGVfRnJvbVN0cmluZygoY2hhciAqKWRhdGEgKyBvZmZzZXQpOwogCQl9IGVsc2UgewogCQkJ
cmV0ID0gUHlCeXRlQXJyYXlfRnJvbVN0cmluZ0FuZFNpemUoKGNvbnN0IGNoYXIgKikgZGF0YSAr
IG9mZnNldCwgbGVuKTsKIAkJCWZpZWxkLT5mbGFncyAmPSB+RklFTERfSVNfU1RSSU5HOwpAQCAt
MzUyLDcgKzM4MCw3IEBAIHN0YXRpYyBib29sIGlzX3RyYWNlcG9pbnQoc3RydWN0IHB5cmZfZXZl
bnQgKnBldmVudCkKIHN0YXRpYyBQeU9iamVjdCoKIGdldF90cmFjZXBvaW50X2ZpZWxkKHN0cnVj
dCBweXJmX2V2ZW50ICpwZXZlbnQsIFB5T2JqZWN0ICphdHRyX25hbWUpCiB7Ci0JY29uc3QgY2hh
ciAqc3RyID0gUHlTdHJpbmdfQXNTdHJpbmcoUHlPYmplY3RfU3RyKGF0dHJfbmFtZSkpOworCWNv
bnN0IGNoYXIgKnN0ciA9IF9QeVVuaWNvZGVfQXNTdHJpbmcoUHlPYmplY3RfU3RyKGF0dHJfbmFt
ZSkpOwogCXN0cnVjdCBwZXJmX2V2c2VsICpldnNlbCA9IHBldmVudC0+ZXZzZWw7CiAJc3RydWN0
IGZvcm1hdF9maWVsZCAqZmllbGQ7CiAKQEAgLTQxNiw3ICs0NDQsNyBAQCBzdGF0aWMgUHlPYmpl
Y3QgKnB5cmZfY29udGV4dF9zd2l0Y2hfZXZlbnRfX3JlcHIoc3RydWN0IHB5cmZfZXZlbnQgKnBl
dmVudCkKIAkJICAgICAhIShwZXZlbnQtPmV2ZW50LmhlYWRlci5taXNjICYgUEVSRl9SRUNPUkRf
TUlTQ19TV0lUQ0hfT1VUKSkgPCAwKSB7CiAJCXJldCA9IFB5RXJyX05vTWVtb3J5KCk7CiAJfSBl
bHNlIHsKLQkJcmV0ID0gUHlTdHJpbmdfRnJvbVN0cmluZyhzKTsKKwkJcmV0ID0gX1B5VW5pY29k
ZV9Gcm9tU3RyaW5nKHMpOwogCQlmcmVlKHMpOwogCX0KIAlyZXR1cm4gcmV0OwpAQCAtNTI4LDcg
KzU1Niw3IEBAIHN0YXRpYyBpbnQgcHlyZl9jcHVfbWFwX19pbml0KHN0cnVjdCBweXJmX2NwdV9t
YXAgKnBjcHVzLAogc3RhdGljIHZvaWQgcHlyZl9jcHVfbWFwX19kZWxldGUoc3RydWN0IHB5cmZf
Y3B1X21hcCAqcGNwdXMpCiB7CiAJY3B1X21hcF9fcHV0KHBjcHVzLT5jcHVzKTsKLQlwY3B1cy0+
b2JfdHlwZS0+dHBfZnJlZSgoUHlPYmplY3QqKXBjcHVzKTsKKwlQeV9UWVBFKHBjcHVzKS0+dHBf
ZnJlZSgoUHlPYmplY3QqKXBjcHVzKTsKIH0KIAogc3RhdGljIFB5X3NzaXplX3QgcHlyZl9jcHVf
bWFwX19sZW5ndGgoUHlPYmplY3QgKm9iaikKQEAgLTU5Nyw3ICs2MjUsNyBAQCBzdGF0aWMgaW50
IHB5cmZfdGhyZWFkX21hcF9faW5pdChzdHJ1Y3QgcHlyZl90aHJlYWRfbWFwICpwdGhyZWFkcywK
IHN0YXRpYyB2b2lkIHB5cmZfdGhyZWFkX21hcF9fZGVsZXRlKHN0cnVjdCBweXJmX3RocmVhZF9t
YXAgKnB0aHJlYWRzKQogewogCXRocmVhZF9tYXBfX3B1dChwdGhyZWFkcy0+dGhyZWFkcyk7Ci0J
cHRocmVhZHMtPm9iX3R5cGUtPnRwX2ZyZWUoKFB5T2JqZWN0KilwdGhyZWFkcyk7CisJUHlfVFlQ
RShwdGhyZWFkcyktPnRwX2ZyZWUoKFB5T2JqZWN0KilwdGhyZWFkcyk7CiB9CiAKIHN0YXRpYyBQ
eV9zc2l6ZV90IHB5cmZfdGhyZWFkX21hcF9fbGVuZ3RoKFB5T2JqZWN0ICpvYmopCkBAIC03NTks
NyArNzg3LDcgQEAgc3RhdGljIGludCBweXJmX2V2c2VsX19pbml0KHN0cnVjdCBweXJmX2V2c2Vs
ICpwZXZzZWwsCiBzdGF0aWMgdm9pZCBweXJmX2V2c2VsX19kZWxldGUoc3RydWN0IHB5cmZfZXZz
ZWwgKnBldnNlbCkKIHsKIAlwZXJmX2V2c2VsX19leGl0KCZwZXZzZWwtPmV2c2VsKTsKLQlwZXZz
ZWwtPm9iX3R5cGUtPnRwX2ZyZWUoKFB5T2JqZWN0KilwZXZzZWwpOworCVB5X1RZUEUocGV2c2Vs
KS0+dHBfZnJlZSgoUHlPYmplY3QqKXBldnNlbCk7CiB9CiAKIHN0YXRpYyBQeU9iamVjdCAqcHly
Zl9ldnNlbF9fb3BlbihzdHJ1Y3QgcHlyZl9ldnNlbCAqcGV2c2VsLApAQCAtODUwLDcgKzg3OCw3
IEBAIHN0YXRpYyBpbnQgcHlyZl9ldmxpc3RfX2luaXQoc3RydWN0IHB5cmZfZXZsaXN0ICpwZXZs
aXN0LAogc3RhdGljIHZvaWQgcHlyZl9ldmxpc3RfX2RlbGV0ZShzdHJ1Y3QgcHlyZl9ldmxpc3Qg
KnBldmxpc3QpCiB7CiAJcGVyZl9ldmxpc3RfX2V4aXQoJnBldmxpc3QtPmV2bGlzdCk7Ci0JcGV2
bGlzdC0+b2JfdHlwZS0+dHBfZnJlZSgoUHlPYmplY3QqKXBldmxpc3QpOworCVB5X1RZUEUocGV2
bGlzdCktPnRwX2ZyZWUoKFB5T2JqZWN0KilwZXZsaXN0KTsKIH0KIAogc3RhdGljIFB5T2JqZWN0
ICpweXJmX2V2bGlzdF9fbW1hcChzdHJ1Y3QgcHlyZl9ldmxpc3QgKnBldmxpc3QsCkBAIC05MDIs
MTIgKzkzMCwxNiBAQCBzdGF0aWMgUHlPYmplY3QgKnB5cmZfZXZsaXN0X19nZXRfcG9sbGZkKHN0
cnVjdCBweXJmX2V2bGlzdCAqcGV2bGlzdCwKIAogCWZvciAoaSA9IDA7IGkgPCBldmxpc3QtPnBv
bGxmZC5ucjsgKytpKSB7CiAJCVB5T2JqZWN0ICpmaWxlOworI2lmIFBZX01BSk9SX1ZFUlNJT04g
PCAzCiAJCUZJTEUgKmZwID0gZmRvcGVuKGV2bGlzdC0+cG9sbGZkLmVudHJpZXNbaV0uZmQsICJy
Iik7CiAKIAkJaWYgKGZwID09IE5VTEwpCiAJCQlnb3RvIGZyZWVfbGlzdDsKIAogCQlmaWxlID0g
UHlGaWxlX0Zyb21GaWxlKGZwLCAicGVyZiIsICJyIiwgTlVMTCk7CisjZWxzZQorCQlmaWxlID0g
UHlGaWxlX0Zyb21GZChldmxpc3QtPnBvbGxmZC5lbnRyaWVzW2ldLmZkLCAicGVyZiIsICJyIiwg
LTEsIE5VTEwsIE5VTEwsIE5VTEwsIDEpOworI2VuZGlmCiAJCWlmIChmaWxlID09IE5VTEwpCiAJ
CQlnb3RvIGZyZWVfbGlzdDsKIApAQCAtMTE5NCw5ICsxMjI2LDkgQEAgc3RhdGljIFB5T2JqZWN0
ICpweXJmX190cmFjZXBvaW50KHN0cnVjdCBweXJmX2V2c2VsICpwZXZzZWwsCiAKIAl0cF9mb3Jt
YXQgPSB0cmFjZV9ldmVudF9fdHBfZm9ybWF0KHN5cywgbmFtZSk7CiAJaWYgKElTX0VSUih0cF9m
b3JtYXQpKQotCQlyZXR1cm4gUHlJbnRfRnJvbUxvbmcoLTEpOworCQlyZXR1cm4gX1B5TG9uZ19G
cm9tTG9uZygtMSk7CiAKLQlyZXR1cm4gUHlJbnRfRnJvbUxvbmcodHBfZm9ybWF0LT5pZCk7CisJ
cmV0dXJuIF9QeUxvbmdfRnJvbUxvbmcodHBfZm9ybWF0LT5pZCk7CiB9CiAKIHN0YXRpYyBQeU1l
dGhvZERlZiBwZXJmX19tZXRob2RzW10gPSB7CkBAIC0xMjA5LDExICsxMjQxLDMxIEBAIHN0YXRp
YyBQeU9iamVjdCAqcHlyZl9fdHJhY2Vwb2ludChzdHJ1Y3QgcHlyZl9ldnNlbCAqcGV2c2VsLAog
CXsgLm1sX25hbWUgPSBOVUxMLCB9CiB9OwogCisjaWYgUFlfTUFKT1JfVkVSU0lPTiA8IDMKIFB5
TU9ESU5JVF9GVU5DIGluaXRwZXJmKHZvaWQpCisjZWxzZQorUHlNT0RJTklUX0ZVTkMgUHlJbml0
X3BlcmYodm9pZCkKKyNlbmRpZgogewogCVB5T2JqZWN0ICpvYmo7CiAJaW50IGk7Ci0JUHlPYmpl
Y3QgKmRpY3QsICptb2R1bGUgPSBQeV9Jbml0TW9kdWxlKCJwZXJmIiwgcGVyZl9fbWV0aG9kcyk7
CisJUHlPYmplY3QgKmRpY3Q7CisjaWYgUFlfTUFKT1JfVkVSU0lPTiA8IDMKKwlQeU9iamVjdCAq
bW9kdWxlID0gUHlfSW5pdE1vZHVsZSgicGVyZiIsIHBlcmZfX21ldGhvZHMpOworI2Vsc2UKKwlz
dGF0aWMgc3RydWN0IFB5TW9kdWxlRGVmIG1vZHVsZWRlZiA9IHsKKwkJUHlNb2R1bGVEZWZfSEVB
RF9JTklULAorCQkicGVyZiIsCQkJLyogbV9uYW1lICovCisJCSIiLAkJCS8qIG1fZG9jICovCisJ
CS0xLAkJCS8qIG1fc2l6ZSAqLworCQlwZXJmX19tZXRob2RzLAkJLyogbV9tZXRob2RzICovCisJ
CU5VTEwsCQkJLyogbV9yZWxvYWQgKi8KKwkJTlVMTCwJCQkvKiBtX3RyYXZlcnNlICovCisJCU5V
TEwsCQkJLyogbV9jbGVhciAqLworCQlOVUxMLAkJCS8qIG1fZnJlZSAqLworCX07CisJUHlPYmpl
Y3QgKm1vZHVsZSA9IFB5TW9kdWxlX0NyZWF0ZSgmbW9kdWxlZGVmKTsKKyNlbmRpZgogCiAJaWYg
KG1vZHVsZSA9PSBOVUxMIHx8CiAJICAgIHB5cmZfZXZlbnRfX3NldHVwX3R5cGVzKCkgPCAwIHx8
CkBAIC0xMjIxLDcgKzEyNzMsMTEgQEAgUHlNT0RJTklUX0ZVTkMgaW5pdHBlcmYodm9pZCkKIAkg
ICAgcHlyZl9ldnNlbF9fc2V0dXBfdHlwZXMoKSA8IDAgfHwKIAkgICAgcHlyZl90aHJlYWRfbWFw
X19zZXR1cF90eXBlcygpIDwgMCB8fAogCSAgICBweXJmX2NwdV9tYXBfX3NldHVwX3R5cGVzKCkg
PCAwKQorI2lmIFBZX01BSk9SX1ZFUlNJT04gPCAzCiAJCXJldHVybjsKKyNlbHNlCisJCXJldHVy
biBtb2R1bGU7CisjZW5kaWYKIAogCS8qIFRoZSBwYWdlX3NpemUgaXMgcGxhY2VkIGluIHV0aWwg
b2JqZWN0LiAqLwogCXBhZ2Vfc2l6ZSA9IHN5c2NvbmYoX1NDX1BBR0VfU0laRSk7CkBAIC0xMjcw
LDcgKzEzMjYsNyBAQCBQeU1PRElOSVRfRlVOQyBpbml0cGVyZih2b2lkKQogCQlnb3RvIGVycm9y
OwogCiAJZm9yIChpID0gMDsgcGVyZl9fY29uc3RhbnRzW2ldLm5hbWUgIT0gTlVMTDsgaSsrKSB7
Ci0JCW9iaiA9IFB5SW50X0Zyb21Mb25nKHBlcmZfX2NvbnN0YW50c1tpXS52YWx1ZSk7CisJCW9i
aiA9IF9QeUxvbmdfRnJvbUxvbmcocGVyZl9fY29uc3RhbnRzW2ldLnZhbHVlKTsKIAkJaWYgKG9i
aiA9PSBOVUxMKQogCQkJZ290byBlcnJvcjsKIAkJUHlEaWN0X1NldEl0ZW1TdHJpbmcoZGljdCwg
cGVyZl9fY29uc3RhbnRzW2ldLm5hbWUsIG9iaik7CkBAIC0xMjgwLDYgKzEzMzYsOSBAQCBQeU1P
RElOSVRfRlVOQyBpbml0cGVyZih2b2lkKQogZXJyb3I6CiAJaWYgKFB5RXJyX09jY3VycmVkKCkp
CiAJCVB5RXJyX1NldFN0cmluZyhQeUV4Y19JbXBvcnRFcnJvciwgInBlcmY6IEluaXQgZmFpbGVk
ISIpOworI2lmIFBZX01BSk9SX1ZFUlNJT04gPj0gMworCXJldHVybiBtb2R1bGU7CisjZW5kaWYK
IH0KIAogLyoKZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9zY3JpcHRpbmctZW5naW5lcy90
cmFjZS1ldmVudC1weXRob24uYyBiL3Rvb2xzL3BlcmYvdXRpbC9zY3JpcHRpbmctZW5naW5lcy90
cmFjZS1ldmVudC1weXRob24uYwppbmRleCBjNzE4N2YwLi5kMzdlMjRiIDEwMDY0NAotLS0gYS90
b29scy9wZXJmL3V0aWwvc2NyaXB0aW5nLWVuZ2luZXMvdHJhY2UtZXZlbnQtcHl0aG9uLmMKKysr
IGIvdG9vbHMvcGVyZi91dGlsL3NjcmlwdGluZy1lbmdpbmVzL3RyYWNlLWV2ZW50LXB5dGhvbi5j
CkBAIC01MCw3ICs1MCwzMyBAQAogI2luY2x1ZGUgInByaW50X2JpbmFyeS5oIgogI2luY2x1ZGUg
InN0YXQuaCIKIAorI2lmIFBZX01BSk9SX1ZFUlNJT04gPCAzCisjZGVmaW5lIF9QeVVuaWNvZGVf
RnJvbVN0cmluZyhhcmcpIFwKKyAgUHlTdHJpbmdfRnJvbVN0cmluZyhhcmcpCisjZGVmaW5lIF9Q
eVVuaWNvZGVfRnJvbVN0cmluZ0FuZFNpemUoYXJnMSwgYXJnMikgXAorICBQeVN0cmluZ19Gcm9t
U3RyaW5nQW5kU2l6ZSgoYXJnMSksIChhcmcyKSkKKyNkZWZpbmUgX1B5Qnl0ZXNfRnJvbVN0cmlu
Z0FuZFNpemUoYXJnMSwgYXJnMikgXAorICBQeVN0cmluZ19Gcm9tU3RyaW5nQW5kU2l6ZSgoYXJn
MSksIChhcmcyKSkKKyNkZWZpbmUgX1B5TG9uZ19Gcm9tTG9uZyhhcmcpIFwKKyAgUHlJbnRfRnJv
bUxvbmcoYXJnKQorI2RlZmluZSBfUHlDYXBzdWxlX05ldyhhcmcxLCBhcmcyLCBhcmczKSBcCisg
IFB5Q09iamVjdF9Gcm9tVm9pZFB0cigoYXJnMSksIChhcmcyKSkKKwogUHlNT0RJTklUX0ZVTkMg
aW5pdHBlcmZfdHJhY2VfY29udGV4dCh2b2lkKTsKKyNlbHNlCisjZGVmaW5lIF9QeVVuaWNvZGVf
RnJvbVN0cmluZyhhcmcpIFwKKyAgUHlVbmljb2RlX0Zyb21TdHJpbmcoYXJnKQorI2RlZmluZSBf
UHlVbmljb2RlX0Zyb21TdHJpbmdBbmRTaXplKGFyZzEsIGFyZzIpIFwKKyAgUHlVbmljb2RlX0Zy
b21TdHJpbmdBbmRTaXplKChhcmcxKSwgKGFyZzIpKQorI2RlZmluZSBfUHlCeXRlc19Gcm9tU3Ry
aW5nQW5kU2l6ZShhcmcxLCBhcmcyKSBcCisgIFB5Qnl0ZXNfRnJvbVN0cmluZ0FuZFNpemUoKGFy
ZzEpLCAoYXJnMikpCisjZGVmaW5lIF9QeUxvbmdfRnJvbUxvbmcoYXJnKSBcCisgIFB5TG9uZ19G
cm9tTG9uZyhhcmcpCisjZGVmaW5lIF9QeUNhcHN1bGVfTmV3KGFyZzEsIGFyZzIsIGFyZzMpIFwK
KyAgUHlDYXBzdWxlX05ldygoYXJnMSksIChhcmcyKSwgKGFyZzMpKQorCitQeU1PRElOSVRfRlVO
QyBQeUluaXRfcGVyZl90cmFjZV9jb250ZXh0KHZvaWQpOworI2VuZGlmCiAKICNkZWZpbmUgVFJB
Q0VfRVZFTlRfVFlQRV9NQVgJCQkJXAogCSgoMSA8PCAoc2l6ZW9mKHVuc2lnbmVkIHNob3J0KSAq
IDgpKSAtIDEpCkBAIC0xODMsMTAgKzIwOSwxMCBAQCBzdGF0aWMgdm9pZCBkZWZpbmVfdmFsdWUo
ZW51bSBwcmludF9hcmdfdHlwZSBmaWVsZF90eXBlLAogCiAJdmFsdWUgPSBldmFsX2ZsYWcoZmll
bGRfdmFsdWUpOwogCi0JUHlUdXBsZV9TZXRJdGVtKHQsIG4rKywgUHlTdHJpbmdfRnJvbVN0cmlu
Zyhldl9uYW1lKSk7Ci0JUHlUdXBsZV9TZXRJdGVtKHQsIG4rKywgUHlTdHJpbmdfRnJvbVN0cmlu
ZyhmaWVsZF9uYW1lKSk7Ci0JUHlUdXBsZV9TZXRJdGVtKHQsIG4rKywgUHlJbnRfRnJvbUxvbmco
dmFsdWUpKTsKLQlQeVR1cGxlX1NldEl0ZW0odCwgbisrLCBQeVN0cmluZ19Gcm9tU3RyaW5nKGZp
ZWxkX3N0cikpOworCVB5VHVwbGVfU2V0SXRlbSh0LCBuKyssIF9QeVVuaWNvZGVfRnJvbVN0cmlu
Zyhldl9uYW1lKSk7CisJUHlUdXBsZV9TZXRJdGVtKHQsIG4rKywgX1B5VW5pY29kZV9Gcm9tU3Ry
aW5nKGZpZWxkX25hbWUpKTsKKwlQeVR1cGxlX1NldEl0ZW0odCwgbisrLCBfUHlMb25nX0Zyb21M
b25nKHZhbHVlKSk7CisJUHlUdXBsZV9TZXRJdGVtKHQsIG4rKywgX1B5VW5pY29kZV9Gcm9tU3Ry
aW5nKGZpZWxkX3N0cikpOwogCiAJdHJ5X2NhbGxfb2JqZWN0KGhhbmRsZXJfbmFtZSwgdCk7CiAK
QEAgLTIyNCwxMCArMjUwLDEwIEBAIHN0YXRpYyB2b2lkIGRlZmluZV9maWVsZChlbnVtIHByaW50
X2FyZ190eXBlIGZpZWxkX3R5cGUsCiAJaWYgKCF0KQogCQlQeV9GYXRhbEVycm9yKCJjb3VsZG4n
dCBjcmVhdGUgUHl0aG9uIHR1cGxlIik7CiAKLQlQeVR1cGxlX1NldEl0ZW0odCwgbisrLCBQeVN0
cmluZ19Gcm9tU3RyaW5nKGV2X25hbWUpKTsKLQlQeVR1cGxlX1NldEl0ZW0odCwgbisrLCBQeVN0
cmluZ19Gcm9tU3RyaW5nKGZpZWxkX25hbWUpKTsKKwlQeVR1cGxlX1NldEl0ZW0odCwgbisrLCBf
UHlVbmljb2RlX0Zyb21TdHJpbmcoZXZfbmFtZSkpOworCVB5VHVwbGVfU2V0SXRlbSh0LCBuKyss
IF9QeVVuaWNvZGVfRnJvbVN0cmluZyhmaWVsZF9uYW1lKSk7CiAJaWYgKGZpZWxkX3R5cGUgPT0g
UFJJTlRfRkxBR1MpCi0JCVB5VHVwbGVfU2V0SXRlbSh0LCBuKyssIFB5U3RyaW5nX0Zyb21TdHJp
bmcoZGVsaW0pKTsKKwkJUHlUdXBsZV9TZXRJdGVtKHQsIG4rKywgX1B5VW5pY29kZV9Gcm9tU3Ry
aW5nKGRlbGltKSk7CiAKIAl0cnlfY2FsbF9vYmplY3QoaGFuZGxlcl9uYW1lLCB0KTsKIApAQCAt
MzI2LDEyICszNTIsMTIgQEAgc3RhdGljIFB5T2JqZWN0ICpnZXRfZmllbGRfbnVtZXJpY19lbnRy
eShzdHJ1Y3QgZXZlbnRfZm9ybWF0ICpldmVudCwKIAkJaWYgKGZpZWxkLT5mbGFncyAmIEZJRUxE
X0lTX1NJR05FRCkgewogCQkJaWYgKChsb25nIGxvbmcpdmFsID49IExPTkdfTUlOICYmCiAJCQkJ
CShsb25nIGxvbmcpdmFsIDw9IExPTkdfTUFYKQotCQkJCW9iaiA9IFB5SW50X0Zyb21Mb25nKHZh
bCk7CisJCQkJb2JqID0gX1B5TG9uZ19Gcm9tTG9uZyh2YWwpOwogCQkJZWxzZQogCQkJCW9iaiA9
IFB5TG9uZ19Gcm9tTG9uZ0xvbmcodmFsKTsKIAkJfSBlbHNlIHsKIAkJCWlmICh2YWwgPD0gTE9O
R19NQVgpCi0JCQkJb2JqID0gUHlJbnRfRnJvbUxvbmcodmFsKTsKKwkJCQlvYmogPSBfUHlMb25n
X0Zyb21Mb25nKHZhbCk7CiAJCQllbHNlCiAJCQkJb2JqID0gUHlMb25nX0Zyb21VbnNpZ25lZExv
bmdMb25nKHZhbCk7CiAJCX0KQEAgLTM5MCw5ICs0MTYsOSBAQCBzdGF0aWMgUHlPYmplY3QgKnB5
dGhvbl9wcm9jZXNzX2NhbGxjaGFpbihzdHJ1Y3QgcGVyZl9zYW1wbGUgKnNhbXBsZSwKIAkJCXB5
ZGljdF9zZXRfaXRlbV9zdHJpbmdfZGVjcmVmKHB5c3ltLCAiZW5kIiwKIAkJCQkJUHlMb25nX0Zy
b21VbnNpZ25lZExvbmdMb25nKG5vZGUtPnN5bS0+ZW5kKSk7CiAJCQlweWRpY3Rfc2V0X2l0ZW1f
c3RyaW5nX2RlY3JlZihweXN5bSwgImJpbmRpbmciLAotCQkJCQlQeUludF9Gcm9tTG9uZyhub2Rl
LT5zeW0tPmJpbmRpbmcpKTsKKwkJCQkJX1B5TG9uZ19Gcm9tTG9uZyhub2RlLT5zeW0tPmJpbmRp
bmcpKTsKIAkJCXB5ZGljdF9zZXRfaXRlbV9zdHJpbmdfZGVjcmVmKHB5c3ltLCAibmFtZSIsCi0J
CQkJCVB5U3RyaW5nX0Zyb21TdHJpbmdBbmRTaXplKG5vZGUtPnN5bS0+bmFtZSwKKwkJCQkJX1B5
VW5pY29kZV9Gcm9tU3RyaW5nQW5kU2l6ZShub2RlLT5zeW0tPm5hbWUsCiAJCQkJCQkJbm9kZS0+
c3ltLT5uYW1lbGVuKSk7CiAJCQlweWRpY3Rfc2V0X2l0ZW1fc3RyaW5nX2RlY3JlZihweWVsZW0s
ICJzeW0iLCBweXN5bSk7CiAJCX0KQEAgLTQwNyw3ICs0MzMsNyBAQCBzdGF0aWMgUHlPYmplY3Qg
KnB5dGhvbl9wcm9jZXNzX2NhbGxjaGFpbihzdHJ1Y3QgcGVyZl9zYW1wbGUgKnNhbXBsZSwKIAkJ
CQkJZHNvbmFtZSA9IG1hcC0+ZHNvLT5uYW1lOwogCQkJfQogCQkJcHlkaWN0X3NldF9pdGVtX3N0
cmluZ19kZWNyZWYocHllbGVtLCAiZHNvIiwKLQkJCQkJUHlTdHJpbmdfRnJvbVN0cmluZyhkc29u
YW1lKSk7CisJCQkJCV9QeVVuaWNvZGVfRnJvbVN0cmluZyhkc29uYW1lKSk7CiAJCX0KIAogCQlj
YWxsY2hhaW5fY3Vyc29yX2FkdmFuY2UoJmNhbGxjaGFpbl9jdXJzb3IpOwpAQCAtNDg0LDE2ICs1
MTAsMTYgQEAgc3RhdGljIFB5T2JqZWN0ICpnZXRfcGVyZl9zYW1wbGVfZGljdChzdHJ1Y3QgcGVy
Zl9zYW1wbGUgKnNhbXBsZSwKIAlpZiAoIWRpY3Rfc2FtcGxlKQogCQlQeV9GYXRhbEVycm9yKCJj
b3VsZG4ndCBjcmVhdGUgUHl0aG9uIGRpY3Rpb25hcnkiKTsKIAotCXB5ZGljdF9zZXRfaXRlbV9z
dHJpbmdfZGVjcmVmKGRpY3QsICJldl9uYW1lIiwgUHlTdHJpbmdfRnJvbVN0cmluZyhwZXJmX2V2
c2VsX19uYW1lKGV2c2VsKSkpOwotCXB5ZGljdF9zZXRfaXRlbV9zdHJpbmdfZGVjcmVmKGRpY3Qs
ICJhdHRyIiwgUHlTdHJpbmdfRnJvbVN0cmluZ0FuZFNpemUoCisJcHlkaWN0X3NldF9pdGVtX3N0
cmluZ19kZWNyZWYoZGljdCwgImV2X25hbWUiLCBfUHlVbmljb2RlX0Zyb21TdHJpbmcocGVyZl9l
dnNlbF9fbmFtZShldnNlbCkpKTsKKwlweWRpY3Rfc2V0X2l0ZW1fc3RyaW5nX2RlY3JlZihkaWN0
LCAiYXR0ciIsIF9QeVVuaWNvZGVfRnJvbVN0cmluZ0FuZFNpemUoCiAJCQkoY29uc3QgY2hhciAq
KSZldnNlbC0+YXR0ciwgc2l6ZW9mKGV2c2VsLT5hdHRyKSkpOwogCiAJcHlkaWN0X3NldF9pdGVt
X3N0cmluZ19kZWNyZWYoZGljdF9zYW1wbGUsICJwaWQiLAotCQkJUHlJbnRfRnJvbUxvbmcoc2Ft
cGxlLT5waWQpKTsKKwkJCV9QeUxvbmdfRnJvbUxvbmcoc2FtcGxlLT5waWQpKTsKIAlweWRpY3Rf
c2V0X2l0ZW1fc3RyaW5nX2RlY3JlZihkaWN0X3NhbXBsZSwgInRpZCIsCi0JCQlQeUludF9Gcm9t
TG9uZyhzYW1wbGUtPnRpZCkpOworCQkJX1B5TG9uZ19Gcm9tTG9uZyhzYW1wbGUtPnRpZCkpOwog
CXB5ZGljdF9zZXRfaXRlbV9zdHJpbmdfZGVjcmVmKGRpY3Rfc2FtcGxlLCAiY3B1IiwKLQkJCVB5
SW50X0Zyb21Mb25nKHNhbXBsZS0+Y3B1KSk7CisJCQlfUHlMb25nX0Zyb21Mb25nKHNhbXBsZS0+
Y3B1KSk7CiAJcHlkaWN0X3NldF9pdGVtX3N0cmluZ19kZWNyZWYoZGljdF9zYW1wbGUsICJpcCIs
CiAJCQlQeUxvbmdfRnJvbVVuc2lnbmVkTG9uZ0xvbmcoc2FtcGxlLT5pcCkpOwogCXB5ZGljdF9z
ZXRfaXRlbV9zdHJpbmdfZGVjcmVmKGRpY3Rfc2FtcGxlLCAidGltZSIsCkBAIC01MDMsMTcgKzUy
OSwxNyBAQCBzdGF0aWMgUHlPYmplY3QgKmdldF9wZXJmX3NhbXBsZV9kaWN0KHN0cnVjdCBwZXJm
X3NhbXBsZSAqc2FtcGxlLAogCXNldF9zYW1wbGVfcmVhZF9pbl9kaWN0KGRpY3Rfc2FtcGxlLCBz
YW1wbGUsIGV2c2VsKTsKIAlweWRpY3Rfc2V0X2l0ZW1fc3RyaW5nX2RlY3JlZihkaWN0LCAic2Ft
cGxlIiwgZGljdF9zYW1wbGUpOwogCi0JcHlkaWN0X3NldF9pdGVtX3N0cmluZ19kZWNyZWYoZGlj
dCwgInJhd19idWYiLCBQeVN0cmluZ19Gcm9tU3RyaW5nQW5kU2l6ZSgKKwlweWRpY3Rfc2V0X2l0
ZW1fc3RyaW5nX2RlY3JlZihkaWN0LCAicmF3X2J1ZiIsIF9QeUJ5dGVzX0Zyb21TdHJpbmdBbmRT
aXplKAogCQkJKGNvbnN0IGNoYXIgKilzYW1wbGUtPnJhd19kYXRhLCBzYW1wbGUtPnJhd19zaXpl
KSk7CiAJcHlkaWN0X3NldF9pdGVtX3N0cmluZ19kZWNyZWYoZGljdCwgImNvbW0iLAotCQkJUHlT
dHJpbmdfRnJvbVN0cmluZyh0aHJlYWRfX2NvbW1fc3RyKGFsLT50aHJlYWQpKSk7CisJCQlfUHlV
bmljb2RlX0Zyb21TdHJpbmcodGhyZWFkX19jb21tX3N0cihhbC0+dGhyZWFkKSkpOwogCWlmIChh
bC0+bWFwKSB7CiAJCXB5ZGljdF9zZXRfaXRlbV9zdHJpbmdfZGVjcmVmKGRpY3QsICJkc28iLAot
CQkJUHlTdHJpbmdfRnJvbVN0cmluZyhhbC0+bWFwLT5kc28tPm5hbWUpKTsKKwkJCV9QeVVuaWNv
ZGVfRnJvbVN0cmluZyhhbC0+bWFwLT5kc28tPm5hbWUpKTsKIAl9CiAJaWYgKGFsLT5zeW0pIHsK
IAkJcHlkaWN0X3NldF9pdGVtX3N0cmluZ19kZWNyZWYoZGljdCwgInN5bWJvbCIsCi0JCQlQeVN0
cmluZ19Gcm9tU3RyaW5nKGFsLT5zeW0tPm5hbWUpKTsKKwkJCV9QeVVuaWNvZGVfRnJvbVN0cmlu
ZyhhbC0+c3ltLT5uYW1lKSk7CiAJfQogCiAJcHlkaWN0X3NldF9pdGVtX3N0cmluZ19kZWNyZWYo
ZGljdCwgImNhbGxjaGFpbiIsIGNhbGxjaGFpbik7CkBAIC01NzMsOSArNTk5LDkgQEAgc3RhdGlj
IHZvaWQgcHl0aG9uX3Byb2Nlc3NfdHJhY2Vwb2ludChzdHJ1Y3QgcGVyZl9zYW1wbGUgKnNhbXBs
ZSwKIAlzY3JpcHRpbmdfY29udGV4dC0+ZXZlbnRfZGF0YSA9IGRhdGE7CiAJc2NyaXB0aW5nX2Nv
bnRleHQtPnBldmVudCA9IGV2c2VsLT50cF9mb3JtYXQtPnBldmVudDsKIAotCWNvbnRleHQgPSBQ
eUNPYmplY3RfRnJvbVZvaWRQdHIoc2NyaXB0aW5nX2NvbnRleHQsIE5VTEwpOworCWNvbnRleHQg
PSBfUHlDYXBzdWxlX05ldyhzY3JpcHRpbmdfY29udGV4dCwgTlVMTCwgTlVMTCk7CiAKLQlQeVR1
cGxlX1NldEl0ZW0odCwgbisrLCBQeVN0cmluZ19Gcm9tU3RyaW5nKGhhbmRsZXJfbmFtZSkpOwor
CVB5VHVwbGVfU2V0SXRlbSh0LCBuKyssIF9QeVVuaWNvZGVfRnJvbVN0cmluZyhoYW5kbGVyX25h
bWUpKTsKIAlQeVR1cGxlX1NldEl0ZW0odCwgbisrLCBjb250ZXh0KTsKIAogCS8qIGlwIHVud2lu
ZGluZyAqLwpAQCAtNTg0LDE4ICs2MTAsMTggQEAgc3RhdGljIHZvaWQgcHl0aG9uX3Byb2Nlc3Nf
dHJhY2Vwb2ludChzdHJ1Y3QgcGVyZl9zYW1wbGUgKnNhbXBsZSwKIAlQeV9JTkNSRUYoY2FsbGNo
YWluKTsKIAogCWlmICghZGljdCkgewotCQlQeVR1cGxlX1NldEl0ZW0odCwgbisrLCBQeUludF9G
cm9tTG9uZyhjcHUpKTsKLQkJUHlUdXBsZV9TZXRJdGVtKHQsIG4rKywgUHlJbnRfRnJvbUxvbmco
cykpOwotCQlQeVR1cGxlX1NldEl0ZW0odCwgbisrLCBQeUludF9Gcm9tTG9uZyhucykpOwotCQlQ
eVR1cGxlX1NldEl0ZW0odCwgbisrLCBQeUludF9Gcm9tTG9uZyhwaWQpKTsKLQkJUHlUdXBsZV9T
ZXRJdGVtKHQsIG4rKywgUHlTdHJpbmdfRnJvbVN0cmluZyhjb21tKSk7CisJCVB5VHVwbGVfU2V0
SXRlbSh0LCBuKyssIF9QeUxvbmdfRnJvbUxvbmcoY3B1KSk7CisJCVB5VHVwbGVfU2V0SXRlbSh0
LCBuKyssIF9QeUxvbmdfRnJvbUxvbmcocykpOworCQlQeVR1cGxlX1NldEl0ZW0odCwgbisrLCBf
UHlMb25nX0Zyb21Mb25nKG5zKSk7CisJCVB5VHVwbGVfU2V0SXRlbSh0LCBuKyssIF9QeUxvbmdf
RnJvbUxvbmcocGlkKSk7CisJCVB5VHVwbGVfU2V0SXRlbSh0LCBuKyssIF9QeVVuaWNvZGVfRnJv
bVN0cmluZyhjb21tKSk7CiAJCVB5VHVwbGVfU2V0SXRlbSh0LCBuKyssIGNhbGxjaGFpbik7CiAJ
fSBlbHNlIHsKLQkJcHlkaWN0X3NldF9pdGVtX3N0cmluZ19kZWNyZWYoZGljdCwgImNvbW1vbl9j
cHUiLCBQeUludF9Gcm9tTG9uZyhjcHUpKTsKLQkJcHlkaWN0X3NldF9pdGVtX3N0cmluZ19kZWNy
ZWYoZGljdCwgImNvbW1vbl9zIiwgUHlJbnRfRnJvbUxvbmcocykpOwotCQlweWRpY3Rfc2V0X2l0
ZW1fc3RyaW5nX2RlY3JlZihkaWN0LCAiY29tbW9uX25zIiwgUHlJbnRfRnJvbUxvbmcobnMpKTsK
LQkJcHlkaWN0X3NldF9pdGVtX3N0cmluZ19kZWNyZWYoZGljdCwgImNvbW1vbl9waWQiLCBQeUlu
dF9Gcm9tTG9uZyhwaWQpKTsKLQkJcHlkaWN0X3NldF9pdGVtX3N0cmluZ19kZWNyZWYoZGljdCwg
ImNvbW1vbl9jb21tIiwgUHlTdHJpbmdfRnJvbVN0cmluZyhjb21tKSk7CisJCXB5ZGljdF9zZXRf
aXRlbV9zdHJpbmdfZGVjcmVmKGRpY3QsICJjb21tb25fY3B1IiwgX1B5TG9uZ19Gcm9tTG9uZyhj
cHUpKTsKKwkJcHlkaWN0X3NldF9pdGVtX3N0cmluZ19kZWNyZWYoZGljdCwgImNvbW1vbl9zIiwg
X1B5TG9uZ19Gcm9tTG9uZyhzKSk7CisJCXB5ZGljdF9zZXRfaXRlbV9zdHJpbmdfZGVjcmVmKGRp
Y3QsICJjb21tb25fbnMiLCBfUHlMb25nX0Zyb21Mb25nKG5zKSk7CisJCXB5ZGljdF9zZXRfaXRl
bV9zdHJpbmdfZGVjcmVmKGRpY3QsICJjb21tb25fcGlkIiwgX1B5TG9uZ19Gcm9tTG9uZyhwaWQp
KTsKKwkJcHlkaWN0X3NldF9pdGVtX3N0cmluZ19kZWNyZWYoZGljdCwgImNvbW1vbl9jb21tIiwg
X1B5VW5pY29kZV9Gcm9tU3RyaW5nKGNvbW0pKTsKIAkJcHlkaWN0X3NldF9pdGVtX3N0cmluZ19k
ZWNyZWYoZGljdCwgImNvbW1vbl9jYWxsY2hhaW4iLCBjYWxsY2hhaW4pOwogCX0KIAlmb3IgKGZp
ZWxkID0gZXZlbnQtPmZvcm1hdC5maWVsZHM7IGZpZWxkOyBmaWVsZCA9IGZpZWxkLT5uZXh0KSB7
CkBAIC02MTQsNyArNjQwLDcgQEAgc3RhdGljIHZvaWQgcHl0aG9uX3Byb2Nlc3NfdHJhY2Vwb2lu
dChzdHJ1Y3QgcGVyZl9zYW1wbGUgKnNhbXBsZSwKIAkJCX0KIAkJCWlmIChmaWVsZC0+ZmxhZ3Mg
JiBGSUVMRF9JU19TVFJJTkcgJiYKIAkJCSAgICBpc19wcmludGFibGVfYXJyYXkoZGF0YSArIG9m
ZnNldCwgbGVuKSkgewotCQkJCW9iaiA9IFB5U3RyaW5nX0Zyb21TdHJpbmcoKGNoYXIgKikgZGF0
YSArIG9mZnNldCk7CisJCQkJb2JqID0gX1B5VW5pY29kZV9Gcm9tU3RyaW5nKChjaGFyICopIGRh
dGEgKyBvZmZzZXQpOwogCQkJfSBlbHNlIHsKIAkJCQlvYmogPSBQeUJ5dGVBcnJheV9Gcm9tU3Ry
aW5nQW5kU2l6ZSgoY29uc3QgY2hhciAqKSBkYXRhICsgb2Zmc2V0LCBsZW4pOwogCQkJCWZpZWxk
LT5mbGFncyAmPSB+RklFTERfSVNfU1RSSU5HOwpAQCAtNjY3LDcgKzY5Myw3IEBAIHN0YXRpYyBQ
eU9iamVjdCAqdHVwbGVfbmV3KHVuc2lnbmVkIGludCBzeikKIHN0YXRpYyBpbnQgdHVwbGVfc2V0
X3U2NChQeU9iamVjdCAqdCwgdW5zaWduZWQgaW50IHBvcywgdTY0IHZhbCkKIHsKICNpZiBCSVRT
X1BFUl9MT05HID09IDY0Ci0JcmV0dXJuIFB5VHVwbGVfU2V0SXRlbSh0LCBwb3MsIFB5SW50X0Zy
b21Mb25nKHZhbCkpOworCXJldHVybiBQeVR1cGxlX1NldEl0ZW0odCwgcG9zLCBfUHlMb25nX0Zy
b21Mb25nKHZhbCkpOwogI2VuZGlmCiAjaWYgQklUU19QRVJfTE9ORyA9PSAzMgogCXJldHVybiBQ
eVR1cGxlX1NldEl0ZW0odCwgcG9zLCBQeUxvbmdfRnJvbUxvbmdMb25nKHZhbCkpOwpAQCAtNjc2
LDEyICs3MDIsMTIgQEAgc3RhdGljIGludCB0dXBsZV9zZXRfdTY0KFB5T2JqZWN0ICp0LCB1bnNp
Z25lZCBpbnQgcG9zLCB1NjQgdmFsKQogCiBzdGF0aWMgaW50IHR1cGxlX3NldF9zMzIoUHlPYmpl
Y3QgKnQsIHVuc2lnbmVkIGludCBwb3MsIHMzMiB2YWwpCiB7Ci0JcmV0dXJuIFB5VHVwbGVfU2V0
SXRlbSh0LCBwb3MsIFB5SW50X0Zyb21Mb25nKHZhbCkpOworCXJldHVybiBQeVR1cGxlX1NldEl0
ZW0odCwgcG9zLCBfUHlMb25nX0Zyb21Mb25nKHZhbCkpOwogfQogCiBzdGF0aWMgaW50IHR1cGxl
X3NldF9zdHJpbmcoUHlPYmplY3QgKnQsIHVuc2lnbmVkIGludCBwb3MsIGNvbnN0IGNoYXIgKnMp
CiB7Ci0JcmV0dXJuIFB5VHVwbGVfU2V0SXRlbSh0LCBwb3MsIFB5U3RyaW5nX0Zyb21TdHJpbmco
cykpOworCXJldHVybiBQeVR1cGxlX1NldEl0ZW0odCwgcG9zLCBfUHlVbmljb2RlX0Zyb21TdHJp
bmcocykpOwogfQogCiBzdGF0aWMgaW50IHB5dGhvbl9leHBvcnRfZXZzZWwoc3RydWN0IGRiX2V4
cG9ydCAqZGJlLCBzdHJ1Y3QgcGVyZl9ldnNlbCAqZXZzZWwpCkBAIC0xMDI4LDggKzEwNTQsOCBA
QCBzdGF0aWMgdm9pZCBnZXRfaGFuZGxlcl9uYW1lKGNoYXIgKnN0ciwgc2l6ZV90IHNpemUsCiAJ
CXJldHVybjsKIAl9CiAKLQlQeVR1cGxlX1NldEl0ZW0odCwgbisrLCBQeUludF9Gcm9tTG9uZyhj
cHUpKTsKLQlQeVR1cGxlX1NldEl0ZW0odCwgbisrLCBQeUludF9Gcm9tTG9uZyh0aHJlYWQpKTsK
KwlQeVR1cGxlX1NldEl0ZW0odCwgbisrLCBfUHlMb25nX0Zyb21Mb25nKGNwdSkpOworCVB5VHVw
bGVfU2V0SXRlbSh0LCBuKyssIF9QeUxvbmdfRnJvbUxvbmcodGhyZWFkKSk7CiAKIAl0dXBsZV9z
ZXRfdTY0KHQsIG4rKywgdHN0YW1wKTsKIAl0dXBsZV9zZXRfdTY0KHQsIG4rKywgY291bnQtPnZh
bCk7CkBAIC0xMjExLDI3ICsxMjM3LDU4IEBAIHN0YXRpYyB2b2lkIHNldF90YWJsZV9oYW5kbGVy
cyhzdHJ1Y3QgdGFibGVzICp0YWJsZXMpCiAJU0VUX1RBQkxFX0hBTkRMRVIoY2FsbF9yZXR1cm4p
OwogfQogCisjaWYgUFlfTUFKT1JfVkVSU0lPTiA8IDMKK3N0YXRpYyB2b2lkIF9mcmVlX2NvbW1h
bmRfbGluZShjb25zdCBjaGFyICoqY29tbWFuZF9saW5lLCBpbnQgbnVtKQoreworCWZyZWUoY29t
bWFuZF9saW5lKTsKK30KKyNlbHNlCitzdGF0aWMgdm9pZCBfZnJlZV9jb21tYW5kX2xpbmUod2No
YXJfdCAqKmNvbW1hbmRfbGluZSwgaW50IG51bSkKK3sKKwlpbnQgaTsKKwlmb3IgKGkgPSAwOyBp
IDwgbnVtOyBpKyspCisJCVB5TWVtX1Jhd0ZyZWUoY29tbWFuZF9saW5lW2ldKTsKKwlmcmVlKGNv
bW1hbmRfbGluZSk7Cit9CisjZW5kaWYKKworCiAvKgogICogU3RhcnQgdHJhY2Ugc2NyaXB0CiAg
Ki8KIHN0YXRpYyBpbnQgcHl0aG9uX3N0YXJ0X3NjcmlwdChjb25zdCBjaGFyICpzY3JpcHQsIGlu
dCBhcmdjLCBjb25zdCBjaGFyICoqYXJndikKIHsKIAlzdHJ1Y3QgdGFibGVzICp0YWJsZXMgPSAm
dGFibGVzX2dsb2JhbDsKKyNpZiBQWV9NQUpPUl9WRVJTSU9OIDwgMwogCWNvbnN0IGNoYXIgKipj
b21tYW5kX2xpbmU7CisjZWxzZQorCXdjaGFyX3QgKipjb21tYW5kX2xpbmU7CisjZW5kaWYKIAlj
aGFyIGJ1ZltQQVRIX01BWF07CiAJaW50IGksIGVyciA9IDA7CiAJRklMRSAqZnA7CiAKKyNpZiBQ
WV9NQUpPUl9WRVJTSU9OIDwgMwogCWNvbW1hbmRfbGluZSA9IG1hbGxvYygoYXJnYyArIDEpICog
c2l6ZW9mKGNvbnN0IGNoYXIgKikpOwogCWNvbW1hbmRfbGluZVswXSA9IHNjcmlwdDsKIAlmb3Ig
KGkgPSAxOyBpIDwgYXJnYyArIDE7IGkrKykKIAkJY29tbWFuZF9saW5lW2ldID0gYXJndltpIC0g
MV07CisjZWxzZQorCWNvbW1hbmRfbGluZSA9IG1hbGxvYygoYXJnYyArIDEpICogc2l6ZW9mKHdj
aGFyX3QgKikpOworCWNvbW1hbmRfbGluZVswXSA9IFB5X0RlY29kZUxvY2FsZShzY3JpcHQsIE5V
TEwpOworCWZvciAoaSA9IDE7IGkgPCBhcmdjICsgMTsgaSsrKQorCQljb21tYW5kX2xpbmVbaV0g
PSBQeV9EZWNvZGVMb2NhbGUoYXJndltpIC0gMV0sIE5VTEwpOworI2VuZGlmCiAKIAlQeV9Jbml0
aWFsaXplKCk7CiAKKyNpZiBQWV9NQUpPUl9WRVJTSU9OIDwgMwogCWluaXRwZXJmX3RyYWNlX2Nv
bnRleHQoKTsKLQogCVB5U3lzX1NldEFyZ3YoYXJnYyArIDEsIChjaGFyICoqKWNvbW1hbmRfbGlu
ZSk7CisjZWxzZQorCVB5SW5pdF9wZXJmX3RyYWNlX2NvbnRleHQoKTsKKwlQeVN5c19TZXRBcmd2
KGFyZ2MgKyAxLCBjb21tYW5kX2xpbmUpOworI2VuZGlmCiAKIAlmcCA9IGZvcGVuKHNjcmlwdCwg
InIiKTsKIAlpZiAoIWZwKSB7CkBAIC0xMjYxLDEyICsxMzE4LDEyIEBAIHN0YXRpYyBpbnQgcHl0
aG9uX3N0YXJ0X3NjcmlwdChjb25zdCBjaGFyICpzY3JpcHQsIGludCBhcmdjLCBjb25zdCBjaGFy
ICoqYXJndikKIAkJCWdvdG8gZXJyb3I7CiAJfQogCi0JZnJlZShjb21tYW5kX2xpbmUpOworCV9m
cmVlX2NvbW1hbmRfbGluZShjb21tYW5kX2xpbmUsIGFyZ2MgKyAxKTsKIAogCXJldHVybiBlcnI7
CiBlcnJvcjoKIAlQeV9GaW5hbGl6ZSgpOwotCWZyZWUoY29tbWFuZF9saW5lKTsKKwlfZnJlZV9j
b21tYW5kX2xpbmUoY29tbWFuZF9saW5lLCBhcmdjICsgMSk7CiAKIAlyZXR1cm4gZXJyOwogfQpk
aWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL3NldHVwLnB5IGIvdG9vbHMvcGVyZi91dGlsL3Nl
dHVwLnB5CmluZGV4IGFmNDE1ZmUuLjY4OTE2MzUgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3BlcmYvdXRp
bC9zZXR1cC5weQorKysgYi90b29scy9wZXJmL3V0aWwvc2V0dXAucHkKQEAgLTEsNCArMSw0IEBA
Ci0jIS91c3IvYmluL3B5dGhvbjIKKyMhL3Vzci9iaW4vcHl0aG9uCiAKIGZyb20gb3MgaW1wb3J0
IGdldGVudgogCkBAIC0zNSwxMSArMzUsMTEgQEAgYnVpbGRfdG1wID0gZ2V0ZW52KCdQWVRIT05f
RVhUQlVJTERfVE1QJykKIGxpYnRyYWNlZXZlbnQgPSBnZXRlbnYoJ0xJQlRSQUNFRVZFTlQnKQog
bGliYXBpa2ZzID0gZ2V0ZW52KCdMSUJBUEknKQogCi1leHRfc291cmNlcyA9IFtmLnN0cmlwKCkg
Zm9yIGYgaW4gZmlsZSgndXRpbC9weXRob24tZXh0LXNvdXJjZXMnKQorZXh0X3NvdXJjZXMgPSBb
Zi5zdHJpcCgpIGZvciBmIGluIG9wZW4oJ3V0aWwvcHl0aG9uLWV4dC1zb3VyY2VzJykKIAkJCQlp
ZiBsZW4oZi5zdHJpcCgpKSA+IDAgYW5kIGZbMF0gIT0gJyMnXQogCiAjIHVzZSBmdWxsIHBhdGhz
IHdpdGggc291cmNlIGZpbGVzCi1leHRfc291cmNlcyA9IG1hcChsYW1iZGEgeDogJyVzLyVzJyAl
IChzcmNfcGVyZiwgeCkgLCBleHRfc291cmNlcykKK2V4dF9zb3VyY2VzID0gbGlzdChtYXAobGFt
YmRhIHg6ICclcy8lcycgJSAoc3JjX3BlcmYsIHgpICwgZXh0X3NvdXJjZXMpKQogCiBwZXJmID0g
RXh0ZW5zaW9uKCdwZXJmJywKIAkJICBzb3VyY2VzID0gZXh0X3NvdXJjZXMsCg==
------=_Part_42061179_414787436.1510868201499--
