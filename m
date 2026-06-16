Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED4E37C933
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572586; cv=none; b=OhBRoArU2/BqpTsWIPEJy5nidpD/8IhvfITzkAJyWdbtUBcXkPp1c/lNaC+Q0e0guuSC3FOfZHeunE+731EvtHJKNyqGirszYf7bbCk7K2yz1LG+6jVCm0cBSsbID9sFiqvu+qAZOeR80z8GzmF4ttoBt1RoKqRg4WNSDyzQ6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572586; c=relaxed/simple;
	bh=ugjh2Ji5JszZPl7RY1Khg2UwWX7UG0MmkP/3pOaPdSs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YGJKPBOeMFFGPTKKTywkJJtlPfVob0jkbW9LAR6prwsqT7lN0MAH+S3b1zF3GV/Ox3rLIgXIFrkqYIDhNVNGtjIFhYR9XY8JgSoeMBtag/uZXuduEo9NbOoIAOHJtTfFCck3w3gsFOMkcDzgeXnyklxxGVDGBuMqZliygR1ZQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a/nYdoeG; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/nYdoeG"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1384427c3efso14017235c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781572584; x=1782177384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1k4LtxuRX1KAiOjJBVofrvhJI0JHdLwLNq9oCAztbI=;
        b=a/nYdoeGza9LHU/l97DQLcQSMTVwlqA+Oa01p/u6mHoEBnsygFDoLqkNVuw40lJ21+
         vetck6cZ32URhXsaRdUguoUULgXpwhJy65UQiJrIrS+8LWayqMYrCKIq/WdO4WVkJLPQ
         xNIKdLrXn2KvYrbNTf3DYORMMaD8PvIwUo15+IB88wyK1xfjLeYCjYoLMeD1jJBHVJ3N
         zQpZPv/NvbeqEpWz31UCebmPvK+q5FoJaKv9fyBvsng8rMaY0YRJ5TfRItZ/1bvIZ2dZ
         z0cVm88BfzbbaQdU41Ko4FSHRjgcZRis/8T/3URwDnNr6mE+6CPA5HBq0bIzeXEiC6PR
         YRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781572584; x=1782177384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1k4LtxuRX1KAiOjJBVofrvhJI0JHdLwLNq9oCAztbI=;
        b=j5vSWYVA9FLGtt912oS7DbvmfI9w8VhXnnph7jBiGRq0WsM+lXrI149D1Zlzr3QCyy
         5OCkT7EexoqwVlNY7ZQMkvHcst7tB08RjYxE1laFdzhLYanLn1E4SrBmnH9fyVGn+CA+
         FYl/5mB8v/IBUe+3uc0ikts30T/dmuDjdj4Jk80FFzxK6YIFxbf33ziWei0RQtjFeqQi
         OTLm7sY0zpSlXS53EUn13UK5BURGDcRWy0zPs5VyNrLScICRKDrABk59hf04H3ammube
         +wc5eZLVoYf0HuIQ8aSAILTP94gVDaNy0HUDyHCSlPKhs5KTUEtUpxp57SygjZomO2kY
         60/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/wweWllvFPJhKYL20uGIWJe4onrpugBaRgcmtnhAeNm3Dfm7IO/FPrwMSt+KBIHrg/PBbQqnfMZ32of2kxj/zo@vger.kernel.org
X-Gm-Message-State: AOJu0YxDY3DS1BDcsr5/yATLU6M0X8ZGGNRMW804jqe0U8Q9B61IUi3N
	/EKRqKZ8F+I3Msq1HdQb3c8zHkO6Vd8E14q4fSqX66kazd+Cakw/Tj5QyUZXBPRXLCNxspq67YT
	4s20j7Q4Ncg==
X-Received: from dly2-n2.prod.google.com ([2002:a05:701b:2042:20b0:138:4bc:1c9f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b92:b0:127:33e0:ea44
 with SMTP id a92af1059eb24-1384bbba625mr7065265c88.29.1781572583967; Mon, 15
 Jun 2026 18:16:23 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:15:38 -0700
In-Reply-To: <20260616011543.4037138-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615223011.3873955-1-irogers@google.com> <20260616011543.4037138-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616011543.4037138-17-irogers@google.com>
Subject: [PATCH v21 16/21] perf python: Add syscall name/id to convert syscall
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

