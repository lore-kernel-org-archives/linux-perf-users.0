Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AFE379C28
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572581; cv=none; b=fclBqvqoTe9+nf4IHGXgpFBAFhcXOtH68xQwF+lFAyaygVM8w4NVHPECxPhOoRuiTRCp8DdPOw0lP70jn6l0kG9DkzQ9KBtlKkDLEChdYMZagGvQ/ANS9/Xd5q6Yv/SsJtqJkY59ys8PGOu85sqoZLzZZhYE0nIYbvjNOJvSgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572581; c=relaxed/simple;
	bh=6eO1ch38VO/OEFgU/BYLO4gQkJ7Our8r3ufLonmsQBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sWF65bwa/nxgVRsw/HJM2kI945jpPxtprcQ3pF8yAhm/oKPI0E5hsWwX7cgfw24Dk9p2nmuCPg+Zcy2Y2UkqqOstbMVC5lQgZnpmOcG0FhCHbupFN9oWO1/FEUmnDnbDHYGJlu8ECi2KcbJct/kU4Mc8zAwrhOMtWHTq97HLF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ByWi34qp; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ByWi34qp"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-139553dd8acso4699609c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781572578; x=1782177378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8CFOcUq2WiwNGLAYkCTCVZuoe20Gg0qXaoOVAzlB4UI=;
        b=ByWi34qpOc2rr4itZxBW8b52y3JzHmMbapvh2+2l304ZojLYNQZgIYfxxFuWDLsHtY
         O0pBuqAvQ/f62+NORttVyQUjjbKLeWrTmJWfkCT/5aAbPo/8O5abPizs9Ocm1iO7UktE
         hunJCBF7z+4iRFTI+UxlTPp/hVKvgMo7uAP8u1+eSrF0H7WooD6L1Y3lEUZxESOZi7uk
         7BZRwLHCu6F2n6kx9hVwqbqs7VtkhrmLf9ppn9EuPAJMX9CUBj6hMc5c0yYqEhT6ks7i
         6oXP3pllGco8c97Sk53yCQpWpvE33+BuBCSnEoF1OsUWkhBVTf/rx8jumwTYCAG13Jve
         LKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781572578; x=1782177378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CFOcUq2WiwNGLAYkCTCVZuoe20Gg0qXaoOVAzlB4UI=;
        b=Gr0eCcs5FjgdtXj1HTfOac4OnMzfUDYb0NU2pe9hHcIlvXJvcFPr+PT0VEVGX5LFYc
         HxOGnIvXCp8pt2oAm/PgiGPFpzGTS58m1JewYy/dS7uj3Ubo7PhAqP9Z+b5L1FDM9ksm
         EV8qxawx+KekVYoatnCQqGLmg9I/KeUtU8Ugq8uc0cO/yvDb5gnUOuqnJihqOjUbB1yL
         /K+7A2oBS22Qu5rCCLuAoSRM1T11aAnM1H9yE59d7qA1nFY6TJw7FOp/AcvOC1LTje/t
         VznEVq7M5z3vF4CRWfWPp/WBsFM3jA+Oo+Rs3FuBe8QKwMSuFgBxUYt1QAVVZEskmw9g
         bzYg==
X-Forwarded-Encrypted: i=1; AFNElJ/gFMuzrJD/XLetCdn0HyjCkK6rBOhdCvUosxMJc2ZOJuRI8uJcdxcOrkmNPJUp9QfvEuWWpt7hn/jlNO/FiuIX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6GF0Fh03KYyl52qHS48x1jqBYUejLbXjHVp5Sc18DvP0z4BoS
	CPLeXu1wrzgmS0hgbIxQapVhHGgD3z9doq7oBaNABzarlSIe1J1h6wE/XaGoHBcCZdwNx6MHmnh
	8c6T/7xRxHg==
X-Received: from dldoa11.prod.google.com ([2002:a05:701a:ca8b:b0:137:fdb1:854c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:98e:b0:138:236a:c521
 with SMTP id a92af1059eb24-13985e96053mr754303c88.2.1781572577868; Mon, 15
 Jun 2026 18:16:17 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:15:35 -0700
In-Reply-To: <20260616011543.4037138-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615223011.3873955-1-irogers@google.com> <20260616011543.4037138-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616011543.4037138-14-irogers@google.com>
Subject: [PATCH v21 13/21] perf python: Add callchain support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Implement pyrf_callchain_node and pyrf_callchain types for lazy
iteration over callchain frames. Add callchain property to
sample_event.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 221 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1d27df207cc5..01369d8b3e65 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -87,6 +87,8 @@ struct pyrf_event {
 	struct addr_location al;
 	/** @al_resolved: True when machine__resolve been called. */
 	bool al_resolved;
+	/** @callchain: Resolved callchain, eagerly computed if requested. */
+	PyObject *callchain;
 	/** @event: The underlying perf_event that may be in a file or ring buffer. */
 	union perf_event event;
 };
@@ -124,6 +126,7 @@ static void pyrf_event__delete(struct pyrf_event *pevent)
 {
 	if (pevent->al_resolved)
 		addr_location__exit(&pevent->al);
+	Py_XDECREF(pevent->callchain);
 	perf_sample__exit(&pevent->sample);
 	Py_TYPE(pevent)->tp_free((PyObject *)pevent);
 }
@@ -785,6 +788,144 @@ static PyObject *pyrf_sample_event__insn(PyObject *self, PyObject *args __maybe_
 					 pevent->sample.insn_len);
 }
 
+struct pyrf_callchain_node {
+	PyObject_HEAD
+	u64 ip;
+	struct map *map;
+	struct symbol *sym;
+};
+
+static void pyrf_callchain_node__delete(struct pyrf_callchain_node *pnode)
+{
+	map__put(pnode->map);
+	Py_TYPE(pnode)->tp_free((PyObject *)pnode);
+}
+
+static PyObject *pyrf_callchain_node__get_ip(struct pyrf_callchain_node *pnode,
+					     void *closure __maybe_unused)
+{
+	return PyLong_FromUnsignedLongLong(pnode->ip);
+}
+
+static PyObject *pyrf_callchain_node__get_symbol(struct pyrf_callchain_node *pnode,
+						 void *closure __maybe_unused)
+{
+	if (pnode->sym)
+		return PyUnicode_FromString(pnode->sym->name);
+	return PyUnicode_FromString("[unknown]");
+}
+
+static PyObject *pyrf_callchain_node__get_dso(struct pyrf_callchain_node *pnode,
+					      void *closure __maybe_unused)
+{
+	const char *dsoname = "[unknown]";
+
+	if (pnode->map) {
+		struct dso *dso = map__dso(pnode->map);
+
+		if (dso) {
+			if (symbol_conf.show_kernel_path && dso__long_name(dso))
+				dsoname = dso__long_name(dso);
+			else
+				dsoname = dso__name(dso);
+		}
+	}
+	return PyUnicode_FromString(dsoname);
+}
+
+static PyGetSetDef pyrf_callchain_node__getset[] = {
+	{ .name = "ip",     .get = (getter)pyrf_callchain_node__get_ip, },
+	{ .name = "symbol", .get = (getter)pyrf_callchain_node__get_symbol, },
+	{ .name = "dso",    .get = (getter)pyrf_callchain_node__get_dso, },
+	{ .name = NULL, },
+};
+
+static PyTypeObject pyrf_callchain_node__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.callchain_node",
+	.tp_basicsize	= sizeof(struct pyrf_callchain_node),
+	.tp_dealloc	= (destructor)pyrf_callchain_node__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= "perf callchain node object.",
+	.tp_getset	= pyrf_callchain_node__getset,
+};
+
+struct pyrf_callchain_frame {
+	u64 ip;
+	struct map *map;
+	struct symbol *sym;
+};
+
+struct pyrf_callchain {
+	PyObject_HEAD
+	struct pyrf_callchain_frame *frames;
+	u64 nr_frames;
+};
+
+static void pyrf_callchain__delete(struct pyrf_callchain *pchain)
+{
+	if (pchain->frames) {
+		for (u64 i = 0; i < pchain->nr_frames; i++)
+			map__put(pchain->frames[i].map);
+		free(pchain->frames);
+	}
+	Py_TYPE(pchain)->tp_free((PyObject *)pchain);
+}
+
+static Py_ssize_t pyrf_callchain__length(PyObject *obj)
+{
+	struct pyrf_callchain *pchain = (void *)obj;
+
+	return pchain->nr_frames;
+}
+
+static PyObject *pyrf_callchain__item(PyObject *obj, Py_ssize_t i)
+{
+	struct pyrf_callchain *pchain = (void *)obj;
+	struct pyrf_callchain_node *pnode;
+
+	if (i < 0 || i >= (Py_ssize_t)pchain->nr_frames) {
+		PyErr_SetString(PyExc_IndexError, "Index out of range");
+		return NULL;
+	}
+
+	pnode = PyObject_New(struct pyrf_callchain_node, &pyrf_callchain_node__type);
+	if (!pnode)
+		return NULL;
+
+	pnode->ip = pchain->frames[i].ip;
+	pnode->map = map__get(pchain->frames[i].map);
+	pnode->sym = pchain->frames[i].sym;
+
+	return (PyObject *)pnode;
+}
+
+static PySequenceMethods pyrf_callchain__sequence_methods = {
+	.sq_length = pyrf_callchain__length,
+	.sq_item   = pyrf_callchain__item,
+};
+
+static PyTypeObject pyrf_callchain__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.callchain",
+	.tp_basicsize	= sizeof(struct pyrf_callchain),
+	.tp_dealloc	= (destructor)pyrf_callchain__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= "perf callchain object.",
+	.tp_as_sequence	= &pyrf_callchain__sequence_methods,
+};
+
+static PyObject *pyrf_sample_event__get_callchain(PyObject *self, void *closure __maybe_unused)
+{
+	struct pyrf_event *pevent = (void *)self;
+
+	if (!pevent->callchain)
+		Py_RETURN_NONE;
+
+	Py_INCREF(pevent->callchain);
+	return pevent->callchain;
+}
+
 static PyObject*
 pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
 {
@@ -799,6 +940,12 @@ pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
 }
 
 static PyGetSetDef pyrf_sample_event__getset[] = {
+	{
+		.name = "callchain",
+		.get = pyrf_sample_event__get_callchain,
+		.set = NULL,
+		.doc = "event callchain.",
+	},
 	{
 		.name = "raw_buf",
 		.get = (getter)pyrf_sample_event__get_raw_buf,
@@ -968,6 +1115,12 @@ static int pyrf_event__setup_types(void)
 	err = PyType_Ready(&pyrf_context_switch_event__type);
 	if (err < 0)
 		goto out;
+	err = PyType_Ready(&pyrf_callchain_node__type);
+	if (err < 0)
+		goto out;
+	err = PyType_Ready(&pyrf_callchain__type);
+	if (err < 0)
+		goto out;
 out:
 	return err;
 }
@@ -987,13 +1140,19 @@ static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_SWITCH_CPU_WIDE]  = &pyrf_context_switch_event__type,
 };
 
-static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *evsel)
+static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *evsel,
+				 struct perf_session *session,
+				 struct machine *machine)
 {
 	struct pyrf_event *pevent;
+	struct perf_sample *sample;
 	int err;
 	u32 min_size;
 	bool needs_swap;
 
+	if (!machine)
+		machine = session ? &session->machines.host : NULL;
+
 	if (event->header.type >= ARRAY_SIZE(pyrf_event__type) ||
 	    pyrf_event__type[event->header.type] == NULL) {
 		return PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
@@ -1025,6 +1184,7 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 		pevent->event.mmap2.filename[sizeof(pevent->event.mmap2.filename) - 1] = '\0';
 
 	perf_sample__init(&pevent->sample, /*all=*/true);
+	pevent->callchain = NULL;
 	pevent->al_resolved = false;
 	addr_location__init(&pevent->al);
 
@@ -1042,6 +1202,50 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 		return PyErr_Format(PyExc_OSError,
 				    "perf: can't parse sample, err=%d", err);
 	}
+	sample = &pevent->sample;
+	if (machine && sample->callchain) {
+		struct addr_location al;
+		struct callchain_cursor *cursor;
+		u64 i;
+		struct pyrf_callchain *pchain;
+
+		addr_location__init(&al);
+		if (machine__resolve(machine, &al, sample) >= 0) {
+			cursor = get_tls_callchain_cursor();
+			if (thread__resolve_callchain(al.thread, cursor, sample,
+						      NULL, NULL, PERF_MAX_STACK_DEPTH) == 0) {
+				callchain_cursor_commit(cursor);
+
+				pchain = PyObject_New(struct pyrf_callchain, &pyrf_callchain__type);
+				if (!pchain) {
+					addr_location__exit(&al);
+					Py_DECREF(pevent);
+					return NULL;
+				}
+				pchain->nr_frames = cursor->nr;
+				pchain->frames = calloc(pchain->nr_frames,
+							sizeof(*pchain->frames));
+				if (!pchain->frames) {
+					Py_DECREF(pchain);
+					addr_location__exit(&al);
+					Py_DECREF(pevent);
+					return PyErr_NoMemory();
+				}
+				struct callchain_cursor_node *node;
+
+				for (i = 0; i < pchain->nr_frames; i++) {
+					node = callchain_cursor_current(cursor);
+					pchain->frames[i].ip = node->ip;
+					pchain->frames[i].map =
+						map__get(node->ms.map);
+					pchain->frames[i].sym = node->ms.sym;
+					callchain_cursor_advance(cursor);
+				}
+				pevent->callchain = (PyObject *)pchain;
+			}
+			addr_location__exit(&al);
+		}
+	}
 	return (PyObject *)pevent;
 }
 
@@ -2417,7 +2621,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		perf_mmap__consume(&md->core);
 		Py_RETURN_NONE;
 	}
-	pyevent = pyrf_event__new(event, evsel);
+	pyevent = pyrf_event__new(event, evsel, evlist__session(evlist), /*machine=*/NULL);
 	perf_mmap__consume(&md->core);
 	if (pyevent == NULL)
 		return PyErr_Occurred() ? NULL : PyErr_NoMemory();
@@ -3185,10 +3389,10 @@ struct pyrf_session {
 static int pyrf_session_tool__sample(const struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample,
-				     struct machine *machine __maybe_unused)
+				     struct machine *machine)
 {
 	struct pyrf_session *psession = container_of(tool, struct pyrf_session, tool);
-	PyObject *pyevent = pyrf_event__new(event, sample->evsel);
+	PyObject *pyevent = pyrf_event__new(event, sample->evsel, psession->session, machine);
 	PyObject *ret;
 
 	if (pyevent == NULL)
@@ -3296,6 +3500,9 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	}
 	psession->session = session;
 
+	symbol_conf.use_callchain = true;
+	symbol_conf.show_kernel_path = true;
+	symbol_conf.inline_name = false;
 	if (symbol__init(perf_session__env(session)) < 0) {
 		PyErr_SetString(PyExc_OSError, "perf: symbol__init failed");
 		goto err_out;
@@ -3475,6 +3682,12 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_thread__type);
 	PyModule_AddObject(module, "thread", (PyObject *)&pyrf_thread__type);
 
+	Py_INCREF(&pyrf_callchain__type);
+	PyModule_AddObject(module, "callchain", (PyObject *)&pyrf_callchain__type);
+
+	Py_INCREF(&pyrf_callchain_node__type);
+	PyModule_AddObject(module, "callchain_node", (PyObject *)&pyrf_callchain_node__type);
+
 	Py_INCREF(&pyrf_mmap_event__type);
 	PyModule_AddObject(module, "mmap_event", (PyObject *)&pyrf_mmap_event__type);
 
-- 
2.54.0.1136.gdb2ca164c4-goog

