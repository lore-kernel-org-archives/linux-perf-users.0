Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C95A33AD9A
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964687; cv=none; b=itKYSGblWLPKXv4O2zQM6GEngq0VJVyPWOM+rdYyCMUgplDPLw5aUB3tToyC0HChisgDfME6f9LUuoKZdhMlfcoTONHcJ8vpOW04E1+aws1lGByhqzDJLc4kULygaQ6Hczu5Jt9zsHxZ0V0Jp2E6n836lNSx9OKF0gPH+7iltCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964687; c=relaxed/simple;
	bh=IAFz6HvD1HqgBGKZf/vmrYIzO04GOyUd7HHrwKSp1Qo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=EjLpWF+Hyc+zs/f2kJh+9u2k2RiknsRPKJS3OgbOtfu6cPp9Z9pyk+4pTexkOrkntVVamuHH0DXiPN08B1waxhgnknCtU7oihsfSfslEEzZGiEZjKD8dA5JfpCJIHkKctZkwigOg9YqBP58xet14uGd86JryPl6C7AhKc//mG54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V0OHB0Uv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V0OHB0Uv"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29809acd049so12440905ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762964685; x=1763569485; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2k/4sgiqyEzPJrtOKnDWo378laZvIgrqxzza06nCo4w=;
        b=V0OHB0UvuSHr5l7mCvrCfI2bs3Tp9fU0VPLoMexuII8AGP5jgod4Fb7YJuofw4/YMJ
         +TJJB4eIFdJQk3sWVAFqo9xVkgV8ZTWPod3y30kwgzj2R/nQV+4ular9bo/+IRFiFUd2
         krXsh+HR/1Atzs28tV2ZiNL9STmPmopHYRgg3zI8lpYk97FSkGN1b+9SPiSJDZW1j6dE
         iaqJL8X4SBiZizPSMcxb/Fe05YSF1SrZnk1drr3p6MXa5V5rkEZeq/I0Mv+XXeGJH+bX
         Ohu/A7yX1ru6IrAfd8jlItS9vm7XB5pxBBdnYiS60aNnAdYyDM4ZJxCIp57o4vByUiOo
         jAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762964685; x=1763569485;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2k/4sgiqyEzPJrtOKnDWo378laZvIgrqxzza06nCo4w=;
        b=ffXmCv4XNQho/HcjVTlXRhs/BCPjNu1W9k/NDhRUy+61vZD+998ZyLY9zqh51l5Fqd
         xgDt85o4epg+rGnpj73VYZX2U8A7E/5GAFOVELtaR9S//QXEFSRfPYU4bwb39MeQMWSb
         hQVz5ID9we7WAKoQ3jFibAPbWaUdHk95tK2sG2I00TMtGcoCCpw300hsvrx1k/+gDWPH
         fFBpPEjkrLIXQRL2oEF3X36a1NB4NwNAUKseX9Dy3dQ3RybTeEBkWrFsNc7he+15DQ1x
         O/fBf/nw6/+erUEhQMiXUbboZ/TnYubATEY6o+TsRvNJehGZDyYvIB6waNImrNVs9Kww
         ObZg==
X-Forwarded-Encrypted: i=1; AJvYcCXdS77kdXnmMUqt1FCNXAFJ6hKozhZdmyPzmoyhyCD0en2h/MlMgKEO/Vvt1vUR5c575LZs8yqbBoU44TBVUq+C@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQVTUX3Q8T8scuG1nLOzgZACEiNfKCUSKEllhZ5HduFLLBCY7
	QbMPn2pT12uu1sD+2ChwvovxGb3nkja5GzzZD1NC5M+/298oB3XivghUjQhUJTotDrINuHNTA9J
	FjEX6eVuN7w==
X-Google-Smtp-Source: AGHT+IF0nVwY5tvfnLuL9pHgSRiLyebsOlZqwtBrsEiSpZb6JrB31Jxvbsk87QVKKHU3IaMKufVApxvvSQd7
X-Received: from dybml43.prod.google.com ([2002:a05:7301:152b:b0:2a4:6b4f:4044])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1103:b0:298:481c:cbd0
 with SMTP id d9443c01a7336-2984ede110bmr41038115ad.55.1762964684490; Wed, 12
 Nov 2025 08:24:44 -0800 (PST)
Date: Wed, 12 Nov 2025 08:24:39 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112162439.1553368-1-irogers@google.com>
Subject: [PATCH v1] perf vendor metrics s390: Avoid has_event(INSTRUCTIONS)
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The instructions event is now provided in json meaning the has_event
test always succeeds. Switch to using non-legacy event names in the
affected metrics.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Closes: https://lore.kernel.org/linux-perf-users/3e80f453-f015-4f4f-93d3-8df6bb6b3c95@linux.ibm.com/
Fixes: 0012e0fa221b ("perf jevents: Add legacy-hardware and legacy-cache json")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/s390/cf_z16/transaction.json | 8 ++++----
 tools/perf/pmu-events/arch/s390/cf_z17/transaction.json | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
index 3ab1d3a6638c..57b785307a85 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
@@ -7,17 +7,17 @@
   {
     "BriefDescription": "Cycles per Instruction",
     "MetricName": "cpi",
-    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(CPU_CYCLES) else 0"
   },
   {
     "BriefDescription": "Problem State Instruction Ratio",
     "MetricName": "prbstate",
-    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(PROBLEM_STATE_INSTRUCTIONS) else 0"
   },
   {
     "BriefDescription": "Level One Miss per 100 Instructions",
     "MetricName": "l1mp",
-    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(L1I_DIR_WRITES) else 0"
   },
   {
     "BriefDescription": "Percentage sourced from Level 2 cache",
@@ -52,7 +52,7 @@
   {
     "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
     "MetricName": "est_cpi",
-    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(CPU_CYCLES) else 0"
   },
   {
     "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json
index 74df533c8b6f..7ded6a5a76c0 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json
@@ -7,17 +7,17 @@
   {
     "BriefDescription": "Cycles per Instruction",
     "MetricName": "cpi",
-    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(CPU_CYCLES) else 0"
   },
   {
     "BriefDescription": "Problem State Instruction Ratio",
     "MetricName": "prbstate",
-    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(PROBLEM_STATE_INSTRUCTIONS) else 0"
   },
   {
     "BriefDescription": "Level One Miss per 100 Instructions",
     "MetricName": "l1mp",
-    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(L1I_DIR_WRITES) else 0"
   },
   {
     "BriefDescription": "Percentage sourced from Level 2 cache",
@@ -52,7 +52,7 @@
   {
     "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
     "MetricName": "est_cpi",
-    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(INSTRUCTIONS) else 0"
+    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(L1C_TLB2_MISSES) else 0"
   },
   {
     "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
-- 
2.51.2.1041.gc1ab5b90ca-goog

