Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820B63D8137
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360799; cv=none; b=cBQ5Mh2/0L9nCWUGkulkPF/MoqDxTyptouzEU+hzuc2K4PcHdX+rSTdw/Nxam939/W+2nnIDJ62oGvr+Q9z8iJxz+XKe+YlDcbAaKw1U3pxOStkSwZN3qOw9fKc7GCy2z38I0bhTeWYP6UBJHYBK7vpqtrGrTPOvG4he3vL5dyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360799; c=relaxed/simple;
	bh=sHlykUY8ugsPXc0OzhhBnJwhekD8IQ6BM2q1Ln/DcUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U16uvb6IzuanBkGiN/SZnvDzL0WLF92yFnYoxoa5Rgd5S7l//sgbkEX/Rrrmfjk3we8s85PsLb5XfyLSo8v8xtaL2X2vrZ2fl/pocGE9XMpSjzO5z3PUqi8i6VmQ4EUYagIn6Mkn9JCGrfrhVel11y5GRLGYMKOFhvmXBJx6wNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oz0IodND; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oz0IodND"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c16233ee11so15294738eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360797; x=1777965597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NM8MmFs51bCluxfEvZVq8FmIxeuvBEx0XSUWwcZ6XFQ=;
        b=Oz0IodNDn6++a7yU1ppyZ8z9izRIldRngufuId1xywsLgbaEoy2xM7uvy0QVwALyrR
         L3NR7W9wG/d2onYS6PHTFokPeqTUVHLkjwjHOig4ma5zt7vWMnPatUfrMyWRSM3FoLLs
         CuPrJC7N7gOAXUstAiZK+l7igIi9OYExDZkRDkEd8oIGGdOMIrbIjpxYm5TkVqzG+dxX
         sBWlM6iFzYO2x+m0p+yG1BYA6e7hL+8Hf6/sDm7gIRIOmC+M1TlVY0V69sBgdt7/PCJ3
         ycfsPMtbu0nRv/3HOSy9cvf7BdO88kltBh7aBnOKEq0G54UG03v+4qZPd8tDwJVrDtWs
         GIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360797; x=1777965597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NM8MmFs51bCluxfEvZVq8FmIxeuvBEx0XSUWwcZ6XFQ=;
        b=sucvXaPMxJpQSuApe9nHlQn+jd4VYCWNhkMsXkx0RArrh+R5oqCthvfP1nfJ5Su6PR
         jx+X4CbChkW7drNUqgdZoR2x9wqS++BC9m/ueWuqsiQQOfOe0bBDTNlDdKC3d9SmGSrr
         YjWqAyk9zQvsJgIuXBhQrIkoKglO5XmipHdpEg0aTqYPHo9I7MSbi+0mSXyMVwwZCJql
         RdC3plPsG+LW6qnrLjrayPSZIzn+0Yl6w5qVaIQLx1MFMu4fDCy0oWwZNp9n+kkx5vGl
         JSSQpNuHHCRBUnbkYhs2bVQdEi/hv36JLGTvLbUTz76mLqMm5mvrhcMMsw/zqXylaAWy
         E2Pw==
X-Forwarded-Encrypted: i=1; AFNElJ+W0ea+l5hHHzJZRasqfcgC7d7xQ07yONarg2SEUcx0JirVwRhE+x4xNalsJ0C2BdSEiyuMQo7oTDFOlbUYwC6O@vger.kernel.org
X-Gm-Message-State: AOJu0YzepxSufOsaA6EzcB7fq1dp6HgD2xu36k+FzoBLiVpTQYzOdj6+
	d05XvoTFk0A7k+nhNYxhhtQ/6mCn2qwFE4YK8lJtnlbks4Y4KiNviQq6rhutupbflDofYw42S1x
	/rj8t82tfgw==
X-Received: from dybqo1.prod.google.com ([2002:a05:7301:6781:b0:2d8:c995:cafe])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6412:b0:2ed:e12:376a
 with SMTP id 5a478bee46e88-2ed0e128922mr513997eec.32.1777360796315; Tue, 28
 Apr 2026 00:19:56 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:24 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-20-irogers@google.com>
Subject: [PATCH v8 19/58] perf python: Expose brstack in sample event
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement pyrf_branch_entry and pyrf_branch_stack for lazy
iteration over branch stack entries.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Avoided Keyword Collision: Renamed the properties "from" and "to"
   to "from_ip" and "to_ip" in pyrf_branch_entry__getset[] to prevent
   syntax errors in Python.

2. Eager Branch Stack Resolution: Updated pyrf_session_tool__sample()
   to allocate and copy the branch stack entries eagerly when the
   event is processed, instead of deferring it to iteration time. This
   avoids reading from potentially overwritten or unmapped mmap
   buffers.

3. Updated Iterators: Updated pyrf_branch_stack and
   pyrf_branch_stack__next() to use the copied entries rather than
   pointing directly to the sample's buffer.

4. Avoided Reference Leak on Init Failure: Added proper error checking
   for PyModule_AddObject() in the module initialization function,
   decrementing references on failure.

v6:
- Moved branch stack resolution from `session_tool__sample` to
  `pyrf_event__new`.
---
 tools/perf/util/python.c | 188 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 144fbc85fcb3..c947abf8affe 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -17,6 +17,7 @@
 #include "debug.h"
 #include "dso.h"
 #include "event.h"
+#include "branch.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "expr.h"
@@ -66,6 +67,8 @@ struct pyrf_event {
 	bool al_resolved;
 	/** @callchain: Resolved callchain, eagerly computed if requested. */
 	PyObject *callchain;
+	/** @brstack: Resolved branch stack, eagerly computed if requested. */
+	PyObject *brstack;
 	/** @event: The underlying perf_event that may be in a file or ring buffer. */
 	union perf_event event;
 };
@@ -104,6 +107,7 @@ static void pyrf_event__delete(struct pyrf_event *pevent)
 	if (pevent->al_resolved)
 		addr_location__exit(&pevent->al);
 	Py_XDECREF(pevent->callchain);
+	Py_XDECREF(pevent->brstack);
 	perf_sample__exit(&pevent->sample);
 	Py_TYPE(pevent)->tp_free((PyObject *)pevent);
 }
@@ -916,6 +920,144 @@ static PyObject *pyrf_sample_event__get_callchain(PyObject *self, void *closure
 	return pevent->callchain;
 }
 
+struct pyrf_branch_entry {
+	PyObject_HEAD
+	u64 from;
+	u64 to;
+	struct branch_flags flags;
+};
+
+static void pyrf_branch_entry__delete(struct pyrf_branch_entry *pentry)
+{
+	Py_TYPE(pentry)->tp_free((PyObject *)pentry);
+}
+
+static PyObject *pyrf_branch_entry__get_from(struct pyrf_branch_entry *pentry,
+					     void *closure __maybe_unused)
+{
+	return PyLong_FromUnsignedLongLong(pentry->from);
+}
+
+static PyObject *pyrf_branch_entry__get_to(struct pyrf_branch_entry *pentry,
+					   void *closure __maybe_unused)
+{
+	return PyLong_FromUnsignedLongLong(pentry->to);
+}
+
+static PyObject *pyrf_branch_entry__get_mispred(struct pyrf_branch_entry *pentry,
+						void *closure __maybe_unused)
+{
+	return PyBool_FromLong(pentry->flags.mispred);
+}
+
+static PyObject *pyrf_branch_entry__get_predicted(struct pyrf_branch_entry *pentry,
+						  void *closure __maybe_unused)
+{
+	return PyBool_FromLong(pentry->flags.predicted);
+}
+
+static PyObject *pyrf_branch_entry__get_in_tx(struct pyrf_branch_entry *pentry,
+					      void *closure __maybe_unused)
+{
+	return PyBool_FromLong(pentry->flags.in_tx);
+}
+
+static PyObject *pyrf_branch_entry__get_abort(struct pyrf_branch_entry *pentry,
+					      void *closure __maybe_unused)
+{
+	return PyBool_FromLong(pentry->flags.abort);
+}
+
+static PyObject *pyrf_branch_entry__get_cycles(struct pyrf_branch_entry *pentry,
+					       void *closure __maybe_unused)
+{
+	return PyLong_FromUnsignedLongLong(pentry->flags.cycles);
+}
+
+static PyObject *pyrf_branch_entry__get_type(struct pyrf_branch_entry *pentry,
+					     void *closure __maybe_unused)
+{
+	return PyLong_FromLong(pentry->flags.type);
+}
+
+static PyGetSetDef pyrf_branch_entry__getset[] = {
+	{ .name = "from_ip",      .get = (getter)pyrf_branch_entry__get_from, },
+	{ .name = "to_ip",        .get = (getter)pyrf_branch_entry__get_to, },
+	{ .name = "mispred",   .get = (getter)pyrf_branch_entry__get_mispred, },
+	{ .name = "predicted", .get = (getter)pyrf_branch_entry__get_predicted, },
+	{ .name = "in_tx",     .get = (getter)pyrf_branch_entry__get_in_tx, },
+	{ .name = "abort",     .get = (getter)pyrf_branch_entry__get_abort, },
+	{ .name = "cycles",    .get = (getter)pyrf_branch_entry__get_cycles, },
+	{ .name = "type",      .get = (getter)pyrf_branch_entry__get_type, },
+	{ .name = NULL, },
+};
+
+static PyTypeObject pyrf_branch_entry__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.branch_entry",
+	.tp_basicsize	= sizeof(struct pyrf_branch_entry),
+	.tp_dealloc	= (destructor)pyrf_branch_entry__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= "perf branch entry object.",
+	.tp_getset	= pyrf_branch_entry__getset,
+};
+
+struct pyrf_branch_stack {
+	PyObject_HEAD
+	struct pyrf_event *pevent;
+	struct branch_entry *entries;
+	u64 nr;
+	u64 pos;
+};
+
+static void pyrf_branch_stack__delete(struct pyrf_branch_stack *pstack)
+{
+	Py_XDECREF(pstack->pevent);
+	free(pstack->entries);
+	Py_TYPE(pstack)->tp_free((PyObject *)pstack);
+}
+
+static PyObject *pyrf_branch_stack__next(struct pyrf_branch_stack *pstack)
+{
+	struct pyrf_branch_entry *pentry;
+
+	if (pstack->pos >= pstack->nr)
+		return NULL;
+
+	pentry = PyObject_New(struct pyrf_branch_entry, &pyrf_branch_entry__type);
+	if (!pentry)
+		return NULL;
+
+	pentry->from = pstack->entries[pstack->pos].from;
+	pentry->to = pstack->entries[pstack->pos].to;
+	pentry->flags = pstack->entries[pstack->pos].flags;
+
+	pstack->pos++;
+	return (PyObject *)pentry;
+}
+
+static PyTypeObject pyrf_branch_stack__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.branch_stack",
+	.tp_basicsize	= sizeof(struct pyrf_branch_stack),
+	.tp_dealloc	= (destructor)pyrf_branch_stack__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= "perf branch stack object.",
+	.tp_iter	= PyObject_SelfIter,
+	.tp_iternext	= (iternextfunc)pyrf_branch_stack__next,
+};
+
+static PyObject *pyrf_sample_event__get_brstack(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_event *pevent = (void *)self;
+
+	if (!pevent->brstack)
+		Py_RETURN_NONE;
+
+	Py_INCREF(pevent->brstack);
+	return pevent->brstack;
+}
+
 static PyObject*
 pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
 {
@@ -936,6 +1078,12 @@ static PyGetSetDef pyrf_sample_event__getset[] = {
 		.set = NULL,
 		.doc = "event callchain.",
 	},
+	{
+		.name = "brstack",
+		.get = pyrf_sample_event__get_brstack,
+		.set = NULL,
+		.doc = "event branch stack.",
+	},
 	{
 		.name = "raw_buf",
 		.get = (getter)pyrf_sample_event__get_raw_buf,
@@ -1117,6 +1265,12 @@ static int pyrf_event__setup_types(void)
 	err = PyType_Ready(&pyrf_callchain__type);
 	if (err < 0)
 		goto out;
+	err = PyType_Ready(&pyrf_branch_entry__type);
+	if (err < 0)
+		goto out;
+	err = PyType_Ready(&pyrf_branch_stack__type);
+	if (err < 0)
+		goto out;
 out:
 	return err;
 }
@@ -1303,6 +1457,7 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 
 	perf_sample__init(&pevent->sample, /*all=*/true);
 	pevent->callchain = NULL;
+	pevent->brstack = NULL;
 	pevent->al_resolved = false;
 	addr_location__init(&pevent->al);
 
@@ -1359,6 +1514,27 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 			addr_location__exit(&al);
 		}
 	}
+	if (sample->branch_stack) {
+		struct branch_stack *bs = sample->branch_stack;
+		struct branch_entry *entries = perf_sample__branch_entries(sample);
+		struct pyrf_branch_stack *pstack;
+
+		pstack = PyObject_New(struct pyrf_branch_stack, &pyrf_branch_stack__type);
+		if (pstack) {
+			Py_INCREF(pevent);
+			pstack->pevent = pevent;
+			pstack->pos = 0;
+			pstack->nr = bs->nr;
+			pstack->entries = calloc(bs->nr, sizeof(struct branch_entry));
+			if (pstack->entries) {
+				memcpy(pstack->entries, entries,
+				       bs->nr * sizeof(struct branch_entry));
+				pevent->brstack = (PyObject *)pstack;
+			} else {
+				Py_DECREF(pstack);
+			}
+		}
+	}
 	return (PyObject *)pevent;
 }
 
@@ -3735,6 +3911,18 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_session__type);
 	PyModule_AddObject(module, "session", (PyObject *)&pyrf_session__type);
 
+	Py_INCREF(&pyrf_branch_entry__type);
+	if (PyModule_AddObject(module, "branch_entry", (PyObject *)&pyrf_branch_entry__type) < 0) {
+		Py_DECREF(&pyrf_branch_entry__type);
+		goto error;
+	}
+
+	Py_INCREF(&pyrf_branch_stack__type);
+	if (PyModule_AddObject(module, "branch_stack", (PyObject *)&pyrf_branch_stack__type) < 0) {
+		Py_DECREF(&pyrf_branch_stack__type);
+		goto error;
+	}
+
 	dict = PyModule_GetDict(module);
 	if (dict == NULL)
 		goto error;
-- 
2.54.0.545.g6539524ca2-goog

