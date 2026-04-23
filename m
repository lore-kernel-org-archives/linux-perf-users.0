Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82646390985
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960640; cv=none; b=LtmbRTVD78FEw6nBFlFkYVeJqr8usH4febLvSqX4c5QBuLVDhlXT0QNpoHp3YU7UuYm5ifZDP9f2lXQotp6bKkIZC0oBvzntkTcFuim5qUdd7cRaZHkAXsBSTexlc/A6c69d9K/dcDfZLD/Br81ZBgANq585AAYjjvYCWeF7KXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960640; c=relaxed/simple;
	bh=ln1rV6AypW2boTLgr0zbcDXnCUbmGvFLpZvQ6sZwGkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ron1bGnXgB7rYnObmbUrE825lIdJN0/mzFHbh24tmlVEY049LU32DiUDnEpFbLdsE2FATOSqpMaFSEGpcuAbbRFtY1p/QirZFBXWCcuEqiKvTLpYQASUpMOPoUwHWMF4GtcKJIjv+SZynetY9WQVt2aNtV8Zhr8axIcTtiVeNjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l1hBVbi3; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l1hBVbi3"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso8993897eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960637; x=1777565437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wB0epHj5T6mGCNWPcnrhm03fhnWEaqx9O8W0M4mhTNQ=;
        b=l1hBVbi3+0Ge6ZjJX7FyyQcA2LejBHFtwjqzR5NXGNgr2SCKpFsggf0YMquF/YzBmn
         AbbHi9Fut9XRD1vT1BHId8Uh3y7QqOGLHI6nPTfq5IWPTgorPGHWE0LBCLKko7KPK0Zg
         z4GkUlPkeimqT2/+fu3vaWbqv0W62a5vxdLtuJkMWMTCxhMv0FgKI+EOPeahDCs59o41
         8KS7PuRbfr3aAWBqcvVaJnwyTn/e+KUZPjuOGRFnjsCZgX6/BGkbZJDxUi1KQ43Vi4az
         CKDyPKYt8zWrPGqYE050oTwUPxShDR+QKet6idCivwScy55fhCMJjT0j8BuZtjeLnseo
         EKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960637; x=1777565437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wB0epHj5T6mGCNWPcnrhm03fhnWEaqx9O8W0M4mhTNQ=;
        b=aHHSwNPjdlxGy0g2Bgunki8umxRQYNmtRUxDe6zq0rz3qOPA4NaLu8BnLEl8vpXo+i
         VqSxO4wPnNydnYoxulbso871w/eDfdI3XrOO6vbd6e2D2J9SwDK9ePy/zpzXZy73we0v
         WwtH1XWCsggTSXSnPIjz8Ybl8gZ2c7xVnSPnPG7+6vYShrsI0G0tT1bFMEBANQb+6+57
         jZAnhWPiGfgog7WfUiGJLZ9KyvYWZp4vZ7F1WQQ+h9xC1qrAAZXjT7Te0mgWcMMDq1Rh
         a6RGkFnIfU/qMfUcjMZbFwrTMKh2yNIssIQxNFXzKiPSBRBCHwLtNkX1dRi4DtaLDrGT
         ibZA==
X-Forwarded-Encrypted: i=1; AFNElJ/CbPNT/heuapDmJ/FK1C4VZ2jFHdjFP8fNVJ6ATjKNa53/z+yd0764vE8H6pYB7WDqAcUG9Ok9sguma6UX0QFx@vger.kernel.org
X-Gm-Message-State: AOJu0YwnxWT5repl8mN1u2c0S3wJEKpCU6dC6d6XqYCJudm+QtKoVVbY
	n0V+Kejs57JCr8sJUiIE9iu4U8Ya9vCNtfUwrB9/yIgvGDs/VcfEg3/FxdofcAJ6ywbCMJMNoKp
	TbU0MdFn7lQ==
X-Received: from dybkz15.prod.google.com ([2002:a05:7301:1a0f:b0:2d9:cb4f:864d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:230c:b0:2d2:c60d:4fe5
 with SMTP id 5a478bee46e88-2e464ea4e10mr13830290eec.6.1776960636267; Thu, 23
 Apr 2026 09:10:36 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:20 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-14-irogers@google.com>
Subject: [PATCH v3 13/58] perf python: Add wrapper for perf_data file abstraction
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

