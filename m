Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0C335BA8
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899546; cv=none; b=f1OEwQpn5rb89mWplVfv1YgYfI0RpreyROTncUWiGPTGRorwAJsQA1BugYRfiV4yfEMLIDM8qknmJLEC+xorVhQNx2Rv+olsIBwvKEV7f9sMzDOIzX+MOdzCmQrxZcEVGYKQoo2jNiBP4eNuuRQrGJ3guE3ExqOhyCpbdrs781w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899546; c=relaxed/simple;
	bh=0/p47u8XI/jepoD/8n27VWWYDMXq2JoIclYASBN8NcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Zps2Gk5/Q0QTenE27xkWm4HIoNxJ4gZ465b90rbO3Z3JS103JNCnM4rN0pA/R4ir7/l8k/GwE5BAFIy6SUrv6IfmK5bnXzcwlgsjZ4SYVoWqqDcaxOcAm/heHHLhEAsdlX86s4PrSd/U2ze7LN08CjB5TYRY56MPelDKBs9U0JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rcrGPhfJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rcrGPhfJ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-81d9b88caf2so321023b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899543; x=1768504343; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8hELqlVqsPd53TkBvYAfiL9c8Iu/vvPZfjM7X/WNAc=;
        b=rcrGPhfJNk5kseZLM0pau/Ffv02I8+NsCn4M2H4WiTBrujnL1+ojGjqiirQDAlTLlb
         822b3ukRb8jNUuuC/dxEzzSjAiUY6zTfme+SmfeyupCITvHv5wyCi7FvMTcQWDO8b8c/
         lc2FuaFcbnIg5uXvgOdZ1WrVSk311QKW5Mqm4u/Vb4ZMdhXSLtS2Dzb8VHjqAalLKTcM
         OQL5RXvMfgIp2lC8wlEcEoE90bLRddtNwHDGEutsKQa05RTI2wShfmN2WPmVYO5rAMPH
         /zkjBEDPnodvAjExPDI48C1ol08ylabqV40lPGMRejCuJnQ8d6aDDOSOe7IXWyNuzKnH
         jipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899543; x=1768504343;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8hELqlVqsPd53TkBvYAfiL9c8Iu/vvPZfjM7X/WNAc=;
        b=Rj418ZGY4nb6F9lwyJJkAom+r/sUjYPQs34bD3Als0Idm8h0bT+mMEZtwf+15bCBpz
         CZVfgcHPDrSaXzwsYE6CZpmttaCKD361PUbtpIUHit2+EwWi9XDuTHOIfLJB8iMfmSGP
         KMw1jrsiOBIaQZkVqT1fNZEOCe9czSJndsdTl9M65vT/+CXXbmBe4Uu7Xk0wuTowNXT/
         rMy9jCL0z9uO0NcNGC0RWqqPONiksmy4KHpXQ84RbKqDy17x62U2Bp7wARVyBJL/8569
         hwBnxARg0PCZWdlxXx4yIEHX48TgV2Q+7HcgVS2kZVkj2EAdh5LAN5wkE+Pnx1c2FJma
         MGiA==
X-Forwarded-Encrypted: i=1; AJvYcCUBRU53rRYPslOtQtxBhduOThhm3KoYXzLmc0vD1AyDATnCqm+2iHY/ePbmzJphax1atG99WjzpLm/JcWhswJFq@vger.kernel.org
X-Gm-Message-State: AOJu0Yya1KDy2SAlbh4wHkTYG97CGj7fKj9KfK2dWSZp9mpfSFwQFZPE
	yaYSI2Y7l5M8dZoMC2AJDuBW+hJXOqwlR1pL6co40JNq5v+HzQQ0XlsyH4x09CWFXHa9h9k5O2t
	UI1euMxfRdw==
X-Google-Smtp-Source: AGHT+IFRLVCG00OMl4aUYaYlQrWXSJrN6jHeG/wDPN6BSUfe309G2jTBMOTWjoyJ5g1BW6F9QWsfjo74w4mH
X-Received: from pfbde15.prod.google.com ([2002:a05:6a00:468f:b0:81c:668c:d977])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:440a:b0:7a2:7bdd:cbe8
 with SMTP id d2e1a72fcca58-81b7de55545mr5958156b3a.18.1767899542556; Thu, 08
 Jan 2026 11:12:22 -0800 (PST)
Date: Thu,  8 Jan 2026 11:11:00 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-31-irogers@google.com>
Subject: [PATCH v10 30/35] perf jevents: Add C-State metrics from the PCU PMU
 for Intel
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

Use occupancy events fixed in:
https://lore.kernel.org/lkml/20240226201517.3540187-1-irogers@google.com/

Metrics are at the socket level referring to cores, not hyperthreads.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 24ceb7f8719b..118fe0fc05a3 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -815,6 +815,35 @@ def IntelLdSt() -> Optional[MetricGroup]:
     ], description="Breakdown of load/store instructions")
 
 
+def UncoreCState() -> Optional[MetricGroup]:
+    try:
+        pcu_ticks = Event("UNC_P_CLOCKTICKS")
+        c0 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C0")
+        c3 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C3")
+        c6 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C6")
+    except:
+        return None
+
+    num_cores = Literal("#num_cores") / Literal("#num_packages")
+
+    max_cycles = pcu_ticks * num_cores
+    total_cycles = c0 + c3 + c6
+
+    # remove fused-off cores which show up in C6/C7.
+    c6 = Select(max(c6 - (total_cycles - max_cycles), 0),
+                total_cycles > max_cycles,
+                c6)
+
+    return MetricGroup("lpm_cstate", [
+        Metric("lpm_cstate_c0", "C-State cores in C0/C1",
+               d_ratio(c0, pcu_ticks), "cores"),
+        Metric("lpm_cstate_c3", "C-State cores in C3",
+               d_ratio(c3, pcu_ticks), "cores"),
+        Metric("lpm_cstate_c6", "C-State cores in C6/C7",
+               d_ratio(c6, pcu_ticks), "cores"),
+    ])
+
+
 def UncoreDir() -> Optional[MetricGroup]:
     try:
         m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
@@ -979,6 +1008,7 @@ def main() -> None:
         IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
+        UncoreCState(),
         UncoreDir(),
         UncoreMem(),
         UncoreMemBw(),
-- 
2.52.0.457.g6b5491de43-goog

