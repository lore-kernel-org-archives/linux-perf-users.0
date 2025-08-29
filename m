Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D324DD1F
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440713; cv=none; b=YRmH3NMpyNH19UDYoMIvhPD4jPBn0pIsjPTeuTVcogIoym0MyHGlkAEXm9tB2nzUXOj9g9fTyyjkX9lLL7HdMOZMOctCZL/5w6Ajf7LZSRqZmvqMkSAeMXUwIV4OU2YzTFy/N1BP6jBARZ8XmuBu7DJiTvH6lODMI7LUYTgh5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440713; c=relaxed/simple;
	bh=Hp5WV0n8SnsdwaoqohkLH+hIH0gHJxo/yXPqFsFnseg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IFHcF4pxEc180aEt0YkFiOTzX/6IuoJi2R0Y4RraDCt54Ye8rziRbkFk3THG7WM1qWovLBAO9V6th9XJzM9EcI7hrR2TgQSP4C4b5VHTHEDWcE115LSzr354+kn1I5zr1WODuLy5qkRjKi21Uk9zlaFlHIsyh+CYUc1cmzAMdms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RFUNEay+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RFUNEay+"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-248eec89618so11930315ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440711; x=1757045511; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhMZdtMjJhuzLc6gr9GuhAcC6OciUjcHbgWMOwK4Tk0=;
        b=RFUNEay+gPu0Mdj4bQ0ttfkLBO9q1dJFEfjRTpW0pEJWZqzIg5+qo3ZHK1sEwPjoto
         XkLMzuu5DFx1eVIEnY0Blz2G16O7xLmtkruXD5nYR+BHBiczYXEUXLLEzLABs1yjk6CR
         b6Zm/uM6vQ0chZQabu3zprgSg6qJq7lBoyYCb3CjJhpOEtmPYqZoO8BLqRZq0Z1/z88G
         geSF1DDwoBx0RgfDP/un7ztF4dfDrrT1z03IhiUe8botWpTHfshe35lYdcNtJny5uq4f
         oHSKG/hofBtwdQjFQLX/oTnyQnz3YBC8Q8m3Lwl7nZqYzJ/60o+UkrG9S18Fw4Kr03GW
         /1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440711; x=1757045511;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhMZdtMjJhuzLc6gr9GuhAcC6OciUjcHbgWMOwK4Tk0=;
        b=Oq5FlzkcxmJS0tj1rTJ8D+xThUSny/gcZCt3Q/FfWtbav4M3I/5WNKPV53mWJTkkAy
         P7cCdZtFOz0+1yotQzQ3jiDlJHdZpLXQlppdBLegGRrKm38o/VROESvZmyuc47y1oyhk
         YsgtKk3i4sIvg7LfnN4TOX1hHZJ/QY19FYnY33S6bb0Dv2dnC5sXcI0HzPmUIUSjbS9N
         Eur52pRh7jiKwDR2t2t4q7SxCYzrlobprGLvU4rQHETzzyygNz8NUSbJtSFUWSkc+s3+
         GJ6N4OnwNNMuQJP1EnPNqp3ko5JGqQWnF033CX+x6bluD4AL4cxbkHCfhLfKMxaNVfUJ
         yOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcT+cqbJQw+Z9r1CnXffEpwHCZua9CaKvBjacKPb++Ly96nYXoPsdAAPHc+jorC+w+37Jo3V/k43pwpLCvMvDw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1UnsJy0fn2pvnDyjt5JF4J1w10dRO0JHlC48VuokxT2KC3h4X
	DcT2BF6wjzpiBcMBGWtx05PtXmlwsnxtTGdaqBpaf8e+M0JCSuAml4HdY+Nz4aUExUMOgLcVmXr
	NDeg200L3Wg==
X-Google-Smtp-Source: AGHT+IHF7CHbu3OvL/I74+5b3sbk1r/AjOT14kvv4VtBF/x1sIiXfR96ALsS6D+gUrOUzz1+usM/iTT4ggNj
X-Received: from plbm11.prod.google.com ([2002:a17:902:d18b:b0:249:329:c51c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3843:b0:248:741f:2c31
 with SMTP id d9443c01a7336-248741f2e2fmr166214065ad.18.1756440711503; Thu, 28
 Aug 2025 21:11:51 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:53 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-13-irogers@google.com>
Subject: [PATCH v5 12/22] perf jevents: Add ILP metrics for Intel
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 03983107c5c0..df0e1dce041c 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -262,6 +262,44 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelIlp() -> MetricGroup:
+  tsc = Event("msr/tsc/")
+  c0 = Event("msr/mperf/")
+  low = tsc - c0
+  inst_ret = Event("INST_RETIRED.ANY_P")
+  inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+  core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                      "CPU_CLK_UNHALTED.DISTRIBUTED",
+                      "cycles")
+  ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), core_cycles) for x in range(0, 4)]
+  ilp.append(d_ratio(inst_ret_c[4], core_cycles))
+  ilp0 = 1
+  for x in ilp:
+    ilp0 -= x
+  return MetricGroup("lpm_ilp", [
+      Metric("lpm_ilp_idle", "Lower power cycles as a percentage of all cycles",
+             d_ratio(low, tsc), "100%"),
+      Metric("lpm_ilp_inst_ret_0",
+             "Instructions retired in 0 cycles as a percentage of all cycles",
+             ilp0, "100%"),
+      Metric("lpm_ilp_inst_ret_1",
+             "Instructions retired in 1 cycles as a percentage of all cycles",
+             ilp[0], "100%"),
+      Metric("lpm_ilp_inst_ret_2",
+             "Instructions retired in 2 cycles as a percentage of all cycles",
+             ilp[1], "100%"),
+      Metric("lpm_ilp_inst_ret_3",
+             "Instructions retired in 3 cycles as a percentage of all cycles",
+             ilp[2], "100%"),
+      Metric("lpm_ilp_inst_ret_4",
+             "Instructions retired in 4 cycles as a percentage of all cycles",
+             ilp[3], "100%"),
+      Metric("lpm_ilp_inst_ret_5",
+             "Instructions retired in 5 or more cycles as a percentage of all cycles",
+             ilp[4], "100%"),
+  ])
+
+
 def IntelL2() -> Optional[MetricGroup]:
   try:
     DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
@@ -633,6 +671,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelIlp(),
       IntelL2(),
       IntelLdSt(),
       IntelPorts(),
-- 
2.51.0.318.gd7df087d1a-goog

