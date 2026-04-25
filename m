Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B231E366052
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139375; cv=none; b=YboePT/TEaFOpsaiB5ITTQ4dr/hTsXZBjd+2UIfDNctiMLgn+n+7iN7tYMr7llNqzzSsUtquHVuidjsTuP0R57Rdlzbn4RgLYBw45AgWzwaDdDvFinzJuoIkSl4AqcMntwBn9RhLHxuQrCU+yJZMLSEM3WzKejVrs6UmCWI0UJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139375; c=relaxed/simple;
	bh=ya+t7IUOpRNk8Fu/0uERle+8OciY3+nM0FzIdh4j4hM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lrSkDXIpurtwk666Zf2AVx4HxX1eo0GdNe6zmTwomd2XIHt5HJFwwW6youQ7wSzGWmPVHEnNNYwScxrJxcii8kkGFRcm8va6+Ixu+H8H1lE8EnXr5KKUdwjXC51l1SBbDn2QqE9zymZRFc1vmAyI6t1Zf6meVq9550FNf5dJqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nvRHlznB; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvRHlznB"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdd327d970so5447042eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139373; x=1777744173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm4BzhaiNoNEhqaEIRecziDxpgSmNxYS1qVSWQUr3vA=;
        b=nvRHlznBYc1NpO7P6wfIX9PiHdlKmbreYJgEiz10qvbLuvVsO81fKvoKH+TV5QnK0q
         S9xFLEPPPKgqPirS0SWoQfqoUWU4hH+1uGJHsCBvILO7vF2TdoD8R8VDNbBi5SfNXpYw
         4ZToUAAlKAgsNfV62BovdMUO4Rr65loYR1yIt0D+FRl+sLdG+TJoUYoWgKRcIqtOhgU3
         xLAq2Eiv6txgA1cLDezkZovSFnb33RhT9sw3WoprxuXRRm954dotSJHPEIOZ71RRLJ+X
         1QLlaF6Y1d5u07zj2x75EXgGGpfosyS69MZVfnZ4+giMgJFDYorh7jDvSfcdFguH34rZ
         azow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139373; x=1777744173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm4BzhaiNoNEhqaEIRecziDxpgSmNxYS1qVSWQUr3vA=;
        b=isoxTbMQuO//dLbTD6G+DRi0H7Zd+27PCftyPx6deiTQkz0rsTnpgttGv4WRWVRWjU
         CPBSZq268DcBH0EiVx7dJsjIx/DAdTO+Po/Krh+IGwYarduTrWdmhXmESa65Xni/DtQX
         iGx+8TNB3VcFljb08qnvyfi0Oem/WPdrmDogA8z2iHcZhB5LeVEUYLQxwQdb1LRRYJFI
         LXVf8hZVhB9P0Ixv4TzJjzcyt2xpke2LzijzskIEQrnODGJ5lewAfsEW3t/qZ3ynkRhZ
         tB9e8pwlWZK021QQK5jyoK9Ov9F/oxHpFXrSyhSeKfpnNGo3JegIrz48eufIRoRCZ2Cd
         OZoA==
X-Forwarded-Encrypted: i=1; AFNElJ+hvmczQ4aY5U8Hd8U5MS4u0+FmnJdlHx+N9MSJHlM6L7MrefPH0ey9KZMhEsvz3ZJcs0SmmTAgPkOxfOTtbd+n@vger.kernel.org
X-Gm-Message-State: AOJu0YyzkYaJaXhv44mymwJFjXZpErPRp/HhhULwe+ZRBqo3yvrpt1wY
	2nq8ZYABkGkNqsXitHvm32NjK7zpEL0SKXhDUzu8AynMK3bPeK32Uw8lixoHL4tsd/T0p2sr6en
	jjkHbFgyfaQ==
X-Received: from dybta16.prod.google.com ([2002:a05:7301:6f10:b0:2d8:9b3:87f2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ec07:b0:2d8:4dee:6ad0
 with SMTP id 5a478bee46e88-2e42e20295amr14273592eec.16.1777139372620; Sat, 25
 Apr 2026 10:49:32 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:14 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-17-irogers@google.com>
Subject: [PATCH v6 16/59] perf python: Add syscall name/id to convert syscall
 number and name
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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
---
 tools/perf/util/python.c | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index d10359abd1ea..a10c4a292756 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -13,6 +13,7 @@
 #include "counts.h"
 #include "data.h"
 #include "debug.h"
+#include "dwarf-regs.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -25,6 +26,7 @@
 #include "session.h"
 #include "strbuf.h"
 #include "symbol.h"
+#include "syscalltbl.h"
 #include "thread.h"
 #include "thread_map.h"
 #include "tool.h"
@@ -2635,6 +2637,40 @@ static int pyrf_session__setup_types(void)
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
@@ -2668,6 +2704,18 @@ static PyMethodDef perf__methods[] = {
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

