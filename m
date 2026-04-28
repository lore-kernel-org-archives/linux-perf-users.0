Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343553D8100
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360797; cv=none; b=gxuD3XAXfAv9qcayJy+0UR588Gg+QiVPRnYNAF7Pymff5XkOukknBB6cM26p0AhDMhQnrSpjnjQyZil5SNkK8TB+xBeLzPj65IjOK/RR4Al+jVxZ86l0cjsNGQf68YciYqy6ZhR953UL4CHvhMwaBEuZL+vxxuojn2Gm+9AANBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360797; c=relaxed/simple;
	bh=KKUiZiJRKZtnLyRrxUEvAv7Z7+Lqd0YKzJf/Pj8Volc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TxKcwwWESpYpWOKsCStnynBTFxaVEk/P4khLdQliF1mL6e4ta8ws3L8cvyPOr98YwaOs4+LO2Ih5xS2TSzw836wx4EXc06Ej7A8dP9W+l/W7xtUKJXx0tsC+NN/Aaa2K3zWSvtg9i0gJ+g32cMMQatfhfE821kdobrnCxRCNARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryquuIIk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryquuIIk"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36472c6a7d8so3765508a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360794; x=1777965594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv/wZt06TAEWoI0SMLj1YS0ILpIarRzTY+ClpzLsEU4=;
        b=ryquuIIkUMhCQ631CZVcD3ggFmMh+xGVusAVjp1qMW9j3IxR8QP044JZ/jHVGU3L8b
         haxsFl76ZVC8JeWDqaW9j0q4alMsK1niQc3gg1Rss4N9i2aJRmAc8TE2+MxMdtvH223l
         9ov+G4vjQaJavh/AbqG7SnYcatI6Ip/+YafsxPgc61A6SHB2DTyp0OY3HZHkfXX5f3Lq
         knnr2beRJwVoPGkCuRLNfR0uIKh/NXhIlHrZ1lK0Caf19+3kppgcIj8aoi1ivWCXnKGy
         z8oKo6nHhjLCnwliy978or+VVrysFZThFobChmjiCLWq3Oly2rdS+bsZV7Fy2A5VzPIE
         7ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360794; x=1777965594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv/wZt06TAEWoI0SMLj1YS0ILpIarRzTY+ClpzLsEU4=;
        b=oGh3a3evNLyLx7uSPacrToPqGNiJscNlLKSw1CLqaysvoq2rL+0s3SLMuKtTSiU2eL
         QdRG6iU6fKg8N6Bfz+/BABs6LjCGLxOFGlBaFxD2MbnS/MKs/+xHgy+3uGcYp6m9gHLY
         VkXbvrjUoUTyrO0UUCHOFqHPXBj9trp+48AMmKZdlIv0ZVo8p4TXIw+gTkdN2okamREG
         Gk36HY+famesondzEH/CBm79uku8CIdUS4cfisdxU243ebYpru2xDSoTLyBlX0Ebz3gD
         16Zn6QXjKBpiHf9fsXYd7xOKhv0yhsV4Vrvx8Fn+fXsHGohTWY1sUeQsv/UGGXM5Yl2V
         wNDA==
X-Forwarded-Encrypted: i=1; AFNElJ8j0sJgQTxUb70fGMBV0SPg0Biz9u6vGBYtojls4aYPgsAqnLWiGOMTSUZ74qfhBLuJN52IXV8U7TaviDetJaJk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9i7ZWu+IQCjCMwfHDcYmYXd+lkUdWzWgJ/GGEWtaWNJWHNqGe
	fjD650s2cUYRzvgFvfd/4wmN1jneufl6HrZdkk/XGMibpQpVXZh+fJ3nhLzFaNpSQjxZiH+HsZB
	vG6iKvrx6yQ==
X-Received: from pgtt124.prod.google.com ([2002:a63:2d82:0:b0:c73:fbb5:af1b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a92:b0:35b:e56e:a17e
 with SMTP id 98e67ed59e1d1-364920a55e8mr2010942a91.17.1777360794333; Tue, 28
 Apr 2026 00:19:54 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:23 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-19-irogers@google.com>
Subject: [PATCH v8 18/58] perf python: Extend API for stat events in python.c
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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
---
 tools/perf/util/python.c | 177 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 170 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 2ff588517c29..144fbc85fcb3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -341,6 +341,77 @@ static PyTypeObject pyrf_lost_event__type = {
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
@@ -1032,6 +1103,12 @@ static int pyrf_event__setup_types(void)
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
@@ -1057,6 +1134,8 @@ static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_SAMPLE]	 = &pyrf_sample_event__type,
 	[PERF_RECORD_SWITCH]	 = &pyrf_context_switch_event__type,
 	[PERF_RECORD_SWITCH_CPU_WIDE]  = &pyrf_context_switch_event__type,
+	[PERF_RECORD_STAT]	 = &pyrf_stat_event__type,
+	[PERF_RECORD_STAT_ROUND] = &pyrf_stat_round_event__type,
 };
 
 static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *evsel,
@@ -1089,13 +1168,13 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	case PERF_RECORD_EXIT:
 		min_size = sizeof(struct perf_record_fork);
 		break;
+	case PERF_RECORD_LOST:
+		min_size = sizeof(struct perf_record_lost);
+		break;
 	case PERF_RECORD_THROTTLE:
 	case PERF_RECORD_UNTHROTTLE:
 		min_size = sizeof(struct perf_record_throttle);
 		break;
-	case PERF_RECORD_LOST:
-		min_size = sizeof(struct perf_record_lost);
-		break;
 	case PERF_RECORD_READ:
 		min_size = sizeof(struct perf_record_read);
 		break;
@@ -2117,7 +2196,40 @@ static PyObject *pyrf_evsel__get_attr_wakeup_events(PyObject *self, void */*clos
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
@@ -2890,6 +3002,8 @@ static const struct perf_constant perf__constants[] = {
 	PERF_CONST(RECORD_LOST_SAMPLES),
 	PERF_CONST(RECORD_SWITCH),
 	PERF_CONST(RECORD_SWITCH_CPU_WIDE),
+	PERF_CONST(RECORD_STAT),
+	PERF_CONST(RECORD_STAT_ROUND),
 
 	PERF_CONST(RECORD_MISC_SWITCH_OUT),
 	{ .name = NULL, },
@@ -3266,6 +3380,7 @@ struct pyrf_session {
 	struct perf_tool tool;
 	struct pyrf_data *pdata;
 	PyObject *sample;
+	PyObject *stat;
 };
 
 static int pyrf_session_tool__sample(const struct perf_tool *tool,
@@ -3291,6 +3406,47 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
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
@@ -3322,13 +3478,13 @@ static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObje
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
@@ -3337,6 +3493,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 
 	psession->session = NULL;
 	psession->sample = NULL;
+	psession->stat = NULL;
 
 	Py_INCREF(pdata);
 	psession->pdata = pdata;
@@ -3358,8 +3515,13 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
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
@@ -3399,6 +3561,7 @@ static void pyrf_session__delete(struct pyrf_session *psession)
 	perf_session__delete(psession->session);
 	Py_XDECREF(psession->pdata);
 	Py_XDECREF(psession->sample);
+	Py_XDECREF(psession->stat);
 	Py_TYPE(psession)->tp_free((PyObject *)psession);
 }
 
-- 
2.54.0.545.g6539524ca2-goog

