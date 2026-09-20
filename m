Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC03D47C0
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881779; cv=none; b=Eusc8OAwm34dj8WGkCPuMyuMGrXnm1DhXBJmGhpmnpqjvbPuBLD/6KxWjy+zyoR8oYgP4y1WhwD9zuHi+gxgsfj0UrI2Ae+CBzJQ8J3ztfYWGZZpNd8c07+lUuWhrYRbIqA1wFlzNq5FLktMKaHYpKrUyumx2XC+q+NVcmedDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881779; c=relaxed/simple;
	bh=7r/bTHh0ScTAyQwcYIRK3GzSDEyuQ23uw0vfe0MckBw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YiUFIawRuc2fImIPhcSYAldYoKdAPso3GSDA7HVuUsG0tyT63QDJBKtgu6Y0wnZvny5J6Uatw2WTYv5gjfSBI52DDBzSfy/5MM/o1O9+fZAgZt2QK9J5wFd64PXiMvY7oNCC/hFOZnpiuAmhU5xG5OaGP00jgJNcde3mgOumKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E7i3fcxc; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E7i3fcxc"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b80835d5so2710927a12.2
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881772; x=1790486572; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TAr3JsSecIvU8RuLJP8w4tdcPJ2utP0RVG4o7rqJXfI=;
        b=E7i3fcxc/vhDqIkRDR8SJG7obvyhZ52DC0k7djG8LZxUH0CYSNEdwxRLD77/W72Cwc
         M/xNWpOEThidgwwhQSVp6Uwz/Nq++ocheK/jyyuqRDVOAN5Ys5ABbBITFcn0JddBvUA6
         tRK5GzQZmxvhNqa5hb+E0FoHpx/7vwtP+UAIVt6P5JEvTM3toxMv6+KvI07fCuAWtUil
         gT8r+XvSRnOcTeCKETT0qFEkwgdk/gC1TOtvifwzMWJlmBXrPC/4bqd3uimUPAp+6LLN
         KgCrK52/Dfzyu1cdaCvFVB7F13zfos8GnMPJD9pOe5OO+SouJ/eRgO/exepHg5D4+0MP
         ea6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881772; x=1790486572;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAr3JsSecIvU8RuLJP8w4tdcPJ2utP0RVG4o7rqJXfI=;
        b=JM+J5WOL6HWzxfyIayN5ZREtPaR9lqWQR4SiNOjVNqwQRErmo+iBcgdrfcNGOUN8Eu
         8ucbzJEVNGbxCEtkE96sxMuZfqQ6Ua/lUNXEnZC4Ct7Nd8fGQJW2f+9UJW/1Ee0bithf
         875vP3FUblw6/IZ8MkNI2XqwxBhpI8f47t3ZwFs8Ed7mTh1RF0Dt52Ill3MZ6nla58Wd
         CRl5Ahs/5i/+BoUlm6Z+baqY8mHgif7rDgZejqzvyKuyseMJ/uZHFwEaa2OZNn9kK59E
         eAjqMfkQ51g22aBs1Gclqex+kf1A3cSZkuzZ3fq5BEp6mnlM0N8+04lMnUeARvSoEasK
         CUxQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7j6+Nxl2ESCvNiuPUsLrQgW/d6DdJTKtVpeMls804fKUoDUxhU6CAfI4oGEGXt8NXlPzM1Ulca2vOfw139312@vger.kernel.org
X-Gm-Message-State: AFuF++ndeCRkL1LkYIfR+il04babNmVxt5IFcjjH2Yk2k7/LxuIF2uck
	06JpquJvwWe29xFs8JulJdccyV4t1BSlQ9K8so8LKwEfk7utY/XGdsMxM9JJrxdEs5yk/C6Qz+T
	wvr2/cdUC1A==
X-Received: from dleb12-n2.prod.google.com ([2002:a05:701b:424c:20b0:13c:fe05:89a3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9d8e:b0:3dd:a197:cf2f
 with SMTP id adf61e73a8af0-3dda197d85dmr5741846637.83.1789881772168; Sat, 19
 Sep 2026 22:22:52 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:00 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <b8e1b4ae6cb475a56bcd2c48130ac1f8ca036ddb.1789880842.git.irogers@google.com>
Subject: [PATCH v1 08/49] perf python: Expose addr location, transaction, and context_switch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Expose destination address location components (addr_dso, addr_symbol,
addr_sym_offset), branch/transaction metrics (branch_type, in_tx,
flags, transaction), machine_pid, vcpu, sym_offset, and context_switch
callbacks directly to the Python extension.

Also include supporting fixes and infrastructure updates in
util/python.c and perf.pyi:
- Support fetching sym_offset on resolved sample symbols.
- Populate sample machine_pid and vcpu from evlist__id2sid() when
  perf_guest is enabled, and resolve samples against the matching guest
  or host machine.
- Expose next_prev_pid and next_prev_tid on switch_event only for
  PERF_RECORD_SWITCH_CPU_WIDE records (returning None otherwise).
- Wire up tracing_data in pyrf_session__new(), use 'static char * const
  kwlist[]', and update perf.pyi type stubs (including srccode() and
  insn() return types).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/perf.pyi |  22 +++-
 tools/perf/util/python.c   | 249 +++++++++++++++++++++++++++++++++++--
 2 files changed, 253 insertions(+), 18 deletions(-)

diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
index e5259e9b61dd..7f747eed3eda 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -182,6 +182,8 @@ class _sample_members:
     sample_time: int
     sample_id: int
     sample_stream_id: int
+    machine_pid: int
+    vcpu: int
     sample_period: int
     sample_cpu: int
 
@@ -206,10 +208,18 @@ class sample_event(_sample_members):
     symbol: str
     sym_start: int
     sym_end: int
+    sym_offset: Optional[int]
+    addr_dso: Optional[str]
+    addr_symbol: Optional[str]
+    addr_sym_offset: Optional[int]
+    branch_type: int
+    in_tx: int
+    flags: int
+    transaction: int
     brstack: Optional['branch_stack']
     callchain: Optional['callchain']
-    def srccode(self) -> str: ...
-    def insn(self) -> str: ...
+    def srccode(self) -> Optional[tuple[str, int, str]]: ...
+    def insn(self) -> Optional[bytes]: ...
     def __getattr__(self, name: str) -> Any: ...
 
 class mmap_event(_sample_members):
@@ -286,8 +296,9 @@ class read_event(_sample_members):
 class switch_event(_sample_members):
     """Represents a SWITCH or SWITCH_CPU_WIDE record."""
     type: int
-    next_prev_pid: int
-    next_prev_tid: int
+    misc: int
+    next_prev_pid: Optional[int]
+    next_prev_tid: Optional[int]
     evsel: Optional['evsel']
 
 class branch_entry:
@@ -429,7 +440,8 @@ class session:
         self,
         data: data,
         sample: Optional[Callable[[sample_event], None]] = None,
-        stat: Optional[Callable[[Any, Optional[str]], None]] = None
+        stat: Optional[Callable[[Any, Optional[str]], None]] = None,
+        context_switch: Optional[Callable[[switch_event], None]] = None,
     ) -> None:
         """Initialize a perf session.
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index fbfa71b1c4b6..49f37198f4b3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3,6 +3,7 @@
 #include <Python.h>
 
 #include <inttypes.h>
+#include <stdio.h>
 #include <string.h>
 
 #include <linux/err.h>
@@ -106,6 +107,8 @@ struct pyrf_event {
 	sample_member_def(sample_time, time, T_ULONGLONG, "event timestamp"),		 \
 	sample_member_def(sample_id, id, T_ULONGLONG, "event id"),			 \
 	sample_member_def(sample_stream_id, stream_id, T_ULONGLONG, "event stream id"), \
+	sample_member_def(machine_pid, machine_pid, T_UINT, "event machine pid"),	 \
+	sample_member_def(vcpu, vcpu, T_UINT, "event vcpu"),				 \
 	sample_member_def(sample_period, period, T_ULONGLONG, "event period"),		 \
 	sample_member_def(sample_cpu, cpu, T_UINT, "event cpu"),
 
@@ -581,6 +584,7 @@ static PyMemberDef pyrf_sample_event__members[] = {
 	sample_member_def(sample_data_src, data_src, T_ULONGLONG, "event data source"),
 	sample_member_def(sample_insn_count, insn_cnt, T_ULONGLONG, "event instruction count"),
 	sample_member_def(sample_cyc_count, cyc_cnt, T_ULONGLONG, "event cycle count"),
+	sample_member_def(flags, flags, T_UINT, "event flags"),
 	member_def(perf_event_header, type, T_UINT, "event type"),
 	{ .name = NULL, },
 };
@@ -679,6 +683,7 @@ static int pyrf_sample_event__resolve_al(struct pyrf_event *pevent)
 	struct evsel *evsel = pevent->sample.evsel;
 	struct evlist *evlist = evsel ? evsel->evlist : NULL;
 	struct perf_session *session = evlist ? evlist__session(evlist) : NULL;
+	struct machine *machine;
 
 	if (pevent->al_resolved)
 		return 0;
@@ -686,8 +691,14 @@ static int pyrf_sample_event__resolve_al(struct pyrf_event *pevent)
 	if (!session)
 		return -1;
 
+	machine = pevent->sample.machine_pid ?
+		machines__find(&session->machines, pevent->sample.machine_pid) :
+		&session->machines.host;
+	if (!machine)
+		machine = &session->machines.host;
+
 	addr_location__init(&pevent->al);
-	if (machine__resolve(&session->machines.host, &pevent->al, &pevent->sample) < 0) {
+	if (machine__resolve(machine, &pevent->al, &pevent->sample) < 0) {
 		addr_location__exit(&pevent->al);
 		return -1;
 	}
@@ -771,6 +782,15 @@ static PyObject *pyrf_sample_event__get_sym_start(struct pyrf_event *pevent,
 	return PyLong_FromUnsignedLongLong(pevent->al.sym->start);
 }
 
+static PyObject *pyrf_sample_event__get_sym_offset(struct pyrf_event *pevent,
+						   void *closure __maybe_unused)
+{
+	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.sym)
+		Py_RETURN_NONE;
+
+	return PyLong_FromUnsignedLongLong(pevent->al.addr - pevent->al.sym->start);
+}
+
 static PyObject *pyrf_sample_event__get_sym_end(struct pyrf_event *pevent,
 						void *closure __maybe_unused)
 {
@@ -1166,7 +1186,115 @@ pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
 	return obj ?: PyObject_GenericGetAttr((PyObject *) pevent, attr_name);
 }
 
+
+static int pyrf_sample_event__resolve_addr_al(struct pyrf_event *pevent,
+					      struct addr_location *addr_al)
+{
+	addr_location__init(addr_al);
+	if (pyrf_sample_event__resolve_al(pevent) < 0 || !pevent->al.thread)
+		return -1;
+
+	thread__find_symbol_fb(pevent->al.thread, pevent->sample.cpumode,
+			       pevent->sample.addr, addr_al);
+	return 0;
+}
+
+static PyObject *pyrf_sample_event__get_addr_dso(struct pyrf_event *pevent,
+						 void *closure __maybe_unused)
+{
+	struct addr_location addr_al;
+	PyObject *ret = Py_None;
+
+	if (pyrf_sample_event__resolve_addr_al(pevent, &addr_al) == 0 && addr_al.map)
+		ret = PyUnicode_FromString(dso__name(map__dso(addr_al.map)));
+	else
+		Py_INCREF(Py_None);
+
+	addr_location__exit(&addr_al);
+	return ret;
+}
+
+static PyObject *pyrf_sample_event__get_addr_symbol(struct pyrf_event *pevent,
+						    void *closure __maybe_unused)
+{
+	struct addr_location addr_al;
+	PyObject *ret = Py_None;
+
+	if (pyrf_sample_event__resolve_addr_al(pevent, &addr_al) == 0 && addr_al.sym)
+		ret = PyUnicode_FromString(addr_al.sym->name);
+	else
+		Py_INCREF(Py_None);
+
+	addr_location__exit(&addr_al);
+	return ret;
+}
+
+static PyObject *pyrf_sample_event__get_addr_sym_offset(struct pyrf_event *pevent,
+							void *closure __maybe_unused)
+{
+	struct addr_location addr_al;
+	PyObject *ret = Py_None;
+
+	if (pyrf_sample_event__resolve_addr_al(pevent, &addr_al) == 0 && addr_al.sym)
+		ret = PyLong_FromUnsignedLongLong(addr_al.addr - addr_al.sym->start);
+	else
+		Py_INCREF(Py_None);
+
+	addr_location__exit(&addr_al);
+	return ret;
+}
+
+static PyObject *pyrf_sample_event__get_branch_type(struct pyrf_event *pevent,
+						    void *closure __maybe_unused)
+{
+	return PyLong_FromUnsignedLong(pevent->sample.flags & PERF_BRANCH_MASK);
+}
+
+static PyObject *pyrf_sample_event__get_in_tx(struct pyrf_event *pevent,
+					      void *closure __maybe_unused)
+{
+	return PyLong_FromUnsignedLong(!!(pevent->sample.flags & PERF_IP_FLAG_IN_TX));
+}
+
+static PyObject *pyrf_sample_event__get_transaction(struct pyrf_event *pevent,
+						    void *closure __maybe_unused)
+{
+	return PyLong_FromUnsignedLongLong(pevent->sample.transaction);
+}
+
 static PyGetSetDef pyrf_sample_event__getset[] = {
+
+	{
+		.name = "addr_dso",
+		.get = (getter)pyrf_sample_event__get_addr_dso,
+		.doc = "event destination dso.",
+	},
+	{
+		.name = "addr_symbol",
+		.get = (getter)pyrf_sample_event__get_addr_symbol,
+		.doc = "event destination symbol.",
+	},
+	{
+		.name = "addr_sym_offset",
+		.get = (getter)pyrf_sample_event__get_addr_sym_offset,
+		.doc = "event destination symbol offset.",
+	},
+	{
+		.name = "branch_type",
+		.get = (getter)pyrf_sample_event__get_branch_type,
+		.doc = "branch type.",
+	},
+	{
+		.name = "in_tx",
+		.get = (getter)pyrf_sample_event__get_in_tx,
+		.doc = "in transaction flag.",
+	},
+	{
+		.name = "transaction",
+		.get = (getter)pyrf_sample_event__get_transaction,
+		.doc = "transaction execution.",
+	},
+
 	{
 		.name = "callchain",
 		.get = pyrf_sample_event__get_callchain,
@@ -1227,6 +1355,12 @@ static PyGetSetDef pyrf_sample_event__getset[] = {
 		.set = NULL,
 		.doc = "event map page offset.",
 	},
+	{
+		.name = "sym_offset",
+		.get = (getter)pyrf_sample_event__get_sym_offset,
+		.set = NULL,
+		.doc = "event symbol offset.",
+	},
 	{
 		.name = "symbol",
 		.get = (getter)pyrf_sample_event__get_symbol,
@@ -1283,8 +1417,45 @@ static const char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_swi
 static PyMemberDef pyrf_context_switch_event__members[] = {
 	sample_members
 	member_def(perf_event_header, type, T_UINT, "event type"),
-	member_def(perf_record_switch, next_prev_pid, T_UINT, "next/prev pid"),
-	member_def(perf_record_switch, next_prev_tid, T_UINT, "next/prev tid"),
+	member_def(perf_event_header, misc, T_USHORT, "event misc"),
+	{ .name = NULL, },
+};
+
+static PyObject *pyrf_context_switch_event__get_next_prev_pid(const struct pyrf_event *pevent,
+							      void *closure __maybe_unused)
+{
+	if (pevent->event.header.type == PERF_RECORD_SWITCH_CPU_WIDE)
+		return PyLong_FromUnsignedLong(pevent->event.context_switch.next_prev_pid);
+	Py_RETURN_NONE;
+}
+
+static PyObject *pyrf_context_switch_event__get_next_prev_tid(const struct pyrf_event *pevent,
+							      void *closure __maybe_unused)
+{
+	if (pevent->event.header.type == PERF_RECORD_SWITCH_CPU_WIDE)
+		return PyLong_FromUnsignedLong(pevent->event.context_switch.next_prev_tid);
+	Py_RETURN_NONE;
+}
+
+static PyGetSetDef pyrf_context_switch_event__getset[] = {
+	{
+		.name = "evsel",
+		.get = pyrf_event__get_evsel,
+		.set = NULL,
+		.doc = "tracking event.",
+	},
+	{
+		.name = "next_prev_pid",
+		.get = (getter)pyrf_context_switch_event__get_next_prev_pid,
+		.set = NULL,
+		.doc = "next/prev pid for CPU-wide switch, or None.",
+	},
+	{
+		.name = "next_prev_tid",
+		.get = (getter)pyrf_context_switch_event__get_next_prev_tid,
+		.set = NULL,
+		.doc = "next/prev tid for CPU-wide switch, or None.",
+	},
 	{ .name = NULL, },
 };
 
@@ -1292,11 +1463,19 @@ static PyObject *pyrf_context_switch_event__repr(const struct pyrf_event *pevent
 {
 	PyObject *ret;
 	char *s;
-
-	if (asprintf(&s, "{ type: context_switch, next_prev_pid: %u, next_prev_tid: %u, switch_out: %u }",
-		     pevent->event.context_switch.next_prev_pid,
-		     pevent->event.context_switch.next_prev_tid,
-		     !!(pevent->event.header.misc & PERF_RECORD_MISC_SWITCH_OUT)) < 0) {
+	int res;
+
+	if (pevent->event.header.type == PERF_RECORD_SWITCH_CPU_WIDE) {
+		res = asprintf(&s,
+			"{ type: context_switch, next_prev_pid: %u, next_prev_tid: %u, switch_out: %u }",
+			pevent->event.context_switch.next_prev_pid,
+			pevent->event.context_switch.next_prev_tid,
+			!!(pevent->event.header.misc & PERF_RECORD_MISC_SWITCH_OUT));
+	} else {
+		res = asprintf(&s, "{ type: context_switch, switch_out: %u }",
+			       !!(pevent->event.header.misc & PERF_RECORD_MISC_SWITCH_OUT));
+	}
+	if (res < 0) {
 		ret = PyErr_NoMemory();
 	} else {
 		ret = PyUnicode_FromString(s);
@@ -1313,7 +1492,7 @@ static PyTypeObject pyrf_context_switch_event__type = {
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_context_switch_event__doc,
 	.tp_members	= pyrf_context_switch_event__members,
-	.tp_getset	= pyrf_event__getset,
+	.tp_getset	= pyrf_context_switch_event__getset,
 	.tp_repr	= (reprfunc)pyrf_context_switch_event__repr,
 };
 
@@ -1450,6 +1629,16 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 		return PyErr_Format(PyExc_OSError,
 				    "perf: can't parse sample, err=%d", err);
 	}
+	if (session && session->evlist && perf_guest && pevent->sample.id) {
+		struct perf_sample_id *sid = evlist__id2sid(session->evlist, pevent->sample.id);
+
+		if (sid) {
+			pevent->sample.machine_pid = sid->machine_pid;
+			pevent->sample.vcpu = sid->vcpu.cpu;
+		}
+	}
+	if (machine && machine->pid > 0 && !pevent->sample.machine_pid)
+		pevent->sample.machine_pid = machine->pid;
 	sample = &pevent->sample;
 	if (machine && sample->callchain) {
 		struct addr_location al;
@@ -3837,6 +4026,7 @@ struct pyrf_session {
 	struct pyrf_data *pdata;
 	PyObject *sample;
 	PyObject *stat;
+	PyObject *context_switch;
 };
 
 static int pyrf_session_tool__sample(const struct perf_tool *tool,
@@ -3861,6 +4051,33 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
 	return 0;
 }
 
+static int pyrf_session_tool__context_switch(const struct perf_tool *tool,
+					     union perf_event *event,
+					     struct perf_sample *sample,
+					     struct machine *machine)
+{
+	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
+	PyObject *pyevent = pyrf_event__new(event, sample->evsel, psession->session, machine);
+	PyObject *ret;
+
+	if (perf_event__process_switch(tool, event, sample, machine) < 0) {
+		Py_XDECREF(pyevent);
+		return -1;
+	}
+
+	if (pyevent == NULL)
+		return -ENOMEM;
+
+	ret = PyObject_CallFunction(psession->context_switch, "O", pyevent);
+	if (!ret) {
+		Py_DECREF(pyevent);
+		return -1;
+	}
+	Py_DECREF(ret);
+	Py_DECREF(pyevent);
+	return 0;
+}
+
 static int pyrf_session_tool__stat(const struct perf_tool *tool,
 				   struct perf_session *session,
 				   union perf_event *event)
@@ -3943,13 +4160,13 @@ static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObje
 static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject *kwargs)
 {
 	struct pyrf_data *pdata;
-	PyObject *sample = NULL, *stat = NULL;
-	static char *kwlist[] = { "data", "sample", "stat", NULL };
+	PyObject *sample = NULL, *stat = NULL, *context_switch = NULL;
+	static char * const kwlist[] = { "data", "sample", "stat", "context_switch", NULL };
 	struct pyrf_session *psession;
 	struct perf_session *session;
 
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O!|OO", kwlist, &pyrf_data__type, &pdata,
-					 &sample, &stat))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O!|OOO", kwlist, &pyrf_data__type, &pdata,
+					 &sample, &stat, &context_switch))
 		return NULL;
 
 	psession = PyObject_New(struct pyrf_session, type);
@@ -3959,6 +4176,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	psession->session = NULL;
 	psession->sample = NULL;
 	psession->stat = NULL;
+	psession->context_switch = NULL;
 	psession->pdata = NULL;
 
 	Py_INCREF(pdata);
@@ -3982,6 +4200,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 
 	ADD_TOOL(sample);
 	ADD_TOOL(stat);
+	ADD_TOOL(context_switch);
 	#undef ADD_TOOL
 
 	if (stat)
@@ -4000,6 +4219,9 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	psession->tool.build_id         = perf_event__process_build_id;
 	psession->tool.attr		= perf_event__process_attr;
 	psession->tool.feature		= perf_event__process_feature;
+#ifdef HAVE_LIBTRACEEVENT
+	psession->tool.tracing_data	= perf_event__process_tracing_data;
+#endif
 
 	session = perf_session__new(&pdata->data, &psession->tool);
 	if (IS_ERR(session)) {
@@ -4030,6 +4252,7 @@ static void pyrf_session__delete(struct pyrf_session *psession)
 	Py_XDECREF(psession->pdata);
 	Py_XDECREF(psession->sample);
 	Py_XDECREF(psession->stat);
+	Py_XDECREF(psession->context_switch);
 	Py_TYPE(psession)->tp_free((PyObject *)psession);
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog

