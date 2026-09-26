Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881C138944E
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403678; cv=none; b=g/RUdfmSTPIAvLxMsegSivS/EGlKMfW6pClnwRHILY8hDKdxea00SiGEsv9iCWWJql7nj6pd8FDGS3K+mVrR6ArfBscLJGEO18Lc8sVBUzdITxf76K8emK4tO2ZHoQwBmD1H1NSy53bxBFGpnvBemo/cpI2vLjeQOdd/TqiXBsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403678; c=relaxed/simple;
	bh=YmUqhj/1l5AJh9mtZ27SFakHGqB/yPvGoB+TDHTYAmo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XF+Rh1VSYlofH+VTty0z/b9ADmhYeaf2gxkSSHEr28NO1uv0H80WaNUD82i+txAfQqx6OMYD8k5sghX3WNgR9JmUo2zPp9beSIti27v/VzV0iujimpaU1lJSa9rcbUnhKclqYCssqgzbDAJdQGHDNZ9TEL3DapfBJtcno8kUgbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oMv3c2Ae; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oMv3c2Ae"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so3397507eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403675; x=1791008475; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5FsBEC30ubFR8P2HspjwaXniTpxKI6Ko79tBrfrlfRs=;
        b=oMv3c2AeLnjXM4Zbhjz7EoLv+019OdZ4oEEGrQYwdRXtqesxG0VzetPMf6eAe0Xzl3
         0RwC6qOwzHHKlVjweJfwjNI2L5DuLApFMZIxh7sqq0g4AwUl6gv6wcCRn4KIh7bRlG3P
         UGYRFS/DFQg9fvLUii23TfRQCPT9c02qY3uTfNWew75XVQnOctyv9RMUvv2qgcBoGjsq
         BTCTItYb0Uj1tY30p92BRhEcIciDcyPJZm2XnAwV0Fz1wGKVVDqGfJgtLAn0h4UVITGd
         MhMtUJQj7WbZX9Fz9cP1vprQXMQbxUSleBYBz7OsN51ndJ+C7pfV/9viStBiR5D7RbY3
         vJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403675; x=1791008475;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5FsBEC30ubFR8P2HspjwaXniTpxKI6Ko79tBrfrlfRs=;
        b=DsrXYCsbb0yaEsQ5mPNuokpbmrqKt4ZFlTlyt2ZKoNDPqNQrF288gYJwH8kfT+lxCd
         T68B67TZWuFXzuOkQ0oq+g312U0ow2v1U6TozIi1vNJkrRcGhMQtRYSHDQTbE+5jpoAo
         nUV0rDthMmFOefFJ8koTbXinpTnLNl8ftHHKFUfEVQt/QxpA+h8hjxu0O88i1VWViXzK
         pjIQ4QBZjE8jt51VSG0RojzIoLAia/63LlZ4HzE76F5dGsTskFgNY4QETJDAx+gLcUbW
         aya0y4AUAsOKBIB7kSDLHLW7XD6HtMq9ca8Qo5b5n9MdZ90LHpIOnB3gg+cmbSA2QLgw
         CsyA==
X-Forwarded-Encrypted: i=1; AKwUvBwAWpAaVMA1VH6vMrfYVV/u8w4qTYxKTjTwRS7wXtJtUeCVwaiB4+VEtHRCUgSea8s6lWtAuD3fKdQWYpcls+mE@vger.kernel.org
X-Gm-Message-State: AFuF++kBzgPXeDEPN5X+bkqbkQD6HIEDqkVdHKTgAPyV3V6sHngu1BlR
	c4WLoOfpc8NX4H+0RBCH5PlLXxx/Qd/9iDtPhFP3m6nrZM0yTBU6DnOEdYJf56AysHMxRm0UKg8
	r6WoLKFapvQ==
X-Received: from dlbrs4.prod.google.com ([2002:a05:7022:f684:b0:144:3f31:5c89])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:424d:10b0:144:ddf7:2570
 with SMTP id a92af1059eb24-146d077bc3dmr1939564c88.39.1790403674346; Fri, 25
 Sep 2026 23:21:14 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:35 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-9-irogers@google.com>
Subject: [PATCH v4 08/49] perf python: Expose addr location, transaction, and context_switch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
- Wire up tracing_data in pyrf_session__new() and update perf.pyi type
  stubs (including srccode() and insn() return types).

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/perf.pyi |  23 ++-
 tools/perf/util/python.c   | 291 ++++++++++++++++++++++++++++++++++---
 2 files changed, 289 insertions(+), 25 deletions(-)

diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
index 92aad84ca542..44c693761838 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -194,6 +194,8 @@ class _sample_members:
     sample_time: int
     sample_id: int
     sample_stream_id: int
+    machine_pid: int
+    vcpu: int
     sample_period: int
     sample_cpu: int
 
@@ -218,10 +220,18 @@ class sample_event(_sample_members):
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
+    def srccode(self) -> Optional[tuple[Optional[str], int, Optional[str]]]: ...
+    def insn(self) -> Optional[bytes]: ...
     def __getattr__(self, name: str) -> Any: ...
 
 class mmap_event(_sample_members):
@@ -298,8 +308,9 @@ class read_event(_sample_members):
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
@@ -334,6 +345,7 @@ class callchain_node:
     ip: int
     symbol: str
     dso: str
+    sym_offset: Optional[int]
 
 class callchain:
     """Sequence of callchain frames."""
@@ -441,7 +453,8 @@ class session:
         self,
         data: data,
         sample: Optional[Callable[[sample_event], None]] = None,
-        stat: Optional[Callable[[Any, Optional[str]], None]] = None
+        stat: Optional[Callable[[Any, Optional[str]], None]] = None,
+        context_switch: Optional[Callable[[switch_event], None]] = None,
     ) -> None:
         """Initialize a perf session.
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 40b327801b7d..526d0e197230 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2,9 +2,11 @@
 #define PY_SSIZE_T_CLEAN
 #include <Python.h>
 
+#include <errno.h>
 #include <inttypes.h>
 #include <limits.h>
 #include <stdint.h>
+#include <stdio.h>
 #include <string.h>
 
 #include <linux/err.h>
@@ -91,6 +93,8 @@ struct pyrf_event {
 	PyObject_HEAD
 	/** @sample: The parsed sample from the event. */
 	struct perf_sample sample;
+	/** @machine: The machine associated with the sample/event. */
+	struct machine *machine;
 	/** @al: The address location from machine__resolve, lazily computed. */
 	struct addr_location al;
 	/** @al_resolved: True when machine__resolve been called. */
@@ -109,6 +113,8 @@ struct pyrf_event {
 	sample_member_def(sample_time, time, T_ULONGLONG, "event timestamp"),		 \
 	sample_member_def(sample_id, id, T_ULONGLONG, "event id"),			 \
 	sample_member_def(sample_stream_id, stream_id, T_ULONGLONG, "event stream id"), \
+	sample_member_def(machine_pid, machine_pid, T_UINT, "event machine pid"),	 \
+	sample_member_def(vcpu, vcpu, T_UINT, "event vcpu"),				 \
 	sample_member_def(sample_period, period, T_ULONGLONG, "event period"),		 \
 	sample_member_def(sample_cpu, cpu, T_UINT, "event cpu"),
 
@@ -584,6 +590,7 @@ static PyMemberDef pyrf_sample_event__members[] = {
 	sample_member_def(sample_data_src, data_src, T_ULONGLONG, "event data source"),
 	sample_member_def(sample_insn_count, insn_cnt, T_ULONGLONG, "event instruction count"),
 	sample_member_def(sample_cyc_count, cyc_cnt, T_ULONGLONG, "event cycle count"),
+	sample_member_def(flags, flags, T_UINT, "event flags"),
 	member_def(perf_event_header, type, T_UINT, "event type"),
 	{ .name = NULL, },
 };
@@ -682,6 +689,7 @@ static int pyrf_sample_event__resolve_al(struct pyrf_event *pevent)
 	struct evsel *evsel = pevent->sample.evsel;
 	struct evlist *evlist = evsel ? evsel->evlist : NULL;
 	struct perf_session *session = evlist ? evlist__session(evlist) : NULL;
+	struct machine *machine;
 
 	if (pevent->al_resolved)
 		return 0;
@@ -689,8 +697,17 @@ static int pyrf_sample_event__resolve_al(struct pyrf_event *pevent)
 	if (!session)
 		return -1;
 
+	/*
+	 * Use pevent->machine, which pyrf_event__new() initializes either from
+	 * the machine resolved by perf_session (machines__find_for_cpumode(),
+	 * preserving DEFAULT_GUEST_KERNEL_ID == 0 for default guests) or via
+	 * sample.machine_pid when pyrf_event__new() is called with a NULL
+	 * machine.
+	 */
+	machine = pevent->machine ? pevent->machine : &session->machines.host;
+
 	addr_location__init(&pevent->al);
-	if (machine__resolve(&session->machines.host, &pevent->al, &pevent->sample) < 0) {
+	if (machine__resolve(machine, &pevent->al, &pevent->sample) < 0) {
 		addr_location__exit(&pevent->al);
 		return -1;
 	}
@@ -774,6 +791,15 @@ static PyObject *pyrf_sample_event__get_sym_start(struct pyrf_event *pevent,
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
@@ -915,10 +941,23 @@ static PyObject *pyrf_callchain_node__get_dso(struct pyrf_callchain_node *pnode,
 	return PyUnicode_FromString(dsoname);
 }
 
+static PyObject *pyrf_callchain_node__get_sym_offset(struct pyrf_callchain_node *pnode,
+						     void *closure __maybe_unused)
+{
+	u64 addr;
+
+	if (!pnode->sym)
+		Py_RETURN_NONE;
+
+	addr = pnode->map ? map__map_ip(pnode->map, pnode->ip) : pnode->ip;
+	return PyLong_FromUnsignedLongLong(addr - pnode->sym->start);
+}
+
 static PyGetSetDef pyrf_callchain_node__getset[] = {
-	{ .name = "ip",     .get = (getter)pyrf_callchain_node__get_ip, },
-	{ .name = "symbol", .get = (getter)pyrf_callchain_node__get_symbol, },
-	{ .name = "dso",    .get = (getter)pyrf_callchain_node__get_dso, },
+	{ .name = "ip",         .get = (getter)pyrf_callchain_node__get_ip, },
+	{ .name = "symbol",     .get = (getter)pyrf_callchain_node__get_symbol, },
+	{ .name = "dso",        .get = (getter)pyrf_callchain_node__get_dso, },
+	{ .name = "sym_offset", .get = (getter)pyrf_callchain_node__get_sym_offset, },
 	{ .name = NULL, },
 };
 
@@ -1169,7 +1208,114 @@ pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
 	return obj ?: PyObject_GenericGetAttr((PyObject *) pevent, attr_name);
 }
 
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
@@ -1230,6 +1376,12 @@ static PyGetSetDef pyrf_sample_event__getset[] = {
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
@@ -1286,8 +1438,45 @@ static const char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_swi
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
 
@@ -1295,11 +1484,19 @@ static PyObject *pyrf_context_switch_event__repr(const struct pyrf_event *pevent
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
@@ -1316,7 +1513,7 @@ static PyTypeObject pyrf_context_switch_event__type = {
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_context_switch_event__doc,
 	.tp_members	= pyrf_context_switch_event__members,
-	.tp_getset	= pyrf_event__getset,
+	.tp_getset	= pyrf_context_switch_event__getset,
 	.tp_repr	= (reprfunc)pyrf_context_switch_event__repr,
 };
 
@@ -1400,9 +1597,6 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	u32 min_size;
 	bool needs_swap;
 
-	if (!machine)
-		machine = session ? &session->machines.host : NULL;
-
 	if (event->header.type >= ARRAY_SIZE(pyrf_event__type) ||
 	    pyrf_event__type[event->header.type] == NULL) {
 		return PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
@@ -1434,13 +1628,17 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 		pevent->event.mmap2.filename[sizeof(pevent->event.mmap2.filename) - 1] = '\0';
 
 	perf_sample__init(&pevent->sample, /*all=*/true);
+	pevent->machine = machine;
 	pevent->callchain = NULL;
 	pevent->brstack = NULL;
 	pevent->al_resolved = false;
 	addr_location__init(&pevent->al);
 
-	if (!evsel)
+	if (!evsel) {
+		if (!pevent->machine && session)
+			pevent->machine = &session->machines.host;
 		return (PyObject *)pevent;
+	}
 
 	/* Parse the sample again so that pointers are within the copied event. */
 	needs_swap = evsel->needs_swap;
@@ -1453,6 +1651,24 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
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
+	if (!machine && session) {
+		machine = pevent->sample.machine_pid ?
+			machines__find(&session->machines, pevent->sample.machine_pid) :
+			&session->machines.host;
+		if (!machine)
+			machine = &session->machines.host;
+	}
+	pevent->machine = machine;
+	if (machine && machine->pid > 0 && !pevent->sample.machine_pid)
+		pevent->sample.machine_pid = machine->pid;
 	sample = &pevent->sample;
 	if (machine && sample->callchain) {
 		struct addr_location al;
@@ -3840,6 +4056,7 @@ struct pyrf_session {
 	struct pyrf_data *pdata;
 	PyObject *sample;
 	PyObject *stat;
+	PyObject *context_switch;
 };
 
 static int pyrf_session_tool__sample(const struct perf_tool *tool,
@@ -3864,6 +4081,33 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
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
@@ -3946,13 +4190,13 @@ static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObje
 static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject *kwargs)
 {
 	struct pyrf_data *pdata;
-	PyObject *sample = NULL, *stat = NULL;
-	static char *kwlist[] = { "data", "sample", "stat", NULL };
+	PyObject *sample = NULL, *stat = NULL, *context_switch = NULL;
+	static char *kwlist[] = { "data", "sample", "stat", "context_switch", NULL };
 	struct pyrf_session *psession;
 	struct perf_session *session;
 
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O!|OO", kwlist, &pyrf_data__type, &pdata,
-					 &sample, &stat))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O!|OOO", kwlist, &pyrf_data__type, &pdata,
+					 &sample, &stat, &context_switch))
 		return NULL;
 
 	psession = PyObject_New(struct pyrf_session, type);
@@ -3962,6 +4206,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	psession->session = NULL;
 	psession->sample = NULL;
 	psession->stat = NULL;
+	psession->context_switch = NULL;
 	psession->pdata = NULL;
 
 	Py_INCREF(pdata);
@@ -3985,6 +4230,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 
 	ADD_TOOL(sample);
 	ADD_TOOL(stat);
+	ADD_TOOL(context_switch);
 	#undef ADD_TOOL
 
 	if (stat)
@@ -4002,7 +4248,11 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	psession->tool.text_poke        = perf_event__process_text_poke;
 	psession->tool.build_id         = perf_event__process_build_id;
 	psession->tool.attr		= perf_event__process_attr;
+	psession->tool.event_update	= perf_event__process_event_update;
 	psession->tool.feature		= perf_event__process_feature;
+#ifdef HAVE_LIBTRACEEVENT
+	psession->tool.tracing_data	= perf_event__process_tracing_data;
+#endif
 
 	session = perf_session__new(&pdata->data, &psession->tool);
 	if (IS_ERR(session)) {
@@ -4033,6 +4283,7 @@ static void pyrf_session__delete(struct pyrf_session *psession)
 	Py_XDECREF(psession->pdata);
 	Py_XDECREF(psession->sample);
 	Py_XDECREF(psession->stat);
+	Py_XDECREF(psession->context_switch);
 	Py_TYPE(psession)->tp_free((PyObject *)psession);
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

