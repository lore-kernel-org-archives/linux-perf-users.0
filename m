Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0233CEB8F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916579; cv=none; b=okAJ2W3PR9o6uTGy3oLtGRfKwEJZ4trML6A9Kx1eRC9TjSC/wX1FObaF7ia4HQH0CzMyRsuByCr2zDK/26QzQWazNknA4m222Hlvx8AmP5Pw6WevsEQlKY07Un3FD+VJxWfzi0gNILRreYTKYHB1jNQcoJwsnOmFkNaIPG/4THg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916579; c=relaxed/simple;
	bh=gSDSS9XpGtqDUmeeUCJmSlFCjeMvGpESLA5PZCKK85k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WmSy+zjSzXs32e0P3WOND8NhoxenxiPQOOSidc9mmxoJ/GDGdtkGaTuZLQ9r1bNr1MvKm5Y06lN5pioEgQzBQ0efZzuIneHkGpEtwTvGpp+eTwIdNlSSO7CRlLE2f5nN5TVbMIj2Z7E7zUuG7kxSWOSWrKVQDwlXMxlCmkpa7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gxF3boe7; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gxF3boe7"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so5666118eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916577; x=1777521377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sy83hNgbhH8frjBDFDeYQ8MDyd6a8euOqQUQ+sZUMQw=;
        b=gxF3boe7zH9lkUOtmi+eJqP7rcdWGnRpNEMWZ6APQVnTenSJtq9PfqYUI/F5VismPc
         BVZVJTmzz4wFwNOrw54UtASwdvBM7PHCcm+fxqolNP14Z5NJ1XmnL2gSrxnt8V7FGyKI
         qhS7stfJ95Uau135WcoKv4ZBxbDlBb5KIQpGcXUQwMXb92Da7cj32SEeOEdk9DsxWE3R
         Qc50uddSbjNxspo7OO1LGXNpJ1ZuXunoMPCz+wSkaK6IzyjXk2h08nHR8Vsw2e8jNcXO
         LjD6dNJ3k9qxUT3IeUJHjZZrSwtlxLuHYIa1s5KJjeE3ezmFeovA+AKvB9Q3673edMAq
         0oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916577; x=1777521377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sy83hNgbhH8frjBDFDeYQ8MDyd6a8euOqQUQ+sZUMQw=;
        b=TH0mU7MRTtaY7X56uGaPBXNmmRji/QNF3BiCzFqD5s5O2HkaJ0hBexqxdGcOTQsnLw
         2TLJtB8PLL0HogY9InECOh3BEyVBdsll4YBIg830R+EgsU6xhDhOxmeoxgSTRail6htK
         5dh+qddSJCdjxFs3H3hOsNldi2c2RtZV4uoPKVLcvnnkyn80Z76i7BZKtsNbWwDggkBh
         MEVN784mRaVo8r35ymE1Qgmv7hBJzmFqvlWrI3lJJ4yhYtVm2QqQdXKXZj6BDY8FIVG4
         XseF2OfLhgb67wiUciu1wmdusSEsiq7dxdtwlWg2tptXnE0owFUhtedUSEUaSJyXl2QH
         gm6A==
X-Forwarded-Encrypted: i=1; AFNElJ/mQo1JXlnK5XmZCMDmTYTCoHL82hloRPASZwveE3VEAp+LWadlUUraOAaNEb6faXKOhuC32Ps2WKfX76O+VSda@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/mSRfkt55Jc0OCu4x+wzQGLMLk42l6TQRDLjalrk1vmsMyrJ
	k0a+YxCTVqjSZlwx8dys7OHK3gNbXWHF+udOY0y9+sy6IAZFjlXHlgdNscH0bXfzyOFAENuXPHK
	mSxDIWjTU0w==
X-Received: from dybqf23.prod.google.com ([2002:a05:7301:6497:b0:2df:8911:82c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4349:b0:2da:13c6:f27b
 with SMTP id 5a478bee46e88-2e42c8481e9mr10854863eec.5.1776916576698; Wed, 22
 Apr 2026 20:56:16 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:54:46 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-20-irogers@google.com>
Subject: [PATCH v2 19/58] perf python: Add config file access
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

Add perf.config_get(name) to expose the perf configuration system.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ebbb10c0efeb..c707adf4785c 100644
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
@@ -3229,7 +3230,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args)
 }
 #endif
 
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
2.54.0.rc2.533.g4f5dca5207-goog

