Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A048B36D
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645266; cv=none; b=Z6FUuSw2BqIKJiBQp+DiTcD1/Y/tWvs92PtrbJqPggWm7UEVuv4ZIkIt21/6HwakO93kJcHi/lusBqUYAXoL2F4VLpBR6pl0+xWejEiDAqpXINmB2rLU2OH1m0MPG7W+x1T8CuY+K2L0WAp+hWWmPCSkUKhSPRy4tAWj8vE30VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645266; c=relaxed/simple;
	bh=RHRrkXXYcYNq62G+cS7Ng47p2C2OwfZEq52wF0NYtno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KlBP/7nHDM5FKCjR1qZPBFBJDOSwiZZiVyzTOsaZOJ+XKTRdukA8F3XeN0flw2Sf18xxFjRe6oiPNj9F/Jks5dzHYHdOn4CLN1YDgXngxe8A13l+2oingQoLwjjv7W1SOaij0NwQTvb8609lF1hPeBhyZOq+sL9HvA3yGcZ6PhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpXYfX8K; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpXYfX8K"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304b8d0ee63so2033879eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780645264; x=1781250064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KF1KukU9Rk2Bs9+AAMOvCc6v+Vx5eW/rGfc2xWnqbwc=;
        b=lpXYfX8KzlCtcU9salsi34HZN982qE+gKXbnaSvA2KSC4Iu8LvkHDSBB8YNRBJ/CaM
         e02oW/keh8y2beXe84fubbb+vFZi0XaQBhLOGWUCd9oJxW0NrlNE0uDxvD8Qbgb4umeM
         a4emuurfYg/D5MFGoZ4Qyz5hsD/xL9bAYFAVcSSfno2e9sFhkJk9pe0wonmdmKlbvTgD
         C8s1x69JDgxXFD9eU1VgG3SYONa7+hfa+n3Um/jMnLv3BaelyXv5xV0j8E2hEPsOdpBv
         4tBHxkolhb54V2Z4CdBOWWrKrUndsojD73t93FlryTvT8sy5ppw0ah1la0j2DDDsQmLs
         zJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645264; x=1781250064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KF1KukU9Rk2Bs9+AAMOvCc6v+Vx5eW/rGfc2xWnqbwc=;
        b=XniLgYiNKHTU1WUfSyQtTjvBrvnPs/d7SMYhjeHUja5NaQtgFaQKWabMOv04qLPD/b
         ZlDfl1mjSDvWLm2V/6aEjHn4RR5cxZ4YYjMCITczwfPGJ930LUmAFTncGBqzAd7ptLAA
         NxdPdPuziI05KN+thtnHKO/UDftC5XbSN0gxAiV14UNF3IQJSjvWAnTFsdRny2PeAa8C
         hWalnOHBtofRb1MuRdzXIj0vYDRxvrymvd0JUZA0yOafkB4X2IBCbQurHWsviuO2G2mb
         /U1JqVC9zF3Yh2V3Ps4mPG2y+tCBxnlqr99qwD0tFKBsplda1ElHgHM8tMOqskKugMF7
         1qqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lvf/v2T1KlJj0G421GE52NhXJ0EIH7/eU1wdpqDDwtv6xwDeykYdszSrNP5ASADVN+X4EbtRIDgQpJaVCLe86@vger.kernel.org
X-Gm-Message-State: AOJu0YxhpUmgvJhJPQLtiFSfrYGjlHZuNo0d1WawN9izbh7/t1uX9B1P
	tfvQRfzhmLwdbNx05cg/kGMdh6+WQfQ/+44h0/TEuW4nDbfONQnCs1hePnn6sz8z4EwTqmk1Mav
	79fdPxoSI1A==
X-Received: from dyckg9.prod.google.com ([2002:a05:7301:d189:b0:304:e649:3ce4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:37c3:b0:304:de94:1c55
 with SMTP id 5a478bee46e88-3077b38e7e4mr1190615eec.35.1780645263444; Fri, 05
 Jun 2026 00:41:03 -0700 (PDT)
Date: Fri,  5 Jun 2026 00:40:00 -0700
In-Reply-To: <20260605074003.1730715-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522220435.2378363-1-irogers@google.com> <20260605074003.1730715-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605074003.1730715-17-irogers@google.com>
Subject: [PATCH v10 16/19] perf python: Add syscall name/id to convert syscall
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
index 7265e2dcd60e..12a1379cdbed 100644
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
@@ -38,6 +39,7 @@
 #include "srcline.h"
 #include "strbuf.h"
 #include "symbol.h"
+#include "trace/beauty/syscalltbl.h"
 #include "thread.h"
 #include "thread_map.h"
 #include "tool.h"
@@ -4041,6 +4043,40 @@ static int pyrf_session__setup_types(void)
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
@@ -4074,6 +4110,18 @@ static PyMethodDef perf__methods[] = {
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
2.54.0.1032.g2f8565e1d1-goog

