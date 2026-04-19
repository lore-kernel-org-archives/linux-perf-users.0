Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3718A93F
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643207; cv=none; b=NB4m6/VKZ10hwUZnenOyNVOFytGPw2K4EqFik3If65b2SqPiBoBhvvd1MPoFZum95pGbBaI4LzcdIs2OjtNPK0UtDmh2g1CdJyV4OUbQvmmpUAnjqwHNVB14CkB+Zuc3mwEKljcZtuLS4Frxqzz1KnOw4B8TAVFjpAHUCxZ9YUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643207; c=relaxed/simple;
	bh=GztvdGHfQIrSysgHZ6mog5jtOvCG9PF8BBx1ZcL32vw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uFGcTHelfxZDmmBCQamLeS6NTRcYH/+/KIQ7VSzNyZnhDx4de2j23GL56krSi8ab3mkMUWDSzIJMWF95pIvDj5nKUQGLAI5tNTZhoPDwuf2kqboxjH6qgVXFUUb3vfCS4cpicUinYvbvKkpeQMJRV2BTv1s4UWGzgyLYiq+VZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmB4Xz5W; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmB4Xz5W"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2dd6fb4c867so1916648eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643204; x=1777248004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3qCsPBrj8NjguiteEn+YIxZCMV7sPaGLx4K9rrDO14=;
        b=JmB4Xz5WZQk541Q077L/dz3jeWhDVdkLn+/JuD/ueqRwkSMioJyCh1LApZvcssfN2M
         iOP1S4I3vJtvG0qMzWJFQ1FfW++wdSx8AXe22n0HYGKI98F0swxCJ9OHbhM4JqVOljk9
         XgeZvwQjQikGi7yYNC2dImKlCM5rB/deO0v/oHRfFQS89HPye/bf6tU23O/eUrNbjgDI
         W7cnFYYGMBeFja2Rxi2exXEFYS8kaw0b/wAotaoOOFoNWrf4LkLartZsygt2nyQbhC6s
         /Vru4+VEgKrBgEbwT8/imNMkvt8jFah0E1udxm85rnGzuryYoyJBNfM+wqeBF3qozDun
         83vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643204; x=1777248004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3qCsPBrj8NjguiteEn+YIxZCMV7sPaGLx4K9rrDO14=;
        b=ds4x4/pPipziW4+eM5tmPYDe2Vw4g6e/jng++Fmrtl0Vv/47sKwwHpqPPhSpVhnN5n
         4p1EezOzOQpvmNIRRADJ+4LWsTOWb80WxrvypocQPfLpVhvlPrkRRGvI9JQ/+kEXmFh7
         9oAOLXBqrTYnbhiBSNUHCvJM8l6f6AflSLVoLDdNKPPRa3uFBvGJHBlwFtb2SRsg859N
         wilRQpXhWnFLOutAeF6mIhXX07HkczvEEZwNbHaHReRBIhvKnIrs6z72i+UwxAl/bWSv
         MR33QA7oCw+TCR1Y3zj23rx3yw79O3/1fG5kyHk6s5uHjd+SwYhOqq99arqQo/5FVfjH
         RghQ==
X-Forwarded-Encrypted: i=1; AFNElJ/uKBGoTXooQ7ij0uX3PPJUNwX4RrOBsTWffCMeXV7CbUpsL4FB58/80bYBZ+BnUYFmyEmiKlgGnCGWxY8iPkKV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jMRkqXqqH/8ymKJ1LeSubEUI6zzaSnSL6/q/V7pNfUNA1xa5
	ElrkzSMOhaXkNy2bfaOHZYYgAjMVrq7Y5ZBvtJsApL9elcolEumGON7DvMTN60iHrTv3n4P/9kI
	2U27/ohbR8Q==
X-Received: from dybb21.prod.google.com ([2002:a05:693c:6095:b0:2d9:61d4:4d0e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d517:b0:2e0:4edd:64e8
 with SMTP id 5a478bee46e88-2e47a2faf4amr6245972eec.24.1776643204137; Sun, 19
 Apr 2026 17:00:04 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:31 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-20-irogers@google.com>
Subject: [PATCH v1 19/58] perf python: Add config file access
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

Enhance the perf Python module by adding lazy address resolution and
Add perf.config_get(name) to expose the perf configuration system.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6baf38a08690..e5f96bc695fd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -12,6 +12,7 @@
 #include "build-id.h"
 #include "callchain.h"
 #include "comm.h"
+#include "config.h"
 #include "counts.h"
 #include "data.h"
 #include "debug.h"
@@ -3130,7 +3131,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args)
 	return PyLong_FromLong(id);
 }
 
+static PyObject *pyrf__config_get(PyObject *self, PyObject *args)
+{
+	const char *config_name, *val;
+
+	if (!PyArg_ParseTuple(args, "s", &config_name))
+		return NULL;
+
+	val = perf_config_get(config_name);
+	if (!val)
+		Py_RETURN_NONE;
+	return PyUnicode_FromString(val);
+}
+
 static PyMethodDef perf__methods[] = {
+	{
+		.ml_name  = "config_get",
+		.ml_meth  = (PyCFunction) pyrf__config_get,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR("Get a perf config value.")
+	},
 	{
 		.ml_name  = "metrics",
 		.ml_meth  = (PyCFunction) pyrf__metrics,
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

