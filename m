Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255613B0AFB
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504222; cv=none; b=a/YuX4dHLbatuiMvtj4B8JPNLwQh3Qc1+LtwosNfySoMpxoKGEVUnlCTplkZAi24h10ho0ZCcN6Le7gUMFnE8ULKS+izKUSmpdPYiE9DAaOazp1rJVGZsuHJL8ySUyc44rcQ6RuEcAowawsS28OkGcFBr30UeocphhpgcXtG41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504222; c=relaxed/simple;
	bh=8sXDn0vK9r81Qsa9Y9Sk99zyPG1gpIjME0/GVxBU7Sk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GtcUpK8Q3x6m6aRFb3BA/ADs+ftoRwv79nE9tbilmGnV29ewYwJAIWpMPyDkqQV23YjHRNFjiSsvCybeA3ImGUU0bGw1HHJRrUIxPgdi7kJFQMRYnN1vocmtlkqX2kDCkzbnphMpZ6Ch07xaEQRj96JaHcyUO6siWMsQTB3CkVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XiUE4O+G; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XiUE4O+G"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304e7fc90b1so3355874eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 23:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781504218; x=1782109018; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qSq72wGd5BqyAnl1/YRZKEcO1VhxMUb1+DM3tlLbRco=;
        b=XiUE4O+GZ3kOivlYKZhMfVJ9FaK+qIk/cWsiRHafwnAPE9VkrFNT5THa10X4spX6ZF
         bL8Ts5rsJH39/ltt2IbLk5Hk4JhC7EvaBts36i1QihIRgsc5XpayRTJFCKPG94hZniwW
         mSKVKr8RVrQXENlQhpIaTfqnijI1DYWoIOAuYlklMMwnQ2d1t0VCdx5WKYcCo0/AOVKh
         EASfXdY8I2apkr/JR0fMNUutro9vEJtGo2SvHD28ILEN7+FAb1zYqLnp5CJczoa8LVA+
         lB+OMm0e7u7h7U5bzzoMMHmkDB7/dQzEVZ7flC1fbBsFmdbvO09lHE3mn8O4TXugritY
         BKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504218; x=1782109018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSq72wGd5BqyAnl1/YRZKEcO1VhxMUb1+DM3tlLbRco=;
        b=YEKOnvN8mp9mj6uIAuWgM8bSuvJnDS+R77w3Pjh9Aj/cVVpzYQkLp/cpg5rElt8FCa
         QfPBvcfaITZ1wx8D0EimLoW8Z9JOaIjyXQzwMa7VYCoQ9hFAqW6UAWXMtJyQB6eIALiK
         eogrMD0Od18IHoqXLJoYHvE9QrBgM+ZH4XmWk7GbZK+dkQqjOTlGQs7i1lZEaY5UR613
         5DW0rhLRqlJTDRqEsv0vBilgcyroamhfeaKXzvUtm3IEvJOzD+qbk62ir7QaZBCeffS7
         5c455WHnI7p+VHK5L8h1mJBx2/OKhs9ICziaaev1IN7JWSc2z6s4mWAaf5M15hchmro1
         Mddw==
X-Forwarded-Encrypted: i=1; AFNElJ8ovDHIYE40h+IX8yqZ+Qrepl2dRxGVkReSaTaETcNTqcRB6316PbrquWnD3kU9kduA38V0aHIz6/UrsDDrEefj@vger.kernel.org
X-Gm-Message-State: AOJu0YzOIJ7wW/gYcQYrIT0exp1hCk3MOCe3lGdnMeTXnBtK6RFRy0TJ
	63Tdi1IoZ14dM7KjdP1f3AT1/5chn7K+6NInFL0EB8hhlMq0y6bBhwROQ3oWIPWfUV21UD0NQhn
	k7EIcUW9XPQ==
X-Received: from dyec22.prod.google.com ([2002:a05:7300:2216:b0:304:df46:263a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:80cb:b0:2ce:25be:c8e8
 with SMTP id 5a478bee46e88-3093b84e7d4mr5120822eec.17.1781504217996; Sun, 14
 Jun 2026 23:16:57 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:16:21 -0700
In-Reply-To: <20260615061631.2382079-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615002812.2234795-1-irogers@google.com> <20260615061631.2382079-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615061631.2382079-12-irogers@google.com>
Subject: [PATCH v19 11/20] perf python: Refactor and add accessors to sample event
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add common evsel field for events and move sample specific fields to
only be present in sample events. Add accessors for sample
events. Ensure offsets are within the bounds of the event. Allocate
just enough memory for the copied event, don't make the maximum event
size each time.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v12:
 - Used `copy_size` to bound `max_len` for NUL termination to fix an out-of-bounds write in `pyrf_event__new`. Also set `pevent->event.header.size = copy_size`.

v5:
1. Fix Uninitialized Memory: Restore zero-initialization of `pevent->sample`
   in `pyrf_event__new()` to prevent wild free crashes on error paths.

v6:
- Refactored `pyrf_event__new` to take `evsel` and `session`, and use
  dynamic allocation based on event size. Updated callers.

v8:
- Ensure events are properly deallocated.

v11:
- Use `perf_event__too_small` for event size validation, sharing logic
  with the session parser instead of replicating validation checks.
---
 tools/perf/util/python.c  | 509 +++++++++++++++++++++++++++++++-------
 tools/perf/util/session.c |   2 +-
 tools/perf/util/session.h |   2 +
 3 files changed, 421 insertions(+), 92 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index dc71fe7e3787..3f4aff7ddc76 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -13,21 +13,28 @@
 #include <perf/mmap.h>
 #include <structmember.h>
 
+#include "addr_location.h"
+#include "build-id.h"
 #include "callchain.h"
 #include "comm.h"
 #include "counts.h"
 #include "data.h"
 #include "debug.h"
+#include "dso.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "expr.h"
+#include "map.h"
 #include "metricgroup.h"
 #include "mmap.h"
 #include "pmus.h"
 #include "print_binary.h"
 #include "record.h"
+#include "sample.h"
 #include "session.h"
+#include "srccode.h"
+#include "srcline.h"
 #include "strbuf.h"
 #include "symbol.h"
 #include "stat.h"
@@ -37,7 +44,6 @@
 #include "tool.h"
 #include "tp_pmu.h"
 #include "trace-event.h"
-#include "util/sample.h"
 
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
@@ -45,6 +51,8 @@
 
 PyMODINIT_FUNC PyInit_perf(void);
 
+static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel);
+
 #define member_def(type, member, ptype, help) \
 	{ #member, ptype, \
 	  offsetof(struct pyrf_event, event) + offsetof(struct type, member), \
@@ -73,21 +81,53 @@ PyMODINIT_FUNC PyInit_perf(void);
 
 struct pyrf_event {
 	PyObject_HEAD
+	/** @sample: The parsed sample from the event. */
 	struct perf_sample sample;
-	union perf_event   event;
+	/** @al: The address location from machine__resolve, lazily computed. */
+	struct addr_location al;
+	/** @al_resolved: True when machine__resolve been called. */
+	bool al_resolved;
+	/** @event: The underlying perf_event that may be in a file or ring buffer. */
+	union perf_event event;
 };
 
 #define sample_members \
-	sample_member_def(sample_ip, ip, T_ULONGLONG, "event ip"),			 \
 	sample_member_def(sample_pid, pid, T_INT, "event pid"),			 \
 	sample_member_def(sample_tid, tid, T_INT, "event tid"),			 \
 	sample_member_def(sample_time, time, T_ULONGLONG, "event timestamp"),		 \
-	sample_member_def(sample_addr, addr, T_ULONGLONG, "event addr"),		 \
 	sample_member_def(sample_id, id, T_ULONGLONG, "event id"),			 \
 	sample_member_def(sample_stream_id, stream_id, T_ULONGLONG, "event stream id"), \
 	sample_member_def(sample_period, period, T_ULONGLONG, "event period"),		 \
 	sample_member_def(sample_cpu, cpu, T_UINT, "event cpu"),
 
+static PyObject *pyrf_event__get_evsel(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_event *pevent = (void *)self;
+
+	if (!pevent->sample.evsel)
+		Py_RETURN_NONE;
+
+	return pyrf_evsel__from_evsel(pevent->sample.evsel);
+}
+
+static PyGetSetDef pyrf_event__getset[] = {
+	{
+		.name = "evsel",
+		.get = pyrf_event__get_evsel,
+		.set = NULL,
+		.doc = "tracking event.",
+	},
+	{ .name = NULL, },
+};
+
+static void pyrf_event__delete(struct pyrf_event *pevent)
+{
+	if (pevent->al_resolved)
+		addr_location__exit(&pevent->al);
+	perf_sample__exit(&pevent->sample);
+	Py_TYPE(pevent)->tp_free((PyObject *)pevent);
+}
+
 static const char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
 
 static PyMemberDef pyrf_mmap_event__members[] = {
@@ -126,9 +166,11 @@ static PyTypeObject pyrf_mmap_event__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
 	.tp_name	= "perf.mmap_event",
 	.tp_basicsize	= sizeof(struct pyrf_event),
+	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_mmap_event__doc,
 	.tp_members	= pyrf_mmap_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_mmap_event__repr,
 };
 
@@ -161,9 +203,11 @@ static PyTypeObject pyrf_task_event__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
 	.tp_name	= "perf.task_event",
 	.tp_basicsize	= sizeof(struct pyrf_event),
+	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_task_event__doc,
 	.tp_members	= pyrf_task_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_task_event__repr,
 };
 
@@ -190,9 +234,11 @@ static PyTypeObject pyrf_comm_event__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
 	.tp_name	= "perf.comm_event",
 	.tp_basicsize	= sizeof(struct pyrf_event),
+	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_comm_event__doc,
 	.tp_members	= pyrf_comm_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_comm_event__repr,
 };
 
@@ -222,9 +268,11 @@ static PyTypeObject pyrf_throttle_event__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
 	.tp_name	= "perf.throttle_event",
 	.tp_basicsize	= sizeof(struct pyrf_event),
+	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_throttle_event__doc,
 	.tp_members	= pyrf_throttle_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_throttle_event__repr,
 };
 
@@ -257,9 +305,11 @@ static PyTypeObject pyrf_lost_event__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
 	.tp_name	= "perf.lost_event",
 	.tp_basicsize	= sizeof(struct pyrf_event),
+	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_lost_event__doc,
 	.tp_members	= pyrf_lost_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_lost_event__repr,
 };
 
@@ -287,9 +337,11 @@ static PyTypeObject pyrf_read_event__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
 	.tp_name	= "perf.read_event",
 	.tp_basicsize	= sizeof(struct pyrf_event),
+	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_read_event__doc,
 	.tp_members	= pyrf_read_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_read_event__repr,
 };
 
@@ -297,16 +349,17 @@ static const char pyrf_sample_event__doc[] = PyDoc_STR("perf sample event object
 
 static PyMemberDef pyrf_sample_event__members[] = {
 	sample_members
+	sample_member_def(sample_ip, ip, T_ULONGLONG, "event ip"),
+	sample_member_def(sample_addr, addr, T_ULONGLONG, "event addr"),
+	sample_member_def(sample_phys_addr, phys_addr, T_ULONGLONG, "event physical addr"),
+	sample_member_def(sample_weight, weight, T_ULONGLONG, "event weight"),
+	sample_member_def(sample_data_src, data_src, T_ULONGLONG, "event data source"),
+	sample_member_def(sample_insn_count, insn_cnt, T_ULONGLONG, "event instruction count"),
+	sample_member_def(sample_cyc_count, cyc_cnt, T_ULONGLONG, "event cycle count"),
 	member_def(perf_event_header, type, T_UINT, "event type"),
 	{ .name = NULL, },
 };
 
-static void pyrf_sample_event__delete(struct pyrf_event *pevent)
-{
-	perf_sample__exit(&pevent->sample);
-	Py_TYPE(pevent)->tp_free((PyObject *)pevent);
-}
-
 static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
@@ -324,6 +377,8 @@ static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
 #ifdef HAVE_LIBTRACEEVENT
 static bool is_tracepoint(const struct pyrf_event *pevent)
 {
+	if (!pevent->sample.evsel)
+		return false;
 	return pevent->sample.evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
 }
 
@@ -394,6 +449,199 @@ get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 }
 #endif /* HAVE_LIBTRACEEVENT */
 
+static int pyrf_sample_event__resolve_al(struct pyrf_event *pevent)
+{
+	struct evsel *evsel = pevent->sample.evsel;
+	struct evlist *evlist = evsel ? evsel->evlist : NULL;
+	struct perf_session *session = evlist ? evlist__session(evlist) : NULL;
+
+	if (pevent->al_resolved)
+		return 0;
+
+	if (!session)
+		return -1;
+
+	addr_location__init(&pevent->al);
+	if (machine__resolve(&session->machines.host, &pevent->al, &pevent->sample) < 0) {
+		addr_location__exit(&pevent->al);
+		return -1;
+	}
+
+	pevent->al_resolved = true;
+	return 0;
+}
+
+static PyObject *pyrf_sample_event__get_dso(struct pyrf_event *pevent,
+					    void *closure __maybe_unused)
+{
+	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
+		Py_RETURN_NONE;
+
+	return PyUnicode_FromString(dso__name(map__dso(pevent->al.map)));
+}
+
+static PyObject *pyrf_sample_event__get_dso_long_name(struct pyrf_event *pevent,
+						      void *closure __maybe_unused)
+{
+	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
+		Py_RETURN_NONE;
+
+	return PyUnicode_FromString(dso__long_name(map__dso(pevent->al.map)));
+}
+
+static PyObject *pyrf_sample_event__get_dso_bid(struct pyrf_event *pevent,
+						void *closure __maybe_unused)
+{
+	char sbuild_id[SBUILD_ID_SIZE];
+
+	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
+		Py_RETURN_NONE;
+
+	build_id__snprintf(dso__bid(map__dso(pevent->al.map)), sbuild_id, sizeof(sbuild_id));
+	return PyUnicode_FromString(sbuild_id);
+}
+
+static PyObject *pyrf_sample_event__get_map_start(struct pyrf_event *pevent,
+						  void *closure __maybe_unused)
+{
+	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
+		Py_RETURN_NONE;
+
+	return PyLong_FromUnsignedLong(map__start(pevent->al.map));
+}
+
+static PyObject *pyrf_sample_event__get_map_end(struct pyrf_event *pevent,
+						void *closure __maybe_unused)
+{
+	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
+		Py_RETURN_NONE;
+
+	return PyLong_FromUnsignedLong(map__end(pevent->al.map));
+}
+
+static PyObject *pyrf_sample_event__get_map_pgoff(struct pyrf_event *pevent,
+						  void *closure __maybe_unused)
+{
+	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.map)
+		Py_RETURN_NONE;
+
+	return PyLong_FromUnsignedLongLong(map__pgoff(pevent->al.map));
+}
+
+static PyObject *pyrf_sample_event__get_symbol(struct pyrf_event *pevent,
+					       void *closure __maybe_unused)
+{
+	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.sym)
+		Py_RETURN_NONE;
+
+	return PyUnicode_FromString(pevent->al.sym->name);
+}
+
+static PyObject *pyrf_sample_event__get_sym_start(struct pyrf_event *pevent,
+						  void *closure __maybe_unused)
+{
+	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.sym)
+		Py_RETURN_NONE;
+
+	return PyLong_FromUnsignedLongLong(pevent->al.sym->start);
+}
+
+static PyObject *pyrf_sample_event__get_sym_end(struct pyrf_event *pevent,
+						void *closure __maybe_unused)
+{
+	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.sym)
+		Py_RETURN_NONE;
+
+	return PyLong_FromUnsignedLongLong(pevent->al.sym->end);
+}
+
+static PyObject *pyrf_sample_event__get_raw_buf(struct pyrf_event *pevent,
+						void *closure __maybe_unused)
+{
+	if (pevent->event.header.type != PERF_RECORD_SAMPLE)
+		Py_RETURN_NONE;
+
+	return PyBytes_FromStringAndSize((const char *)pevent->sample.raw_data,
+					 pevent->sample.raw_size);
+}
+
+static PyObject *pyrf_sample_event__srccode(PyObject *self, PyObject *args)
+{
+	struct pyrf_event *pevent = (void *)self;
+	u64 addr = pevent->sample.ip;
+	char *srcfile = NULL;
+	char *srccode = NULL;
+	unsigned int line = 0;
+	int len = 0;
+	PyObject *result;
+	struct addr_location al;
+
+	if (!PyArg_ParseTuple(args, "|K", &addr))
+		return NULL;
+
+	if (pyrf_sample_event__resolve_al(pevent) < 0)
+		Py_RETURN_NONE;
+
+	if (addr != pevent->sample.ip) {
+		addr_location__init(&al);
+		thread__find_symbol_fb(pevent->al.thread, pevent->sample.cpumode, addr, &al);
+	} else {
+		addr_location__init(&al);
+		al.thread = thread__get(pevent->al.thread);
+		al.map = map__get(pevent->al.map);
+		al.sym = pevent->al.sym;
+		al.addr = pevent->al.addr;
+	}
+
+	if (al.map) {
+		struct dso *dso = map__dso(al.map);
+
+		if (dso) {
+			srcfile = get_srcline_split(dso, map__rip_2objdump(al.map, addr),
+						    &line);
+		}
+	}
+	addr_location__exit(&al);
+
+	if (srcfile) {
+		srccode = find_sourceline(srcfile, line, &len);
+		result = Py_BuildValue("(sIs#)", srcfile, line, srccode, (Py_ssize_t)len);
+		free(srcfile);
+	} else {
+		result = Py_BuildValue("(sIs#)", NULL, 0, NULL, (Py_ssize_t)0);
+	}
+
+	return result;
+}
+
+static PyObject *pyrf_sample_event__insn(PyObject *self, PyObject *args __maybe_unused)
+{
+	struct pyrf_event *pevent = (void *)self;
+	struct thread *thread;
+	struct machine *machine;
+
+	if (pyrf_sample_event__resolve_al(pevent) < 0)
+		Py_RETURN_NONE;
+
+	thread = pevent->al.thread;
+
+	if (!thread || !thread__maps(thread))
+		Py_RETURN_NONE;
+
+	machine = maps__machine(thread__maps(thread));
+	if (!machine)
+		Py_RETURN_NONE;
+
+	if (pevent->sample.ip && !pevent->sample.insn_len)
+		perf_sample__fetch_insn(&pevent->sample, thread, machine);
+
+	if (!pevent->sample.insn_len)
+		Py_RETURN_NONE;
+
+	return PyBytes_FromStringAndSize((const char *)pevent->sample.insn,
+					 pevent->sample.insn_len);
+}
+
 static PyObject*
 pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
 {
@@ -407,13 +655,102 @@ pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
 	return obj ?: PyObject_GenericGetAttr((PyObject *) pevent, attr_name);
 }
 
+static PyGetSetDef pyrf_sample_event__getset[] = {
+	{
+		.name = "raw_buf",
+		.get = (getter)pyrf_sample_event__get_raw_buf,
+		.set = NULL,
+		.doc = "event raw buffer.",
+	},
+	{
+		.name = "evsel",
+		.get = pyrf_event__get_evsel,
+		.set = NULL,
+		.doc = "tracking event.",
+	},
+	{
+		.name = "dso",
+		.get = (getter)pyrf_sample_event__get_dso,
+		.set = NULL,
+		.doc = "event dso short name.",
+	},
+	{
+		.name = "dso_long_name",
+		.get = (getter)pyrf_sample_event__get_dso_long_name,
+		.set = NULL,
+		.doc = "event dso long name.",
+	},
+	{
+		.name = "dso_bid",
+		.get = (getter)pyrf_sample_event__get_dso_bid,
+		.set = NULL,
+		.doc = "event dso build id.",
+	},
+	{
+		.name = "map_start",
+		.get = (getter)pyrf_sample_event__get_map_start,
+		.set = NULL,
+		.doc = "event map start address.",
+	},
+	{
+		.name = "map_end",
+		.get = (getter)pyrf_sample_event__get_map_end,
+		.set = NULL,
+		.doc = "event map end address.",
+	},
+	{
+		.name = "map_pgoff",
+		.get = (getter)pyrf_sample_event__get_map_pgoff,
+		.set = NULL,
+		.doc = "event map page offset.",
+	},
+	{
+		.name = "symbol",
+		.get = (getter)pyrf_sample_event__get_symbol,
+		.set = NULL,
+		.doc = "event symbol name.",
+	},
+	{
+		.name = "sym_start",
+		.get = (getter)pyrf_sample_event__get_sym_start,
+		.set = NULL,
+		.doc = "event symbol start address.",
+	},
+	{
+		.name = "sym_end",
+		.get = (getter)pyrf_sample_event__get_sym_end,
+		.set = NULL,
+		.doc = "event symbol end address.",
+	},
+	{ .name = NULL, },
+};
+
+static PyMethodDef pyrf_sample_event__methods[] = {
+	{
+		.ml_name  = "srccode",
+		.ml_meth  = (PyCFunction)pyrf_sample_event__srccode,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR("Get source code for an address.")
+	},
+	{
+		.ml_name  = "insn",
+		.ml_meth  = (PyCFunction)pyrf_sample_event__insn,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Get instruction bytes for a sample.")
+	},
+	{ .ml_name = NULL, }
+};
+
 static PyTypeObject pyrf_sample_event__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
 	.tp_name	= "perf.sample_event",
 	.tp_basicsize	= sizeof(struct pyrf_event),
+	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_sample_event__doc,
 	.tp_members	= pyrf_sample_event__members,
+	.tp_getset	= pyrf_sample_event__getset,
+	.tp_methods	= pyrf_sample_event__methods,
 	.tp_repr	= (reprfunc)pyrf_sample_event__repr,
 	.tp_getattro	= (getattrofunc) pyrf_sample_event__getattro,
 };
@@ -449,25 +786,17 @@ static PyTypeObject pyrf_context_switch_event__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
 	.tp_name	= "perf.context_switch_event",
 	.tp_basicsize	= sizeof(struct pyrf_event),
+	.tp_dealloc	= (destructor)pyrf_event__delete,
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_context_switch_event__doc,
 	.tp_members	= pyrf_context_switch_event__members,
+	.tp_getset	= pyrf_event__getset,
 	.tp_repr	= (reprfunc)pyrf_context_switch_event__repr,
 };
 
 static int pyrf_event__setup_types(void)
 {
 	int err;
-	pyrf_mmap_event__type.tp_new =
-	pyrf_task_event__type.tp_new =
-	pyrf_comm_event__type.tp_new =
-	pyrf_lost_event__type.tp_new =
-	pyrf_read_event__type.tp_new =
-	pyrf_sample_event__type.tp_new =
-	pyrf_context_switch_event__type.tp_new =
-	pyrf_throttle_event__type.tp_new = PyType_GenericNew;
-
-	pyrf_sample_event__type.tp_dealloc = (destructor)pyrf_sample_event__delete,
 
 	err = PyType_Ready(&pyrf_mmap_event__type);
 	if (err < 0)
@@ -511,33 +840,57 @@ static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_SWITCH_CPU_WIDE]  = &pyrf_context_switch_event__type,
 };
 
-static PyObject *pyrf_event__new(const union perf_event *event)
+static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *evsel)
 {
 	struct pyrf_event *pevent;
-	PyTypeObject *ptype;
+	int err;
+	u32 min_size;
+	bool needs_swap;
 
-	if ((event->header.type < PERF_RECORD_MMAP ||
-	     event->header.type > PERF_RECORD_SAMPLE) &&
-	    !(event->header.type == PERF_RECORD_SWITCH ||
-	      event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)) {
-		PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
+	if (event->header.type >= ARRAY_SIZE(pyrf_event__type) ||
+	    pyrf_event__type[event->header.type] == NULL) {
+		return PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
 			     event->header.type);
-		return NULL;
 	}
 
-	// FIXME this better be dynamic or we need to parse everything
-	// before calling perf_mmap__consume(), including tracepoint fields.
-	if (sizeof(pevent->event) < event->header.size) {
-		PyErr_Format(PyExc_TypeError, "Unexpected event size: %zd < %u",
-			     sizeof(pevent->event), event->header.size);
-		return NULL;
+	if (perf_event__too_small(event, &min_size)) {
+		return PyErr_Format(PyExc_ValueError, "Event size %u too small for type %u",
+				    event->header.size, event->header.type);
 	}
 
-	ptype = pyrf_event__type[event->header.type];
-	pevent = PyObject_New(struct pyrf_event, ptype);
-	if (pevent != NULL) {
-		memcpy(&pevent->event, event, event->header.size);
-		perf_sample__init(&pevent->sample, /*all=*/false);
+	size_t copy_size = event->header.size;
+
+	if (copy_size > sizeof(pevent->event)) {
+		return PyErr_Format(PyExc_TypeError, "Unexpected event size: %zd < %zu",
+				    sizeof(pevent->event), copy_size);
+	}
+
+	pevent = PyObject_New(struct pyrf_event, pyrf_event__type[event->header.type]);
+	if (pevent == NULL)
+		return PyErr_NoMemory();
+
+	/* Copy the event for memory safety and initialize variables. */
+	memcpy(&pevent->event, event, copy_size);
+	if (copy_size < sizeof(pevent->event))
+		memset((char *)&pevent->event + copy_size, 0, sizeof(pevent->event) - copy_size);
+
+	perf_sample__init(&pevent->sample, /*all=*/true);
+	pevent->al_resolved = false;
+	addr_location__init(&pevent->al);
+
+	if (!evsel)
+		return (PyObject *)pevent;
+
+	/* Parse the sample again so that pointers are within the copied event. */
+	needs_swap = evsel->needs_swap;
+
+	evsel->needs_swap = false;
+	err = evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
+	evsel->needs_swap = needs_swap;
+	if (err < 0) {
+		Py_DECREF(pevent);
+		return PyErr_Format(PyExc_OSError,
+				    "perf: can't parse sample, err=%d", err);
 	}
 	return (PyObject *)pevent;
 }
@@ -1244,7 +1597,7 @@ static PyObject *pyrf_evsel__str(PyObject *self)
 	if (!evsel)
 		return PyUnicode_FromString("evsel(uninitialized)");
 
-	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel__pmu_name(evsel), evsel__name(evsel));
+	return PyUnicode_FromFormat("evsel(%s)", evsel__name(evsel));
 }
 
 static PyMethodDef pyrf_evsel__methods[] = {
@@ -1878,9 +2231,11 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 {
 	struct evlist *evlist;
 	union perf_event *event;
+	struct evsel *evsel;
 	int sample_id_all = 1, cpu;
 	static char *kwlist[] = { "cpu", "sample_id_all", NULL };
 	struct mmap *md;
+	PyObject *pyevent;
 	int err;
 
 	CHECK_INITIALIZED(pevlist->evlist, "evlist");
@@ -1891,44 +2246,33 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		return NULL;
 
 	md = get_md(evlist, cpu);
-	if (!md) {
-		PyErr_Format(PyExc_TypeError, "Unknown CPU '%d'", cpu);
-		return NULL;
-	}
+	if (!md)
+		return PyErr_Format(PyExc_TypeError, "Unknown CPU '%d'", cpu);
 
-	if (perf_mmap__read_init(&md->core) < 0)
-		goto end;
+	err = perf_mmap__read_init(&md->core);
+	if (err < 0) {
+		if (err == -EAGAIN)
+			Py_RETURN_NONE;
+		return PyErr_Format(PyExc_OSError,
+				    "perf: error mmap read init, err=%d", err);
+	}
 
 	event = perf_mmap__read_event(&md->core);
-	if (event != NULL) {
-		PyObject *pyevent = pyrf_event__new(event);
-		struct pyrf_event *pevent = (struct pyrf_event *)pyevent;
-		struct evsel *evsel;
-
-		if (pyevent == NULL)
-			return PyErr_NoMemory();
-
-		evsel = evlist__event2evsel(evlist, event);
-		if (!evsel) {
-			Py_DECREF(pyevent);
-			Py_INCREF(Py_None);
-			return Py_None;
-		}
+	if (event == NULL)
+		Py_RETURN_NONE;
 
+	evsel = evlist__event2evsel(evlist, event);
+	if (!evsel) {
+		/* Unknown evsel. */
 		perf_mmap__consume(&md->core);
-
-		err = evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
-		if (err) {
-			Py_DECREF(pyevent);
-			return PyErr_Format(PyExc_OSError,
-					    "perf: can't parse sample, err=%d", err);
-		}
-
-		return pyevent;
+		Py_RETURN_NONE;
 	}
-end:
-	Py_INCREF(Py_None);
-	return Py_None;
+	pyevent = pyrf_event__new(event, evsel);
+	perf_mmap__consume(&md->core);
+	if (pyevent == NULL)
+		return PyErr_Occurred() ? NULL : PyErr_NoMemory();
+
+	return pyevent;
 }
 
 static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
@@ -2140,10 +2484,7 @@ static PyObject *pyrf_evlist__str(PyObject *self)
 	evlist__for_each_entry(pevlist->evlist, pos) {
 		if (!first)
 			strbuf_addch(&sb, ',');
-		if (!pos->pmu)
-			strbuf_addstr(&sb, evsel__name(pos));
-		else
-			strbuf_addf(&sb, "%s/%s/", pos->pmu->name, evsel__name(pos));
+		strbuf_addstr(&sb, evsel__name(pos));
 		first = false;
 	}
 	strbuf_addstr(&sb, "])");
@@ -2696,26 +3037,12 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
 				     struct machine *machine __maybe_unused)
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
-	PyObject *pyevent = pyrf_event__new(event);
-	struct pyrf_event *pevent = (struct pyrf_event *)pyevent;
+	PyObject *pyevent = pyrf_event__new(event, sample->evsel);
 	PyObject *ret;
-	bool needs_swap;
 
 	if (pyevent == NULL)
 		return -ENOMEM;
 
-	needs_swap = sample->evsel->needs_swap;
-
-	memcpy(&pevent->event, event, event->header.size);
-	/* The event is already swapped, disable swapping temporarily */
-	sample->evsel->needs_swap = false;
-	if (evsel__parse_sample(sample->evsel, &pevent->event, &pevent->sample) < 0) {
-		sample->evsel->needs_swap = needs_swap;
-		Py_DECREF(pyevent);
-		return -1;
-	}
-	sample->evsel->needs_swap = needs_swap;
-
 	ret = PyObject_CallFunction(psession->sample, "O", pyevent);
 	if (!ret) {
 		Py_DECREF(pyevent);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 18af70488e07..004593b8675f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2672,7 +2672,7 @@ static const u32 perf_event__min_size[PERF_RECORD_HEADER_MAX] = {
  * Caller must ensure event->header.type < PERF_RECORD_HEADER_MAX.
  * If min is non-NULL, stores the required minimum on failure.
  */
-static bool perf_event__too_small(const union perf_event *event, u32 *min)
+bool perf_event__too_small(const union perf_event *event, u32 *min)
 {
 	u32 min_sz = perf_event__min_size[event->header.type];
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index d554e2a1a50e..ac5803d5fb4e 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -122,6 +122,8 @@ void perf_session__delete(struct perf_session *session);
 
 void perf_event_header__bswap(struct perf_event_header *hdr);
 
+bool perf_event__too_small(const union perf_event *event, u32 *min);
+
 int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 			     void *buf, size_t buf_sz,
 			     union perf_event **event_ptr,
-- 
2.54.0.1136.gdb2ca164c4-goog

