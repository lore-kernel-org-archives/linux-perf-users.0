Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBAE389454
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156923; cv=none; b=uO4dZyHi93r7IUBEUYl5A9kdKHJ3p6DYk4wdXDWVWRHkQfFsVHquKMe/RteIKJofITpQokC4pMTaovio2LPAc6QGB/OeyvCRrrq7WjYnfKoi18dOCDt559Q6GYYFuJxhmCoB4nKw3QL9QwYgkhR1juyC8czJiZkLI7SaqMF81kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156923; c=relaxed/simple;
	bh=zQJJTQ7WIIRdlqmfoLZApYom+sX71HVjnn5QQIJluZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I7Be/VjR7ik3s7dtjv3F1W3llTIGrtyxj3BfcVsbnwe/nuGJ54eOn5vmxtChxvf4xtIUbI8nhSG80ec85fAGrjSf0+zEn1bMbbbcHXI+/QTsUdsHfewGxSPtuBnTu7OmIf6G9MI+NZp1yHWXIavKeCJ+Ho0GtH3/je7owa5axV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llVqX3Dl; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llVqX3Dl"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d93379001eso20009826eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156920; x=1777761720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9169CYggYX8a+HEsC3bSJNy6IomTsX+Hp0FHeVzozsY=;
        b=llVqX3DlX5TtPY2+8eIb24fTkZ//24JUFHONlBlXzC8eUUtwSz4bxu/V8wbVexZHFd
         c/CBGeCEkr8mtWP/xMm7ZHu3hmFYeBs4mdbZr2FdS7WxLpHzJpzejOk8s+p8vAoYA8p3
         +L6OMJRnx92rmsQc7RlzRhvDnBRYuMh8eZ1C5H7x5yl3eYGBq/Z3Kj7rgf7GajjSKv5D
         2ShKO5qRfi1CaYrOOGXBESdGstAVefKQDreWIZSUEByws4cMJycl2UBkZ8WK3hM1xkMY
         VcvU0i3ACePSeLOv2EDBXbXLzb/JDlS8oRvtio0ze+jGM0m0SAIlQwKHUeaEyjyH4Yla
         lmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156920; x=1777761720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9169CYggYX8a+HEsC3bSJNy6IomTsX+Hp0FHeVzozsY=;
        b=I6KbX7CkeL3w0eP35+LBZdkBOvi/MoRgKcs7hyT2Ijzi5ovoNbca6LXsJz7AejgDA0
         NLbFuVVramvUDLZWHUrrlHEfgbneXU+ecMieADNunmuS+9RB6O7oAH8D2A0tBcN0qQbO
         EKiUG5fP6TTJpIsFSEdFJF4Xbj3FE7m2iFE+/aggXZnV0R/Nn5hsM+7P7Jsx6fpu/4bD
         LMFj44YG1h/ZdPSN9lvFSuBTVzE7caVq5yCEW9qXy9wDd3qz8ygN/sWtL5zHYtCXIXYZ
         uq6yedzZsUVebNrhjh8D5hYT3nbWTiZUvWXrnsz/uIESbT/uULHhhunCYm63pZ1aA803
         LU2g==
X-Forwarded-Encrypted: i=1; AFNElJ9lo7H1cCnCNZZ4I7JO9s9qCrO4T6FNdaUwH/NyWGJJuhO4diQPJYFc5p4ZFLQW5z4nBl2g9u6pXGNivsB8zNlp@vger.kernel.org
X-Gm-Message-State: AOJu0YyNuvp+NNMr6RPgEtKgHkjXipmSmdEzEuWyLGJUb8W0OCrupz6H
	fyfUmDwGWRWBIIg3hAV6LUXr91poJUTDc7yI0x+3gT95Zz5YHxUKLce/IhR5u1IiA3e7I7XrCag
	SwZXsJqZKlA==
X-Received: from dybkz15.prod.google.com ([2002:a05:7301:1a0f:b0:2d9:cb4f:864d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:3d17:b0:2dd:405f:89b3
 with SMTP id 5a478bee46e88-2e4528ce85cmr21073178eec.0.1777156919870; Sat, 25
 Apr 2026 15:41:59 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:39 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-15-irogers@google.com>
Subject: [PATCH v7 14/59] perf python: Add wrapper for perf_data file abstraction
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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

v7:
- Added pyrf_data__new to zero-initialize pdata->data to fix
  crash on re-initialization.
---
 tools/perf/util/python.c | 103 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 2ba3556c4f16..aa63c7ffe822 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -10,6 +10,7 @@
 
 #include "callchain.h"
 #include "counts.h"
+#include "data.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -2316,6 +2317,102 @@ static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
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
+static PyObject *pyrf_data__new(PyTypeObject *type, PyObject *args, PyObject *kwargs)
+{
+	struct pyrf_data *pdata;
+
+	pdata = (struct pyrf_data *)PyType_GenericNew(type, args, kwargs);
+	if (pdata)
+		memset(&pdata->data, 0, sizeof(pdata->data));
+	return (PyObject *)pdata;
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
+	pyrf_data__type.tp_new = pyrf_data__new;
+	return PyType_Ready(&pyrf_data__type);
+}
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "metrics",
@@ -2378,7 +2475,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_cpu_map__setup_types() < 0 ||
 	    pyrf_pmu_iterator__setup_types() < 0 ||
 	    pyrf_pmu__setup_types() < 0 ||
-	    pyrf_counts_values__setup_types() < 0)
+	    pyrf_counts_values__setup_types() < 0 ||
+	    pyrf_data__setup_types() < 0)
 		return module;
 
 	/* The page_size is placed in util object. */
@@ -2426,6 +2524,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_counts_values__type);
 	PyModule_AddObject(module, "counts_values", (PyObject *)&pyrf_counts_values__type);
 
+	Py_INCREF(&pyrf_data__type);
+	PyModule_AddObject(module, "data", (PyObject *)&pyrf_data__type);
+
 	dict = PyModule_GetDict(module);
 	if (dict == NULL)
 		goto error;
-- 
2.54.0.545.g6539524ca2-goog

