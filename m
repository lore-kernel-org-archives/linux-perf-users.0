Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B41371880
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139383; cv=none; b=s5aKsxTGPcq44tB86qp74kyA6AyaDmVI8dT1bLNQMa9ta6m23G4ZE8UcSCmhRQuOegnpjaKHCsnKmLDafgXPDMlwMesNUOlR7cFA4xj1HnIUIczw8V12zgjXIba70YGA6n1dBaXMlCQtcr48L7Z4V4x/VKmnPFjtn8Hh45DuxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139383; c=relaxed/simple;
	bh=4co4sVbAW2ppQ4UiaObqaywzsylVfP0uEey5+h3QFGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pCrFXuPELWWDYMmLrPbtYVYQ7MHbaB4b73yLDPR9V5mZDfFD/yWMeICIpRHpjuMuOSFnjXhefsBqOzWzGkdSQCUsgymNmVfSoelJ3mHqdknLFIINHiGYmWyhaZKqraE7/KIOn+m2afN8+9cYdasXcrXun3YOuZAqEnbhERgFM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6y5JuLt; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6y5JuLt"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so7643241eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139381; x=1777744181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SP+0lsiDdzNCVN0ltPixIRraLs+b7x8VVL39ZhCrgV4=;
        b=r6y5JuLt+674ngmYkE5SEQaVNHNrQCAVDQt1mAFRfSi8w2tb0qTRaVZiIE6BZwqA0g
         lQLr53vfm+8lHItU+eLt7/DkGZtd4BjrWwr29W9Pykju8kp8B3nJLK/1akBKW8SRVzIr
         UUaQJY5TSbPqechx0cANV01U4Ltmphzrl2jRBOwanLfsxWaP8V0Kp8esYd1vwIh9HlqF
         ztbR72nSJ+qp+5fkj33R9Nny2ht4CXyIATaw3mN98G2n8P74SS+OVVev8CU5gv/Nezp8
         6BaDsMyJMvhtdJM9dNpTd5WO3/Hl0BNi8CU4bZVirDtSjwIzR29+nFCdyx84fTjSVhLX
         X1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139381; x=1777744181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SP+0lsiDdzNCVN0ltPixIRraLs+b7x8VVL39ZhCrgV4=;
        b=pOP479rN8WdoPv1b0WVnMjzYH3dgrw/3INyAmhmB7Tm0ke+PlOqPnhhKWz+LtdSzLi
         muqO4pwmUgGhCAzQcv3Qi76u/T0wD342RzDcx3K03haylZHf1rqA5fGzprEBqB9+6TTC
         3ogQyg+SFmO/0A5tR1MoLLzjwWV/a5oIIzN5/cRE2X4xDuDVJWYLKCtN/2lgXqcpfHqp
         mpmWcL2Z3Vh1I5Bzjp+88Y42czFV2x5e6zFdzJsQuvW53+DzCp9UNQ/rylEwtTS7JeZw
         OzWkenk+lDPxD3yz6YJOkmLoKWfQk2piUe9zyuV2h0sP5Ivz7Oq3/s7a/+HyQ+KX0evu
         FT0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8eh4ArrZMp4RML+vXF6ylcUNUsomguu8zx3WJsnNz9Xngp+CAtHhIe3IQSN5a/lzfh/rwFAUDN6KCGVsXi+9I1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9O6ho1p6IUdwnyrNAz52xDBt+gtJ2XVTHLOAunfEJi4T9lmDJ
	gx1we9b5NedP+EzYbfNlrpvgGcNrsV/QHXi6MhBnuUA1ZrKqRWI+Ouim/ZypJCvqP5VhgRaYsKw
	jA0QsaNKY2Q==
X-Received: from dyblz34.prod.google.com ([2002:a05:7301:1622:b0:2e6:f22b:f849])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6787:b0:2d2:d5a3:e97c
 with SMTP id 5a478bee46e88-2e42dc07d8fmr13078187eec.12.1777139380455; Sat, 25
 Apr 2026 10:49:40 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:18 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-21-irogers@google.com>
Subject: [PATCH v6 20/59] perf python: Extend API for stat events in python.c
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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
 tools/perf/util/python.c | 171 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b358852b3528..37764a287a71 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -299,6 +299,76 @@ static PyTypeObject pyrf_lost_event__type = {
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
+	  .offset = offsetof(struct pyrf_event, event) + offsetof(struct perf_record_stat_round, type), .doc = "round type" },
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
@@ -986,6 +1056,12 @@ static int pyrf_event__setup_types(void)
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
@@ -1010,6 +1086,8 @@ static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_SAMPLE]	 = &pyrf_sample_event__type,
 	[PERF_RECORD_SWITCH]	 = &pyrf_context_switch_event__type,
 	[PERF_RECORD_SWITCH_CPU_WIDE]  = &pyrf_context_switch_event__type,
+	[PERF_RECORD_STAT]	 = &pyrf_stat_event__type,
+	[PERF_RECORD_STAT_ROUND] = &pyrf_stat_round_event__type,
 };
 
 static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *evsel,
@@ -1025,7 +1103,9 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	if ((event->header.type < PERF_RECORD_MMAP ||
 	     event->header.type > PERF_RECORD_SAMPLE) &&
 	    !(event->header.type == PERF_RECORD_SWITCH ||
-	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)) {
+	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
+	      event->header.type == PERF_RECORD_STAT ||
+	      event->header.type == PERF_RECORD_STAT_ROUND)) {
 		PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
 			     event->header.type);
 		return NULL;
@@ -1937,7 +2017,40 @@ static PyObject *pyrf_evsel__get_attr_wakeup_events(PyObject *self, void */*clos
 	return PyLong_FromUnsignedLong(pevsel->evsel->core.attr.wakeup_events);
 }
 
+static PyObject *pyrf_evsel__get_ids(struct pyrf_evsel *pevsel, void *closure __maybe_unused)
+{
+	struct evsel *evsel = pevsel->evsel;
+	PyObject *list = PyList_New(0);
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
@@ -2690,6 +2803,8 @@ static const struct perf_constant perf__constants[] = {
 	PERF_CONST(RECORD_LOST_SAMPLES),
 	PERF_CONST(RECORD_SWITCH),
 	PERF_CONST(RECORD_SWITCH_CPU_WIDE),
+	PERF_CONST(RECORD_STAT),
+	PERF_CONST(RECORD_STAT_ROUND),
 
 	PERF_CONST(RECORD_MISC_SWITCH_OUT),
 	{ .name = NULL, },
@@ -3051,6 +3166,47 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
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
+	ret = PyObject_CallFunction(psession->stat, "Os", pyevent, name);
+	if (!ret) {
+		PyErr_Print();
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
+	ret = PyObject_CallFunction(psession->stat, "O", pyevent);
+	Py_XDECREF(ret);
+	Py_DECREF(pyevent);
+	return 0;
+}
+
 static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObject *args)
 {
 	struct machine *machine;
@@ -3083,10 +3239,11 @@ static int pyrf_session__init(struct pyrf_session *psession, PyObject *args, PyO
 {
 	struct pyrf_data *pdata;
 	PyObject *sample = NULL;
-	static char *kwlist[] = { "data", "sample", NULL };
+	PyObject *stat = NULL;
+	static char *kwlist[] = { "data", "sample", "stat", NULL };
 
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O!|O", kwlist, &pyrf_data__type, &pdata,
-					 &sample))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O!|OO", kwlist, &pyrf_data__type, &pdata,
+					 &sample, &stat))
 		return -1;
 
 	Py_INCREF(pdata);
@@ -3108,8 +3265,13 @@ static int pyrf_session__init(struct pyrf_session *psession, PyObject *args, PyO
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
@@ -3151,6 +3313,7 @@ static void pyrf_session__delete(struct pyrf_session *psession)
 {
 	Py_XDECREF(psession->pdata);
 	Py_XDECREF(psession->sample);
+	Py_XDECREF(psession->stat);
 	perf_session__delete(psession->session);
 	Py_TYPE(psession)->tp_free((PyObject *)psession);
 }
-- 
2.54.0.545.g6539524ca2-goog

