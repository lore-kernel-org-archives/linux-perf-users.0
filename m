Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB632236F2
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139371; cv=none; b=Y0+iT3oyP97zIKkwjvoch+NmlNyyWFvE/9tuYmlo1394hOSA8Zi1AuRyjCS547f3VEb6LslIhY92sx76PvaHxamZLG2/Vol5wwuch23Qb48o5KfOgnaKkujs89VR4kAgixXToJGzN9Tib4XYejcQFWCdLfNpAWA27vhdmnzHZus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139371; c=relaxed/simple;
	bh=gL7zg7JTJOEaEfnIKsA+ZHMroZi/N8zA92GiSrJF+0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r7LfpfASgU99BWab023n0mDDpbmqw+jYKoxa5W3EBh6BLHMkWz1p3M0OlnmThO016CAIE8CLjHn6eLLRJ9B4so0pTPNexwJcguygPEJC8jninsaZvg5k23DP5D0MKNuWQ9DtVUKGthl7vCeEckcdJs1XuB4YDyh02r1Vq2qSAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iiWT6qiC; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iiWT6qiC"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c16233ee11so12313806eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139369; x=1777744169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wM2h5mdu5BIohf7YOf7SjkCuYCdrfaX5/l3G92wMaFw=;
        b=iiWT6qiCecU0o6kzHUI4utijx4WovqlDZdHXppYfi3tiRM+z6Mp9fPhhx8EkAo2oDa
         rC8iSl80PufVNrusMYQhUfXvuN2XX2KI5JBgJCp04XCELLLbofEGdUjCMz+DiH44Ib5l
         3h4SWNI63IVtR90XPhPnvmwl8Nr3PYLPHJTD4x3hQXp3q+2PMpwcb7S2tfvgBioW076y
         lqElKK+IhV+UPnPAASKBmfypsUVKzeK2CscB/Y/rgxcsS0+V4RZQEi4f6JNufgkMGRsF
         gP2xUMRCIrcyZcMLIqXkMxe7rtlniCY7M5x6nFXHBYWf9H5fNjTJwCHvHS+iWFjjOkKM
         Ou0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139369; x=1777744169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wM2h5mdu5BIohf7YOf7SjkCuYCdrfaX5/l3G92wMaFw=;
        b=PZ4YveqK/g2/xXjXMJJ0MvwyI822yOqDYEm6qRrtqr4sCX5UtHe/VI2xtTeGVwtHd5
         Mo0av6RbDVTsxhq9LHFfoVW1Pu/1e/8WkIvz8DbNftS8DffKSFhXSXSMH3tK0i6tK+Uk
         tewfVsuLOitjJ3qSCDLfhBbNbLsXmHn9V3im0abAioCx9ChgcDm1aWb4PybfZlVhSuBh
         DcsGJD9kBJ6aF5gURGxgNUpsYXe7Wfs50gwZhgWHb4Fm/0AFFeTCkVbWeLJzd5K2+FCK
         zPFMmYBmvjTg/UzPmMAmH4PyqJ6pyB0k/RfFRKAcMxYF+w4S4+rQmfHAaKbWalZcWx5X
         dEUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8v8tIkm1gG6Pe4j0RTUVwceqb0vHJy3kycQkvUBiIOAGFaUWMZIpmthf8bjSljx8GPGzZkgOwPdibBJXNTydFr@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/GmvtjCVXewuH3vTZyE6du2V/3hLV9JXVSHeQbC87h+xRw35
	hoqwBwcfcIO9YUgrHz3B6MlagdaX/cboHXJW+ipoZPlP1XYMpZTH87cK1VcBq/lcLok9BvH4esn
	znDMKx9LWXQ==
X-Received: from dybbs6.prod.google.com ([2002:a05:7300:a206:b0:2df:75ae:2719])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:230c:b0:2d2:c60d:4fe5
 with SMTP id 5a478bee46e88-2e464ea4e10mr18084168eec.6.1777139368785; Sat, 25
 Apr 2026 10:49:28 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:12 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-15-irogers@google.com>
Subject: [PATCH v6 14/59] perf python: Add wrapper for perf_data file abstraction
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
---
 tools/perf/util/python.c | 93 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0424290f8b77..a2cdd92e0548 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -10,6 +10,7 @@
 
 #include "callchain.h"
 #include "counts.h"
+#include "data.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -2296,6 +2297,92 @@ static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
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
+	pyrf_data__type.tp_new = PyType_GenericNew;
+	return PyType_Ready(&pyrf_data__type);
+}
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "metrics",
@@ -2358,7 +2445,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_cpu_map__setup_types() < 0 ||
 	    pyrf_pmu_iterator__setup_types() < 0 ||
 	    pyrf_pmu__setup_types() < 0 ||
-	    pyrf_counts_values__setup_types() < 0)
+	    pyrf_counts_values__setup_types() < 0 ||
+	    pyrf_data__setup_types() < 0)
 		return module;
 
 	/* The page_size is placed in util object. */
@@ -2406,6 +2494,9 @@ PyMODINIT_FUNC PyInit_perf(void)
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

