Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74418364043
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967259; cv=none; b=rt/ssokLXMHlQW7/u3EfMEcfShsP84UcZ2cB1zQeKqfqHHG8UScrM0BSi3H0LsliPlRrQ4dCLKLxXHhj6xad96nAM9Kse2OdfLUTO0uIYn9kAmmbQZhwAIJunf8EYtgJAV7hAnMpzaMByu7zwYZhx0WcnQzoP02lbLQCLYwBwC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967259; c=relaxed/simple;
	bh=+i9BYzANs+vfywraFpLpFp/I4/Y9LL5hswXt4QjVYd0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B1SWgxkTMjJ3G3/2lpBDfYjF0VsASMtqoj0It42dLSE65KIeS3/b9Is5ZTN/nvCtBEXyXcHRaiJS1fUdTjOHuL/SGSFZa2nF/orhNtmA8eDjRgK4adWmYoHvLIJdax7IDqCXTSYLO3MTPsa7R+vHKylA6gYpIaUgeOrpdZrexZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZn3RAZe; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZn3RAZe"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39de1f85cb2so3335240a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967257; x=1790572057; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ef7s28V90CYZ856CQuGA3BM6bx+/ZX7dSehpMz8byEs=;
        b=aZn3RAZehZMPT9DwB8yP7VOEFR71Fz0O8NwWtz9svAWMslDzmDkSOfWiug780K1dxP
         fSnPUSI+IDYy/mwMnRZLJNg3Bld5XnPzz2SjNi1EkyPIbMYwnEECrvBAaNvwyTAKyOmP
         ODZ4YjUBUzELRNRmJ7Ifg79FUo2ENUXSh8TRo3x+fPWpxlaZwfo5kOML5kxZV7FW3XqR
         dBxJ8uZ3DDmiiCm7FNTI6WlSpTD7FrkR7APxblGceK5YbNGQr9X6m/HbFU36v2wGK9iZ
         PIXQ6Q4cU5FyHi4v8gwRNwaXoBJ66LLWA49WArr6WFs4KgzhpKqQOU0tks5+n4w6Y6Po
         Xkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967257; x=1790572057;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ef7s28V90CYZ856CQuGA3BM6bx+/ZX7dSehpMz8byEs=;
        b=wjYM8Kz+KwqD+uiKt+YqntszktDftP1vdvzBtmrTIuVFcgicIFG1DyoBx/3cuvcV5A
         kEfAU7X1f8e4iQDKAMCuyA9pTxyeXXZ5r3jDiZYhNvTY1Zs1vkv1+O4U6B1mevxLCGPC
         CW7dY9hTfkmw2PAAoPbwlDZZ0mNk3qnUZWHe4DQy9xfVp4GWoyaGXxXCu1ieCvnySm6W
         q2v7X0mcA5w+umBNsD/oopZd0SGCbPjwn3Nl2S8Rz79Jw3X4rpoZ6U6jqrvIswll3kMl
         02T9dYQTPYYj6N6YZGuujL2CKNFppo/elcvu4n9lFn5vULOXjznInknArWfFkslOqLvx
         zf+g==
X-Forwarded-Encrypted: i=1; AKwUvBwWTcENlFJThP4vH2kzPOKvRboeo1Nuxs5CeQfCj93lnGuAuydqhYNiLPP8CWWOC2adsm8aqydvuiAIH3zNk3Fo@vger.kernel.org
X-Gm-Message-State: AFuF++lxKIIBgISrUGEpL6FfcCKzb9NLgNF9H5vIEYK4enmN6Nz1qrm/
	ZN24jvOeMrBLnuBPTEeIHlyJnEQQxhkUP0O6hDEzZggrNGfG7ybZTSk2Nl9v70S/qbyNnSRWOp8
	baWZL3JCN/w==
X-Received: from dlbut14.prod.google.com ([2002:a05:7022:7e0e:b0:143:7820:3080])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac7:b0:39e:252:ae4d
 with SMTP id 98e67ed59e1d1-39e54f9d387mr14103641a91.17.1789967256607; Sun, 20
 Sep 2026 22:07:36 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:27 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <b1d417e1f28afa565fa01b4997e3c31140e4772d.1789966896.git.irogers@google.com>
Subject: [PATCH v2 09/49] perf python: Add Intel PT call_return and itrace capability
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add support for Intel PT call_return events and itrace options to the
perf Python extension so standalone Python scripts can decode and
inspect low-level instruction traces.

Specifically:
- Add a call_return callback parameter and itrace option string to
  perf.session, treating explicit None (Py_None) callbacks as omitted.
- Expose the perf.call_return object with db_id, parent_id, insn_count,
  cyc_count, comm, pid, tid, call_time, return_time, branch_count,
  call_ref, return_ref, flags, and call_path (resolved as a
  perf.callchain ordered from outermost caller to callee).
- Export perf.CALL_RETURN_NO_CALL, perf.CALL_RETURN_NO_RETURN, and
  perf.CALL_RETURN_NON_CALL flag constants.
- Expose session.e_machine and session.is_64_bit properties, preferring
  recorded thread ELF machines (perf_session__e_machine) over perf_env
  so pipe-mode traces do not prematurely cache host bitness.
- Support optional vmlinux, kallsyms, and symfs symbol configuration
  parameters (and PERF_SYMBOL_VMLINUX, PERF_SYMBOL_KALLSYMS,
  PERF_SYMBOL_SYMFS environment fallbacks) in perf.session, resetting
    symbol_conf pointers and freeing vm_tm_corr_args, cpu_bitmap, and
  ptime_range in
  pyrf_session__delete().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/perf.pyi |  35 +++
 tools/perf/util/python.c   | 624 +++++++++++++++++++++++++++++++++++--
 2 files changed, 632 insertions(+), 27 deletions(-)

diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
index a8d0e61e8d10..20f0a8b4e810 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -435,6 +435,25 @@ class evlist:
         ...
 
 
+class call_return:
+    """Represents a call/return event from instruction trace decoding."""
+    db_id: int
+    parent_id: int
+    insn_count: int
+    cyc_count: int
+    comm: Optional[str]
+    machine_pid: int
+    pid: Optional[int]
+    tid: Optional[int]
+    call_time: int
+    return_time: int
+    branch_count: int
+    call_ref: int
+    return_ref: int
+    flags: int
+    call_path: Optional[callchain]
+
+
 class session:
     def __init__(
         self,
@@ -442,6 +461,11 @@ class session:
         sample: Optional[Callable[[sample_event], None]] = None,
         stat: Optional[Callable[[Any, Optional[str]], None]] = None,
         context_switch: Optional[Callable[[switch_event], None]] = None,
+        call_return: Optional[Callable[[call_return], None]] = None,
+        itrace: Optional[str] = None,
+        vmlinux: Optional[str] = None,
+        kallsyms: Optional[str] = None,
+        symfs: Optional[str] = None
     ) -> None:
         """Initialize a perf session.
 
@@ -451,6 +475,8 @@ class session:
             stat: Callback for stat events.
         """
         ...
+    e_machine: Optional[int]
+    is_64_bit: bool
     def process_events(self) -> None:
         """Process all events in the session."""
         ...
@@ -683,3 +709,12 @@ RECORD_STAT_ROUND: int
 
 RECORD_MISC_SWITCH_OUT: int
 """MISC_SWITCH_OUT record."""
+
+CALL_RETURN_NO_CALL: int
+"""'return' but no matching 'call'."""
+
+CALL_RETURN_NO_RETURN: int
+"""'call' but no matching 'return'."""
+
+CALL_RETURN_NON_CALL: int
+"""A branch but not a 'call' to the start of a different symbol."""
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 49f37198f4b3..dff307f4ab57 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2,9 +2,11 @@
 #define PY_SSIZE_T_CLEAN
 #include <Python.h>
 
+#include <elf.h>
 #include <inttypes.h>
 #include <stdio.h>
 #include <string.h>
+#include <stdlib.h>
 
 #include <linux/err.h>
 #include <poll.h>
@@ -23,12 +25,16 @@
 #include "counts.h"
 #include "data.h"
 #include "debug.h"
+#include "call-path.h"
+#include "db-export.h"
+#include "thread-stack.h"
 #include "dso.h"
 #include "dwarf-regs.h"
 #include "event.h"
 #include "branch.h"
 #include "evlist.h"
 #include "evsel.h"
+#include "symbol.h"
 #include "expr.h"
 #include "map.h"
 #include "metricgroup.h"
@@ -892,11 +898,13 @@ struct pyrf_callchain_node {
 	u64 ip;
 	struct map *map;
 	struct symbol *sym;
+	char *sym_name;
 };
 
 static void pyrf_callchain_node__delete(struct pyrf_callchain_node *pnode)
 {
 	map__put(pnode->map);
+	free(pnode->sym_name);
 	Py_TYPE(pnode)->tp_free((PyObject *)pnode);
 }
 
@@ -909,6 +917,8 @@ static PyObject *pyrf_callchain_node__get_ip(struct pyrf_callchain_node *pnode,
 static PyObject *pyrf_callchain_node__get_symbol(struct pyrf_callchain_node *pnode,
 						 void *closure __maybe_unused)
 {
+	if (pnode->sym_name)
+		return PyUnicode_FromString(pnode->sym_name);
 	if (pnode->sym)
 		return PyUnicode_FromString(pnode->sym->name);
 	return PyUnicode_FromString("[unknown]");
@@ -953,6 +963,7 @@ struct pyrf_callchain_frame {
 	u64 ip;
 	struct map *map;
 	struct symbol *sym;
+	char *sym_name;
 };
 
 struct pyrf_callchain {
@@ -964,8 +975,10 @@ struct pyrf_callchain {
 static void pyrf_callchain__delete(struct pyrf_callchain *pchain)
 {
 	if (pchain->frames) {
-		for (u64 i = 0; i < pchain->nr_frames; i++)
+		for (u64 i = 0; i < pchain->nr_frames; i++) {
 			map__put(pchain->frames[i].map);
+			free(pchain->frames[i].sym_name);
+		}
 		free(pchain->frames);
 	}
 	Py_TYPE(pchain)->tp_free((PyObject *)pchain);
@@ -995,6 +1008,7 @@ static PyObject *pyrf_callchain__item(PyObject *obj, Py_ssize_t i)
 	pnode->ip = pchain->frames[i].ip;
 	pnode->map = map__get(pchain->frames[i].map);
 	pnode->sym = pchain->frames[i].sym;
+	pnode->sym_name = pchain->frames[i].sym_name ? strdup(pchain->frames[i].sym_name) : NULL;
 
 	return (PyObject *)pnode;
 }
@@ -1567,8 +1581,8 @@ static PyTypeObject *pyrf_event__type[] = {
 };
 
 static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *evsel,
-				 struct perf_session *session,
-				 struct machine *machine)
+				 struct perf_session *session, struct machine *machine,
+				 struct perf_sample *sample_arg)
 {
 	struct pyrf_event *pevent;
 	struct perf_sample *sample;
@@ -1625,9 +1639,26 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	err = evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
 	evsel->needs_swap = needs_swap;
 	if (err < 0) {
-		Py_DECREF(pevent);
-		return PyErr_Format(PyExc_OSError,
-				    "perf: can't parse sample, err=%d", err);
+		/*
+		 * Synthesized events (e.g. Intel PT itrace) may not have raw sample
+		 * buffers for evsel__parse_sample(); use the pre-parsed sample_arg.
+		 */
+		if (sample_arg) {
+			perf_sample__exit(&pevent->sample);
+			pevent->sample = *sample_arg;
+			if (pevent->sample.evsel)
+				pevent->sample.evsel = evsel__get(pevent->sample.evsel);
+			pevent->sample.merged_callchain = false;
+
+			pevent->sample.user_regs = NULL;
+			pevent->sample.intr_regs = NULL;
+			pevent->sample.raw_data = NULL;
+			pevent->sample.raw_size = 0;
+		} else {
+			Py_DECREF(pevent);
+			return PyErr_Format(PyExc_OSError,
+					    "perf: can't parse sample, err=%d", err);
+		}
 	}
 	if (session && session->evlist && perf_guest && pevent->sample.id) {
 		struct perf_sample_id *sid = evlist__id2sid(session->evlist, pevent->sample.id);
@@ -3221,7 +3252,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		perf_mmap__consume(&md->core);
 		Py_RETURN_NONE;
 	}
-	pyevent = pyrf_event__new(event, evsel, evlist__session(evlist), /*machine=*/NULL);
+	pyevent = pyrf_event__new(event, evsel, evlist__session(evlist), /*machine=*/NULL, NULL);
 	perf_mmap__consume(&md->core);
 	if (pyevent == NULL)
 		return PyErr_Occurred() ? NULL : PyErr_NoMemory();
@@ -3589,6 +3620,11 @@ static const struct perf_constant perf__constants[] = {
 	PERF_CONST(RECORD_STAT_ROUND),
 
 	PERF_CONST(RECORD_MISC_SWITCH_OUT),
+
+	/* Values for the flags of a perf.call_return, see thread-stack.h. */
+	{ "CALL_RETURN_NO_CALL",	CALL_RETURN_NO_CALL },
+	{ "CALL_RETURN_NO_RETURN",	CALL_RETURN_NO_RETURN },
+	{ "CALL_RETURN_NON_CALL",	CALL_RETURN_NON_CALL },
 	{ .name = NULL, },
 };
 
@@ -4023,31 +4059,417 @@ struct pyrf_session {
 
 	struct perf_session *session;
 	struct perf_tool tool;
+	struct itrace_synth_opts itrace_opts;
 	struct pyrf_data *pdata;
 	PyObject *sample;
 	PyObject *stat;
 	PyObject *context_switch;
+	PyObject *call_return;
+	struct call_return_processor *crp;
+	/**
+	 * @call_return_last_db_id: Counter used to give each perf.call_return a
+	 * unique db_id. A call's db_id may be allocated before the call
+	 * returns, so the identifiers cannot be generated by the Python script.
+	 */
+	u64 call_return_last_db_id;
+	u64 sample_last_db_id;
+	char *vmlinux_name;
+	char *kallsyms_name;
+	char *symfs;
+};
+
+
+struct pyrf_call_return {
+	PyObject_HEAD
+	struct call_return cr;
+	/**
+	 * @call_path: perf.callchain of the call path, ordered from the
+	 * outermost caller to the callee. Resolved eagerly as the underlying
+	 * struct call_path is owned by the call return processor.
+	 */
+	PyObject *call_path;
+	char *comm;
+	pid_t machine_pid;
+	pid_t pid;
+	pid_t tid;
+};
+
+static PyObject *pyrf_call_return__repr(struct pyrf_call_return *pcr)
+{
+	return PyUnicode_FromString("{ type: call_return }");
+}
+
+static PyObject *pyrf_call_return__get_comm(struct pyrf_call_return *pcr,
+				       void *closure __maybe_unused)
+{
+	if (pcr->comm)
+		return PyUnicode_FromString(pcr->comm);
+	Py_RETURN_NONE;
+}
+
+static PyObject *pyrf_call_return__get_machine_pid(struct pyrf_call_return *pcr,
+						   void *closure __maybe_unused)
+{
+	return PyLong_FromLong(pcr->machine_pid);
+}
+
+static PyObject *pyrf_call_return__get_pid(struct pyrf_call_return *pcr,
+					   void *closure __maybe_unused)
+{
+	if (pcr->pid != -1)
+		return PyLong_FromLong(pcr->pid);
+	Py_RETURN_NONE;
+}
+
+static PyObject *pyrf_call_return__get_tid(struct pyrf_call_return *pcr,
+				       void *closure __maybe_unused)
+{
+	if (pcr->tid != -1)
+		return PyLong_FromLong(pcr->tid);
+	Py_RETURN_NONE;
+}
+
+static PyObject *pyrf_call_return__get_call_time(struct pyrf_call_return *pcr,
+				       void *closure __maybe_unused)
+{
+	struct call_return *cr = &pcr->cr;
+
+	return PyLong_FromUnsignedLongLong(cr->call_time);
+}
+
+static PyObject *pyrf_call_return__get_return_time(struct pyrf_call_return *pcr,
+				       void *closure __maybe_unused)
+{
+	struct call_return *cr = &pcr->cr;
+
+	return PyLong_FromUnsignedLongLong(cr->return_time);
+}
+
+static PyObject *pyrf_call_return__get_branch_count(struct pyrf_call_return *pcr,
+				       void *closure __maybe_unused)
+{
+	struct call_return *cr = &pcr->cr;
+
+	return PyLong_FromUnsignedLongLong(cr->branch_count);
+}
+
+static PyObject *pyrf_call_return__get_call_ref(struct pyrf_call_return *pcr,
+				       void *closure __maybe_unused)
+{
+	struct call_return *cr = &pcr->cr;
+
+	return PyLong_FromUnsignedLongLong(cr->call_ref);
+}
+
+static PyObject *pyrf_call_return__get_return_ref(struct pyrf_call_return *pcr,
+				       void *closure __maybe_unused)
+{
+	struct call_return *cr = &pcr->cr;
+
+	return PyLong_FromUnsignedLongLong(cr->return_ref);
+}
+
+static PyObject *pyrf_call_return__get_flags(struct pyrf_call_return *pcr,
+				       void *closure __maybe_unused)
+{
+	struct call_return *cr = &pcr->cr;
+
+	return PyLong_FromLong(cr->flags);
+}
+
+static PyObject *pyrf_call_return__get_call_path(struct pyrf_call_return *pcr,
+				       void *closure __maybe_unused)
+{
+	PyObject *call_path = pcr->call_path ?: Py_None;
+
+	Py_INCREF(call_path);
+	return call_path;
+}
+
+
+static PyObject *pyrf_call_return__get_parent_id(struct pyrf_call_return *pcr,
+						 void *closure __maybe_unused)
+{
+	return PyLong_FromUnsignedLongLong(pcr->cr.parent_db_id);
+}
+
+static PyObject *pyrf_call_return__get_insn_count(struct pyrf_call_return *pcr,
+						  void *closure __maybe_unused)
+{
+	return PyLong_FromUnsignedLongLong(pcr->cr.insn_count);
+}
+
+static PyObject *pyrf_call_return__get_cyc_count(struct pyrf_call_return *pcr,
+						 void *closure __maybe_unused)
+{
+	return PyLong_FromUnsignedLongLong(pcr->cr.cyc_count);
+}
+
+static PyObject *pyrf_call_return__get_db_id(struct pyrf_call_return *pcr,
+					     void *closure __maybe_unused)
+{
+	return PyLong_FromUnsignedLongLong(pcr->cr.db_id);
+}
+
+static PyGetSetDef pyrf_call_return__getset[] = {
+	{
+		.name = "db_id",
+		.get = (getter)pyrf_call_return__get_db_id,
+		.doc = "Unique identifier of this call return.",
+	},
+	{
+		.name = "parent_id",
+		.get = (getter)pyrf_call_return__get_parent_id,
+		.doc = "db_id of the calling call return, 0 if there is none.",
+	},
+	{
+		.name = "insn_count",
+		.get = (getter)pyrf_call_return__get_insn_count,
+		.doc = "Instructions executed between the call and the return.",
+	},
+	{
+		.name = "cyc_count",
+		.get = (getter)pyrf_call_return__get_cyc_count,
+		.doc = "Cycles elapsed between the call and the return.",
+	},
+	{
+		.name = "comm",
+		.get = (getter)pyrf_call_return__get_comm,
+		.doc = "Thread comm at the time of the call/return, or None.",
+	},
+	{
+		.name = "machine_pid",
+		.get = (getter)pyrf_call_return__get_machine_pid,
+		.doc = "Machine PID (0 for host).",
+	},
+	{
+		.name = "pid",
+		.get = (getter)pyrf_call_return__get_pid,
+		.doc = "Process ID of the thread, or None.",
+	},
+	{
+		.name = "tid",
+		.get = (getter)pyrf_call_return__get_tid,
+		.doc = "Thread identifier, None if unknown.",
+	},
+	{
+		.name = "call_time",
+		.get = (getter)pyrf_call_return__get_call_time,
+		.doc = "Timestamp of the call.",
+	},
+	{
+		.name = "return_time",
+		.get = (getter)pyrf_call_return__get_return_time,
+		.doc = "Timestamp of the return.",
+	},
+	{
+		.name = "branch_count",
+		.get = (getter)pyrf_call_return__get_branch_count,
+		.doc = "Branches taken between the call and the return.",
+	},
+	{
+		.name = "call_ref",
+		.get = (getter)pyrf_call_return__get_call_ref,
+		.doc = "Reference to the sample of the call.",
+	},
+	{
+		.name = "return_ref",
+		.get = (getter)pyrf_call_return__get_return_ref,
+		.doc = "Reference to the sample of the return.",
+	},
+	{
+		.name = "flags",
+		.get = (getter)pyrf_call_return__get_flags,
+		.doc = "Bitmask of perf.CALL_RETURN_* values.",
+	},
+	{
+		.name = "call_path",
+		.get = (getter)pyrf_call_return__get_call_path,
+		.doc = "perf.callchain from outermost caller to callee.",
+	},
+	{ .name = NULL, },
+};
+
+
+static void pyrf_call_return__delete(struct pyrf_call_return *pevent)
+{
+	Py_XDECREF(pevent->call_path);
+	free(pevent->comm);
+	Py_TYPE(pevent)->tp_free((PyObject *)pevent);
+}
+
+static PyTypeObject pyrf_call_return__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.call_return",
+	.tp_basicsize	= sizeof(struct pyrf_call_return),
+	.tp_dealloc	= (destructor)pyrf_call_return__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= "perf call_return object.",
+	.tp_getset	= pyrf_call_return__getset,
+	.tp_repr	= (reprfunc)pyrf_call_return__repr,
 };
 
+/*
+ * Turn a struct call_path, that is a leaf with parent pointers up to the
+ * outermost caller, into a perf.callchain ordered from the outermost caller to
+ * the leaf. The struct call_path is owned by the call return processor and so
+ * must be resolved before returning to Python.
+ */
+static PyObject *pyrf_call_path__to_callchain(const struct call_path *cp)
+{
+	struct pyrf_callchain *pchain;
+	const struct call_path *pos;
+	u64 nr_frames = 0;
+
+	/* The root call path is a sentinel with no symbol, skip it. */
+	for (pos = cp; pos && pos->parent; pos = pos->parent)
+		nr_frames++;
+
+	pchain = PyObject_New(struct pyrf_callchain, &pyrf_callchain__type);
+	if (!pchain)
+		return NULL;
+
+	pchain->nr_frames = nr_frames;
+	pchain->frames = nr_frames ? calloc(nr_frames, sizeof(*pchain->frames)) : NULL;
+	if (nr_frames && !pchain->frames) {
+		pchain->nr_frames = 0;
+		Py_DECREF(pchain);
+		return PyErr_NoMemory();
+	}
+	/* Fill in reverse so that the outermost caller is first. */
+	for (pos = cp; nr_frames > 0; pos = pos->parent) {
+		struct pyrf_callchain_frame *frame = &pchain->frames[--nr_frames];
+
+		frame->ip = pos->ip;
+		frame->sym = NULL;
+		frame->sym_name = pos->sym ? strdup(pos->sym->name) : NULL;
+		frame->map = NULL;
+	}
+	return (PyObject *)pchain;
+}
+
+static PyObject *pyrf_call_return__new(struct call_return *cr)
+{
+	struct pyrf_call_return *pevent;
+
+	pevent = PyObject_New(struct pyrf_call_return, &pyrf_call_return__type);
+	if (!pevent)
+		return NULL;
+
+	pevent->cr = *cr;
+	/* Avoid lifetime issues with thread by caching tid/pid/machine_pid */
+	if (cr->thread) {
+		struct maps *maps = thread__maps(cr->thread);
+
+		pevent->machine_pid = maps && maps__machine(maps) ? maps__machine(maps)->pid : 0;
+		pevent->pid = thread__pid(cr->thread);
+		pevent->tid = thread__tid(cr->thread);
+	} else {
+		pevent->machine_pid = 0;
+		pevent->pid = -1;
+		pevent->tid = -1;
+	}
+	pevent->cr.thread = NULL;
+	pevent->comm = cr->comm ? strdup(comm__str(cr->comm)) : NULL;
+	pevent->call_path = NULL;
+	if (cr->cp) {
+		pevent->call_path = pyrf_call_path__to_callchain(cr->cp);
+		if (!pevent->call_path) {
+			Py_DECREF(pevent);
+			return NULL;
+		}
+	}
+	return (PyObject *)pevent;
+}
+
+static int pyrf_session__call_return_process(struct call_return *cr,
+					     u64 *parent_db_id,
+					     void *data)
+{
+	struct pyrf_session *psession = data;
+	PyObject *pyevent, *ret;
+
+	if (!psession->call_return)
+		return 0;
+
+	if (!cr->db_id)
+		cr->db_id = ++psession->call_return_last_db_id;
+
+	if (parent_db_id) {
+		if (!*parent_db_id)
+			*parent_db_id = ++psession->call_return_last_db_id;
+		cr->parent_db_id = *parent_db_id;
+	}
+
+	pyevent = pyrf_call_return__new(cr);
+	if (!pyevent)
+		return -1;
+
+	ret = PyObject_CallFunctionObjArgs(psession->call_return, pyevent, NULL);
+	if (!ret) {
+		Py_DECREF(pyevent);
+		return -1;
+	}
+	Py_DECREF(ret);
+	Py_DECREF(pyevent);
+	return 0;
+}
+
 static int pyrf_session_tool__sample(const struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample,
 				     struct machine *machine)
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
-	PyObject *pyevent = pyrf_event__new(event, sample->evsel, psession->session, machine);
-	PyObject *ret;
+	u64 sample_db_id = ++psession->sample_last_db_id;
 
-	if (pyevent == NULL)
-		return -ENOMEM;
+	if (psession->crp) {
+		struct addr_location al, addr_al;
+		struct thread *thread = NULL;
 
-	ret = PyObject_CallFunction(psession->sample, "O", pyevent);
-	if (!ret) {
+		addr_location__init(&al);
+		addr_location__init(&addr_al);
+
+		if (machine__resolve(machine, &al, sample) >= 0) {
+			thread = al.thread;
+			if (sample->flags & (PERF_IP_FLAG_CALL |
+					     PERF_IP_FLAG_TRACE_BEGIN |
+					     PERF_IP_FLAG_RETURN |
+					     PERF_IP_FLAG_BRANCH |
+					     PERF_IP_FLAG_TRACE_END)) {
+				thread__resolve(thread, &addr_al, sample);
+			}
+
+			int err;
+
+			err = thread_stack__process(thread, thread__comm(thread), sample,
+					      &al, &addr_al, sample_db_id, psession->crp);
+			if (err) {
+				addr_location__exit(&addr_al);
+				addr_location__exit(&al);
+				return err;
+			}
+		}
+
+		addr_location__exit(&addr_al);
+		addr_location__exit(&al);
+	}
+
+	if (psession->sample) {
+		PyObject *pyevent = pyrf_event__new(event, sample->evsel,
+						    psession->session,
+						    machine, sample);
+		PyObject *ret;
+
+		if (pyevent == NULL)
+			return -ENOMEM;
+
+		ret = PyObject_CallFunction(psession->sample, "O", pyevent);
 		Py_DECREF(pyevent);
-		return -1;
+		if (!ret)
+			return -1;
+		Py_DECREF(ret);
 	}
-	Py_DECREF(ret);
-	Py_DECREF(pyevent);
 	return 0;
 }
 
@@ -4057,7 +4479,7 @@ static int pyrf_session_tool__context_switch(const struct perf_tool *tool,
 					     struct machine *machine)
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
-	PyObject *pyevent = pyrf_event__new(event, sample->evsel, psession->session, machine);
+	PyObject *pyevent = pyrf_event__new(event, sample->evsel, psession->session, machine, NULL);
 	PyObject *ret;
 
 	if (perf_event__process_switch(tool, event, sample, machine) < 0) {
@@ -4085,7 +4507,7 @@ static int pyrf_session_tool__stat(const struct perf_tool *tool,
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
 	struct evsel *evsel = evlist__id2evsel(session->evlist, event->stat.id);
 	PyObject *pyevent = pyrf_event__new(event, /*evsel=*/NULL, psession->session,
-					    /*machine=*/NULL);
+					    /*machine=*/NULL, NULL);
 	const char *name = evsel ? evsel__name(evsel) : "unknown";
 	PyObject *ret;
 
@@ -4108,7 +4530,7 @@ static int pyrf_session_tool__stat_round(const struct perf_tool *tool,
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
 	PyObject *pyevent = pyrf_event__new(event, /*evsel=*/NULL, psession->session,
-					    /*machine=*/NULL);
+					    /*machine=*/NULL, NULL);
 	PyObject *ret;
 
 	if (pyevent == NULL)
@@ -4136,15 +4558,17 @@ static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObje
 	if (!PyArg_ParseTuple(args, "i|i", &pid, &tid))
 		return NULL;
 
-	if (tid == -1)
+	if (tid == -1) {
 		tid = pid;
+		pid = -1;
+	}
 
 	/* Look up the thread in the host machine first, then fall back to guest machines. */
 	machine = &psession->session->machines.host;
 	thread = machine__find_thread(machine, pid, tid);
 
 	if (!thread) {
-		machine = perf_session__find_machine(psession->session, pid);
+		machine = perf_session__find_machine(psession->session, pid != -1 ? pid : tid);
 		if (machine)
 			thread = machine__find_thread(machine, pid, tid);
 	}
@@ -4161,23 +4585,40 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 {
 	struct pyrf_data *pdata;
 	PyObject *sample = NULL, *stat = NULL, *context_switch = NULL;
-	static char * const kwlist[] = { "data", "sample", "stat", "context_switch", NULL };
+	PyObject *call_return = NULL;
+	char *itrace_str = NULL;
+	char *vmlinux_str = NULL, *kallsyms_str = NULL, *symfs_str = NULL;
+	static char * const kwlist[] = { "data", "sample", "stat", "context_switch",
+			      "call_return", "itrace", "vmlinux", "kallsyms",
+			      "symfs", NULL };
 	struct pyrf_session *psession;
 	struct perf_session *session;
 
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O!|OOO", kwlist, &pyrf_data__type, &pdata,
-					 &sample, &stat, &context_switch))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O!|OOOOzzzz", kwlist,
+					 &pyrf_data__type, &pdata,
+					 &sample, &stat, &context_switch,
+					 &call_return, &itrace_str,
+					 &vmlinux_str, &kallsyms_str, &symfs_str))
 		return NULL;
 
 	psession = PyObject_New(struct pyrf_session, type);
 	if (!psession)
 		return NULL;
 
+	/* PyObject_New doesn't zero the memory, initialize every member. */
 	psession->session = NULL;
 	psession->sample = NULL;
 	psession->stat = NULL;
 	psession->context_switch = NULL;
+	psession->call_return = NULL;
+	psession->crp = NULL;
+	psession->call_return_last_db_id = 0;
+	psession->sample_last_db_id = 0;
+	psession->vmlinux_name = NULL;
+	psession->kallsyms_name = NULL;
+	psession->symfs = NULL;
 	psession->pdata = NULL;
+	memset(&psession->itrace_opts, 0, sizeof(psession->itrace_opts));
 
 	Py_INCREF(pdata);
 	psession->pdata = pdata;
@@ -4187,7 +4628,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 
 	#define ADD_TOOL(name)						\
 	do {								\
-		if (name) {						\
+		if (name && name != Py_None) {				\
 			if (!PyCallable_Check(name)) {			\
 				PyErr_SetString(PyExc_TypeError, #name " must be callable"); \
 				goto err_out;				\
@@ -4199,15 +4640,39 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	} while (0)
 
 	ADD_TOOL(sample);
+	if (call_return && call_return != Py_None && (!sample || sample == Py_None))
+		psession->tool.sample = pyrf_session_tool__sample;
 	ADD_TOOL(stat);
 	ADD_TOOL(context_switch);
+
+	if (call_return && call_return != Py_None) {
+		if (!PyCallable_Check(call_return)) {
+			PyErr_SetString(PyExc_TypeError, "call_return must be callable");
+			Py_DECREF(psession);
+			return NULL;
+		}
+		Py_INCREF(call_return);
+		psession->call_return = call_return;
+		psession->crp = call_return_processor__new(pyrf_session__call_return_process,
+							   psession);
+		if (!psession->crp) {
+			PyErr_SetString(PyExc_MemoryError,
+					"Failed to allocate call_return_processor");
+			Py_DECREF(psession);
+			return NULL;
+		}
+	}
 	#undef ADD_TOOL
 
-	if (stat)
+	if (stat && stat != Py_None)
 		psession->tool.stat_round = pyrf_session_tool__stat_round;
 
 
 	psession->tool.comm		= perf_event__process_comm;
+	psession->tool.auxtrace_info = perf_event__process_auxtrace_info;
+	psession->tool.auxtrace = perf_event__process_auxtrace;
+	psession->tool.auxtrace_error = perf_event__process_auxtrace_error;
+	psession->tool.id_index	= perf_event__process_id_index;
 	psession->tool.mmap		= perf_event__process_mmap;
 	psession->tool.mmap2            = perf_event__process_mmap2;
 	psession->tool.namespaces       = perf_event__process_namespaces;
@@ -4230,6 +4695,49 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	}
 	psession->session = session;
 
+	if (itrace_str) {
+		memset(&psession->itrace_opts, 0, sizeof(psession->itrace_opts));
+		if (itrace_do_parse_synth_opts(&psession->itrace_opts, itrace_str, 0) < 0) {
+			PyErr_SetString(PyExc_ValueError, "Failed to parse itrace options");
+			Py_DECREF(psession);
+			return NULL;
+		}
+		psession->session->itrace_synth_opts = &psession->itrace_opts;
+	}
+
+	if (!vmlinux_str)
+		vmlinux_str = getenv("PERF_SYMBOL_VMLINUX");
+	if (vmlinux_str && vmlinux_str[0]) {
+		psession->vmlinux_name = strdup(vmlinux_str);
+		if (!psession->vmlinux_name) {
+			PyErr_NoMemory();
+			goto err_out;
+		}
+		symbol_conf.vmlinux_name = psession->vmlinux_name;
+	}
+
+	if (!kallsyms_str)
+		kallsyms_str = getenv("PERF_SYMBOL_KALLSYMS");
+	if (kallsyms_str && kallsyms_str[0]) {
+		psession->kallsyms_name = strdup(kallsyms_str);
+		if (!psession->kallsyms_name) {
+			PyErr_NoMemory();
+			goto err_out;
+		}
+		symbol_conf.kallsyms_name = psession->kallsyms_name;
+	}
+
+	if (!symfs_str)
+		symfs_str = getenv("PERF_SYMBOL_SYMFS");
+	if (symfs_str && symfs_str[0]) {
+		psession->symfs = strdup(symfs_str);
+		if (!psession->symfs) {
+			PyErr_NoMemory();
+			goto err_out;
+		}
+		symbol_conf.symfs = psession->symfs;
+	}
+
 	symbol_conf.use_callchain = true;
 	symbol_conf.show_kernel_path = true;
 	symbol_conf.inline_name = false;
@@ -4249,10 +4757,25 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 static void pyrf_session__delete(struct pyrf_session *psession)
 {
 	perf_session__delete(psession->session);
+	if (symbol_conf.vmlinux_name == psession->vmlinux_name)
+		symbol_conf.vmlinux_name = NULL;
+	free(psession->vmlinux_name);
+	if (symbol_conf.kallsyms_name == psession->kallsyms_name)
+		symbol_conf.kallsyms_name = NULL;
+	free(psession->kallsyms_name);
+	if (symbol_conf.symfs == psession->symfs)
+		symbol_conf.symfs = "";
+	free(psession->symfs);
+	free(psession->itrace_opts.vm_tm_corr_args);
+	free(psession->itrace_opts.cpu_bitmap);
+	free(psession->itrace_opts.ptime_range);
 	Py_XDECREF(psession->pdata);
 	Py_XDECREF(psession->sample);
 	Py_XDECREF(psession->stat);
 	Py_XDECREF(psession->context_switch);
+	Py_XDECREF(psession->call_return);
+	if (psession->crp)
+		call_return_processor__free(psession->crp);
 	Py_TYPE(psession)->tp_free((PyObject *)psession);
 }
 
@@ -4295,10 +4818,54 @@ static const char pyrf_session__doc[] = PyDoc_STR("perf session object.");
 
 static PyObject *pyrf_session__getattro(struct pyrf_session *psession, PyObject *attr_name)
 {
+	const char *name_str = PyUnicode_AsUTF8(attr_name);
+
+	if (!name_str)
+		return NULL;
 	if (!psession->session) {
 		PyErr_SetString(PyExc_ValueError, "session not initialized");
 		return NULL;
 	}
+	if (!strcmp(name_str, "e_machine"))
+		return PyLong_FromLong(perf_session__e_machine(psession->session,
+							       /*e_flags=*/NULL));
+
+	if (!strcmp(name_str, "is_64_bit")) {
+		/*
+		 * Prefer the machine of the recorded threads over the perf_env,
+		 * as in pipe mode the perf_env may not be populated yet and
+		 * perf_env__kernel_is_64_bit would cache the host's bitness.
+		 */
+		switch (perf_session__e_machine(psession->session, /*e_flags=*/NULL)) {
+		case EM_AARCH64:
+		case EM_ALPHA:
+		case EM_IA_64:
+		case EM_LOONGARCH:
+		case EM_PPC64:
+		case EM_SPARCV9:
+		case EM_X86_64:
+			Py_RETURN_TRUE;
+		case EM_386:
+		case EM_ARM:
+		case EM_PPC:
+		case EM_SPARC:
+			Py_RETURN_FALSE;
+		default:
+			/*
+			 * Machines like EM_MIPS, EM_PARISC, EM_RISCV and
+			 * EM_S390 are used for both word sizes, fall back on
+			 * the recorded arch string if available.
+			 */
+			break;
+		}
+		{
+			struct perf_env *env = perf_session__env(psession->session);
+
+			if (env && env->arch)
+				return PyBool_FromLong(perf_env__kernel_is_64_bit(env) == 1);
+			return PyBool_FromLong(sizeof(void *) == 8);
+		}
+	}
 	return PyObject_GenericGetAttr((PyObject *) psession, attr_name);
 }
 
@@ -4452,7 +5019,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	if (module == NULL)
 		return NULL;
 
-	if (pyrf_event__setup_types() < 0 ||
+	if (PyType_Ready(&pyrf_call_return__type) < 0 ||
+	    pyrf_event__setup_types() < 0 ||
 	    pyrf_evlist__setup_types() < 0 ||
 	    pyrf_evsel__setup_types() < 0 ||
 	    pyrf_thread_map__setup_types() < 0 ||
@@ -4535,6 +5103,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 
 	Py_INCREF(&pyrf_session__type);
 	PyModule_AddObject(module, "session", (PyObject *)&pyrf_session__type);
+	Py_INCREF(&pyrf_call_return__type);
+	PyModule_AddObject(module, "call_return", (PyObject *)&pyrf_call_return__type);
 
 	Py_INCREF(&pyrf_branch_entry__type);
 	if (PyModule_AddObject(module, "branch_entry", (PyObject *)&pyrf_branch_entry__type) < 0) {
-- 
2.55.0.1082.g2b9226bbc0-goog

