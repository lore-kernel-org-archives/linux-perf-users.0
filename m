Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FBE3783AC
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572572; cv=none; b=jk32yuDkOErSR5027rnL0+KjcruCnm8P4foy0wonYH487tdqmJ5rD31hEWdHkcgjS8xLu+GFbaVZ93gHaUKjIUqqHFDisun8Skd4uXTic0S7ORYW8aEoAJgughKEUgEG2SzMkhRIycWq491YcHa779qk74sPlwqfk9IWYdeQBho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572572; c=relaxed/simple;
	bh=BZVUZS7RauWlRhZV9cWP8T6E6kJsqVmLF64NaEjC5kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PU/rjtlR5+XoskFmw9RoDz8rYM1SWy403WwgiuRM3bc46HQghG2lLPu6nE+yP8xk6COsz00oyBknzL63gtjUTyEjpTplIHgYCzas5JbRmOxqNgnJ6sQtbTBYNAm+SpeRymXhFaA1Q5g6GW/5CdfVyl9ZWG6QnaElnxD7O45FOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NglHp7oX; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NglHp7oX"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304dd917645so8301798eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781572570; x=1782177370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1iCDk97WaJwsoeBupTQlphjiTMgLvJ2ZxhyFknylKk=;
        b=NglHp7oX3Yn/a9cWUTOgqG9YXmm6z7lpxqz3Z4pSufWw9V2uVnX/zz8tWs2/uBZiGC
         lyCxI5ZS3wcfgYgpPS+eMYFoEvIVz/hEKYRGpdtK4MomF/0bqqiI9mD6tv8IGnYCB/h7
         /VFKG2x1kX9tK4j+fquOEWVy+Blen49Xza8wxoEjDQWKclbjXYEOw2JeTIBUL3YnVmaj
         a0Y1b2iMUgluobwiAmFYtbAHU4zrQoh7oxh9se3CpqnQtuqhUmf6oS3op6j1it4c2lx7
         yrLMdVVYy9p7x3AouVFkrN5y10Q687h5CtaoTNtEEkN9E044cOd7/pHA3RfwtiO+TPD4
         m9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781572570; x=1782177370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1iCDk97WaJwsoeBupTQlphjiTMgLvJ2ZxhyFknylKk=;
        b=SG/CtgbKvsSmo8+mB49FbdIolTGTqU7vwVuJ51dmVzznkCB6Z2cZ4B7OuIAOuR8eZG
         FQMn1i1V+ELJ6OY6w1pO/vrB+PKAvLgSA+rzwOHacDoRh2/8TFSygcVTSWbn2FCOAky3
         ZofX/Gx/ExQIQNd2LaUXi/lyciAFWkiccAQXz5jBGQ51BtY7hcDx/4ULzFWZ7EfkHncU
         mueAmKP1+5Rih4zIbhb3bcfZnJLPmdBQoQsHX6vGtJ2/WHojwHnVDgMf/tM169O8VHye
         iijPVLEcLXvHZbpowkqQtw03SkJL5uRm0ulf3S9y7zxGOw9lQVIQVRvQyqQTYIZU4e9e
         zpCg==
X-Forwarded-Encrypted: i=1; AFNElJ84TgR2fT8cgzlDm0/99r1zI0Xys9x2QX88eYNOUAWdGINynZq0/I7JHGPilyA9G5j6KkPrDBfxAHr0ukW60CbW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0kvMehhetd+xE0fD9gYOz9XFDo3RjVlAF6F0xeK5LhfdZtwtA
	qbHNqkgoqwa3YVPHdAOQY3BzYEnQ0LOTSj3j/5PCXsLl2wJVWdfnVzGBKsHkdcsvgvM5UoBbHp6
	Y8nFkMosqfg==
X-Received: from dybmj45.prod.google.com ([2002:a05:7301:e2d:b0:304:e5db:c51d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7255:b0:2ed:e12:3769
 with SMTP id 5a478bee46e88-308200d684amr9111754eec.31.1781572568996; Mon, 15
 Jun 2026 18:16:08 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:15:31 -0700
In-Reply-To: <20260616011543.4037138-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615223011.3873955-1-irogers@google.com> <20260616011543.4037138-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616011543.4037138-10-irogers@google.com>
Subject: [PATCH v21 09/21] perf python: Add wrapper for perf_data file abstraction
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

