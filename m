Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D94932D0CC
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643211; cv=none; b=Ex42PcoJJ+Kr4Te834d5h6CiFkfM/x/epeVyt7Q0upTbuoLW94L4ffJeH2ToX9TYE5rTOmheakZV3KJiT96IASJbTNireHg1kMlJ1VL/dM8KxjBi6j0QL13W8og7BXEcracZnF7AmuayVb5IEX2lO/cZ3f1smEb+FMDXsSd2Dc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643211; c=relaxed/simple;
	bh=5tcmYFQPeR1bn08XqQ2iVKkWHZAVGujzskKVtdxnaRU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GhCYawB1aQB12QypzMXkeb5rwuAY/ybmhN//gb9VIuMeQx+PsEGe22W1ZqU2oTTnYRFbG1tSMNiEOu7KFX+w4xID6rbZERVuJ7zYXqXTcFdZ3YLDk7C9SxONzxudkivsmKU8ASB+vmIBdK5+TODgW/i8vG8LxnOd8h3vbWTJkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FpomshYk; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpomshYk"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d8a677cdfaso2652065eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643209; x=1777248009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SslHAE9Igw/56ZpfjBGKdcU4iQE9U20B4MzACiYcJVk=;
        b=FpomshYkylSRQup0kTntXfQOOOeFfmE4DiSqcJH24k/qfXPqtOgOQHpbEXdShiK27x
         65+y4yyDFRsbCIjjXtRx6OP1lfC9Uv0AyQEjjrticonsPbG8up4yk/T336pi0iGywd/f
         heFgu+6YFemuTGfJ0efJHpDK0mScPd/7JxFd7jZdoxxleAqY595GEqXpXmB7Vw4wi1MP
         MXCaOOS4UQKeCzFi1KHkFOqFzF+y+nkJMMt5bDcIdlR8U+3OZoOBH216yAxBZzUNTjYl
         nI5xs+HLQetuzRiNGmn9MuVSTX51vsQXpQPA5GW40AYrIwKiFTghI97p8m1QaeR5qM3O
         1lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643209; x=1777248009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SslHAE9Igw/56ZpfjBGKdcU4iQE9U20B4MzACiYcJVk=;
        b=gV8YXvHiEz2JylPgwZzMU8/qZQYDVrvwDgrP5P9/Gx+XyhCbgpYHkBMSoOgljcvYZT
         Ab6rHcxGQrgWd6/i186q0Ns1OV7O/2tDrlUvuaCLXmYWDyUQBJJ33BGLg+1IoRxx9OfE
         Qit4/vazQ9lRiNINV1pDhz0hg41wwjgtc4lTuE68tTWSmLBvWdDsPKv1kkcE8taaM/By
         snWfEMCMb6hi4E7mLAJPzGlldSVTONFHmdNnvmvQy6BEF2ZE0Bvtme+MdmFvdhArpg0S
         xTp7TuDuA0kC4FPu1/Zxj6yzb4uYhymtcXMtb7uyIUNzlOQDs2fE3fJHm1VxmevB81v1
         k9EQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hwEoSS0yJY06zpEHV34yTttxlCIqMY8eZn11cd5y5Plin08gNtsh3jOYop51yXxMReG0zOZmeTjyqcb8u5MG0@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+DMnPyGR942Yg9BEHjVpUcAgT4HnmOwmeC8Hppt0S2J5GPnh
	c9qwgzzerK3xi31Ap8cLHO80UPbKRkpsObAMkhTelfnx5FTOiR3BfQum6geldfYRoMJcB9Vmg8h
	nIGwQBxppBA==
X-Received: from dycnm7.prod.google.com ([2002:a05:7300:d187:b0:2d8:fc66:cd7b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8c9f:b0:2e1:e3e6:2909
 with SMTP id 5a478bee46e88-2e465487fa5mr5686790eec.9.1776643208678; Sun, 19
 Apr 2026 17:00:08 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:33 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-22-irogers@google.com>
Subject: [PATCH v1 21/58] perf python: Expose brstack in sample event
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

Implement pyrf_branch_entry and pyrf_branch_stack for lazy
iteration over branch stack entries.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 163 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1e393f354ea0..52970c78106f 100644
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
@@ -866,6 +867,150 @@ static PyObject *pyrf_sample_event__get_callchain(PyObject *self, void */*closur
 	return (PyObject *)pchain;
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
+	{ .name = "from",      .get = (getter)pyrf_branch_entry__get_from, },
+	{ .name = "to",        .get = (getter)pyrf_branch_entry__get_to, },
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
+	u64 pos;
+};
+
+static void pyrf_branch_stack__delete(struct pyrf_branch_stack *pstack)
+{
+	Py_XDECREF(pstack->pevent);
+	Py_TYPE(pstack)->tp_free((PyObject *)pstack);
+}
+
+static PyObject *pyrf_branch_stack__next(struct pyrf_branch_stack *pstack)
+{
+	struct pyrf_branch_entry *pentry;
+	struct branch_stack *bs = pstack->pevent->sample.branch_stack;
+	struct branch_entry *entries = perf_sample__branch_entries(&pstack->pevent->sample);
+
+	if (!bs || !entries || pstack->pos >= bs->nr)
+		return NULL;
+
+	pentry = PyObject_New(struct pyrf_branch_entry, &pyrf_branch_entry__type);
+	if (!pentry)
+		return NULL;
+
+	pentry->from = entries[pstack->pos].from;
+	pentry->to = entries[pstack->pos].to;
+	pentry->flags = entries[pstack->pos].flags;
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
+	struct pyrf_branch_stack *pstack;
+
+	if (!pevent->sample.branch_stack)
+		Py_RETURN_NONE;
+
+	pstack = PyObject_New(struct pyrf_branch_stack, &pyrf_branch_stack__type);
+	if (!pstack)
+		return NULL;
+
+	Py_INCREF(pevent);
+	pstack->pevent = pevent;
+	pstack->pos = 0;
+	return (PyObject *)pstack;
+}
+
 static PyObject*
 pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
 {
@@ -886,6 +1031,12 @@ static PyGetSetDef pyrf_sample_event__getset[] = {
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
@@ -1066,6 +1217,12 @@ static int pyrf_event__setup_types(void)
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
@@ -3434,6 +3591,12 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_session__type);
 	PyModule_AddObject(module, "session", (PyObject *)&pyrf_session__type);
 
+	Py_INCREF(&pyrf_branch_entry__type);
+	PyModule_AddObject(module, "branch_entry", (PyObject *)&pyrf_branch_entry__type);
+
+	Py_INCREF(&pyrf_branch_stack__type);
+	PyModule_AddObject(module, "branch_stack", (PyObject *)&pyrf_branch_stack__type);
+
 	dict = PyModule_GetDict(module);
 	if (dict == NULL)
 		goto error;
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

