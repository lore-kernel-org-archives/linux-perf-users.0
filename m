Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F83A873B
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562661; cv=none; b=DZnf5A4B9WY1BJCDFH/WYdAPjJ29QrBLfqTMwvAJwycUkWeg7JG2+IGyuQjN/n+XmtAo1EIIeCpcv42ITIrslZna3mblnyhpK1Jswfo84OQPU9AVexRhrEly0qd37Up/GhlS9tiVl9FtRvcOnDZg34vpH+dOo16ITQ8xczO4ihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562661; c=relaxed/simple;
	bh=ugjh2Ji5JszZPl7RY1Khg2UwWX7UG0MmkP/3pOaPdSs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HOQPUj+NL6P6Yw4Bdq8pe85jcb9PI0We4wOPlF83SPVW+elviTI0W+OuZiGtf2IF0Y4YIF6QbQGPMe5z2kxvOqockgxpCSApWLOGjeELa+LtLFY1q8Sv8aRziavjqkOvop+yO1+hTwkHA39NuKoZnBZJ032p0rl7Al7X/YpyG+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEiSPHZM; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEiSPHZM"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-138acbc0e69so1135841c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781562659; x=1782167459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1k4LtxuRX1KAiOjJBVofrvhJI0JHdLwLNq9oCAztbI=;
        b=GEiSPHZMz8NqqvjpH8+58rxGkdMyDyJLVrbsA27YUTfC1g5NMmjE3lAqhcNZRFYngR
         QCqqsxbFEcnJvG+DYp6nKVvdQeLltUYdIlpsOKaKDciooH7S8t4saREpdD0N3Lcw2tW3
         M02RTqXy4ZIHz5bTfZN8Rq7nQLkGo0+ODB9S7cXVjcSadzxIJiJMOld7R2aAlK8+Y+Uz
         yLbXXN3QHISR+tDi5tRwgHj9gWTjKrdPDF4yE8ZLVr3n5jKlrI0S08L7TNpGdVbgm9YM
         olp9G6k/w+Ap2G9QNpCQiuj6vXQvpua4KbM1LmpyamsOlc7uZz6zsYpKgiNzXvEIJZoO
         ozCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781562659; x=1782167459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1k4LtxuRX1KAiOjJBVofrvhJI0JHdLwLNq9oCAztbI=;
        b=YrNg5yBZre9QIlmaHFOcxXNARH1dMqhhljcWTG6+pwcC11wD5JjqoL46Ie2IO+XwsO
         CmSPuUDoJewDen2WNI2zs/rQQ0jMJ5ImfZNmLWWhIlaj+lv20e80E5QVB0UthOJd6PRk
         llV7Puz+ArrkjTKpgRGY+vEafEWcOjCY35h9wL3M3gMwnkkfjc95C2oZhCvtVFuzq/Yi
         v94Pc4fRSsnB4HEt+XojjhKOGkdPEbJfYRpuhSHqDDFFJkS9wojoHjcEb3HDJGbW+YBn
         /tieccKNO3j1R8GsonhELytK6RetNQpo4mIN4bjdeLObMHPao/FXSkQHqEr6qMLEcG1a
         diYw==
X-Forwarded-Encrypted: i=1; AFNElJ9zYd5RhBeo7fhwXruIbb/z56wbAO1qZ4dpZHHwpKHRoT9UvVy9043bQKgWwAyHCAnPHGfpQRBnu4ODK9Nxkl5q@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/bTWJUZmDV63xNVWXRqO11d9PeqvS/ejTdJ5pCuKnrijXeh7h
	6+R39qN+WEXkil0ciPbJHRwfTjJudz6uWKO59rdrkqy3vZUE1OK8L8pyv7rxvGfRCY3hnyZyg0j
	+t/1XGaSJrg==
X-Received: from dlec14-n2.prod.google.com ([2002:a05:701b:428e:20b0:136:23d8:d537])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:90c:b0:12d:d972:b96e
 with SMTP id a92af1059eb24-13985f08537mr479848c88.20.1781562658499; Mon, 15
 Jun 2026 15:30:58 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:30:06 -0700
In-Reply-To: <20260615223011.3873955-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615223011.3873955-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615223011.3873955-17-irogers@google.com>
Subject: [PATCH v20 16/21] perf python: Add syscall name/id to convert syscall
 number and name
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use perf's syscalltbl support to convert syscall number to name
assuming the number is for the host machine. This avoids python
libaudit support as tools/perf/scripts/python/syscall-counts.py
requires.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build    |  1 -
 tools/perf/util/python.c | 48 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b22cdc24082a..cb180dd77222 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -75,7 +75,6 @@ perf-util-y += sample.o
 perf-util-y += sample-raw.o
 perf-util-y += s390-sample-raw.o
 perf-util-y += amd-sample-raw.o
-
 perf-util-y += ordered-events.o
 perf-util-y += namespaces.o
 perf-util-y += comm.o
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 05691a513184..c5f567c15cc7 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -21,6 +21,7 @@
 #include "data.h"
 #include "debug.h"
 #include "dso.h"
+#include "dwarf-regs.h"
 #include "event.h"
 #include "branch.h"
 #include "evlist.h"
@@ -40,6 +41,7 @@
 #include "symbol.h"
 #include "stat.h"
 #include "header.h"
+#include "trace/beauty/syscalltbl.h"
 #include "thread.h"
 #include "thread_map.h"
 #include "tool.h"
@@ -3957,6 +3959,40 @@ static int pyrf_session__setup_types(void)
 	return PyType_Ready(&pyrf_session__type);
 }
 
+static PyObject *pyrf__syscall_name(PyObject *self, PyObject *args, PyObject *kwargs)
+{
+	const char *name;
+	int id;
+	int elf_machine = EM_HOST;
+	static char *kwlist[] = { "id", "elf_machine", NULL };
+
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|$i", kwlist, &id, &elf_machine))
+		return NULL;
+
+	name = syscalltbl__name(elf_machine, id);
+	if (!name)
+		Py_RETURN_NONE;
+	return PyUnicode_FromString(name);
+}
+
+static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwargs)
+{
+	const char *name;
+	int id;
+	int elf_machine = EM_HOST;
+	static char *kwlist[] = { "name", "elf_machine", NULL };
+
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "s|$i", kwlist, &name, &elf_machine))
+		return NULL;
+
+	id = syscalltbl__id(elf_machine, name);
+	if (id < 0) {
+		PyErr_Format(PyExc_ValueError, "Failed to find syscall %s", name);
+		return NULL;
+	}
+	return PyLong_FromLong(id);
+}
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "metrics",
@@ -3990,6 +4026,18 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_NOARGS,
 		.ml_doc	  = PyDoc_STR("Returns a sequence of pmus.")
 	},
+	{
+		.ml_name  = "syscall_name",
+		.ml_meth  = (PyCFunction) pyrf__syscall_name,
+		.ml_flags = METH_VARARGS | METH_KEYWORDS,
+		.ml_doc	  = PyDoc_STR("Turns a syscall number to a string.")
+	},
+	{
+		.ml_name  = "syscall_id",
+		.ml_meth  = (PyCFunction) pyrf__syscall_id,
+		.ml_flags = METH_VARARGS | METH_KEYWORDS,
+		.ml_doc	  = PyDoc_STR("Turns a syscall name to a number.")
+	},
 	{ .ml_name = NULL, }
 };
 
-- 
2.54.0.1136.gdb2ca164c4-goog

