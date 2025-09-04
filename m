Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C6272E45
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961248; cv=none; b=HAwsKm05csk9yyvJaW1d4FnPoMfda0wTPZwoVQ9EW2Bg/AXqBNlhF/fxOu6uYvrHqN/wHINQ2lbM7yuVLrGg1hW5XQBR7Gff4YF4XsHitry1P56GVa7fhF5EjfLIYJNa0QYiN2lxSVAqLSxVev72Ulu6FH0i6p6So0FYHDt9aFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961248; c=relaxed/simple;
	bh=RWxTmP9bErTpRh3MiSreSF6Ijc5xe2sVs1oxl7J9cPY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=E3uvwUPxJKebvM1sNTj6H6fjigCAJGvBltnBb33i1JhRKsnmSEEyjUnyX8oSNOXthtoH62pFKk/cT0WVLZd6XS+FCPyEJH9MoPT+7pZAXnOpKzttQFMJwrC5W+VaxdP6xETUQ53T/N/pU60qsZA0zdGK8FUTdJy4clduqcK4U8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChqCHghZ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChqCHghZ"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-327b5e7f2f6so720922a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961246; x=1757566046; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDydOVVnbrc6TFkbkF/HCcYpcaepdAwyY0x1g/ePwfs=;
        b=ChqCHghZWgQ/4CGeH3xltHk67U4kT/yT7QAdFyKBni+D6XlalpZxxL67Zea4EIen0V
         ZLFAAaqjlL/L0WsXzq+mMFObwlz59Eud9NMrSQWpOV+Kz7aiDOWQEFrUbID+6FXMm+Dd
         1Chkf06rBLuHkrmYBforDDbe02YII9c3JDq3+RYU9uDD88IS8nbHLEIDboLFyMUnLEPZ
         l99SfHt/lxLnrB2FED4uYMPzrR/KHieyZI4pqGfdWpbaILSktl/plF8s+p+QH0ullkfh
         JswxPDSXMD5r/nh+IjNNHJRjl6p4a/ZafPTsjSRsezPqK2Sjf1KysBskkDlyk2ykVSJ9
         3oiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961246; x=1757566046;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDydOVVnbrc6TFkbkF/HCcYpcaepdAwyY0x1g/ePwfs=;
        b=LJYRxRLUHBLM4U8sfz+bPdEUiK3D20qgzHtMDhAWpazcKen1rbb5JA0PzncAQeo113
         VfT9Fr4oje8hOmpPCHEVHWzO4iaUEurS58mn/VDnDNi8g1uzX/1KkdPDaYAjyork/E4/
         CG7zDAqJG33LMZKJAtCvwlL7lbf+HDoGWqS48ha4wwKCY0QCEL0F9JyAb6CIHRLutUYW
         fIAddU9xC/oIl4uU/ukKUAC30SupI7N3ycFPX1PJB5c2wE1zno7SLiSr0zT31G9isznN
         xxKZ+DGubVtNaSJWOYISZcfc+vIBYU6AhmCiFCEiZPccRiL7MllkzP97E0c1qIAmz6hM
         tCXg==
X-Forwarded-Encrypted: i=1; AJvYcCUtLmKsRN8uKC9ENTaoBygzcyppQrj2SwVu4fSq7VsxTud8OxOeTDmtgXGD/+79UaquV7gp6uu/rPZCKRE8zAlA@vger.kernel.org
X-Gm-Message-State: AOJu0YxFAn0SrfoKeYVWfgaDkUPX8LFg69KUo3zbqM4HtsXEJtUBlc+b
	gF38MjmAQaIDsIufXNmZkYUNZSjqGpCFHgXk1C6PpcLSntQfTPEV+2TumqbTM1EaNRfOUM8puRh
	/Szo33WjSjw==
X-Google-Smtp-Source: AGHT+IE6Y+fdsaIR18oM/DotikYbuFy1clsPgX/Q/otYDx0TymT9tgfvaSNYdaWhSNkqxMPbDYK+liV0WBSn
X-Received: from pjbsm7.prod.google.com ([2002:a17:90b:2e47:b0:329:d09b:a3f2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b51:b0:327:8bb0:4338
 with SMTP id 98e67ed59e1d1-32815414094mr22756248a91.2.1756961246462; Wed, 03
 Sep 2025 21:47:26 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:46 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-16-irogers@google.com>
Subject: [PATCH v6 15/22] perf jevents: Add Miss Level Parallelism (MLP)
 metric for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Number of outstanding load misses per cycle.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index ff571256e100..fb15ba6b9f90 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -612,6 +612,20 @@ def IntelL2() -> Optional[MetricGroup]:
   ], description = "L2 data cache analysis")
 
 
+def IntelMlp() -> Optional[Metric]:
+  try:
+    l1d = Event("L1D_PEND_MISS.PENDING")
+    l1dc = Event("L1D_PEND_MISS.PENDING_CYCLES")
+  except:
+    return None
+
+  l1dc = Select(l1dc / 2, Literal("#smt_on"), l1dc)
+  ml = d_ratio(l1d, l1dc)
+  return Metric("lpm_mlp",
+                "Miss level parallelism - number of outstanding load misses per cycle (higher is better)",
+                ml, "load_miss_pending/cycle")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
   pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
 
@@ -819,6 +833,7 @@ def main() -> None:
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
+      IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
   ])
-- 
2.51.0.338.gd7d06c2dae-goog

