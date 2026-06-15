Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2713BFAF2
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562660; cv=none; b=XjI49HK5G8g/RZnfMYHkJMNH5qGZ/PUOlK7V71qIWn7kPkMcvXHeDgBO7Q9tw62+l6NlnjV026kAi1pR5WbXo0WqTOHYidQQ0iOxbLb5Ts/abizMaPrIDSBX9r4Wv0Y3Dky6dv30Yyec4jG9w0tkoUdk8N7ok308mFCQFFDuoEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562660; c=relaxed/simple;
	bh=9YGUsUzLYhD8XJHaX9ZnkC25/6gAFjUsnJxT1hUoFuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gEjg/q8KIGeG/euZZsA//o0cbcdVqfVRkZC364Jn5UD9UvGaQkdOpoWCXwtF9oXf9F6wAOBIPYZjVqcZNDxTVv/P38AVpL+A4rn5dXjFyK54izTJDllddVCu/2wVtZ1vyv8umFXycNKlbN6clk9M8FNQvlJ5hQinwnwds+ubteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mrXbYFUS; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mrXbYFUS"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3080bb0267dso615356eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781562657; x=1782167457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVK3FkXCbTNpq89+mLIqwXCTcGUtlpUopGuzTNxk1yw=;
        b=mrXbYFUSOfXEUidRM7dNB9SCKqV3IkXDahHPZ2tmKniOtG8WIv2X7myDp2z47gfcQp
         tHo0Va9jkj7EVZGSRrYYydcOXd03GAJbwJ+Cq2nTJ42dvSF4BX/ePV+GC9+CN0A4GalM
         CLnWjcPPvJfy5A8TTThkG7D9wqL3p8uumXY2PRR1HCM7QO65XItqByAB+ViN1HrzqFOu
         5QWSll3v7ofTuGIDWv/zRxXq4MxfkmD09rjltr1ZpHhObMW4IjCYTjodv4ljveSQ+GFP
         eDFhtJJYSsO9PBW7by9WDX32E85Zu1RB3/rTluUbHTHb/sQcYWRnTziU7RUYf3I7ouNZ
         wxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781562657; x=1782167457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVK3FkXCbTNpq89+mLIqwXCTcGUtlpUopGuzTNxk1yw=;
        b=CLEHxHDG0dLk/0d3PEhcWTtM8TtPL/lZa6SqNurN2r6TENLk433BdOrtCPJZiRIPK+
         aJnqUqnD5qZzci4wkJZC7vsJ68IufzrnvUO/6ArNycUgXtmgb9JjYIyJG2S9iK9bnvq0
         mL/pGG29dzQL+EbpcG0oFwWp0ydydRIXSDbCUTa90KPFCwnvs4Q6etlQHZVClsZLM7Mu
         cLhoD66caiLroUw66UV66CrB1L91YF73ZPKtLmaXezpgwRTZo8m82OI0KrBXswfJuimo
         1ApwuZJQtNYIApTbyeKLsE6349Hcgm4IMizWMG21ESTre/uEyqkSuNYRglUh7sEmELjz
         SIEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ijMgf8fLa/50Ln/dPTextSUeYwksfqeSE10cARgsnNEidBrEom+tSwu72dREfnb0FsO7Xrkp1c38UzFa+oJ8U@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8CHQHBMsFR55eCUOpBvQByGwfC/3ceWrOJBTNzlWyPXwh5KUw
	F3ISGATlGLmRR65UzoUgZKxbvT1/7I1ggI9zh4gfEh20FJG5FcqR6QmdgUHDy72wq7l1PRS2pzM
	bolf/EGGIPw==
X-Received: from dycog13.prod.google.com ([2002:a05:7301:9a8d:b0:304:d831:cdfc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:640e:b0:2be:1f58:32a3
 with SMTP id 5a478bee46e88-3093e39e015mr7108646eec.29.1781562656302; Mon, 15
 Jun 2026 15:30:56 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:30:05 -0700
In-Reply-To: <20260615223011.3873955-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615223011.3873955-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615223011.3873955-16-irogers@google.com>
Subject: [PATCH v20 15/21] perf python: Expose brstack in sample event
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
 tools/perf/util/python.c | 198 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index db7f4a8ebcd1..05691a513184 100644
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
@@ -1264,6 +1428,7 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 
 	perf_sample__init(&pevent->sample, /*all=*/true);
 	pevent->callchain = NULL;
+	pevent->brstack = NULL;
 	pevent->al_resolved = false;
 	addr_location__init(&pevent->al);
 
@@ -1325,6 +1490,27 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
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
 
@@ -3912,6 +4098,18 @@ PyMODINIT_FUNC PyInit_perf(void)
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

