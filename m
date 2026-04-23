Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F03C9EE8
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916573; cv=none; b=t9PJ5NJs8flXhRBGcjFJvbpq4KXmhmwC1U9h8+Okl4hRRTpt8dikmv0vtM9rdyO1e6DTGthb0hjusLEt6axVwR1/NwRDqWYJvAmZeMQv72MH+AGmGS7c/FZhMPyyAQXdpa/ktvWQUTCjCtBBuF9W/W4kngRMHpHR4SD+9EGl+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916573; c=relaxed/simple;
	bh=aNxoOrxPhxXzocB21tqQz2c3YEMxFCOU2og+CJ4jZHk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kWSaGapWTOdEKWkj52LtlafGdEB/Ma0ACwIP17ZlkxlhI62vMvNVlDIXolZqZsvr5fpEzbaL2Y3D1xnUKeE9HIt421qpXANX027MJL/aWotGm+qZxAr18UNeKAVIeY+ykRaYHyQptPYiEPWGgBwnaN8MiGnWUCl58OCtRRJE7Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WG31cPCM; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WG31cPCM"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c16233ee11so8467014eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916571; x=1777521371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQMISqSg3iP5UCcUJjXCXo87Ek+vREvOUQgiBf2+rIk=;
        b=WG31cPCMXrJecE+BB4XJZobNCaWd4Xk+UlawNQv97Eiv4b/BS96K/Qh4iE8Jm9voLY
         RRZbAVTy1wOPTWGTr6USMuVRPgrKd0Fb+AAVMvr4osil59WwasILIyhrccYt2AP5N0bA
         I1vAFq62BvzW6N8xAWdWpCRESTz2BuUY5/k6Fm7GU/otP0Edi1EVbp/UbY+O5/lN/lqv
         CKrNhYOyro/HGRRmxRyqygv56RcBtR6FA4BfUyxVYTp43/dqxo1Mdn25LhAvV4ubz0U/
         /w0L3uhHfICsvOn02M6879Eu0Vq68/vE3Psp0a7SJWtcy/XGPanj8ZSNX3nK6d4lz7jv
         w6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916571; x=1777521371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQMISqSg3iP5UCcUJjXCXo87Ek+vREvOUQgiBf2+rIk=;
        b=cJ1wIYR2VCz+sRujjNtSd/4TXEY4gh1U+zOtqgZvetRsKAjaSzdTYCFlRdN4K73BHj
         2NL81oTR9mktWGDGT/rRi++pbUSDxigsoH+kB6uWyBh282Uaa7pOBwkQ+g/+1tuSwumZ
         fYg373AtxdUeYTU7BS6rQ8PF3orVuRtlPGIpSB7SQ+betLjPE4jZ1tyEDA92YESptM4N
         Ka/jK/6h+9xr9Mk1940H/dSd/QSwa9eVt4pxdIgpNuH2RGzSlGtfFvM1HhALp8M8nuUX
         pndH4YsJic00hResTrx98UkcCk4rdP1Xc6macKkOdbLfQRoBbQM+s0blsvpu/9W7Xy5t
         FvxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JIir+Akwbk1idK69bJBiBNfS9JDvEmJ4s6FcL4u5FwkJFedWTJuRMPUW1mnhKKgHQhiOPMBfgLa5aRsbwrFrq@vger.kernel.org
X-Gm-Message-State: AOJu0YyGwaRGo20kwaT6rGSK/7OOn+u9trBLMn2pWBCzhEcwnccQAlaT
	N4X85/3utFj166guLxd5o8dhUxq5sROGbu3ShMZZckjDE77DmGXcvBUPw7UMFyuhrAMG3pPWIqJ
	tuyZGtCjYQA==
X-Received: from dycmx3.prod.google.com ([2002:a05:693c:2883:b0:2d9:a817:812d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:214e:b0:2c4:dd55:ffc1
 with SMTP id 5a478bee46e88-2e464ea4fffmr12938206eec.2.1776916570558; Wed, 22
 Apr 2026 20:56:10 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:54:43 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-17-irogers@google.com>
Subject: [PATCH v2 16/58] perf python: Add syscall name/id to convert syscall
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
 tools/perf/util/python.c | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 9cd7cca321aa..d90aa24e5310 100644
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
@@ -2632,6 +2634,38 @@ static int pyrf_session__setup_types(void)
 	return PyType_Ready(&pyrf_session__type);
 }
 
+#ifdef HAVE_LIBTRACEEVENT
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
+#endif
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "metrics",
@@ -2665,6 +2699,20 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_NOARGS,
 		.ml_doc	  = PyDoc_STR("Returns a sequence of pmus.")
 	},
+#ifdef HAVE_LIBTRACEEVENT
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
+#endif
 	{ .ml_name = NULL, }
 };
 
-- 
2.54.0.rc2.533.g4f5dca5207-goog

