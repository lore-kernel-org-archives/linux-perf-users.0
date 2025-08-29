Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC648246BB8
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438329; cv=none; b=mw85hqywrn1oTEpnoxKfCV8BvL5yqUbEq2XuzkJ7Ti5OArAmPpPEw6s3GbRk7KfSecxOPZXzyPJpfm63HGX/M2sRKQsO0UPd7kAO+dfWrbCxjqG391YQdR8byogs1aJ2jy10GMWai4cGO1ZuXbH3jO4kRyfQQaDz/EGUDbnGyAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438329; c=relaxed/simple;
	bh=epB32bgqoBg+Y9IczPEeSot7J5GpkAAMYtGdLSFAUEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GLI1OhOa9iqExOSAHxml2dfKq8Qmbn2VniMJKlN8PTsQom6K09VJzNeScxwxNCnnMMzM9oe3utIsXkHknMsgyehkE71Pjziw5VaLerW+zBhwg9c32yko8SlKrhq+yVGXb3vOvCrKeppWhhOa+3Josz1JczNYGl2WUIzRa38Wxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=01EkYCyN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="01EkYCyN"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24456ebed7bso22889785ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438327; x=1757043127; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6o45Rbe1ZhPS/kWrkC4UpT//UnRPcEEIFEGMxNVhUzE=;
        b=01EkYCyN9+LBjLGkw3/aFDe1JoYX5Em1aOjdUqQQWN1Tt26R/H+uBVS5baalOgCMqk
         Pg17hJdOrnmgxTNVihfvS15WEWwqtOdtv3VnS7GNUjxUYwBK62sNf6Vn3vfyyIbytrMU
         hFaXk0MjO2MlS9G7Hiq89qUyCW9nwAQZRyXVOgnY1TZZqW9BzAZpXsGlgRxbTdA+Ucm1
         pV5wdZg9SFE0s5X/pCYaYBmEfUSxf2T4M3zjUi+PImhLrfNRHXahoxYf/tYLCuc/+hNt
         +QIkXD9jCoOceEiZCdbSqLMvNKH3PY7+sQSP3lE9mrKFZQh8g3IFXWh76oOLFraTLCMo
         +Y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438327; x=1757043127;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6o45Rbe1ZhPS/kWrkC4UpT//UnRPcEEIFEGMxNVhUzE=;
        b=gLgaq7XBfYz4/1+QfsmiJZCmMp64O0A8DnscNi00hRb1q+kMUpkgr/Oey4Zq6UAgrk
         hy+4gxY9SfOXzWL6fJBrjcfwFJQEm0QK+x7TlWAQy9Ba9lRpX4Jife5RzhKyKKz7n6XX
         DhVyBfiCGxpkjXX2SmbwFKJe66RNxhDU60BZtF5Lr8E86EVsM1cbfhSUW+actpoad6o7
         BZ4NZXYpsP3ECzdvLFJwOF4QbfmRQbfkdLxip7MntBHflDfXZCrXuHwJefiuobuBffbP
         Nd/kESe17+RhvmFn/Re11MPJRmoSrUogkrERsQ8/GJgWBZHD4Bn7vRn5g9fLjy6ticVX
         HTRw==
X-Forwarded-Encrypted: i=1; AJvYcCX0pE3X5Fc0BNiMsi4RCSiyRodksDNdTDvQk0C6dkyp7T8rqcNdGoS6tuaZOEfxrxm+zbBWO53s+ATHmhUutxvb@vger.kernel.org
X-Gm-Message-State: AOJu0YxClAonCy4jUWQNzWgLBfdBRfJlgpLBl7vGbBfo1Bjw90R5oDdo
	92W7alAwOGU/K0oHw2HCOgt2skweWVhvHwzHQdQl1SrR1+RQTvQtaC2RwYyw5sbOiGeBVCTOb9u
	FYbrFeOCklg==
X-Google-Smtp-Source: AGHT+IGWFJKyKtY4P8UpIxPqLRFXmtn3fkygNqVRq1CXNPMFQs466KbnXI/f1SsdBuMKTvK8/3nFXr3dKqwg
X-Received: from plbmg11.prod.google.com ([2002:a17:903:348b:b0:240:2ea7:26fe])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2cf:b0:248:dfaf:2aee
 with SMTP id d9443c01a7336-248dfaf3002mr61506385ad.28.1756438327192; Thu, 28
 Aug 2025 20:32:07 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:36 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-12-irogers@google.com>
Subject: [PATCH v5 11/13] perf jevents: Add ILP metrics for AMD
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
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 13bf3eaf498f..2101598e8b04 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,41 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("ex_ret_instr")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), cycles) for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], cycles))
+    ilp0 = 1
+    for x in ilp:
+        ilp0 -= x
+    return MetricGroup("lpm_ilp", [
+        Metric("lpm_ilp_idle", "Lower power cycles as a percentage of all cycles",
+               d_ratio(low, tsc), "100%"),
+        Metric("lpm_ilp_inst_ret_0",
+               "Instructions retired in 0 cycles as a percentage of all cycles",
+               ilp0, "100%"),
+        Metric("lpm_ilp_inst_ret_1",
+               "Instructions retired in 1 cycles as a percentage of all cycles",
+               ilp[0], "100%"),
+        Metric("lpm_ilp_inst_ret_2",
+               "Instructions retired in 2 cycles as a percentage of all cycles",
+               ilp[1], "100%"),
+        Metric("lpm_ilp_inst_ret_3",
+               "Instructions retired in 3 cycles as a percentage of all cycles",
+               ilp[2], "100%"),
+        Metric("lpm_ilp_inst_ret_4",
+               "Instructions retired in 4 cycles as a percentage of all cycles",
+               ilp[3], "100%"),
+        Metric("lpm_ilp_inst_ret_5",
+               "Instructions retired in 5 or more cycles as a percentage of all cycles",
+               ilp[4], "100%"),
+    ])
+
+
 def AmdDtlb() -> Optional[MetricGroup]:
   global _zen_model
   if _zen_model >= 4:
@@ -584,6 +619,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdIlp(),
       AmdDtlb(),
       AmdItlb(),
       AmdLdSt(),
-- 
2.51.0.318.gd7df087d1a-goog

