Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F12FC875
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004130; cv=none; b=H2rguq1tKaSuZ//Ww8hmtvfIlLO6W4Wol97aC9csETxZccJq97YVCh4b6PLoBJct3h6LTqUqjaU5xpHxVrkhXdX1z4DHkliYLubqKROuTRtM3jR7QolL/4a6/6CM2V0hnFGghQLzuIamKecUe4IVbmcSlsZDRQIsN8gv4b0VndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004130; c=relaxed/simple;
	bh=BuIAYyNMq3IAp0j6+HENoO3ue/Xt0Y2U744Xu8tCfDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=azxRZmKZRO9nSewn/pyzU6+PN6HHGzHCvPwLdd/zTOBRj4LfGZxuw267W/3rpCklAS/TEMPcylAvxn5d8sB4rVXWJETqVhjAdWcAlq8V489dNndfoGa8asQydlfJClPKKhgDylzS88RbVmlFVc7inBAjDdG4NzMjfF0nsiTyVFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCBWswWA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCBWswWA"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297e66542afso10011765ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004129; x=1763608929; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eWSeHx62mFtsTcGK4paHRc5k1J5dwqX6QH7NFrtx1f0=;
        b=jCBWswWAOFAXUh8MiKTRW/CZNXUHYplwqazXfb8Gnd3uNolhZiz/yDDfSc8ycCfoNJ
         yXozOdSViXBtwrtiOb+wFBBz2BwMv+XePe79ezkMkQuYv5o0g1U8zcLYekBkH65y+eb+
         +kpJu+5IocK7utETL0UbKbP3Dy4RIAny+fvHPSZilV9QcYHnV7CmpaH4lIoYMhQyl32N
         7cjYKRrF1rMmGkfcHTYoaXKlVSxYs6nSvRpyz9MFbB1Ues0fF3LUTewARb8J3zJj6gMZ
         vQlLirNlVg00/HJcxXWD1lQXb6TREIBlyySuVDJ1rGgewjffCapaQPFBddhnk8VuY+ZC
         Sz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004129; x=1763608929;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWSeHx62mFtsTcGK4paHRc5k1J5dwqX6QH7NFrtx1f0=;
        b=G4nwW1Fq4N8z+LBx5skPO5TawmUUvfqG5Ny647bm3YUTNHXA1TAE8qa7JKQRrtd0KF
         OskYVTPRw6GDYOQ/gwz2WsRIOqQbbBNf/TxzJA7LkWNjT0l4mBr2plJ8Ndy/TI6zNUOq
         r7WbZ9/h8btRH4D4ijoWaeUHjbN2gXDNl8yneGXdZqwof0kWHl84oAEoej9w0l9nz1XU
         iswwPLgxJ1g/WPnKqflLdvD3GyXsaWnKo830/Nbo0StfxdyK3Bw/VidPPwRVr5uTT7vk
         dN5u01SecNN/BS4VTcoHYl9p45vynSWFgjhohNine7Kp1fba116vVNMWVUM/RRFNPNiM
         OWkw==
X-Forwarded-Encrypted: i=1; AJvYcCWdcw3j5Kh4CYxaFDnRDQ1d20s+l2+MxWID2CNbuTwSyCILvVIIogoXZOK7sw/oR/2j9RuxNPtk+CWIR3TSxngQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyQdPyjdvsoLZRLJZoAwS9VBmclefIMO2eKigehcvYXNyOWW8Iu
	1muLBH20djmfLFEanSHMhGqJM5rnadA8IBrSK5aK1QmyRBN4pMNWJeIMgLAWaNJMUHBAQOYcrz/
	cbBAHHcKNog==
X-Google-Smtp-Source: AGHT+IGle4B5YsI4ZJFIfE+2wzp5CoEpzKhiQOYTSbpWS9Y97npyU8+xFp1rVZyv43ldRhi/EH81rCFybKd5
X-Received: from dycpw12.prod.google.com ([2002:a05:7300:de4c:b0:2a4:61a6:6c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e947:b0:295:592f:94a3
 with SMTP id d9443c01a7336-2984edefe32mr68231395ad.48.1763004128714; Wed, 12
 Nov 2025 19:22:08 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:27 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-40-irogers@google.com>
Subject: [PATCH v8 39/52] perf jevents: Add ILP metrics for Intel
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

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
2.51.2.1041.gc1ab5b90ca-goog

