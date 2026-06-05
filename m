Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA684D98F8
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686966; cv=none; b=XKoRcf2RgvY9cjrzE0s5F2sXGu7AztsfLFUiKE6hV+2YTkyJ0mLLNUcG3ivqJ83qBSx8dGDdOoxfs3cPPHc7bxESVulvgaFjJDpNJIOIC6Me0gqq8vTjR6FKg0Yw8YlJI8VVGP7/pKtmlYQOUsS63leriYhNNx3OCCywChwIv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686966; c=relaxed/simple;
	bh=LvH7XaZ13QCjz/HSLWRezOA6nF11nDquatU+ITVlmO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lxUEO7YMMpbGHTsclepzR415095QcwlY8dGpz+/r6zSSU+uCSIH5WAPQNoqAgaEuUppzy5CiKlRpCYaOUfEPiPz3aBfGvAAfo0n3/96aWAkTTB80XwqtUVadGahD8wU13r0I+Lx4PMrJF1gxr8Sqn/qcyyymFLOX7GgxkAwrYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTbd3Be9; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTbd3Be9"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-307625ee07fso4287717eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 12:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780686953; x=1781291753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IsvRcLx17k/Op5bsqmRrLW9Bjhn9K64oYOXZ18feBi4=;
        b=XTbd3Be9z8CAEqWtkgbbA9gepF6Faj1OFzw3xw6TGMDNF8KbSQJshOUHVGT/sFDWoS
         u9VJeKMOzxHB88tiNMlOCdRrVl+LcYihP8M4tBpWk+r7ruHRjYF+0XQhwzuxUbhbbm5v
         B+qCi7bfx9r7a+yJF+qWarryhGQCETL7BHFyE/Ra40RyoRpfEjHrzCxabwouHpch/4kC
         oXkBJpNNh+8NNO2TmMuH3em8fA7VvubmXqHpc5qNInZnrJbWztmcX9KDncPY3NT63L73
         CecCIU4imWBu2gLCQ1edabHo6ObV/HiBK42Vpo0VKKdsK/BKz4s8G7+UIL05Ld1iAE1v
         DRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686953; x=1781291753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsvRcLx17k/Op5bsqmRrLW9Bjhn9K64oYOXZ18feBi4=;
        b=YRH0KwChurQarPHWY4AEEozplzQhTViXFxUknJIhpWxFznt0UUHtMAy38KJ4aV1RmF
         hTDEcbeYkncJET+QWzdr42I2hEnTI9xGuaBB2gAOGdxmxLnjTCKXdmnN3d8VLmGWPWWr
         y2km1G9B+nW34tEplT2CKitPm9a3TDy3T5Kj6EIG9C1Gutv4ToPUHC6HULNmCJReQvo4
         f+VklVjT0AzIF1hkO+RYnM1X25OLFP64Trj9WwmntXSHe9ctmXnRSy0amPMd7muthEmH
         GcJRc9Zmx7T92UKBHq2YxFvX/nueGTsBGVM3pQV5h8x25QYoBuxWQKN1BBYwGyHi/OvK
         rNLg==
X-Forwarded-Encrypted: i=1; AFNElJ+/1BjMg/NFgRmqj/QRoH18vtwX/jaI9S93XcBZ3mhQJ6AxvXb168uR0VZ0jaT1Fox6em+ivE+vjxYW5cgE304s@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu3Qk8aauRmZHpJ31X7OPJvzMwEAT88z63uSJ8UdpE1t4k4Hck
	Z6m1PuxI7IBio9FGWquJvphpyTzztHJi3FX1I5NYEj57h4nCd3vg/QE/xxWRgvg/qwWpFWUClBi
	FbSmfLbDL+g==
X-Received: from dybrh10.prod.google.com ([2002:a05:7300:f00a:b0:304:e34e:e1e1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3b06:b0:2dd:6937:79b8
 with SMTP id 5a478bee46e88-3077ae6f714mr2591891eec.5.1780686952305; Fri, 05
 Jun 2026 12:15:52 -0700 (PDT)
Date: Fri,  5 Jun 2026 12:14:57 -0700
In-Reply-To: <20260605191500.2477026-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605074003.1730715-1-irogers@google.com> <20260605191500.2477026-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605191500.2477026-17-irogers@google.com>
Subject: [PATCH v11 16/19] perf python: Add syscall name/id to convert syscall
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
index eabc71c1f9a2..b4baf8cd79fa 100644
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
@@ -3938,6 +3940,40 @@ static int pyrf_session__setup_types(void)
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
@@ -3971,6 +4007,18 @@ static PyMethodDef perf__methods[] = {
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
2.54.0.1032.g2f8565e1d1-goog

