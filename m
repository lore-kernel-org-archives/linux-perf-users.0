Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A939BFF5
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157459; cv=none; b=Wo/o27i+d2ylq8IAWNOrxOm2YS2CAgQLw0H/CJjH/5saWwod8AYvoE5QrmOglES4U2B0qChj4B1nHUS2SLHon603QFrsbXjhTCF3T0WKLYLG1CwmCGJpe6QyoCAWkSvkT45xV3K3UrODnd7AgdbGv06HBXfbcJMLV3htazO1Q00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157459; c=relaxed/simple;
	bh=/9+s+2uN+0FSb3j4s+R0LP1vky14f3XNoupPJzN7HwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FvuPMowS3tv/YwOjAX3jnTNJwHlc7w9H/iEVM4SOyYajzDB6544vzSZ1hkzJqU5OO3XobRhyAXph5/ce8HsQ18UGzTI2UmFJm0NeLXan0WUGCeZS7K7cxU3QzQvuWDSRLbXVfGtRUqtALbnknLZDt2mBBavpVXko3qpo8ZAbpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DjgYhSgp; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DjgYhSgp"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2eaf70f3b5fso734359eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157455; x=1777762255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LehBsqXOO+3vyC/RHNJFTkhwNHC6p/PwtZuYnp7DrgM=;
        b=DjgYhSgpF3WuxEnqilbxjd9nVMdukrf+0J/p3Svy4shJzYzFzbfLz8Ac4xJ9GbclgV
         0hQdmRqCc7O0IS0MC4trV7yYmlblIzHXnSPWfuZ4nvoPud6D5PZEpu1pEHJsCS1cNa22
         Ux+hVPSH4L+zCe2bCF124eIvYe5GxYyBEJMyNr3G09IenPq+5+erHIAxPL2ujhSh4EH6
         /AycOWQuuBm+k2X+Q49r4JpwwFcxK9wleUNI4B3mIin/P6D0+rKoMH4uu9vlQruudXTL
         fZHht6NVQQi7yV3//OoJSfhjZlb/qiwUP/2m6MDvV5L8zVyc4sUnXdvdgEKpTOM11NK1
         tuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157455; x=1777762255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LehBsqXOO+3vyC/RHNJFTkhwNHC6p/PwtZuYnp7DrgM=;
        b=hdS9XlFOy9VsIOM2PGk28u7HGQMbXB2da+/i6QtGwz23t9r5uExUuIMF9x7ip+Lt2B
         XwnB1VEu8GQh+UAUv7e1sR4na3ZBXGE8YUEcer5GJHvDLCAzkU9pg4T+A413Haz5vh67
         PElcYwCAu2ENUl0OpV3dhxfruf+C47/t/PYOIyd2bFOzfDqd74nrH7RFOwQrlGANZH3o
         D2fGW0Bhxa06G8/pawMshzYezpUGIti99fz86iYEXPhwunfWaIg2WH4Qw6H8S+DJ8fNy
         lSgdIPFfq0NOJmMGVAiGocE5G51mK4SDKj51JhAO8+MVqy6k0j20nQ4t/vdo8YYixWr5
         iOPg==
X-Forwarded-Encrypted: i=1; AFNElJ9Qyqd69KyacjhpvR2H8GJgH3567IfCBxQNL+6K+C5Or7R86SqcgBz5w3ERSg7opgmAC4mvVbHyziOMvvToVsn6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2C4q2VxnEDEeCrd8O4MU3M/JYmmW4JYyz+FHTatQOEjQ6NYCm
	I6ivV9N8kcvmIRVzkt6b8/sHjfnKymEDAJ46SxuBfg3dBLzHQ7zImi6Bbk77k7vT54G0c5pn4a6
	R2r5Dx4+/hQ==
X-Received: from dycw20.prod.google.com ([2002:a05:7300:2154:b0:2d6:2fd7:91f8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4288:b0:2da:2ec2:64e5
 with SMTP id 5a478bee46e88-2e479c042b2mr13816235eec.18.1777157454743; Sat, 25
 Apr 2026 15:50:54 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:12 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-21-irogers@google.com>
Subject: [PATCH v7 20/59] perf python: Extend API for stat events in python.c
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
v7:
- Added comprehensive size checks in pyrf_event__new for all event
  types.
- Fixed line length warning.
---
 tools/perf/util/python.c | 271 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 264 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 5478561ca62c..17d0ee15336f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -299,6 +299,77 @@ static PyTypeObject pyrf_lost_event__type = {
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
@@ -986,6 +1057,12 @@ static int pyrf_event__setup_types(void)
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
@@ -1010,6 +1087,8 @@ static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_SAMPLE]	 = &pyrf_sample_event__type,
 	[PERF_RECORD_SWITCH]	 = &pyrf_context_switch_event__type,
 	[PERF_RECORD_SWITCH_CPU_WIDE]  = &pyrf_context_switch_event__type,
+	[PERF_RECORD_STAT]	 = &pyrf_stat_event__type,
+	[PERF_RECORD_STAT_ROUND] = &pyrf_stat_round_event__type,
 };
 
 static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *evsel,
@@ -1026,7 +1105,9 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
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
@@ -1038,6 +1119,9 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	case PERF_RECORD_MMAP:
 		min_size = sizeof(struct perf_record_mmap);
 		break;
+	case PERF_RECORD_MMAP2:
+		min_size = sizeof(struct perf_record_mmap2);
+		break;
 	case PERF_RECORD_COMM:
 		min_size = sizeof(struct perf_record_comm);
 		break;
@@ -1045,13 +1129,13 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
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
@@ -1059,6 +1143,96 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	case PERF_RECORD_SWITCH_CPU_WIDE:
 		min_size = sizeof(struct perf_record_switch);
 		break;
+	case PERF_RECORD_AUX:
+		min_size = sizeof(struct perf_record_aux);
+		break;
+	case PERF_RECORD_ITRACE_START:
+		min_size = sizeof(struct perf_record_itrace_start);
+		break;
+	case PERF_RECORD_LOST_SAMPLES:
+		min_size = sizeof(struct perf_record_lost_samples);
+		break;
+	case PERF_RECORD_NAMESPACES:
+		min_size = sizeof(struct perf_record_namespaces);
+		break;
+	case PERF_RECORD_KSYMBOL:
+		min_size = sizeof(struct perf_record_ksymbol);
+		break;
+	case PERF_RECORD_BPF_EVENT:
+		min_size = sizeof(struct perf_record_bpf_event);
+		break;
+	case PERF_RECORD_CGROUP:
+		min_size = sizeof(struct perf_record_cgroup);
+		break;
+	case PERF_RECORD_TEXT_POKE:
+		min_size = sizeof(struct perf_record_text_poke_event);
+		break;
+	case PERF_RECORD_AUX_OUTPUT_HW_ID:
+		min_size = sizeof(struct perf_record_aux_output_hw_id);
+		break;
+	case PERF_RECORD_CALLCHAIN_DEFERRED:
+		min_size = sizeof(struct perf_record_callchain_deferred);
+		break;
+	case PERF_RECORD_HEADER_ATTR:
+		min_size = sizeof(struct perf_record_header_attr);
+		break;
+	case PERF_RECORD_HEADER_TRACING_DATA:
+		min_size = sizeof(struct perf_record_header_tracing_data);
+		break;
+	case PERF_RECORD_HEADER_BUILD_ID:
+		min_size = sizeof(struct perf_record_header_build_id);
+		break;
+	case PERF_RECORD_ID_INDEX:
+		min_size = sizeof(struct perf_record_id_index);
+		break;
+	case PERF_RECORD_AUXTRACE_INFO:
+		min_size = sizeof(struct perf_record_auxtrace_info);
+		break;
+	case PERF_RECORD_AUXTRACE:
+		min_size = sizeof(struct perf_record_auxtrace);
+		break;
+	case PERF_RECORD_AUXTRACE_ERROR:
+		min_size = sizeof(struct perf_record_auxtrace_error);
+		break;
+	case PERF_RECORD_THREAD_MAP:
+		min_size = sizeof(struct perf_record_thread_map);
+		break;
+	case PERF_RECORD_CPU_MAP:
+		min_size = sizeof(struct perf_record_cpu_map);
+		break;
+	case PERF_RECORD_STAT_CONFIG:
+		min_size = sizeof(struct perf_record_stat_config);
+		break;
+	case PERF_RECORD_STAT:
+		min_size = sizeof(struct perf_record_stat);
+		break;
+	case PERF_RECORD_STAT_ROUND:
+		min_size = sizeof(struct perf_record_stat_round);
+		break;
+	case PERF_RECORD_EVENT_UPDATE:
+		min_size = sizeof(struct perf_record_event_update);
+		break;
+	case PERF_RECORD_TIME_CONV:
+		min_size = sizeof(struct perf_record_time_conv);
+		break;
+	case PERF_RECORD_HEADER_FEATURE:
+		min_size = sizeof(struct perf_record_header_feature);
+		break;
+	case PERF_RECORD_COMPRESSED:
+		min_size = sizeof(struct perf_record_compressed);
+		break;
+	case PERF_RECORD_COMPRESSED2:
+		min_size = sizeof(struct perf_record_compressed2);
+		break;
+	case PERF_RECORD_BPF_METADATA:
+		min_size = sizeof(struct perf_record_bpf_metadata);
+		break;
+	case PERF_RECORD_SCHEDSTAT_CPU:
+		min_size = sizeof(struct perf_record_schedstat_cpu);
+		break;
+	case PERF_RECORD_SCHEDSTAT_DOMAIN:
+		min_size = sizeof(struct perf_record_schedstat_domain);
+		break;
 	default:
 		break;
 	}
@@ -1970,7 +2144,40 @@ static PyObject *pyrf_evsel__get_attr_wakeup_events(PyObject *self, void */*clos
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
@@ -2743,6 +2950,8 @@ static const struct perf_constant perf__constants[] = {
 	PERF_CONST(RECORD_LOST_SAMPLES),
 	PERF_CONST(RECORD_SWITCH),
 	PERF_CONST(RECORD_SWITCH_CPU_WIDE),
+	PERF_CONST(RECORD_STAT),
+	PERF_CONST(RECORD_STAT_ROUND),
 
 	PERF_CONST(RECORD_MISC_SWITCH_OUT),
 	{ .name = NULL, },
@@ -3117,6 +3326,47 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
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
@@ -3149,10 +3399,11 @@ static int pyrf_session__init(struct pyrf_session *psession, PyObject *args, PyO
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
@@ -3174,8 +3425,13 @@ static int pyrf_session__init(struct pyrf_session *psession, PyObject *args, PyO
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
@@ -3217,6 +3473,7 @@ static void pyrf_session__delete(struct pyrf_session *psession)
 {
 	Py_XDECREF(psession->pdata);
 	Py_XDECREF(psession->sample);
+	Py_XDECREF(psession->stat);
 	perf_session__delete(psession->session);
 	Py_TYPE(psession)->tp_free((PyObject *)psession);
 }
-- 
2.54.0.545.g6539524ca2-goog

