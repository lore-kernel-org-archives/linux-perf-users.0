Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C49E3C3C08
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781328471; cv=none; b=sCBS2L8t4KAmyUBwMSxMmyVsoTz11eQo985VNebSpAotmFN9/LY+CHP+R8HfrYMDKfQom+YI5d+NtQtiAphVp7Ut2JyOpOzdYcZdXQx8o1zF6I+xokM4p5v9j2r8d2NeTLYR16QbZgvOslbfLX9z5ye7SxEff9AGU9alZejLLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781328471; c=relaxed/simple;
	bh=kPS6wNLPXRyXxP5HXB/lH3uNZYt+f65bab32Pw3ek1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cQ1Q9NJdpj45zxUuxx6H/EUt7SWb13YpXkkmmvmbtV6BmanzmVasiif8tNTCoRIzCSwdIFFt7AwEiAmfkfLHqS48jH+KnaKiexfTcMqmouoEffTz9jVc0a3nzvQYvOO5ZVlmYm94Gk7rxDdY0K3MXMYrrN3IlxneEWvCSYGv660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q1MQ3w5q; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1MQ3w5q"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304dd917645so3525622eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781328466; x=1781933266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z5pBXYo6XfMNZKCpgiF1LJlAx8VzG0m780zpTv8X+M=;
        b=q1MQ3w5qbbAAgNNzTU4mXZA/nEUfDd1N1owhChEEnsXx7MSmt+2TbDLtIQc6SiS+dM
         mgrNCbiDeALUqxVWA7WcE+beTECqp2zg5eHI+kFUXxS+AcESPopIVpsKrav7YskzkPEE
         UsEuuKeBdte2p3fOm5Bgz9BkGqdjCtUjR1sojZzvvjKf3LxRVISeiy72yxL3v4HlUvDc
         x2gzpV3NffjZ0EtIDisJ0X1E9o1fFRVcMUcMe2NBv4WPgEK+jGatgB7ZcOqMLfp1d7aA
         MO3YiCl0NJzOGoPktY5nBld0e+Ra54aOejqf6EcO+b2/QQG7x7zp4p/mSl6LieXGUElA
         s0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781328466; x=1781933266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z5pBXYo6XfMNZKCpgiF1LJlAx8VzG0m780zpTv8X+M=;
        b=ElaCrdbVU6DMcr3NKS1hPdtgFTLc6O0DLKVw/P1wbBmc85x/INUfu+Gbg+AzIH+kXz
         38xPIyieyjfTyNVLTmse08ySyN/tZlYPH6PI8+nS3AGVdxUymTDZjbwTfgzGd6dXtTG9
         i1+7JSL7CTcMEc0/1LwJnm2AscwrSCdg2TlbVlR4+Nn1d4Y8OeObcA1srp0TA9uDjH9F
         GRX+a3exWc3XvktlV0H9DZxmi82jLtPjc4Mt5/MBZZQyFMXU+CsrTC1xG8HvB9nkvVKe
         9zenf+DVk2pfA95IWkSGlr4TvzDEH4f+OkrufZbKdI93u95GUHj2X4TYyRkF1EDhHuDL
         iJ8w==
X-Forwarded-Encrypted: i=1; AFNElJ+zbT0cL9l016Yea8dpeYegT89gICSetS3QIvMZtoVFkIWxzBXnNwuEM4hBMsRY4aBBqexsXIMavoQ2xZVg0Ocp@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1Yt/bEufxSSA/gZmtup4J6M/QGHqyuVYlzRLlMQY6z1pAkQL
	EBMaC4hb3Gz2mgUd5i7yOhov9nXFEJoaXf0gJAhzQTtBesWJFuJ2wCrxfaIBiu98m6pBfFEWW4T
	RbKhKcMgjsA==
X-Received: from dybmk48.prod.google.com ([2002:a05:7301:eb0:b0:304:eb73:cff1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7306:b0:304:e6f8:7cc9
 with SMTP id 5a478bee46e88-3082005fd53mr3509874eec.20.1781328465365; Fri, 12
 Jun 2026 22:27:45 -0700 (PDT)
Date: Fri, 12 Jun 2026 22:27:10 -0700
In-Reply-To: <20260613052722.1424093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612221211.1221305-1-irogers@google.com> <20260613052722.1424093-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613052722.1424093-10-irogers@google.com>
Subject: [PATCH v16 09/20] perf python: Add wrapper for perf_data file abstraction
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
 tools/perf/util/python.c | 123 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cea5fd9b5f79..31da1283fc15 100644
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
@@ -2462,6 +2464,121 @@ static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
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
+	pdata->data.path = NULL;
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
@@ -2524,7 +2641,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_cpu_map__setup_types() < 0 ||
 	    pyrf_pmu_iterator__setup_types() < 0 ||
 	    pyrf_pmu__setup_types() < 0 ||
-	    pyrf_counts_values__setup_types() < 0)
+	    pyrf_counts_values__setup_types() < 0 ||
+	    pyrf_data__setup_types() < 0)
 		return module;
 
 	/* The page_size is placed in util object. */
@@ -2572,6 +2690,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_counts_values__type);
 	PyModule_AddObject(module, "counts_values", (PyObject *)&pyrf_counts_values__type);
 
+	Py_INCREF(&pyrf_data__type);
+	PyModule_AddObject(module, "data", (PyObject *)&pyrf_data__type);
+
 	dict = PyModule_GetDict(module);
 	if (dict == NULL)
 		goto error;
-- 
2.54.0.1136.gdb2ca164c4-goog

