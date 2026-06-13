Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4EC3C3C08
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781328485; cv=none; b=tbQ6m0VAqyqsLHh9et3NDo2TjOTKIymBjqRVxwlHs48nMiOiwI5W60hWBPG20aW0Ici1yDXdPD5E0PSCDoTLvyVl9zZHMAnOnNPaqhWw5PyHmuV8llVIjMT3Q9gcaqjWw3abtj3ZVhcBhgEULugT97hwl3qYbJgXJlGiePw9860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781328485; c=relaxed/simple;
	bh=6BHIWfnuEIDdWajaFNMwPY7O5xdFlSCuAMSWBT9TSeM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dPIizQ0ZbfZ18apn/s5um4ucaFAS6LLf/rQHVHKucSNW39C8JvzGnFSfABx9MRmWWVojGwhndXR1i2gsYrDtVM3tiWrZTgEm4e3kfUFNX3qa/oAaSoQhGhzQ8j+znBw+TvB16EXMucQUFC+a071gH9qfZdjMPsfSqMMgLRNDHjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ixUZx7lQ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ixUZx7lQ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3075fa5a407so853732eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781328477; x=1781933277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DDknL0m0LAkxOv84LU1BfXnKLXkeDIAiLnx6CWaf/KI=;
        b=ixUZx7lQf0MIYam2ArEuIaVCmFPrV98DaemFgaQuZ8XFhHPPakxH1XNAyDtiZjNC9z
         I240D6+LOHrJe6G5b6qoY2HQWWeGdZw3RUnyTu9NbwBX0dyFOGVTsSZr4gi5eBrxvlAr
         rqtToM4isvCt7pMZCTurTZF83QPue560vO6vdX9t1tSvYE8O8DnjfQqS7GUPmNsMENz+
         w+TR2yAtkIejRcyEGFjMKgi1l7As893nRMKxx9bJQqiq2WQk8n8pZ895DLOkO54Og625
         wxUYty6Gc57DrXuT1QyhrWt6pM4PUtiRBEk2RABDAEWCSyZ1093iPBFJejsUTTox9Wlk
         pCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781328477; x=1781933277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDknL0m0LAkxOv84LU1BfXnKLXkeDIAiLnx6CWaf/KI=;
        b=CVIbcjtZ+Umjzqt58ORz4NjimtVT/A6QbzAwyof+Dm3EXKq6Lrcm2NnqKIsx5OtsO+
         /krUtu846yb7gza+MfaWvhSn5nCObSQsQ121IWsHbztbHMg0dBGATxb3Rz7SQfNyAgax
         f0RtJXIt8Lkq8dwYs9FQ4qLHwi+m6kjYMm8ODC1EKAA/XV9SzWt9rfU2RMkbYfKR1k7g
         1MUkFRF7i/HGdeTEcucNnB1gF0LGRrL5cGRUek63B4Muw2igvoamkt3GLM/tg5tlibWS
         1TJiXKgMaT+xDF5ddbChUKV0wCbkXpspJ4ly9LLPXNTN4BDakDTG2Vxv5dv0BoUShCH0
         jw9w==
X-Forwarded-Encrypted: i=1; AFNElJ9o8nSu8IWHyUn3xcGTb5nlVv3r7QGzVE9o/A5wQcBGmoEcxRCHub3rl75s64p4gVBNk0DU5k3sCqRqZChTrXEP@vger.kernel.org
X-Gm-Message-State: AOJu0YwXZRVlUOrOg//HSoy6jsE5NW2K7pzs9iHPp0JWYtkYgMfdhIdz
	nOTB2yWvRV69oqq7ZG3Ncx87YWGZqGVAbGOCGYKrE6HFmfpz2SIKgxOqdHyw4v2XTXEKH7OZH4h
	KOATpUaqn6Q==
X-Received: from dybvq12.prod.google.com ([2002:a05:7301:77cc:b0:30a:e530:f075])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:caa:b0:307:140f:d511
 with SMTP id 5a478bee46e88-30941e49533mr1327705eec.33.1781328476933; Fri, 12
 Jun 2026 22:27:56 -0700 (PDT)
Date: Fri, 12 Jun 2026 22:27:16 -0700
In-Reply-To: <20260613052722.1424093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612221211.1221305-1-irogers@google.com> <20260613052722.1424093-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613052722.1424093-16-irogers@google.com>
Subject: [PATCH v16 15/20] perf python: Expose brstack in sample event
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
 tools/perf/util/python.c | 198 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 08fd04bef7f2..39eab82d4487 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -22,6 +22,7 @@
 #include "debug.h"
 #include "dso.h"
 #include "event.h"
+#include "branch.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "expr.h"
@@ -89,6 +90,8 @@ struct pyrf_event {
 	bool al_resolved;
 	/** @callchain: Resolved callchain, eagerly computed if requested. */
 	PyObject *callchain;
+	/** @brstack: Resolved branch stack, eagerly computed if requested. */
+	PyObject *brstack;
 	/** @event: The underlying perf_event that may be in a file or ring buffer. */
 	union perf_event event;
 };
@@ -127,6 +130,7 @@ static void pyrf_event__delete(struct pyrf_event *pevent)
 	if (pevent->al_resolved)
 		addr_location__exit(&pevent->al);
 	Py_XDECREF(pevent->callchain);
+	Py_XDECREF(pevent->brstack);
 	perf_sample__exit(&pevent->sample);
 	Py_TYPE(pevent)->tp_free((PyObject *)pevent);
 }
@@ -997,6 +1001,154 @@ static PyObject *pyrf_sample_event__get_callchain(PyObject *self, void *closure
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
+	return PyLong_FromUnsignedLongLong((unsigned long long)pentry->flags.type);
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
+	struct branch_entry *entries;
+	u64 nr;
+};
+
+static void pyrf_branch_stack__delete(struct pyrf_branch_stack *pstack)
+{
+	free(pstack->entries);
+	Py_TYPE(pstack)->tp_free((PyObject *)pstack);
+}
+
+static Py_ssize_t pyrf_branch_stack__length(PyObject *obj)
+{
+	struct pyrf_branch_stack *pstack = (void *)obj;
+
+	return pstack->nr;
+}
+
+static PyObject *pyrf_branch_stack__item(PyObject *obj, Py_ssize_t i)
+{
+	struct pyrf_branch_stack *pstack = (void *)obj;
+	struct pyrf_branch_entry *pentry;
+
+	if (i < 0 || i >= (Py_ssize_t)pstack->nr) {
+		PyErr_SetString(PyExc_IndexError, "Index out of range");
+		return NULL;
+	}
+
+	pentry = PyObject_New(struct pyrf_branch_entry, &pyrf_branch_entry__type);
+	if (!pentry)
+		return NULL;
+
+	pentry->from = pstack->entries[i].from;
+	pentry->to = pstack->entries[i].to;
+	pentry->flags = pstack->entries[i].flags;
+
+	return (PyObject *)pentry;
+}
+
+static PySequenceMethods pyrf_branch_stack__sequence_methods = {
+	.sq_length = pyrf_branch_stack__length,
+	.sq_item   = pyrf_branch_stack__item,
+};
+
+static PyTypeObject pyrf_branch_stack__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.branch_stack",
+	.tp_basicsize	= sizeof(struct pyrf_branch_stack),
+	.tp_dealloc	= (destructor)pyrf_branch_stack__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= "perf branch stack object.",
+	.tp_as_sequence	= &pyrf_branch_stack__sequence_methods,
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
@@ -1017,6 +1169,12 @@ static PyGetSetDef pyrf_sample_event__getset[] = {
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
@@ -1198,6 +1356,12 @@ static int pyrf_event__setup_types(void)
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
@@ -1263,6 +1427,7 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 
 	perf_sample__init(&pevent->sample, /*all=*/true);
 	pevent->callchain = NULL;
+	pevent->brstack = NULL;
 	pevent->al_resolved = false;
 	addr_location__init(&pevent->al);
 
@@ -1320,6 +1485,27 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 			addr_location__exit(&al);
 		}
 	}
+	if (sample->branch_stack) {
+		struct branch_stack *bs = sample->branch_stack;
+		struct branch_entry *entries = perf_sample__branch_entries(sample);
+		struct pyrf_branch_stack *pstack;
+
+		pstack = PyObject_New(struct pyrf_branch_stack, &pyrf_branch_stack__type);
+		if (!pstack) {
+			Py_DECREF(pevent);
+			return NULL;
+		}
+		pstack->nr = bs->nr;
+		pstack->entries = calloc(bs->nr, sizeof(struct branch_entry));
+		if (!pstack->entries) {
+			Py_DECREF(pstack);
+			Py_DECREF(pevent);
+			return PyErr_NoMemory();
+		}
+		memcpy(pstack->entries, entries,
+		       bs->nr * sizeof(struct branch_entry));
+		pevent->brstack = (PyObject *)pstack;
+	}
 	return (PyObject *)pevent;
 }
 
@@ -3891,6 +4077,18 @@ PyMODINIT_FUNC PyInit_perf(void)
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
2.54.0.1136.gdb2ca164c4-goog

