Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6B5822F
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396022; cv=none; b=WW3rDW5SBsm7SHq31jAMTru1Xouvs3Tzq8F3fOs+g44VWuN+mWOZnTr9FXJtyHub6qb31sRnvHJpKsMTSRFWkHFJ0Z09SkeHWzyWrzT/lPSWHslzNxAlvDhaoUMucNh4h6vGy9sbAJIPv44OVvxvFESqKLxH7LoX4hZHuYzl3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396022; c=relaxed/simple;
	bh=CsX0lQnByBZDbYc0bC/+3WRwprgEBJaViufFNrdPpWk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Kc57ER+gyiVIeuQykLETMTKGyXGtA7kNkgNIA5QN0o3NP07PnE+Vb/yntQR5g7m5WAwd0BYF6oEAi8Mhs9OLZ0/tBHJRMEZlTmwFENlhMwBIiNrGTTqngVh5eMDQQnKRjwRqTNZwv+bmi6v5QZMcspUlXW/ozZh+4PFB2KOwMQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z4P4Qx+P; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4P4Qx+P"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a5374f3bcso10763567b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396018; x=1711000818; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUWUXwe+5uPOvq9VWv9aWVcoc1LyId0S73x8LQ06sEM=;
        b=Z4P4Qx+PheNK5oyDBjNw1WMXug4nbu4Z35fx6OalyzXjPSV907aMCNn8hNIHtC7LTO
         kPeRDFj4BX6njGC1pUCc70TW10aJVcKcq6B3yssnZy0mSp/PLbLedhRymeYCw3vXeSRl
         x1RpD1b57vlZpmZITp+EFsEYqXgA4QpzpgVwFucfQNdSXV41rgPB8vQ15QoFsfygQ4VA
         +bTI2Y/zNcvMbh3wZ9eKqI949J1goJzWrPwBYKWzLJHl4KRKp0nXgKAGI4Cb2DDmkemz
         KvXcontuw0m0yz+AO5iUkfTdS+LTHs/nxMNOW8V5qvNcEvQVM7Q9chBmVfCPISOu5woo
         oOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396018; x=1711000818;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUWUXwe+5uPOvq9VWv9aWVcoc1LyId0S73x8LQ06sEM=;
        b=Bafko6IvGusexU63/rDGNwAtJnENgCW6+IavqdO7/f4sj5r26LYMZeKPN4yom0Wk5a
         pSh7T+4Wqj9wRAjaA6/fVTPmuFR2q8FHUMl+EbuBxp7oLfSoRWehIozndpRmp0CKgGXv
         Cq0kuuvt02N8/+XauMwcr4wtBie3Q8QJvBcNJCaS6mT/wpVmFwN1dfOpPgNze0n/SPgv
         6cIGzq9Tq6wcAgGO66e7Oq6nipmhoHfzYASH+8KC1poTVdEuwDk6qgrm2oQp6XL9w1Hd
         sY9AAgNx9KGA3kTXm2kEER42rMFuY5/VA8+2CMz4CpkMy8Pt8TpaNStLpWJo0ZptlAGu
         nXUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF+SLa0I8MoHJ3+Dg7dfszSHDRvn0msAfhI+WzcjP1VZm+kii5Xlyf3XOB0FG1Nwct2dcPtw7u9fv12gDb5kKlhncW3TWD0Xbus3sHw0PQLQ==
X-Gm-Message-State: AOJu0YwHq/1zE49PpuCZYKnGLrfEuH7ZtBcrzcRqYttWhTVas18qhrT+
	T9+SG/1UyOmhFVeqdbpPKIrwCZWt7WDCdkn2e8sG6tCdriMGTUzzVmfTkVn7ebro+Yg3qCFzrXM
	VM5g89A==
X-Google-Smtp-Source: AGHT+IGkvCXkHOuijNMrlG8qdOyE9AHiz1Lw63N3mHdp2yGpOkH9A4N3QKasquBeDRnefnUvLLTmQLydVhes
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a81:4886:0:b0:60a:66b9:c089 with SMTP id
 v128-20020a814886000000b0060a66b9c089mr150033ywa.8.1710396018654; Wed, 13 Mar
 2024 23:00:18 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:19 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 20/20] perf jevents: Add upi_bw metric for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Break down UPI read and write bandwidth using uncore_upi counters.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 95b4dd3c175d..778517968b4e 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -983,6 +983,27 @@ def UncoreMemBw() -> Optional[MetricGroup]:
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
+  return MetricGroup("upi_bw", [
+      Metric("upi_bw_read", "UPI read bandwidth",
+             d_ratio(upi_rds, interval_sec), f"{scale}MB/s"),
+      Metric("upi_bw_write", "DDR memory write bandwidth",
+             d_ratio(upi_wrs, interval_sec), f"{scale}MB/s"),
+  ], description = "UPI Bandwidth")
+
+
 def main() -> None:
   global _args
 
@@ -1024,6 +1045,7 @@ def main() -> None:
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
+      UncoreUpiBw(),
   ])
 
 
-- 
2.44.0.278.ge034bb2e1d-goog

