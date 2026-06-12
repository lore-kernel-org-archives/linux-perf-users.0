Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EAF3D300A
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302376; cv=none; b=m64z+OdOVPnfLXpdb3iDr3S5Zllk9jcmqan/Z9gIrNr/RAShuqLekxfT2G1h49Wm10NL2PuS6tEs8c5jcce942OFRFzFDuj2TAx47kVTr4i3D7XlwstBrkwUhM0W5iRjFVxf/Onrg8SZuulmNcZ3Rlw49Y0Z7IPGeDVGBtbPLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302376; c=relaxed/simple;
	bh=qyK4fXvdu95AkC0VQJx5MW1zOkKVez0W+PT+CsRSyyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rBniXTUkDOfDcLEqTVi9IUi+pxi+dpAKcV/8XoOP58oPZVn3gJudk43mPlwnmu2CMxHL3BuA3NeEzRiyAbu0c4yD1OsXYfaVb6pb+LtxpvjVZvvFTVKsYtJi9cY/eOQ9N6cf0RZ3Ub17PNrL81a5Jt2bOZl3XEn+p7VN5Lv0CNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBZUKLZm; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBZUKLZm"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304b8d0ee63so2460235eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 15:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781302374; x=1781907174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pky8TKVHcYMbaxaWIeiFp5Y+wCfhYAg3ppeOmUygJ94=;
        b=UBZUKLZmKApJcqclBirfMJGQxx6iNc/98SmP9D0O+F/Qr5O5BojnrdTKuXPUJJhkFc
         LnTE9aza+eIYXNE/nlo2ayRb73tmSDvl4pkUHcvsn5htk8py2ZQwS7X+52hRI6QAAUFB
         riGUmmrNnMYeNFLKNUMJ3lp22JVh26AxInmSkOyVjvb3YQXVxyEOag/SdjNvojsp/00H
         oWz0uCiRT+z9O5tF8QBu6DGocvHVZ7r9yafcseR2Ceaxhe/qgqOFHvYkFlDzgH66v+G6
         9JHl/b+tMRYwroKTVY5bpG0bzWf8v64VfciKU3xhlBy03i/C3iEqJuy65nXSvSfRFD6R
         DhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781302374; x=1781907174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pky8TKVHcYMbaxaWIeiFp5Y+wCfhYAg3ppeOmUygJ94=;
        b=YfGN2T9sSK3mM5bOjle2Fl1/5+i1fKgGEIh2UnoiWnmzNH+KzSACacAk6HKhC0HvdW
         MUy0FKZKzdtWfUHy3Cn6Sns4K4Th+UOZoBiLPbQotFJmxLBRXO29Zp5odI4eKtxl5qoM
         GjxzJNq6Oq02ccUqHOsDWVuKdlY/T9X6rH4ZQlyoOBmmwNYLct9OOAwmo80MD1J8CHtl
         BYnIBL+Ug6wzbdQGzDWQOnrmfl7ja1pod73/KOqpAbLI870aR1KbzvuZBNlHEOSlyGh+
         yWM27KEehLjuYwoRRo8PpNh4QE3kzuphB0vy43Oj2mbmPCqw/W14SPiGSXIMwF980sRB
         03pA==
X-Forwarded-Encrypted: i=1; AFNElJ+tzsEqZ2UKJO52p/OWVV7/FvrGcnKF7g3PJianl4nF6ODdwmp4OndROuYR4VstHBm0pNFa6NcTzeKomvdQy5ty@vger.kernel.org
X-Gm-Message-State: AOJu0Yx61AfkZN+2qxVZit15xInepm8hy6OsJwyZBBuodWUcPe4Qt4lL
	D7lDwRfKYP2z2YZCx5N/ztZsxeC2oFCZzGLZ//nmdN/l012PUr3spKpfMFjuCGK59WUjoawFQ+d
	Y5f+0kNJhow==
X-Received: from dybvh3.prod.google.com ([2002:a05:7301:52c3:b0:2d9:9fa3:5aa6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:9c8e:b0:306:f474:738c
 with SMTP id 5a478bee46e88-309367670d0mr869109eec.13.1781302373664; Fri, 12
 Jun 2026 15:12:53 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:12:01 -0700
In-Reply-To: <20260612221211.1221305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612180956.1105352-1-irogers@google.com> <20260612221211.1221305-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612221211.1221305-10-irogers@google.com>
Subject: [PATCH v15 09/19] perf python: Add wrapper for perf_data file abstraction
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
index e9057536bf5e..bfd50f29049f 100644
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
@@ -2460,6 +2462,121 @@ static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
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
@@ -2522,7 +2639,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_cpu_map__setup_types() < 0 ||
 	    pyrf_pmu_iterator__setup_types() < 0 ||
 	    pyrf_pmu__setup_types() < 0 ||
-	    pyrf_counts_values__setup_types() < 0)
+	    pyrf_counts_values__setup_types() < 0 ||
+	    pyrf_data__setup_types() < 0)
 		return module;
 
 	/* The page_size is placed in util object. */
@@ -2570,6 +2688,9 @@ PyMODINIT_FUNC PyInit_perf(void)
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

