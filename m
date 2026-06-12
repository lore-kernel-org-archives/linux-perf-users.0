Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0973EFFC8
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302389; cv=none; b=rjsVdkxYr5035orRDmNF3cDHgKvk0fd+Qk5McPcOAO+FC2U/XpCPxBiPhF6TDtFXVgVD+jd9ZjDwE8jyQxaDMogBu0oAw3AhUCry4lutrkM4f0H96jHA7HGeCWN4XPUECgNZlhXnfQd0Do2kZ50bBntpyWHYqatA2FrfqRYubeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302389; c=relaxed/simple;
	bh=e+QxyGebBI0MOFBhBuWIbrMuUQVVTwuiU7W/IYD81Us=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AlJfmILdHA+IIRw61EvbErN1Bn8OofPfg/ijKQPY3sdyMatcQhrjy5kd/u3/bXdcuGGlGSPXOxBhGEWC4ejwUq1DQ186cb6HtUBRatT3tM2ZsJglcqX7dtHJTOzEwCxLKD68r2eJ1gJOcD87A8/cEruqXKf/4n08jzKoUB7hz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULaAGpbe; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULaAGpbe"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-3080bb0267dso3139220eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781302387; x=1781907187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZXBwL8IC//gBDuxDydS4Px/k4cRpf/PiPTdLZBN+z0=;
        b=ULaAGpbeY82EQs5sgY5sE3x8j+4AQJTdcMfx4awcjG1pJkNMGXMbAqnnn/blwB/ZPg
         90m5p2MGIIhkYuFIKTd/KMp2y8pLO6m8uyQyYe8q1eOVpraNfPKOEFr7hUpWiO8/smoZ
         +gCr+mCaOZ3NXSApvZN6+eeI85AiQPctvC+ze1s0a3oKH5SeO+Hqbd9e5ehfpDchai6r
         +sFKLID8gcRjQIYLfi6tX+m02onyu8od+ttrXPOeNX0VCPZJQzFRQGjwAeVJLxMMcYbZ
         p/8s5WsHTY5t5j9MB2rJiwC44TqtNaUOy4Jy920IvEXreak7AgOVugqZnQ5HH1WceiWw
         A5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781302387; x=1781907187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZXBwL8IC//gBDuxDydS4Px/k4cRpf/PiPTdLZBN+z0=;
        b=HXRwQgMndVC44LUR+bcgbB9icbl5RKuNrXh6xDhkg1mAiJjlp1JiFKNLxhhQiog0sJ
         rRHX+XZs9+ShQC/64hgsnjrkvxhx/V7+YGYzOXzex1qMi0CV0VhvhLbEnMsKbuCiIxkB
         uRAajYBGUoWKvPrjVWMGSztNUle6z64FPhkSYjAzrQqeqvUUEbm9Fa5z1QFw/2asVCtO
         viUT+2N4xC8OeobgeJXoQKj62rmkdJ0ZpM3ST4O91w0tg8gycxE1WIcoy+EEk42/MHq7
         h/h8PQi1c264CUUxK5CMDn7erHz57DyEdLkf7dtQGWonOPMrNpoNczrUwbuRd4nbrnoY
         9pzw==
X-Forwarded-Encrypted: i=1; AFNElJ8ic9/le+K5hC8P+ApIXioC+e/Vo4CTGJHJixfQM6+/ibUQ9ozSoPrTI8JGP4wDXaJgizp0YETgYJRH1Mr9iB6A@vger.kernel.org
X-Gm-Message-State: AOJu0YyzW1FsrW1otVjckvELxBUdGznfKoa4hlbpMUmqmsHKH/SBNp+F
	0e6RzOuGtDD6LazzIIpG2ob6B49i8lUayFns+ddpPIK1RnxjF1TU9dgV8UlzrLYOHhue8yaJk/S
	1k0SAN7keBA==
X-Received: from dybmc6.prod.google.com ([2002:a05:7301:1986:b0:2f9:af7:504f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a887:b0:305:179:4dde
 with SMTP id 5a478bee46e88-3094044cbeemr816937eec.35.1781302386964; Fri, 12
 Jun 2026 15:13:06 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:12:08 -0700
In-Reply-To: <20260612221211.1221305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612180956.1105352-1-irogers@google.com> <20260612221211.1221305-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612221211.1221305-17-irogers@google.com>
Subject: [PATCH v15 16/19] perf python: Add syscall name/id to convert syscall
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
v2:

1. Guarded with HAVE_LIBTRACEEVENT : Wrapped the syscall functions and
   their entries in perf__methods with #ifdef HAVE_LIBTRACEEVENT to
   avoid potential linker errors if CONFIG_TRACE is disabled.

2. Changed Exception Type: Updated pyrf__syscall_id to raise a
   ValueError instead of a TypeError when a syscall is not found.

3. Fixed Typo: Corrected "name number" to "name" in the docstring for
   syscall_id.

v6:
- Added optional keyword-only `elf_machine` argument to `syscall_name`
  and `syscall_id`.

v7:
- Made syscalltbl.o unconditional in Build to fix undefined symbol
  when building without libtraceevent.
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
index d6cf7d6d3c84..bedd2175065d 100644
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
@@ -3938,6 +3940,40 @@ static int pyrf_session__setup_types(void)
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
@@ -3971,6 +4007,18 @@ static PyMethodDef perf__methods[] = {
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

