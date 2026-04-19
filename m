Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8ED33439A
	for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643200; cv=none; b=jiS+8qWVnsYlcxmci0KrP4VHeyG7KUIHSYug+y5ffmXV6bcuqNeyZGPI0z2rtmpPU2+Yf9siljv+aBhW77lvWwXn9XDYf7mZlK0a4+ybhOdCGAU8uKMKEJHBYt9ACxFJgmt24SexhzcMa6VP6nPL2Xbt+YU49S1eQnsN3KfTIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643200; c=relaxed/simple;
	bh=nq8Rn9AUkszwOzX/LnnRPVdXLTuei+t5rW7c+tBb4gc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eLpe2XXTtgWlDoTQ+XU1VkAWpRH64431knw4mIWzbPefM5UkAJbmpNZWmeG2tsl2qOylhFCzTk95Hlzr9D4wGgNGMiW1GBRqALva7eSdHDDBYMMWEwtMDR/umMzT3UKzczai4JNbLhDOXVMal7CXhIFmTP6NaXBInJ2h5VzvG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASkbIxXG; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASkbIxXG"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c73b00bd1so3608159c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 16:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643197; x=1777247997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQkLr/jW0JBIpHCf/jXLaYWpMKneVIdgi/cFupzzeaY=;
        b=ASkbIxXGraYvO1h3w5xrDPw1F3kQgyCaU97+SLcf1e924FXgUxF0NepAC9+0VUNc6I
         tMZDypwMcECEgzEzLblK19JhiA9I4wrqWVnzv4YYxzMbWwArsE1xUuxrFhkkvlklTaGa
         9sAWrE81YffC2pqhqz73NMaBC9lNKf1dhzxZkVXDmE5mLrStm14fbhyYNQ3aCW+Jd9x9
         AdABSyHMJ72QeHsLm46N5YgkEw4SoRSUmwAYCU0ztOfp7piptzGjrGIX0h5fpzH7/Sbu
         1SL9x8lkyvXyLFG4L7O5vj9hUBFxRQtXVcYCFJFC+rf9fj42mZV3w88MtLlItfon/NFz
         9naA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643197; x=1777247997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQkLr/jW0JBIpHCf/jXLaYWpMKneVIdgi/cFupzzeaY=;
        b=LxHaQCssLIIuYyYT+7cBB5XJtKnuVGwwMr32+54gGfVo+cCIIpVZekr1SNPXLJBFCm
         gKcxug52j1k7cj68d2J04lrgfASxjXyaRBoFKvAnQuqKblSvixR8vOT2KiKF1bnZvyXp
         E62zMWg4nrtTqFLcKyblJvymqqqw58YC+UZiEzjee722jtgSiBammCPRyg/we8W4VlLF
         ew4Dtj+HAP1Wxlhl/Er9YWlO9U2Fqv7MINVsVR05Fso4J05i3Xv3uu9MRc/aqXSCZxwJ
         vuwGjINibemShr5Flcsc6IwWVPFg19wFfgTEDupAVTKPNHs6ungvcfkoVyLiC6jhfHsR
         sp1w==
X-Forwarded-Encrypted: i=1; AFNElJ+UD6d5WJt7yk9S2v6hqi/9lpQ+/cF6uc6BnWn3iI6kM1xpEFqqQgq2w1XtLvdtNGUMhpBQiIvWYUtHNuLQfnHs@vger.kernel.org
X-Gm-Message-State: AOJu0YwbcXpG8opums5kJ028Fv+DFPEaOslQ4Lu3XAdVkxiH4TOomZix
	JAfa5lHpJOqqnYNJwj/XDMAEWIW1DMn1U06EZv/XoO2i7Zi91MPA20bQ0ha7y4XReGRMOGtKdMT
	udisgDKDX+g==
X-Received: from dlbqc5.prod.google.com ([2002:a05:7023:a85:b0:12c:20b9:8109])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec07:b0:11d:f89d:85a0
 with SMTP id a92af1059eb24-12c73fa5a0cmr5603462c88.27.1776643196469; Sun, 19
 Apr 2026 16:59:56 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:28 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-17-irogers@google.com>
Subject: [PATCH v1 16/58] perf python: Add syscall name/id to convert syscall
 number and name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Use perf's syscalltbl support to convert syscall number to name
assuming the number is for the host machine. This avoids python
libaudit support as tools/perf/scripts/python/syscall-counts.py
requires.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b68668c267d8..84a186532353 100644
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
@@ -2581,6 +2583,36 @@ static int pyrf_session__setup_types(void)
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
+		PyErr_Format(PyExc_TypeError, "Failed to find syscall %s", name);
+		return NULL;
+	}
+	return PyLong_FromLong(id);
+}
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "metrics",
@@ -2614,6 +2646,18 @@ static PyMethodDef perf__methods[] = {
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
+		.ml_doc	  = PyDoc_STR("Turns a syscall name number to a number.")
+	},
 	{ .ml_name = NULL, }
 };
 
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

