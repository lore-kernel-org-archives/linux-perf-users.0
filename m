Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC19328B4B
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916570; cv=none; b=a0wo/Yo8hOYQccys/zVBbijY26X9H/S2kkZ75HrLqa4y0aGhTzkNVXqexgGikgrrbZw7UriCZPDXCsYVhTSSLofp3Wo/OF/2xPy8qmX9dCChiy83b4nU4+staoT19uq0XEJvfGbhHz8UUHbZakDW6jxPPTPln8A/eVJ1PYQmsvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916570; c=relaxed/simple;
	bh=ln1rV6AypW2boTLgr0zbcDXnCUbmGvFLpZvQ6sZwGkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l7FA8EqgEvpmEdxaUZT1NU4mMFu1MGRBrCd8WMV1D7qfwKl2lDu3KgyfJmvmjhXWpzfzWoLLNUdfkdJgEyj9xmTyqqLKMQBeKdmICLzYErC3mO7UyD3VJDIkF6iNXPbHvQQsVaNqOaXiEeBzihkC56R7XypRGxP1iOMJt5XdQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SsYTsaOv; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SsYTsaOv"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so7541020eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916567; x=1777521367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wB0epHj5T6mGCNWPcnrhm03fhnWEaqx9O8W0M4mhTNQ=;
        b=SsYTsaOvoCKBOdL1ngKWxytGc6uCLZJFrtmDuW+dNJI/iQyenacvLhmuhhbptqonam
         zB3sAX/Fr2rgbtvmJASXv8JylI91ybh/sMpp1wznJW+OIqsj3GSG4XfTCb277nanhUBt
         UqlEb+Y/bvuScrKO8Lz8qaSvrk0UgOvl+AjBUaH8kC10KXKY1cWJu9NsIKAJ3Nj2PI6a
         eGZPB+goRbnMTx2UOuDyZUVaudt01p8hEFM0hq0zSHFELLuGcGZRy97NrCCkuPBq21qL
         LphShhQ9WbaFp3NafI1qU1TvOBR8+GKXXrPCmKM83ildN+0aeNAUVtxAWNPc4WD0Neys
         cS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916567; x=1777521367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wB0epHj5T6mGCNWPcnrhm03fhnWEaqx9O8W0M4mhTNQ=;
        b=S9tFeC1vUrOciNfExFC6BVQrq39c/dNpIxEvKvXF4/Aev0dITsAD3nQFWy+jxizaHT
         Gurr6li8xyudjDHGIiAH2YjJbi9Wl//3Wg/nqIdG9Cxia8X0d6vWpmKYv43U7b+yyHSs
         4UeZ2LQ4ESR9Ie5aDjqB55a5JKFWuxw/h5WQqmv3s/qMKI1/kCZwzGxcx8JQzA7HF2tq
         8TDQsItGhFqmg5JBZHigrTGjjxbUSrpuHZpgqEAaofq/hgYLfTuva6fY9Q8yemIjpJ1E
         xDn7hLEMf9SS7krinCwIWeFFzxR2WutRNtt8a4B6qRbJA4X8hVf1aTWLQBzHxqkq5myp
         pSGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6ftVh+lF9w6vx8wnaG/LuukA0JkTuos579LZWePiLZFRZ4nsItzmu3ZKNfVWRIHNPKfokXY08qmlvFs/pq4ye@vger.kernel.org
X-Gm-Message-State: AOJu0YxBIjh//px96p2WVJvx1w3G0kNybam+Jrol2iJpGU1lEabAiIjs
	K8BsKe41F77yQw2CJmfh1z5l00CTAN2G9jMfh0ztLno7jJsCcuvwvkXhvA9qg+NzpMqGd9Pd8mb
	kONFxpB2wsQ==
X-Received: from dlec6-n2.prod.google.com ([2002:a05:701b:4286:20b0:12d:bbdf:edcb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:628c:b0:12a:8ea4:252
 with SMTP id a92af1059eb24-12c73f6d5ffmr12937127c88.4.1776916566269; Wed, 22
 Apr 2026 20:56:06 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:54:41 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-15-irogers@google.com>
Subject: [PATCH v2 14/58] perf python: Add wrapper for perf_data file abstraction
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

