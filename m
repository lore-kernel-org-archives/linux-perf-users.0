Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B43955EB
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487524; cv=none; b=rS97+5hP7s/85gPs3MMhnd1Y36iDhPQP9nOgftYkneFNDPDVFJqveJLM2gpo8/YrdiRP8eXuxV9cgowUkZ+XI/Y/SDe66h1rt4vpkM6P0fmHJnE2NumhAkWig6+Wjorzj159OwaR90disBGk+eJRfn9h1aDJG79K760IqrreNks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487524; c=relaxed/simple;
	bh=dqKmg4nKf14S8ybLYiSbiatdZipReLdpeDHE6VkthxU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MZh27tkEklnDU3QU1ydWuU/5y2v9CwQNAXdVt159o7YrSG9j5RPwIx1gvhnEdGn2PVzu8u9LM+xQjuh++5jsIb92rPkMIKW5Sdv+EntZhENXvSStEdxgMxV6TM1eSkiN+nPJlxnDoCChMLIVyjwYLRl8yTfS1g5h6OolyY6TC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dm/IZq3k; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dm/IZq3k"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1353ac304f3so11853018c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487521; x=1780092321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8zoT8NtEq4Wo2jdLV0BHRgdjeNd/pAmkexwraDI86U=;
        b=dm/IZq3kKtJnO9GeoaqwWMSMYGc82plLnu8s+iLl9NKrO3fGqHYhvD5/ceJEtA+kl3
         AFltzMReFisVj3nb+usnnuHWtCZn/3P9/94aBKxmawwF5B+INFov3GcUMmWo5QPh7DKE
         8xYividXP9Z8hIl4uaEwbmAsg3kYjLkIwiJ5fHCp6cej36JHfrOKfAo8TkwKsSpwYWyD
         O2kaCh+3lc4NPoiothpid6pctKO1TwaGqccPADTbDhT9u6yRcA8z02Zldn8CEFOKptY/
         Dm+KkMYT5kGyuyqhT5a0Q50JM1eB+fa7/Yzu0+alQR0fCEvOfD8OpeIayFFAC6PjuTy2
         Okuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487521; x=1780092321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8zoT8NtEq4Wo2jdLV0BHRgdjeNd/pAmkexwraDI86U=;
        b=rldWS8pObh9m3Pb7B+LeLT8fPE1OwkU9DSYd0kUmLFrsx6DseKcer6/pS7j9XB5dkf
         NsMlLAqBhuS2dky/M0d0rdhgJjfg9HlWOhu0BIjaqG6WIxLX5SqutJ6U3U5/J0NNgpyU
         aEJGJk1NcVjfd7ZDmGTqL7OrUbSBnV4aufshyqi1MJYdv4IvZ/UBZVA0SHi4mN073nB8
         GRMrLbIkGS77+qg3jsPVZ/VHSc0bWA0LsILCLZt8ZdDwyKIH2OVGZqGyABlweom4agi9
         FCQpGDQR4O/rxIE0pP18zgtBCclVl2qcZpwiIZJjtMcFYLPpnqhzR6DzhjGaA+afvzet
         8xtQ==
X-Forwarded-Encrypted: i=1; AFNElJ8zimtHUDSQmzikGU7b5b+ooN9KMm+S6R0d0Bu+AcKQDb5r8ZmCn/4suwO/2XqjXZ+1NrwhxYfBDSZZecQxhK0b@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+1JHa5XFg3i6n2zilmqZs4aPnu0S4Ow4KPTXO7ZLINNxdez9D
	0D8VvXnAMrs96NpAU+xRJ0gq57IZA0mDVH9yW5KzOW7gJjqbxlIBuM6bs750+SSFfUG1ws92dXW
	pE9S0ONnxOA==
X-Received: from dlbvc2.prod.google.com ([2002:a05:7022:fe02:b0:133:3081:bb33])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:128a:b0:135:dd7c:7
 with SMTP id a92af1059eb24-1365fc6db3dmr2056201c88.38.1779487520955; Fri, 22
 May 2026 15:05:20 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:29 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-19-irogers@google.com>
Subject: [PATCH v9 18/23] perf python: Extend API for stat events in python.c
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
 tools/perf/util/python.c | 180 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 173 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index de7a51389572..4ee3fdbf35de 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -343,6 +343,77 @@ static PyTypeObject pyrf_lost_event__type = {
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
@@ -1034,6 +1105,12 @@ static int pyrf_event__setup_types(void)
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
@@ -1059,6 +1136,8 @@ static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_SAMPLE]	 = &pyrf_sample_event__type,
 	[PERF_RECORD_SWITCH]	 = &pyrf_context_switch_event__type,
 	[PERF_RECORD_SWITCH_CPU_WIDE]  = &pyrf_context_switch_event__type,
+	[PERF_RECORD_STAT]	 = &pyrf_stat_event__type,
+	[PERF_RECORD_STAT_ROUND] = &pyrf_stat_round_event__type,
 };
 
 static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *evsel,
@@ -1091,13 +1170,13 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
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
@@ -2119,7 +2198,40 @@ static PyObject *pyrf_evsel__get_attr_wakeup_events(PyObject *self, void */*clos
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
@@ -2894,6 +3006,8 @@ static const struct perf_constant perf__constants[] = {
 	PERF_CONST(RECORD_LOST_SAMPLES),
 	PERF_CONST(RECORD_SWITCH),
 	PERF_CONST(RECORD_SWITCH_CPU_WIDE),
+	PERF_CONST(RECORD_STAT),
+	PERF_CONST(RECORD_STAT_ROUND),
 
 	PERF_CONST(RECORD_MISC_SWITCH_OUT),
 	{ .name = NULL, },
@@ -3270,6 +3384,7 @@ struct pyrf_session {
 	struct perf_tool tool;
 	struct pyrf_data *pdata;
 	PyObject *sample;
+	PyObject *stat;
 };
 
 static int pyrf_session_tool__sample(const struct perf_tool *tool,
@@ -3294,6 +3409,50 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
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
@@ -3325,13 +3484,13 @@ static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObje
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
@@ -3340,6 +3499,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 
 	psession->session = NULL;
 	psession->sample = NULL;
+	psession->stat = NULL;
 	psession->pdata = NULL;
 
 	Py_INCREF(pdata);
@@ -3362,8 +3522,13 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
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
@@ -3403,6 +3568,7 @@ static void pyrf_session__delete(struct pyrf_session *psession)
 	perf_session__delete(psession->session);
 	Py_XDECREF(psession->pdata);
 	Py_XDECREF(psession->sample);
+	Py_XDECREF(psession->stat);
 	Py_TYPE(psession)->tp_free((PyObject *)psession);
 }
 
-- 
2.54.0.794.g4f17f83d09-goog

