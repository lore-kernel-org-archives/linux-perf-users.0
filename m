Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADC74C6EE7
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217932; cv=none; b=U9mZduOyetwHlvbwq7XZiDVsp4zzc0XzkLkI/qIVGtrSb2iiWHKMEibVoZhQjBMwPzGPFHX0El7wIEsOND3cbizrA/YKhvQvAKgEO8rvNRu/aw2kJ254tDakG5Z8t3mgfd4wKcx+QYiBxgXd6frpVr8DstY0Tnag8UD5PaHgciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217932; c=relaxed/simple;
	bh=y3zOoPQp4XuyTQYdgm5I3apXe7TX3zqtShC4yqOl/5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JDV5Al4eXe3PM7N9bOZillXfNqq5Kw3x0U8e0XKggdEJEw1Uuv8TMuEEhZpNt2Aqubm8PzhaRMogGJgqHh3rTmmui9UC2qnjRk7MUrzwINPPQVIioe2mvaMHL51KQogzGUIah0LgoRY6SZFwyDi6CmgiYcVkd75iRE/msgU7qek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SO8+b8jp; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SO8+b8jp"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304d0d0b28eso1195265eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781217929; x=1781822729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qS1O8SCcDXoGU/lPSCheBvmch/d7eU47Lc6w6op5Hpo=;
        b=SO8+b8jpFn8H0kByNyl/nZIkZAxq+AK7htUy4clRhDyKYlyn9R+C2Y+jb8UTUG1rca
         FAAvk9exAmPozVvOUf01C238Ln7MX1jWsxKWw6puJSfyrBwITDMWkueONG+LWFu98zuq
         3bDKgFSc4gnY1AJRv7VXrcko9PR6dMd2xWzPKGOc3p7sf78Bk2erEFwva7FwIIuX2fN8
         wkcKLqrgFir32QBuVdIn2fCdXhm1dtkMD8tvH1NGd7p3rXv9gqn+HglIxP1GenMSNeI9
         qWa3aFWeuFyjFCKs5EOOguYgSgP3oAjoJZRRh1r+lDZMhGjvsls5RmzYcYQDtoVaVz3H
         WVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217929; x=1781822729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qS1O8SCcDXoGU/lPSCheBvmch/d7eU47Lc6w6op5Hpo=;
        b=FhOWw5XDCg3ajnBS58TxRyrVO/I4Z9TG+Rl5t4otBuqS3ohr1Pei0AqPuxQjP2Dbku
         vQkTAMa9dm+x5BQHd55B5CYmhe3Hg0G9N/1lmJFUDn9sBNJrNcsGTnOWQwO1yvFhPMk/
         kP3+XFPdHihhjPSaP1SpCTW3GSmNvu5/mtvJ5o/0naisTyC235dz+bnSz7jYbaFRyHiC
         lHv5gn/CRQfYRujFVmQinsX4V668b4yDhjLXG6wuN6Ahit8RbTSFFbOHAyTvENQ0UymZ
         HttHbpRa3tZ51/mjL7Lk+0eS89tu3+4jUrSLP9diMOSeOdadv6UTtBIt2evsxNsGpE0y
         c8wA==
X-Forwarded-Encrypted: i=1; AFNElJ94JRgKHEns787cnyJiq4+eqLR2P7LQaBBuzJlxU04+S3iJs3f212VrSHMTsxuTC4DLDEIS5JXAaa5T/y32D34t@vger.kernel.org
X-Gm-Message-State: AOJu0YzzwLUUZ2M3vhTDW/S6bpmAAe7mC4iuJ7Bne7j4lxCYfo08bv+T
	ZJZgjQRgawbRBqTAVXxCLBsGBf4JJGV/P2M1+MsJ77nqEpuj8HDdELEG1PT9k7NImaggv8LQF4o
	1UHUBsvRfTA==
X-Received: from dybnb15.prod.google.com ([2002:a05:7300:cc8f:b0:304:4f23:4977])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c15:b0:304:c651:bdfe
 with SMTP id 5a478bee46e88-30820098f0bmr204367eec.17.1781217928943; Thu, 11
 Jun 2026 15:45:28 -0700 (PDT)
Date: Thu, 11 Jun 2026 15:44:50 -0700
In-Reply-To: <20260611224455.201994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611171756.4008769-1-irogers@google.com> <20260611224455.201994-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611224455.201994-15-irogers@google.com>
Subject: [PATCH v13 14/19] perf python: Extend API for stat events in python.c
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add stat information to the session. Add call backs for stat events.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v12:
 - Made `psession->tool.stat = perf_event__process_stat_event;` conditional on `!stat` so it doesn't unconditionally overwrite user stat callbacks.

v5:
1. Fix Memory Corruption: Corrected the memory offset for `stat_round_type`
   in `pyrf_stat_round_event__members` by adding the base offset of
   `struct pyrf_event`.
2. Fix Memory Leak: Added `Py_XDECREF()` to free the unused return value
   of the Python callback in `pyrf_session_tool__stat_round()`.

---
v7:
- Added comprehensive size checks in pyrf_event__new for all event
  types.
- Fixed line length warning.

v10:
- Added CHECK_INITIALIZED check to pyrf_evsel__get_ids to prevent
  NULL pointer dereference on uninitialized evsel objects.
---
 tools/perf/util/python.c | 188 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 536755593eff..16e415bd4a16 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -459,6 +459,77 @@ static PyTypeObject pyrf_lost_event__type = {
 	.tp_repr	= (reprfunc)pyrf_lost_event__repr,
 };
 
+static const char pyrf_stat_event__doc[] = PyDoc_STR("perf stat event object.");
+
+static PyMemberDef pyrf_stat_event__members[] = {
+	sample_members
+	member_def(perf_event_header, type, T_UINT, "event type"),
+	member_def(perf_record_stat, id, T_ULONGLONG, "event id"),
+	member_def(perf_record_stat, cpu, T_UINT, "event cpu"),
+	member_def(perf_record_stat, thread, T_UINT, "event thread"),
+	member_def(perf_record_stat, val, T_ULONGLONG, "counter value"),
+	member_def(perf_record_stat, ena, T_ULONGLONG, "enabled time"),
+	member_def(perf_record_stat, run, T_ULONGLONG, "running time"),
+	{ .name = NULL, },
+};
+
+static PyObject *pyrf_stat_event__repr(const struct pyrf_event *pevent)
+{
+	return PyUnicode_FromFormat(
+		"{ type: stat, id: %llu, cpu: %u, thread: %u, val: %llu, ena: %llu, run: %llu }",
+		pevent->event.stat.id,
+		pevent->event.stat.cpu,
+		pevent->event.stat.thread,
+		pevent->event.stat.val,
+		pevent->event.stat.ena,
+		pevent->event.stat.run);
+}
+
+static PyTypeObject pyrf_stat_event__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.stat_event",
+	.tp_basicsize	= sizeof(struct pyrf_event),
+	.tp_new		= PyType_GenericNew,
+	.tp_dealloc	= (destructor)pyrf_event__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= pyrf_stat_event__doc,
+	.tp_members	= pyrf_stat_event__members,
+	.tp_getset	= pyrf_event__getset,
+	.tp_repr	= (reprfunc)pyrf_stat_event__repr,
+};
+
+static const char pyrf_stat_round_event__doc[] = PyDoc_STR("perf stat round event object.");
+
+static PyMemberDef pyrf_stat_round_event__members[] = {
+	sample_members
+	member_def(perf_event_header, type, T_UINT, "event type"),
+	{ .name = "stat_round_type", .type = T_ULONGLONG,
+	  .offset = offsetof(struct pyrf_event, event) + offsetof(struct perf_record_stat_round, type),
+	  .doc = "round type" },
+	member_def(perf_record_stat_round, time, T_ULONGLONG, "round time"),
+	{ .name = NULL, },
+};
+
+static PyObject *pyrf_stat_round_event__repr(const struct pyrf_event *pevent)
+{
+	return PyUnicode_FromFormat("{ type: stat_round, type: %llu, time: %llu }",
+				   pevent->event.stat_round.type,
+				   pevent->event.stat_round.time);
+}
+
+static PyTypeObject pyrf_stat_round_event__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.stat_round_event",
+	.tp_basicsize	= sizeof(struct pyrf_event),
+	.tp_new		= PyType_GenericNew,
+	.tp_dealloc	= (destructor)pyrf_event__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= pyrf_stat_round_event__doc,
+	.tp_members	= pyrf_stat_round_event__members,
+	.tp_getset	= pyrf_event__getset,
+	.tp_repr	= (reprfunc)pyrf_stat_round_event__repr,
+};
+
 static const char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
 
 static PyMemberDef pyrf_read_event__members[] = {
@@ -1113,6 +1184,12 @@ static int pyrf_event__setup_types(void)
 	if (err < 0)
 		goto out;
 	err = PyType_Ready(&pyrf_context_switch_event__type);
+	if (err < 0)
+		goto out;
+	err = PyType_Ready(&pyrf_stat_event__type);
+	if (err < 0)
+		goto out;
+	err = PyType_Ready(&pyrf_stat_round_event__type);
 	if (err < 0)
 		goto out;
 	err = PyType_Ready(&pyrf_callchain_node__type);
@@ -1138,6 +1215,8 @@ static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_SAMPLE]	 = &pyrf_sample_event__type,
 	[PERF_RECORD_SWITCH]	 = &pyrf_context_switch_event__type,
 	[PERF_RECORD_SWITCH_CPU_WIDE]  = &pyrf_context_switch_event__type,
+	[PERF_RECORD_STAT]	 = &pyrf_stat_event__type,
+	[PERF_RECORD_STAT_ROUND] = &pyrf_stat_round_event__type,
 };
 
 static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *evsel,
@@ -2136,7 +2215,45 @@ static PyObject *pyrf_evsel__get_attr_wakeup_events(PyObject *self, void */*clos
 	return PyLong_FromUnsignedLong(pevsel->evsel->core.attr.wakeup_events);
 }
 
+static PyObject *pyrf_evsel__get_ids(struct pyrf_evsel *pevsel, void *closure __maybe_unused)
+{
+	struct evsel *evsel;
+	PyObject *list;
+
+	CHECK_INITIALIZED(pevsel->evsel, "evsel");
+
+	evsel = pevsel->evsel;
+	list = PyList_New(0);
+
+	if (!list)
+		return NULL;
+
+	for (u32 i = 0; i < evsel->core.ids; i++) {
+		PyObject *id = PyLong_FromUnsignedLongLong(evsel->core.id[i]);
+		int ret;
+
+		if (!id) {
+			Py_DECREF(list);
+			return NULL;
+		}
+		ret = PyList_Append(list, id);
+		Py_DECREF(id);
+		if (ret < 0) {
+			Py_DECREF(list);
+			return NULL;
+		}
+	}
+
+	return list;
+}
+
 static PyGetSetDef pyrf_evsel__getset[] = {
+	{
+		.name = "ids",
+		.get = (getter)pyrf_evsel__get_ids,
+		.set = NULL,
+		.doc = "event IDs.",
+	},
 	{
 		.name = "tracking",
 		.get = pyrf_evsel__get_tracking,
@@ -2984,6 +3101,8 @@ static const struct perf_constant perf__constants[] = {
 	PERF_CONST(RECORD_LOST_SAMPLES),
 	PERF_CONST(RECORD_SWITCH),
 	PERF_CONST(RECORD_SWITCH_CPU_WIDE),
+	PERF_CONST(RECORD_STAT),
+	PERF_CONST(RECORD_STAT_ROUND),
 
 	PERF_CONST(RECORD_MISC_SWITCH_OUT),
 	{ .name = NULL, },
@@ -3379,6 +3498,7 @@ struct pyrf_session {
 	struct perf_tool tool;
 	struct pyrf_data *pdata;
 	PyObject *sample;
+	PyObject *stat;
 };
 
 static int pyrf_session_tool__sample(const struct perf_tool *tool,
@@ -3403,6 +3523,50 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
 	return 0;
 }
 
+static int pyrf_session_tool__stat(const struct perf_tool *tool,
+				   struct perf_session *session,
+				   union perf_event *event)
+{
+	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
+	struct evsel *evsel = evlist__id2evsel(session->evlist, event->stat.id);
+	PyObject *pyevent = pyrf_event__new(event, evsel, psession->session, /*machine=*/NULL);
+	const char *name = evsel ? evsel__name(evsel) : "unknown";
+	PyObject *ret;
+
+	if (pyevent == NULL)
+		return -ENOMEM;
+
+	ret = PyObject_CallFunction(psession->stat, "Oz", pyevent, name);
+	if (!ret) {
+		Py_DECREF(pyevent);
+		return -1;
+	}
+	Py_DECREF(ret);
+	Py_DECREF(pyevent);
+	return 0;
+}
+
+static int pyrf_session_tool__stat_round(const struct perf_tool *tool,
+					 struct perf_session *session __maybe_unused,
+					 union perf_event *event)
+{
+	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
+	PyObject *pyevent = pyrf_event__new(event, /*evsel=*/NULL, psession->session, /*machine=*/NULL);
+	PyObject *ret;
+
+	if (pyevent == NULL)
+		return -ENOMEM;
+
+	ret = PyObject_CallFunction(psession->stat, "Oz", pyevent, NULL);
+	if (!ret) {
+		Py_DECREF(pyevent);
+		return -1;
+	}
+	Py_DECREF(ret);
+	Py_DECREF(pyevent);
+	return 0;
+}
+
 static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObject *args)
 {
 	struct machine *machine;
@@ -3436,13 +3600,13 @@ static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObje
 static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject *kwargs)
 {
 	struct pyrf_data *pdata;
-	PyObject *sample = NULL;
-	static char *kwlist[] = { "data", "sample", NULL };
+	PyObject *sample = NULL, *stat = NULL;
+	static char *kwlist[] = { "data", "sample", "stat", NULL };
 	struct pyrf_session *psession;
 	struct perf_session *session;
 
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O!|O", kwlist, &pyrf_data__type, &pdata,
-					 &sample))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O!|OO", kwlist, &pyrf_data__type, &pdata,
+					 &sample, &stat))
 		return NULL;
 
 	psession = PyObject_New(struct pyrf_session, type);
@@ -3451,6 +3615,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 
 	psession->session = NULL;
 	psession->sample = NULL;
+	psession->stat = NULL;
 	psession->pdata = NULL;
 
 	Py_INCREF(pdata);
@@ -3473,8 +3638,13 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	} while (0)
 
 	ADD_TOOL(sample);
+	ADD_TOOL(stat);
 	#undef ADD_TOOL
 
+	if (stat)
+		psession->tool.stat_round = pyrf_session_tool__stat_round;
+
+
 	psession->tool.comm		= perf_event__process_comm;
 	psession->tool.mmap		= perf_event__process_mmap;
 	psession->tool.mmap2            = perf_event__process_mmap2;
@@ -3487,7 +3657,8 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	psession->tool.build_id         = perf_event__process_build_id;
 	psession->tool.attr		= perf_event__process_attr;
 	psession->tool.feature		= perf_event__process_feature;
-	psession->tool.stat		= perf_event__process_stat_event;
+	if (!stat)
+		psession->tool.stat	= perf_event__process_stat_event;
 	session = perf_session__new(&pdata->data, &psession->tool);
 	if (IS_ERR(session)) {
 		PyErr_Format(PyExc_IOError, "failed to create session: %ld", PTR_ERR(session));
@@ -3517,6 +3688,7 @@ static void pyrf_session__delete(struct pyrf_session *psession)
 	perf_session__delete(psession->session);
 	Py_XDECREF(psession->pdata);
 	Py_XDECREF(psession->sample);
+	Py_XDECREF(psession->stat);
 	Py_TYPE(psession)->tp_free((PyObject *)psession);
 }
 
@@ -3704,6 +3876,12 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_context_switch_event__type);
 	PyModule_AddObject(module, "switch_event", (PyObject *)&pyrf_context_switch_event__type);
 
+	Py_INCREF(&pyrf_stat_event__type);
+	PyModule_AddObject(module, "stat_event", (PyObject *)&pyrf_stat_event__type);
+
+	Py_INCREF(&pyrf_stat_round_event__type);
+	PyModule_AddObject(module, "stat_round_event", (PyObject *)&pyrf_stat_round_event__type);
+
 	Py_INCREF(&pyrf_thread_map__type);
 	PyModule_AddObject(module, "thread_map", (PyObject*)&pyrf_thread_map__type);
 
-- 
2.54.0.1136.gdb2ca164c4-goog

