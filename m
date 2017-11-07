From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf: Add Python 3 support
Date: Tue, 7 Nov 2017 11:46:46 -0300
Message-ID: <20171107144646.GG3216@kernel.org>
References: <20171020223614.30787-1-jskarvad@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933972AbdKGOqu (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Nov 2017 09:46:50 -0500
Content-Disposition: inline
In-Reply-To: <20171020223614.30787-1-jskarvad@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jaroslav =?utf-8?B?xaBrYXJ2YWRh?= <jskarvad@redhat.com>
Cc: Clark Williams <williams@redhat.com>, Jiri Kastner <jkastner@redhat.com>, Jiri Olsa <jolsa@kernel.org>, John Kacur <jkacur@redhat.com>, linux-perf-users@vger.kernel.org

Em Sat, Oct 21, 2017 at 12:36:14AM +0200, Jaroslav Škarvada escreveu:
> Added Python 3 support while keeping Python < 3 compatibility.
> 
> Signed-off-by: Jaroslav Škarvada <jskarvad@redhat.com>
> ---
>  .../perf/scripts/python/Perf-Trace-Util/Context.c  |  34 ++++-
>  tools/perf/util/python.c                           |  95 ++++++++++---
>  .../util/scripting-engines/trace-event-python.c    | 147 +++++++++++++++------
>  tools/perf/util/setup.py                           |   6 +-
>  4 files changed, 215 insertions(+), 67 deletions(-)

I'll add more of those ifdefs, as the support doesn't get built when you
uninstall the python2-devel package, leaving just the python3-devel one:

[acme@jouet linux]$ cat /tmp/build/perf/feature/test-libpython.make.output 
test-libpython.c:2:10: fatal error: Python.h: No such file or directory
 #include <Python.h>
          ^~~~~~~~~~
compilation terminated.
[acme@jouet linux]$

- Arnaldo
 
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> index fcd1dd66..1a0d2775 100644
> --- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> +++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> @@ -23,7 +23,17 @@
>  #include "../../../perf.h"
>  #include "../../../util/trace-event.h"
>  
> +#if PY_MAJOR_VERSION < 3
> +#define _PyCapsule_GetPointer(arg1, arg2) \
> +  PyCObject_AsVoidPtr(arg1)
> +
>  PyMODINIT_FUNC initperf_trace_context(void);
> +#else
> +#define _PyCapsule_GetPointer(arg1, arg2) \
> +  PyCapsule_GetPointer((arg1), (arg2))
> +
> +PyMODINIT_FUNC PyInit_perf_trace_context(void);
> +#endif
>  
>  static PyObject *perf_trace_context_common_pc(PyObject *obj, PyObject *args)
>  {
> @@ -34,7 +44,7 @@ static PyObject *perf_trace_context_common_pc(PyObject *obj, PyObject *args)
>  	if (!PyArg_ParseTuple(args, "O", &context))
>  		return NULL;
>  
> -	scripting_context = PyCObject_AsVoidPtr(context);
> +	scripting_context = _PyCapsule_GetPointer(context, NULL);
>  	retval = common_pc(scripting_context);
>  
>  	return Py_BuildValue("i", retval);
> @@ -50,7 +60,7 @@ static PyObject *perf_trace_context_common_flags(PyObject *obj,
>  	if (!PyArg_ParseTuple(args, "O", &context))
>  		return NULL;
>  
> -	scripting_context = PyCObject_AsVoidPtr(context);
> +	scripting_context = _PyCapsule_GetPointer(context, NULL);
>  	retval = common_flags(scripting_context);
>  
>  	return Py_BuildValue("i", retval);
> @@ -66,7 +76,7 @@ static PyObject *perf_trace_context_common_lock_depth(PyObject *obj,
>  	if (!PyArg_ParseTuple(args, "O", &context))
>  		return NULL;
>  
> -	scripting_context = PyCObject_AsVoidPtr(context);
> +	scripting_context = _PyCapsule_GetPointer(context, NULL);
>  	retval = common_lock_depth(scripting_context);
>  
>  	return Py_BuildValue("i", retval);
> @@ -82,7 +92,25 @@ static PyMethodDef ContextMethods[] = {
>  	{ NULL, NULL, 0, NULL}
>  };
>  
> +#if PY_MAJOR_VERSION < 3
>  PyMODINIT_FUNC initperf_trace_context(void)
>  {
>  	(void) Py_InitModule("perf_trace_context", ContextMethods);
>  }
> +#else
> +PyMODINIT_FUNC PyInit_perf_trace_context(void)
> +{
> +	static struct PyModuleDef moduledef = {
> +		PyModuleDef_HEAD_INIT,
> +		"perf_trace_context",	/* m_name */
> +		"",			/* m_doc */
> +		-1,			/* m_size */
> +		ContextMethods,		/* m_methods */
> +		NULL,			/* m_reload */
> +		NULL,			/* m_traverse */
> +		NULL,			/* m_clear */
> +		NULL,			/* m_free */
> +	};
> +	return PyModule_Create(&moduledef);
> +}
> +#endif
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index c129e991..37fa07ec 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -11,6 +11,30 @@
>  #include "print_binary.h"
>  #include "thread_map.h"
>  
> +#if PY_MAJOR_VERSION < 3
> +#define _PyUnicode_FromString(arg) \
> +  PyString_FromString(arg)
> +#define _PyUnicode_AsString(arg) \
> +  PyString_AsString(arg)
> +#define _PyUnicode_FromFormat(...) \
> +  PyString_FromFormat(__VA_ARGS__)
> +#define _PyLong_FromLong(arg) \
> +  PyInt_FromLong(arg)
> +
> +#else
> +
> +#define _PyUnicode_FromString(arg) \
> +  PyUnicode_FromString(arg)
> +#define _PyUnicode_FromFormat(...) \
> +  PyUnicode_FromFormat(__VA_ARGS__)
> +#define _PyLong_FromLong(arg) \
> +  PyLong_FromLong(arg)
> +#endif
> +
> +#ifndef Py_TYPE
> +#define Py_TYPE(ob) (((PyObject*)(ob))->ob_type)
> +#endif
> +
>  /*
>   * Provide these two so that we don't have to link against callchain.c and
>   * start dragging hist.c, etc.
> @@ -48,7 +72,11 @@ int eprintf(int level, int var, const char *fmt, ...)
>  # define PyVarObject_HEAD_INIT(type, size) PyObject_HEAD_INIT(type) size,
>  #endif
>  
> +#if PY_MAJOR_VERSION < 3
>  PyMODINIT_FUNC initperf(void);
> +#else
> +PyMODINIT_FUNC PyInit_perf(void);
> +#endif
>  
>  #define member_def(type, member, ptype, help) \
>  	{ #member, ptype, \
> @@ -106,7 +134,7 @@ static PyObject *pyrf_mmap_event__repr(struct pyrf_event *pevent)
>  		     pevent->event.mmap.pgoff, pevent->event.mmap.filename) < 0) {
>  		ret = PyErr_NoMemory();
>  	} else {
> -		ret = PyString_FromString(s);
> +		ret = _PyUnicode_FromString(s);
>  		free(s);
>  	}
>  	return ret;
> @@ -137,7 +165,7 @@ static PyMemberDef pyrf_task_event__members[] = {
>  
>  static PyObject *pyrf_task_event__repr(struct pyrf_event *pevent)
>  {
> -	return PyString_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
> +	return _PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
>  				   "ptid: %u, time: %" PRIu64 "}",
>  				   pevent->event.header.type == PERF_RECORD_FORK ? "fork" : "exit",
>  				   pevent->event.fork.pid,
> @@ -170,7 +198,7 @@ static PyMemberDef pyrf_comm_event__members[] = {
>  
>  static PyObject *pyrf_comm_event__repr(struct pyrf_event *pevent)
>  {
> -	return PyString_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
> +	return _PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
>  				   pevent->event.comm.pid,
>  				   pevent->event.comm.tid,
>  				   pevent->event.comm.comm);
> @@ -201,7 +229,7 @@ static PyObject *pyrf_throttle_event__repr(struct pyrf_event *pevent)
>  {
>  	struct throttle_event *te = (struct throttle_event *)(&pevent->event.header + 1);
>  
> -	return PyString_FromFormat("{ type: %sthrottle, time: %" PRIu64 ", id: %" PRIu64
> +	return _PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRIu64 ", id: %" PRIu64
>  				   ", stream_id: %" PRIu64 " }",
>  				   pevent->event.header.type == PERF_RECORD_THROTTLE ? "" : "un",
>  				   te->time, te->id, te->stream_id);
> @@ -236,7 +264,7 @@ static PyObject *pyrf_lost_event__repr(struct pyrf_event *pevent)
>  		     pevent->event.lost.id, pevent->event.lost.lost) < 0) {
>  		ret = PyErr_NoMemory();
>  	} else {
> -		ret = PyString_FromString(s);
> +		ret = _PyUnicode_FromString(s);
>  		free(s);
>  	}
>  	return ret;
> @@ -263,7 +291,7 @@ static PyMemberDef pyrf_read_event__members[] = {
>  
>  static PyObject *pyrf_read_event__repr(struct pyrf_event *pevent)
>  {
> -	return PyString_FromFormat("{ type: read, pid: %u, tid: %u }",
> +	return _PyUnicode_FromFormat("{ type: read, pid: %u, tid: %u }",
>  				   pevent->event.read.pid,
>  				   pevent->event.read.tid);
>  	/*
> @@ -298,7 +326,7 @@ static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
>  	if (asprintf(&s, "{ type: sample }") < 0) {
>  		ret = PyErr_NoMemory();
>  	} else {
> -		ret = PyString_FromString(s);
> +		ret = _PyUnicode_FromString(s);
>  		free(s);
>  	}
>  	return ret;
> @@ -329,7 +357,7 @@ tracepoint_field(struct pyrf_event *pe, struct format_field *field)
>  		}
>  		if (field->flags & FIELD_IS_STRING &&
>  		    is_printable_array(data + offset, len)) {
> -			ret = PyString_FromString((char *)data + offset);
> +			ret = _PyUnicode_FromString((char *)data + offset);
>  		} else {
>  			ret = PyByteArray_FromStringAndSize((const char *) data + offset, len);
>  			field->flags &= ~FIELD_IS_STRING;
> @@ -351,7 +379,7 @@ tracepoint_field(struct pyrf_event *pe, struct format_field *field)
>  static PyObject*
>  get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
>  {
> -	const char *str = PyString_AsString(PyObject_Str(attr_name));
> +	const char *str = _PyUnicode_AsString(PyObject_Str(attr_name));
>  	struct perf_evsel *evsel = pevent->evsel;
>  	struct format_field *field;
>  
> @@ -415,7 +443,7 @@ static PyObject *pyrf_context_switch_event__repr(struct pyrf_event *pevent)
>  		     !!(pevent->event.header.misc & PERF_RECORD_MISC_SWITCH_OUT)) < 0) {
>  		ret = PyErr_NoMemory();
>  	} else {
> -		ret = PyString_FromString(s);
> +		ret = _PyUnicode_FromString(s);
>  		free(s);
>  	}
>  	return ret;
> @@ -527,7 +555,7 @@ static int pyrf_cpu_map__init(struct pyrf_cpu_map *pcpus,
>  static void pyrf_cpu_map__delete(struct pyrf_cpu_map *pcpus)
>  {
>  	cpu_map__put(pcpus->cpus);
> -	pcpus->ob_type->tp_free((PyObject*)pcpus);
> +	Py_TYPE(pcpus)->tp_free((PyObject*)pcpus);
>  }
>  
>  static Py_ssize_t pyrf_cpu_map__length(PyObject *obj)
> @@ -596,7 +624,7 @@ static int pyrf_thread_map__init(struct pyrf_thread_map *pthreads,
>  static void pyrf_thread_map__delete(struct pyrf_thread_map *pthreads)
>  {
>  	thread_map__put(pthreads->threads);
> -	pthreads->ob_type->tp_free((PyObject*)pthreads);
> +	Py_TYPE(pthreads)->tp_free((PyObject*)pthreads);
>  }
>  
>  static Py_ssize_t pyrf_thread_map__length(PyObject *obj)
> @@ -758,7 +786,7 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
>  static void pyrf_evsel__delete(struct pyrf_evsel *pevsel)
>  {
>  	perf_evsel__exit(&pevsel->evsel);
> -	pevsel->ob_type->tp_free((PyObject*)pevsel);
> +	Py_TYPE(pevsel)->tp_free((PyObject*)pevsel);
>  }
>  
>  static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
> @@ -849,7 +877,7 @@ static int pyrf_evlist__init(struct pyrf_evlist *pevlist,
>  static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
>  {
>  	perf_evlist__exit(&pevlist->evlist);
> -	pevlist->ob_type->tp_free((PyObject*)pevlist);
> +	Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
>  }
>  
>  static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
> @@ -901,12 +929,16 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
>  
>  	for (i = 0; i < evlist->pollfd.nr; ++i) {
>  		PyObject *file;
> +#if PY_MAJOR_VERSION < 3
>  		FILE *fp = fdopen(evlist->pollfd.entries[i].fd, "r");
>  
>  		if (fp == NULL)
>  			goto free_list;
>  
>  		file = PyFile_FromFile(fp, "perf", "r", NULL);
> +#else
> +		file = PyFile_FromFd(evlist->pollfd.entries[i].fd, "perf", "r", -1, NULL, NULL, NULL, 1);
> +#endif
>  		if (file == NULL)
>  			goto free_list;
>  
> @@ -1193,9 +1225,9 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
>  
>  	tp_format = trace_event__tp_format(sys, name);
>  	if (IS_ERR(tp_format))
> -		return PyInt_FromLong(-1);
> +		return _PyLong_FromLong(-1);
>  
> -	return PyInt_FromLong(tp_format->id);
> +	return _PyLong_FromLong(tp_format->id);
>  }
>  
>  static PyMethodDef perf__methods[] = {
> @@ -1208,11 +1240,31 @@ static PyMethodDef perf__methods[] = {
>  	{ .ml_name = NULL, }
>  };
>  
> +#if PY_MAJOR_VERSION < 3
>  PyMODINIT_FUNC initperf(void)
> +#else
> +PyMODINIT_FUNC PyInit_perf(void)
> +#endif
>  {
>  	PyObject *obj;
>  	int i;
> -	PyObject *dict, *module = Py_InitModule("perf", perf__methods);
> +	PyObject *dict;
> +#if PY_MAJOR_VERSION < 3
> +	PyObject *module = Py_InitModule("perf", perf__methods);
> +#else
> +	static struct PyModuleDef moduledef = {
> +		PyModuleDef_HEAD_INIT,
> +		"perf",			/* m_name */
> +		"",			/* m_doc */
> +		-1,			/* m_size */
> +		perf__methods,		/* m_methods */
> +		NULL,			/* m_reload */
> +		NULL,			/* m_traverse */
> +		NULL,			/* m_clear */
> +		NULL,			/* m_free */
> +	};
> +	PyObject *module = PyModule_Create(&moduledef);
> +#endif
>  
>  	if (module == NULL ||
>  	    pyrf_event__setup_types() < 0 ||
> @@ -1220,7 +1272,11 @@ PyMODINIT_FUNC initperf(void)
>  	    pyrf_evsel__setup_types() < 0 ||
>  	    pyrf_thread_map__setup_types() < 0 ||
>  	    pyrf_cpu_map__setup_types() < 0)
> +#if PY_MAJOR_VERSION < 3
>  		return;
> +#else
> +		return module;
> +#endif
>  
>  	/* The page_size is placed in util object. */
>  	page_size = sysconf(_SC_PAGE_SIZE);
> @@ -1269,7 +1325,7 @@ PyMODINIT_FUNC initperf(void)
>  		goto error;
>  
>  	for (i = 0; perf__constants[i].name != NULL; i++) {
> -		obj = PyInt_FromLong(perf__constants[i].value);
> +		obj = _PyLong_FromLong(perf__constants[i].value);
>  		if (obj == NULL)
>  			goto error;
>  		PyDict_SetItemString(dict, perf__constants[i].name, obj);
> @@ -1279,6 +1335,9 @@ PyMODINIT_FUNC initperf(void)
>  error:
>  	if (PyErr_Occurred())
>  		PyErr_SetString(PyExc_ImportError, "perf: Init failed!");
> +#if PY_MAJOR_VERSION >= 3
> +	return module;
> +#endif
>  }
>  
>  /*
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index c7187f06..3a868834 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -50,7 +50,37 @@
>  #include "print_binary.h"
>  #include "stat.h"
>  
> +#if PY_MAJOR_VERSION < 3
> +#define _PyUnicode_FromString(arg) \
> +  PyString_FromString(arg)
> +#define _PyUnicode_FromStringAndSize(arg1, arg2) \
> +  PyString_FromStringAndSize((arg1), (arg2))
> +#define _PyBytes_FromStringAndSize(arg1, arg2) \
> +  PyString_FromStringAndSize((arg1), (arg2))
> +#define _PyLong_FromLong(arg) \
> +  PyInt_FromLong(arg)
> +#define _PyLong_AsLong(arg) \
> +  PyInt_AsLong(arg)
> +#define _PyCapsule_New(arg1, arg2, arg3) \
> +  PyCObject_FromVoidPtr((arg1), (arg2))
> +
>  PyMODINIT_FUNC initperf_trace_context(void);
> +#else
> +#define _PyUnicode_FromString(arg) \
> +  PyUnicode_FromString(arg)
> +#define _PyUnicode_FromStringAndSize(arg1, arg2) \
> +  PyUnicode_FromStringAndSize((arg1), (arg2))
> +#define _PyBytes_FromStringAndSize(arg1, arg2) \
> +  PyBytes_FromStringAndSize((arg1), (arg2))
> +#define _PyLong_FromLong(arg) \
> +  PyLong_FromLong(arg)
> +#define _PyLong_AsLong(arg) \
> +  PyLong_AsLong(arg)
> +#define _PyCapsule_New(arg1, arg2, arg3) \
> +  PyCapsule_New((arg1), (arg2), (arg3))
> +
> +PyMODINIT_FUNC PyInit_perf_trace_context(void);
> +#endif
>  
>  #define TRACE_EVENT_TYPE_MAX				\
>  	((1 << (sizeof(unsigned short) * 8)) - 1)
> @@ -136,7 +166,7 @@ static int get_argument_count(PyObject *handler)
>  		PyObject *arg_count_obj = PyObject_GetAttrString(code_obj,
>  			"co_argcount");
>  		if (arg_count_obj) {
> -			arg_count = (int) PyInt_AsLong(arg_count_obj);
> +			arg_count = (int) _PyLong_AsLong(arg_count_obj);
>  			Py_DECREF(arg_count_obj);
>  		}
>  		Py_DECREF(code_obj);
> @@ -183,10 +213,10 @@ static void define_value(enum print_arg_type field_type,
>  
>  	value = eval_flag(field_value);
>  
> -	PyTuple_SetItem(t, n++, PyString_FromString(ev_name));
> -	PyTuple_SetItem(t, n++, PyString_FromString(field_name));
> -	PyTuple_SetItem(t, n++, PyInt_FromLong(value));
> -	PyTuple_SetItem(t, n++, PyString_FromString(field_str));
> +	PyTuple_SetItem(t, n++, _PyUnicode_FromString(ev_name));
> +	PyTuple_SetItem(t, n++, _PyUnicode_FromString(field_name));
> +	PyTuple_SetItem(t, n++, _PyLong_FromLong(value));
> +	PyTuple_SetItem(t, n++, _PyUnicode_FromString(field_str));
>  
>  	try_call_object(handler_name, t);
>  
> @@ -224,10 +254,10 @@ static void define_field(enum print_arg_type field_type,
>  	if (!t)
>  		Py_FatalError("couldn't create Python tuple");
>  
> -	PyTuple_SetItem(t, n++, PyString_FromString(ev_name));
> -	PyTuple_SetItem(t, n++, PyString_FromString(field_name));
> +	PyTuple_SetItem(t, n++, _PyUnicode_FromString(ev_name));
> +	PyTuple_SetItem(t, n++, _PyUnicode_FromString(field_name));
>  	if (field_type == PRINT_FLAGS)
> -		PyTuple_SetItem(t, n++, PyString_FromString(delim));
> +		PyTuple_SetItem(t, n++, _PyUnicode_FromString(delim));
>  
>  	try_call_object(handler_name, t);
>  
> @@ -326,12 +356,12 @@ static PyObject *get_field_numeric_entry(struct event_format *event,
>  		if (field->flags & FIELD_IS_SIGNED) {
>  			if ((long long)val >= LONG_MIN &&
>  					(long long)val <= LONG_MAX)
> -				obj = PyInt_FromLong(val);
> +				obj = _PyLong_FromLong(val);
>  			else
>  				obj = PyLong_FromLongLong(val);
>  		} else {
>  			if (val <= LONG_MAX)
> -				obj = PyInt_FromLong(val);
> +				obj = _PyLong_FromLong(val);
>  			else
>  				obj = PyLong_FromUnsignedLongLong(val);
>  		}
> @@ -390,9 +420,9 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
>  			pydict_set_item_string_decref(pysym, "end",
>  					PyLong_FromUnsignedLongLong(node->sym->end));
>  			pydict_set_item_string_decref(pysym, "binding",
> -					PyInt_FromLong(node->sym->binding));
> +					_PyLong_FromLong(node->sym->binding));
>  			pydict_set_item_string_decref(pysym, "name",
> -					PyString_FromStringAndSize(node->sym->name,
> +					_PyUnicode_FromStringAndSize(node->sym->name,
>  							node->sym->namelen));
>  			pydict_set_item_string_decref(pyelem, "sym", pysym);
>  		}
> @@ -407,7 +437,7 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
>  					dsoname = map->dso->name;
>  			}
>  			pydict_set_item_string_decref(pyelem, "dso",
> -					PyString_FromString(dsoname));
> +					_PyUnicode_FromString(dsoname));
>  		}
>  
>  		callchain_cursor_advance(&callchain_cursor);
> @@ -484,16 +514,16 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  	if (!dict_sample)
>  		Py_FatalError("couldn't create Python dictionary");
>  
> -	pydict_set_item_string_decref(dict, "ev_name", PyString_FromString(perf_evsel__name(evsel)));
> -	pydict_set_item_string_decref(dict, "attr", PyString_FromStringAndSize(
> +	pydict_set_item_string_decref(dict, "ev_name", _PyUnicode_FromString(perf_evsel__name(evsel)));
> +	pydict_set_item_string_decref(dict, "attr", _PyUnicode_FromStringAndSize(
>  			(const char *)&evsel->attr, sizeof(evsel->attr)));
>  
>  	pydict_set_item_string_decref(dict_sample, "pid",
> -			PyInt_FromLong(sample->pid));
> +			_PyLong_FromLong(sample->pid));
>  	pydict_set_item_string_decref(dict_sample, "tid",
> -			PyInt_FromLong(sample->tid));
> +			_PyLong_FromLong(sample->tid));
>  	pydict_set_item_string_decref(dict_sample, "cpu",
> -			PyInt_FromLong(sample->cpu));
> +			_PyLong_FromLong(sample->cpu));
>  	pydict_set_item_string_decref(dict_sample, "ip",
>  			PyLong_FromUnsignedLongLong(sample->ip));
>  	pydict_set_item_string_decref(dict_sample, "time",
> @@ -503,17 +533,17 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  	set_sample_read_in_dict(dict_sample, sample, evsel);
>  	pydict_set_item_string_decref(dict, "sample", dict_sample);
>  
> -	pydict_set_item_string_decref(dict, "raw_buf", PyString_FromStringAndSize(
> +	pydict_set_item_string_decref(dict, "raw_buf", _PyBytes_FromStringAndSize(
>  			(const char *)sample->raw_data, sample->raw_size));
>  	pydict_set_item_string_decref(dict, "comm",
> -			PyString_FromString(thread__comm_str(al->thread)));
> +			_PyUnicode_FromString(thread__comm_str(al->thread)));
>  	if (al->map) {
>  		pydict_set_item_string_decref(dict, "dso",
> -			PyString_FromString(al->map->dso->name));
> +			_PyUnicode_FromString(al->map->dso->name));
>  	}
>  	if (al->sym) {
>  		pydict_set_item_string_decref(dict, "symbol",
> -			PyString_FromString(al->sym->name));
> +			_PyUnicode_FromString(al->sym->name));
>  	}
>  
>  	pydict_set_item_string_decref(dict, "callchain", callchain);
> @@ -573,9 +603,9 @@ static void python_process_tracepoint(struct perf_sample *sample,
>  	scripting_context->event_data = data;
>  	scripting_context->pevent = evsel->tp_format->pevent;
>  
> -	context = PyCObject_FromVoidPtr(scripting_context, NULL);
> +	context = _PyCapsule_New(scripting_context, NULL, NULL);
>  
> -	PyTuple_SetItem(t, n++, PyString_FromString(handler_name));
> +	PyTuple_SetItem(t, n++, _PyUnicode_FromString(handler_name));
>  	PyTuple_SetItem(t, n++, context);
>  
>  	/* ip unwinding */
> @@ -584,18 +614,18 @@ static void python_process_tracepoint(struct perf_sample *sample,
>  	Py_INCREF(callchain);
>  
>  	if (!dict) {
> -		PyTuple_SetItem(t, n++, PyInt_FromLong(cpu));
> -		PyTuple_SetItem(t, n++, PyInt_FromLong(s));
> -		PyTuple_SetItem(t, n++, PyInt_FromLong(ns));
> -		PyTuple_SetItem(t, n++, PyInt_FromLong(pid));
> -		PyTuple_SetItem(t, n++, PyString_FromString(comm));
> +		PyTuple_SetItem(t, n++, _PyLong_FromLong(cpu));
> +		PyTuple_SetItem(t, n++, _PyLong_FromLong(s));
> +		PyTuple_SetItem(t, n++, _PyLong_FromLong(ns));
> +		PyTuple_SetItem(t, n++, _PyLong_FromLong(pid));
> +		PyTuple_SetItem(t, n++, _PyUnicode_FromString(comm));
>  		PyTuple_SetItem(t, n++, callchain);
>  	} else {
> -		pydict_set_item_string_decref(dict, "common_cpu", PyInt_FromLong(cpu));
> -		pydict_set_item_string_decref(dict, "common_s", PyInt_FromLong(s));
> -		pydict_set_item_string_decref(dict, "common_ns", PyInt_FromLong(ns));
> -		pydict_set_item_string_decref(dict, "common_pid", PyInt_FromLong(pid));
> -		pydict_set_item_string_decref(dict, "common_comm", PyString_FromString(comm));
> +		pydict_set_item_string_decref(dict, "common_cpu", _PyLong_FromLong(cpu));
> +		pydict_set_item_string_decref(dict, "common_s", _PyLong_FromLong(s));
> +		pydict_set_item_string_decref(dict, "common_ns", _PyLong_FromLong(ns));
> +		pydict_set_item_string_decref(dict, "common_pid", _PyLong_FromLong(pid));
> +		pydict_set_item_string_decref(dict, "common_comm", _PyUnicode_FromString(comm));
>  		pydict_set_item_string_decref(dict, "common_callchain", callchain);
>  	}
>  	for (field = event->format.fields; field; field = field->next) {
> @@ -614,7 +644,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
>  			}
>  			if (field->flags & FIELD_IS_STRING &&
>  			    is_printable_array(data + offset, len)) {
> -				obj = PyString_FromString((char *) data + offset);
> +				obj = _PyUnicode_FromString((char *) data + offset);
>  			} else {
>  				obj = PyByteArray_FromStringAndSize((const char *) data + offset, len);
>  				field->flags &= ~FIELD_IS_STRING;
> @@ -667,7 +697,7 @@ static PyObject *tuple_new(unsigned int sz)
>  static int tuple_set_u64(PyObject *t, unsigned int pos, u64 val)
>  {
>  #if BITS_PER_LONG == 64
> -	return PyTuple_SetItem(t, pos, PyInt_FromLong(val));
> +	return PyTuple_SetItem(t, pos, _PyLong_FromLong(val));
>  #endif
>  #if BITS_PER_LONG == 32
>  	return PyTuple_SetItem(t, pos, PyLong_FromLongLong(val));
> @@ -676,12 +706,12 @@ static int tuple_set_u64(PyObject *t, unsigned int pos, u64 val)
>  
>  static int tuple_set_s32(PyObject *t, unsigned int pos, s32 val)
>  {
> -	return PyTuple_SetItem(t, pos, PyInt_FromLong(val));
> +	return PyTuple_SetItem(t, pos, _PyLong_FromLong(val));
>  }
>  
>  static int tuple_set_string(PyObject *t, unsigned int pos, const char *s)
>  {
> -	return PyTuple_SetItem(t, pos, PyString_FromString(s));
> +	return PyTuple_SetItem(t, pos, _PyUnicode_FromString(s));
>  }
>  
>  static int python_export_evsel(struct db_export *dbe, struct perf_evsel *evsel)
> @@ -1028,8 +1058,8 @@ process_stat(struct perf_evsel *counter, int cpu, int thread, u64 tstamp,
>  		return;
>  	}
>  
> -	PyTuple_SetItem(t, n++, PyInt_FromLong(cpu));
> -	PyTuple_SetItem(t, n++, PyInt_FromLong(thread));
> +	PyTuple_SetItem(t, n++, _PyLong_FromLong(cpu));
> +	PyTuple_SetItem(t, n++, _PyLong_FromLong(thread));
>  
>  	tuple_set_u64(t, n++, tstamp);
>  	tuple_set_u64(t, n++, count->val);
> @@ -1211,27 +1241,58 @@ static void set_table_handlers(struct tables *tables)
>  	SET_TABLE_HANDLER(call_return);
>  }
>  
> +#if PY_MAJOR_VERSION < 3
> +static void _free_command_line(const char **command_line, int num)
> +{
> +	free(command_line);
> +}
> +#else
> +static void _free_command_line(wchar_t **command_line, int num)
> +{
> +	int i;
> +	for (i = 0; i < num; i++)
> +		PyMem_RawFree(command_line[i]);
> +	free(command_line);
> +}
> +#endif
> +
> +
>  /*
>   * Start trace script
>   */
>  static int python_start_script(const char *script, int argc, const char **argv)
>  {
>  	struct tables *tables = &tables_global;
> +#if PY_MAJOR_VERSION < 3
>  	const char **command_line;
> +#else
> +	wchar_t **command_line;
> +#endif
>  	char buf[PATH_MAX];
>  	int i, err = 0;
>  	FILE *fp;
>  
> +#if PY_MAJOR_VERSION < 3
>  	command_line = malloc((argc + 1) * sizeof(const char *));
>  	command_line[0] = script;
>  	for (i = 1; i < argc + 1; i++)
>  		command_line[i] = argv[i - 1];
> +#else
> +	command_line = malloc((argc + 1) * sizeof(wchar_t *));
> +	command_line[0] = Py_DecodeLocale(script, NULL);
> +	for (i = 1; i < argc + 1; i++)
> +		command_line[i] = Py_DecodeLocale(argv[i - 1], NULL);
> +#endif
>  
>  	Py_Initialize();
>  
> +#if PY_MAJOR_VERSION < 3
>  	initperf_trace_context();
> -
>  	PySys_SetArgv(argc + 1, (char **)command_line);
> +#else
> +	PyInit_perf_trace_context();
> +	PySys_SetArgv(argc + 1, command_line);
> +#endif
>  
>  	fp = fopen(script, "r");
>  	if (!fp) {
> @@ -1261,12 +1322,12 @@ static int python_start_script(const char *script, int argc, const char **argv)
>  			goto error;
>  	}
>  
> -	free(command_line);
> +	_free_command_line(command_line, argc + 1);
>  
>  	return err;
>  error:
>  	Py_Finalize();
> -	free(command_line);
> +	_free_command_line(command_line, argc + 1);
>  
>  	return err;
>  }
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index af415feb..6891635b 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python2
> +#!/usr/bin/python
>  
>  from os import getenv
>  
> @@ -35,11 +35,11 @@ build_tmp = getenv('PYTHON_EXTBUILD_TMP')
>  libtraceevent = getenv('LIBTRACEEVENT')
>  libapikfs = getenv('LIBAPI')
>  
> -ext_sources = [f.strip() for f in file('util/python-ext-sources')
> +ext_sources = [f.strip() for f in open('util/python-ext-sources')
>  				if len(f.strip()) > 0 and f[0] != '#']
>  
>  # use full paths with source files
> -ext_sources = map(lambda x: '%s/%s' % (src_perf, x) , ext_sources)
> +ext_sources = list(map(lambda x: '%s/%s' % (src_perf, x) , ext_sources))
>  
>  perf = Extension('perf',
>  		  sources = ext_sources,
> -- 
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
