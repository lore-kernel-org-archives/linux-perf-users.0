Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01D3CDBB5
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781328486; cv=none; b=BkVHLj5TyGqPTuZPaax3UiNVFRIlxTTfPFwXc7DHWr7aojMLcmjRbTgVPTxS9KGWoZ6MFZ7BiUjC+AtPV3qbjus/OuGVCv30idJAbgZdUunBwCimkkfEo2cpnuX2pDduF6UnUyDoJJqZC7o9LFg1D1R+L4e7VEite8325I2NFjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781328486; c=relaxed/simple;
	bh=wqpDsWCtWJpM67+W7wcgQcZgfa0jgE9xgguxs8ONSbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yt7HH8rTnU20W1dHn/YLjZwVwV5v1aRn3w67Rhl2/pNg/G51UZ97wntx2E6pXD6zYGwYDfuwErz0Qx9YRtQKyebAbeOSH05cHYcUDIuz5CCPmY/sIiwa0EXT9f/KDhtKTKyZDPjiGpjrMZY4J3eSJeiuph6kab4LspZuTpVsUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZUeAyV+z; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUeAyV+z"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137f3465368so2247058c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781328479; x=1781933279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEDe0ph2Sqa78fbZ6f8XFKuWperegUCa7Bz4vXvbQ9E=;
        b=ZUeAyV+zZelESIvuDQKVWsqUedTtIrYczJ1d9s96+uERwZKbXqyM+eAer2wGfqiiX4
         FZwKcfOLS29d3t858Y5+LOlm2p8PWvreKwDeqB1B0sAoSpZzUfps01pJ8+J6UjH8JiKm
         XY88JUvmmmQJPzNHDLNPz99s4Yp/VwLRAU3ewbT7V7sdjEOxuogju/KqhNRhiX2vOu28
         D24Z/V+B/vCDnIoCiKKebVPEMXXL29QSTlpff9e32QhUdqfg74LXH/6jP6Fjr6YkQBAC
         FM0aYgRQ19q+WC8F7gKOZCxtRJgwqhO/rzG5BUokNcDtbN3yZDUBU8yY2T5rVSYSueVT
         Uldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781328479; x=1781933279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEDe0ph2Sqa78fbZ6f8XFKuWperegUCa7Bz4vXvbQ9E=;
        b=saj/NutnS0Xr29f9zUGz2t/hL/bP5IZXR9ZRb/u9VUVpLgxMkQDo09HgmNSVq1H5U0
         rm45ao7oYOSqL9ZWQMrI3YNf+e5nV8f5TkiP6WBnFHhvn4xfmZBNGvW5hJ2aw+U5bTPI
         EMToAyREakChv+VUpduA1DV4IkS2nzW9G2vXOw4n/i+UwP6p2LbjoYOltN67tDNCxhEr
         W18A9qPKQmkTw8sAJ/zSk8OdZ4gQMX6dGjClR36hwhWqG1h4bn8ayYhk936d3/71JO1F
         25UoONHLNC337p2LD00Wsm3enPlAmNot3VBjSWFOr01fn+uUPHl6xyx8gbUnB5CDGcm/
         nT3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9uCQLbsvwI1rUhYgsY0yWC4PRKfKCJ4AvlyuEpSCFaDurP8hQWyFsnkRX/l36WgU5QE8RKffmKtJP96t8LEfvI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy5F8SHKg/pykcAnzNu7zZn5ajFtdCsnOjOKB25In0Igq8bOn2
	fY8QH0PrIyZVI1HeVUkhWm1JZIp422qnTrIUH0CevjDZE9rXB6A1jHr7yDbWfatNZomwaO6+IED
	Ie9Lu6KLZ9Q==
X-Received: from dycc1.prod.google.com ([2002:a05:693c:60c1:b0:304:d0db:3725])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6712:b0:137:e6a1:c4b3
 with SMTP id a92af1059eb24-1386860936bmr1083984c88.0.1781328479056; Fri, 12
 Jun 2026 22:27:59 -0700 (PDT)
Date: Fri, 12 Jun 2026 22:27:17 -0700
In-Reply-To: <20260613052722.1424093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612221211.1221305-1-irogers@google.com> <20260613052722.1424093-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613052722.1424093-17-irogers@google.com>
Subject: [PATCH v16 16/20] perf python: Add syscall name/id to convert syscall
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
index 39eab82d4487..137699a08c0d 100644
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
@@ -3945,6 +3947,40 @@ static int pyrf_session__setup_types(void)
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
@@ -3978,6 +4014,18 @@ static PyMethodDef perf__methods[] = {
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

