Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4F39903E
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157450; cv=none; b=ojsBxtzK6HbjMkzJ8nPxQj0Ax8j0Ggpru0ozlYdVOrfWYC7z83qxmyO3wiYVZFn7xMR7Eklbsoox057Q0Wj82+ppl9grIHZyv2MNMiofyEzem4yNvOYKzEx/j4/z04aA2lmg2E4J0bYmBqVfa30XffHehORKLtOxVvcjZIRPqAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157450; c=relaxed/simple;
	bh=20COE+F8AnmEkDkK/TnYKsZ+aMgWybNxHdBlRVGcSpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eAzmeK3fqlAygSOJY6GcZTvZd96GkafPL7EwCPskmqi2akL97VkB+CXbxGNSobFksdsaSNx21bS9jEt5iSn71ekkyx7IbjspYl9puMA7RwQnrODrsxbBSHZDDAfqTONCyvZnV2r3fYXHJhyoZRFL5DUrGc6uUWFFBoVKhMm8FN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aVtnLVGo; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aVtnLVGo"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bda35eab74so7738796eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157447; x=1777762247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmZaRmxvqC34085lIoL5dgTRYciZnOOQN4pPPp0OcBc=;
        b=aVtnLVGow1HLOn+GeGdYkZue3DIBhMkOJM0Fae2XZDmStp1EfIwyC0GxqVr5Vv3T0f
         E+EY9rsBJvheSxEg5PpmbY8TyX2f6oawSyFtTuQHIT8j5EUPXTxUNVbXaWKwFjcrfiWh
         5bI3bpIF0vUg7XhnChs2X8OLvH1x0MHvWHzUM5f3uoThsPpSPi5gaJBkGktYGdxEHCTe
         qjuRv+IXIaQlL4jDCOym+pLeStx/w0WF+MuCm82LTB1v4ZIr2NI25TIqe0p459v8+zKx
         p9L20ejAeyBXA6u2RH9uby9pyIw4cEu+SNEwXCspqWz4rGetkRPspqKZjeL5XGImTtVN
         Bnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157447; x=1777762247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmZaRmxvqC34085lIoL5dgTRYciZnOOQN4pPPp0OcBc=;
        b=WcsgRAHvjI+ygqwo2dwBq68rfCYwZzo2U24gjGJWU7e63rsOzzRT4m1hXAOmftHRfw
         3gVNmTMYxvzM24JVt+UBsY5nhCtYohxvEikLDFtkiKT1iWWvS4Y0Ckzt96UenvhcEdqB
         /0RK8blWN8kljCmL/kp1tgwFxOn7w4NRg2U02PqdeJ+JKGUiy54xyfwhpixdTqZAKbzs
         7zmmZormAdHcsvHZcx/ie/19B7rH9he2IcWwyBAxmOEJkf8AvSWmmIRlnB2g1Bx5QJrT
         i9gM1xBsvc+x0USvd/LD5qY1Sc9k49iFcxKTZoIGNMMzmQlVo/PtQO6UtGgmdbWEEpFf
         szRA==
X-Forwarded-Encrypted: i=1; AFNElJ+KcxIIxAbUDg1kaKf0V8LNkpGLbOy3ZMUqedFhwghanvnqinZ6L91aEvEDrJtopglZi3MKyab1EpieoiwwOHSt@vger.kernel.org
X-Gm-Message-State: AOJu0YwNdRr723nog2yYnSFFq9ihENuoataru9fAP5ayn5MLYmAzCDtK
	Ko3FEnWeA4LeiR3SDMH0BGGADP5a4P1Q0t0yh7MIDh/bvYLTncWLg9Ojt3hQumZM++/suiRFzlJ
	5ulLj+yxf1w==
X-Received: from dycpq4.prod.google.com ([2002:a05:7301:fd04:b0:2df:6abf:7cee])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e12a:b0:2d3:9c91:6c45
 with SMTP id 5a478bee46e88-2e42c84c585mr16800947eec.6.1777157446435; Sat, 25
 Apr 2026 15:50:46 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:08 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-17-irogers@google.com>
Subject: [PATCH v7 16/59] perf python: Add syscall name/id to convert syscall
 number and name
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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
 tools/perf/util/Build    |  2 +-
 tools/perf/util/python.c | 48 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 70cc91d00804..fd55d02dd433 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -75,7 +75,7 @@ perf-util-y += sample.o
 perf-util-y += sample-raw.o
 perf-util-y += s390-sample-raw.o
 perf-util-y += amd-sample-raw.o
-perf-util-$(CONFIG_TRACE) += syscalltbl.o
+perf-util-y += syscalltbl.o
 perf-util-y += ordered-events.o
 perf-util-y += namespaces.o
 perf-util-y += comm.o
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1af53480661f..861973144106 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -13,6 +13,7 @@
 #include "counts.h"
 #include "data.h"
 #include "debug.h"
+#include "dwarf-regs.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -25,6 +26,7 @@
 #include "session.h"
 #include "strbuf.h"
 #include "symbol.h"
+#include "syscalltbl.h"
 #include "thread.h"
 #include "thread_map.h"
 #include "tool.h"
@@ -2669,6 +2671,40 @@ static int pyrf_session__setup_types(void)
 	return PyType_Ready(&pyrf_session__type);
 }
 
+static PyObject *pyrf__syscall_name(PyObject *self, PyObject *args, PyObject *kwargs)
+{
+	const char *name;
+	int id;
+	int elf_machine = EM_HOST;
+	static char * const kwlist[] = { "id", "elf_machine", NULL };
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
+	static char * const kwlist[] = { "name", "elf_machine", NULL };
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
@@ -2702,6 +2738,18 @@ static PyMethodDef perf__methods[] = {
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
2.54.0.545.g6539524ca2-goog

