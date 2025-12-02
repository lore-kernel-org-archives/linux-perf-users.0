Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53912E6CC7
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698071; cv=none; b=Gki0KvkwpTrB9jtLFGlhAgspZl5oDOhB4AUCENr2+HqM+SIDyUKw1R/GO1nRaHOO3UnEEfpuAim14kOrkBcYhVLQ0VlHn9AaBNPJ6M/4Q2sP+1K0LySx7RdJ4nkBvnGj1HRXxhDkp7fhjgGVMOFE3SvOfYUIMw39nX6q8VGbSfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698071; c=relaxed/simple;
	bh=DDSXnD/DJgD/dICvB1Byxj1+big3EiDNfGtz0EwuRes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RHYgenvxWA+7ZrytFYJUjIB1j+xLcXbGg8S6xaBp3QGWFuwZiqkt69xw9ul/Esm+5x+Raoilj1cB7YE6Fh4y/fHoJXOp78/qxPfOBhOecA8YNnyjlB0f3aQ4FSlNAq+2wgHSmeO7jDKxccYZs84g31FEQpDaNUSp540N56cQQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+dR90j2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+dR90j2"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so5233697a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698069; x=1765302869; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zEtSIIDn9SEKd5Nwsp78rOS06RnZngXyTnhJKt7idWA=;
        b=f+dR90j2s+bhpNpYckjBcJgE2tHpe5Rhso4RlzSZ5jyRXlsLytheVDFz+jSP0kozL+
         pua6ZcESwHG7UTtV3v4xAWDwTg5kWYa+kN1f8BMYcg1MlGeocVTvoQfofS+wnOoPFC+d
         /8lOTVnalAxbXloMykC3NRhaIFe7/Le/GGUa2OiqFGZ7jBIDy9myB2ZZ5vTEA3u4jMfs
         MU+P4vxoWiLpHRYILuhR19jJ7/Lnwedj1sng7R3mJ17m+k+wXAQXp0cmEoEKUQ+J19KV
         YQeCeegBYJ/W/coSdNvK/YN8+uHHH+ebV35PZwv2FV62+38mjtCdJ6xn61AmM+lC+ERI
         7hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698069; x=1765302869;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEtSIIDn9SEKd5Nwsp78rOS06RnZngXyTnhJKt7idWA=;
        b=lm6gA5yx9lf8rDwN/5fryy9Fr6OoXn7dzSkzirrD9FT9yt95Q6yfHqJXyvLiKxTwYR
         exLdGdjeKlXyyCKbYJnvlw0IhNaPuOnNKSL8/cZtG7Nr3dEf0YMw8pJz1Yz0D+QigaWR
         G5M+WKtV39VGz7yV3r/n5G/fOBLV6gOdhOjpxI/GYAiKlKcEBbpkb7M9rzFKwnHs+4mS
         HHpX4zdkE7ny0J3qjsuHTWas5o0BSivHFNfbVm2sJaesZDiKLhuYZS1O8X4Rfl3zqGJc
         guymuXcSwelkNw+imb5seYQlKyWEnZ4kLjZ4mBL/LL5oCt11aQ9UbvTuKmJ6/hG50PY/
         kZ1A==
X-Forwarded-Encrypted: i=1; AJvYcCVWJ7iEW+AqrX8z0/v/gevk7hsi3KbrSrKLKdI6+dV1fsIOD5ercQen9AjRIylbr5iCvL2OxVo5kzs5chpbpXp3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9gidt1axr43CnksaqBPOqvINBU4QBVj4MPii4zLkUtgnhy7l
	buhK/hgnxCRDomhUTJQ/NIbXZ9WJUKerci2qOS0gSYG5cjf2MV5sDadEM1WY8HeJnPlM2ktBs/O
	k3QfYomJVgw==
X-Google-Smtp-Source: AGHT+IHvr2ajxXLvGgMUZCNsqlbUgMIcYWCgD6Jkf+MPzrQCwnqS7NekH4Z05a8nN1CnLK5GdN8YmY5chBTv
X-Received: from dyke34.prod.google.com ([2002:a05:7300:4722:b0:2a4:6f7f:e6f0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f40b:b0:2a4:3593:ddf5
 with SMTP id 5a478bee46e88-2ab8fb54c8emr139000eec.34.1764698069042; Tue, 02
 Dec 2025 09:54:29 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:37 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-43-irogers@google.com>
Subject: [PATCH v9 42/48] perf jevents: Add C-State metrics from the PCU PMU
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

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

