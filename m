Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571D32C939
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899508; cv=none; b=Y2I4knZd/9L8CTfX/a+dCK+/AlGVDAzTpNUoqZ6DR5FGgEx5emHpLJhYklIQ6/Hj4qfnkqoqS6L/DxKTV4VbrfdajWL3NpWIlEltRxVb6HfJIHoUgPdlHlsCXtkzo06gG9MpxUlB5UmkB1ccw6uNTR9eN+g3VuNB1JVYTxiptQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899508; c=relaxed/simple;
	bh=ARE/Q2G89TxiCVGgVTApgtKtNEltPTE3mlntYnL0UpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RIHx1Vbre3Mftc2xdc+Hkt04Isr8qJSggie0dq1cI704yG7NATT23Bkd0oL1W3kGzuIgnPbpSuNN4HsIW0VyRlVO0w/rlxw2UULhSv5g9xyz/tTTHBuxVKpaKau0bNRqGomjsF1DxsQDh3GMsU0GR2VoL6WdaFf0oKkgY4apHrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWPwtOsq; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWPwtOsq"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11f3b5411c7so248710c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899503; x=1768504303; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rblm5KSHXE6JkXlIc70Vz9oUvY6uCMkftvfXFaxGDFo=;
        b=fWPwtOsqhf5z4icDx8aHjASzk0M/OfUaxRMjIceUys6eHb+SeboVW3EbBc3wyeRKl6
         nVZi1Q1AEatkijklQVNk2BfG5CaSqXvrS+IiZtaXKKj+I1QOOGW5+FFxWWTotYMJWg05
         Iib5Q40eL1oiyfnnwYYvZ/UCESuoZ+wcPeUrUmvwUA/kZnBhQolp7QNinEcBYlFSc2pq
         kgc69+8swAEgd9Y9U/9YuAS3vz7ssh23WnA7vDIJlYFVD0yYdl5lJXcV0bCMFW54e5iT
         ogu5LHOXCxvokQvc8cff7HWQNYl4X1KcNOmmkgi8sQSkYh+DxFYtRqtyxrkomSoUdhPu
         2Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899503; x=1768504303;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rblm5KSHXE6JkXlIc70Vz9oUvY6uCMkftvfXFaxGDFo=;
        b=Up2gixobtttv/Yl5FNXtwYk1C+DRAxxz5Ku0Qt7IoiyeG+cGe6bpkt0T74iasxXDYl
         w8oghuNQ8B1us41c169wdlxxOYZ2LNNc7N6CHmqTqA1ylQw4qNBJi1xJBzbGHt7BdWb1
         MqoHZ5RtOX42OYiDa0PxeLWQorHF95VAx/rNe/JiWUR44iJHo9Drpr/62AzZ2s2Lk3nm
         PbGR5qjGiXf3+v4LzojI9bNsSxQ0Y2roeeOKbPnbj/sU3GOdQWJoQ3krCPopfHSK831w
         C23hoGxExHmUQzgYBEHBv6FnJEx9bR0TUrFrYsAb088FrHFRl+gZrJu7+8ymWHL8P5mC
         AEog==
X-Forwarded-Encrypted: i=1; AJvYcCUGeLnXVinQIaOqHCLEBKRA53Om54IsHBArWESJC5H0hrtchgUerKSACeh0LVMWW4XnZj57GgpzvVlHYis2tPW9@vger.kernel.org
X-Gm-Message-State: AOJu0YzjE0EC2rUtDnYK/GMFEmqq2W/W2QQQAMDQX8gXoxA+uQBfqtfw
	FeDWLI9f8FbaWypSpdotg0zi3YUKlwIUI6jP6n5E0tKx5+vU755zdo3GEEUbCjglnSqF/KQuj4y
	SJLzlijygqw==
X-Google-Smtp-Source: AGHT+IGycfr/V1MBVAvRRJu+cPILshDBpdVCcPH1A4b61DFn/b7LNM1rkSXlN/gpZHLmomvyiXzogQ1MjY34
X-Received: from dlbuy4.prod.google.com ([2002:a05:7022:1e04:b0:11f:3f33:f0a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e08:b0:11b:4351:2687
 with SMTP id a92af1059eb24-121f8ad0889mr6464293c88.17.1767899503061; Thu, 08
 Jan 2026 11:11:43 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:39 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-10-irogers@google.com>
Subject: [PATCH v10 09/35] perf jevents: Add uncore l3 metric group for AMD
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

Metrics use the amd_l3 PMU for access/miss/hit information.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index a4ff88de08b5..d71997177239 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -317,6 +317,24 @@ def Rapl() -> MetricGroup:
                        description="Processor socket power consumption estimates")
 
 
+def UncoreL3():
+    acc = Event("l3_lookup_state.all_coherent_accesses_to_l3",
+                "l3_lookup_state.all_l3_req_typs")
+    miss = Event("l3_lookup_state.l3_miss",
+                 "l3_comb_clstr_state.request_miss")
+    acc = max(acc, miss)
+    hits = acc - miss
+
+    return MetricGroup("lpm_l3", [
+        Metric("lpm_l3_accesses", "L3 victim cache accesses",
+               d_ratio(acc, interval_sec), "accesses/sec"),
+        Metric("lpm_l3_hits", "L3 victim cache hit rate",
+               d_ratio(hits, acc), "100%"),
+        Metric("lpm_l3_miss", "L3 victim cache miss rate", d_ratio(miss, acc),
+               "100%"),
+    ], description="L3 cache breakdown per CCX")
+
+
 def main() -> None:
     global _args
     global _zen_model
@@ -351,6 +369,7 @@ def main() -> None:
         AmdUpc(),
         Idle(),
         Rapl(),
+        UncoreL3(),
     ])
 
     if _args.metricgroups:
-- 
2.52.0.457.g6b5491de43-goog

