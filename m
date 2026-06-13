Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638283CAE95
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781328480; cv=none; b=WV4yaIJILbdw4mFwsk5UdMfU13bbOpdnCtVZTP/rFJJy3p1KIQa7b+9GyKwJnev53RXUwEPxMLcZmRsecIoKfZbK/3RUPkcGB3lgf8DwjGMNTjlBl0Kl8ixUHOx3F7SnFC4aILbYGWJ6VY8A55BTgkLhFmRlN8gkK6dIlX2rYvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781328480; c=relaxed/simple;
	bh=v2B2xzJORvA4uynMotkOJ09teV0xwIhoq/t6XGZ3TCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kKP8nlx/nmrcojV/akj9sQeB7RW7EeM8E7++HFjs6jokI7oHZHWpc3Va/B+6g616bxr3IyFcgGXMkROdWkXmISZOzw90FR8sBzmRfoSrRGzPdXKSw3dwJFrxhQlulOZKGFpR+VMQGspDJRacE6zPJtn6HMALkNM+2t1Gqn76lEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eeKV77Pi; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eeKV77Pi"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304d0d0b28eso5163667eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781328473; x=1781933273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZLZ2ula6KruRrE7zJFPlJWfB0sziy1YWINkWo3krEg=;
        b=eeKV77PiIB8k9ILjZe6rvw2mfdtnySKAEZ3cLi2MMN8agYQQ4fOIjFcUhT5gX3xXUT
         afi4eyZzEjWWHsJaPuTcl1kUMc9+nSMbk9iwVvn9Jnda7VemMJytDyZW3XdsTkoREnSe
         cXaztSLvy/xi3w8h3/JklRStIXIY8joJrXoKH8TulWBlZtS9UJ6FZwdLr1c2QQw6aaQr
         Vi5Jyg4OJuFZDfBzdam+FPxIqiEUHhEzughRdFc6XqDHdV4eu5k4kg6wqGtqPKF3CliY
         pNgirUCA9FcilQo0kOMNU4XrAYL/aDCvJxb6e28yw9MbCoqLysrC3YxA8SibWMrDHz6U
         Qu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781328473; x=1781933273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZLZ2ula6KruRrE7zJFPlJWfB0sziy1YWINkWo3krEg=;
        b=TuMTv6Kw5g/YtcoYA6QZC3S8CDSpLJ9gS/32/V0HnsG1NqOvz/aiPshmhQMYZQtbap
         K5ljbEyv/DWpKmpkLK5l4fhwWBkNvN6k6Ta3021btdtnqvLxCt+w6mGIeVRtir7ylai1
         Q+BiZSEyoyOIvKsCM2pPwhdxEluoPubZX2CuhwsCV13+OX+UP0SGcur0AoTGa8zvN3Sw
         BMEbWixaKZdmzXUBJ/F5nU6FEdF1ITndmt+P0iCu+LwNlxll9BC09nhZEdATg91AUdh4
         EyyzCRR1udQwKU4A8MkjO7GgwzbYaPO9eB9V4nlT3UII3yxJL9NYDo3VRvmFQ40qSON8
         rr+w==
X-Forwarded-Encrypted: i=1; AFNElJ+D1cLFoZu7Qgua1gTHgyDtjn2KnlhL0JhqiJDGYujbTapnsqfG8XG6EK9drhHyvACmmptqJ5OrbZxM/7PbWIBI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5dw5mSlOz1PAZsq7XZY1JnfM2QT1kt6f5J/iXNH2M7bSXkzNZ
	Rwl1dat0pEmvSxLVz8qe+Touq0VIEiatSlsDIrbef+gUvcLSTsumUkK6d973lfa/DnArpS04VrT
	AvALpz1ysog==
X-Received: from dyay13.prod.google.com ([2002:a05:693c:62cd:b0:307:ff57:53b0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:caa:b0:307:140f:d511
 with SMTP id 5a478bee46e88-30941e49533mr1327623eec.33.1781328473224; Fri, 12
 Jun 2026 22:27:53 -0700 (PDT)
Date: Fri, 12 Jun 2026 22:27:14 -0700
In-Reply-To: <20260613052722.1424093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612221211.1221305-1-irogers@google.com> <20260613052722.1424093-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613052722.1424093-14-irogers@google.com>
Subject: [PATCH v16 13/20] perf python: Add callchain support
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
v12:
 - Added an optional `struct machine *` argument to `pyrf_event__new` defaulting to the host machine if NULL, avoiding regressions for future phases.

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
 tools/perf/util/python.c | 215 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 211 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b3dca4b63844..c7f4af39c418 100644
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
@@ -987,12 +1140,18 @@ static PyTypeObject *pyrf_event__type[] = {
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
 
+	if (!machine)
+		machine = session ? &session->machines.host : NULL;
+
 	if (event->header.type >= ARRAY_SIZE(pyrf_event__type) ||
 	    pyrf_event__type[event->header.type] == NULL) {
 		return PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
@@ -1024,6 +1183,7 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 		pevent->event.mmap2.filename[sizeof(pevent->event.mmap2.filename) - 1] = '\0';
 
 	perf_sample__init(&pevent->sample, /*all=*/true);
+	pevent->callchain = NULL;
 	pevent->al_resolved = false;
 	addr_location__init(&pevent->al);
 
@@ -1037,6 +1197,50 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
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
 
@@ -2412,7 +2616,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		perf_mmap__consume(&md->core);
 		Py_RETURN_NONE;
 	}
-	pyevent = pyrf_event__new(event, evsel);
+	pyevent = pyrf_event__new(event, evsel, evlist__session(evlist), /*machine=*/NULL);
 	perf_mmap__consume(&md->core);
 	if (pyevent == NULL)
 		return PyErr_Occurred() ? NULL : PyErr_NoMemory();
@@ -3175,10 +3379,10 @@ struct pyrf_session {
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
@@ -3286,6 +3490,9 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	}
 	psession->session = session;
 
+	symbol_conf.use_callchain = true;
+	symbol_conf.show_kernel_path = true;
+	symbol_conf.inline_name = false;
 	if (symbol__init(perf_session__env(session)) < 0) {
 		PyErr_SetString(PyExc_OSError, "perf: symbol__init failed");
 		goto err_out;
-- 
2.54.0.1136.gdb2ca164c4-goog

