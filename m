Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB53382F1
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049303; cv=none; b=FhtHSRbft6ZJuLa0PCf5DBqLGIUwJC5n+a1mL5JnkhbEoddG8ydQKbookTAbCjjAlBcuBFXNno/yrMQe/NSwzY6Ys3vbzKDntsJoP47/5AUT1gSgPd+VJkWDh+h6YkKOJReYJqfbtOsr4xvVJ9btmM8k8FaTCJZ0gK4dykl1zKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049303; c=relaxed/simple;
	bh=/pBRBsqgb+bUY9O9xJ8s7X9riO/Y3sr4uo9e5IWSu4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VgO/niHZOsOvMNIV63WsGxJHHqnFXQTYaHhd+FltIU/Hmuxm9GxowntEZto5U3UJBWBmP9pI7XRKTXlU/UR6NBa80oJ4zKwiEwkdCY2eOBdsnPJLPrX6U07d1Cc+j7HyZfDk3lnwV65bwezkFY2bjcvfy3y+nQoyr4JU8xkRaBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q5UNYRaF; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5UNYRaF"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bda35eab74so7010910eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049301; x=1777654101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TiCzqIIsCpDeADhoki4N8x1LD0SbRK3k+MFHddyXRA8=;
        b=Q5UNYRaFF0KqYFZrbW8FTmxX8w48+ECy+bT5xOCYj14wYrcixQPQL8yo8mRbHY8bG2
         tj540r1AIIc7SZLAgAYen2RoGu3cHHNq5o+9HFAov81AnQF4CY1aoA/JIkJnfiXCfdi2
         J9jc8VM0+2sgZFTWzfE4pB1y8xSup64ralilBEinTLrIiV32WihteALdYlveF/dS+BOn
         pI394AmY66wk1+1LpZlQ5DrtmKM1NEUkFqFsfKmfUmNzKFChoEEVJajcFcxmWEGUzfFG
         jdFJd3mcTeIEpzwD9gx10T+ZrWH23mlLOChv99/zulwwEZreXmQ6clEEA3+DRSn3x5kD
         8wJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049301; x=1777654101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TiCzqIIsCpDeADhoki4N8x1LD0SbRK3k+MFHddyXRA8=;
        b=bwPvQ9Dz3uZ+JrDFj7RPcR/CvUjrwtIiajAe/y8E4BI7PoQA+G75hN1x1mJCa6dRnq
         fPQ/UwrQzDOWmFmE1EFoAjMQ2z3TkeUAsuNxX9qq9LXAwEjShf2P2OSi4iZY4n/8Tz/e
         vkxWbQkQYgBKsLPmDQFPM55ixDvASryeH6Y+Ut2rao2/qL5Vux9LXRtSVIT7pB7H7rqW
         9HeA+obcRo6lKdOw6ARhkFfz2Wk2mw2zQMs89gEJuP5FyEP8OpJaQeF0Wz8HZsrNKz4r
         KAjS8f9yhMusZutNEis2xVIxi8Dn4yIlZUnHlbWpemG7U5Tm8+xRafrSHCMOwn63Shf9
         DidA==
X-Forwarded-Encrypted: i=1; AFNElJ/Nzc2GHHdAw1rCvL5J+qpr2ZwQ8K0bShYCh/ymeLOY7JprcwMzsH3j1x1VqVM+FmiHIGSmh6CA7xvCKi0/VtMz@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZjogrnYZHcpD9Jg1eSaxkZWWnIeslKm/oA7Skge/SB/V2yWR
	Q9jzSUvQMWnHm8DnmTXTXrsARd45FketMaxRbsWo/62WtP+JfZP0khzwE36GCDs+jlhMw6Fb4Ui
	789SizOQq7A==
X-Received: from dybbs6.prod.google.com ([2002:a05:7300:a206:b0:2df:75ae:2719])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2e88:b0:2d9:6652:524b
 with SMTP id 5a478bee46e88-2e42e201f39mr11442254eec.17.1777049300798; Fri, 24
 Apr 2026 09:48:20 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:38 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-17-irogers@google.com>
Subject: [PATCH v5 16/58] perf python: Add syscall name/id to convert syscall
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
---
 tools/perf/util/python.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 35eda69a32e1..f240905e07d6 100644
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
@@ -2635,6 +2637,36 @@ static int pyrf_session__setup_types(void)
 	return PyType_Ready(&pyrf_session__type);
 }
 
+static PyObject *pyrf__syscall_name(PyObject *self, PyObject *args)
+{
+	const char *name;
+	int id;
+
+	if (!PyArg_ParseTuple(args, "i", &id))
+		return NULL;
+
+	name = syscalltbl__name(EM_HOST, id);
+	if (!name)
+		Py_RETURN_NONE;
+	return PyUnicode_FromString(name);
+}
+
+static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args)
+{
+	const char *name;
+	int id;
+
+	if (!PyArg_ParseTuple(args, "s", &name))
+		return NULL;
+
+	id = syscalltbl__id(EM_HOST, name);
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
@@ -2668,6 +2700,18 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_NOARGS,
 		.ml_doc	  = PyDoc_STR("Returns a sequence of pmus.")
 	},
+	{
+		.ml_name  = "syscall_name",
+		.ml_meth  = (PyCFunction) pyrf__syscall_name,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR("Turns a syscall number to a string.")
+	},
+	{
+		.ml_name  = "syscall_id",
+		.ml_meth  = (PyCFunction) pyrf__syscall_id,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR("Turns a syscall name to a number.")
+	},
 	{ .ml_name = NULL, }
 };
 
-- 
2.54.0.545.g6539524ca2-goog

