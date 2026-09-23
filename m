Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC0495042
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187192; cv=none; b=l5Q6SzgRM7VNMWGcuCcnZEsHsLSovYhBShmEHU9L8RNoV1VGayu9Hsrukt41XaURZFyQPV2IaIaT/W8ZboR+Sf137xERbjp5N7uFKirf85lcb5dkiuKpylLQLYWEX+DItf1bFgZrDsmpvlNER700N3ITJfqWR/QwvtTGKBN0xKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187192; c=relaxed/simple;
	bh=t5nROc84EJtqNRszx08awWIoUh0mTNrHH+xG8zZhDAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gu0X54ALkHzAtwrpeYjCIxl0JHTiD6+e4keTxtlKyv7/jwMCZh/89Ggk9uw8Bww9r9KEdLuPsL6PXG+ViMlebcEiNs2vTaip+aBPkkAs+pdZaNMZKuZWxKpoEk/74d9v3dlYWisB0k3qbzVaSAZO15JhW/ll6AWz5VxjCz1hf90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tOEnmtql; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tOEnmtql"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14318be7d79so1363280c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187185; x=1790791985; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Izcn87/X47pU9K+vXcxHrwbhfzHS8v54a8K1HVSp2F4=;
        b=tOEnmtql/KmA6r7jDbxcsX3C2q2FXucGsuUJp3/AI7t0vZBsZmSgqjFoch/u9vAiaX
         uk1F+5YUGuvaIJe9oc6jcKj2ocKG1xfJwaMV8DNMJa2uGwanqM6rn7LhiDeoAQZuq0ON
         sr6axsW+hGkNOCha8egTqVFNQQ1E4+gE8ceSfEgGUDmrSPLYr5zVV9cGe46I18wMNZlH
         Wdr1HKxtfdQZCMRlNRMzlxDvV8qnVxKV1CmmvHWdrhoTd/OsMJEu53SyIfEN574waWsn
         URvutkm2PbPyw/aNUl0V2pKSF6R8FclJdb6jBnrrjpMWU/rcJKbFn1V0z+PnqS8kgk2k
         jO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187185; x=1790791985;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Izcn87/X47pU9K+vXcxHrwbhfzHS8v54a8K1HVSp2F4=;
        b=orTWnUd4uPFwklbW6wLvoPOhx52+VjxoNCz9ZexHc17iCMzHJ8rqHrw1mGynTqfv4Y
         +ZukF9zoQl7HbEFpc8xevAt5v7DA3No2N45unuhJKN9s+OyPlBJWNlfbyvxA8NOpZgGC
         OwewrxyhsPMfrbV4CgpvzVy5C77c7o7TFHAFdKmY9uHO60A03z2csN6aIoEQGDvt/3vk
         AhXYQ1zHO9qUqXahmXIJmsFH5cWOsPmjLgZ2c6o+6cod8uFh/O5fcrpTaKdNRay16Hdi
         f3T/z6p7LILwgbAptOpefsFCiZJAWKhKNYbmf640FE9iVDBDBytysRLCHprUwfM/wk8K
         43jA==
X-Forwarded-Encrypted: i=1; AKwUvBy+s08U8+SdinMvO/2lSPFKQTm9nOvQsImTkMCNljOy2Rr7L01U9LAjhLyZTqUbgh7kbVbIBZqdBgBbLEYJv4Kv@vger.kernel.org
X-Gm-Message-State: AFuF++lWeGsRsSvsxSTl7B5ZCzX8SGo26gW+IdzhKumD8wm0jxOAis1O
	7fNtSVhtsMkdxPe4OGgGUbUWi0f0zyrCp1u/9uS2OVzjZ6gVE4wKnRlLkcYifJ/stB9oXo8gGK1
	gmsfLE3TTBg==
X-Received: from dlam3-n1.prod.google.com ([2002:a05:701b:2083:10b0:144:cc99:5883])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2591:b0:143:3617:c595
 with SMTP id a92af1059eb24-144f90da1b3mr4269160c88.1.1790187184518; Wed, 23
 Sep 2026 11:13:04 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:31 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-9-irogers@google.com>
Subject: [PATCH v3 08/49] perf python: Expose addr location, transaction, and context_switch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
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
index 9e5ecc2d9abf..05b558b6aa66 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2,8 +2,10 @@
 #define PY_SSIZE_T_CLEAN
 #include <Python.h>
 
+#include <errno.h>
 #include <inttypes.h>
 #include <limits.h>
+#include <stdio.h>
 #include <string.h>
 
 #include <linux/err.h>
@@ -90,6 +92,8 @@ struct pyrf_event {
 	PyObject_HEAD
 	/** @sample: The parsed sample from the event. */
 	struct perf_sample sample;
+	/** @machine: The machine associated with the sample/event. */
+	struct machine *machine;
 	/** @al: The address location from machine__resolve, lazily computed. */
 	struct addr_location al;
 	/** @al_resolved: True when machine__resolve been called. */
@@ -108,6 +112,8 @@ struct pyrf_event {
 	sample_member_def(sample_time, time, T_ULONGLONG, "event timestamp"),		 \
 	sample_member_def(sample_id, id, T_ULONGLONG, "event id"),			 \
 	sample_member_def(sample_stream_id, stream_id, T_ULONGLONG, "event stream id"), \
+	sample_member_def(machine_pid, machine_pid, T_UINT, "event machine pid"),	 \
+	sample_member_def(vcpu, vcpu, T_UINT, "event vcpu"),				 \
 	sample_member_def(sample_period, period, T_ULONGLONG, "event period"),		 \
 	sample_member_def(sample_cpu, cpu, T_UINT, "event cpu"),
 
@@ -583,6 +589,7 @@ static PyMemberDef pyrf_sample_event__members[] = {
 	sample_member_def(sample_data_src, data_src, T_ULONGLONG, "event data source"),
 	sample_member_def(sample_insn_count, insn_cnt, T_ULONGLONG, "event instruction count"),
 	sample_member_def(sample_cyc_count, cyc_cnt, T_ULONGLONG, "event cycle count"),
+	sample_member_def(flags, flags, T_UINT, "event flags"),
 	member_def(perf_event_header, type, T_UINT, "event type"),
 	{ .name = NULL, },
 };
@@ -681,6 +688,7 @@ static int pyrf_sample_event__resolve_al(struct pyrf_event *pevent)
 	struct evsel *evsel = pevent->sample.evsel;
 	struct evlist *evlist = evsel ? evsel->evlist : NULL;
 	struct perf_session *session = evlist ? evlist__session(evlist) : NULL;
+	struct machine *machine;
 
 	if (pevent->al_resolved)
 		return 0;
@@ -688,8 +696,17 @@ static int pyrf_sample_event__resolve_al(struct pyrf_event *pevent)
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
@@ -773,6 +790,15 @@ static PyObject *pyrf_sample_event__get_sym_start(struct pyrf_event *pevent,
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
@@ -914,10 +940,23 @@ static PyObject *pyrf_callchain_node__get_dso(struct pyrf_callchain_node *pnode,
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
 
@@ -1168,7 +1207,114 @@ pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
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
@@ -1229,6 +1375,12 @@ static PyGetSetDef pyrf_sample_event__getset[] = {
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
@@ -1285,8 +1437,45 @@ static const char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_swi
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
 
@@ -1294,11 +1483,19 @@ static PyObject *pyrf_context_switch_event__repr(const struct pyrf_event *pevent
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
@@ -1315,7 +1512,7 @@ static PyTypeObject pyrf_context_switch_event__type = {
 	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
 	.tp_doc		= pyrf_context_switch_event__doc,
 	.tp_members	= pyrf_context_switch_event__members,
-	.tp_getset	= pyrf_event__getset,
+	.tp_getset	= pyrf_context_switch_event__getset,
 	.tp_repr	= (reprfunc)pyrf_context_switch_event__repr,
 };
 
@@ -1399,9 +1596,6 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	u32 min_size;
 	bool needs_swap;
 
-	if (!machine)
-		machine = session ? &session->machines.host : NULL;
-
 	if (event->header.type >= ARRAY_SIZE(pyrf_event__type) ||
 	    pyrf_event__type[event->header.type] == NULL) {
 		return PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
@@ -1433,13 +1627,17 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
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
@@ -1452,6 +1650,24 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
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
@@ -3839,6 +4055,7 @@ struct pyrf_session {
 	struct pyrf_data *pdata;
 	PyObject *sample;
 	PyObject *stat;
+	PyObject *context_switch;
 };
 
 static int pyrf_session_tool__sample(const struct perf_tool *tool,
@@ -3863,6 +4080,33 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
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
@@ -3945,13 +4189,13 @@ static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObje
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
@@ -3961,6 +4205,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	psession->session = NULL;
 	psession->sample = NULL;
 	psession->stat = NULL;
+	psession->context_switch = NULL;
 	psession->pdata = NULL;
 
 	Py_INCREF(pdata);
@@ -3984,6 +4229,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 
 	ADD_TOOL(sample);
 	ADD_TOOL(stat);
+	ADD_TOOL(context_switch);
 	#undef ADD_TOOL
 
 	if (stat)
@@ -4001,7 +4247,11 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
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
@@ -4032,6 +4282,7 @@ static void pyrf_session__delete(struct pyrf_session *psession)
 	Py_XDECREF(psession->pdata);
 	Py_XDECREF(psession->sample);
 	Py_XDECREF(psession->stat);
+	Py_XDECREF(psession->context_switch);
 	Py_TYPE(psession)->tp_free((PyObject *)psession);
 }
 
-- 
2.56.0.rc1.310.g51773c2048-goog

