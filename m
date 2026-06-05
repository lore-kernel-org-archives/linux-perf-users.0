Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F90480DCD
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645251; cv=none; b=auDDU0LqwhbkqGrZz6++f33QiicoGCsXwOexEd4QpyqvoQ7U4vRwhnI8oibOwnIv+1En53w6vzc64dWs+ogpDUuBLYEwVGDYagJL+HCQUxRIueZCT7m8LvlkVsfL6uH3BX9I0ApsX2tTcO1DqERQ4HRuOt5hiQHpG7AUqUDBzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645251; c=relaxed/simple;
	bh=2eqGqbCW1cMb7B0Ok76uVNtT0y/L8rrHKRd4Wz49hcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UgpXzmEqyN1G+rWHRcFJ8YV+kHzbVf1O0vjJFCgFHn68vAQD/s8mVLTXQaSJyB7r/1Jz16hAvTBSegrSZa8LmXsBcl9zRUtHq5u2/+L9zyaYUieQjXrynx2lZatbFkqZoP2Blc8GDpfAExFQbhhAGt8oc0OA7XSNIZwZ5GIK/Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWDx9Ssd; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWDx9Ssd"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304d0d0b28eso4405119eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 00:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780645249; x=1781250049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+B9cSzn8GcXcwF9wku+X/fXJWBxya5og+KBn7MXNpU=;
        b=YWDx9SsdGaF8poD24IrZE2brN6ozwCyIQ+NNnc/EPyVde51Bjpoaaw69YvjbL095q2
         nm8dkyBVCBhz++QviNL5x4JR3CNAmkT4wp0MM9zm0fc/TdWn1P0nYyiqt1bmC1WO97L9
         c+wJhz27jsENVvt1vOWnk2iR3jelLRbxjzE0cjluHPoXL87/odQd/tKxDsrp0hE7ihvB
         OcJjEr2T9Y2oswuUbGx6V+EFTEWgCGgtmzLohWw7eRLuwlfBlZtjlmI4NCh2MCxRBzZX
         5KZjZjQy1ljXaOn/dwpAFUjiEjoUevLF1k60v8407gHtdvb4QH3iBKh1eZjfmrLFa9pr
         2N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645249; x=1781250049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+B9cSzn8GcXcwF9wku+X/fXJWBxya5og+KBn7MXNpU=;
        b=T0bVleBDQcAqXSFqsjUcMx7TI1spgeiyPAYKlCS46tI1BfeNt9puTKSg6zNmJOV8dL
         iSe4OcTyzlg3KBEkbOsuiq+LVy9Z/cDbjIYEOobLlHK9y1DFE+8aFCKdtduNvIQM2+O8
         yt7mx954Q4Co5U8J13MahNe1CuRWgMHrMFklfQc+Kp4+0d8ct4RWkIMrGsJf8VTsXvRu
         T5Q7d4YCDmDM1hK9nJfud8N1v7TAha6x08KzL9tXftMJ4bfLMVom2gghdzPqVgWldYKl
         z4ip0/0Ku8xmvLrOoUYlogbYSWHAmj6pNkq9vwU3XRSvGPWqy8XtmbRR0OPLXmP9/vHh
         uvjw==
X-Forwarded-Encrypted: i=1; AFNElJ8m06yoripfxvK8LVV03ZMHg8ioP9DetiHSPvxTogILH/ka9CnIdkM5ef0nROgr1PsM82KBo233fHf+BuwfNojE@vger.kernel.org
X-Gm-Message-State: AOJu0YwwVOelprBizC8CrAb/hXHCFZHr66iDmKo+9GQU5QH6ewxC1KL8
	pPhzgEl/6R/IlDDMHKhSIy12diPawiWZhCXLxv3CFOLveqd5HdcPKVz/6Yh7rKFGbAXHpxqgcEI
	ibBld67Mu0w==
X-Received: from dybzy19.prod.google.com ([2002:a05:7301:e113:b0:304:dbcd:d155])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1010:b0:304:c651:bdfe
 with SMTP id 5a478bee46e88-3077b753011mr1154696eec.17.1780645248721; Fri, 05
 Jun 2026 00:40:48 -0700 (PDT)
Date: Fri,  5 Jun 2026 00:39:53 -0700
In-Reply-To: <20260605074003.1730715-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522220435.2378363-1-irogers@google.com> <20260605074003.1730715-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605074003.1730715-10-irogers@google.com>
Subject: [PATCH v10 09/19] perf python: Add wrapper for perf_data file abstraction
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
 tools/perf/util/python.c | 122 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 8b922d3013f2..4c09a22d3521 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -6,6 +6,7 @@
 
 #include <linux/err.h>
 #include <poll.h>
+#include <unistd.h>
 
 #include <internal/lib.h>
 #include <perf/cpumap.h>
@@ -14,6 +15,7 @@
 
 #include "callchain.h"
 #include "counts.h"
+#include "data.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -2454,6 +2456,120 @@ static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
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
+	if (fd != -1) {
+		struct stat st;
+
+		if (fstat(fd, &st) < 0 || !S_ISFIFO(st.st_mode)) {
+			PyErr_SetString(PyExc_ValueError,
+					"fd argument is only supported for pipes");
+			return -1;
+		}
+		if (!path)
+			path = "-";
+		else if (strcmp(path, "-") != 0) {
+			PyErr_SetString(PyExc_ValueError,
+					"path must be '-' when fd is provided");
+			return -1;
+		}
+		fd = dup(fd);
+		if (fd < 0) {
+			PyErr_SetFromErrno(PyExc_OSError);
+			return -1;
+		}
+	} else if (path && strcmp(path, "-") == 0) {
+		fd = dup(0);
+		if (fd < 0) {
+			PyErr_SetFromErrno(PyExc_OSError);
+			return -1;
+		}
+	}
+
+	if (!path)
+		path = "perf.data";
+
+	pdata->data.path = strdup(path);
+	if (!pdata->data.path) {
+		if (fd != -1)
+			close(fd);
+		PyErr_NoMemory();
+		return -1;
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
@@ -2516,7 +2632,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_cpu_map__setup_types() < 0 ||
 	    pyrf_pmu_iterator__setup_types() < 0 ||
 	    pyrf_pmu__setup_types() < 0 ||
-	    pyrf_counts_values__setup_types() < 0)
+	    pyrf_counts_values__setup_types() < 0 ||
+	    pyrf_data__setup_types() < 0)
 		return module;
 
 	/* The page_size is placed in util object. */
@@ -2564,6 +2681,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_counts_values__type);
 	PyModule_AddObject(module, "counts_values", (PyObject *)&pyrf_counts_values__type);
 
+	Py_INCREF(&pyrf_data__type);
+	PyModule_AddObject(module, "data", (PyObject *)&pyrf_data__type);
+
 	dict = PyModule_GetDict(module);
 	if (dict == NULL)
 		goto error;
-- 
2.54.0.1032.g2f8565e1d1-goog

