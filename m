Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF2184530
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373064; cv=none; b=J7TZmIG75P981UObBEAaPHArNHAQXOclWay1vLtiuGrjHXGvtzSucCwwhvHuNXF7PpEXqNE+ZiAR/yf3vw1ssYjW/na9qXpfGMK8lLszNOU47g9EF2yTr7ERqJod2ie3+JFHsmNVTfkgwt8SbRJs87eYw3s1FKKCp9DiaxJ7Byc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373064; c=relaxed/simple;
	bh=31f8Yn/eH35gJOA1WoSL/vLUefq6U+ZrMOBE1Vfo1c4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=D+wZ9WTxu6cvjg8Y+ftQA2NGOhVxof+eEI0Kh7I18x1X7tcvNfaVMMrMNAGUzdyLx9m0kKYZokbgl4v2lbg7lqF7avOi26Sxi9lYxva7ki1POQ/ulvghU4yw0pioRCMWmvedjpJiA51RgeXu1Iov2Cf13Do6OqL/UMKQFHcbVNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y8ATJ+kL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8ATJ+kL"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2270a147aso24078147b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373062; x=1727977862; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7MPwk0xrq2ytWuACw1JGtjRht0m9lFik9PWCPhm5zw=;
        b=Y8ATJ+kLuDu4xi9rR0W6XCwKyjrXBtUyu/BnflPUfVCvGnPUqeWENBBU9xd7+145+T
         2a5mrfS5maxYDKBW8sIXHAnzt8JWUF2v1tzSbVNOBUsSbVTe+LqnNNPAzUsEJNuZy9z8
         joJsnODAHpL1JQ0F4JQbgj/r8L5aVpJeE9S4zdhmZ0BjASs8zObNWSCR24gQnUGHT7oY
         oABe0FBdIRnFrx2XOa3e1xplmZopDf7VpX5hshZBgjdyZoZ/JPMlrpYd1AUVJLKfgYNg
         TED5roJt3WkyQN/+ovV7lE6EaACVCbNpYdarK84bdLQJQwGmc2kZ0nNlFojmleKdpkjN
         BRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373062; x=1727977862;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7MPwk0xrq2ytWuACw1JGtjRht0m9lFik9PWCPhm5zw=;
        b=Y5+gBJHsozquKBsFaR+epyfqXg+LJaGv0HAeK5qwKWpg4++pWU4wQpiVRIdFVaybIJ
         2wbs/ENjBsLWF7td/mzIP+SFRza0HRi8U+wIOuS+TXq7guf+kAEdjbbq+5SGU7fPxmIh
         fan5sts82bDVDSRGyCDv2wBrhHrkLHCM9CEAWa9ZFEac8jlmOe38wXPUVHa6k+GqrUb6
         /z+W9LC7yEBmYSAT37WksPGYKohqVyG+jthH4YQrJmxw1jiMDbhvI+5ZtGpqQaef76Rd
         U6mYF99vGiOcSybiB5JRc6H9z1qHLlGwGEro6+zDoIUe3EPtuDM6EKG34JBPM5+Q10wO
         Flbg==
X-Forwarded-Encrypted: i=1; AJvYcCVuMCQPfoqP8QiZH/YMHrJeyJiug84K5SloPj0H/enedc2b8Fwk6qahF8SKboIXYbLu8RbGV2XCEeBM20MBnnvm@vger.kernel.org
X-Gm-Message-State: AOJu0YwwLcuIr9W9r7YtGAr3JEfbmAkG8UJMv251wcZ2CUzP3DgqsJtn
	1YfaDKRoarzWfXW6OT6rpl5fo6PprWD9XoL21p2OqQE/B66nGdV9/0IncZpSjtU0UzCd5oxH+8a
	4m0bOeQ==
X-Google-Smtp-Source: AGHT+IHNk76QKSnZUXPxgHza2gJOP+DOgOGOrNseya7y6/YLAm6TyJ3yml9Onq8MbRGrlTjekM2OEFxh3CFT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:6902:3d2:b0:e1a:6bf9:aa83 with SMTP id
 3f1490d57ef6-e2604b33cc4mr306276.3.1727373061843; Thu, 26 Sep 2024 10:51:01
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:21 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 08/22] perf jevents: Add software prefetch (swpf) metric
 group for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add metrics that breakdown software prefetch instruction use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 65 ++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 09f7b7159e7c..f4707e964f75 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -260,6 +260,70 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelSwpf() -> Optional[MetricGroup]:
+  ins = Event("instructions")
+  try:
+    s_ld = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+    s_nta = Event("SW_PREFETCH_ACCESS.NTA")
+    s_t0 = Event("SW_PREFETCH_ACCESS.T0")
+    s_t1 = Event("SW_PREFETCH_ACCESS.T1_T2")
+    s_w = Event("SW_PREFETCH_ACCESS.PREFETCHW")
+  except:
+    return None
+
+  all_sw = s_nta + s_t0 + s_t1 + s_w
+  swp_r = d_ratio(all_sw, interval_sec)
+  ins_r = d_ratio(ins, all_sw)
+  ld_r = d_ratio(s_ld, all_sw)
+
+  return MetricGroup("swpf", [
+      MetricGroup("swpf_totals", [
+          Metric("swpf_totals_exec", "Software prefetch instructions per second",
+                swp_r, "swpf/s"),
+          Metric("swpf_totals_insn_per_pf",
+                 "Average number of instructions between software prefetches",
+                 ins_r, "insn/swpf"),
+          Metric("swpf_totals_loads_per_pf",
+                 "Average number of loads between software prefetches",
+                 ld_r, "loads/swpf"),
+      ]),
+      MetricGroup("swpf_bkdwn", [
+          MetricGroup("swpf_bkdwn_nta", [
+              Metric("swpf_bkdwn_nta_per_swpf",
+                     "Software prefetch NTA instructions as a percent of all prefetch instructions",
+                     d_ratio(s_nta, all_sw), "100%"),
+              Metric("swpf_bkdwn_nta_rate",
+                     "Software prefetch NTA instructions per second",
+                     d_ratio(s_nta, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_t0", [
+              Metric("swpf_bkdwn_t0_per_swpf",
+                     "Software prefetch T0 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t0, all_sw), "100%"),
+              Metric("swpf_bkdwn_t0_rate",
+                     "Software prefetch T0 instructions per second",
+                     d_ratio(s_t0, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_t1_t2", [
+              Metric("swpf_bkdwn_t1_t2_per_swpf",
+                     "Software prefetch T1 or T2 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t1, all_sw), "100%"),
+              Metric("swpf_bkdwn_t1_t2_rate",
+                     "Software prefetch T1 or T2 instructions per second",
+                     d_ratio(s_t1, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_w", [
+              Metric("swpf_bkdwn_w_per_swpf",
+                     "Software prefetch W instructions as a percent of all prefetch instructions",
+                     d_ratio(s_w, all_sw), "100%"),
+              Metric("swpf_bkdwn_w_rate",
+                     "Software prefetch W instructions per second",
+                     d_ratio(s_w, interval_sec), "insn/s"),
+          ]),
+      ]),
+  ], description="Software prefetch instruction breakdown")
+
+
 def main() -> None:
   global _args
 
@@ -288,6 +352,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelSwpf(),
   ])
 
 
-- 
2.46.1.824.gd892dcdcdd-goog

