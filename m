Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1988636BCCE
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539586; cv=none; b=KhshkMDQcPAcHmabFowI5ZQp1kwRSXkcUhrVDmaJQ8wA8Z17fe8b4K2pq1uAUNw45bgk7EdMqKrz23MX6pgV4MQI4Tb4dICuQgRr9OEKKsF/RmrBEcYZgHs4ZbQZRYEOCZn3Z8kngEmaRcILeMHo3BLFh02JA65NJll7XeQ+fhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539586; c=relaxed/simple;
	bh=0/p47u8XI/jepoD/8n27VWWYDMXq2JoIclYASBN8NcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KRDRBWVng4XGGip91g4yWnkzJvKMvDqLJf7+GU/AZffNtsn5cUq0+T9JX/ODPLJ2PQWS8poCHzaK3qCc5qk0VGVrlpfLCvJM8+GpCDtfkSvvPA79VSvopq2GVAqcJy0bRmU5WglazlYPaIvk7Cfp6lZRFBq9V7hF7TM+kHsWvu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PjUpvf1y; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjUpvf1y"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b71c5826fbso6471376eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539584; x=1770144384; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8hELqlVqsPd53TkBvYAfiL9c8Iu/vvPZfjM7X/WNAc=;
        b=PjUpvf1ygi+Hbk8spsqC5wR8y/0AlujyVQ9vmQPR/4bmkb5wwJp/pQb9yGCz8T3OnO
         C4ICh+BGtLGSxV+YTsnzHa4mnYc1T08qxtqzOoDl5GPh8Nf8iDCDVQTFvZx265eXptTX
         XRXhYjBGcTPPeXqBDqZdF2tZpYB8y9obv3cMfKWdLWNV4VNExdOO217odvZXJQmIVxxF
         PBojYiB6GNhSJLCc6NVeTgf5w8+czxOvi2dPrbwhEtO38GTj6BpJWsLNvtk4IMfUTaJQ
         7R07tfbPS98z0o1Zm4Smv6RWAQ8ahoye2qGA/rnm7z8Zo1hAmlQHUDe6fBF9Lray+eZR
         LHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539584; x=1770144384;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8hELqlVqsPd53TkBvYAfiL9c8Iu/vvPZfjM7X/WNAc=;
        b=C3mIqtl1w79CoYro0lQjxY2W0BT641chuwabIwK9pzMCSbRgPT+7n0vtapfxAlBSAy
         BhDVYFvVEHHp9h+UQUiKSOvXU7GTLfQ6Shp3VIwFiFjq2XFW8QCtgx98JVCgyhItNxl0
         dgJmaXGmKpvvMAK8iyOKN9j317KQnt2q59cbKf3gAR18lnicRZ/qtrIf61zuEUme1XM2
         ytEXDf6G5DLMupar3Dt0IhFhQ9f2WRYOIk7vr8RChkDQO1f2dQbdkIZqhqovGdN6Kv7P
         HiJR9IOiI0ObGhpe1fv4go8JQdokqzIFXMQmp7bT7poPS2THBbsH3feXC1EQCfwW56L+
         HmFA==
X-Forwarded-Encrypted: i=1; AJvYcCVbm4VZoCNQQrh0od5ruKAQqdbPR25PdlbPHT2yGuNR2ZwEdgdEWhi0zpIMlbIP6mCfvnVlO24ZvUcui+UTyqiU@vger.kernel.org
X-Gm-Message-State: AOJu0YzdnmiwvvnNn4AUs5ohrmlxkAo9yGpHdV7qL76FW+ybto63V8eu
	yb9gjzMeZGKHL40bRxKtjTQODF480lfP/w7EexcOeziNKnmzkoysC45bwVQgKhwjGQBNzhhrVd6
	meYauUFFjUQ==
X-Received: from dlbtu19.prod.google.com ([2002:a05:7022:3c13:b0:123:2dd9:db4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6286:b0:11b:9386:a37d
 with SMTP id a92af1059eb24-124a00e8ae7mr1367052c88.44.1769539583947; Tue, 27
 Jan 2026 10:46:23 -0800 (PST)
Date: Tue, 27 Jan 2026 10:45:01 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-31-irogers@google.com>
Subject: [PATCH v11 30/35] perf jevents: Add C-State metrics from the PCU PMU
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
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
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

