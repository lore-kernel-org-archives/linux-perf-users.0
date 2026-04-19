Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D777336EE1
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643205; cv=none; b=IuEacyYJfStUiAeXCHdN59kXbzvOCGd2RLyh0tIWkRP0qidKa/cq4duPF6xxem34RZLMdzy2CJYZuhhZ0JbWlVYgFUFQthUCJUp4HXrzg2qpWKvykydVw9LGdex+tXuxqHMyhCWzb+c8fZWuoucH9zp/RwUgZYKIVNQX1+Pd9j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643205; c=relaxed/simple;
	bh=w6qF2Dp5WBenrQB+GWwCm8gNspOujBAITf2k5B/kQLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=biaIunN2gEFCjsAVsxViAbzNo99j9W3Zda5IJ9H75HwTwJ3uCVRHZZT8lOxYIZak3AhsYhYiVFJeAS1r+gFg46HgDx8QH1VwgtWTVmZDqjfZpaUkAr+3347sPRWj+6MAScP2ntqM/NMFFjIRwmPtct6sE9iqX+y+9fIaqQBg7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BxWEsRyt; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BxWEsRyt"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c16233ee11so3409152eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643202; x=1777248002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQ3TjyG2TqHvChMMttRj9q841UswYarUqQ8JlEldfog=;
        b=BxWEsRytGCmQ2LXMtpRFQ828EAqCLPR3DTO3ozOrP0hIB59OSjWgqeMtIq5EQG3CiM
         yyZosv+JeTKTwpbwaYPRDLkERQplHr8XJmY70odijMTcXAXUA/5ByloRTt5TMz7uDPQ9
         HsZwRFyDlfUEDZ0TAJ2SITzw/kS69s2pXpzNysrqX4+588Az1Nx7e6jxMVrYDSm8sAlb
         BdcY5ZltD3sq663rybOGI3iKcVB7Y0rL8Wzr2gcykiw+pr7LFVjo3yfFaJfN3mFuCq05
         NDayyBSWI1/DQeUK8h9sAobP1HKvmoScY1PscUi7s1EAeRYDwvMUYXBixUIu7BSxs3By
         8wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643202; x=1777248002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQ3TjyG2TqHvChMMttRj9q841UswYarUqQ8JlEldfog=;
        b=KfcdtLdjkdups0HEXl0VLL5fWKJPgXQTiZjo3k59zBqIVyv6e2k7PcTV6M5zPy84+A
         gRoOOEU92/YVIlwbAQeoWkJNAI79Uj/NGeGnwuwSz4a0U/kCxFx/Dtkf6CUkA57q0sSC
         wF8bAHHO1CaNinLdFglnfC6NBF/AbLLxNp2Rq8AK1uhPpJV3ZXfX9NrBXHR/Uh601Lx6
         FmXbcmjRuVbuVLBxP09fV2cnUmkgHdhRhTXMv8B4Fl+C7SsptXiCRhoogXYlEIzMcqzh
         u1UTvrCUkYCg2SdBqaPtDQmCFo7gxentaaxorf95G8DjSKXQwkicz/tiD3CKAqzGrq2H
         YHUA==
X-Forwarded-Encrypted: i=1; AFNElJ+tebYH52lHSoWqZK3U/h1zGy0gbpUhVaB2n7AHOqwB8WLQoKcGgGcV4+XDUCvK5DmS9xkRAZvMYuZ2H3so3/SI@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZn6Mi5Jx4tgqmGSWVgmR6b0PlbNm4cOpH8VQv+tV98jHTmhg
	w5wXevRqDOMAl7dPsuqNK9hY46FFVI1PF8gvVIVzHY2HFM/cyou6zfVLC/QliHFYXwD1Zm7sEFg
	J5TV1lZzJyQ==
X-Received: from dyfv9.prod.google.com ([2002:a05:7300:8249:b0:2df:7541:1895])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1292:b0:2c0:c415:cfd6
 with SMTP id 5a478bee46e88-2e47873bca2mr5611154eec.13.1776643201232; Sun, 19
 Apr 2026 17:00:01 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:30 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-19-irogers@google.com>
Subject: [PATCH v1 18/58] perf python: Add callchain support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement pyrf_callchain_node and pyrf_callchain types for lazy
iteration over callchain frames. Add callchain property to
sample_event.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 202 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 09b566707563..6baf38a08690 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -609,6 +609,193 @@ static PyObject *pyrf_sample_event__insn(PyObject *self, PyObject *args __maybe_
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
+		struct perf_session *session = evlist ? evlist->session : NULL;
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
+static PyObject *pyrf_sample_event__get_callchain(PyObject *self, void */*closure*/)
+{
+	struct pyrf_event *pevent = (void *)self;
+	struct pyrf_callchain *pchain;
+
+	if (!pevent->sample.callchain) {
+		Py_INCREF(Py_None);
+		return Py_None;
+	}
+
+	pchain = PyObject_New(struct pyrf_callchain, &pyrf_callchain__type);
+	if (!pchain)
+		return NULL;
+
+	Py_INCREF(pevent);
+	pchain->pevent = pevent;
+	pchain->frames = NULL;
+	pchain->nr_frames = 0;
+	pchain->pos = 0;
+	pchain->resolved = false;
+	return (PyObject *)pchain;
+}
+
 static PyObject*
 pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
 {
@@ -623,6 +810,12 @@ pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
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
@@ -791,6 +984,12 @@ static int pyrf_event__setup_types(void)
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
@@ -2836,6 +3035,9 @@ static int pyrf_session__init(struct pyrf_session *psession, PyObject *args, PyO
 		return -1;
 	}
 
+	symbol_conf.use_callchain = true;
+	symbol_conf.show_kernel_path = true;
+	symbol_conf.inline_name = false;
 	if (symbol__init(perf_session__env(psession->session)) < 0) {
 		perf_session__delete(psession->session);
 		Py_DECREF(pdata);
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

