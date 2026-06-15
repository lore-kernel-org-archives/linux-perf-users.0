Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BA4218B7
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542249; cv=none; b=QBDqHkwt6ULSxzZBu7ADEkFACdQKqv9eQXQSVjiwzGt7Iv7cG6PML14Ri8Q1BYVsEQNnUKBfjlFVFI+eZvrOdqdKirDXM8lxQ5EaTv+1RU71J64CbD/yyNA75ZHP3jCpzisf6WZ/xnKmr/zaiIUmw3/GCxiNoyvDTLcShalr/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542249; c=relaxed/simple;
	bh=8cw+pvOKHMw3Pv4o+e2XpKS4CSgLYPvyfZ6ntLF5MdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QDsd+mdqIC8d5snH5C2SvMpOtjnRtp2g/kCmrHMEUU834yAxZrRLP6EM9TGaiMxPRaqEAqgUU4/tPPsOym80YaGvRRJnRJlndgUr8r+iSC2kOsLl3IP2EoOlRGHPI+RdPPXgPBcIWdcoxOjOP2sy+qvHLiEXsJlgR/9agiTnmlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DKEKSLDG; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKEKSLDG"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30b877ee493so937348eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542247; x=1782147047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jU1HUHBYXI+vZIg5y2+7ouwtQjIqetfkPcPs367jPco=;
        b=DKEKSLDGUmvuKlwqp0AIiA8VL6XXbmmuWyRimvqOqHf/8/6IjaxdhzA0nLLjFohHRF
         BlReTaMZIhOsk9QIjuKX8DN4DXEGr0EUOBd17XYkb3aAuiMb7LFcowQnb5qV3elxF1qA
         DioIf5FIFMgGoVmLEl3JkXp5vbkWjzRAnsOFHS9u1/ulob60oSBxGdGUVlLTmAbGwRKx
         HspYvYVPA8HMI5WDExzN7T0N2LMOy/3qchEgNKrrLZ2xCKO73U1Hn8fePJfFs/41iJtb
         IBUReaNS0EAUy7llijPy9YWjWBafoY09ctESIUEJyepiSS4770OJLYUTbSiTfycwSKux
         SkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542247; x=1782147047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jU1HUHBYXI+vZIg5y2+7ouwtQjIqetfkPcPs367jPco=;
        b=cTCtKmlwRqhjLQgk9yaxAUViF1L2nUCoGLx5k+U+mRVnSoP1s07Nvq4r1t+0MEWqzl
         wE03DEVlMlPpB12gO16ASBLaBi4EFReLwlm2R3ZuGOvULB6PzI4hpPxzueVA7iHuhpf4
         2HLDA7H2B+fGsfFTWUqLe/PA+1+eu9KN00FvTWDp98FpB8X3IgnHeMQFR+5/wJpnPL6o
         oYMIyNwD4bNMRW9p6Ty8GyjfBT4/olv9ubORjkYZAk401Vm9IuWhqfK2E5rLxcGnNTwR
         o7gMVPvOhNWNgPBWCFcFE2ZO2MFBvV7W0yZXudf20FsNlzgq8qSc9qSJbusXZJdvii+L
         +nXw==
X-Forwarded-Encrypted: i=1; AFNElJ8r5N8+SkN1oaXzEyG92P2lnuA8amPV6Lq2EDgLE8sQZO67FaWRPRcNUJlWBAEuBjG9y1yX4L55xwPP7aIgDKae@vger.kernel.org
X-Gm-Message-State: AOJu0YyF5TCpXK+YOrh27i6xCQIxK54L8a/YipYkVwxR4RVjqbDHKL9J
	WjIDOuTHxEbGm68QXxyCNwjPyOvzK33mne4kqBnJTjKFCQDAmT1vm83hG91lBoL+c8JqbSQygzj
	dlHS8nslv7A==
X-Received: from dybuz17.prod.google.com ([2002:a05:7301:5091:b0:300:7c0d:9eac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b01:b0:12a:8122:24a9
 with SMTP id a92af1059eb24-1398582a630mr98667c88.22.1781542246169; Mon, 15
 Jun 2026 09:50:46 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:50:06 -0700
In-Reply-To: <20260615165010.2724690-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615165010.2724690-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615165010.2724690-17-irogers@google.com>
Subject: [PATCH v19 16/20] perf python: Add syscall name/id to convert syscall
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
index c5b8b9f1ea4a..f1230bd222d7 100644
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
@@ -3954,6 +3956,40 @@ static int pyrf_session__setup_types(void)
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
@@ -3987,6 +4023,18 @@ static PyMethodDef perf__methods[] = {
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

