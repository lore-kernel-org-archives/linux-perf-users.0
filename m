Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C813BB13B
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562648; cv=none; b=lP5KyhUA9MYmGTy2r3TBRQ8t9wr81G/7dVek9k0Zy+5wx/iVv2iJDXDuvKOTeFvmEIl867xlV9UO9EVVquPIQinkTOxKVGU9yS1E/gjZulnx7ytTmqpfdw+SBPzBwEg7h82nEX6Rwy/j7+vPcW0Wrq3BjKutihuLcbqaPHDOM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562648; c=relaxed/simple;
	bh=BZVUZS7RauWlRhZV9cWP8T6E6kJsqVmLF64NaEjC5kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rJdnomMAOvLGEPVMEMIDivuWBelzPDUVi55G0dtKdsZvbWDtkOXir811mTrVf1DdnsDr1xA5gpxZ2bzVG22qop9DRloIjkYroeDHwDRg1jdsEBNBsHvZ0eLNgHaPWsFlwpSjUBFAQos4Ty1UijRaFDwEByBz8fgDsuk/5hpdhi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCh/uZ+O; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCh/uZ+O"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304f1820babso5877158eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 15:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781562644; x=1782167444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1iCDk97WaJwsoeBupTQlphjiTMgLvJ2ZxhyFknylKk=;
        b=GCh/uZ+O6F9uRNP/lTxJJ4zs3xXE000FvE3uuSUmDky+24UFbtkhHgP4eZVDVGxitv
         7Kx5VCdzVX6zxW657wMIaZcBTF5EarzWNv+Ycu70yBgxjZQ1KJsDWLQ0DSJGiUR81iHB
         1294h2YpR6hLvLg3EE+yYbcReTU270LirrUjr5wPFSUFKpe+IBcNXVjpJ7MtJ3vabiuB
         l5M4Di4vYG/G9io7nrjF8OWukZn4mC135yCEQFqoeffKZCx2RgWt0zSXGtCqHnUV9pkL
         wIDzHovLK8lnnPtvVp6iJNHJDc+MtAkRgEAfkWHPTShURb86vvAxdBzpmjTqS9ZfSL7w
         Nu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781562644; x=1782167444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1iCDk97WaJwsoeBupTQlphjiTMgLvJ2ZxhyFknylKk=;
        b=FEAFIdpA2dPnOFzS3omyVzLC4XWOfrrJWPUM6GM1NLYB6nz3RdpLZJe3So4BBE9+hz
         T2+VXPFAymm0Vh+Rc2jtMMhPc5dopjZvMQ2SsIiJYB0+Cx90i5V8FvMMhGmHCqYgYOvz
         d3Ls8CIaDiIwmvAfoAtgVS5DXvbTx+WNz3IKt3Y2Of2Uxt0bX/vQKmoI6YLos+XFTnGA
         nztYJ4bvPoGZdf2Xh1sfZPRHII3FNM/KfHdNGv2giZnmIppdxzBRol7LKuB4jvjRp7YH
         TyLkGk5hedeETCz5Bj1tlXu+8rHax0sx+NaaQPXr46Zk2Jicnu2XKCDDfRKxsqo+VLr/
         8ebA==
X-Forwarded-Encrypted: i=1; AFNElJ9UpxlL+wVq+Ixsr5/gvHAkLBRYvbVzRar1x/tunBPos6CWQjYT23TZcVwhNrSCnjtO+JhPUp7Jtq4TDuIqU453@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGnfxwJlupozf3NFt57JCqzOkqLrbmPLRfi1kYm0ank29qbq/
	ikC3xkbbI42f20QLjlaNaj0SZLhVZmMTK594QRvZuzYsV9dwsQ1kL4UkOMD0vXq/2La+2gOhJrK
	nEUXJtvQKAg==
X-Received: from dybmj48.prod.google.com ([2002:a05:7301:e30:b0:304:ec70:1029])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5f10:b0:304:5a9c:6479
 with SMTP id 5a478bee46e88-30ba59cbce2mr750639eec.9.1781562643924; Mon, 15
 Jun 2026 15:30:43 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:29:59 -0700
In-Reply-To: <20260615223011.3873955-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615223011.3873955-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615223011.3873955-10-irogers@google.com>
Subject: [PATCH v20 09/21] perf python: Add wrapper for perf_data file abstraction
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The perf_data struct is needed for session support.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
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

