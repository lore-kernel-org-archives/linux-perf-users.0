Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324173A6F06
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962095; cv=none; b=l0vIeUrJGEPqJMPACCW3N6IHnzICkZHRKtVnnJVbYWUrVfcww2yDkAc4rTXemCMdDXBIPySMtgkYrDso/uAFJz2MLnIqTBtxuE0+rcnF4twteoTGPczYNqApmCsI8ZBJpXL4rpe3iix71pus+tMlaaP9Prpyt31ThAKU67DSQ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962095; c=relaxed/simple;
	bh=/WAm6bqeJBhq2D+iKPcDWe1EhSKPK75SqyvYyfliOWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JTkiUmES9jT+sFL/fox81SGO0aPn13a8XEWLUGC+c1ZwpSkC+eEF0FgsMcjKcBx5+XK/rZadnZqqjGjiPNxDm8/B7lEd/SBJBo3TDNBCowfZgf3TM0SzE6fQgSTkLd1FJeNtCE7coMgwX9UI2UfFIKjUwORzfStop7fvPoktnc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eijyD7Gl; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eijyD7Gl"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so7408647eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776962092; x=1777566892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWf6Qami7NRlFpvOBe8d9c6H2MSbHEw6hdBOQg4jYMQ=;
        b=eijyD7GlRmilElDvgKiG4OmKCNFwafugKzj1DcCuK9Al87F+ZOESwLMyQ9sjkPkeVa
         n69Aq8wpsN90sKK2K43+Ub/1IgxB4g9mrOIqFKU/jml/Nr9IwxQ4wBmS4vX+XbTL/fQW
         +ilX+tzjQUPRJAGFjq301BA1LB4CyNGiuKOhkKalizDZwO1lVEeqLWbxnDxCC09h8nrr
         zW6Wi/6tkLKptrq/3sL0Ih/njnpTtOZymwNJlXCepXCQbQ5vTgGzmEfsKUGq4qs7g0T3
         famJeOp6yR2edQUj3xWAO7McO9YBfJDeyfCdwtqZgJuiu70qXI0nLQRuANMcNm40n/Vj
         AMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962092; x=1777566892;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWf6Qami7NRlFpvOBe8d9c6H2MSbHEw6hdBOQg4jYMQ=;
        b=p21nNhFXKC/pMuF3E77VIQ8Aysr67pfKVi/iG9XIVkb9fu98wmkxb+rZc4YBjE3RQR
         zw1V68RBLR4E61TMKRKgEtwuydlfYrK7ohbBkq2wG67KAdzgN2NrHqLDs50Q7rMFo66k
         WrJTp5sa/9/SiYSVJFQh6flKqnwr9JuvzaDBRsZqvQCayi3VNzIoxWVl9pzSxO8cAZa4
         oyiokuIGTMZwdEacfDxI0NaCjot/jHe8uYaau60t/LZ0TaKpjbCoObaQ4VN5Y6jN4lbt
         Nod+fv718LmGprVS+Q+oivYpFXAmZUaoyZzvxVNs/je7Rts8tS6nOm5ggyX/Q9JrJsN+
         tWpw==
X-Forwarded-Encrypted: i=1; AFNElJ+YMJjzUkmSQ6SuD6ZZodDoPfxvXsOaW2LvIBqOD1lyv97DD11JfPQcCEq8v/HRpy7qIVfc3GgI5QYeZv4pLRYc@vger.kernel.org
X-Gm-Message-State: AOJu0YxPotVWmv5mO09jcgFWG8CjjdaCpfXHUlrn1G58+11+bxd8mRai
	xV3XvwDSF/C8lInRB1Hz+LjqIf2dAqVYNDlIo6e+S0HmF7HpBT9Z2RWfYWFb3W7pZnnGzKk0ZC1
	GaEXhY+j0SQ==
X-Received: from dlak21.prod.google.com ([2002:a05:701b:2915:b0:12c:71e:5ab3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:48c:b0:128:ca83:5aa3
 with SMTP id a92af1059eb24-12c73f6d910mr15777795c88.1.1776962092033; Thu, 23
 Apr 2026 09:34:52 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:33:24 -0700
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423163406.1779809-17-irogers@google.com>
Subject: [PATCH v4 16/58] perf python: Add syscall name/id to convert syscall
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

