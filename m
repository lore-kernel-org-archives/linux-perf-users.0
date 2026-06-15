Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16F3B42CB
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504230; cv=none; b=Ouv3ZS/uWTjI+U+Lyleg5OlP3Mh0EPMZBoFugaKe85p3zsIqRdWPRRxgKfCq7mJR70rmeMkC+BhHi6onxD1pTOyynYYzm++Yad5Eiinnlmcb68Iv1aklvCqBsJehWpB4sNhKtK2r8C6ZsiUVxUx1k8UZxQNHGOTsLzDD+JqdSPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504230; c=relaxed/simple;
	bh=8cw+pvOKHMw3Pv4o+e2XpKS4CSgLYPvyfZ6ntLF5MdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DJwIuDPeKTz+0TbtxNo1e0gvdj44uES6XFTDnqH9sXB0gyq2DJBD0G/WUq2rkGt7DP7PpdDftWPquQzJbyGfUsK64xXyBmDGRV+0wJ98KaOf6ptxgHZusU9OKcM7uy3X7vSTO19yUDdyleUP0BTA/PTZHhm9/QmmH+zLFVxoCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lo922PNk; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lo922PNk"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-139553dd8acso1197742c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 23:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781504227; x=1782109027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jU1HUHBYXI+vZIg5y2+7ouwtQjIqetfkPcPs367jPco=;
        b=Lo922PNkpaFP0lAbBrEjFlw2UZ8g37i1Qt8wD2D1aVO2BREqJyYrGdfkwA8xTjxVFc
         GLuwH+PrsussygSDYwTcNfXY3ajZkrkCvszPWSdJscFd3vn9mhACnPmQ7Ryrs4+f8mJd
         aYhjmke0YbRQPySQQNS2F6DU2OviYFPpEqrSOtjbadxFqRxl4RnNOjVvaYjOJICM041M
         MiyvNHwAwRV3smeU3YX3tCf1mWY233GaYYel4jxROA1YxwZ8EFbgQ8e44/d8FOhHfIoG
         jP5tNj9BPssXtLhm0BFS3WgWe2ykmyyNuPv/Em6h6cAdP3grhwbiB1MYZxbBW2kQcikk
         NlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781504227; x=1782109027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jU1HUHBYXI+vZIg5y2+7ouwtQjIqetfkPcPs367jPco=;
        b=aUQ4WC5MyfEx/lgce7OLAWhKaU8DYgriPfjz7lOW5SwAGpSguhguW/lJvg/RpP75+h
         iWPnHr8euEgShweHtPg/NehXqyHahdvnE7ZUsjeZcR30jFindC5d32uHJH1ndGSIqwlD
         ggmVBQb5DFYPOkkdm8RAsVhjNotI/uYu5SLEtxfnyB5YNw+uxAFLtubhUQLvHgCtzlq8
         cFY5NhoBt65Fx0e29vc/XgYQSougOBMfN5NXRiakd3e4pc6nB5qosFm+goKXyuhWgpjm
         BeM5FiUBKNLIJ6wMUZP90ubdGygTBBIYEdQvwRgSpISd0vnXU3xFx7GbBeb5z36mKV9W
         /Swg==
X-Forwarded-Encrypted: i=1; AFNElJ9+GKheI8xElQ/xyO7JWHyqmOrtEBpGEXT1gCaocYFdfCo7LMQcq+2aQ/mv6WzdlTKVItH0BZVfdCL3DCjH5prH@vger.kernel.org
X-Gm-Message-State: AOJu0YxqTtYLPEiSiaYkcURJwdPFSJc59OTmYJ1wohmnkoqK6b27qfBP
	akDCkpYEzNk02K9cTvP7WFEWDLTuz2qP+3ENt9PIWs9szs214lQP8JpXEvi/2T6EluAnX8iqOMg
	0Jx6IYf9QFQ==
X-Received: from dlae21.prod.google.com ([2002:a05:701b:2315:b0:12d:b2ba:b551])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:527:b0:130:aa42:167b
 with SMTP id a92af1059eb24-1384bb94864mr6823281c88.36.1781504227066; Sun, 14
 Jun 2026 23:17:07 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:16:26 -0700
In-Reply-To: <20260615061631.2382079-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615002812.2234795-1-irogers@google.com> <20260615061631.2382079-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615061631.2382079-17-irogers@google.com>
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

