Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A153806D8
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960650; cv=none; b=XIOYqLB6+x1U4SkCUJ61CwNtms13qLeucCoTK77p59nlOhEIu5f734BuEF0F04Lp4hsjJJR+KZb4mX+9QuBjG9UgmHyR7Wac/DB6MOCbUoQscb1Kiz25kGzXcrBppi5o3BEeyiIEtDq9AuCpUvKxlajJEQQpmsH8Seh5HfJd6uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960650; c=relaxed/simple;
	bh=QHx1+jP8Xoa+KpULosdDawvIN5XPNfXuSXgd9EFaHR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gNq2I6ktlpGgGxGJThMKvVM3IzV84TC7YuGXi1aYFshaPNdExkG7dV1NB3MoZDGtfu48rHwed6qGaRE+eqYwqP+q8qtTXoWLFECpPy/mfBybXH2YJSg+uyTfe+cqOCzx5T6YQ5d5mhCP+kL7oi3vfZn/j+IKg3UMWDuFzPFjgo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3DpUVjf; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3DpUVjf"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bda35eab74so6134972eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960646; x=1777565446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqWbWwttWazbhBwzSy9FYV2WLXqz3OOopag/c+5+FWQ=;
        b=r3DpUVjf2mrOsi2kXkSLIZnSAJhDVTakOFe/7bjeiKI0F/c/y0l/NIJJ+JL8sC+UU/
         Y6o+l2DSVtKgWx8q5O5vkYTZjwfhqabHLT6m5C9ENfn7hZ1uP9Tf+dgdEDvhHwGMpzer
         WXn6P34L81nbA0MUZOBA+VLHInhskm54VrjfIAtWXFo4vrunXr6AoDokrYvhHEgDOXsE
         L0SAJgSAIv92v+RRkCJZAIYoYLlz0ZbAoWx6RRdLO3HxwAi38I8XFBu69RieMmH8X/6B
         0ekJQspkava9bAo8kAIf8zHZlIkSWWf7P6Gxda+9ng7RLmiFUqOZYKv7DSih1HyB2FjL
         vzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960646; x=1777565446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqWbWwttWazbhBwzSy9FYV2WLXqz3OOopag/c+5+FWQ=;
        b=A2Gp/fWfWA4huuYm2VYJGPUoOtFh517zXnwhfFL+sc+0HONX4BBIVmV5lqDq55BXCh
         DDDsC6jBktfjIfSsnZOJsaWzNO1XVIA3HXssEtfDYQa6PULSN2qog4R9IP7UY2kBiSkv
         1lyM7Gl6ToWDEwhj9gjO7RKFLfGrsNB0jIjtwZS7tnL0Pjf1wRPbxpRsqs6q8r0ucTfR
         XPBni97K3KFEeTkdb2CjsIKdRoEAHLNz+af+N/tjVsh/8UL3t3iVSmTmwKli4/5o1nmq
         uLuo4tNXhwaw5lrWvtDMpVkhZTNCY1wJjiA7E/OJ0DFGP6bqNenjwiC14/K37VdTXurJ
         t54Q==
X-Forwarded-Encrypted: i=1; AFNElJ/WcDhG0pF9DpsOKHbGJvm4ruOWfIkMpvNd0zIuGz6zHQuhcGP4x+X5FEeaCMzHjRIuUubhGa1xoDSFg09Kk6oN@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxYUauTMU8gu/SKz8prQeY7mFmxUFyk0mZ9cSLnYDrHdyHrrI
	KR9Pu3FIpbWaOD81E2b66f/pEzagmX+EN8WcBgt4vc5enGCsg9HqETin3q0H6L6GEF/DxokLo3M
	lf79HoLWd8w==
X-Received: from dybmc15.prod.google.com ([2002:a05:7301:198f:b0:2d7:e13b:ef99])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a191:b0:2be:6693:9b4d
 with SMTP id 5a478bee46e88-2e42cd45b4cmr13179825eec.9.1776960645885; Thu, 23
 Apr 2026 09:10:45 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:25 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-19-irogers@google.com>
Subject: [PATCH v3 18/58] perf python: Add config file access
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
index 28961ad47010..dc10d8a42d92 100644
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
@@ -3230,7 +3231,26 @@ static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args)
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
2.54.0.rc2.533.g4f5dca5207-goog

