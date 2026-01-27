Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA44363C7C
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539572; cv=none; b=sxtTkH8uRHF+AJ69nvJcIyjWSPKU+pbPIDKKmIFeLRFqYGU9YHCFALd5/59MYuSHdilr5GT0TcICB3fi7SrjfhWhUu5T5Bwe6GNwEHg7yy6tK7+g2MIGZsBxAY4LRTCg5Lx6psY8q0mmQ15DGgRQomEOvrQ/pCmbT6L9vM/cAPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539572; c=relaxed/simple;
	bh=5xiZtz+7A1r9ki67YdNxm6S4vRgkIhkqUDeTkPmh6mI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KLbw6xILHDuA/u8efQBcpGEHQmEXpZBupfb95c32FGhU5dCsINEPcMyNhe9a+goNR5KWD+Q4kBROxdLP+I1/TchxrcsxNLX+WNqPX3rwgwLvbe44lr1CN6p6nAyylv1y38MzrjJYtA/3i+PLOIUVx4bpUxTUV/cLz6wzYECL3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VySkdmiO; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VySkdmiO"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b7155ca88cso5835647eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539571; x=1770144371; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfvDdkmRBFYOyeN2O+RaG4K637ivAdshUHZLdNirJKE=;
        b=VySkdmiOWgJ7o2Bzf9bds0jiHGTm7CRKb2XdET/ys9XVJOxMrhMkczpz+ggZy5J84M
         5FvajUZ7rNROqn9krGyGSh8DsFBuE+Xwyx7eLmTKYdMBkk7EGVGKClSuhn58Aq4ny9is
         EM+ig9Fb4iauyGdkUNSXJtgT9r+Jjqtd6KfYdQ9jKg2giqy1jv/zAHgOWCLRj5aVPrIN
         2+LvW6AxlnAROkNIcv9WK6ryMMu1bkMJnlM/4lAJ/95VvijR1CbeFbICkE944IhdtX9A
         6cjDKUY6X9oOrJcYQ0ioggpvCnjNA2LxKRstEVHqKoDHlzI6Pc4VssT1pH6WwZdtt6Nd
         vLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539571; x=1770144371;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfvDdkmRBFYOyeN2O+RaG4K637ivAdshUHZLdNirJKE=;
        b=YQMKNsT68Hy74KgsqN3hKDxGFcMfJFhrQkgaaezLX+2PP/pMe8mwy621Y3sN+dIBE8
         LT3IGCYSQH67cELgMjRuVpoi8DW5gCKjOMbj2h9laOm2UbmBMD1rxEqX66+SOlrnjwJn
         617ZbcLS2Yq60I08Cod35FUS7ACgeZ1CEbRJY1rr9bzFOXLzcBCpKAmmfeTCG69c7Ntf
         gDhe1o+jZx7qIc5nviJHg4FRUBnWJObOVUeper3g96/AFjS1WQeTUmw7PdgSLMPzwQXz
         LcIaOxuKZkgz2pVTZ9Y8IRFJL27UbZAH4CQJLZpDNkw0/DRw59IwgU0Sj433k7JXt4wr
         YmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqpu17Sjp4G1FlwlLvcRxD8qzzcPovlYJ6QMkd7AuREHUmhlrj09eWJ05J7mQxklHTVJF0mnjleGYSxfA9tAgj@vger.kernel.org
X-Gm-Message-State: AOJu0YwuGTPmFfQKH702sDu/E+BqxFo6P0HjWuyvxYmdCZVMS9GrMriD
	wX7FucPBd4NWV7XRtvUCpB64IH/bRAOxpLAmp/RS3jL/nBk/cp9Nfy/hp77tZAszzxvmx8GeuGX
	MTPENg3Tfrg==
X-Received: from dybtr9.prod.google.com ([2002:a05:7300:f549:b0:2b0:4f93:391f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6d08:b0:2ab:ca55:89b1
 with SMTP id 5a478bee46e88-2b78da0a187mr1459124eec.40.1769539570509; Tue, 27
 Jan 2026 10:46:10 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:54 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-24-irogers@google.com>
Subject: [PATCH v11 23/35] perf jevents: Add ILP metrics for Intel
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 19a284b4c520..bc3c50285916 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -263,6 +263,45 @@ def IntelBr():
                        description="breakdown of retired branch instructions")
 
 
+def IntelIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("INST_RETIRED.ANY_P")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                        "CPU_CLK_UNHALTED.DISTRIBUTED",
+                        "cycles")
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), core_cycles)
+           for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], core_cycles))
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
 def IntelL2() -> Optional[MetricGroup]:
     try:
         DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
@@ -639,6 +678,7 @@ def main() -> None:
         Smi(),
         Tsx(),
         IntelBr(),
+        IntelIlp(),
         IntelL2(),
         IntelLdSt(),
         IntelPorts(),
-- 
2.52.0.457.g6b5491de43-goog

