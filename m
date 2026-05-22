Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F2238D412
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487511; cv=none; b=lkd7w2JXK5g4bw2BsL9oYKfY3fzABUsqVcXbrwpPwKhJVgS9yfQFf1gGBSAtW3LcCIupp0fqxb/roHy8unenQLeA1xu/rBXJH9k2jtsiCQxPHHb4eOhfKwHZ1QzhjPZiYCZquozvxAQTD0J3ps79LNEyBd/vSgxw+aeHT3oxTo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487511; c=relaxed/simple;
	bh=R4trJEEv81oL2VTeqiSNBIQO4kDyBrBmJ4whvqXqDUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YDTSgpgsQILHv/rO7Z2ehCqTfkBkfzxniR87nqhjbJJ78Gw5IQ1lSk0z+qSxXoyHXzSrKq1fCK8DA/mJwIeaNIjBM75yET0fRvjwpULmcysXFtUdJzKAgGmItL0W3BG0p/e80IXGhUn+4n3/mldCkkYn7eNd5zfSwgtUfuwgLZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QtTtzDIj; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QtTtzDIj"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304627c66ddso655001eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487509; x=1780092309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wzVRJfCxGadSbc6h6w850uaNmmNm6HgXxyQYTuFPM3I=;
        b=QtTtzDIjwV2JmVGMfygcx8J1vZk6Hp+Wnf9C0hmD5nq+HAcXQ9dkw+u1GBodeZgPcE
         3PtI+N7ujLcndU3nLtn7iLnQ0LvGKl123lZqCpNXlqFGw/skDmzFprLPYrQzVL/rwuGD
         Xmi7khaeI6MZZbVXApsZTDXtS9/E0s/eEsCPAPmBzEUNVBRmDOS0JV7JNS/24a2Ba61r
         i7uzr4z5MDNkhRaVZEwsvUQPH3OpdVkktHhHeXR4RlqBOFqUfyY11hc3q7FMBMpeU7XS
         0dwPOuSsKB5JWZd6aEaKF5Ba16HaMqfi1C1+7Kg7KC/fCWFSV0HwwmXy6QoBJj5Ewh9f
         A/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487509; x=1780092309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzVRJfCxGadSbc6h6w850uaNmmNm6HgXxyQYTuFPM3I=;
        b=Lz6II5x73RNBsLv0FQdGmuRltuMT8/cSS3ZRC2Tzw/lV7z2P8fpb+EeD/iUJIkFBx3
         T4Bbu26qEp3b0qjHRj2v1JzZJt54WHvS4SFD3jG6SoS7gW5GNiO65UoHous6OfXfyL5n
         dHjm+4RDERmeHo8A6xna4qiLG3MmOLktC5qLAc0sytHjBtlYGCB2OhoMxM6iuCHB3PrA
         vJ58aU7WdzVZuoZSMBmXL0liYu6AiOdLmd/McJ7k80DmP2lxrWdN3zj2FGJCa2CWQZT8
         pwazpSvtq29KoTbCXV8x14gl2tRXzAXJe58cjEzdiKyK0xdMTx/oVY6IFCsaRWtQJyAp
         QrWw==
X-Forwarded-Encrypted: i=1; AFNElJ/WvnbrCaQD9dQe6/ozmQBG1Iw5hn9J+87IGgDat9aPYQnWhO0f2HE9SIvO+LRXtZgxvH+aaGvnhkxgo85EV1NY@vger.kernel.org
X-Gm-Message-State: AOJu0YyPR98PvBMASGBjh8xcRK8YzYWuK9WYaQ+pAYblW/mAyoxr4f/U
	scx+P/SKIG/fTrt4EN5JqK5/5Zs2V6dONiaWf3lu6LWrFzO5Eyk6ee39MSgYvcAxqDaNpDhwW55
	RlFdHTYaJEw==
X-Received: from dyem6.prod.google.com ([2002:a05:7300:8186:b0:2f6:cacc:a338])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:638d:20b0:304:4f23:68d3
 with SMTP id 5a478bee46e88-3044f2446d3mr1287805eec.18.1779487508392; Fri, 22
 May 2026 15:05:08 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:24 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-14-irogers@google.com>
Subject: [PATCH v9 13/23] perf python: Add wrapper for perf_data file abstraction
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
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
 tools/perf/util/python.c | 103 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index e14e857cf90b..82adc59ecd94 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -12,6 +12,7 @@
 
 #include "callchain.h"
 #include "counts.h"
+#include "data.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -2320,6 +2321,102 @@ static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
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
@@ -2382,7 +2479,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_cpu_map__setup_types() < 0 ||
 	    pyrf_pmu_iterator__setup_types() < 0 ||
 	    pyrf_pmu__setup_types() < 0 ||
-	    pyrf_counts_values__setup_types() < 0)
+	    pyrf_counts_values__setup_types() < 0 ||
+	    pyrf_data__setup_types() < 0)
 		return module;
 
 	/* The page_size is placed in util object. */
@@ -2430,6 +2528,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_counts_values__type);
 	PyModule_AddObject(module, "counts_values", (PyObject *)&pyrf_counts_values__type);
 
+	Py_INCREF(&pyrf_data__type);
+	PyModule_AddObject(module, "data", (PyObject *)&pyrf_data__type);
+
 	dict = PyModule_GetDict(module);
 	if (dict == NULL)
 		goto error;
-- 
2.54.0.794.g4f17f83d09-goog

