Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE431D371
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004147; cv=none; b=XPz6m5Nnmr1kTLdpF8lzwUVtr6fur8tK0T+7EbrwvO6FWHEOZYVljQCdOqUgaZkuKPLiqtbVfvke8KxBq5I2S2hkYfXVHz9Qj/CSjeiuc9bpihIwBEarX6EhMSURtnL3GdAEklvq0ozncudZvLUw7qkVQBDOsQAwqok/WUeK4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004147; c=relaxed/simple;
	bh=Cgrn5s9K+hOhdC3Kkof0GurfCoyskQbob4D8Z7OGfPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uJiorZIE32WK2ddgL+v+Moa6T811Ye6jdAFlpu9gA6lEWcoB/mpdDZyY5mWcGCsX8BHumGzExZ39yomhOfnJCG1kcymwe3awOaQbD2ajYnM8969vQy75bBNvBLIRq9c5G1jTWqoSSVvE9PT+FySLQ5NGbHZyZ5LtmE9zSxOoYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+hHPxR9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+hHPxR9"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29809acd049so4390745ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004145; x=1763608945; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHh9aOjep5ch3f1bENK/wIAmZh80xO2AoWISVhbZGbs=;
        b=U+hHPxR9OJzpSWuI4LSJBFck/na1C1MAZsDb4IBT0b7//Sp8UbKA4k1qqA9NPEWnVp
         o7CrmdrT2TRlJSxbQmzURIEmMTsIbQcbY2a/QAHBoE9ghI+FN9aah7EsuEqom3X9tjnV
         Vb4FjdMwobEf2ZiUgLapurH035Sv9bFDgT+RU7CjII73XU6RK3St74k3lQJqQDkgpiAR
         5Nav8F+nk7eboCqcey6jezJB1Ak0/h5UNZLOZjVvVMyh59Gz3rmG2gYceFM1y+POoBmG
         BY6cqaz3w186CfUscMs8dQ8xXmg0eua5E6HoWGRiiO2kXHblT+dt99C/kTzYBiCOTl+2
         8k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004145; x=1763608945;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHh9aOjep5ch3f1bENK/wIAmZh80xO2AoWISVhbZGbs=;
        b=L4G01XrNnwyewQqqgua0p0dN7w8VKmM2ZKFUjeL2SVjnbJhmCT9Is/67exoZOtC3fh
         YkoXx432/7tcV5zW0NoabCe0olhJj8eMqds4KS+c0BnDpGO/Rdy0rN285UWtLgci+BBt
         wB8EVVtX+BRKKxPcbrFTAOOynfsz3cjxu0+/WPguehlnrJezYUXFJfe7+ov9Mx0SC8tK
         WHT4GHdpMyqY8fj7xMHSni3kBBogAfj35k+djGB/mgZtUNtfLHDSyHqnIee5tSgaQsV9
         F5iIS4XyCWp9zRjbaapuNb6RMx7/+J3g9nPSL+EZAuXmE+QEhHUDgfRLkIOShyKSpZ6Z
         w3/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsbQTW9aiDfLVvFiXX825gKnmq3I3F1L33dWdLf2zdVs+b1hTW/mEgH7xf4fgKlQcvy5eo88wZ5raGuPTN+S77@vger.kernel.org
X-Gm-Message-State: AOJu0YwVEwTCj9+N5lO0m8cqGel2lAHMZLxfjtRFgyVWVEkHUYaA4zYK
	bqHBbwXzvkaFogsVGOnk0dTxx7/56/PQoywEmbo1yvbw8t/qrkxN/imb9jdT4/W0Z9O7kOuq/3x
	bUC/rVn/Weg==
X-Google-Smtp-Source: AGHT+IEteJFe2wj6/twulKdAFdi8lqJ8Hyr8xL8nUMpnOp47DYZOzTaZS9eX1v7Kg+BqzewYZ3Xj2icn6/1s
X-Received: from dlbvv8.prod.google.com ([2002:a05:7022:5f08:b0:11a:29e5:12df])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f712:b0:297:c0f0:42d7
 with SMTP id d9443c01a7336-2984edcb752mr71037525ad.41.1763004145593; Wed, 12
 Nov 2025 19:22:25 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:36 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-49-irogers@google.com>
Subject: [PATCH v8 48/52] perf jevents: Add upi_bw metric for Intel
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

Break down UPI read and write bandwidth using uncore_upi counters.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 037f9b2ea1b6..f6bb691dc5bb 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1033,6 +1033,27 @@ def UncoreMemBw() -> Optional[MetricGroup]:
     ], description="Memory Bandwidth")
 
 
+def UncoreUpiBw() -> Optional[MetricGroup]:
+    try:
+        upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
+        upi_wrs = Event("UNC_UPI_TxL_FLITS.ALL_DATA")
+    except:
+        return None
+
+    upi_total = upi_rds + upi_wrs
+
+    # From "Uncore Performance Monitoring": When measuring the amount of
+    # bandwidth consumed by transmission of the data (i.e. NOT including
+    # the header), it should be .ALL_DATA / 9 * 64B.
+    scale = (64 / 9) / 1_000_000
+    return MetricGroup("lpm_upi_bw", [
+        Metric("lpm_upi_bw_read", "UPI read bandwidth",
+               d_ratio(upi_rds, interval_sec), f"{scale}MB/s"),
+        Metric("lpm_upi_bw_write", "DDR memory write bandwidth",
+               d_ratio(upi_wrs, interval_sec), f"{scale}MB/s"),
+    ], description="UPI Bandwidth")
+
+
 def main() -> None:
     global _args
 
@@ -1076,6 +1097,7 @@ def main() -> None:
         UncoreDir(),
         UncoreMem(),
         UncoreMemBw(),
+        UncoreUpiBw(),
     ])
 
     if _args.metricgroups:
-- 
2.51.2.1041.gc1ab5b90ca-goog

