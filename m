Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CE13CF67A
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781334704; cv=none; b=tAW24FM16kUf5wyCph7DEJF4QgoEnPGmcYvjhYIpg2hRSU4xpQ+TFp6TNd5k9nzGMuKLDYFA2VvR37TNC1E4jo85M3Y5APE6jjuE5siZ6sI8GaEQBQ3MmpfnwMEntzg9/OCNkAF1aX1jq2ScR43Lusxghk4JuJuL9ThhJ4ON/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781334704; c=relaxed/simple;
	bh=0Rv98vqbuYTS4rdYxKrShUD/SOBpPPgcPyMeBYIp0cU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y/lhg96PcqVjwDo5YFOTCameTSisBtslcm2NeH6GImF20eb/+3iEYbauQ6aAAiDqiFvoqhe9lmnFQY6II6HBItRjTzAA1Njk5g9YYZkpogjZp2T3bTacx3Cmpvw1+X3On+0WlJbPVbndXeHntiMOoADfoTchUHb6YM0Q126cBRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mPneYgIk; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPneYgIk"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30762d67a64so2593293eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 00:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781334697; x=1781939497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vBekA9pBLPOjmpSUevxXY5H8lVRG7mdj5IaASPiGeLQ=;
        b=mPneYgIkRTS1l/tbJ+f+8a4s/QWH3d+gOiVqmPopEx46+lQ3Ja34vbC4sefLUvakAI
         INKCKpwlEt3nyx+7ZHNR90G6WJj/8hX0wsTfgXkhlIgYoIJzUd3nJ+sb6aRNYXwZyy2i
         BQsHrqHTCBeAqsQlApSp7VFB7Hhsy01Obi6jkOVKx3BxeCD/TpBqUXFeDgr2dwH4aZVM
         mD7a+bHBmgvzEqKYuwkVF3AidfrBjcjmRwRoeYWfZeDvZzMEeTTVUG2CGvavpQ5hgX93
         1SraEk/D7bRMNq08DntKenyWJJdgvsr7DGIzh7a0Gqlsywt0ZtxUOwXvHfvydrFs2nmj
         wiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781334697; x=1781939497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBekA9pBLPOjmpSUevxXY5H8lVRG7mdj5IaASPiGeLQ=;
        b=ptURJd+r7QegZFz3SEU7Oi3RNONQNRCeecX06/80r98+MKUwvrJMR85n7Sisihxfb6
         kSb0lc/OvURdppS8/r3vEfcTCa4dsEwun/9INXp3/5B0UmrfY5Cif/MY/drtpymEglDC
         QFjiRtPLmNr7oS95A0qv/eXAUet85vOLSNQA9W1ywDopZTa8wJtMSxyBWVGy90SUxyeE
         9a7GYsSQSCpKdaA6WxFK0XeArjRWl4NXOooP3OJiiGdH4lXiOyIZaiVflyzyGV2Pf/Md
         eRmnE8wyUMICFZ8DTS7I/RNCLG7drUvdHgKdCu91LmbgLqvsfl+d1KzAgVs/gOFps11I
         K3bw==
X-Forwarded-Encrypted: i=1; AFNElJ+3IUTaQpq3H5FIMF9th/w4ZWgxxLI1vfZzmxmM/0Gfvp+L8ZBNLb43Lt9+gdUZ22qpYKG4qZ9DNGR1nY/skN8K@vger.kernel.org
X-Gm-Message-State: AOJu0YzfhJ0An2LhPLUxPTxegN3Oda9TtEq0FhnSb3iFIuWr14DUQTGj
	3GT/RMYWJVKpolE0wzelKtaJCR9xDewqvY1N8C7QN5d1uC8Qe5YBZ+saTSZ+TWDhQ3BKyK74RAb
	9N/r5dhYYVg==
X-Received: from dyek34.prod.google.com ([2002:a05:7300:6422:b0:2f7:767f:edc3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3202:b0:304:d788:ac5
 with SMTP id 5a478bee46e88-308200c9097mr3997979eec.35.1781334696485; Sat, 13
 Jun 2026 00:11:36 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:10:56 -0700
In-Reply-To: <20260613071100.1508192-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613052722.1424093-1-irogers@google.com> <20260613071100.1508192-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613071100.1508192-17-irogers@google.com>
Subject: [PATCH v17 16/20] perf python: Add syscall name/id to convert syscall
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
index 0ddcaa054cf9..8b708d29b1cc 100644
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
@@ -3944,6 +3946,40 @@ static int pyrf_session__setup_types(void)
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
@@ -3977,6 +4013,18 @@ static PyMethodDef perf__methods[] = {
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

