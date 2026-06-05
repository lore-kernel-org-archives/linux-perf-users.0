Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45D43DA4B
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686959; cv=none; b=uj/42OxdVL3bsPMW74Mk1LNFkjxOkgRrQFR3fe+H13PAFdA4ssnHJdsc//TpHZghDj+gjUq9OcrBa3RvXrQRwPXbZ8+3+BLeh3KflYVnko5cjXHTp2HOvkFlMXmAJMT2VtNQtsKg+bywn4rrBvmgNLgYSijs3JuzVIBrRQVFDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686959; c=relaxed/simple;
	bh=cTY+36xGwCbA7Ok0R22v5DdbhJnIIxQAoPyT215EyfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PUI6L1DpRp6qKwgreOwhO2HfSrTvn6Ui2+TW8Pd3aZPtUDFoq3lel++FzkoUAR19nQTFTRcNLVA38tk1NLQs0PUKHLFwOUy3CXNjIcYN3qYQZzcg3J8bSgtMlkttUj+T/imsd8O9tFttmzmU8TM9oZM8wu1yImr+uMmnuI/jokM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asBYC2up; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asBYC2up"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13807001f80so3604620c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 12:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780686946; x=1781291746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UNycYfT/7d7QOLsfs9/fFsWZVKf+PMTo6n7QrzonWQ=;
        b=asBYC2upHiXx3Qv7sqlUrgTVsgta4tF1UtubGyDYuyxEhWLKzHoatymP1ylh5tIDhd
         gwCv/VtmcUzRzuLwc4OgBmLVXuVMSf0QN7HOkDy6bTd3Ekv6QcWHh+YVPgL9v9toKFv0
         5MSFuar5J3sHM1CY7XxnYmCSiNymdQ9G9w/kRoUZJ4Yz2wevH+hyeWvSktaYEP+Kyv/7
         5BTXt5Ia9xFXIo6BJ3K8t7bSJMxouZMbgliWUt4OISVCUFvHcD4KPS+OLQlXdqg7HclG
         97upi6X8ZftuEnuQBzmcMvnh/8Zjtn2du3KssR9Xqcb6rZE19F/EylX/T6IEXadtDoCh
         Lx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686946; x=1781291746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UNycYfT/7d7QOLsfs9/fFsWZVKf+PMTo6n7QrzonWQ=;
        b=GFjN1FUs+zJbSESZExot4TchOLEumdipx8DVkfGzo2O/hxp2BWWZyV1Vjm/r0D91Zf
         SRVpfRBJKlk0T7dSr36jHw5Q8bGlRcWUAnc/wt+SjaWQ1Wf/5kczYp9sEio3AsGadN1t
         K+P8dUK/MHvtF2F5NXP/Ap75D5/kYjPaSMKNG42+rj5Mkgcw41vqIkqJLMaI1bbZFypk
         5iRXOlidIWz3Gn5QiARi8FUjPtqNhplQtUcGfcP7hO6t8W2XqfcTwPjOkcGdpE0YURNq
         y8jW5DaKWBtdP6YaR60uxZBYs1h/vFTXAQdTsR3meaGYi6eHRP5fRtuAWsgG4f3dB8N0
         gJLA==
X-Forwarded-Encrypted: i=1; AFNElJ/UnjFuUQ0aq2Gt0gAAjZAAutopbQ11W6QIpqM5XvhXsCqYE3iaKmszSAz/SfzCyITWJ9P+NuFw7eMopdtJwQyJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg57wIhkCXRxxei+VtkZ39fs/Igt+A4HjT1+wGEg283EWYjND5
	8wIAx0Nmvt4juhRo3o+aFj+O6CN96coSpc3hbDcMMZb4uo+23+fl/Dl3zYp/YCVqejEe05/A3eg
	SuQlLSc2tGA==
X-Received: from dldoa1.prod.google.com ([2002:a05:701a:ca81:b0:132:8d92:4d65])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6999:b0:137:e45d:7c4a
 with SMTP id a92af1059eb24-13806720d38mr2472164c88.29.1780686946106; Fri, 05
 Jun 2026 12:15:46 -0700 (PDT)
Date: Fri,  5 Jun 2026 12:14:55 -0700
In-Reply-To: <20260605191500.2477026-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605074003.1730715-1-irogers@google.com> <20260605191500.2477026-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605191500.2477026-15-irogers@google.com>
Subject: [PATCH v11 14/19] perf python: Extend API for stat events in python.c
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
 tools/perf/util/python.c | 185 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 181 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index d8296d4d17d8..96694360c978 100644
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
@@ -2128,7 +2207,45 @@ static PyObject *pyrf_evsel__get_attr_wakeup_events(PyObject *self, void */*clos
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
@@ -2977,6 +3094,8 @@ static const struct perf_constant perf__constants[] = {
 	PERF_CONST(RECORD_LOST_SAMPLES),
 	PERF_CONST(RECORD_SWITCH),
 	PERF_CONST(RECORD_SWITCH_CPU_WIDE),
+	PERF_CONST(RECORD_STAT),
+	PERF_CONST(RECORD_STAT_ROUND),
 
 	PERF_CONST(RECORD_MISC_SWITCH_OUT),
 	{ .name = NULL, },
@@ -3372,6 +3491,7 @@ struct pyrf_session {
 	struct perf_tool tool;
 	struct pyrf_data *pdata;
 	PyObject *sample;
+	PyObject *stat;
 };
 
 static int pyrf_session_tool__sample(const struct perf_tool *tool,
@@ -3396,6 +3516,50 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
 	return 0;
 }
 
+static int pyrf_session_tool__stat(const struct perf_tool *tool,
+				   struct perf_session *session,
+				   union perf_event *event)
+{
+	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
+	struct evsel *evsel = evlist__id2evsel(session->evlist, event->stat.id);
+	PyObject *pyevent = pyrf_event__new(event, evsel, psession->session);
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
+	PyObject *pyevent = pyrf_event__new(event, /*evsel=*/NULL, psession->session);
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
@@ -3429,13 +3593,13 @@ static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObje
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
@@ -3444,6 +3608,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 
 	psession->session = NULL;
 	psession->sample = NULL;
+	psession->stat = NULL;
 	psession->pdata = NULL;
 
 	Py_INCREF(pdata);
@@ -3466,8 +3631,13 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
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
@@ -3510,6 +3680,7 @@ static void pyrf_session__delete(struct pyrf_session *psession)
 	perf_session__delete(psession->session);
 	Py_XDECREF(psession->pdata);
 	Py_XDECREF(psession->sample);
+	Py_XDECREF(psession->stat);
 	Py_TYPE(psession)->tp_free((PyObject *)psession);
 }
 
@@ -3692,6 +3863,12 @@ PyMODINIT_FUNC PyInit_perf(void)
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
2.54.0.1032.g2f8565e1d1-goog

