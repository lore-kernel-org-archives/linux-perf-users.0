Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29F52E1F02
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698063; cv=none; b=sjQSZ22Xmz9bZq+fIQxOLeunXPP2eVdFvEqbN/pAZpl3IqduEmvmtDSAGRoIkFulbKIGJ6nsReZosOdg4739mrz5EUBejznRDIWJTlyhEmuCijHHXNXZ4YKniZlfl4I1ejcHD6LRZ/AsG5enr3EjrV4FgBbuMHSvCKvafbUdLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698063; c=relaxed/simple;
	bh=HbqjuqmfTyXOvOBzE/ZBtIvkD3sFaHP5dLAWeufweuk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=r6iim0k6e2E4ypO0j6WLTQQ4KMrh/sbU1juO6qwqNzYc386NzEH4gnhRfGnuwVfVUx+RahoGky5cG5UHvO6eyxKW4bP8uAXObEeRwRu5vNI71v3dlq5rykEXZPAiYAiBvInKCArl2jrmRQCSeIjwix22v4GQXXAAAuw+1T4bYZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kcnjlk1O; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcnjlk1O"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29846a9efa5so106144345ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698061; x=1765302861; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LiDtubt1AphVgSFkzW+FmI1oqQxqLj5ewhOCQtRYDYQ=;
        b=kcnjlk1O0PtQSrSZhgyc5sw2qPVKV63fvP/Tz/Pe+otgs7XPkNbn9shy525b1X/MoF
         aqMn/QWGFExWXZ/CxDlNveOSxseY8uhJIEzO92NRNXRhDxInHsqmayzOqhJsNN21B8BL
         h62tO4cl9PibBcrmvrKnw/dowKJ2pzbISGqwzaLDYSVgUqtKYRQXOIU4Aku+WRqi5Jcr
         h15OU+8w53VzIXTDy/gjVG8Fk7MoSx9jA1hunoUlIHANNCgqX4EEk9YKSn7hB3QACS0h
         Utx6JMe2hdpBalBA27c30ZesvCYcQY7Li3D5ZKEQFONL1Uingjsxn82+gNH1w3TMxbuG
         qx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698061; x=1765302861;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LiDtubt1AphVgSFkzW+FmI1oqQxqLj5ewhOCQtRYDYQ=;
        b=xG0cskP5euWDlf0kp8w4u1q705py2BfUyWi6llV+Ik4qwfk8p1uq7Y1bDZGGhuM5o9
         DtTcUk56OC+W+BYHXn1MSEOUcXuSs4J+ZL71ag8xQioqzslcokJTxFXU7BXwVyxGG3gH
         Pt2vd0Lq/pFQO8qbA3aPZJz/NC96sYUAw1LvjE+QA4o+VLnPObwMSQeWDCZBqpV/ht9w
         hnMXr00R8N19duaynjozXFkmJqlTRO52wJE4VBee98eQsa8SpNvIXnWrQ+RrhVp4fEn4
         mB/mFnhwuX6wKboSZmT4mGdSZA76Jc9Ow4z4JJTNZU+ZQ0X8Q2/LRqd8W6AfdqLTzuJN
         lmWg==
X-Forwarded-Encrypted: i=1; AJvYcCUrO6OcrqVo6SeDWPoMv539Bv4cRu+x7IBH5y/0Lubm+gWPu6uQvbEFXs1hKR+4ivxPk2uc3qAcVerj3UwVf6PH@vger.kernel.org
X-Gm-Message-State: AOJu0Yymdto52hcDRSu46ttZIG6HTkxqWPurtHoLVt7orSSNxrVw2Zeu
	pB1yd23STfMFfgARnxF97b1puYTqhho5H3R7XCebgct9lVSDc7VkJ6er0smV9BMWCoX6NOSDg38
	VxnXqV+7eng==
X-Google-Smtp-Source: AGHT+IH5qHnWptUctlRlS9Et1AE/osOMz74PdqfxaJzodJz+anR5B8/WSihGvugo+rrwS7KOq9hdAaoSJyqw
X-Received: from dlnn37.prod.google.com ([2002:a05:7022:61a5:b0:11d:cde5:d78e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2509:b0:11b:bf3f:5208
 with SMTP id a92af1059eb24-11c9d708d55mr25940152c88.1.1764698061026; Tue, 02
 Dec 2025 09:54:21 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:34 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-40-irogers@google.com>
Subject: [PATCH v9 39/48] perf jevents: Add mem_bw metric for Intel
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

Break down memory bandwidth using uncore counters. For many models
this matches the memory_bandwidth_* metrics, but these metrics aren't
made available on all models. Add support for free running counters.
Query the event json when determining which what events/counters are
available.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/intel_metrics.py | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index dddeae35e4b4..f671d6e4fd67 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -815,6 +815,67 @@ def IntelLdSt() -> Optional[MetricGroup]:
     ], description="Breakdown of load/store instructions")
 
 
+def UncoreMemBw() -> Optional[MetricGroup]:
+    mem_events = []
+    try:
+        mem_events = json.load(open(f"{os.path.dirname(os.path.realpath(__file__))}"
+                                    f"/arch/x86/{args.model}/uncore-memory.json"))
+    except:
+        pass
+
+    ddr_rds = 0
+    ddr_wrs = 0
+    ddr_total = 0
+    for x in mem_events:
+        if "EventName" in x:
+            name = x["EventName"]
+            if re.search("^UNC_MC[0-9]+_RDCAS_COUNT_FREERUN", name):
+                ddr_rds += Event(name)
+            elif re.search("^UNC_MC[0-9]+_WRCAS_COUNT_FREERUN", name):
+                ddr_wrs += Event(name)
+            # elif re.search("^UNC_MC[0-9]+_TOTAL_REQCOUNT_FREERUN", name):
+            #  ddr_total += Event(name)
+
+    if ddr_rds == 0:
+        try:
+            ddr_rds = Event("UNC_M_CAS_COUNT.RD")
+            ddr_wrs = Event("UNC_M_CAS_COUNT.WR")
+        except:
+            return None
+
+    ddr_total = ddr_rds + ddr_wrs
+
+    pmm_rds = 0
+    pmm_wrs = 0
+    try:
+        pmm_rds = Event("UNC_M_PMM_RPQ_INSERTS")
+        pmm_wrs = Event("UNC_M_PMM_WPQ_INSERTS")
+    except:
+        pass
+
+    pmm_total = pmm_rds + pmm_wrs
+
+    scale = 64 / 1_000_000
+    return MetricGroup("lpm_mem_bw", [
+        MetricGroup("lpm_mem_bw_ddr", [
+            Metric("lpm_mem_bw_ddr_read", "DDR memory read bandwidth",
+                   d_ratio(ddr_rds, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_ddr_write", "DDR memory write bandwidth",
+                   d_ratio(ddr_wrs, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_ddr_total", "DDR memory write bandwidth",
+                   d_ratio(ddr_total, interval_sec), f"{scale}MB/s"),
+        ], description="DDR Memory Bandwidth"),
+        MetricGroup("lpm_mem_bw_pmm", [
+            Metric("lpm_mem_bw_pmm_read", "PMM memory read bandwidth",
+                   d_ratio(pmm_rds, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_pmm_write", "PMM memory write bandwidth",
+                   d_ratio(pmm_wrs, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_pmm_total", "PMM memory write bandwidth",
+                   d_ratio(pmm_total, interval_sec), f"{scale}MB/s"),
+        ], description="PMM Memory Bandwidth") if pmm_rds != 0 else None,
+    ], description="Memory Bandwidth")
+
+
 def main() -> None:
     global _args
 
@@ -853,6 +914,7 @@ def main() -> None:
         IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
+        UncoreMemBw(),
     ])
 
     if _args.metricgroups:
-- 
2.52.0.158.g65b55ccf14-goog

