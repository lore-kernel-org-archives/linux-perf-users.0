Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E73CBE99
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916577; cv=none; b=Ugn84B2RlxReJxcE2nHN38tVcHFHc4Pzm5GlgV04vUa9Wvt1qJkxilOF6OGUQ78YRHPxq67spNavPzihxZjk/2wKIiGOx5esNIOmJ8S5gOaA4wXkOFj3du7WudBGwnuB/9LvVegM4HD6He9/BeZu4o4Aowu1+myX1ADZdKcedrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916577; c=relaxed/simple;
	bh=nkdVBAM3kFGKskgBz9rxwnoM2mVPIT+wUGRrR0sOOt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LPG88o53tKKADq7boI4lTQUOVqzoCmyhO47SAC0hYMKQx3+NviVlPAX4jbTj3N60UyIojyJbyma/5zfUn5yLupGTtdVhCebFE3n5WfoYVnUMpCpkTtG6xm0ozgu46YQw7Qwi2LNFarCVFteDit8uEkEH/hLR2i4bH98Dpp+gg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Syoz8O6n; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Syoz8O6n"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c16233ee11so8467111eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916575; x=1777521375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ9+er+QbbbztcK4JbiUkjtDIIx93po4ZYbVXaJ1Y78=;
        b=Syoz8O6n2MnwbxbgPN3wnJCFd2rs05JcK+W5A/zY7ZLiF3ebA0LBZnrBRJeY69z+0J
         ZEtIy8AJ0NUkPLf6pr0yoEG7es7hLL1Ir6F543qmEartGyRPRG293RSuhJjXhydn6qIs
         UtQfZDkfP8AKiStCQzcnE0r2jm8GhunZGIUGUjrXiIgzmUPrBmClGJqD6jgIjaWjydUx
         4nS2tHaj36losbidhM/dK54OVfHj5M4aWJo24ESiSqgLzAqb53DtrbigpMN7BOi8hCPq
         lGSuJ6SSRFY8hDna72CdvWq9D9+nRtIRZZvHjwGYasfZNXT83OZ/zoWUOJUXpS9W9hjp
         AGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916575; x=1777521375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ9+er+QbbbztcK4JbiUkjtDIIx93po4ZYbVXaJ1Y78=;
        b=G4Ww5b6dxh0ZvAjKzers2wqRCSmVE132+QHSiwHwTKG3c51euyB8UWQuenRSVL/nIa
         5vXAtbd6r+klmkJSUR//ZVxSzpfS4XLkbbEs7Lem8DX6i3eYlEg0iGbIXeWEPWCplT6a
         JjnbsBDTL037dvFsJPIrHplmVsaLt79gi/NftCiMWj6NEZ6Cblpm0fHprgRRRVtJnnNB
         sB97YObPwel1C65u2JkQFBflC8b+rYwAPqYCjJhwnoSvFAluvazwEXc3lc67KEucMG/9
         L7YzXt+67hP0rUrB76AYIzHHhs/a4QIKCAj5x099u0lDwxnHf3ySid6ZA+zfJ/qeAeOW
         YwAA==
X-Forwarded-Encrypted: i=1; AFNElJ9FZg3x1jlbT1OaFlwygGS0jVzzxqFAsJvOVm4Ir0LwO+PWbf/A4u28mYmQ/laI8e+M6ehvWFu7T6WrLsCfBx0n@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ1Lm1hOMZ25S5cR7XY3/j+gNNeBuWtHTWfKLxP7onzLVmqaRR
	fMxYHvCgI/O0VH3ZynhOGrez4b/kZj+yFu/xx1rZgiyRkp07NHzG0T08C6Qc12DEkrAhDnh76Ec
	sCj06eNvFSQ==
X-Received: from dybaz36.prod.google.com ([2002:a05:7300:6c24:b0:2da:2525:9f3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4083:b0:2d8:b1ce:d3d8
 with SMTP id 5a478bee46e88-2e4526dd448mr12868745eec.0.1776916574585; Wed, 22
 Apr 2026 20:56:14 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:54:45 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-19-irogers@google.com>
Subject: [PATCH v2 18/58] perf python: Add callchain support
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
index 3e0534744f0a..ebbb10c0efeb 100644
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
@@ -2807,6 +2998,49 @@ static int pyrf_session_tool__sample(const struct perf_tool *tool,
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
@@ -2897,6 +3131,9 @@ static int pyrf_session__init(struct pyrf_session *psession, PyObject *args, PyO
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

