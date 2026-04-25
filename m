Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2673438F64F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157445; cv=none; b=aboVs1UJfjBZ3Ixymz3GCRQKqsIncBMImFNFLPzT1IlocFsOG27X7qiAtanXm+RcTZSZ8fK6xB0DYDfQH6hHriObozL7KypLNAIc3aFwbRsTbbXBKAce1twSh5ROknLPIaOdCyXs8WPTWouziRACWK4+UFHAIlfwkYcae24ptPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157445; c=relaxed/simple;
	bh=zQJJTQ7WIIRdlqmfoLZApYom+sX71HVjnn5QQIJluZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FC2IQlrwU4AySnahkPI9TGJAxsG9aIGuqiYqcYxUJUcJjRQjojqVyen3ZJ07LFAkHa26vLLpf9wr4pGdgBmv1/yURzuQfwxp7nRughBe82VATsYio6qTfjocOtmyF9RDnVv/jtHptkFtCbJeMeltYR/l12Q0SrxSn1XX6X7VWLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muq6mXeB; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muq6mXeB"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-126e8ee6227so9132355c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157442; x=1777762242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9169CYggYX8a+HEsC3bSJNy6IomTsX+Hp0FHeVzozsY=;
        b=muq6mXeBGZ/X9NDZJsUoS52+cZ25HB+wEDNv/Y//BkP08/IMmdjJS6eRSub7+amFio
         /A9lsq2W9qeOQq+ASSi+FbLveC2khknCePoxsxxo5Lm1PESAtoKXsILLHSlJjALuGolV
         02J9VIy/PivkiblF+U/DghVfjuECUxvXbZ0KnXZksV4QmtUkb7FHghS+BRpJFJbGHsWu
         xKYcIE928cX/4daBU/q5AizNlFj+580s4EAPFyrLcCEEoIZxqBX4+Wy5a3Dab0Wfrmz7
         jLd+I9Onz4a+Odp0jmmvPIqcsqIknS2dJ1AjrSV2pOOgBAO4DaXBgXakL4QwO7b/TvIB
         blwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157442; x=1777762242;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9169CYggYX8a+HEsC3bSJNy6IomTsX+Hp0FHeVzozsY=;
        b=kWBbiWIAG7XjDdWhdx2C3udlLSzrImeHFIgvFQvg74brbp+Aukz020drZt6rP48417
         awH+PsRYNDQ577M7qmqdvzMbcaZjDb4K1sWv3fordFkGubnQiWOQtuMVLk+lryOeiN1H
         TBdZYOzTqrUjMZj2BpOdrBAekEaNoWBwVr/2GZ7BiUqmyUj1ZyZlEU7RMJnUW76hizmi
         g5dqRPIfTK8fe3YRURyA/ENkWspHTTwiQgwzSllgS/wWcdGWNC3MUTdFhtsisvpAj2Iv
         VAGa+IdWwG97FUlCrt7VadJvrxmX0BUGuyhslyuz9xzKlPyrpUz2DVoLxbqkwGGUMNbS
         c5yg==
X-Forwarded-Encrypted: i=1; AFNElJ9yjZjozI0fVNwjRagyGVo+m/Bv+tQdRQl6zEoGOW8D+8wTD+oOHeh6u4FFaVhcs/dsYKHjs8pvZbsRfryXO2Ih@vger.kernel.org
X-Gm-Message-State: AOJu0YwHv02zGYLsdLN1qVOH9c4/+J8Kqq9rpkinSNb1UJxmIJMcWcrj
	zHZhImL/XQQi6OZMDyfBbx2/F9zRjPp+TddCB5q62BIohSwk4y2Uj1Z9wy62VGMrV62B7kLQrNh
	fnEz8qMB5nA==
X-Received: from dlbto5.prod.google.com ([2002:a05:7022:3b05:b0:12c:1f83:7b4c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3d87:b0:12a:85ef:1e50
 with SMTP id a92af1059eb24-12c73f6c614mr20784618c88.12.1777157442219; Sat, 25
 Apr 2026 15:50:42 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:06 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-15-irogers@google.com>
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

