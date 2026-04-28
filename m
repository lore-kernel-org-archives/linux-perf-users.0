Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60503D646C
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360787; cv=none; b=RYw0DU4fSrE1KLuLTQZozReaWOOzr7SaI4ijGfxkVxf/gWbOtzNs7zrcFUTQoeN/dMspkebW3YFjobzpmgJYbE95NtAqT+MAihzKculF3di806ZkxtdqCTIYHbS++dGr1+59pdqdtWzfgQFcOmeavhXtHh+oVveGGrCjS5yms6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360787; c=relaxed/simple;
	bh=SDkZd5PHcdHIVHpfcJiz8ApT6TmnhVaboQYPe2AO0yY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOH+gSjE1Frtv1m9dLGETgbSXpjsyQqQTTN+WAFNXUbziKnbVchRZaq1Q9wdUknj+5MSGny2/YFeohif6/emZxXaRMv+M30qe+zsoCbQqCZD+guer9YcMdDjXicRdppf1hI2XdSV2+NlbAGJ2FY2/f/D7p1hF3BPmYQJOWmeXEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lcy/iKYE; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lcy/iKYE"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2de07c12745so36433884eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360785; x=1777965585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8mOLykJWwD+iuOSEzySshJ8svHD3lJcsoFwbvIkpO8=;
        b=Lcy/iKYEIX/9mzsEcgsiKo10lLvR+JNsQUM79uU9AH08Tk0LcL1Rzq0SfIBEQOFT4n
         bNvATGukghwIu930eWraPhlhxYQZq7yLBaRp1hgJolpsuHkFs/FC7vF2p37078b9uzfS
         YSASUyo1aXVgUxyPBmLi4pyQJtDxUVGaNXi33nhYLEhULqGKcWeloj15v0zGHg0Rgyj/
         lMGUruxGX/DcuHkMM9OR0tjIbJ9YwgcTBBXthcHLuP//5ISnt7/Ql6m3rpYR0kcB1AGo
         KFeTGbXQ+yjDRgMQvvIn8rFyL8IJo3YkS28Cjv7YwNXjSwSUVNfSs7hdkDaeGVHMCo8F
         pNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360785; x=1777965585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8mOLykJWwD+iuOSEzySshJ8svHD3lJcsoFwbvIkpO8=;
        b=nTmX1K0ROLQis483U3IbM/35XjwZR1X338XdbhIr9chP4KWun6Y/d98uxGv0e+5quP
         CXQeRg7e3L+nfbgJHl3vSbQwhUyKVwP76M9wo9ySVHIDblm4krTVplLsjCC7J/8xUQu+
         guOHEe8nxMXh1pMHl8zloFB7Gf0IwcW13/Mr11XSvvCwxi8LSigIj/0Bon4zh0cXuunq
         YLzCxYUZBeXfrMkFbKHG3dyJ3XqtN3/h+RhT9z+5YkWHpXOswNFXjlRiBFXQMxAjkmzv
         n3rVSJ9iflbQbu9oZ6bmDfwaKRoKxkcpMMg5wqCQhDV7ExiX72MvR0t4psf700AJ89V8
         +rQA==
X-Forwarded-Encrypted: i=1; AFNElJ8189OYG0Tetxi7yQDKflVL+0odgMpo2pp1DCNuds+reNa1NVVGdBkp2XNwviUt9loQOGk7ut1z5VAdGISSCUhI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3hJ8P6g6BvTYP9fBqbRahDpTE+MBVt+FBvzg9lOlL1Y+v+FBI
	wsz8OXqpQZrfOKHL5l43XN7lSDFroec6Ud4CmevUVfJyp0tZZsHfhlul4ncMcmPTGBgXImwnRT1
	Op8c0QmB5ww==
X-Received: from dycnh13.prod.google.com ([2002:a05:7300:ce8d:b0:2dd:3fe1:f5b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:3e18:b0:2c5:50fe:c795
 with SMTP id 5a478bee46e88-2ed0a1c5256mr981566eec.29.1777360784853; Tue, 28
 Apr 2026 00:19:44 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:18 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-14-irogers@google.com>
Subject: [PATCH v8 13/58] perf python: Add wrapper for perf_data file abstraction
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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
index 61a7ee1f4c2f..c002181d96f4 100644
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

