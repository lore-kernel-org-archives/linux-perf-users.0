Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482C3B52E4
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965611; cv=none; b=u9j8rMLYd1UWmI5O2ChBpU+3iS2xB9OKFlJmcqKNcKyzXN9XvJ9Jmz01pGu5wLHJyFsioI3NKOjyh07dpB14+9WyIUr8eNIXRLZUCr/vzCYCTjbDGwf71rJGaw+VK7Xj8sOTjUTtqlAnThsQYcQ1nC2M7MHukfWeSVDJbQ9vUiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965611; c=relaxed/simple;
	bh=sceLqC/0HXug/mJWV7t6yNkapRYO0ZNHFU/nLsxP1jM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=c/AQ0KeEY3rsDTN+Nd9S3gb4GKlJsH5UyaGA7E6ON8FjDPHT/G0fjI7PkjouoyJwovyBWV/VD4unV8jT24GJvhyq41VHj/bzDEH1WK+glQjcA5T8zQASDY+W1Hl2cp9qOnahMnKFL6U7sgcjNHt6SKPidBq/pwlrE7BkDb6naho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mws78MV6; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mws78MV6"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33baaba6371so10941409eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790965609; x=1791570409; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n1N6DAVYbk5i++BVBpocC3cJA7vKFAd5ixF05QyYdmw=;
        b=mws78MV6d1p8OJgecu6Ve8C+gQXhgbHPwIo517ykFqO5YtRqdhLirOwa6W7QZH9ihn
         i8pmTaGs9s5COxpJEDnVMWrErrKZQ7ocDGtc+U/0imyb7/9NYEUkjjyNLGjTt2izUpQn
         flLu0kjMa3DTKTVgDSIfvgCuSYyScRITKGsrVqf2ZKC4BAbqbW7THUzxaBt7Vardasmd
         cAQ0gGjcTSn3EYyYA+01QOXXSlxX8yIe5G+TH/vf1OgcM6dmUfnmq6sBrYDDCG4NPGck
         /J7M5PsrUfgv6isWAObLFFQnkKJVN8M20seza5lBDv3cR6+L30jWYTK2NJ0Rd148vH4+
         aV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965609; x=1791570409;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n1N6DAVYbk5i++BVBpocC3cJA7vKFAd5ixF05QyYdmw=;
        b=yiY8hFWiD9rnMDtlDBuK/RkezgQoFpwxFf8eLeRkYQZSKH+RzL1/HMqlfv9Ak7FtVT
         u1WyVtiiP/FOaNIySaWp54jBrFKaQrVIgoTXYZXOP/OM03Ilgv1xaO8SrJ9dPgbR2Kzj
         mCmsQ4G5Uyj0odzT6aJWLfI+xtu13VUmfhVXWA5LtWIpfV86+0LfMuzqK2gIjp5r4it7
         u/OGVdrnWEmQvaDyaC2tBlD6eyQ3DkPzN7zz+5QrCTdxYiBAjdKlZAgUUMGfI9HuUXMn
         8h5Lf6lssy0akHZG/yZ1TD/5qeStZMPfs34xB95Kvhy780UHffCbAxTSlDI551JUuBHm
         wi0A==
X-Forwarded-Encrypted: i=1; AKwUvBzI6fHN054gpdhIN9qzOInh2OGSjF0tWMqioQPAQoE8KfOndG0eBgbT0Av2DIKzQsbX+1ym/b6t2x6RXqYH83sn@vger.kernel.org
X-Gm-Message-State: AFuF++lK3xebDjfdISFtIKXQoeH7p8oSHqhT3csUn8MRkVYWI7Ee45UX
	FAKELKLMoXzMVDmfaHwutAh2bCIHmDHvINBHyk+g9zcrhaNs62h7i3GaoyDlKTEuUBXfZp0cOKl
	oEQMN6LgIbw==
X-Received: from dlbur23.prod.google.com ([2002:a05:7022:ea57:b0:144:c2b6:8f47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4346:b0:144:c127:dd1b
 with SMTP id a92af1059eb24-14f5d2b508cmr4529457c88.39.1790965608489; Fri, 02
 Oct 2026 11:26:48 -0700 (PDT)
Date: Fri,  2 Oct 2026 11:26:13 -0700
In-Reply-To: <20261002182624.3259797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002182624.3259797-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002182624.3259797-5-irogers@google.com>
Subject: [PATCH v1 04/13] perf python: Lazily resolve sample callchains
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Changbin Du <changbin.du@huawei.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, tanze <tanze@kylinos.cn>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously, pyrf_event__new() eagerly resolved the sample's address
location and callchain (including DWARF/FP unwinding and symbol lookup)
for every sample with a callchain, even when the Python callback never
accessed event.callchain (such as in ttimechart.py).

Move callchain resolution to pyrf_sample_event__get_callchain() so that
callchains are only unwound and resolved when event.callchain is
accessed, reusing the sample's cached pevent->al via
pyrf_sample_event__resolve_al().

Because process_events() borrows the event and sample during the
callback, callchains are never copied in the common case. Only when a
callback retains a reference to the event beyond its return
(Py_REFCNT(pyevent) > 1), the callchain was not already resolved during
the callback, and the callchain is synthesized or LBR-merged (not backed
by event_copy) does pyrf_event__copy() allocate a copy of
sample->callchain.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 160 +++++++++++++++++++--------------------
 1 file changed, 79 insertions(+), 81 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index a40e89c1b329..251b7d517ad5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -100,7 +100,7 @@ struct pyrf_event {
 	struct addr_location al;
 	/** @al_resolved: True when machine__resolve been called. */
 	bool al_resolved;
-	/** @callchain: Resolved callchain, eagerly computed if requested. */
+	/** @callchain: Resolved callchain, lazily computed. */
 	PyObject *callchain;
 	/** @brstack: Resolved branch stack, eagerly computed if requested. */
 	PyObject *brstack;
@@ -727,28 +727,19 @@ get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 
 static int pyrf_sample_event__resolve_al(struct pyrf_event *pevent)
 {
-	struct evsel *evsel = pevent->sample->evsel ?: pevent->evsel;
-	struct evlist *evlist = evsel ? evsel->evlist : NULL;
-	struct perf_session *session = evlist ? evlist__session(evlist) : NULL;
-	struct machine *machine;
-
 	if (pevent->al_resolved)
 		return 0;
 
-	if (!session)
-		return -1;
-
 	/*
-	 * Use pevent->machine, which pyrf_event__new() initializes either from
-	 * the machine resolved by perf_session (machines__find_for_cpumode(),
-	 * preserving DEFAULT_GUEST_KERNEL_ID == 0 for default guests) or via
-	 * sample.machine_pid when pyrf_event__new() is called with a NULL
-	 * machine.
+	 * Use pevent->machine, which pyrf_event__new() initializes while the
+	 * session callback is active and pyrf_event__copy() clears after
+	 * resolving pevent->al if a reference is retained beyond the callback.
 	 */
-	machine = pevent->machine ? pevent->machine : &session->machines.host;
+	if (!pevent->machine)
+		return -1;
 
 	addr_location__init(&pevent->al);
-	if (machine__resolve(machine, &pevent->al, pevent->sample) < 0) {
+	if (machine__resolve(pevent->machine, &pevent->al, pevent->sample) < 0) {
 		addr_location__exit(&pevent->al);
 		return -1;
 	}
@@ -924,23 +915,15 @@ static PyObject *pyrf_sample_event__srccode(PyObject *self, PyObject *args)
 static PyObject *pyrf_sample_event__insn(PyObject *self, PyObject *args __maybe_unused)
 {
 	struct pyrf_event *pevent = (void *)self;
-	struct thread *thread;
-	struct machine *machine;
 
-	if (pyrf_sample_event__resolve_al(pevent) < 0)
-		Py_RETURN_NONE;
-
-	thread = pevent->al.thread;
-
-	if (!thread || !thread__maps(thread))
-		Py_RETURN_NONE;
-
-	machine = maps__machine(thread__maps(thread));
-	if (!machine)
-		Py_RETURN_NONE;
+	if (pevent->sample->ip && !pevent->sample->insn_len) {
+		if (pyrf_sample_event__resolve_al(pevent) < 0 ||
+		    !pevent->al.thread || !pevent->machine)
+			Py_RETURN_NONE;
 
-	if (pevent->sample->ip && !pevent->sample->insn_len)
-		perf_sample__fetch_insn(pevent->sample, thread, machine);
+		perf_sample__fetch_insn(pevent->sample, pevent->al.thread,
+					pevent->machine);
+	}
 
 	if (!pevent->sample->insn_len)
 		Py_RETURN_NONE;
@@ -1097,10 +1080,53 @@ static PyTypeObject pyrf_callchain__type = {
 	.tp_as_sequence	= &pyrf_callchain__sequence_methods,
 };
 
+static int pyrf_sample_event__resolve_callchain(struct pyrf_event *pevent)
+{
+	struct callchain_cursor *cursor;
+	struct pyrf_callchain *pchain;
+	struct callchain_cursor_node *node;
+
+	if (pevent->callchain || !pevent->sample->callchain || !pevent->machine)
+		return 0;
+
+	if (pyrf_sample_event__resolve_al(pevent) < 0)
+		return 0;
+
+	cursor = get_tls_callchain_cursor();
+	if (thread__resolve_callchain(pevent->al.thread, cursor, pevent->sample,
+				      NULL, NULL, PERF_MAX_STACK_DEPTH) != 0)
+		return 0;
+
+	callchain_cursor_commit(cursor);
+	pchain = PyObject_New(struct pyrf_callchain, &pyrf_callchain__type);
+	if (!pchain)
+		return -ENOMEM;
+
+	pchain->nr_frames = cursor->nr;
+	pchain->frames = calloc(pchain->nr_frames, sizeof(*pchain->frames));
+	if (!pchain->frames) {
+		Py_DECREF(pchain);
+		PyErr_NoMemory();
+		return -ENOMEM;
+	}
+	for (u64 i = 0; i < pchain->nr_frames; i++) {
+		node = callchain_cursor_current(cursor);
+		pchain->frames[i].ip = node->ip;
+		pchain->frames[i].map = map__get(node->ms.map);
+		pchain->frames[i].sym = node->ms.sym;
+		callchain_cursor_advance(cursor);
+	}
+	pevent->callchain = (PyObject *)pchain;
+	return 0;
+}
+
 static PyObject *pyrf_sample_event__get_callchain(PyObject *self, void *closure __maybe_unused)
 {
 	struct pyrf_event *pevent = (void *)self;
 
+	if (pyrf_sample_event__resolve_callchain(pevent) < 0)
+		return NULL;
+
 	if (!pevent->callchain)
 		Py_RETURN_NONE;
 
@@ -1646,13 +1672,31 @@ static int pyrf_event__copy(struct pyrf_event *pevent)
 	size_t copy_size = orig_event->header.size;
 	int err = -EINVAL;
 
+	/*
+	 * If a session callback retained a reference to pevent, resolve its
+	 * address location and callchain now while pevent->machine is still
+	 * live and thread->maps reflects the point in time of the sample.
+	 */
+	if (pevent->machine && pevent->evsel) {
+		pyrf_sample_event__resolve_al(pevent);
+		if (pyrf_sample_event__resolve_callchain(pevent) < 0) {
+			pevent->machine = NULL;
+			if (!pevent->event_copy) {
+				pevent->event = &zero_event;
+				pevent->sample = &pevent->sample_storage;
+			}
+			return -ENOMEM;
+		}
+	}
+	pevent->machine = NULL;
+
 	if (pevent->event_copy)
 		return 0;
 
 	/*
 	 * Clear borrowed pointers immediately so that even if copying fails,
-	 * pevent does not retain dangling pointers to the caller's stack or
-	 * ring buffer.
+	 * pevent does not retain dangling pointers to the caller's stack,
+	 * ring buffer, or session.
 	 */
 	pevent->event = &zero_event;
 	pevent->sample = &pevent->sample_storage;
@@ -1759,7 +1803,7 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	perf_sample__init(&pevent->sample_storage, /*all=*/true);
 	pevent->sample = sample_arg ?: &pevent->sample_storage;
 	pevent->evsel = evsel ? evsel__get(evsel) : NULL;
-	pevent->machine = machine;
+	pevent->machine = NULL;
 	pevent->callchain = NULL;
 	pevent->brstack = NULL;
 	pevent->al_resolved = false;
@@ -1777,11 +1821,8 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 		return NULL;
 	}
 
-	if (!evsel) {
-		if (!pevent->machine && session)
-			pevent->machine = &session->machines.host;
+	if (!evsel)
 		return (PyObject *)pevent;
-	}
 
 	sample = pevent->sample;
 	if (session && session->evlist && perf_guest && sample->id) {
@@ -1802,49 +1843,6 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	pevent->machine = machine;
 	if (machine && machine->pid > 0 && !sample->machine_pid)
 		sample->machine_pid = machine->pid;
-	if (machine && sample->callchain) {
-		struct addr_location al;
-		struct callchain_cursor *cursor;
-		u64 i;
-		struct pyrf_callchain *pchain;
-
-		addr_location__init(&al);
-		if (machine__resolve(machine, &al, sample) >= 0) {
-			cursor = get_tls_callchain_cursor();
-			if (thread__resolve_callchain(al.thread, cursor, sample,
-						      NULL, NULL, PERF_MAX_STACK_DEPTH) == 0) {
-				callchain_cursor_commit(cursor);
-
-				pchain = PyObject_New(struct pyrf_callchain, &pyrf_callchain__type);
-				if (!pchain) {
-					addr_location__exit(&al);
-					Py_DECREF(pevent);
-					return NULL;
-				}
-				pchain->nr_frames = cursor->nr;
-				pchain->frames = calloc(pchain->nr_frames,
-							sizeof(*pchain->frames));
-				if (!pchain->frames) {
-					Py_DECREF(pchain);
-					addr_location__exit(&al);
-					Py_DECREF(pevent);
-					return PyErr_NoMemory();
-				}
-				struct callchain_cursor_node *node;
-
-				for (i = 0; i < pchain->nr_frames; i++) {
-					node = callchain_cursor_current(cursor);
-					pchain->frames[i].ip = node->ip;
-					pchain->frames[i].map =
-						map__get(node->ms.map);
-					pchain->frames[i].sym = node->ms.sym;
-					callchain_cursor_advance(cursor);
-				}
-				pevent->callchain = (PyObject *)pchain;
-			}
-			addr_location__exit(&al);
-		}
-	}
 	if (sample->branch_stack) {
 		struct branch_stack *bs = sample->branch_stack;
 		struct branch_entry *entries = perf_sample__branch_entries(sample);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

