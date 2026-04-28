Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2631C3D6CDE
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360801; cv=none; b=E7SO8jSvg2AT8syIHR+6/6PA58OFTSpNOajmLCIBCwOZoBEin/aHxXc+i46wNzpR7Cw6nKKdEW/SPTsqLbTvelc4kRlGQMPLuG3A8AF53iC3oHn1vj7vINxQj9459ooxVRwiDEyoCiKH7KlrL5DZiN4NFHP0m1j6kWrktV43ZJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360801; c=relaxed/simple;
	bh=jqJnuTglrIE0C5t8ONOLiuW2D1hx0/jRrchBDIYUDKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d0uq2WuEzH82uP4NqSF0COHV8U78pol0QtI8Sc588L+SXdFf12HSPeiXWFM32GMXiifrcg/OZn0ypKeN0iJL13YWtaIYIVsmztmK9Pq0gEo77tswXu32qx9piHgVCi6Wpp+a5mlnCRbF8jLyJlFsUfAppCM0G76n+KZ9K5rdIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+yM1UBO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+yM1UBO"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3648018e142so1764804a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360798; x=1777965598; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1gKO7YE159lzRxtp3cqFIqyDD3fMB5ThR/PuFBByjQ=;
        b=U+yM1UBOdV/vPk3rVuoOeZFrwoXSKvpt8K8qn8RJPO/aczSAuTSUSq884kdK7lX/Kc
         Htkyl72XtxJ5NdYqCdtZ/L/6mOixGUdVtglPKISf4kxfxI5Neyf3R2OilZdyqRtJ88hU
         0avyv/zZoK1eXMSZCkNQAIMKVe9wU8R0iKhbQ14iMcezQQgjzK4MAXRiXpWXXzot41G1
         C+/4tDxiGFwbfY/MibXFhgDFzQi6grrBCqCxUtojWYH+C+oXN9beMlaOj2f0gMHYAtNR
         o5OGtizd8ZnTbH/vw0+Al0OKyt8N1eAsm8/IzYIj2woYd1JK4nFx/0g1MC9RkZRbFSpO
         qOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360798; x=1777965598;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1gKO7YE159lzRxtp3cqFIqyDD3fMB5ThR/PuFBByjQ=;
        b=XrP8grl790tpxhbvZGIKFT/W4K3lP9Ag9UwufERw1bmP+5ufEAVYRFoXN18VC94aoW
         58wXgfrsPZ6pUymGVL+d7LOctri6zbql00G8eCInN2SQ58oZv4swS/EWuOGIE8xdoQCg
         +O4Yxvc+kK2Tcrpe6VJDUHmfUqkudW1vnwRFDZz3idz6PEq1/kPRUVTi9lGJilhv0+Ye
         29TMp7sHk5/1JbjWIjqjALrc2RYRbwHw2ncBm1XXNH5e6vNkvAJiVHmAfAXpfP/cXO0k
         RYj1sDJqi14HFHY9M5N7ftZQP0LSk3Ksfx3kE7znHj7o6Y0opsvF6JBAfbSLU9EJfIW4
         A9tQ==
X-Forwarded-Encrypted: i=1; AFNElJ/COylKK+omaDFOlcbOdL/j/+Hpyr9mszDEM/E2ON3SWTwEKoudKDya1oU+l3hgln6+5MG8FQE3uCaZwFYzK062@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdNClfOXTTb9gCalWlGMYQ4ikemnadmKpcMVuk9WeFnkheEiz
	pobXIxvXnVeTt9Afoh84AANIxQ2Dd9px3fi0e7hSZ9G9aDUzFflPKm4MBq1+pVjxc/LIoFTfcwN
	haYGyCsvzng==
X-Received: from pgc12.prod.google.com ([2002:a05:6a02:2f8c:b0:c79:1600:6a09])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e210:b0:39f:3ca8:a31c
 with SMTP id adf61e73a8af0-3a39c2e1812mr2289909637.53.1777360798186; Tue, 28
 Apr 2026 00:19:58 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:25 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-21-irogers@google.com>
Subject: [PATCH v8 20/58] perf python: Add syscall name/id to convert syscall
 number and name
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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
index c947abf8affe..69d443c504d3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,6 +16,7 @@
 #include "data.h"
 #include "debug.h"
 #include "dso.h"
+#include "dwarf-regs.h"
 #include "event.h"
 #include "branch.h"
 #include "evlist.h"
@@ -33,6 +34,7 @@
 #include "srcline.h"
 #include "strbuf.h"
 #include "symbol.h"
+#include "syscalltbl.h"
 #include "thread.h"
 #include "thread_map.h"
 #include "tool.h"
@@ -3785,6 +3787,40 @@ static int pyrf_session__setup_types(void)
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
@@ -3818,6 +3854,18 @@ static PyMethodDef perf__methods[] = {
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

