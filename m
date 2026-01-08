Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6416332EA4
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899534; cv=none; b=NFGqGFIw9pzBFzK3GVTQxXdES8pGohaIYyKbBFTSyj0zX7ByAq3vUJGGZxHxbldSwjkXVuK718Ij+T+U07j5zR22vrPwb7+ECdCvVG9DE8zsS1ysdHYC9LN45+lFdtXwPmWID62QDIf5MLpCOLYYmdSmQ7o+fHXtroNvDWTm158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899534; c=relaxed/simple;
	bh=uBZQbaf2jw+Z+6X/HPLRd2UQ4QNWgpzfDckkTan8FMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TL5PThkh9ovdGrZ/brNE0TYxy7Lxi62r5v3SDOubQf85eA5kK7mh+VsC9075zqrzrSUu86RA6w8sX/IeMcNlF/8QhgxUEtWirK9c+ROy/a2LJPdHDpqb8E4ECdwxmGSZDRLcp+6Fb8PaLVcr0i5WyyC2cCCwQif9dFCLJTfxXLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wCvENyBW; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCvENyBW"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ae56205588so3843698eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899532; x=1768504332; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTe2zkqt3kO+WTK/oM0HIoGu3LJeTRzWv45QieO9b4w=;
        b=wCvENyBWGboJG2DyaS/lWJmAY9ZLWbVazcvJvwELfK2WGZSWmdY/y1hUi/kZOLryqD
         POEnmzwJzsuXmgxPc3dNVUh5AT1KJAda3Ldq+jHQdTgDAgCoLl/OKGq4wM1LM3DBIhwW
         q9v5p73u8942t0nHO8TkndbI/byoOFmWuf3jjowvw05e+56kE4zS+miYKcXRC0smKb67
         xVV4MyYEbG8K2BcXK8hcEkYZMTqJIjVcqS8QmWtCU/99vCmCiBVR80TY2M1BeKqZGihi
         mFLVTAsBMycDyca5GS9mPZRZjX9ESK+I+i9Ry64A3T2qn/IdOmO1cdStk2rePlDJWlE6
         50+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899532; x=1768504332;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTe2zkqt3kO+WTK/oM0HIoGu3LJeTRzWv45QieO9b4w=;
        b=DDaousQM+ZRet+j8QhAbZx5imFS0yhey1relVwUV/Axcsfeli0Va4zn2zdh3vNelgZ
         tZU5rKK57H4MT6no1IiDmQAjADKo1Wr1zxmAHEdvMGRaxtOqS2xeojaWU1zcMsojyxlG
         YV8Gr3wWDVyEdnTI/zpuSY1XRlomik2XNIDFSmbe+YA+jmg78/pkStGcg53ngHhbw9dp
         rLWtltoY087p8wl+NxWN97MPvzIAwm4hKWjaCOMFyPsFHr+43ExDM8qrLptBGO5NxO30
         HS5bnInP5Fo1k7BI4n+hhhS/Vu+AfFw2HzR6Ml3h31uuaN5bqLXrRFGtujgJPApxce6Z
         IK6A==
X-Forwarded-Encrypted: i=1; AJvYcCX3boYtLtVAxS0EbGqOrh4GkESncOhOdXsACl+52h274po++CeV2GlyLFVhJ4L8GHRjdIgXXW2Xg/JcWOLmu9Ag@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqj5BtZ7cPlg8BKRG1xVsH1+cIImo6Gi1TfIktkSXl6MnluF16
	21A8L6Qo4rHAUoWjtPwiHlJ7PPXqz7JwFmzQTyTwC4cg0wNuPsgDG1/biWyj/dlaFrJHCDxdgPW
	sjFZUNUZxjQ==
X-Google-Smtp-Source: AGHT+IFbjP+UWSBe29MHc+N1MLgZsL8OyAZWmVkuOZMU5joxNuR39cAh4GxZ/t7opuGsNYq/pZOja6CvhUrc
X-Received: from dybpm2.prod.google.com ([2002:a05:7301:4342:b0:2ae:34d1:e425])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:fc07:b0:2ae:5af4:7d65
 with SMTP id 5a478bee46e88-2b17d3211d7mr4597327eec.31.1767899531834; Thu, 08
 Jan 2026 11:12:11 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:54 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-25-irogers@google.com>
Subject: [PATCH v10 24/35] perf jevents: Add context switch metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics break down context switches for different kinds of
instruction.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index bc3c50285916..9cf4bd8ac769 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -263,6 +263,63 @@ def IntelBr():
                        description="breakdown of retired branch instructions")
 
 
+def IntelCtxSw() -> MetricGroup:
+    cs = Event("context\\-switches")
+    metrics = [
+        Metric("lpm_cs_rate", "Context switches per second",
+               d_ratio(cs, interval_sec), "ctxsw/s")
+    ]
+
+    ev = Event("instructions")
+    metrics.append(Metric("lpm_cs_instr", "Instructions per context switch",
+                          d_ratio(ev, cs), "instr/cs"))
+
+    ev = Event("cycles")
+    metrics.append(Metric("lpm_cs_cycles", "Cycles per context switch",
+                          d_ratio(ev, cs), "cycles/cs"))
+
+    try:
+        ev = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+        metrics.append(Metric("lpm_cs_loads", "Loads per context switch",
+                              d_ratio(ev, cs), "loads/cs"))
+    except:
+        pass
+
+    try:
+        ev = Event("MEM_INST_RETIRED.ALL_STORES",
+                   "MEM_UOPS_RETIRED.ALL_STORES")
+        metrics.append(Metric("lpm_cs_stores", "Stores per context switch",
+                              d_ratio(ev, cs), "stores/cs"))
+    except:
+        pass
+
+    try:
+        ev = Event("BR_INST_RETIRED.NEAR_TAKEN", "BR_INST_RETIRED.TAKEN_JCC")
+        metrics.append(Metric("lpm_cs_br_taken", "Branches taken per context switch",
+                              d_ratio(ev, cs), "br_taken/cs"))
+    except:
+        pass
+
+    try:
+        l2_misses = (Event("L2_RQSTS.DEMAND_DATA_RD_MISS") +
+                     Event("L2_RQSTS.RFO_MISS") +
+                     Event("L2_RQSTS.CODE_RD_MISS"))
+        try:
+            l2_misses += Event("L2_RQSTS.HWPF_MISS",
+                               "L2_RQSTS.L2_PF_MISS", "L2_RQSTS.PF_MISS")
+        except:
+            pass
+
+        metrics.append(Metric("lpm_cs_l2_misses", "L2 misses per context switch",
+                              d_ratio(l2_misses, cs), "l2_misses/cs"))
+    except:
+        pass
+
+    return MetricGroup("lpm_cs", metrics,
+                       description=("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def IntelIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -678,6 +735,7 @@ def main() -> None:
         Smi(),
         Tsx(),
         IntelBr(),
+        IntelCtxSw(),
         IntelIlp(),
         IntelL2(),
         IntelLdSt(),
-- 
2.52.0.457.g6b5491de43-goog

