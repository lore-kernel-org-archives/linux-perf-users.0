Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050743E4B0
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686942; cv=none; b=FGIZjmE1Uix6zFAxmYlGHc/R4yJ+ptH0nKLor9dgN6lpdEAlQoiHRsAxvTG7rsez/JDuUq2aXZEbYz8M/eyc608egLvA0HkK6b0EyQHk/V5dS8Nqa1Clcf7f0NT01sJqcGKm7rPN+e9l2ldwVtIkgPEXBbHjhRLw0YBXRKhWThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686942; c=relaxed/simple;
	bh=hy773N83K+DDTQHFzzMyFLdUXbCTVIslZxomCgTAO7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sQdyy+P6Oj7E4cx+x7zyHolkbpTnFZLu6F/DCS14gGWyTCc52pfD/iIzlAUMr0Zo/TpXio1V9nGz9AschT+UTWvJE/F+YkX5fFcOwgOhV4QdJU1w8V97i44Pe81rSOpuFCBUjxufzHaVe/J7KajhUe0T/ZOhYACfZNjpipX5zJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLlz7XhV; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLlz7XhV"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304f1820babso2973345eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780686932; x=1781291732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xkRZrzadx99hywv7ejqiJIrnyOSG70s4V7BCHBJLtuo=;
        b=eLlz7XhVHG2KbXqvDl9+tsSVhVLWUnrChB4UHFHh61Icj+SY3rUxrqrBq/R4clfwVq
         lb1dzVV33KLk7UgyjjHonIkHg8pNtUYxjkGfovcHw5hjmss1F0AIWUdEQ6luvxuvl3NT
         zRdPoSxNCTOYOj5DkqXEOHmsaaVoBNV+f+17kd98YMhJpkHtqJLd55Lz/x85rffuNqfz
         8bmfHYRfVX/zp2VFAGyAuLbYdKVj0qmb82ILutUCOKEMsm1BY+i7siMmSCt3Axjzl0gt
         WHUkbJvkfQInSV7YXGfxxPVw8ithp+qajHgdM92N9++cJHD/W2dd1CbYHkjzG6C6cSME
         sleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686932; x=1781291732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkRZrzadx99hywv7ejqiJIrnyOSG70s4V7BCHBJLtuo=;
        b=QnzteM54X7JjalNQeqbrmfcrIyw4wITDY1TzrciYg0e+AKa9GPmZuNsGg1bqUbxjR/
         w+hdKwtJ1DL+k04kXPdm7WPASb+/fxf2oPFTu9HrW8KtZtEIllJdWaiXu24dsRBgbYNq
         euEj9IIx3JepdE29QUL5I3cOUxmyUZBclx4rwjw40WwrIg+Ulsk6fkMS1R3k8Dc7eKhV
         du41TRCJIsLaX6h2/Uzp8rf+1NLsvcYETPy8Hj53sbhd5sw5+nW6P0CSiQ1zrPwWPnQu
         grE8BX0SZ4u6KJujDx6AW2/ezzLqMu+3Yht0lQCiIzYyhywEueGBG7GkJmIdQdBVapZs
         TnoA==
X-Forwarded-Encrypted: i=1; AFNElJ9D0bn8Zf/hvq4ugVh8R1lhUSMCya5KraCfTeTZpGtQ6WrxDXQzLxq7nbp6DaI7/5Qdcns1bjwLB2biIxoV8Yiz@vger.kernel.org
X-Gm-Message-State: AOJu0YxrAuVhj+jxgONP/JVKvxFL9Xcw/kWlQYqDog+z63dcSi1fcl/Y
	orGDsemCKiogexeXxUUsLiEP9WvmIi38z52eljVoM7wvaKccSHvcyyzJF4fGL7IA+XqoLfz292W
	Y7stooGuA3A==
X-Received: from dycai7.prod.google.com ([2002:a05:7300:fb07:b0:304:ed39:7b0c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:37c8:b0:304:5a9c:644c
 with SMTP id 5a478bee46e88-3077b3cf48emr2635023eec.15.1780686931370; Fri, 05
 Jun 2026 12:15:31 -0700 (PDT)
Date: Fri,  5 Jun 2026 12:14:50 -0700
In-Reply-To: <20260605191500.2477026-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605074003.1730715-1-irogers@google.com> <20260605191500.2477026-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605191500.2477026-10-irogers@google.com>
Subject: [PATCH v11 09/19] perf python: Add wrapper for perf_data file abstraction
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
index 8b922d3013f2..5f57e2336929 100644
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
@@ -2454,6 +2456,121 @@ static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
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
@@ -2516,7 +2633,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_cpu_map__setup_types() < 0 ||
 	    pyrf_pmu_iterator__setup_types() < 0 ||
 	    pyrf_pmu__setup_types() < 0 ||
-	    pyrf_counts_values__setup_types() < 0)
+	    pyrf_counts_values__setup_types() < 0 ||
+	    pyrf_data__setup_types() < 0)
 		return module;
 
 	/* The page_size is placed in util object. */
@@ -2564,6 +2682,9 @@ PyMODINIT_FUNC PyInit_perf(void)
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

