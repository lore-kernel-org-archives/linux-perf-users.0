Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F893E9C05
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187159; cv=none; b=LE7Pn4KN6m3USJt81IpZin+iYF/9GlcPo5CSuhzKSKtXWinbVox1uujSAyQp5yiC0o0axAstNqJA4+CvtlgG2YIjpXHuJkOVOL1ZkSjhkEYEsfd5iURD/Uxtsez4lprXci8Vh+Ths0Pk/r+96zDqah+ZJtW1E8A3px8b6lF/b54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187159; c=relaxed/simple;
	bh=MeFoiyK9aBByvzZF0hUbBOHobo1DVtP7VskXXC8rSdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UBtCNiSfuQWTYM/lekJkoE7rH8bEadAmiV+fjknEuTYcllThpaqUGOJgOuud/tik1WEbDomTD9or2INggM7VGwO/uhp0eqw+NaPZZeBLE93tWg1dEOx44tfZn7PZlXRz6AQ+UprtHnjNBYcywI4ldCb6f4uDdXvsW/Cd5XpNo7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RRaypwt/; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RRaypwt/"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14371f7ba1eso1903433c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187156; x=1790791956; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WW14NGzc/NEGWV8mfByYeJ/e2Khj11iCWX5m3BJGOq0=;
        b=RRaypwt/aEUIZvnDrgXsmCgdH3waj+AZSpyuzy57SnxTP64B2rW0iZ8fANFDdzQ3XY
         IsrQ0JIfSUvSnFfnGr4R3If2GCq4fQxvd+RXkV7fpwQ+rYebWadryHhf5tr5ZN/iHsgd
         OGvuDeAjgn+63bJJ03VGZiXxt9L+e11yX69afPc8b79FgL6NKduBAug6tLZ0b0BZuWjH
         O9GTdxGIIthYEA6SrTMwAx8mQBHGIvyMivhDnsVXeHklPyP0QMIT4MSxyZaLOIOyEoKn
         j7vlBU85F0hluFG6cqvS/18w3wWeIB1AXU2Gjg1HbYe4ot/YB005YJaer579J9UpWsqC
         Ie8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187156; x=1790791956;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WW14NGzc/NEGWV8mfByYeJ/e2Khj11iCWX5m3BJGOq0=;
        b=jdlYNe4EsvV+hH+P5N4rPtBuiDyIIQpLY0ymHWTLqpbhqv5j6SP13F6/ERfpKojrD0
         DfeyBPAwfXWrfI9YzMUqurVHynYaunO5y0yuUQXJXufljYrsScXCAYVHZpF7bu8Stkal
         g6d+mvBXvwm4Imq9EQbIWJls9iUWkYhxiQVWnzwH92Rg9GO0nPcXD8V6RIazwAPJf+Q6
         9/cSHq3m4hnKs+JHQs+wS8X9n7qBoC+95iNlW8n9Ae9z5dlv5Krtpa9ZCX77rlt7MOKM
         OoQQUWZBiFn1xq+/vO7cchOha1UeiAaABZo1tWos15Ok52FMkdVqWcuHMUNZlTaKcOLB
         Mb4A==
X-Forwarded-Encrypted: i=1; AKwUvBzF/ZAvdQSepdK8ubalMTAouswkWVm+F51U21KyIi2dQWk4qahCxTiUnCBLt6Vhb7fN2qZ34DJH7ibd/5lsRmmz@vger.kernel.org
X-Gm-Message-State: AFuF++kBctWxszYvJ9F5iHpvsTHLc1ltoHXQQc+GqGv+2GDjncBXQ2R6
	N6PHXzn+7V6vDOMa8zTXub2krn4Oc+HkUM3MyZKLk5IlO03+7c/Ii/cWZ6x4kIUFqXGDMjdIm0X
	Pu5+/XGKOdg==
X-Received: from dlea7-n1.prod.google.com ([2002:a05:701b:4207:10b0:144:e5a6:137a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:458e:10b0:144:e246:a0d8
 with SMTP id a92af1059eb24-144f916a133mr3287893c88.40.1790187156051; Wed, 23
 Sep 2026 11:12:36 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:24 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-2-irogers@google.com>
Subject: [PATCH v3 01/49] perf python: Update syscall helpers and expose arch_strerrno
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Update the PyArg_ParseTupleAndKeywords format string for
pyrf__syscall_name() and pyrf__syscall_id() from "i|$i" to "i|i" (and
"s|$i" to "s|i"), allowing elf_machine to be passed as an optional
positional argument as well as a keyword argument. Update syscall_id()
and syscall_name() in perf.pyi to match, and set the return type of
syscall_name() to Optional[str] as unknown syscall numbers return None.

Also expose perf_env__arch_strerrno() as perf.arch_strerrno(err,
elf_machine=None) so standalone Python scripts can resolve
architecture-specific errno names directly from the auto-generated
trace beauty tables instead of maintaining duplicate errno dictionaries
in Python. Tighten the macro pattern in arch_errno_names.sh to
E[A-Z0-9]+ so compiler -D flags containing underscores (such as LLVM's
-DEXPERIMENTAL_KEY_INSTRUCTIONS=1) do not shadow EPERM (1), and add
EM_SPARC32PLUS alongside EM_SPARC and EM_SPARCV9.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/perf.pyi                  | 16 +++++-
 tools/perf/trace/beauty/arch_errno_names.sh |  4 +-
 tools/perf/util/python.c                    | 60 ++++++++++++++++++++-
 3 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
index 58b0b3ed819d..c390e17708b1 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -20,7 +20,7 @@ def metrics() -> List[Dict[str, Union[str, List[str]]]]:
     """
     ...
 
-def syscall_name(id: int, *, elf_machine: Optional[int] = None) -> str:
+def syscall_name(id: int, elf_machine: Optional[int] = None) -> Optional[str]:
     """Convert a syscall number to its name.
 
     Args:
@@ -32,7 +32,7 @@ def syscall_name(id: int, *, elf_machine: Optional[int] = None) -> str:
     """
     ...
 
-def syscall_id(name: str, *, elf_machine: Optional[int] = None) -> int:
+def syscall_id(name: str, elf_machine: Optional[int] = None) -> int:
     """Convert a syscall name to its number.
 
     Args:
@@ -44,6 +44,18 @@ def syscall_id(name: str, *, elf_machine: Optional[int] = None) -> int:
     """
     ...
 
+def arch_strerrno(err: int, elf_machine: Optional[int] = None) -> Optional[str]:
+    """Convert an errno number to its symbolic name.
+
+    Args:
+        err: The errno number (positive or negative).
+        elf_machine: Optional ELF machine type.
+
+    Returns:
+        The symbolic name of the errno, or None if unknown.
+    """
+    ...
+
 def parse_events(
     event_string: str,
     cpus: Optional[cpu_map] = None,
diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index 8751bfa4a2b2..e75cd5bc4328 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -46,7 +46,7 @@ process_arch()
 	asm_errno=$(asm_errno_file "$arch")
 
 	$gcc $CFLAGS $include_path -E -dM -x c $asm_errno \
-		|grep -hE '^#define[[:blank:]]+(E[^[:blank:]]+)[[:blank:]]+([[:digit:]]+).*' \
+		|grep -hE '^#define[[:blank:]]+(E[A-Z0-9]+)[[:blank:]]+([[:digit:]]+).*' \
 		|awk '{ print $2","$3; }' \
 		|sort -t, -k2 -nu \
 		|IFS=, create_errno_lookup_func "$arch"
@@ -69,7 +69,7 @@ arch_to_e_machine()
 	riscv)      printf '\tcase EM_RISCV:\n' ;;
 	s390)       printf '\tcase EM_S390:\n' ;;
 	sh)         printf '\tcase EM_SH:\n' ;;
-	sparc)      printf '\tcase EM_SPARC:\n\tcase EM_SPARCV9:\n' ;;
+	sparc)      printf '\tcase EM_SPARC:\n\tcase EM_SPARC32PLUS:\n\tcase EM_SPARCV9:\n' ;;
 	x86)        printf '\tcase EM_386:\n\tcase EM_X86_64:\n' ;;
 	xtensa)     printf '\tcase EM_XTENSA:\n' ;;
 	esac
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index d8a842621cda..6ff0b4ed0bef 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3,6 +3,7 @@
 #include <Python.h>
 
 #include <inttypes.h>
+#include <limits.h>
 #include <string.h>
 
 #include <linux/err.h>
@@ -25,6 +26,7 @@
 #include "dso.h"
 #include "dwarf-regs.h"
 #include "event.h"
+#include "env.h"
 #include "branch.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -4104,14 +4106,35 @@ static int pyrf_session__setup_types(void)
 	return PyType_Ready(&pyrf_session__type);
 }
 
+static int pyrf__parse_elf_machine(PyObject *obj, int *elf_machine)
+{
+	long val;
+
+	if (!obj || obj == Py_None) {
+		*elf_machine = EM_HOST;
+		return 0;
+	}
+	val = PyLong_AsLong(obj);
+	if (val == -1 && PyErr_Occurred())
+		return -1;
+	if (val <= 0 || val > UINT16_MAX)
+		*elf_machine = EM_HOST;
+	else
+		*elf_machine = (int)val;
+	return 0;
+}
+
 static PyObject *pyrf__syscall_name(PyObject *self, PyObject *args, PyObject *kwargs)
 {
 	const char *name;
 	int id;
 	int elf_machine = EM_HOST;
+	PyObject *elf_machine_obj = NULL;
 	static char *kwlist[] = { "id", "elf_machine", NULL };
 
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|$i", kwlist, &id, &elf_machine))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|O", kwlist, &id, &elf_machine_obj))
+		return NULL;
+	if (pyrf__parse_elf_machine(elf_machine_obj, &elf_machine) < 0)
 		return NULL;
 
 	name = syscalltbl__name(elf_machine, id);
@@ -4125,9 +4148,12 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
 	const char *name;
 	int id;
 	int elf_machine = EM_HOST;
+	PyObject *elf_machine_obj = NULL;
 	static char *kwlist[] = { "name", "elf_machine", NULL };
 
-	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "s|$i", kwlist, &name, &elf_machine))
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "s|O", kwlist, &name, &elf_machine_obj))
+		return NULL;
+	if (pyrf__parse_elf_machine(elf_machine_obj, &elf_machine) < 0)
 		return NULL;
 
 	id = syscalltbl__id(elf_machine, name);
@@ -4138,6 +4164,30 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
 	return PyLong_FromLong(id);
 }
 
+static PyObject *pyrf__arch_strerrno(PyObject *self, PyObject *args, PyObject *kwargs)
+{
+	const char *name;
+	int err;
+	int elf_machine = EM_HOST;
+	PyObject *elf_machine_obj = NULL;
+	static char *kwlist[] = { "err", "elf_machine", NULL };
+
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|O", kwlist, &err, &elf_machine_obj))
+		return NULL;
+	if (pyrf__parse_elf_machine(elf_machine_obj, &elf_machine) < 0)
+		return NULL;
+
+	if (err == INT_MIN)
+		Py_RETURN_NONE;
+	if (err < 0)
+		err = -err;
+
+	name = perf_env__arch_strerrno((uint16_t)elf_machine, err);
+	if (!name || !strcmp(name, "(unknown)"))
+		Py_RETURN_NONE;
+	return PyUnicode_FromString(name);
+}
+
 static PyObject *pyrf__config_get(PyObject *self, PyObject *args)
 {
 	const char *config_name, *val;
@@ -4202,6 +4252,12 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_VARARGS | METH_KEYWORDS,
 		.ml_doc	  = PyDoc_STR("Turns a syscall name to a number.")
 	},
+	{
+		.ml_name  = "arch_strerrno",
+		.ml_meth  = (PyCFunction) pyrf__arch_strerrno,
+		.ml_flags = METH_VARARGS | METH_KEYWORDS,
+		.ml_doc	  = PyDoc_STR("Turns an errno number to a string.")
+	},
 	{ .ml_name = NULL, }
 };
 
-- 
2.56.0.rc1.310.g51773c2048-goog

