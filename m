Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7238F626
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156926; cv=none; b=YKPK/jEVT5tZgRzV/YCB70p97OwHvTFrmiNWts7a3iKSTlu2WR2we3jY0FpLQtY0D60Ky55Sr7XliwDleta9ZNIop3WibNRV9axkAmtpEEQRI96UkB6LyHFHfC/4ZL5jI6s58sdYyonZLANytqPh6arHgJZtju1xtQVE1HD8Dlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156926; c=relaxed/simple;
	bh=20COE+F8AnmEkDkK/TnYKsZ+aMgWybNxHdBlRVGcSpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O63NhDAfVvHZ0R8YWD8iEKYt2PW12Sv/lj7DCtPJxxzHER2tnCEn3EUuwmUpcbIDDBqYcg/9dbHpm9plubDAwsIcOK5kKkB84AYV88nn+FApLbNU/ImNMhvPbhAkNQlq7JSnHB0pbPmwuyPZa0j7IqlTsEE3gWsqXXG9sIYHbfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxwD2YuE; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxwD2YuE"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d93379001eso20009890eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156924; x=1777761724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmZaRmxvqC34085lIoL5dgTRYciZnOOQN4pPPp0OcBc=;
        b=KxwD2YuETM7SXBT9HAisSOZ2jQcZbfU1yZvUXZpMEKsg2GoIlJX1DFd9bpQ8KNa9mU
         xaDwBOVDijkWrqOrNSBeJx+h0tXgRkHe7Lm26EBhQdYAyhgdHo85JKfM/7FbEDjnnjuL
         YPZRN9vBk9ojF8gyKwKU6pkjbwXargP3mF+jIHccnDhWHxPavsx+HvYgm0yd3RupJDoQ
         bMkEG27oj+fcjrz/O5a2TxSfmRcYxR/CnjO6NLf3oWkUy1rQkQKC2n/YGMSm1ARefP1u
         GHnfePJZQ1YQzP3rLSGAVshJFnAeWgqqzNWcHZHGG3oz21lCEezAy/oeK6DYNWHMgQmN
         /FFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156924; x=1777761724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmZaRmxvqC34085lIoL5dgTRYciZnOOQN4pPPp0OcBc=;
        b=W7W8x72N6oI8JA8DIJdc0q8SdN1LZvkyhIprZfMfek2gQbLWoR3CrwS7ZcVpFZxHiW
         IK1G+ToHGu5xJYKesY8AHHrpS0HFSPw5kP4YN4G8/ZrJwhfOtxG6Wkb27FBFb676ACYL
         VW36Ybh14EWkLek5XZPP01uRlaqdxFSpvhvPOfydDYuw/hjkPsHKBDZP4DfEw+oTODX4
         g1jXZhvWXCr7d9X5bD/SzGCoKu7s1XVLvOmlcgi+TXiVZ2dYyz3OjOqvaw0LC9RtUqk1
         s17OxQMXHwDCEYp6/FL3549A0uG/dVTHBLe4iKhbj44uYntsAbBWfij5CF2ZdhYwaL76
         fSjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jBAldO0RwweBAxnmfxY98cDn7pJ4bBqw5vOQAxpMwsfmsmXJKMc9KPmh/KwsHtYIz47BxKB7l3A/XZrhtunCO@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw1YW0f58bubgtlscVg6PfhtH0jE3I42kdcHd0jVqZcAMbtG8l
	1fW0ETd9OO0+719kda/S65l5zIuBj3JIbMQw0zqZrGRJgYxMBFFNbOhJYLLFfenklZhVPzOXWb3
	qH2Y1XKGRwQ==
X-Received: from dycpv7.prod.google.com ([2002:a05:7300:de07:b0:2da:4712:5fcf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:f0e:b0:2e6:ff79:e34c
 with SMTP id 5a478bee46e88-2e6ff7a0431mr12080767eec.8.1777156924120; Sat, 25
 Apr 2026 15:42:04 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:41 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-17-irogers@google.com>
Subject: [PATCH v7 16/59] perf python: Add syscall name/id to convert syscall
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

v7:
- Made syscalltbl.o unconditional in Build to fix undefined symbol
  when building without libtraceevent.
---
 tools/perf/util/Build    |  2 +-
 tools/perf/util/python.c | 48 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 70cc91d00804..fd55d02dd433 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -75,7 +75,7 @@ perf-util-y += sample.o
 perf-util-y += sample-raw.o
 perf-util-y += s390-sample-raw.o
 perf-util-y += amd-sample-raw.o
-perf-util-$(CONFIG_TRACE) += syscalltbl.o
+perf-util-y += syscalltbl.o
 perf-util-y += ordered-events.o
 perf-util-y += namespaces.o
 perf-util-y += comm.o
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1af53480661f..861973144106 100644
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
@@ -2669,6 +2671,40 @@ static int pyrf_session__setup_types(void)
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
@@ -2702,6 +2738,18 @@ static PyMethodDef perf__methods[] = {
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

