Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8798C3769E0
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487522; cv=none; b=Fs/s73Jq1/56FBDUjg/g9OpcT5TtvH2ZlaZfhzTL6M4zPubMmaFYcauJdxjwd9hUcXSDPxKd1UzN76p0+2QanDSTk7dA5PWqxtJz1yWnJGWT+TP6Y3gq2uoq4TDOK9LBTioTXJvHB+w0NmFTuoSHH+c2FwlglwAzn2UppaCW414=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487522; c=relaxed/simple;
	bh=UFH+SCufTNAWZPKLpGYQoKrPFz3DXmqxCwE9KFTLIQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aqEo1xnqqQfjnhfD26pdcihhjpEoy1yHT4z/zUcVlKgrL4kbFOx2zpNm3DsCMFy9doB6vLJb3QfTPwJi3SOW7QMLGI7a/QVMIKOFPP7cdCoWfG/gzYMjz1pazgBDnTs4sP6g800F4oy8Icas9sUCiru+YbPFLoCTNZ+b0ZAqzzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRahgo0y; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRahgo0y"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132d631edaaso45960983c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487519; x=1780092319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1oiPPeerxAd2KDhCMXKVrpSVXvS8guW5A+bxiFsiP8I=;
        b=rRahgo0yJzdkyizaMw7zP9wXFvcDVR9ckeVq1hwhbNbA+hezw68e7R0inhneeych90
         BUoCmNwrvFTZ67CPvItAw25freE66kU0DtiWuWcZ/N/R9hzJTRTkd+phN5/+Zp0zYl/l
         3XFRVLEUHqZiR2xW8Ycaa6YE9M+XeT4frrH9t/+5CpZTUEiLgMB55lKW+hgpijDucGie
         edMaUI+Tja/YBjLaaHLrHiBHenfofC9hB3JkW2UqVG54CXMV9TXrJ+l/bW+KKoWgBFSi
         INx8eDUqUdxa6rweTa0GnX0dd6hwVMnwgJgU+d6Aa7hzz5G9NucsAsDKVAemZTX2IjEU
         MBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487519; x=1780092319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oiPPeerxAd2KDhCMXKVrpSVXvS8guW5A+bxiFsiP8I=;
        b=IU7oEX1XkIdmozDwpIezfZFXIPllc+om8qp0GWiMImBQG8ue16/fpiB0RRgmg5n56G
         QJkIYKgFD9bX+sB+91DY5mjVUsYuGv17E7sQNnsuLAqRy+NZMESt152Ui597KVW1Q1uq
         2Lyx8B+FXiUPZ1xhYcEWocDyTacSDIKfed7dzbSPbc3qhaGuJimYtX7kH/8qE18tlw3p
         Vt7O6cIo7Tf01sMnx3VkXxvLtMH9t0yUkcoVCn9dmU/9Yw6Wew4ceTU/Kx63smoM2lzK
         3rwfQjt1xcuUBvSXNvXdEBD5oFdMou36fjOV9AB1LtY6kMEFJ3s4kOQS2EYxLZ4C2JYS
         6DPg==
X-Forwarded-Encrypted: i=1; AFNElJ9q5Pf4Q8dT7Wpf+TkGKoL2KDyXoxI7PcNsyGEnQb7uNhK0vSjvsivE0Bl7sSaexSsEu95y5Bb+t0wjXim/LK2H@vger.kernel.org
X-Gm-Message-State: AOJu0YwKg50BLzzgvbOip/8XimQdC9zV+CsPaLV99t3miHdbGfbsMMhQ
	zPde+9q9xmDe04mAEZtHdPdkZzJze6FrhJOms4qAo0ruiTVmw6FgSU/Fn6Z575SDF8vlM/ZMCtm
	ANio50vveIA==
X-Received: from dlb3.prod.google.com ([2002:a05:7022:603:b0:135:e6d6:d14d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61b:b0:12d:b205:c737
 with SMTP id a92af1059eb24-1365f91bdb4mr2206422c88.17.1779487519099; Fri, 22
 May 2026 15:05:19 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:28 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-18-irogers@google.com>
Subject: [PATCH v9 17/23] perf python: Add callchain support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
index daedd67f12d5..de7a51389572 100644
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
@@ -669,6 +672,181 @@ static PyObject *pyrf_sample_event__insn(PyObject *self, PyObject *args __maybe_
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
+		if (thread__resolve_callchain(al.thread, cursor,
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
@@ -683,6 +861,12 @@ pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
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
@@ -852,6 +1036,12 @@ static int pyrf_event__setup_types(void)
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
@@ -872,9 +1062,11 @@ static PyTypeObject *pyrf_event__type[] = {
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
@@ -1033,6 +1225,7 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
 	}
 
 	perf_sample__init(&pevent->sample, /*all=*/true);
+	pevent->callchain = NULL;
 	pevent->al_resolved = false;
 	addr_location__init(&pevent->al);
 
@@ -1046,6 +1239,49 @@ static PyObject *pyrf_event__new(const union perf_event *event, struct evsel *ev
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
 
@@ -3145,6 +3381,9 @@ static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyObject
 	}
 	psession->session = session;
 
+	symbol_conf.use_callchain = true;
+	symbol_conf.show_kernel_path = true;
+	symbol_conf.inline_name = false;
 	if (symbol__init(perf_session__env(session)) < 0) {
 		PyErr_SetString(PyExc_OSError, "perf: symbol__init failed");
 		goto err_out;
-- 
2.54.0.794.g4f17f83d09-goog

