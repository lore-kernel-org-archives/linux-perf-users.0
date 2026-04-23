Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754539A04F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960649; cv=none; b=P73IoZU0XA+skKR+apY4y+O09C7QE28gFqkeFvtxCD1kMsF/keCR+R5daTVsqVN4Etvcaj6NDPnZBVTywBNuASf8n1nYSelPSsBoOdRDaAkg5ax+Aot07okBD86dggZfIGMppKT2ZsqXj9GB6opO/BIGN8ewN7YYDOkTZ2IuHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960649; c=relaxed/simple;
	bh=Q9A6Fy/T5nITzrEIcbVTJsrcRKhWo07ZTbbHva8YMA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oClrG+5SfuwzrgRT6PeHvib6SOrw6lqS7MsW2WDiQQl6hkhxmqwcIERRwAWSQwU+qo63D/MDpnUcDun4ztJBaR0CzvGkTgWINwN3AfU9uVhb4seyuioHK8Kkd/VJABjHaqNVVCfm1Gci3HivjblMk5XUAOaSCJXOm7wXdb3jMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8ocHKbb; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8ocHKbb"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso8994110eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960644; x=1777565444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VZwGVsQ9oOkj3162dFlhg6DsvT8t476do7f7ssi8lO8=;
        b=W8ocHKbbEXA6Rt9W4Jpjr8elCemLLEDU9ghJjge1tg/025D1HfLpjNRu8wIUybaxlE
         XrVJ9CyDS8wTfglCzp5kaDFjo2/S+SF9a+pgKeqcfNpF+wnIVXmUsykXHkBSaWxmHrUF
         373YXypY40Q7QUjj8Ju4+JHVUuc5HEl/e4slSFj/CtB6fyL2BBchGYMVohNVS5l8lzws
         Mxgj+sfqiQTzv91ZtvaoXfzVd8HtZAhmao7h0WavTrxYV2rO1XY2p+k/uzFjsqN+7HUt
         QrxdGk+DpDUXE8JHj33ufyxDgtAQTBYjCdHNtkfO8pcnbB0IAkXPVT6GLs0/D42hhGCW
         WRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960644; x=1777565444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZwGVsQ9oOkj3162dFlhg6DsvT8t476do7f7ssi8lO8=;
        b=eeRLFp338leUXQ1zX/2gi2wcNVcQ6wdgKz7R9sdHiw3QOtGZ9qic0EBhiyO0QU1ytD
         6BPwpHIcn5rCMFoL2vz1mcfZGUdQ/fpjKlk0kMjU7JFx/y9YGCciUIdpU3bi4fHaVMvw
         wum7UWb485eln/fe6wANRMOLrcLgGlzft5eQdzqm0IG344Qmr9UAHq20EQp01xzeR5NN
         /Ir+TA2F5i4tXuJRFMlwNf1xWos3hgVTC+byD7cvcZk8/jNrT8MueX190WH1dol8Dypk
         Bi4pDsUtqtw9VJSA3G+xZa+N3aLINAh9F1za/cYYnjyrOn54MzLqi50R651mE/Oys4nb
         BKOw==
X-Forwarded-Encrypted: i=1; AFNElJ/x4NOH9CAPq80rLOJGaCKv1AxY484jDPnPOYQuDrMB3woMQuI26p/Q2N9yw4+bNH7qrRCu+E5kQZWeI47oEq9F@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9HI92v+wod1BFo2VZoyucgy12O//07wVy+eNyOAGIzeou5D1V
	hfAMbBbKjuGbMwMSSfPSelxxNTb699TN6pN0OZTIKdi1fH+VQHhXp65w5tIa+br20zCCr/8THJW
	rT2QbY8t0+A==
X-Received: from dldz1-n1.prod.google.com ([2002:a05:701b:4181:10b0:12c:8922:f4a2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6720:b0:12d:b2e9:b20f
 with SMTP id a92af1059eb24-12db2e9b4efmr5736211c88.21.1776960644100; Thu, 23
 Apr 2026 09:10:44 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:24 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-18-irogers@google.com>
Subject: [PATCH v3 17/58] perf python: Add callchain support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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
---
 tools/perf/util/python.c | 237 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 63ee9bc65721..28961ad47010 100644
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
 	Py_TYPE(pevent)->tp_free((PyObject*)pevent);
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
@@ -848,6 +1038,7 @@ static PyObject *pyrf_event__new(const union perf_event *event)
 	if (pevent != NULL) {
 		memcpy(&pevent->event, event, event->header.size);
 		pevent->sample.evsel = NULL;
+		pevent->callchain = NULL;
 		pevent->al_resolved = false;
 		addr_location__init(&pevent->al);
 	}
@@ -2810,6 +3001,49 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
 	if (pevent->sample.merged_callchain)
 		pevent->sample.callchain = NULL;
 
+	if (sample->callchain) {
+		struct addr_location al;
+		struct callchain_cursor *cursor;
+		u64 i;
+		struct pyrf_callchain *pchain;
+
+		addr_location__init(&al);
+		if (machine__resolve(&psession->session->machines.host, &al, sample) >= 0) {
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
+
 	ret = PyObject_CallFunction(psession->sample, "O", pyevent);
 	if (!ret) {
 		PyErr_Print();
@@ -2900,6 +3134,9 @@ static int pyrf_session__init(struct pyrf_session *psession, PyObject *args, PyO
 		return -1;
 	}
 
+	symbol_conf.use_callchain = true;
+	symbol_conf.show_kernel_path = true;
+	symbol_conf.inline_name = false;
 	if (symbol__init(perf_session__env(psession->session)) < 0) {
 		perf_session__delete(psession->session);
 		psession->session = NULL;
-- 
2.54.0.rc2.533.g4f5dca5207-goog

