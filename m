Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76D3E5581
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049314; cv=none; b=ha0XO5oi9f3dwqhzgJ+Yx7cwTQhqnoINNQ8xNsl1juxqcWR4+DwAB5Op2W7NECYMXH11otStTTe6JBUtVJTATTascUfmP3z02uEMT0F27xFN5WER3+EsJy1dNxEM8bL7ZE9NIoJzY180J2zz7V0cQIRpKruR81UkSGxd7lhOy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049314; c=relaxed/simple;
	bh=EuEzZ1uybJ8+30wAlp/UbDXzHi9pozreJw0ZGjgNRAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ou6FjfB3ANmdD0Y1AeuDq5dM35r3Qpt0giyKkajjPMrQhQn5hwFx3WrPuHNmuf/yVjIDDyoM5vfnAOLZHBhJ6NXc3/72UWj/HucqKubPf4y6MqT9MnXRACrEnwErVDc7GqAc0PRY00SCbbq3MrF8a9rzA9K8bLWVa/J2JDeEBVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lFpzKMlY; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFpzKMlY"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-126e8ee6227so7671174c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049311; x=1777654111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uDc5xewnW/WRCZ/eh4TAnhQjeYJkHUDchE4dgYupOns=;
        b=lFpzKMlYiQhmtVZUvNj7MPPGJZHVYQKxymek5kJV/n3V9QrT2glQAxGjx6FdOs2oWT
         MNGrHHhUg4xgcHDTOKDquf3IgjMYOivpq5/5kiXb25Hav+LmCyf1gqaf7Zd5XmHVHS/v
         it8PyRiKTWOKorHJnz98XJGisXCx+3cvXXjKbztoIKtIiCRDDueOr59GzJsuXJRn6yNB
         dm4sibi9na1hP24SBkUKftclVSfmfcWlaJiVe/Edmcp/wLI2uDC0Pmh/b9u2U7n+SVc9
         5PS4MRogdgPqs0IUeiIFuIpDuWCcUUmkE4HsW/xpwFcRSPJq6MM4xSTDMTBOZpgzhsR0
         5deA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049311; x=1777654111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDc5xewnW/WRCZ/eh4TAnhQjeYJkHUDchE4dgYupOns=;
        b=osoQKKEvUzUdi2jfr5hAfn8k9qyxcklBZ2CvqkAmST3a0NQSQFe8W5rfmt9dK7fAm7
         CgKQrECTfsZ0CaKTEoNj6ugi3rNci3yVhTq9pHG7f3KcJVC3uRr0XDLq4X1XuvRsgTFS
         BYAyym9j345qTnKC+A62J6ZlU1f5tv0ZtQa7DRqMcuqREdhKgmfcQ32472sQog/m2cDR
         xInk1YdT9pzeK0A+7AvSt99Au0ZaSDr2c78S6H4UJTSVS3UadViQ17DRYcoq3P1JNAQ/
         j0v/V3ylqjAlXV6q6rSI8h6H23X5ftDyTD9+zbaqGtwGo9oT3pyWE9GHoJ7ukeKtGuTL
         v6mQ==
X-Forwarded-Encrypted: i=1; AFNElJ8TvSFzbSqPEgmGGJVATKbKDShdTV1WXr/LEYBYmJb8OLHKzLQpCCJIGTtb6OTv/gHX6K96czdxmHqR0FxgnTh1@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMf8Yw3yQeRWrCxQC2CskyYZjDv5QaVQxEEt/0FYfbzXi8U0m
	0CdQlgED1C/SCBe6BNFDIHQ0CR6G4cnEsx3PZFv+Cc5q4FOr4q2vQw7xXDzMZQvIe/PTFBwZ326
	ncUrrEl7JAw==
X-Received: from dlbui16.prod.google.com ([2002:a05:7022:3d10:b0:12d:b27b:7405])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b99:b0:12c:2dd7:9099
 with SMTP id a92af1059eb24-12c73f9fb84mr18002120c88.30.1777049311224; Fri, 24
 Apr 2026 09:48:31 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:43 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-22-irogers@google.com>
Subject: [PATCH v5 21/58] perf python: Expose brstack in sample event
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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
---
 tools/perf/util/python.c | 189 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index c4f0e01b64f3..b446b1e9cfb6 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -19,6 +19,7 @@
 #include "dso.h"
 #include "dwarf-regs.h"
 #include "event.h"
+#include "branch.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "expr.h"
@@ -69,6 +70,8 @@ struct pyrf_event {
 	bool al_resolved;
 	/** @callchain: Resolved callchain, eagerly computed if requested. */
 	PyObject *callchain;
+	/** @brstack: Resolved branch stack, eagerly computed if requested. */
+	PyObject *brstack;
 	/** @event: The underlying perf_event that may be in a file or ring buffer. */
 	union perf_event event;
 };
@@ -107,6 +110,7 @@ static void pyrf_event__delete(struct pyrf_event *pevent)
 	if (pevent->al_resolved)
 		addr_location__exit(&pevent->al);
 	Py_XDECREF(pevent->callchain);
+	Py_XDECREF(pevent->brstack);
 	perf_sample__exit(&pevent->sample);
 	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
 }
@@ -870,6 +874,144 @@ static PyObject *pyrf_sample_event__get_callchain(PyObject *self, void *closure
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
@@ -890,6 +1032,12 @@ static PyGetSetDef pyrf_sample_event__getset[] = {
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
@@ -1070,6 +1218,12 @@ static int pyrf_event__setup_types(void)
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
@@ -1120,6 +1274,7 @@ static PyObject *pyrf_event__new(const union perf_event *event)
 		memcpy(&pevent->event, event, event->header.size);
 		pevent->sample.evsel = NULL;
 		pevent->callchain = NULL;
+		pevent->brstack = NULL;
 		pevent->al_resolved = false;
 		addr_location__init(&pevent->al);
 	}
@@ -3160,6 +3315,28 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
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
+
 	ret = PyObject_CallFunction(psession->sample, "O", pyevent);
 	if (!ret) {
 		PyErr_Print();
@@ -3543,6 +3720,18 @@ PyMODINIT_FUNC PyInit_perf(void)
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

