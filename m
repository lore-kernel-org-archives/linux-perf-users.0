Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434303A59A3
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287840; cv=none; b=FV6U/8V0oXW7Gjt2xuoxoAyvzqBnPqxE+b6uPOKn3vBS2Sj/K81mM5XSFxBi5Edp79BEE+QAwR3f55lZuQLH4mqfq+XT7dnRWX9wUesDQ+jiF5G4M5Y5ixzGdZIQYBOkck/GgiaFpbAZDF7Mepw7AkvSF+Yz/qn62F+zuovjr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287840; c=relaxed/simple;
	bh=mBcUtegpuv81BFkXJOacumoSGraI3+UmhUeIElIXSwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K9BzjM+JuVTP/vUgu4mQ/4QBzlp4Kd0QH6mn/j5m1t8ryCxtCULPkW5cepdEqLTgq8Iz8MMbrkWifN/0hQk9FF3dl6mX/gxtI3mlMVAD9nmSrdSCkdChfUN4G91L+N4cLne7ANv/du9ob+fl1iKFeT4dE/bymt9IgdA3ryXurzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q5taWQAj; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5taWQAj"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13825e1dc0dso4544687c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781287837; x=1781892637; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+RaBXUfw0aA0QT8Neqw/i6bUoPwCHBlVbRDPCEo3xjk=;
        b=Q5taWQAj3NzQNzL3SqG0jsdIrfitpFSdd9wUijAHsk9wTfH/MUwoSdf6zuOvaTIK8+
         ydjB/APx7L1GvRVjHp9cVKDJ3Bcs8iGJaQ2ovfrNQC9LxNos00KmqdTf2/TIwWIm6vjV
         ct79WXqTegTHRyDRPr6GLZyUqAq4+HQWBTibsnj01p0beP8f4VB+cln7HgOLzoA1gsIc
         hhYFR79TrBefEyCR+fw+/GFKdJE5qwrQnn5ClC/FF6lEFrIRhphoUWSCkN+W8M7L7hIS
         qEozpHGFQmClEw0teuvvYSDrNPk9ffg3e5HKYjEoMTybXdiFgMX4dPSaRrBZXWHjNVIz
         ZHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287837; x=1781892637;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RaBXUfw0aA0QT8Neqw/i6bUoPwCHBlVbRDPCEo3xjk=;
        b=BfgN1S1TYDoGFkPawwlU7h8cqCc8OqyHA/Wy7wQ4Dl+OZTKE3R3O8giKwTtJdm8UZ3
         BTcFcpX0AgHDBcOzVJS5Re8jMiNqBaGfHWaP1Z1PArYjAdtSCk9IZiYBNV8Qryo3sH37
         wDy9ny2EFAd+ONByB/seBNCRDuDc/cq6wKqSLp+ICZwOYLMNtz5OVs+AoiyXiILrBJR5
         PqC6UGw2prJsLm1Qi1CfixYX//ilVwRQRtPRZrspmLXi4FpJ9WUQ3LrwFTdWvnD74xbP
         4Z5ISmVbyPuQjBkJuiffGKBDVp1EpAJjlw2HlOnA8l4bnNoPw975GxyjE7WRvIVNLg6K
         R51g==
X-Forwarded-Encrypted: i=1; AFNElJ+mgtqcFymYcau30YQ45jujHdles899wgCFo4NCSzNDtCVghLdTh70ontdLJRykWz7LySkDeehoPELABKoSbkAN@vger.kernel.org
X-Gm-Message-State: AOJu0YypKiMqYkRsFJl9FVsuXyyhcg0m6Y5rvdsDyfQvJ6gu3AlzTZgU
	S4mdJsXWE54Nk3FehqXE8Fa8gJOpHgm8HVxoLAyloX6+Zkg/uvGp/7+kxlpCdfSNIfeP5nMsATD
	SDvFQfK63Xg==
X-Received: from dlbtv4.prod.google.com ([2002:a05:7022:3c84:b0:138:4eb4:5f7d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f83:b0:134:df7f:910d
 with SMTP id a92af1059eb24-1386f23581dmr410837c88.7.1781287837014; Fri, 12
 Jun 2026 11:10:37 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:09:53 -0700
In-Reply-To: <20260612180956.1105352-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611224455.201994-1-irogers@google.com> <20260612180956.1105352-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612180956.1105352-17-irogers@google.com>
Subject: [PATCH v14 16/19] perf python: Add syscall name/id to convert syscall
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
index 160b2f9868ad..dd84fecc8fff 100644
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
@@ -3956,6 +3958,40 @@ static int pyrf_session__setup_types(void)
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
@@ -3989,6 +4025,18 @@ static PyMethodDef perf__methods[] = {
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

