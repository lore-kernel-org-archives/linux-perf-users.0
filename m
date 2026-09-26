Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7C385515
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403680; cv=none; b=BEMIkHSsjq1udxBVxuuJCvVZky1fiU2et2ij26GCn7opAbxHSFdy3KbC37ZQ1VV0cbfenBimlKdkteYDwyc2+Q4lDfv0ReL5GQq/pQLCdhNEBn6tyYwGXnvDf1aGO/Y+fBT/SDGZPyLAiZoNlKdcDCB3vyjPoCIVI07x9VdQibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403680; c=relaxed/simple;
	bh=2raV1ziHWxUv+/x1agstuO7QVCvHcfpGo4+lP0mlqBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vowy5ePXiBKq6N3JXL71G3gltfh716NEjhW9k+z1ojbaPWoacc9Vn8sHXMqg09ydBaGKhjEFiAl2n4IgUQwq0vb71LFJwJJdJSQg0C1ofy7QH51uCITejl3eFilExBznA5SW8g5xIePSwQMj2xmL4Yy24G/GHiJvBG/CajG9RWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuA7B5x0; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuA7B5x0"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-142f4306744so4684603c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403677; x=1791008477; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xv8cVuL4yjWT++/Y0K++mRl9YFy3Wk0ElmvQjeNYoeA=;
        b=BuA7B5x0n9WwQg9b83MAh1hVRF+u2guVDa3fRHG/O7BczNzaCX0g1liJjgg7qSpM4i
         JmCZHx7ByT1O2cDPDNVjvfKdkjAz0jgrfXXyYVKaMTL1I9B9K1aoGmdgMnfDuc7mn34N
         iSYcJQb4ChctgJuOW3CBQ2gBDU3AzaDTBtLXghO3iIIa8Idjixjgb1QQ6oZHuwXqAuBp
         CujzuPxmBEVN22IoH8hos6BglcMA6pcBBVwwRtw0HUcFhuaqdcevH/9ywdzBF2gnIxDH
         kAgznIASGfb1x+LA6GlWk+S0/OR60jZMGPT3GqLBT9nRiOYbV1CvsipNodv0apCZOdOA
         7flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403677; x=1791008477;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xv8cVuL4yjWT++/Y0K++mRl9YFy3Wk0ElmvQjeNYoeA=;
        b=ol0enGKS8iVyxDVlZwRpVuiA48IfscxuuJhsgvHWHEghB2SOa2JCAP0CMGDb1mMpfV
         HncW2k3HUcglt168GXcwZgo9Pqp/m0ZS3UBL+1R+7sFk8VEU8qkxstLWTHudRTyJ5aw6
         RN2dhVzRIqBPiYRhFoTkUWO0mIaOS8oz7CP5Z8zBDd+/sZzJG+hi/9smk9SJmf5U0Iw0
         Sdua+LP67La08ypHwAAUmrzUoZ3u3PFFQYrlHUpsJuw9mZMqNTk+phWpmTDq/wgT+D27
         ZdcSiUKTukap3mO/qIzuYlokLuQKHr7cwBrcvyQERJh87dy3dM9Ju8fWiVN27ocNcIYg
         dH+A==
X-Forwarded-Encrypted: i=1; AKwUvBwFvJfLucdgGwUEHDFQaAZmBbe9YRLubcwVYREXOBMP0VyvtSPv05OmjRVq62n9J2Ok3pw6vAhl3fCd9ZKO1a9A@vger.kernel.org
X-Gm-Message-State: AFuF++mbF425Z9brQNmnFlO+j5NHaqVjEHiaSFNE9adnkfIVKYj8nnEX
	v13B/ozfHLffRQc56c7cQ9vxZjJHAG5Dk4Y7YYGpYs6Z6TuEl5aCnmVHnQgesmx3BS+j+SpSqmZ
	nIM4L9uijig==
X-Received: from dlbsv13.prod.google.com ([2002:a05:7022:3a0d:b0:13c:fe05:89a3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4546:20b0:145:54f1:682c
 with SMTP id a92af1059eb24-146d03a08ffmr2142493c88.29.1790403676306; Fri, 25
 Sep 2026 23:21:16 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:36 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-10-irogers@google.com>
Subject: [PATCH v4 09/49] perf python: Add Intel PT call_return and itrace capability
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
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
  perf.callchain ordered from outermost caller to callee, populating
  frame->map and frame->sym so call_path entries expose resolved symbol
  and DSO names).
- Export perf.CALL_RETURN_NO_CALL, perf.CALL_RETURN_NO_RETURN, and
  perf.CALL_RETURN_NON_CALL flag constants.
- Expose session.e_machine and session.is_64_bit properties, preferring
  recorded thread ELF machines (perf_session__e_machine) over perf_env
  so pipe-mode traces do not prematurely cache host bitness.
- Support optional vmlinux, kallsyms, and symfs symbol configuration
  parameters (and PERF_SYMBOL_VMLINUX, PERF_SYMBOL_KALLSYMS,
  PERF_SYMBOL_SYMFS environment fallbacks) in perf.session, resetting
  symbol_conf pointers and freeing vm_tm_corr_args, cpu_bitmap, and
  ptime_range in pyrf_session__delete().

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/perf.pyi |  78 ++++-
 tools/perf/util/python.c   | 698 ++++++++++++++++++++++++++++++++++---
 2 files changed, 711 insertions(+), 65 deletions(-)

diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
index 44c693761838..087da00728fd 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -96,7 +96,7 @@ class data:
 
 class thread:
     """Represents a thread in the system."""
-    def comm(self) -> str:
+    def comm(self) -> Optional[str]:
         """Get the command name of the thread."""
         ...
     pid: int
@@ -165,7 +165,13 @@ class evsel:
     def __str__(self) -> str:
         """Return string representation of the event."""
         ...
-    def open(self) -> None:
+    def open(
+        self,
+        cpus: Optional['cpu_map'] = None,
+        threads: Optional[thread_map] = None,
+        group: bool = False,
+        inherit: bool = False,
+    ) -> None:
         """Open the event selector file descriptor table."""
         ...
     def read(self, cpu: int, thread: int) -> counts_values:
@@ -211,15 +217,15 @@ class sample_event(_sample_members):
     sample_cyc_count: int
     type: int
     raw_buf: bytes
-    dso: str
-    dso_long_name: str
-    dso_bid: Optional[bytes]
-    map_start: int
-    map_end: int
-    map_pgoff: int
-    symbol: str
-    sym_start: int
-    sym_end: int
+    dso: Optional[str]
+    dso_long_name: Optional[str]
+    dso_bid: Optional[str]
+    map_start: Optional[int]
+    map_end: Optional[int]
+    map_pgoff: Optional[int]
+    symbol: Optional[str]
+    sym_start: Optional[int]
+    sym_end: Optional[int]
     sym_offset: Optional[int]
     addr_dso: Optional[str]
     addr_symbol: Optional[str]
@@ -230,7 +236,7 @@ class sample_event(_sample_members):
     transaction: int
     brstack: Optional['branch_stack']
     callchain: Optional['callchain']
-    def srccode(self) -> Optional[tuple[Optional[str], int, Optional[str]]]: ...
+    def srccode(self, addr: int = ..., /) -> Optional[tuple[Optional[str], int, Optional[str]]]: ...
     def insn(self) -> Optional[bytes]: ...
     def __getattr__(self, name: str) -> Any: ...
 
@@ -339,6 +345,7 @@ class branch_stack:
     """Sequence of branch entries in the branch stack."""
     def __len__(self) -> int: ...
     def __getitem__(self, index: int) -> branch_entry: ...
+    def __iter__(self) -> Iterator[branch_entry]: ...
 
 class callchain_node:
     """Represents a frame in the callchain."""
@@ -387,10 +394,10 @@ class evlist:
     def close(self) -> None:
         """Close the events in the list."""
         ...
-    def mmap(self) -> None:
+    def mmap(self, pages: int = 128, overwrite: bool = False) -> None:
         """Memory map the event buffers."""
         ...
-    def poll(self, timeout: int) -> int:
+    def poll(self, timeout: int = -1) -> int:
         """Poll for events.
 
         Args:
@@ -400,7 +407,7 @@ class evlist:
             Number of events ready.
         """
         ...
-    def read_on_cpu(self, cpu: int) -> Optional[Any]:
+    def read_on_cpu(self, cpu: int, sample_id_all: bool = True) -> Optional[Any]:
         """Read a sample event from a specific CPU.
 
         Args:
@@ -437,17 +444,38 @@ class evlist:
     def enable(self) -> None:
         """Enable all events in the list."""
         ...
-    def get_pollfd(self) -> List[int]:
+    def get_pollfd(self) -> List[Any]:
         """Get a list of file descriptors for polling."""
         ...
-    def add(self, evsel: evsel) -> int:
+    def add(self, evsel: evsel, /) -> int:
         """Add an event to the list."""
         ...
+    def __len__(self) -> int: ...
+    def __getitem__(self, index: int) -> evsel: ...
     def __iter__(self) -> Iterator[evsel]:
         """Iterate over the events (evsel) in the list."""
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
@@ -455,6 +483,11 @@ class session:
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
 
@@ -464,6 +497,8 @@ class session:
             stat: Callback for stat events.
         """
         ...
+    e_machine: int
+    is_64_bit: bool
     def process_events(self) -> None:
         """Process all events in the session."""
         ...
@@ -696,3 +731,12 @@ RECORD_STAT_ROUND: int
 
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
index 526d0e197230..690a94fb4f62 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2,15 +2,18 @@
 #define PY_SSIZE_T_CLEAN
 #include <Python.h>
 
+#include <elf.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <limits.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <string.h>
+#include <stdlib.h>
 
 #include <linux/err.h>
 #include <poll.h>
+#include <sys/stat.h>
 #include <unistd.h>
 
 #include <internal/lib.h>
@@ -26,6 +29,9 @@
 #include "counts.h"
 #include "data.h"
 #include "debug.h"
+#include "call-path.h"
+#include "db-export.h"
+#include "thread-stack.h"
 #include "dso.h"
 #include "dwarf-regs.h"
 #include "event.h"
@@ -33,6 +39,7 @@
 #include "branch.h"
 #include "evlist.h"
 #include "evsel.h"
+#include "symbol.h"
 #include "expr.h"
 #include "map.h"
 #include "metricgroup.h"
@@ -830,6 +837,12 @@ static PyObject *pyrf_sample_event__srccode(PyObject *self, PyObject *args)
 	PyObject *result;
 	struct addr_location al;
 
+	/*
+	 * addr defaults to pevent->sample.ip when omitted, and when
+	 * addr != pevent->sample.ip a local addr_location is resolved so
+	 * callers can inspect callchain/branch addresses without mutating
+	 * the sample's cached pevent->al.
+	 */
 	if (!PyArg_ParseTuple(args, "|K", &addr))
 		return NULL;
 
@@ -858,6 +871,12 @@ static PyObject *pyrf_sample_event__srccode(PyObject *self, PyObject *args)
 	addr_location__exit(&al);
 
 	if (srcfile) {
+		/*
+		 * PyUnicode_FromStringAndSize(line, len) (via Py_BuildValue "s#")
+		 * must copy the source line before free_srccode() frees the
+		 * buffer, and because the line returned by find_sourceline() is
+		 * bounded by len rather than NUL-terminated.
+		 */
 		srccode = find_sourceline(srcfile, line, &len);
 		result = Py_BuildValue("(sIs#)", srcfile, line, srccode, (Py_ssize_t)len);
 		free(srcfile);
@@ -901,11 +920,13 @@ struct pyrf_callchain_node {
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
 
@@ -918,6 +939,8 @@ static PyObject *pyrf_callchain_node__get_ip(struct pyrf_callchain_node *pnode,
 static PyObject *pyrf_callchain_node__get_symbol(struct pyrf_callchain_node *pnode,
 						 void *closure __maybe_unused)
 {
+	if (pnode->sym_name)
+		return PyUnicode_FromString(pnode->sym_name);
 	if (pnode->sym)
 		return PyUnicode_FromString(pnode->sym->name);
 	return PyUnicode_FromString("[unknown]");
@@ -975,6 +998,7 @@ struct pyrf_callchain_frame {
 	u64 ip;
 	struct map *map;
 	struct symbol *sym;
+	char *sym_name;
 };
 
 struct pyrf_callchain {
@@ -986,8 +1010,10 @@ struct pyrf_callchain {
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
@@ -1017,6 +1043,7 @@ static PyObject *pyrf_callchain__item(PyObject *obj, Py_ssize_t i)
 	pnode->ip = pchain->frames[i].ip;
 	pnode->map = map__get(pchain->frames[i].map);
 	pnode->sym = pchain->frames[i].sym;
+	pnode->sym_name = pchain->frames[i].sym_name ? strdup(pchain->frames[i].sym_name) : NULL;
 
 	return (PyObject *)pnode;
 }
@@ -1588,8 +1615,8 @@ static PyTypeObject *pyrf_event__type[] = {
 };
 
 static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *evsel,
-				 struct perf_session *session,
-				 struct machine *machine)
+				 struct perf_session *session, struct machine *machine,
+				 struct perf_sample *sample_arg)
 {
 	struct pyrf_event *pevent;
 	struct perf_sample *sample;
@@ -1647,9 +1674,26 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
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
@@ -2014,7 +2058,6 @@ static int pyrf_pmu__setup_types(void)
 	return PyType_Ready(&pyrf_pmu__type);
 }
 
-
 /** A python iterator for pmus that has no equivalent in the C code. */
 struct pyrf_pmu_iterator {
 	PyObject_HEAD
@@ -2425,12 +2468,13 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 {
 	struct evsel *evsel = pevsel->evsel;
 	int cpu = 0, cpu_idx, thread = 0, thread_idx;
+	static char *kwlist[] = { "cpu", "thread", NULL };
 	struct perf_counts_values *old_count, *new_count;
 	struct pyrf_counts_values *count_values;
 
 	CHECK_INITIALIZED(evsel, "evsel");
 
-	if (!PyArg_ParseTuple(args, "ii", &cpu, &thread))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "ii", kwlist, &cpu, &thread))
 		return NULL;
 
 	cpu_idx = perf_cpu_map__idx(evsel->core.cpus, (struct perf_cpu){.cpu = cpu});
@@ -2955,10 +2999,6 @@ static int prepare_metric(const struct metric_expr *mexp,
 		double val, ena, run;
 		int ret, source_count = 0;
 		struct perf_counts_values *old_count, *new_count;
-		char *n = strdup(evsel__metric_id(cur));
-
-		if (!n)
-			return -ENOMEM;
 
 		/*
 		 * If there are multiple uncore PMUs and we're not reading the
@@ -3000,9 +3040,15 @@ static int prepare_metric(const struct metric_expr *mexp,
 
 		if (ena != run && run != 0)
 			val = val * ena / run;
+		char *n = strdup(evsel__metric_id(cur));
+
+		if (!n)
+			return -ENOMEM;
 		ret = expr__add_id_val_source_count(pctx, n, val, source_count);
-		if (ret)
+		if (ret) {
+			free(n);
 			return ret;
+		}
 	}
 
 	for (int i = 0; metric_refs && metric_refs[i].metric_name; i++) {
@@ -3020,6 +3066,7 @@ static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevlist,
 {
 	int ret, cpu = 0, cpu_idx = 0, thread = 0, thread_idx = 0;
 	const char *metric;
+	static char *kwlist[] = { "metric", "cpu", "thread", NULL };
 	struct rb_node *node;
 	struct metric_expr *mexp = NULL;
 	struct expr_parse_ctx *pctx;
@@ -3028,7 +3075,7 @@ static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevlist,
 
 	CHECK_INITIALIZED(pevlist->evlist, "evlist");
 
-	if (!PyArg_ParseTuple(args, "sii", &metric, &cpu, &thread))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "sii", kwlist, &metric, &cpu, &thread))
 		return NULL;
 
 	for (node = rb_first_cached(&evlist__metric_events(pevlist->evlist)->entries);
@@ -3170,10 +3217,7 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
 	return PyErr_NoMemory();
 }
 
-
-static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist,
-				  PyObject *args,
-				  PyObject *kwargs __maybe_unused)
+static PyObject *pyrf_evlist__add(struct pyrf_evlist *pevlist, PyObject *args)
 {
 	struct evlist *evlist;
 	PyObject *pevsel;
@@ -3251,7 +3295,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		perf_mmap__consume(&md->core);
 		Py_RETURN_NONE;
 	}
-	pyevent = pyrf_event__new(event, evsel, evlist__session(evlist), /*machine=*/NULL);
+	pyevent = pyrf_event__new(event, evsel, evlist__session(evlist), /*machine=*/NULL, NULL);
 	perf_mmap__consume(&md->core);
 	if (pyevent == NULL)
 		return PyErr_Occurred() ? NULL : PyErr_NoMemory();
@@ -3385,7 +3429,7 @@ static PyMethodDef pyrf_evlist__methods[] = {
 	{
 		.ml_name  = "add",
 		.ml_meth  = (PyCFunction)pyrf_evlist__add,
-		.ml_flags = METH_VARARGS | METH_KEYWORDS,
+		.ml_flags = METH_VARARGS,
 		.ml_doc	  = PyDoc_STR("adds an event selector to the list.")
 	},
 	{
@@ -3619,6 +3663,11 @@ static const struct perf_constant perf__constants[] = {
 	PERF_CONST(RECORD_STAT_ROUND),
 
 	PERF_CONST(RECORD_MISC_SWITCH_OUT),
+
+	/* Values for the flags of a perf.call_return, see thread-stack.h. */
+	{ "CALL_RETURN_NO_CALL",	CALL_RETURN_NO_CALL },
+	{ "CALL_RETURN_NO_RETURN",	CALL_RETURN_NO_RETURN },
+	{ "CALL_RETURN_NON_CALL",	CALL_RETURN_NON_CALL },
 	{ .name = NULL, },
 };
 
@@ -3629,7 +3678,7 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 	char *sys  = NULL;
 	char *name = NULL;
 
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|ss", kwlist,
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "ss", kwlist,
 					 &sys, &name))
 		return NULL;
 
@@ -3897,6 +3946,10 @@ static int pyrf_data__init(struct pyrf_data *pdata, PyObject *args, PyObject *kw
 	pdata->data.mode = PERF_DATA_MODE_READ;
 	pdata->data.file.fd = fd;
 	if (perf_data__open(&pdata->data) < 0) {
+		if (fd >= 0) {
+			close(fd);
+			pdata->data.file.fd = -1;
+		}
 		PyErr_Format(PyExc_IOError, "Failed to open perf data: %s",
 			     pdata->data.path ? pdata->data.path : "perf.data");
 		return -1;
@@ -4053,31 +4106,427 @@ struct pyrf_session {
 
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
 };
 
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
+};
+
+/*
+ * Turn a struct call_path, that is a leaf with parent pointers up to the
+ * outermost caller, into a perf.callchain ordered from the outermost caller to
+ * the leaf. The struct call_path is owned by the call return processor and so
+ * must be resolved before returning to Python.
+ */
+static PyObject *pyrf_call_path__to_callchain(const struct call_path *cp,
+					      struct thread *thread)
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
+		if (thread) {
+			struct addr_location al;
+			u8 cpumode = pos->in_kernel ? PERF_RECORD_MISC_KERNEL
+						    : PERF_RECORD_MISC_USER;
+
+			addr_location__init(&al);
+			thread__find_map(thread, cpumode, pos->ip, &al);
+			frame->map = map__get(al.map);
+			if (frame->map)
+				frame->sym = pos->sym;
+			addr_location__exit(&al);
+		}
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
+		pevent->call_path = pyrf_call_path__to_callchain(cr->cp, cr->thread);
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
 
@@ -4087,7 +4536,7 @@ static int pyrf_session_tool__context_switch(const struct perf_tool *tool,
 					     struct machine *machine)
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
-	PyObject *pyevent = pyrf_event__new(event, sample->evsel, psession->session, machine);
+	PyObject *pyevent = pyrf_event__new(event, sample->evsel, psession->session, machine, NULL);
 	PyObject *ret;
 
 	if (perf_event__process_switch(tool, event, sample, machine) < 0) {
@@ -4115,7 +4564,7 @@ static int pyrf_session_tool__stat(const struct perf_tool *tool,
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
 	struct evsel *evsel = evlist__id2evsel(session->evlist, event->stat.id);
 	PyObject *pyevent = pyrf_event__new(event, /*evsel=*/NULL, psession->session,
-					    /*machine=*/NULL);
+					    /*machine=*/NULL, NULL);
 	const char *name = evsel ? evsel__name(evsel) : "unknown";
 	PyObject *ret;
 
@@ -4138,7 +4587,7 @@ static int pyrf_session_tool__stat_round(const struct perf_tool *tool,
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
 	PyObject *pyevent = pyrf_event__new(event, /*evsel=*/NULL, psession->session,
-					    /*machine=*/NULL);
+					    /*machine=*/NULL, NULL);
 	PyObject *ret;
 
 	if (pyevent == NULL)
@@ -4166,17 +4615,28 @@ static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, PyObje
 	if (!PyArg_ParseTuple(args, "i|i", &pid, &tid))
 		return NULL;
 
-	if (tid == -1)
+	if (tid == -1) {
 		tid = pid;
+		pid = -1;
+	}
 
-	/* Look up the thread in the host machine first, then fall back to guest machines. */
+	/*
+	 * When host lookup fails, guest machines (default_guest and the guests
+	 * rb_root) are searched.
+	 */
 	machine = &psession->session->machines.host;
 	thread = machine__find_thread(machine, pid, tid);
 
 	if (!thread) {
-		machine = perf_session__find_machine(psession->session, pid);
+		machine = perf_session__find_machine(psession->session, pid != -1 ? pid : tid);
 		if (machine)
 			thread = machine__find_thread(machine, pid, tid);
+		if (!thread) {
+			machine = machines__find(&psession->session->machines,
+						 DEFAULT_GUEST_KERNEL_ID);
+			if (machine)
+				thread = machine__find_thread(machine, pid, tid);
+		}
 	}
 
 	/* Return None rather than raising TypeError when a PID/TID is not known. */
@@ -4191,23 +4651,40 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 {
 	struct pyrf_data *pdata;
 	PyObject *sample = NULL, *stat = NULL, *context_switch = NULL;
-	static char *kwlist[] = { "data", "sample", "stat", "context_switch", NULL };
+	PyObject *call_return = NULL;
+	char *itrace_str = NULL;
+	char *vmlinux_str = NULL, *kallsyms_str = NULL, *symfs_str = NULL;
+	static char *kwlist[] = { "data", "sample", "stat", "context_switch",
+				  "call_return", "itrace", "vmlinux", "kallsyms",
+				  "symfs", NULL };
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
@@ -4217,7 +4694,7 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 
 	#define ADD_TOOL(name)						\
 	do {								\
-		if (name) {						\
+		if (name && name != Py_None) {				\
 			if (!PyCallable_Check(name)) {			\
 				PyErr_SetString(PyExc_TypeError, #name " must be callable"); \
 				goto err_out;				\
@@ -4229,15 +4706,38 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
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
 
-
 	psession->tool.comm		= perf_event__process_comm;
+	psession->tool.auxtrace_info = perf_event__process_auxtrace_info;
+	psession->tool.auxtrace = perf_event__process_auxtrace;
+	psession->tool.auxtrace_error = perf_event__process_auxtrace_error;
+	psession->tool.id_index	= perf_event__process_id_index;
 	psession->tool.mmap		= perf_event__process_mmap;
 	psession->tool.mmap2            = perf_event__process_mmap2;
 	psession->tool.namespaces       = perf_event__process_namespaces;
@@ -4254,12 +4754,57 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	psession->tool.tracing_data	= perf_event__process_tracing_data;
 #endif
 
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
 	session = perf_session__new(&pdata->data, &psession->tool);
 	if (IS_ERR(session)) {
 		PyErr_Format(PyExc_IOError, "failed to create session: %ld", PTR_ERR(session));
 		goto err_out;
 	}
 	psession->session = session;
+	psession->session->itrace_synth_opts = &psession->itrace_opts;
+
+	if (!itrace_str)
+		itrace_str = getenv("PERF_ITRACE");
+	if (itrace_str) {
+		memset(&psession->itrace_opts, 0, sizeof(psession->itrace_opts));
+		if (itrace_do_parse_synth_opts(&psession->itrace_opts, itrace_str, 0) < 0) {
+			PyErr_SetString(PyExc_ValueError, "Failed to parse itrace options");
+			Py_DECREF(psession);
+			return NULL;
+		}
+	}
 
 	symbol_conf.use_callchain = true;
 	symbol_conf.show_kernel_path = true;
@@ -4269,8 +4814,6 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 		goto err_out;
 	}
 
-
-
 	return (PyObject *)psession;
 err_out:
 	Py_DECREF(psession);
@@ -4280,10 +4823,25 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
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
 
@@ -4326,10 +4884,54 @@ static const char pyrf_session__doc[] = PyDoc_STR("perf session object.");
 
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
 
@@ -4537,7 +5139,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	if (module == NULL)
 		return NULL;
 
-	if (pyrf_event__setup_types() < 0 ||
+	if (PyType_Ready(&pyrf_call_return__type) < 0 ||
+	    pyrf_event__setup_types() < 0 ||
 	    pyrf_evlist__setup_types() < 0 ||
 	    pyrf_evsel__setup_types() < 0 ||
 	    pyrf_thread_map__setup_types() < 0 ||
@@ -4588,9 +5191,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_throttle_event__type);
 	PyModule_AddObject(module, "throttle_event", (PyObject *)&pyrf_throttle_event__type);
 
-	Py_INCREF(&pyrf_task_event__type);
-	PyModule_AddObject(module, "task_event", (PyObject *)&pyrf_task_event__type);
-
 	Py_INCREF(&pyrf_read_event__type);
 	PyModule_AddObject(module, "read_event", (PyObject *)&pyrf_read_event__type);
 
@@ -4620,6 +5220,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 
 	Py_INCREF(&pyrf_session__type);
 	PyModule_AddObject(module, "session", (PyObject *)&pyrf_session__type);
+	Py_INCREF(&pyrf_call_return__type);
+	PyModule_AddObject(module, "call_return", (PyObject *)&pyrf_call_return__type);
 
 	Py_INCREF(&pyrf_branch_entry__type);
 	if (PyModule_AddObject(module, "branch_entry", (PyObject *)&pyrf_branch_entry__type) < 0) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

