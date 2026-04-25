Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B2E399352
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157453; cv=none; b=ViA5jLiGqrHrQ9886ag6Q/mlVeg2ts8eMY7jq+at51G9itJ5Yarq88lYP9i8u5oWOMbRE0ucbWN1x7M9Xolc2jFsWthraYoJyjlemNKRJHzaEp9KNMaLVZj2LStgAfYT333msl6alzu5ONAcuVjj25uge/g7roobFSNj0jWIgN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157453; c=relaxed/simple;
	bh=KN5i1jN6Kb78peV6jKL5TpWLveWGVlk5wDsutMsOQkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LnEE6RyEdY3HTWSMiWUhCkjHR+HnFFBvLFfZXaN18ul9oWkdME0i70A97DbHQgz1xSy/6gOZZ7nEdaEXC+xN0mnapzoTetfMhgEbXgFHCDwlsVfhgqFZKBvssjVoMapRIxcPwPPqEOdR+CB2o/C54YvC0EjQrkOEXFpNQFx/MQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jifbgMBC; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jifbgMBC"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so10459355eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157450; x=1777762250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=teyYQp0E3EyOIZgpUXSUO0oKReWVKi9UUmdHMeA+/YA=;
        b=jifbgMBCMbCJj05hy95ajIcIjO/zDKBmBSIQpbG/DC4kfixtOAVUHShlMb1rIm6Rk4
         YVaY+Qyb3erf3anRiWpJwWURXZZNP8pteWjQqAMfGW989vi7VetpgpM5ffU4cF0CEB9n
         QJ94zOir/wGDzMOZRg5Zs4Sb9l4dB3qZxuAw95HoaIZmCfzkpMF6eK1VvB1mYp4yTvTf
         5Cg2+JSuwt3HSGiOJzBJrY3BsCBkFgDX8NjcqVkWg235WMHQWnuRxL3CosxhCQeFvSll
         oumpwDsIIikRMmrYE/mg+9TSjZO9byel9WwBHEmLwjew3joJpXO2jxmWghhCjSKMqgWV
         W/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157450; x=1777762250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=teyYQp0E3EyOIZgpUXSUO0oKReWVKi9UUmdHMeA+/YA=;
        b=e9HrfNAPW5X52fRLJfyBPN8wD2llNL6drf1u5OkYrYRan7GgRbtleSdEMtDLXYnBeF
         yPHi80LFq9d6XgC9RzjMa0IJwEiJgF8zHgOaQWXLzvGcfqK0jmcaoM/YXidn6O7I5C7S
         AUBLMc1v1bpT92t/oQthextDoK9W+rJeEqYeQXcFGRDJ8AUOexi6GXnVzaSGvUPpNFT9
         aGy6l336zMU27SAytNwUOAIpAU/ACRSzY/g+iAZTLBObFvCizWm8En/DK5agK7RZXjnL
         U7Y5gQlXcsSlAASuHa5BX9/DzIfUmBbZh8DFeYXKZWVnwDXRjVAftyEXmkOEl6ogtpfP
         YExA==
X-Forwarded-Encrypted: i=1; AFNElJ8TYDG9c7GSQD8bxLeazu8cpbVIdbm1BOFV+MwkJFkyyoEbPTBhQDFV8rSyinoUaIc9e4h3gUfujiTChbsBSpTq@vger.kernel.org
X-Gm-Message-State: AOJu0YyHs1yT/oYT/K5qmHAIZD5KtnbA5cBKCam4jjdKn9+9tiwrSwq0
	P3tMcMPxnMvtlKgzLv1/uji9CZSZx8OVpoChT9byOizsqei78A5Bcm02vwn/oCvbCBLQI0xe2oV
	kuB6oxUJFkg==
X-Received: from dlad28.prod.google.com ([2002:a05:701b:221c:b0:12a:7f44:d2e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6981:b0:12c:856:ddcc
 with SMTP id a92af1059eb24-12c73fa3c9amr19854524c88.27.1777157450294; Sat, 25
 Apr 2026 15:50:50 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:10 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-19-irogers@google.com>
Subject: [PATCH v7 18/59] perf python: Add callchain support
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement pyrf_callchain_node and pyrf_callchain types for lazy
iteration over callchain frames. Add callchain property to
sample_event.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Eager Callchain Resolution: Moved the callchain resolution from
   deferred iteration to eager processing in
   pyrf_session_tool__sample() .  This avoids risks of reading from
   unmapped memory or following dangling pointers to closed sessions.

2. Cached Callchain: Added a callchain field to struct pyrf_event to
   store the resolved object.

3. Simplified Access: pyrf_sample_event__get_callchain() now just
   returns the cached object if available.

4. Avoided Double Free: Handled lazy cleanups properly.

v6:
- Moved callchain resolution from `session_tool__sample` to
  `pyrf_event__new`.
---
 tools/perf/util/python.c | 241 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 240 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 824cf58645e0..2953c4c8e142 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -66,6 +66,8 @@ struct pyrf_event {
 	struct addr_location al;
 	/** @al_resolved: True when machine__resolve been called. */
 	bool al_resolved;
+	/** @callchain: Resolved callchain, eagerly computed if requested. */
+	PyObject *callchain;
 	/** @event: The underlying perf_event that may be in a file or ring buffer. */
 	union perf_event event;
 };
@@ -103,6 +105,7 @@ static void pyrf_event__delete(struct pyrf_event *pevent)
 {
 	if (pevent->al_resolved)
 		addr_location__exit(&pevent->al);
+	Py_XDECREF(pevent->callchain);
 	perf_sample__exit(&pevent->sample);
 	Py_TYPE(pevent)->tp_free((PyObject *)pevent);
 }
@@ -621,6 +624,181 @@ static PyObject *pyrf_sample_event__insn(PyObject *self, PyObject *args __maybe_
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
+	Py_TYPE(pnode)->tp_free((PyObject*)pnode);
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
+	struct pyrf_event *pevent;
+	struct pyrf_callchain_frame *frames;
+	u64 nr_frames;
+	u64 pos;
+	bool resolved;
+};
+
+static void pyrf_callchain__delete(struct pyrf_callchain *pchain)
+{
+	Py_XDECREF(pchain->pevent);
+	if (pchain->frames) {
+		for (u64 i = 0; i < pchain->nr_frames; i++)
+			map__put(pchain->frames[i].map);
+		free(pchain->frames);
+	}
+	Py_TYPE(pchain)->tp_free((PyObject*)pchain);
+}
+
+static PyObject *pyrf_callchain__next(struct pyrf_callchain *pchain)
+{
+	struct pyrf_callchain_node *pnode;
+
+	if (!pchain->resolved) {
+		struct evsel *evsel = pchain->pevent->sample.evsel;
+		struct evlist *evlist = evsel->evlist;
+		struct perf_session *session = evlist ? evlist__session(evlist) : NULL;
+		struct addr_location al;
+		struct callchain_cursor *cursor;
+		struct callchain_cursor_node *node;
+		u64 i;
+
+		if (!session || !pchain->pevent->sample.callchain)
+			return NULL;
+
+		addr_location__init(&al);
+		if (machine__resolve(&session->machines.host, &al, &pchain->pevent->sample) < 0) {
+			addr_location__exit(&al);
+			return NULL;
+		}
+
+		cursor = get_tls_callchain_cursor();
+		if (thread__resolve_callchain(al.thread, cursor, evsel,
+					      &pchain->pevent->sample, NULL, NULL,
+					      PERF_MAX_STACK_DEPTH) != 0) {
+			addr_location__exit(&al);
+			return NULL;
+		}
+		callchain_cursor_commit(cursor);
+
+		pchain->nr_frames = cursor->nr;
+		if (pchain->nr_frames > 0) {
+			pchain->frames = calloc(pchain->nr_frames, sizeof(*pchain->frames));
+			if (!pchain->frames) {
+				addr_location__exit(&al);
+				return PyErr_NoMemory();
+			}
+
+			for (i = 0; i < pchain->nr_frames; i++) {
+				node = callchain_cursor_current(cursor);
+				pchain->frames[i].ip = node->ip;
+				pchain->frames[i].map = map__get(node->ms.map);
+				pchain->frames[i].sym = node->ms.sym;
+				callchain_cursor_advance(cursor);
+			}
+		}
+		pchain->resolved = true;
+		addr_location__exit(&al);
+	}
+
+	if (pchain->pos >= pchain->nr_frames)
+		return NULL;
+
+	pnode = PyObject_New(struct pyrf_callchain_node, &pyrf_callchain_node__type);
+	if (!pnode)
+		return NULL;
+
+	pnode->ip = pchain->frames[pchain->pos].ip;
+	pnode->map = map__get(pchain->frames[pchain->pos].map);
+	pnode->sym = pchain->frames[pchain->pos].sym;
+
+	pchain->pos++;
+	return (PyObject *)pnode;
+}
+
+static PyTypeObject pyrf_callchain__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.callchain",
+	.tp_basicsize	= sizeof(struct pyrf_callchain),
+	.tp_dealloc	= (destructor)pyrf_callchain__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= "perf callchain object.",
+	.tp_iter	= PyObject_SelfIter,
+	.tp_iternext	= (iternextfunc)pyrf_callchain__next,
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
@@ -635,6 +813,12 @@ pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
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
@@ -803,6 +987,12 @@ static int pyrf_event__setup_types(void)
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
@@ -822,10 +1012,12 @@ static PyTypeObject *pyrf_event__type[] = {
 };
 
 static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *evsel,
-				 struct perf_session *session __maybe_unused)
+				 struct perf_session *session)
 {
 	struct pyrf_event *pevent;
 	PyTypeObject *ptype;
+	struct perf_sample *sample;
+	struct machine *machine = session ? &session->machines.host : NULL;
 	size_t size;
 	int err;
 	size_t min_size = sizeof(struct perf_event_header);
@@ -883,6 +1075,7 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	PyObject_Init((PyObject *)pevent, ptype);
 	memcpy(&pevent->event, event, event->header.size);
 	perf_sample__init(&pevent->sample, /*all=*/true);
+	pevent->callchain = NULL;
 	pevent->al_resolved = false;
 	addr_location__init(&pevent->al);
 
@@ -896,6 +1089,49 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
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
+			if (thread__resolve_callchain(al.thread, cursor, evsel, sample,
+						      NULL, NULL, PERF_MAX_STACK_DEPTH) == 0) {
+				callchain_cursor_commit(cursor);
+
+				pchain = PyObject_New(struct pyrf_callchain, &pyrf_callchain__type);
+				if (pchain) {
+					pchain->pevent = pevent;
+					Py_INCREF(pevent);
+					pchain->nr_frames = cursor->nr;
+					pchain->pos = 0;
+					pchain->resolved = true;
+					pchain->frames = calloc(pchain->nr_frames,
+								sizeof(*pchain->frames));
+					if (pchain->frames) {
+						struct callchain_cursor_node *node;
+
+						for (i = 0; i < pchain->nr_frames; i++) {
+							node = callchain_cursor_current(cursor);
+							pchain->frames[i].ip = node->ip;
+							pchain->frames[i].map =
+								map__get(node->ms.map);
+							pchain->frames[i].sym = node->ms.sym;
+							callchain_cursor_advance(cursor);
+						}
+						pevent->callchain = (PyObject *)pchain;
+					} else {
+						Py_DECREF(pchain);
+					}
+				}
+			}
+			addr_location__exit(&al);
+		}
+	}
 	return (PyObject *)pevent;
 }
 
@@ -2959,6 +3195,9 @@ static int pyrf_session__init(struct pyrf_session *psession, PyObject *args, PyO
 		return -1;
 	}
 
+	symbol_conf.use_callchain = true;
+	symbol_conf.show_kernel_path = true;
+	symbol_conf.inline_name = false;
 	if (symbol__init(perf_session__env(psession->session)) < 0) {
 		perf_session__delete(psession->session);
 		psession->session = NULL;
-- 
2.54.0.545.g6539524ca2-goog

