Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458293C9ED6
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 07:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781334703; cv=none; b=W8UlSa4TRod0JPpPsLqJwBOEsWdJZOheByFhNGeDrUKqX0itGnIZsClTDawMG76Q1drI1z/c5ax9G4xsO3rM27WiEdktCDndHsnAXF0xFkFdlGXPcjmuqV7i3xxwZv+bbgR2FLpdInXgtxvzZyoK75c7yB2Hx4kicH3+vk00Hw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781334703; c=relaxed/simple;
	bh=9wtVqzyZ5ynfHntoepls5VjHW+CLfbdZI6XuAfAmD+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mDXtfnTatvFP0Qwiiw+cP4YzTFr7/PT8ZksvEp6TbOvuOKpd4FCu742b6df2sakv/HlX2sI/Qr9O+NjPi4AigrKjOXLMfV+XQZbKo7H89U09XbgZyag8zGpaoh0ArU1E/p9sV73K9dcweEF7/THrWCanxXuyw25+v/JKoX0DFYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YbRTF+Cj; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YbRTF+Cj"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304d2447962so1960192eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 00:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781334693; x=1781939493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zI5bkj2P593OQc9zIdtRqfKAKiOa9bKtKhtzDqsacUE=;
        b=YbRTF+CjBu4Zp9KP5KRtlKOOqPfbLBUHss3R/zsZFZc35lo5w0fw/97oV5CU7vH9iG
         xRKIUKnbVMyDWAfgiPS/+Goh5ahG1IHWVng12khXvqmh02lNKnHWuescuTuYZm+NnyiT
         PrqGrwvJXHlqMqtkfey32gq3iHATSU5P+VcStbP6F+x/QGME6rAhz9jMirq5SglizAoT
         UIZst3ZVwPcQN7GAAcyc9xf69DloW+kFCf4z77rOhMpvx0eIMYgQRJp1dZEPbBZj0kbQ
         Zcbz5gNeKKmOPRgTUM4qSu7zImPD224HbI9f7T5Cb+opWOzQrp5HT60++V1xTVHdVVkB
         st8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781334693; x=1781939493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zI5bkj2P593OQc9zIdtRqfKAKiOa9bKtKhtzDqsacUE=;
        b=qI++GYON8GGCJxznFl4NcWu8viX2jDrHJr0K45wCjC+vavIjHcWgbfdxxbTLw4lGnd
         umZoPgdwtITnW+fS2oboMOxI9JguLNTnrGRAOJgKwv47JUGupUYqN1v8BGlqOmxDR0c6
         hy/DHc8VmFNTSvNQyTmWObAKgINZ7dt3Bj0OE9qK1NHj2xcZfHJlpnsSalorZiFoxy/9
         N2rOLVeZpC2RdoM6Zaf/E4C39wumsJzytz4OKRMQIkv/I3T4hNivtNeisxIHDboKIm7d
         lMmj7rOQp7DwF160flB1IpuB41m0DJeAEn3MQDTspJyO0KUP9UogTbf1ig2/JtRbD/6q
         zRZg==
X-Forwarded-Encrypted: i=1; AFNElJ9UTVUkEcHq6yBFoeJkeyJqfljqg54+AY9QIeQNY6FJ5suvnRYTMfwmGCi3bf+326UYVRvjsrW9JdO9zI78ZLNf@vger.kernel.org
X-Gm-Message-State: AOJu0YwJr0gvFSej9LEBtHT7Gl0W5t7kB1+TR8bgWH4aDoHBpPlsKstb
	wqQurK65v//sAoC6Xt+ThwIUO8NXCRdV+bRGYu4VFnidvpthaNb92wKfrAF0v41lwQH+oFKEAnG
	VIS+VOSwHPw==
X-Received: from dlep13.prod.google.com ([2002:a05:701b:458d:b0:139:734a:2b18])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:485:b0:136:c2fa:32d6
 with SMTP id a92af1059eb24-1384bffb32amr2264943c88.7.1781334692776; Sat, 13
 Jun 2026 00:11:32 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:10:54 -0700
In-Reply-To: <20260613071100.1508192-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613052722.1424093-1-irogers@google.com> <20260613071100.1508192-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613071100.1508192-15-irogers@google.com>
Subject: [PATCH v17 14/20] perf python: Extend API for stat events in python.c
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
 tools/perf/util/python.c | 187 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 182 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 3710e68a89e0..9dfd0848e7a5 100644
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
@@ -2127,7 +2206,45 @@ static PyObject *pyrf_evsel__get_attr_wakeup_events(PyObject *self, void *closur
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
@@ -2979,6 +3096,8 @@ static const struct perf_constant perf__constants[] = {
 	PERF_CONST(RECORD_LOST_SAMPLES),
 	PERF_CONST(RECORD_SWITCH),
 	PERF_CONST(RECORD_SWITCH_CPU_WIDE),
+	PERF_CONST(RECORD_STAT),
+	PERF_CONST(RECORD_STAT_ROUND),
 
 	PERF_CONST(RECORD_MISC_SWITCH_OUT),
 	{ .name = NULL, },
@@ -3374,6 +3493,7 @@ struct pyrf_session {
 	struct perf_tool tool;
 	struct pyrf_data *pdata;
 	PyObject *sample;
+	PyObject *stat;
 };
 
 static int pyrf_session_tool__sample(const struct perf_tool *tool,
@@ -3398,6 +3518,50 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
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
@@ -3431,13 +3595,13 @@ static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObje
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
@@ -3446,6 +3610,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 
 	psession->session = NULL;
 	psession->sample = NULL;
+	psession->stat = NULL;
 	psession->pdata = NULL;
 
 	Py_INCREF(pdata);
@@ -3468,8 +3633,13 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
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
@@ -3482,7 +3652,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	psession->tool.build_id         = perf_event__process_build_id;
 	psession->tool.attr		= perf_event__process_attr;
 	psession->tool.feature		= perf_event__process_feature;
-	psession->tool.stat		= perf_event__process_stat_event;
+
 	session = perf_session__new(&pdata->data, &psession->tool);
 	if (IS_ERR(session)) {
 		PyErr_Format(PyExc_IOError, "failed to create session: %ld", PTR_ERR(session));
@@ -3511,6 +3681,7 @@ static void pyrf_session__delete(struct pyrf_session *psession)
 	perf_session__delete(psession->session);
 	Py_XDECREF(psession->pdata);
 	Py_XDECREF(psession->sample);
+	Py_XDECREF(psession->stat);
 	Py_TYPE(psession)->tp_free((PyObject *)psession);
 }
 
@@ -3698,6 +3869,12 @@ PyMODINIT_FUNC PyInit_perf(void)
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

