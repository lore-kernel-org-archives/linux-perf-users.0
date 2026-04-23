Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B9238D6A2
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962090; cv=none; b=RIToeYass7/g6h0ptBqdk5fQetemFp/eSUfPwYURfXEC8MkiSI6v+p7WZniV8OQQ7W0L2caqPWsdKp0tsIuIodchQXlh76G1wr1dm7eoZLWkUS/JkduTf+cZ39PV5idyEBgr/AQ4vXhZrr6XZ2duoOQxhUZlMy8MqYl1kdBCg3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962090; c=relaxed/simple;
	bh=ln1rV6AypW2boTLgr0zbcDXnCUbmGvFLpZvQ6sZwGkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PmqB5i8zna0dEbp/Y7HTIZcNOW7CwHp3joKjZeYMHqrduCFOkajEJfWwIEtiPaEq7F8dm+IxVIZ1wS+EXu8QKeakBK/6aJfaMOwUvvAgLRpJ06cJ/A2mmDyCs/Zp0nblq8oejRXXNwfYPkHFP3C87NH8Ce+WZOzVJrjRRY8bkpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQqaYeEA; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQqaYeEA"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2dd1c74508cso11165235eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776962087; x=1777566887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wB0epHj5T6mGCNWPcnrhm03fhnWEaqx9O8W0M4mhTNQ=;
        b=fQqaYeEAA6jzv5DO/7VYdmTMPVN5ppAYyvfLm2f0j90XT7Tgi2geFKQTGWWa3Hw8fI
         Z8T0ke2zXNzJGSWJ5hrt+1mguDKn3Kytd4X5k4tbanlTh5jigzYJaBw7APbJJLs54MQX
         bw201xDoRx5e4U/hugLb30frc9Z8qEkaQtnJmnV0aDoDt6T7Jexz8p2a2LyG2esAuVma
         6EyOfyfc/mcCUjcK+XnWkcf/jFldh6b0KTGMVoFPYZaZ9titt5xFM945sIaI5J4bVKSb
         NFeIUs5ipcB69DGl6Jzc3chF0JUP05NdSaVi54O1v5Q4SotyOA777a2TPTASUHp65lj1
         0cpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962087; x=1777566887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wB0epHj5T6mGCNWPcnrhm03fhnWEaqx9O8W0M4mhTNQ=;
        b=hjN6VJlJ+7dwV6Jt9RY+0UpTXwQUlmFoIICqDg/5aPTpiQ7uLir+nzLRkS+TRnYqw5
         /gmT1qZ5HOGbHot0xjDalfaHYcwZ8VONDlDwesW46WdZpbnaSa1w4V9V1FlVwzSx8TIk
         s+eTuQ1a476B1yS95Zg1EZ8eU63sTuk2W0RBYg/q2wvg5aH/USC5Oi+qh1Z//ev0JhcS
         QN82BRu7NqZDmGUvfM4o/8t131BBM6nU7dptA3WQ36lSWWJdwU9ZwRWJonUxWrnKnBdZ
         jADMH/SoQsnaj+p+lNjpaqJM2pzJH2r4TIlPxDZLyUTDLKw2OP76BEYdUTfJ+jlPSY7J
         1Pew==
X-Forwarded-Encrypted: i=1; AFNElJ91LngIvlQBMj5EAtnkDMh0uDGThDca64WE3N6HiMLnbmho2zHrFGlIfbRh1t7cOT1krUiXP0YERmsYEQOfZpCV@vger.kernel.org
X-Gm-Message-State: AOJu0YyMqBE6DoLedHFqXty1pJW/aRLqNdnWVludcOn2ERrncS6m4/oG
	AuuP6vUdjpo1S0lEqaIXgD3U1SzTdVuYI7v0u9NNQFi3FyCuKYJ3sZyXgOmA5B8GzUk/XMHxzp8
	UFpv66j98fA==
X-Received: from dybgl28.prod.google.com ([2002:a05:7300:e01c:b0:2d8:1265:1a34])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:658a:b0:2e2:9c65:ef6c
 with SMTP id 5a478bee46e88-2e4646cdc9amr14986896eec.4.1776962086967; Thu, 23
 Apr 2026 09:34:46 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:33:22 -0700
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423163406.1779809-15-irogers@google.com>
Subject: [PATCH v4 14/58] perf python: Add wrapper for perf_data file abstraction
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

The perf_data struct is needed for session supported.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:
1. Fixed Memory & FD Leaks in pyrf_data__init : Added cleanup of old
   state (closing file and freeing path) if __init__ is called
   multiple times on the same object.

2. Fixed Invalid Free in pyrf_data__delete : Ensured pdata->data.path
   is always dynamically allocated via strdup() , even for the default
   "perf.data" . This avoids passing a static string literal to free().

3. Fixed NULL Pointer Dereference in pyrf_data__str : Added a check
   for NULL path to prevent segfaults if str() or repr() is called on
   an uninitialized object.

4. Guarded fd Argument Usage: Added a check to ensure that if an fd is
   provided, it corresponds to a pipe, failing gracefully with a
   ValueError otherwise.
---
 tools/perf/util/python.c | 93 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0424290f8b77..a2cdd92e0548 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -10,6 +10,7 @@
 
 #include "callchain.h"
 #include "counts.h"
+#include "data.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -2296,6 +2297,92 @@ static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
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
+	if (pdata->data.open)
+		perf_data__close(&pdata->data);
+	free((char *)pdata->data.path);
+
+	if (!path)
+		path = "perf.data";
+
+	pdata->data.path = strdup(path);
+	if (!pdata->data.path) {
+		PyErr_NoMemory();
+		return -1;
+	}
+
+	if (fd != -1) {
+		struct stat st;
+
+		if (fstat(fd, &st) < 0 || !S_ISFIFO(st.st_mode)) {
+			PyErr_SetString(PyExc_ValueError,
+					"fd argument is only supported for pipes");
+			free((char *)pdata->data.path);
+			pdata->data.path = NULL;
+			return -1;
+		}
+	}
+
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
+	if (!pdata->data.path)
+		return PyUnicode_FromString("[uninitialized]");
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
@@ -2358,7 +2445,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_cpu_map__setup_types() < 0 ||
 	    pyrf_pmu_iterator__setup_types() < 0 ||
 	    pyrf_pmu__setup_types() < 0 ||
-	    pyrf_counts_values__setup_types() < 0)
+	    pyrf_counts_values__setup_types() < 0 ||
+	    pyrf_data__setup_types() < 0)
 		return module;
 
 	/* The page_size is placed in util object. */
@@ -2406,6 +2494,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_counts_values__type);
 	PyModule_AddObject(module, "counts_values", (PyObject *)&pyrf_counts_values__type);
 
+	Py_INCREF(&pyrf_data__type);
+	PyModule_AddObject(module, "data", (PyObject *)&pyrf_data__type);
+
 	dict = PyModule_GetDict(module);
 	if (dict == NULL)
 		goto error;
-- 
2.54.0.rc2.533.g4f5dca5207-goog

