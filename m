Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7AF3644C8
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539582; cv=none; b=ALSR8eJbXdyUVhewVRZBkr1eh6Z8XyAzWdIMZI/QNfgkFkHxufwHnI3yeGg+bHBxMpT1vYVW4BAmeVN3KnvznHCdU3APsV+yra3sOleKrfqTeQBek/kszjoQVHYGgsKPuhtg5fRSrguqtuxKAgJUDBuRfYsuICH75vc7R9TzUSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539582; c=relaxed/simple;
	bh=iFgxYI8YkDQdRRykiWwbB91svFRxih0jHTs5Ccf/Mo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ktEA/bfKiqNNDXjsZR1Xd7eAgS3Xs5nfQzAHXttLDIXSuk8XnUo5QQV8UvswBsKcezVXtiAs/riwpsQZh70VD/8tS4cO16UZkn9YtqhH5Y2/qnlgrSrFC/8bsysEUBDcIFkDtKL0LNiLkNOsay9X87uqJAvR3wtgK5eVYuyDyXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MtK8vIcD; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MtK8vIcD"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b71bdcd037so81936eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539580; x=1770144380; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5NprC8R5leRz2bKlO+oNnE5MEyD18eL1u1cM1xoByk=;
        b=MtK8vIcD/nSp5QtBsr91wkuxDWnoFUf+vFjvLWRvPJfpckZN300xLmUgXB8NyaVrrq
         MdZW4sqtrmUkLlCdzv0VhwzrCNPva6eNlvDgoe2azpnb5zKk+obSzvOf4Wt3eW+rsgcX
         jhrZ4LUtlf2ZWFGsdEdLvm4u3LbNex6ydfR+bkSKn0p9ZZst7erd/2qZfysjA8Zv4gce
         C1+Jjzd1zEFySoJnrvI/z64CK+XFRww4O1GTXXyWQDXpwmBAUIWafEu+Hnnq17JyRRTq
         2oCeVec6Mzrhljy7Mes6u1uDIjFihh0vYxFITC6WNlZUF0I/4xlONKhyCpHiLJnyfM/O
         8+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539580; x=1770144380;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5NprC8R5leRz2bKlO+oNnE5MEyD18eL1u1cM1xoByk=;
        b=s15k65mpYlG8CCYs0w2RE8RZuWzZ0tnkSvYcFPga5XL1TsGhEON7hsaGJC76wRZqJ8
         xOsEOcHN1lxiztj73pZoweGFxKyihbMmebfuMe2IEXHRwnu6/aa9TK2paq52k0rMvm5x
         PmvRshykNCqQjPnGJZq6a5ljs8sczI7ZxBIOeQw8BjguBnYg1XQchMciOPY/Fq0M6787
         kGat5fv73p+1P6CdoAV/ifzxj1slwNlsLlhTDT/7WM6jFfd5kKY2oEOSBkh1YAoGTR7k
         hsZOTt83rYjsnsbX1iiu0upuyYg4bumA9tPzZGYhe8+jo7EpEgPGoRshOYHS9g4vQ6+X
         vFWA==
X-Forwarded-Encrypted: i=1; AJvYcCUVs0eUFitY33fXzTtZGwNJ/cY68oxZbY7APvEGfPE8IcsqPmKIRX8/ht3spIki4gQCRrWU0JBRmQkGc7csCZZl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy903hYMSbDLBu9yhj3NKEFbDaPUlSNULywrXj96KQ9pyCLoAjJ
	QNv2nEUScLxH0rJXlB5/+yr5Ic1bR6uDsLFi+ofZjqwch1Gulx6jvHLDn7IExEk/oJPHRUhC/72
	14Psd9wg31A==
X-Received: from dybqf15.prod.google.com ([2002:a05:7301:648f:b0:2ae:582c:694f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cd8d:b0:2ab:9d23:f0b1
 with SMTP id 5a478bee46e88-2b78e7bbecbmr1229676eec.13.1769539580277; Tue, 27
 Jan 2026 10:46:20 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:59 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-29-irogers@google.com>
Subject: [PATCH v11 28/35] perf jevents: Add local/remote "mem" breakdown
 metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Breakdown local and remote memory bandwidth, read and writes. The
implementation uses the HA and CHA PMUs present in server models
broadwellde, broadwellx cascadelakex, emeraldrapids, haswellx,
icelakex, ivytown, sapphirerapids and skylakex.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f671d6e4fd67..983e5021f3d3 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -815,6 +815,36 @@ def IntelLdSt() -> Optional[MetricGroup]:
     ], description="Breakdown of load/store instructions")
 
 
+def UncoreMem() -> Optional[MetricGroup]:
+    try:
+        loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL",
+                        "UNC_H_REQUESTS.READS_LOCAL")
+        rem_rds = Event("UNC_CHA_REQUESTS.READS_REMOTE",
+                        "UNC_H_REQUESTS.READS_REMOTE")
+        loc_wrs = Event("UNC_CHA_REQUESTS.WRITES_LOCAL",
+                        "UNC_H_REQUESTS.WRITES_LOCAL")
+        rem_wrs = Event("UNC_CHA_REQUESTS.WRITES_REMOTE",
+                        "UNC_H_REQUESTS.WRITES_REMOTE")
+    except:
+        return None
+
+    scale = 64 / 1_000_000
+    return MetricGroup("lpm_mem", [
+        MetricGroup("lpm_mem_local", [
+            Metric("lpm_mem_local_read", "Local memory read bandwidth not including directory updates",
+                   d_ratio(loc_rds, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_local_write", "Local memory write bandwidth not including directory updates",
+                   d_ratio(loc_wrs, interval_sec), f"{scale}MB/s"),
+        ]),
+        MetricGroup("lpm_mem_remote", [
+            Metric("lpm_mem_remote_read", "Remote memory read bandwidth not including directory updates",
+                   d_ratio(rem_rds, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_remote_write", "Remote memory write bandwidth not including directory updates",
+                   d_ratio(rem_wrs, interval_sec), f"{scale}MB/s"),
+        ]),
+    ], description="Memory Bandwidth breakdown local vs. remote (remote requests in). directory updates not included")
+
+
 def UncoreMemBw() -> Optional[MetricGroup]:
     mem_events = []
     try:
@@ -914,6 +944,7 @@ def main() -> None:
         IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
+        UncoreMem(),
         UncoreMemBw(),
     ])
 
-- 
2.52.0.457.g6b5491de43-goog

