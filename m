Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023A65BAD5
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165936; cv=none; b=mx/AQHB4TU7E9PFccWRZzz6A7mGD2JLEPt4Wi04tpPrRoMnmR02j9V4u2eNkfjbqvPJXOJ19X3j4kbaiyV6fwDg6nOG9La2Agl3EhGv7++c5l/thLyhuR6bWjG7wFWOXFqiJL7hCxyqbWxd1Ui7uUehl6yaLICC5Ua4vSrP6lLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165936; c=relaxed/simple;
	bh=v5ABchTQpnOktYWaziSCuW1XX126+T9HD5NGgP4r64Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qdQS8FdzDKpslGOQgDtGku5hvkaTf0mBxOU8wqioq0iCkOh1Ni6qn8q8/JVMMmEWw7PcKMDo6oKcwuH8RsrK1wpuubmTcQzOYZ3WJWvgxVRHlmyjaDmi8czFZWnI9sLYDdoAPbcsEnFLXAC9Y9DKI5bMvSd8da39Imvd/Hk0nj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cv5Mz9Xn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cv5Mz9Xn"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso667892276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165934; x=1709770734; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEWMbeD73ltjKkx6wjteD4TdhZhnTqNw+z4QfFdR0Xg=;
        b=cv5Mz9Xn851PoHzwY/s7tDctOCA1uwhB84iMDCNAWRukfJB5/61FSTKs0BUFAZ+oYn
         ABhK2ZAqwsTETsRP36y66QwLGBTGGg3gZR2oJPucKHoXrqi9UFxf9iwWlcboB71s0gvx
         oOknQGF4vB6+boswVezJnRQfgnhoWuRYhDEXW+WfqZwFzT2UiJz3BZAQM4RlM1PuCjrB
         0VkvGCCQKajdsCwsLDJ0t8IcBgwobZw2u6VQRhUnasHddcoh87xiEUZkAmEfKYpHE30Z
         zJoztG8o5CaO/Prq69rhZLP1IVEq/j4jmE2+Hvy4APEv1HnTbeHXBSMU6e2XtGiwN7J9
         OWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165934; x=1709770734;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEWMbeD73ltjKkx6wjteD4TdhZhnTqNw+z4QfFdR0Xg=;
        b=jeE8pphGpR9PelT1gju43p9f+D2b2Ibq1kuIhtUF/8WwTFGJAuklBG08+WGnwmrX+q
         8z4UzFUlwoOQYHPK05OoCpDarzniW740H5Ngy7a6Yuxox3P5mtO/WXUybooPUs+yIPG0
         FiNZUlCYILXisQqgNZf5SQQ9nG4HhDODk1WtquYah3CCW5x39LSCSqQGq5momN25lKf5
         t/383equ6CfriFQOb6vT5cT9a1KmFI1g8ulSzJkAetQoX5+kle7JR4jsPX9Wdeuy43UF
         3PsrhqWfVyLs3RexJPSXvOjW0W7MeMie6G+BtsYYrGQKSDr+EcdELPiTKc+ctReAoii/
         kVLw==
X-Forwarded-Encrypted: i=1; AJvYcCU+pET7lnjWNcHZWKUVVXDiqjN/JNnVe+WefL1NvkYqYNIIJk+osG9PdjArj7EI7lbmJKr3KV0laUeaE8H7eeLoDAfsipXyRrTiYtHLGUw4Pg==
X-Gm-Message-State: AOJu0YyHVL1DUrahim5ysQzw7vKU7cQVzQEg8Bpp4Z5ONrC/Z504V5ZU
	43JjtOfpz8GcwMK8Z3i00lLE4Tm6VJ2B/iSbaBAo0lwTAaxwQ6qCcLJJgYgPPOFyTwoQa4msQjd
	dXCo5VQ==
X-Google-Smtp-Source: AGHT+IEJb5VW34AwdxpVKBuzoStD9RSRzgrbaIVXVct5TzwAEjIblZgUt1eFNmQgufvv+zH2ji/1rFQJZfgv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a25:b225:0:b0:dcf:6b50:9bd7 with SMTP id
 i37-20020a25b225000000b00dcf6b509bd7mr214560ybj.7.1709165934246; Wed, 28 Feb
 2024 16:18:54 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:58 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 13/20] perf jevents: Add cycles breakdown metric for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Breakdown cycles to user, kernel and guest.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index dae44d296861..fef40969a4b8 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -26,6 +26,23 @@ core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
 smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
 
 
+def Cycles() -> MetricGroup:
+  cyc_k = Event("cycles:kHh")
+  cyc_g = Event("cycles:G")
+  cyc_u = Event("cycles:uH")
+  cyc = cyc_k + cyc_g + cyc_u
+
+  return MetricGroup("cycles", [
+      Metric("cycles_total", "Total number of cycles", cyc, "cycles"),
+      Metric("cycles_user", "User cycles as a percentage of all cycles",
+             d_ratio(cyc_u, cyc), "100%"),
+      Metric("cycles_kernel", "Kernel cycles as a percentage of all cycles",
+             d_ratio(cyc_k, cyc), "100%"),
+      Metric("cycles_guest", "Hypervisor guest cycles as a percentage of all cycles",
+             d_ratio(cyc_g, cyc), "100%"),
+  ], description = "cycles breakdown per privilege level (users, kernel, guest)")
+
+
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
   tsc = Event("msr/tsc/")
@@ -770,6 +787,7 @@ def IntelLdSt() -> Optional[MetricGroup]:
 
 
 all_metrics = MetricGroup("", [
+    Cycles(),
     Idle(),
     Rapl(),
     Smi(),
-- 
2.44.0.278.ge034bb2e1d-goog

