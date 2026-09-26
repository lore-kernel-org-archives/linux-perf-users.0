Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDF435B137
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403656; cv=none; b=j9plasIJPsNFTE7hHWUdz2kkfhzIgoPz45rnhjIoWxcCrN52Bbmf2Wu6VFbkkMx7NYXuER8amBIzrzBrxp4qyuGdVodhtaPNX16vvF60nUFi/2xUPWQnsU7j79NcmVaWIVPT6Yu1oddY3RxxexSncHxlxLnf/p+cdoE6jhAj4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403656; c=relaxed/simple;
	bh=YOt3uoJUHdcMrsQJfwrr1AXGNldkmipoWrW0BdGOPeM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AvigADgCWAGh5ynU38cFYx84eGywHPmaaHKAMySkFZczOBvGdeuimN5nBduj90lI5AxWkey3rXAp+evL0c7sS26Agc01Wy82aKskW0LCzSsHgkwd63SV16gPvMqbgyoGic+riSDUytI6d6G8eJx+g5Vln0KVBLoSBPOR66Hascw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rw4JLcJS; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rw4JLcJS"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso2587001eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403654; x=1791008454; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MDS5BHYaRDgH3V+Wvztdr1PPm5zHCGPQu8geXdHU8Ro=;
        b=Rw4JLcJSVaUdXePIy91DJ1y1pTtxSmkMYie0j8iw4OuVQ2RPOYfVUNM0J7A03i4Vrp
         QB/ktAQAwT+cUD8syXM7OWEMIJLHcga1hAgj8BZSEJLV5oKiapSeEmXP+EKCLnlaGUO/
         6uShpPPICFMXelG7LZtj13mbDgyK0umOmGtyRv3oRMOAC7ty1shQPzcQV0Gopm3E5AJt
         5Zh9NW96x6nXkkvxliLJ6bfGbBfkE5IlQ38kVTiILjQ+5X1RgI585NbWznMZBOROGIfr
         HbMpcCNh4jvVMxGZrC6wyjunqlVQIXNWkRNydEamLrpC3cuV0x84H7NHrFIusOqFSwhF
         HTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403654; x=1791008454;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MDS5BHYaRDgH3V+Wvztdr1PPm5zHCGPQu8geXdHU8Ro=;
        b=B/mGJM/nJSOMxkxWpRT0FhLsJa/1X99ht9JBZKtNGhvPyt1+CXApcYUV153kOqVwkV
         7o0UElvmxNJQKXEzaAqNuna83547eob11AXU/CuhYJ5v1h2cbaUHXghRrTZHKVjHRh4I
         Ug095cbxpE2zYFTXR2W2aO5Hbnhv7JNoeBeOG8M17TnLuh2DmEAzBSWvQxHC4f7upsOb
         wCiyTGcW/Vz8gxQGGlSGW371Fg0slkm85kcWOM6xCEztEs+T+UqfnI1F54SKPiShOEmo
         Dieq69DjAhvEt+nIYBRAYniEjRrJL9f4O9J8Qx6vgD2bO19OgpJCZsphPEiRuMfMB7rM
         dTnQ==
X-Forwarded-Encrypted: i=1; AKwUvByfxkJ4H3lAYVzBih/utHvfcW9AhMkzoW9PPGFmlwOiqLzBlfG0Z2JEOJfqLJqSVe5KT/ZemWxsfs36nwICbpDQ@vger.kernel.org
X-Gm-Message-State: AFuF++lqchW6mTeYbtFnRcL5dW9GiWcwdsNi8Bg7qK4EJh+7X9tGWmwq
	pEqMqssjXDSEP0ZQVW/i/mIaRPVPhEwfme8Z7evckZOWz02qVxVdZ4RNo4hq3YKGhKjOESnXHbr
	bRL3WDhOMIw==
X-Received: from dlx9.prod.google.com ([2002:a05:7022:89:b0:144:cdf0:6a43])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1588:b0:147:5149:d108
 with SMTP id a92af1059eb24-1475149db52mr1120509c88.43.1790403653441; Fri, 25
 Sep 2026 23:20:53 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:28 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-2-irogers@google.com>
Subject: [PATCH v4 01/49] perf python: Update syscall helpers and expose arch_strerrno
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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
 tools/perf/util/python.c                    | 61 ++++++++++++++++++++-
 3 files changed, 75 insertions(+), 6 deletions(-)

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
index d8a842621cda..543312c99c20 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3,6 +3,8 @@
 #include <Python.h>
 
 #include <inttypes.h>
+#include <limits.h>
+#include <stdint.h>
 #include <string.h>
 
 #include <linux/err.h>
@@ -25,6 +27,7 @@
 #include "dso.h"
 #include "dwarf-regs.h"
 #include "event.h"
+#include "env.h"
 #include "branch.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -4104,14 +4107,35 @@ static int pyrf_session__setup_types(void)
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
@@ -4125,9 +4149,12 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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
@@ -4138,6 +4165,30 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObject *kwar
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
@@ -4202,6 +4253,12 @@ static PyMethodDef perf__methods[] = {
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
2.56.0.rc1.315.gc6ed9934b7-goog

