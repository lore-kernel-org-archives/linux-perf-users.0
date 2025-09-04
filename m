Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C9D279DDA
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961260; cv=none; b=I7eMDsEC4cZIMpuay5HC0sIh25aMHqOG2ydYw7KXcHZMWNniVtBHjkqjIbpROTZxBS5bj18imeBfgvE93EkXIEP+0kGfdWFfOCqC8zw7tjVbUR29VY1tLoasaIPfYEsuLeY0eSey5GjuTNkh2U25jxBkBSHPd2r/OFj+rx2TkbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961260; c=relaxed/simple;
	bh=WgVcgUdPY54/oQ+eQT+NZOGinWPMmAbwiaLX87/GM0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SflArOSyBnPWT3w4Yc35Nk7TahAWxbuK6J0WQUO8wg4XYle5OX9v3v/8s533Vqoj3muGA8CUnWvH5d3drPMVgX5K7P+GQbIP0xTjKak6hBmDm8GuyDaHlX2WHu+5HnW8bTZJ4zxGk5ca9wRijIrF4YPzMyCZUtkfPMCARDqhjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yAR3xII1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yAR3xII1"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24cba71c71fso4963845ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961258; x=1757566058; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeKqI6ebNZk2OSGf7DnIa24sXNm81pvOyP36Y1EWvxI=;
        b=yAR3xII13+c7nxK6jXxpaeWXk+YtpYYRsxaahrS5ddVl68UhVRAYKTl4CePZ6WJIef
         3lgvvSCTmgCf8LV8ZOXhayMVNrwDeHZqpMdFLQVRNNQonpjeP8JJ3onj5cHTVGzIUUQk
         nDJsODthAxFZHgI/eO0iBSJZ5jP4TZoPsaMONj4YUnAynhu6Tmk2KJW2YWxyNVSTpMKB
         bO6qWXohSvBXA5ssSoEZx721q8E+TlsT2I0HrSnjfCWyUVtTMQAYnAnZgwNum8XEF81F
         XEtU9pqYzb8Cwgw1I07kmNb33NSvAJnJ+brfXN9D5VOWrv/kod0RXJavrM0CNWwBdr2b
         c2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961258; x=1757566058;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeKqI6ebNZk2OSGf7DnIa24sXNm81pvOyP36Y1EWvxI=;
        b=AiPgj6npQx6s0Lq633VG983k+ERm/ExarYrYuHPR2Ur3Ie4WlvprvQOlxkbaHYRmDq
         vesF6WeVJu80cFPLWEypP88zK1bMhJKZ2pFusykzHQRIelWUCvb+PHYMUQVCzmgFXDe6
         IZYUSOF1+D4rsLRn1U5mpFK+w2WG59r9ZRqSed2dRU46uZ19i7hTU94p+oloC+IhoKRE
         /DfMKPiJE9yuchE+cG6ahEpv2uEZpKE190v+QQxqF61AYErLhfqmMcgjZHlwdqeVRQUU
         PRBvIk9IvQq3Bf5GzI7kBsmZ9HoIrQ6z9nsZyZFdbQFg8GzyNnB1l219EfgyfmgEpF/o
         KFZA==
X-Forwarded-Encrypted: i=1; AJvYcCWd7kD/iK0h0cqD+gfh9N6JP0mPqpGA3n9GtmkqgFpXeo7ewB3NTc3G1MopiGdQCQlRNzWe/07Z7HOaPrNfbedV@vger.kernel.org
X-Gm-Message-State: AOJu0YzvezBzFwgwb63RkuCkL25gawCMGf/a/Rh4EWuokcCu+oCBtYYT
	B6GGETfC8ooBuEwCCt2vM8MfESRm8cbu32gYylL4ft90M7PIR1LSzOGyMncZPXpIPZVOAI8VQ3k
	+7WjHYPgZaA==
X-Google-Smtp-Source: AGHT+IGoORPmYjgWxJS10suOpl3A8FHJZo0ncTb0Cn+5QwvLUoT3l8NO/UcjqQFK/RincPcsu8phd8kZmz9j
X-Received: from ploc11.prod.google.com ([2002:a17:902:848b:b0:24b:bbf5:4bc7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22cf:b0:246:80b1:8c87
 with SMTP id d9443c01a7336-24944b2a6d0mr202623705ad.43.1756961257708; Wed, 03
 Sep 2025 21:47:37 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:52 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-22-irogers@google.com>
Subject: [PATCH v6 21/22] perf jevents: Add upi_bw metric for Intel
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

Break down UPI read and write bandwidth using uncore_upi counters.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 47e8f1166870..e639e8998d87 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1009,6 +1009,27 @@ def UncoreMemBw() -> Optional[MetricGroup]:
   ], description = "Memory Bandwidth")
 
 
+def UncoreUpiBw() -> Optional[MetricGroup]:
+  try:
+    upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
+    upi_wrs = Event("UNC_UPI_TxL_FLITS.ALL_DATA")
+  except:
+    return None
+
+  upi_total = upi_rds + upi_wrs
+
+  # From "Uncore Performance Monitoring": When measuring the amount of
+  # bandwidth consumed by transmission of the data (i.e. NOT including
+  # the header), it should be .ALL_DATA / 9 * 64B.
+  scale = (64 / 9) / 1_000_000
+  return MetricGroup("lpm_upi_bw", [
+      Metric("lpm_upi_bw_read", "UPI read bandwidth",
+             d_ratio(upi_rds, interval_sec), f"{scale}MB/s"),
+      Metric("lpm_upi_bw_write", "DDR memory write bandwidth",
+             d_ratio(upi_wrs, interval_sec), f"{scale}MB/s"),
+  ], description = "UPI Bandwidth")
+
+
 def main() -> None:
   global _args
 
@@ -1050,6 +1071,7 @@ def main() -> None:
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
+      UncoreUpiBw(),
   ])
 
 
-- 
2.51.0.338.gd7d06c2dae-goog

