Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22B391E44
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487529; cv=none; b=NaY9JNJLQd41xB6LCTRMGvhBBPZheMYSIJgTfynJI0kUkmb/8beptzCrfAGpFjSwK+67FDklHPYcUFKvQXyVXsKJ2wFiWGua0g9L+0+XkM/lWUkUWeNiCLM0POMLSonLB4jRUZOo7TN8Fio1sGst8g48OUxEwdwNdQwk0rjmxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487529; c=relaxed/simple;
	bh=1HzIEyfchpBFETRM/gJfbDSVMw43NVkp9FBkAodJsTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iGjdK4C+Ffpll73r5zX1FaKwkQ5yuenzlFV2P9uWHZ42qEAta1Y9gkqFGp5ve76zy45730NQrJtltfkeI9I6vHF8gn+Ux5rt5vgs5z1p922TdSSBARHgK8ypXVO3KuLu3ekNhE55nkUlYbVwEpRX4bc39UuXwxXWz3/CpUXM0kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8UW1Vqb; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8UW1Vqb"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-303b38ec2f6so11459568eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487526; x=1780092326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jM4bdTdLVv/rhBQCW1JN696MSnte4z484SiWq30EwPI=;
        b=E8UW1VqbtejuallkIYTMp8Tt53m9NPqumItDSlFQ1OjLy+z+ggw5bCCMCPnZgok9JE
         c4hs0ByE9dHPNOcNZSZ6a5oTdwrYLviegY3+Ix6shLuBZG3EquM17j8eSlKk+Y+V9DKL
         Clt8RPAT1zCNFZmNsXBRcHa4hvLGmoLIobyncd9RZfwYkqNUQUEf1L+HYbxu1NwLMrUp
         fYUMcJkoLQEr7VC0AWagXpj4zUJQ0qfM2K1MTigQOiR524Q4uc9IaXZ/XoTqFA2ZPDS1
         WxJ7yXAtQoIx+q8iuulSBNRPudp2i4kt7FcKT1bgUyCQLZ1AddH7GKcft5Yc5R6I4FAs
         DYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487526; x=1780092326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jM4bdTdLVv/rhBQCW1JN696MSnte4z484SiWq30EwPI=;
        b=qJy5aCDFymzZthfgHtD6/aluZ2T+7YrvPVeF6mG/box6QluYw6rJrziqhGhAVRuvGY
         kuJHmZEYHQHFuYfrXH6Q4SWsXiN/hnMVnUxro+/pQ/i/zxzngLlSZp0wy8mNRrDPbdao
         I3QpAB0J9d1tpamy9MmYvH+tpdyBu7xFSGpzeYQiFdWS/H7Tn3RK3R49VTrr4bhEVYWP
         NRxRPEXu+cSlJT1mKRGysFzAkE1sZnIkc92qtqiXN+jFQASWEv4r7b8QdhIOvIZPaJVI
         cKBhGwmG0whMLcrBMAfjpfAWVXOHc1ajVrXwRCJt32pnoaJKYmigd/Q2++I/h1Bqv7cM
         wG5w==
X-Forwarded-Encrypted: i=1; AFNElJ+cpDjL2eTbjRlR8O1nVTxfGuDyJXcvcFRQNbqY/DBJICfNQ9e9FO9NCSK2RIFM7f/l0G19RByACl6fyZDT44N7@vger.kernel.org
X-Gm-Message-State: AOJu0YwaA5Virlj8Y30uwwUtBDlbjrnRNVKi3J/ANcNW5xX0+qWSOqcA
	Z+TOdzwv5Tr9pka55pUWHEMwdmZu53FzuyCw0W0e7vbcmBJDl4D7LHc/2hv0+oLm79g5X5V9Xaw
	Tqc1/McaQGg==
X-Received: from dycac4.prod.google.com ([2002:a05:7301:5504:b0:2f9:af7:5047])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7fa6:b0:2ea:edc0:4fbe
 with SMTP id 5a478bee46e88-30449095631mr3131034eec.14.1779487526120; Fri, 22
 May 2026 15:05:26 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:31 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-21-irogers@google.com>
Subject: [PATCH v9 20/23] perf python: Add syscall name/id to convert syscall
 number and name
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
index 4bbc78b1f741..e37779f9dfe4 100644
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
index 218d772346e2..23eb65adb392 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -18,6 +18,7 @@
 #include "data.h"
 #include "debug.h"
 #include "dso.h"
+#include "dwarf-regs.h"
 #include "event.h"
 #include "branch.h"
 #include "evlist.h"
@@ -35,6 +36,7 @@
 #include "srcline.h"
 #include "strbuf.h"
 #include "symbol.h"
+#include "trace/beauty/syscalltbl.h"
 #include "thread.h"
 #include "thread_map.h"
 #include "tool.h"
@@ -3792,6 +3794,40 @@ static int pyrf_session__setup_types(void)
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
@@ -3825,6 +3861,18 @@ static PyMethodDef perf__methods[] = {
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
2.54.0.794.g4f17f83d09-goog

