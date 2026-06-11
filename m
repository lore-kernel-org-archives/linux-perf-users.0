Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA22D4C0427
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198328; cv=none; b=GYThiqbAtH1issYVmi3QqgZR3CbUEJMoEar5PzZ4TDUWDRm1Yl2WCs7mjFF6rSFY10sLi+G/woNRSbUOqLnS/d6BvPUl2TCkClZJH4O4M1vlWz6c5LZwOfRy+qA5q0M4Wa2Qmd/Gm9NmMLUeZP+cesBD5vQC0rDrxV4klSAHNQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198328; c=relaxed/simple;
	bh=jl+WG8kNwJ8YSROsIalx5WV3kP4NSWzelHAuzVDy1ac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BVRh+ES6pYRe28/UBdqNfthAJHaAKlqTqD0g4dTDDek1a1/IfLRCeQPGEphIE9BqGy0E1NNevNaAbsvQ0k1l6P1WWyJ9XdSvMVxzJhxd5VeG2ul2Wsfz1Sgaeka2DypGYakmAM79d/GgOKLFqWzrnIDX/MPnUyTmhDtfUpOPxrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZVTx93B; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZVTx93B"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304d8613efbso142147eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781198319; x=1781803119; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqbtn4De/S875mcwmW2jgMrab1zwK638Kbdam+OH048=;
        b=QZVTx93BH7l+crwm6k3g9Ybk2cS8MVIkii7qYVoKMtEYG2p3V8fi3UrE+h6PhQ4jse
         Ook/oWW6dMMxrzsjgDyDWJs+cVdRjytB4a9TdZcGbrN7cWKzJCJhAWNgHrKQ6Zj3OPlt
         2cD4izNnxupgROgfePcYnKf3o2XDxfd5V4aezwnwxCsK4euFf9mTj/75fxCbOVWLPG2m
         +kp2xlLUA+D7XNOcpA51xd9mbaSb+cjuXYdH1hSB41bn5CtsQxgWHvec2HJ5fjosSQcm
         sPSV5kVE96lpsCOcWm+8EkcCwQWr2YzRMPx4S9tTgy2B5EH84CEw7iw3/H4LjZKKxRN0
         IqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198319; x=1781803119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqbtn4De/S875mcwmW2jgMrab1zwK638Kbdam+OH048=;
        b=DslAhySxJYgN2eFF5h1MNUyQSlD432y/tnJ74XrEpQr0e45Fgt2og0HGCTIM6X5kzA
         nYbZsLnIIqmAKkRWnQKFIVakA9bPApvvex6Ab0ZeejCf2ORzbYzoVNGzl0TpxDEhBDaM
         i07IzVHJgEjzDILL0l1cJyAcwcrTxNFRmrrL3SKvpjsHKbsAa+n6Tw/DIi0R4sKUSv1e
         8QGQCgFFk9sJGK0C2XOz71f24ay1ZJIG6prj0wmArEXZHnckQz7hrAoAS14UfhhJkhqH
         /voklkRc2NiWNUcF/cLRr1sfBC7Zyd85/Gv3sDHao6dp7XKAHOfgSBPXbGcP6lFPg4ap
         zpOg==
X-Forwarded-Encrypted: i=1; AFNElJ/8JCQuSNN6QMUzCCCA+pGY7EMP16goYCmZ87PYEoytjOJXWo8IYhDS5e+BcMs0BaBYLwURZwm7H6CKwEJUD+dS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7NHxlI9+ruYwZaPnUZ1Do3DgCDLzmgvolenbAQL5+mQWBRBPJ
	ctcJlx87Half+L4O+Tjjwcetz4KtohmaKCkimeVtm6l2pZeNxPO5MKDx9vk+2dvG8cQm0baNBvX
	Iu67bPKNywA==
X-Received: from dyls30.prod.google.com ([2002:a05:7300:6a9e:b0:304:4f23:4977])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:50e:b0:304:d32e:65e7
 with SMTP id 5a478bee46e88-3080410037amr3034004eec.0.1781198318520; Thu, 11
 Jun 2026 10:18:38 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:17:46 -0700
In-Reply-To: <20260611171756.4008769-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605191500.2477026-1-irogers@google.com> <20260611171756.4008769-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611171756.4008769-10-irogers@google.com>
Subject: [PATCH v12 09/19] perf python: Add wrapper for perf_data file abstraction
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
index 669b65ce3f3d..c86b9713c076 100644
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
@@ -2455,6 +2457,121 @@ static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
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
@@ -2517,7 +2634,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_cpu_map__setup_types() < 0 ||
 	    pyrf_pmu_iterator__setup_types() < 0 ||
 	    pyrf_pmu__setup_types() < 0 ||
-	    pyrf_counts_values__setup_types() < 0)
+	    pyrf_counts_values__setup_types() < 0 ||
+	    pyrf_data__setup_types() < 0)
 		return module;
 
 	/* The page_size is placed in util object. */
@@ -2565,6 +2683,9 @@ PyMODINIT_FUNC PyInit_perf(void)
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

