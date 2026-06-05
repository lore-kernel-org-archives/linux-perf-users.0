Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4F2481FCF
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645260; cv=none; b=fHR/D/uzN6KCev34T0mUbd8qj8qTc44I+PrbRb2Wke9NLkyco31gigfVSdlHttKrM78lffCbhBH6gPU5feUycJMNLI6dqiixvI+jRdZrNKBjYDwAW3sNq6fNr4YDsl9Kc2CniqBWC80Nd18bUCpGEyN4XlJQjngzGJ4n8KIJXX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645260; c=relaxed/simple;
	bh=yKZ5ExdCokw8Mkq4o1GD1YJWfZIWnz4qg/9SxqzxBZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hf1Na2qlRs+wSaPXaJomTKrFbNjIpIHFDhMjA8KgKZxXYdkh7Hgn/Kucn0TI5utvNaULRa04t34KplUN5etFfweyCKTrZLdIzFX+EQ8WwJweC6lYl+v74XcamSd2APwPLVEo11SGb39zAbgxhcaqyQmwyKeNWah+O/46+9YJ5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZVgiaktC; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZVgiaktC"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304ec73b015so3711202eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780645258; x=1781250058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYT3jk6hVRxvWq7waNkgukgyg/ooT4nvyAiUAEF55BI=;
        b=ZVgiaktCOXke2f9MEz2/JEv79/AQGzN/jLMa+3cgrn0yp6bxrPM1JCo8qbNs3LjizJ
         SqsAZOPXCwTpgRt5JgVThnTC+YZjW+LMCCip0eJI0g/c87YJ/hU2Iy/dDQoyGKlGdUvz
         PRchrrWt/ujNksOi00cVfujPrCVT2GdQGF19qLxH40VEqLirBbEZuUz4LsjnS2c5Fvgo
         FNyrEJjSk5MSIg73FSkbHJdlvM3QGhGLFYM4mSyQg33MNxwYaz4y3NOtpvNoseLpnpz0
         d9g4L8xoSATkQTncD6JnaC322uMNtASC6SNMnl84PeuBVAM8xoSK10W/HpPYE4ajUA2B
         Lxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645258; x=1781250058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYT3jk6hVRxvWq7waNkgukgyg/ooT4nvyAiUAEF55BI=;
        b=C/47PS8mbyg+MY71mvbFtefIG/jGq+WHbt3GzkbitqLe+1IGKwtQ/F6KZcWfEdV7g1
         509r1NsYxqxLhobTrYfGBv4Oo51kmDww5EzS4+PHUc7jfBiY3pNqx0tj8mXtAU6vXoHB
         KvcrNw7wZO2JVjE5glxgdKtQmMqN8AoRgxV7yIBqwxsfKOE8vl4iGYyqZSd0liY1knmO
         DmUTJB54IAiMQ27ZCEIYeHPLytcZoFk4RyTJHGL9Ao/BlhowRdfPO9bEqaCcGiUty8Od
         1VnYpy/GskKzSB2uwyXbbtAjNFL0Ooa/Q9nPGnZph4IW9tx/2oF+OzRfhtRJLYme2/by
         qhDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZsQzjrHV8aG/SwyacUX9alGq+VUDVHmQES16LSraqx+3uz9nfy50sajxoGAE9o3nJwNuirlElXctmm2+mpGEp@vger.kernel.org
X-Gm-Message-State: AOJu0YyljtG5Jiqs4pj+GsB0lOkkhPIaZO/8iNX6116vZxkRajvVi0hl
	AIL5TXNck6ryndrvjuYJByoBDUJuqaOe8RjdK1jKkDF4DHtWI2EaICp/W4o4qOvdlpRnj/oWkcp
	b1p6IeLp9dQ==
X-Received: from dyvt1.prod.google.com ([2002:a05:7301:d801:b0:304:d771:74aa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1e94:b0:307:26a3:75d8
 with SMTP id 5a478bee46e88-3077b270c7emr1236555eec.1.1780645257449; Fri, 05
 Jun 2026 00:40:57 -0700 (PDT)
Date: Fri,  5 Jun 2026 00:39:57 -0700
In-Reply-To: <20260605074003.1730715-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522220435.2378363-1-irogers@google.com> <20260605074003.1730715-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605074003.1730715-14-irogers@google.com>
Subject: [PATCH v10 13/19] perf python: Add callchain support
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
 tools/perf/util/python.c | 203 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 352331d73c58..fde22dc551a7 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -85,6 +85,8 @@ struct pyrf_event {
 	struct addr_location al;
 	/** @al_resolved: True when machine__resolve been called. */
 	bool al_resolved;
+	/** @callchain: Resolved callchain, eagerly computed if requested. */
+	PyObject *callchain;
 	/** @event: The underlying perf_event that may be in a file or ring buffer. */
 	union perf_event event;
 };
@@ -122,6 +124,7 @@ static void pyrf_event__delete(struct pyrf_event *pevent)
 {
 	if (pevent->al_resolved)
 		addr_location__exit(&pevent->al);
+	Py_XDECREF(pevent->callchain);
 	perf_sample__exit(&pevent->sample);
 	Py_TYPE(pevent)->tp_free((PyObject *)pevent);
 }
@@ -782,6 +785,142 @@ static PyObject *pyrf_sample_event__insn(PyObject *self, PyObject *args __maybe_
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
@@ -796,6 +935,12 @@ pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
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
@@ -965,6 +1110,12 @@ static int pyrf_event__setup_types(void)
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
@@ -985,9 +1136,11 @@ static PyTypeObject *pyrf_event__type[] = {
 };
 
 static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *evsel,
-				 struct perf_session *session __maybe_unused)
+				 struct perf_session *session)
 {
 	struct pyrf_event *pevent;
+	struct perf_sample *sample;
+	struct machine *machine = session ? &session->machines.host : NULL;
 	size_t size;
 	int err;
 	size_t min_size = sizeof(struct perf_event_header);
@@ -1146,6 +1299,7 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	}
 
 	perf_sample__init(&pevent->sample, /*all=*/true);
+	pevent->callchain = NULL;
 	pevent->al_resolved = false;
 	addr_location__init(&pevent->al);
 
@@ -1159,6 +1313,50 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
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
 
@@ -3394,6 +3592,9 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	}
 	psession->session = session;
 
+	symbol_conf.use_callchain = true;
+	symbol_conf.show_kernel_path = true;
+	symbol_conf.inline_name = false;
 	if (symbol__init(perf_session__env(session)) < 0) {
 		PyErr_SetString(PyExc_OSError, "perf: symbol__init failed");
 		goto err_out;
-- 
2.54.0.1032.g2f8565e1d1-goog

