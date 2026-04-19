Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61939331A43
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643195; cv=none; b=FcfnVUeQOyWH0Au0T6ZDmRPjilFdTlUvAnTHOJoe7hTuhMk+wyR1fSJKbHOV6Rt6TrImA9QgxS5kSRPeVXnQT6kL+DAVeQEToHHdjYAw6ArDGUplS8BJj5daFgeK9UPFpl3si2tPSqht3CqlQHE7vbBkMlfCUv47AqDD6+ioPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643195; c=relaxed/simple;
	bh=KB5eb8G5ppS1tD92rNkQmYQD3K2H/4j5mGJeuDqEZK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=txuem98VVKoMml/lH2W18IK44hGK7HxE1hcaKcgmE38853zl26wK7w8RQh3LRxbABPw0DcPRtNAxPykQzPBrB4EjKZb2DN0FnhY8DwBPMMGZbYj6ZOZom12iCVSmpkc5qW9bjVJadLo3Nny1pwTACJZtWRBmlDRp7FhNlC4wuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LUmveLbl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUmveLbl"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2adef9d486bso22452335ad.2
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 16:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643193; x=1777247993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3E8o38VQEe3FFnmAO2qFuVmo0iKyuhRBjtl6iw6sg4o=;
        b=LUmveLblFyGtEmRAn03Wr+JXRctgqB4rv9GROS3KzU5au5j8lAXZMVatAZ7dcjJJ0u
         fe9LoEU5asRuY0hPwnjWRVbKDFl2MDmf4RHvlKpdg4uBjVOe3ZnixT7WcVON5prG+rT4
         qhawceSAeuinRePpymD9y0cScF/blsbX1GaZAXRysUvvMLlDmkQcIUKYfKK0GIlhHAqq
         0g9mHPC5RDC+HTXUl0Il79UQO2DLtvnmFIyM7Ki4SVKAn7pqAPjLgLqqVyE9RcWpeptC
         ylLsaKKibbrdjRckIRAwJPU4K1oinaC1rpW/085Ssip1GGDWoYVfOCcNJGao5KGk923T
         XGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643193; x=1777247993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3E8o38VQEe3FFnmAO2qFuVmo0iKyuhRBjtl6iw6sg4o=;
        b=WQmzZvjSWPUAG8T1ratjnCPuoRNcandjDVyuGKHih74qisgV7IYMvMzUKoC633Pu6/
         b5z8hSluaEqexoM9UeKRuHdIbWK7eOMrC10L9RnmVDKdSlsqPGspzhHbyI4djQAS+sKA
         mj87kXGxChnra/eOJ5UzVi7wIh2JOoZ2BnuHw3NhFF4X0c4ZiJHzdNqTOxy5ZJKFtCMv
         JZ95sn4g4o3XgJAZ5C8txSVlxHWb+ozf/Y71Ql9ciEa2/8YScwYiA1Pi6XpfmiT6XLl9
         BgSv1/zuTHeJBU+wj6IaDlijq0vH89psH34t3Djf/zn8xWGYfTZ/tZNOO9fWeQi/BZln
         tSjg==
X-Forwarded-Encrypted: i=1; AFNElJ8spadxfh1FBAAYWUdFg7JTAyquZZRv3NEWRQdDVK+4XGAeu5hZAhhGJxHRBerjbRVVuD7vIccGorJGZKrHIZuo@vger.kernel.org
X-Gm-Message-State: AOJu0YxHhrFrsUYB73NhoPLrjx7AISroc43JxJG5sB3ulH8yzp4lpGgE
	9e9MtcoZJau3+mRyjPppPwxDCeSNTG0/bs06Z7lFF0+PhCafdMEMzN+FGMTuiDvTs5oVpeT2QSt
	Iaew8DiN/7A==
X-Received: from pltg9.prod.google.com ([2002:a17:902:6b49:b0:2b2:6eb1:9306])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ae7:b0:2ae:ba5f:3ac3
 with SMTP id d9443c01a7336-2b5f9e77afamr112892385ad.2.1776643192396; Sun, 19
 Apr 2026 16:59:52 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:26 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-15-irogers@google.com>
Subject: [PATCH v1 14/58] perf python: Add wrapper for perf_data file abstraction
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

The perf_data struct is needed for session supported.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 74 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 46fe173c6b5c..f0dff69f67df 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -10,6 +10,7 @@
 
 #include "callchain.h"
 #include "counts.h"
+#include "data.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -2279,6 +2280,73 @@ static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
 	return list;
 }
 
+struct pyrf_data {
+	PyObject_HEAD
+
+	struct perf_data data;
+};
+
+static int pyrf_data__init(struct pyrf_data *pdata, PyObject *args, PyObject *kwargs)
+{
+	static char *kwlist[] = { "path", "fd", NULL };
+	char *path = NULL;
+	int fd = -1;
+
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|si", kwlist, &path, &fd))
+		return -1;
+
+	pdata->data.path = NULL;
+	if (path) {
+		pdata->data.path = strdup(path);
+		if (!pdata->data.path) {
+			PyErr_NoMemory();
+			return -1;
+		}
+	}
+	pdata->data.mode = PERF_DATA_MODE_READ;
+	pdata->data.file.fd = fd;
+	if (perf_data__open(&pdata->data) < 0) {
+		PyErr_Format(PyExc_IOError, "Failed to open perf data: %s",
+			     pdata->data.path ? pdata->data.path : "perf.data");
+		return -1;
+	}
+	return 0;
+}
+
+static void pyrf_data__delete(struct pyrf_data *pdata)
+{
+	perf_data__close(&pdata->data);
+	free((char *)pdata->data.path);
+	Py_TYPE(pdata)->tp_free((PyObject *)pdata);
+}
+
+static PyObject *pyrf_data__str(PyObject *self)
+{
+	const struct pyrf_data *pdata = (const struct pyrf_data *)self;
+
+	return PyUnicode_FromString(pdata->data.path);
+}
+
+static const char pyrf_data__doc[] = PyDoc_STR("perf data file object.");
+
+static PyTypeObject pyrf_data__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.data",
+	.tp_basicsize	= sizeof(struct pyrf_data),
+	.tp_dealloc	= (destructor)pyrf_data__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= pyrf_data__doc,
+	.tp_init	= (initproc)pyrf_data__init,
+	.tp_repr	= pyrf_data__str,
+	.tp_str		= pyrf_data__str,
+};
+
+static int pyrf_data__setup_types(void)
+{
+	pyrf_data__type.tp_new = PyType_GenericNew;
+	return PyType_Ready(&pyrf_data__type);
+}
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "metrics",
@@ -2341,7 +2409,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_cpu_map__setup_types() < 0 ||
 	    pyrf_pmu_iterator__setup_types() < 0 ||
 	    pyrf_pmu__setup_types() < 0 ||
-	    pyrf_counts_values__setup_types() < 0)
+	    pyrf_counts_values__setup_types() < 0 ||
+	    pyrf_data__setup_types() < 0)
 		return module;
 
 	/* The page_size is placed in util object. */
@@ -2389,6 +2458,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_counts_values__type);
 	PyModule_AddObject(module, "counts_values", (PyObject *)&pyrf_counts_values__type);
 
+	Py_INCREF(&pyrf_data__type);
+	PyModule_AddObject(module, "data", (PyObject *)&pyrf_data__type);
+
 	dict = PyModule_GetDict(module);
 	if (dict == NULL)
 		goto error;
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

