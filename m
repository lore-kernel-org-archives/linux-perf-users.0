Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F63D56B
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318896; cv=none; b=U0xgfQzkqV5rn8jPoUSAgJgQXn3M/sdWpq7NCckgKAEXQcONzqpL12X4eS+o9viO0byJkdujVVaFyUuaNbOde3qsiSHdHkJqVifX2GBTReREscidZXLwm/UJ6ABbNebzgHKTQ6z6NFNqAB5afclU2snY3uUBMswtIMJFuPt+RKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318896; c=relaxed/simple;
	bh=UwkjYK+U+f8LwVeVeyTQSJU60/nxqzY/uXtXOkioAuY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oYclqJZucPE1xUSl/PcrLX7SAm5wm1XnvCCf4luEYdGqKZN0KOS5fFGJuLf3baLRcpJiDW746K415diQ7eG36J7xBWoNmnmm7xvBggE2uj8d8GN4Ch8BCw0yxwmsM/W5Dq+KyM8YGx943Gx5RmY/zxEz/FInDQD8YhtN3CXa69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KlnRSczW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KlnRSczW"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso3354605276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318894; x=1709923694; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDmb+1G4FeL2VOjrPNtrbYg/sNUzgE2lO0wYF9ntEME=;
        b=KlnRSczWV9Ue3URYn+VSNWt8DdbUZdt9dwyGMTyN1+kV1Yo1nVLPyv1m3UBNaGtWSL
         Jf0FqqHVnjGRso4FzECrta+bQ08ZuuNamme9jE7cD8SHzDaLMeLkBo6SXQzFCVJcHA1K
         qcRxeNRmwoyUQBSLV7bJ1/Ns0nGdUxO4IaqXKApplrZsKmUYKXrL0U/Ay+IndTIb/ETy
         KQAf2pph9Yw3M7L78bXx8cWWF7kmddl8iRjB1BRf6IrBoMMiA/p6RRP3Nc+CfgOQ750r
         LlTUieFjno8lpOkPmio9hqF/3+OgKQ/4nQ6GTlLNDITXs+cfj8yS8++560kr/+zKWiFn
         Wlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318894; x=1709923694;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDmb+1G4FeL2VOjrPNtrbYg/sNUzgE2lO0wYF9ntEME=;
        b=MJknl7MW5oo7Vmx4CUNdgdRlWt8CNnA2M20UMplRSpjFV6xAI8qAGnFcS5RpUeUPrx
         mmxSZ7MO7zrFlP/1vVx6EBuYfnwoj1XXu1PpX54p6rf/pAJcqRUhDkn8qr6Ex5H58R5v
         BuZOBF1dnHJvBxlsyBabD6oiMe3LeMUMeOp2HYBfZosJwl509czrDCBA080S4ic6KC15
         LacPWkL74yrsrRsiq4vDZi94RtClTX2FVSPx61a5w4IiiXg0cl1V07floJEPcDbc/tXO
         NALLopbBQhNqrzgauJDztzztYsgj8y8BXU6RoqX0oPzdlFasWeYFBuynYZSKI8kWXHCP
         bepA==
X-Forwarded-Encrypted: i=1; AJvYcCWk/ZsKovaazDxh/2g67N/BugNmX0k6OgasLU+SNO+Mm/9aO1AWlw/1zIW4Pnj8jbuAW4mrtap664QSFdzlWl955za2HJXLdGRuAWdIoi9WmQ==
X-Gm-Message-State: AOJu0YzBUgdOEpoRgTSt44faK5jer+oPL05imfLbn1vh5ywcgnFuI9/F
	dlE7gLoWMZoklJfNL8ZQmXBGTOfYtZoYDqJk7SRIIC6hwOhB4uD04sUFrwUfuI+6f4zWWTBieJH
	DEMtXCQ==
X-Google-Smtp-Source: AGHT+IFng0Mqc23qnGvUVcJG0zjb+k/lfku+BXgRvaXwuOhxFc0DvXoSL3inQGchvvNQMPlLV/xu/l78WZlV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1024:b0:dc2:5273:53f9 with SMTP
 id x4-20020a056902102400b00dc2527353f9mr93587ybt.1.1709318894486; Fri, 01 Mar
 2024 10:48:14 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:37 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 12/12] perf jevents: Add context switch metrics for AMD
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
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

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 91f323c1a149..377ce413d051 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -125,6 +125,37 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdCtxSw() -> MetricGroup:
+  cs = Event("context\-switches")
+  metrics = [
+      Metric("cs_rate", "Context switches per second", d_ratio(cs, interval_sec), "ctxsw/s")
+  ]
+
+  ev = Event("instructions")
+  metrics.append(Metric("cs_instr", "Instructions per context switch",
+                        d_ratio(ev, cs), "instr/cs"))
+
+  ev = Event("cycles")
+  metrics.append(Metric("cs_cycles", "Cycles per context switch",
+                        d_ratio(ev, cs), "cycles/cs"))
+
+  ev = Event("ls_dispatch.ld_dispatch")
+  metrics.append(Metric("cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+
+  ev = Event("ls_dispatch.store_dispatch")
+  metrics.append(Metric("cs_stores", "Stores per context switch",
+                        d_ratio(ev, cs), "stores/cs"))
+
+  ev = Event("ex_ret_brn_tkn")
+  metrics.append(Metric("cs_br_taken", "Branches taken per context switch",
+                        d_ratio(ev, cs), "br_taken/cs"))
+
+  return MetricGroup("cs", metrics,
+                     description = ("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def AmdIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -589,6 +620,7 @@ def UncoreL3():
 
 all_metrics = MetricGroup("", [
     AmdBr(),
+    AmdCtxSw(),
     AmdIlp(),
     AmdDtlb(),
     AmdItlb(),
-- 
2.44.0.278.ge034bb2e1d-goog

