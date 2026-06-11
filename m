Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D254DA52C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217936; cv=none; b=b+wy9hVSX8n0uWtYYgSyX7VcXxnEcH3FfmLS8gCCFW9dTAnIw/5zUhbTsRihAQaWA6B8+YHwyiArB27If+KIa4mJ86YYJHUoi/Qt4tl38lLz7noF1DAqH/VN5wzlSevemhy0nPH91S+tjg1Q/GY7oM7/LOl07NCB/bAeUb6p9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217936; c=relaxed/simple;
	bh=Qhnj4TSCJahH6PJibpCTJes14hfzo8V6BZLxy5gk9ng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cJemAUnSHnnlE85ugiC5kaPA6ev2e/FwfeK2fJKmR9IRynQspwR8DfTcOnj9BSzSgL1aQjRkA8w/+zQ7xIm6fhltX0OMfNwK1UsWaFc3otOo96KifZX6Co16yMHbhzrklB+eU6KXbWfxOblAfQK1oPIzA3IYRQglAQsyP0u/jTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBkgKqSi; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBkgKqSi"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304e7fc90b1so473206eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781217934; x=1781822734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBXxRqTrr5JWKSddHPZ8Jmmc29dDcI85ARjTfI3iIe0=;
        b=OBkgKqSi1HvtGINe5eEJexo3fANnXZouH+os908dCxhtZ86FTnfOaZABRsj/SgpqZQ
         FJDkzQml5AF7fjqSD7PDzc5p0+OmhZpmlinJtE8zEw+PHUDr3fMntFMx5IKDaVenpk/a
         Vx7xu3jdSl7SZvgr8RKosmBJekZIvkqGCPaxh+WVXVoKP2XEYUrQHZwGtDC1jQaKV1fn
         2fODSP2z/5bFlHV3fK2BZWd1mIQOmpoEWYrD12ifuBmBXBs+vx8hxRTVoamabrL6O+qA
         aJwVElIcrEAFgsqNu6iRpovFnZPMG6hbFgSuWG5fvxcUCD/T3hxsv5n7yq/Xk0zeoL/M
         glIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217934; x=1781822734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBXxRqTrr5JWKSddHPZ8Jmmc29dDcI85ARjTfI3iIe0=;
        b=dAd7mzWR93V3XE/m3RilkkIEiJQtAWD1kKdON9BmVtTJC9i4UW9IiJfcU9va56rdNG
         9p8eULhXlXmwO5WLXQL1U6CtppTItnnZBPpQOO61rFWUPdkg+1Ik9Qbd7/1143+FoO0U
         VCNidr4H340BamUDuFhvro8gn+x+n0aPK6T0TGlIuS7izFBORT5L2CbNdrwKbq0UMKUC
         Jjy5JAMaFjuTN7dydB/k1MTOyUbrad5pwzXco1wJjrNQbBjbztQifKczBSowenDB9+De
         VEdG4o9h5ZnLz3+3wBExkSopBzo+fmivkQsKIP0CFNRDMrbHppgeH72E9NOF1lBSqVH/
         gjRg==
X-Forwarded-Encrypted: i=1; AFNElJ+DRR7z+ej2fkWdVN/kIWHZO68o1QZfdQSRc5HRigdCjloKzVRAMrG/NXIfhWfI93vndig843zX3hp30rg0qY6Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwQN9wMNThvYCTNXbE25OFcFIdTGsFPyu2t5PsS7CDWBy3HKpRp
	yiVZZ5seamrE1PeFwfZTep0Qtlyi+T0eV35LWOB0RS8AD3ob57dKaIhyonkpiwU1JUM5Jkroofp
	BTFOAHbeCvQ==
X-Received: from dyz9.prod.google.com ([2002:a05:693c:4089:b0:2ed:8f25:962c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cd93:b0:304:df8b:71ee
 with SMTP id 5a478bee46e88-3081ff62e82mr204923eec.7.1781217933458; Thu, 11
 Jun 2026 15:45:33 -0700 (PDT)
Date: Thu, 11 Jun 2026 15:44:52 -0700
In-Reply-To: <20260611224455.201994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611171756.4008769-1-irogers@google.com> <20260611224455.201994-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611224455.201994-17-irogers@google.com>
Subject: [PATCH v13 16/19] perf python: Add syscall name/id to convert syscall
 number and name
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
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
index 56449183a9e7..fe332cb59862 100644
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
@@ -3951,6 +3953,40 @@ static int pyrf_session__setup_types(void)
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
@@ -3984,6 +4020,18 @@ static PyMethodDef perf__methods[] = {
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

