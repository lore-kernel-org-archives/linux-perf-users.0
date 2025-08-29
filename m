Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF85253356
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438332; cv=none; b=mLnaz72o61lKb8R+cg7VIkiFi48MTbPjKEPsm6KLAkNhRyEq0+5sG8LTV3HXiet1FBrtPm9AVeOQooaOxUAT65P/KO8O86Icn4U6dXyY1eeuIc1iGzCF0fncUXvJHlXULfMBY4zou8/Zzjp8w4CIp7QoT3cOfIDGf8nYx3+MJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438332; c=relaxed/simple;
	bh=UWuqUFoPAbtNw47XnAvBqrdOwtohVNIOBeexM7UAGKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EwO+4QJ87W1mptvRPQOG0gYmfY8tVqK1ghsF+HjL4svVYoblwBbil4SC3bna8WKiHRljVYBSpQScjOCHUF5CB6GAi4LipryC4qWRNmL23fmDq1o/ZixWqWuYgLrrxJILZK5k5rUY4KWeZdiypIv4TMKn+da+8D4KtrcXeu/5dms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VdjIH+qz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VdjIH+qz"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3276575ae5bso1748580a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438331; x=1757043131; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9QGW1t2fTrlxsy99oh9r+8W3JLxNT7O01vCVlWKIguI=;
        b=VdjIH+qzsUOn4WEaym3bsio8QUzhrrIF9GbeEp4y02I+hPE1yMStpesMDm4N0HNZrT
         i7MxL0WVbBFGwwKCNVwSDGgq+f9Gva6kIXumRioEAvdyT5kvCdQ2ujRyujAW3Gj7fB3l
         sSMlIcVQXfH5sdjhryi6iW/rQGFmAOVXHdCI8Ti21nCAwUBSAWJzBCjXY3k+mJi19j6Q
         kpIqtCYi5/cpKfPh4kpWnuTu9uD18Svyre0236If4AcIogDz+TWmECFDkQS/y3LZcVRq
         m8aQtwgNaeMtYSxItC+IVr2MChxvv8DCP1CbhyLrmD2kZCrFPBOCb/jpv1QsMqikk9Qa
         wvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438331; x=1757043131;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QGW1t2fTrlxsy99oh9r+8W3JLxNT7O01vCVlWKIguI=;
        b=BgXfVADpc+pwNOqsLh4j/QMulH1MJcvRyuuYuJwA+zc9fHQRBNqKMw0awNYeTI4S8r
         hpVa2bK902VlRMt5LJQuhC5u5falSUJyLuOPOzxLWiLidI779AQ6PzSBO14qp5NSTbsn
         ekQwqf068cQws4NPukaeYv9bSYulhZTPFojUBMPgXu17EwZcFe7j8mf//wuAl2hDDTlK
         37V49zHi25rreUG/apsPANsMvVuUGE/LYx+kKKUNhw9btWPbycQiP/Abn8z9os2lx0IW
         S4V54VKPyg0MBQ5rMIcRzx8i+xIYiw4LZGomGfSn0tMCyAWlM90ribN5oWWPAtOJtHBl
         H5XQ==
X-Forwarded-Encrypted: i=1; AJvYcCULRsGCxxf7DKDsGAr91tpeM/XsHZdVv1LHgCojf3WPWKEaU9q4/sCIGvck1wKICbCa2BVTO/WWCuwfcX5VCfAG@vger.kernel.org
X-Gm-Message-State: AOJu0YyNM9ZGY3vykawCWuI3QevgLVILhh+gAjUPmg6ZAFRZpX+XaTp1
	Q5cNINzzP1kzJEDyi1w0WFJ6XUGtvAPSv7ER3+AY/Dc6j0bd+vtj2oN8dz8sBYhjZ69YDrRHTAB
	C8W4qhadqUg==
X-Google-Smtp-Source: AGHT+IFruY13+0TIPjlDfpbi3fSgUGsWRBLlzXlFgq9LQVQaDvQ7884Pr78k5HIex9b+grU3F8xjr/hDvs29
X-Received: from pjbsb4.prod.google.com ([2002:a17:90b:50c4:b0:325:8ff7:fd4e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d83:b0:327:9345:7097
 with SMTP id 98e67ed59e1d1-32793457259mr9000011a91.10.1756438330967; Thu, 28
 Aug 2025 20:32:10 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:38 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-14-irogers@google.com>
Subject: [PATCH v5 13/13] perf jevents: Add uop cache hit/miss rates for AMD
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

Add metrics giving ratio of uop cache hits to misses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 0578ca7fdf92..d51f4c3fe0cb 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -571,6 +571,23 @@ def AmdSwpf() -> Optional[MetricGroup]:
                      description="Software prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
 
 
+def AmdUopCache() -> Optional[MetricGroup]:
+  try:
+    op_cache_hit = Event("op_cache_hit_miss.op_cache_hit")
+    op_cache_miss = Event("op_cache_hit_miss.op_cache_miss")
+  except:
+    return None
+  op_cache_total = op_cache_hit + op_cache_miss
+  return MetricGroup("lpm_uop_cache", [
+      Metric("lpm_uop_cache_hit_ratio", "Uop cache full or partial hits rate",
+             d_ratio(op_cache_hit, op_cache_total),
+             "100%"),
+      Metric("lpm_uop_cache_miss_ratio", "Uop cache misses rate",
+             d_ratio(op_cache_miss, op_cache_total),
+             "100%"),
+  ], description="Micro-op (uop) hit and miss rates.")
+
+
 def AmdUpc() -> Metric:
   ops = Event("ex_ret_ops", "ex_ret_cops")
   upc = d_ratio(ops, smt_cycles)
@@ -657,6 +674,7 @@ def main() -> None:
       AmdLdSt(),
       AmdHwpf(),
       AmdSwpf(),
+      AmdUopCache(),
       AmdUpc(),
       Idle(),
       Rapl(),
-- 
2.51.0.318.gd7df087d1a-goog

