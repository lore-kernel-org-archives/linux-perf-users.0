Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226C92DE707
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698023; cv=none; b=YPYpomAgwWmvqrxGSsvC5VJ/Hk0IAIa5bweH3VtJwNa/NwOpFSferStAGq+PUAhYugnZgVKFc5a/NtQP5tMf4ermrvcT7EOnI4P8IKsfDTZI/Ig2qg3PK3njBnfW0BbCS25R2j4myhbAc7vDGCpF/tCj0dC9J7RWZiUDml9wUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698023; c=relaxed/simple;
	bh=cnrn7ebfjvFiAKJasfouyQP3U+pd/rAe6Cjcx0pS1NM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ns3Kgi2QtNKTx2DrmziRskLqE6fju91wBqvhIECmmgD0uj9vWEzLYpOexS0RuF/TpW2MQEUNPf97/g5JMI1Z7/mF4hHm+9ncPLdH3C0aOQBW75LtVINluL0Y+4N47OLnen3QUx634DURCsDMkuG5Hi2EX7p81j9KLrzcI8apHH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+4CQwzx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+4CQwzx"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b895b520a2so5226458b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698021; x=1765302821; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7H/fiSBZbcH4CZp2bWGmcEpNcwTRUbcYlOhUmrRII8=;
        b=H+4CQwzxmVeJwVq/TYsBk0Q4R1ssOpbBMG5HFrz2XDl555tjKBrb+YHH+EQRum2FP2
         ewpUXUb3QUec4MlGIM6PxLJYN2hAECiozBrYu5J25fKVg38nhc7keDUvCZMu2K6k4WYF
         RHW8PnbYH3V8VJv7/m3Dg+XAgmRIlwe2ruqf7W6jNIlY22cMkNiPLuDLleZvu1B/+eXb
         8lDlsZCyoaomyzxqXW43AQQgxiVcJGPf1rHAyXZuwzpG5HtMwNmsc+vybx+TUEFqsKxk
         bt6HoJ55IrZTvxJR5AmqH42ZvGdpmNXlJvww+qWlHut8lrVcvX5x6RRTCX0Re2BE16CQ
         /bVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698021; x=1765302821;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7H/fiSBZbcH4CZp2bWGmcEpNcwTRUbcYlOhUmrRII8=;
        b=VrAlhaW9DAIw7y6J7HkecC+p8c3tZeMrAGJ5VL00Hba/kuCRbGFioCNdfE++OGFKTH
         yROaPGY9dChUUcEw+OHrhD/wK9uElsMxkZeoAAsSqNtldk7EDo1XyVQmCQwGahMtJh0l
         iZkeNdrVoj/6z0Q3e9ajeHLFXhn1fHp2vHjkcchsCpU6IbfOYi8lJu+bvwZR0bNDNbrq
         4sQuvADaYpQTNYnUQxx/QsRNpAGVEIBM7bAuk2GnELAHc3IeelSN9jVl1CX97Y8xItjS
         UNJOJy+cYzumhSwdGtHheN5Wace5ucSf3nhVNTHsU+aDJs8BRC28fTu26pbrXYWwCDwl
         jYaw==
X-Forwarded-Encrypted: i=1; AJvYcCVc0CNGf5zlcqTHQZfGO4aRGYdU7t04CMFIqL1/sfgSYnv7koAFumZiF4WWUstnFauHUo62ij2/d/4muiCK3qJV@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKpTN+KQDcdaQWsD8ClpUBqU+02vXKlmm2Rjly1PBgDa2Q5nb
	n7diLnb7bKxOeef84+3yzAuQMuwhqwqn36hFGbN/gFcSSr1UDR9gxh4XG8TvAbkaTVSlPH5hho3
	zPcX3QkQNRg==
X-Google-Smtp-Source: AGHT+IG9lm22mi8fuekKs8VooDbr1yV2Hrw+KvlrXOR7DExXJGCsd39iQjnlI2CKxSwkYQh4V5eOnfOrWHgs
X-Received: from pfblg22.prod.google.com ([2002:a05:6a00:7096:b0:7dd:8bba:63a0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a91:b0:7b9:ef46:ec61
 with SMTP id d2e1a72fcca58-7ca89a6a2b9mr29142803b3a.26.1764698021378; Tue, 02
 Dec 2025 09:53:41 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:25 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-31-irogers@google.com>
Subject: [PATCH v9 30/48] perf jevents: Add br metric group for branch
 statistics on Intel
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

The br metric group for branches itself comprises metric groups for
total, taken, conditional, fused and far metric groups using json
events. Conditional taken and not taken metrics are specific to
Icelake and later generations, so the presence of the event is used to
determine whether the metric should exist.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/intel_metrics.py | 138 +++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 05f3d94ec5d5..e1944d821248 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -124,6 +124,143 @@ def Tsx() -> Optional[MetricGroup]:
     ], description="Breakdown of transactional memory statistics")
 
 
+def IntelBr():
+    ins = Event("instructions")
+
+    def Total() -> MetricGroup:
+        br_all = Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+        br_m_all = Event("BR_MISP_RETIRED.ALL_BRANCHES",
+                         "BR_INST_RETIRED.MISPRED",
+                         "BR_MISP_EXEC.ANY")
+        br_clr = None
+        try:
+            br_clr = Event("BACLEARS.ANY", "BACLEARS.ALL")
+        except:
+            pass
+
+        br_r = d_ratio(br_all, interval_sec)
+        ins_r = d_ratio(ins, br_all)
+        misp_r = d_ratio(br_m_all, br_all)
+        clr_r = d_ratio(br_clr, interval_sec) if br_clr else None
+
+        return MetricGroup("lpm_br_total", [
+            Metric("lpm_br_total_retired",
+                   "The number of branch instructions retired per second.", br_r,
+                   "insn/s"),
+            Metric(
+                "lpm_br_total_mispred",
+                "The number of branch instructions retired, of any type, that were "
+                "not correctly predicted as a percentage of all branch instrucions.",
+                misp_r, "100%"),
+            Metric("lpm_br_total_insn_between_branches",
+                   "The number of instructions divided by the number of branches.",
+                   ins_r, "insn"),
+            Metric("lpm_br_total_insn_fe_resteers",
+                   "The number of resync branches per second.", clr_r, "req/s"
+                   ) if clr_r else None
+        ])
+
+    def Taken() -> MetricGroup:
+        br_all = Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+        br_m_tk = None
+        try:
+            br_m_tk = Event("BR_MISP_RETIRED.NEAR_TAKEN",
+                            "BR_MISP_RETIRED.TAKEN_JCC",
+                            "BR_INST_RETIRED.MISPRED_TAKEN")
+        except:
+            pass
+        br_r = d_ratio(br_all, interval_sec)
+        ins_r = d_ratio(ins, br_all)
+        misp_r = d_ratio(br_m_tk, br_all) if br_m_tk else None
+        return MetricGroup("lpm_br_taken", [
+            Metric("lpm_br_taken_retired",
+                   "The number of taken branches that were retired per second.",
+                   br_r, "insn/s"),
+            Metric(
+                "lpm_br_taken_mispred",
+                "The number of retired taken branch instructions that were "
+                "mispredicted as a percentage of all taken branches.", misp_r,
+                "100%") if misp_r else None,
+            Metric(
+                "lpm_br_taken_insn_between_branches",
+                "The number of instructions divided by the number of taken branches.",
+                ins_r, "insn"),
+        ])
+
+    def Conditional() -> Optional[MetricGroup]:
+        try:
+            br_cond = Event("BR_INST_RETIRED.COND",
+                            "BR_INST_RETIRED.CONDITIONAL",
+                            "BR_INST_RETIRED.TAKEN_JCC")
+            br_m_cond = Event("BR_MISP_RETIRED.COND",
+                              "BR_MISP_RETIRED.CONDITIONAL",
+                              "BR_MISP_RETIRED.TAKEN_JCC")
+        except:
+            return None
+
+        br_cond_nt = None
+        br_m_cond_nt = None
+        try:
+            br_cond_nt = Event("BR_INST_RETIRED.COND_NTAKEN")
+            br_m_cond_nt = Event("BR_MISP_RETIRED.COND_NTAKEN")
+        except:
+            pass
+        br_r = d_ratio(br_cond, interval_sec)
+        ins_r = d_ratio(ins, br_cond)
+        misp_r = d_ratio(br_m_cond, br_cond)
+        taken_metrics = [
+            Metric("lpm_br_cond_retired", "Retired conditional branch instructions.",
+                   br_r, "insn/s"),
+            Metric("lpm_br_cond_insn_between_branches",
+                   "The number of instructions divided by the number of conditional "
+                   "branches.", ins_r, "insn"),
+            Metric("lpm_br_cond_mispred",
+                   "Retired conditional branch instructions mispredicted as a "
+                   "percentage of all conditional branches.", misp_r, "100%"),
+        ]
+        if not br_m_cond_nt:
+            return MetricGroup("lpm_br_cond", taken_metrics)
+
+        br_r = d_ratio(br_cond_nt, interval_sec)
+        ins_r = d_ratio(ins, br_cond_nt)
+        misp_r = d_ratio(br_m_cond_nt, br_cond_nt)
+
+        not_taken_metrics = [
+            Metric("lpm_br_cond_retired", "Retired conditional not taken branch instructions.",
+                   br_r, "insn/s"),
+            Metric("lpm_br_cond_insn_between_branches",
+                   "The number of instructions divided by the number of not taken conditional "
+                   "branches.", ins_r, "insn"),
+            Metric("lpm_br_cond_mispred",
+                   "Retired not taken conditional branch instructions mispredicted as a "
+                   "percentage of all not taken conditional branches.", misp_r, "100%"),
+        ]
+        return MetricGroup("lpm_br_cond", [
+            MetricGroup("lpm_br_cond_nt", not_taken_metrics),
+            MetricGroup("lpm_br_cond_tkn", taken_metrics),
+        ])
+
+    def Far() -> Optional[MetricGroup]:
+        try:
+            br_far = Event("BR_INST_RETIRED.FAR_BRANCH")
+        except:
+            return None
+
+        br_r = d_ratio(br_far, interval_sec)
+        ins_r = d_ratio(ins, br_far)
+        return MetricGroup("lpm_br_far", [
+            Metric("lpm_br_far_retired", "Retired far control transfers per second.",
+                   br_r, "insn/s"),
+            Metric(
+                "lpm_br_far_insn_between_branches",
+                "The number of instructions divided by the number of far branches.",
+                ins_r, "insn"),
+        ])
+
+    return MetricGroup("lpm_br", [Total(), Taken(), Conditional(), Far()],
+                       description="breakdown of retired branch instructions")
+
+
 def main() -> None:
     global _args
 
@@ -153,6 +290,7 @@ def main() -> None:
         Rapl(),
         Smi(),
         Tsx(),
+        IntelBr(),
     ])
 
     if _args.metricgroups:
-- 
2.52.0.158.g65b55ccf14-goog

