Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAA7393DE9
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960643; cv=none; b=WAHqocnajEFWyulFI+jczHnq4OGjZf2K9baYsUtt/Fqo8JP+dRr4+/1xq9lK4WkidMZmllbyeAAW6UrtP31/Q0rVLhU2VCtJaDgjRKC+R16QN2Pb7Z7wnVpg4UQ2h0esCdjanjfVxT3cmgf/J6yWLW3zUzXlKt+oiHow69HUlFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960643; c=relaxed/simple;
	bh=/WAm6bqeJBhq2D+iKPcDWe1EhSKPK75SqyvYyfliOWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q+VveICCLSYaK8RlesXt3SglqjlC2O5WyKcuEPQcGkm/Ho5NGM1mchejQT4z8ttYXIjTPIs3NS9ECTeSrjNByXzb30rSRAcRMKQ3yS65jesp8d++c0dSqy5yw7oB2B3yYtJstdF7E9YEZu9lyXCC5zmmQ7ZhVcpBGxNfaJaFaAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6+uRdSV; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6+uRdSV"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1275c6fc58aso9741213c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960640; x=1777565440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWf6Qami7NRlFpvOBe8d9c6H2MSbHEw6hdBOQg4jYMQ=;
        b=B6+uRdSVh+Y+VOPhGl7yvAULqUqqvpQlsS8ejHW4SUVN70gv95pAIghoqpqEfLgyc1
         4NvoZyRfPAWYGbeheZIjEWNrrdG2E/N5wzdNomVafMtTRKMARWFurehwFDsUnHg0pvRg
         ZFad5YyLauQ/x1cZjENgjHPziF3DAGxedN3nHAnAo9TJAkyxrB1XGVSa+1UD0MXnZz30
         F0ZA+lrxDSTEixIKV1eettZNaHxYeYcX+rS0cYb9o5JHZ2USSM6Kd3+C2ti5ewrwXQo9
         kJTBN7l0yCu3WZ2Yr1AQLcKSPj9nbH/TLLqv27lKfgGV6RkzYeeha4wQPB5dDOjRsBs/
         SKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960640; x=1777565440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWf6Qami7NRlFpvOBe8d9c6H2MSbHEw6hdBOQg4jYMQ=;
        b=bMjZ9AL9lvQqbry+WRcdiJHl9yNg9mhmPXjBYR093VfoIIu6QGSmmAHwtGdEvxq9R/
         Emk6TOt2FEmiJPTcDkZyRKVMNl+dIpn9jBPG/HkQL0TeGFpukyFaokbolCjzL0rb3+cJ
         wz6lePNmR4PRxUQgxV6fLGGN+G1BAkEf8T4R/DWXer5VK2WvDKZ3ZYpC5sLcG+YUDrKH
         G/3amqIOylmFaJrS5PJSIHm7VI+Z+UR6P9VakHerSZuqG7NxS5R6GUjNxxSK128ZTbDI
         8W567Nw5dSJPXf/ivvhOv7nDu8rjBDDzbib0hzZzkwncTX411BXEvLWIiq/kXwiaAOIi
         6Anw==
X-Forwarded-Encrypted: i=1; AFNElJ96mo+fsF/4kTe1TjR+2SdJlgFV/bIMsFSQ7BRTY12sArVw5SHU+n1bi7/sMz18jkFmM/pfpgJOBCq53DgpoTfJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxKzw7R5bQmJbjaYJhspEgRUeW14u1sRLWxNo6EtdNV6dQ/wleM
	596tS3ubfMzk39PhzUJP72sjoa3NOAcoSMBn9HjWeNEN6j3HsrJmDnyLtOulMxiX4T+ml5Bolau
	8RwIB78pDiQ==
X-Received: from dlaj14.prod.google.com ([2002:a05:701b:280e:b0:12d:b28c:f5d6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f9c:b0:128:cf70:9042
 with SMTP id a92af1059eb24-12c73f99674mr13823475c88.18.1776960639927; Thu, 23
 Apr 2026 09:10:39 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:22 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-16-irogers@google.com>
Subject: [PATCH v3 15/58] perf python: Add syscall name/id to convert syscall
 number and name
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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
2.54.0.rc2.533.g4f5dca5207-goog

