Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B822C326F
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781483333; cv=none; b=Nht/ZQnoQoT8bNK2enYd1/WsFjOPUXJCxigGZ3Pmifdb+R1NMAMoW7x2LyjLMI/KJL8Bm3tt54NE2ejTg6MgAVYXfzNqk4VeF7BEz8ewoASIioiknVm1J02z2HOqV8NlG8DVX0mJe954zS2QrJlq8S7A6Lmkray0N69hNTd10xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781483333; c=relaxed/simple;
	bh=mmTj6h8q2JLOjsSCGD9uyZG8SL3aeewYjT7oG/QwsbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yi7cY0/h16PM1WUeYU1pJm9Rsmq0c8fsgyV8dc4f9HA41ePSxp9v0J1EXLkpDE2JdlWs07rpiYWuM+VP7MtVx0edUpqbcqk/S+HCwGmQirJKtoOtLd9NmoIRtKu+mhXlO0+stX41F8cB+EZz91GYJJS6quEBVHhFbntNcPObuFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ljkJ2hOe; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljkJ2hOe"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30762d67a64so3971170eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 17:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781483330; x=1782088130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u7nc50Mnpc18t1FIk+qwE6V0SLX0vs75BRluv9XlL+0=;
        b=ljkJ2hOe0H3JUwHquHPzmRWnlnM5ZjfAX9K/tXIO4G6k5fCzxKhKN3qG5UilF3OQhk
         qwi/TgXeUoTa/kU9J/RMz7medqYppwWgty4/sO4wrvzZ81LEX4Y+el6IznqlnZ7C2HRR
         nXxDhpuSpasAdMGYMdaX32jXUu2R1vxg9l9QcZgcFSrj4PEC9MVwgWBsSqh34sX9MyxA
         XHzxgVH204lT7KndsyWIxiSZ9e7R6iGypbVx8Y+Jhv2ceKzvI2R0s8iCkexLZMqe4r3R
         jdEdwuoML0jtPRVZ0EHvGOfRoKth6qrzPJ0r/4iGumUCplP7cylLmESZ63h+w6s49bLK
         K9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781483330; x=1782088130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7nc50Mnpc18t1FIk+qwE6V0SLX0vs75BRluv9XlL+0=;
        b=jieubmFJhJkxnCUszraCe/7RoIt2onTWda3wb5kra4hfn6F1kEpBH8+2F5yMl/N/Nv
         iquHP4pREPrM9K0Q7K/hoxdSCW7ScCt9LZefV26P9ZIvyIPTeMAtjwGPWW6E4asoenOQ
         jHyCQqsCgle1ML9Z0KbV5jwgMyIjaPgNSsv1SQ38GJEzigT5m7GOhTA+QcFR1Ilbbx2P
         JJMGAy81O8WTzbbTBaE5TWLl66XFknmjHEskdIuSr6e96SzCqQQTumnnTEVUh+jBsNiv
         fvk0iIDyUbV8LWolW2z9a0BcH6blZ/um+sESkTSeRCiZgM59OjCwVRac8UQ6GcAWiyM/
         D9aA==
X-Forwarded-Encrypted: i=1; AFNElJ+uY4DRd+Ne9HUbJ0byo/Smu4PBmnNj+eR1k+RioSEIivfuDxS4FVZrHwADSY/fBA6i0M3+ih8YLd3L6GOC+fwX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw55F/uu41mHCAoLL0e2iYlYD7Z5VYY4RYOnkAGDCtX/Ez3hh1O
	edyt+LQCwiIhzMPR+iGO6fxR6zuvI9vldD8qL3jYEJOaC43/BgIRDZrt31/KEsSqDSgS+y+O3oL
	3GII4ii0Wlg==
X-Received: from dyji23.prod.google.com ([2002:a05:7300:7a17:b0:2f6:ff42:df28])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:100d:b0:307:287f:9bbc
 with SMTP id 5a478bee46e88-30820096078mr6326472eec.25.1781483329517; Sun, 14
 Jun 2026 17:28:49 -0700 (PDT)
Date: Sun, 14 Jun 2026 17:28:08 -0700
In-Reply-To: <20260615002812.2234795-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613071100.1508192-1-irogers@google.com> <20260615002812.2234795-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615002812.2234795-17-irogers@google.com>
Subject: [PATCH v18 16/20] perf python: Add syscall name/id to convert syscall
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
index 8255361b65dd..83ff8e8002f1 100644
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
@@ -3949,6 +3951,40 @@ static int pyrf_session__setup_types(void)
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
@@ -3982,6 +4018,18 @@ static PyMethodDef perf__methods[] = {
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

