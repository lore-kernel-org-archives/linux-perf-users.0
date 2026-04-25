Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D8B39D6D5
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157460; cv=none; b=aojSuyln00LFK6E7aX4ZK7BAXc6Ihw2bPj+HD3yaWczRF2rZBUsokRpzds5nOr0l/v3imSAs7uwIJU9tiBdt+MN+qvOqj9w08h3eSEp03E4mNOvmzD3qxX4BIjy5fRXoEId1h/I1c++sobFZlNUK+RmLPhkxI1MFVkDu2XRGXzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157460; c=relaxed/simple;
	bh=jDmMhZA3CJOJjsZss/AinSXlk6Jzm8+ex9BbvTUV1fw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F2zcG/XnNAChqQyxx1fnujfvgvzyJc67oQcGgh6LkKAaMRb8xaCMZImjfnpmfSOoOVgXthpZIGNzC26+tayjBxMH6WEXBJhCgFBOAbNISEwBmMt0HjVA4CJI4YC0jRRl3hZFBq2WmzKe+7VQDbKkspUotutOT4VjdZRd9bJLqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e7Xzah3U; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7Xzah3U"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c8de02a4dso15630208c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157457; x=1777762257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZwlD8Dg9RxeiBkuuR5VQDv1GiXEHsJfT+1oBNmSxHU=;
        b=e7Xzah3Uc1HkRcvhj8SRrx/UeefMH0qQhgO6g0TK7TkzbtvBFPt5bnXzP6dafFGTiB
         N83IYtZxv/DHtJcsIYbqvYELFUZai+ht1ab11RzhyEcpYyLMZCKWoMNsiZUhLCyl2mkQ
         ZYD5IGqL+bcO+o/UVcspcs4wZhB92wrlEAc5vr+d+GUzil5n9vPJsc5VC8Ks1QKs/eCF
         Sn2hCWmNz+Im5kTLUorqpG/q8X7PpHbdoUW/8/+PtQCG9Q4SfHvHhx8mhZBzJztSFcjO
         PhClcqm/qD9KYoY5jK+Y0JYN3jCjPnNFaADBnOYjqYIGKKZVTAh06Py7YSyq0c8ZAJ9o
         GLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157457; x=1777762257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZwlD8Dg9RxeiBkuuR5VQDv1GiXEHsJfT+1oBNmSxHU=;
        b=Ye0P5WHUrgXTVcyMRZ1XMwt9EQMfRZPq3oV8T1ZMxzjBbACgbaxe2YMjAgCpBNR7xp
         ZI83odjEu1FXUzWITUJYxEVlTHmw0iy+x5LZOFitxGolo8dkLpz3CjbGkovAc+ayBbfB
         IiDqoo8DtTUEV8Wuzb7tuAJsy8fa9BhM52wCwk58EVHDTobxJv7FHi8f1Q30QAfnLgIp
         SoqKJmOMOzZOXw+FuINlcJi8sqQCEAauRKtE7mGwOYoCc0P4fKx3hGXx2poQ7IsuNX/Y
         1vg2tsgBUKOEW44j1cm/9ApohjRbNRuWKH/tinTOcf9CJNKBTphVItOzcp2prD36ViQI
         eF7w==
X-Forwarded-Encrypted: i=1; AFNElJ/Ccvw0ZkPzEMUVwl2N8Ln2OA7H6IEVSchL0H3JJEJINCBeVOrj2dZUY6uXvhHr71fk8VsJ1BBk1ANFeGATPEcx@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuhqfwEA4uOqwkIGsu9KZ+it3n4rhdPBTGn2htEELIX6eOrVZ
	3aKJaqm4ydFLGmOIp3yCyoOndAe6tJ4CEsSt/+MTUdJOE6g/N06dA+AzdN+1R/swIK8NnBUd0oq
	gw489Bmm5lA==
X-Received: from dlbts2-n2.prod.google.com ([2002:a05:7022:b042:20b0:128:cfd6:a3c6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:30b:b0:12b:ed30:5b85
 with SMTP id a92af1059eb24-12c73f67190mr19833604c88.2.1777157456770; Sat, 25
 Apr 2026 15:50:56 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:13 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-22-irogers@google.com>
Subject: [PATCH v7 21/59] perf python: Expose brstack in sample event
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

v6:
- Moved branch stack resolution from `session_tool__sample` to
  `pyrf_event__new`.
---
 tools/perf/util/python.c | 188 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 17d0ee15336f..256129fef4f8 100644
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
 	Py_TYPE(pevent)->tp_free((PyObject *)pevent);
 }
@@ -871,6 +875,144 @@ static PyObject *pyrf_sample_event__get_callchain(PyObject *self, void *closure
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
@@ -891,6 +1033,12 @@ static PyGetSetDef pyrf_sample_event__getset[] = {
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
@@ -1071,6 +1219,12 @@ static int pyrf_event__setup_types(void)
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
@@ -1251,6 +1405,7 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	memcpy(&pevent->event, event, event->header.size);
 	perf_sample__init(&pevent->sample, /*all=*/true);
 	pevent->callchain = NULL;
+	pevent->brstack = NULL;
 	pevent->al_resolved = false;
 	addr_location__init(&pevent->al);
 
@@ -1307,6 +1462,27 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
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
 
@@ -3708,6 +3884,18 @@ PyMODINIT_FUNC PyInit_perf(void)
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

