Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC873328B77
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899500; cv=none; b=pXl0O2EbYpziZnM1JsRNR9H9LFwB0/2riH60x7Zp1CVtHY+wxaBngYxzLuU1Y4IiyNmSZp7Klihp+W/dYyqbim+rRlNTLUkoC445yFWPbOnHEOJg0vPZAMFQvjf7xeq/rLtUmKb76D/KH9zB1CxkeVdYyTK5OTsV9Q/MNH671lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899500; c=relaxed/simple;
	bh=6ngkG0km3yB5xxyOrjatuk4rtbR7Z+mDw14r54hwsFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GYg8MNa/ABCns9/uO46fawzHnIZBzmeRDAf0o02oVHzm2np5OPH5CG+kec40zJ9QRPz70aA80yOBXqViWhKW2f0/FIfxSlPxy65z7QGk4qhxY5Vro96NQLKSaMEt6P8FdAP+8hYGztCk2KNE00vmk89/hqfizzkusaBP6eLxkcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w2kZzWpL; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w2kZzWpL"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ae32686ed0so268253eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899497; x=1768504297; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CoVpu9C7kwqCyjP7uTz46EcKVk9Lj7iUFKEqIBdIZM=;
        b=w2kZzWpL/4TEokXa5KxMfcZTdecYdTK6jCvqoEBPDHPGhYHtxpBwMRjxyCOBn+Acdw
         KpdaXM/qFcXobY0Z/pFGhDeJJ8eDUvKq0oRLPzjjE5FJJVdnauqplwEIrOvMnJlEh+4x
         JfVR7FtMG/vYTXvfVupkx6iXChBSNcpmMMEYSC5JIGYqtDfCd9aOIUd5C1IEFtLL2K8H
         sGk1WeKWg08z28xffg0tbYK6Gxob34SnR7dTqa87TVd4xMbVvG9iOQocOsknyE/sI1ts
         e0LrgkP/5pU/Ys8gH7Hf6rWgMgKg0IoUe4nl8XZUKkiQ5amDof+/tswnNTcH5DcZ1txY
         rTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899497; x=1768504297;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CoVpu9C7kwqCyjP7uTz46EcKVk9Lj7iUFKEqIBdIZM=;
        b=cCCnz2aCPiOybuP1/dWStuRiOgFQYBba1lLdW7B2zUV/G3+mnZAtzF/0dOz4GjeWHM
         uCX3MRdsxu6SdLolA3CvUUpNlbv0NQ5Uei/QTh5HlU2VIetsvmgi6etxPspLUEHktnkG
         rulsu1Cy8NmN8xR0cqq2kbYrDxMvEWrRJDOhDozeABHkAhmWQXhCX8oboHmLNVs4wIgQ
         JfRxtZwVk5JeciG96KFK5T92M2R+4QK2egB2eC9pZDtx7KrVVFZfJgFnV1yy3otfHZxE
         KLnD3wqI+bcs9/bu1gcqU9fovra7cCgxvRFuDt7CL+sCNOtNmjUGQVWncp+VSVl10ge3
         TsvA==
X-Forwarded-Encrypted: i=1; AJvYcCXUFMQrXUcLoQnyrtf2+FvmBniLA7GTyPmPBkMhc3Z1JrmqE0lj0Scw/1e4SgIYPY1dZu9FhX3ncCPae3tzFNZK@vger.kernel.org
X-Gm-Message-State: AOJu0YxkWdurA8URqjG3OGjTPsflhqulxKtoODhQQWF5MQEeqnoE0Xi0
	1CFXXmeGpAiq7v/kFk8ZH6lVSlGrjdTF4Ef/GqjpUApUuTbbp3Xp61jELunqcynP8yEJkBInV86
	4LovmT6mwTA==
X-Google-Smtp-Source: AGHT+IFmDL1/Jm7y3jYHlRr52x4gg+K4AT98rUY39BCT7nJZLphOsKZS1B0cPFaGHiw4JXVPve3oNUa7bDW+
X-Received: from dlbcm27.prod.google.com ([2002:a05:7022:689b:b0:122:8e:6ea4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:686:b0:11d:f440:b743
 with SMTP id a92af1059eb24-121f8ab9d25mr5769708c88.7.1767899497358; Thu, 08
 Jan 2026 11:11:37 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:36 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-7-irogers@google.com>
Subject: [PATCH v10 06/35] perf jevents: Add br metric group for branch
 statistics on AMD
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
events. The lack of conditional events on anything but zen2 means this
category is lacking on zen1, zen3 and zen4.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 105 +++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 42e46b33334d..38948f63cb52 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -18,6 +18,110 @@ cycles = Event("cycles")
 smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
 
 
+def AmdBr():
+    def Total() -> MetricGroup:
+        br = Event("ex_ret_brn")
+        br_m_all = Event("ex_ret_brn_misp")
+        br_clr = Event("ex_ret_brn_cond_misp",
+                       "ex_ret_msprd_brnch_instr_dir_msmtch",
+                       "ex_ret_brn_resync")
+
+        br_r = d_ratio(br, interval_sec)
+        ins_r = d_ratio(ins, br)
+        misp_r = d_ratio(br_m_all, br)
+        clr_r = d_ratio(br_clr, interval_sec)
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
+                   "The number of resync branches per second.", clr_r, "req/s")
+        ])
+
+    def Taken() -> MetricGroup:
+        br = Event("ex_ret_brn_tkn")
+        br_m_tk = Event("ex_ret_brn_tkn_misp")
+        br_r = d_ratio(br, interval_sec)
+        ins_r = d_ratio(ins, br)
+        misp_r = d_ratio(br_m_tk, br)
+        return MetricGroup("lpm_br_taken", [
+            Metric("lpm_br_taken_retired",
+                   "The number of taken branches that were retired per second.",
+                   br_r, "insn/s"),
+            Metric(
+                "lpm_br_taken_mispred",
+                "The number of retired taken branch instructions that were "
+                "mispredicted as a percentage of all taken branches.", misp_r,
+                "100%"),
+            Metric(
+                "lpm_br_taken_insn_between_branches",
+                "The number of instructions divided by the number of taken branches.",
+                ins_r, "insn"),
+        ])
+
+    def Conditional() -> Optional[MetricGroup]:
+        global _zen_model
+        br = Event("ex_ret_brn_cond", "ex_ret_cond")
+        br_r = d_ratio(br, interval_sec)
+        ins_r = d_ratio(ins, br)
+
+        metrics = [
+            Metric("lpm_br_cond_retired", "Retired conditional branch instructions.",
+                   br_r, "insn/s"),
+            Metric("lpm_br_cond_insn_between_branches",
+                   "The number of instructions divided by the number of conditional "
+                   "branches.", ins_r, "insn"),
+        ]
+        if _zen_model == 2:
+            br_m_cond = Event("ex_ret_cond_misp")
+            misp_r = d_ratio(br_m_cond, br)
+            metrics += [
+                Metric("lpm_br_cond_mispred",
+                       "Retired conditional branch instructions mispredicted as a "
+                       "percentage of all conditional branches.", misp_r, "100%"),
+            ]
+
+        return MetricGroup("lpm_br_cond", metrics)
+
+    def Fused() -> MetricGroup:
+        br = Event("ex_ret_fused_instr", "ex_ret_fus_brnch_inst")
+        br_r = d_ratio(br, interval_sec)
+        ins_r = d_ratio(ins, br)
+        return MetricGroup("lpm_br_cond", [
+            Metric("lpm_br_fused_retired",
+                   "Retired fused branch instructions per second.", br_r, "insn/s"),
+            Metric(
+                "lpm_br_fused_insn_between_branches",
+                "The number of instructions divided by the number of fused "
+                "branches.", ins_r, "insn"),
+        ])
+
+    def Far() -> MetricGroup:
+        br = Event("ex_ret_brn_far")
+        br_r = d_ratio(br, interval_sec)
+        ins_r = d_ratio(ins, br)
+        return MetricGroup("lpm_br_far", [
+            Metric("lpm_br_far_retired", "Retired far control transfers per second.",
+                   br_r, "insn/s"),
+            Metric(
+                "lpm_br_far_insn_between_branches",
+                "The number of instructions divided by the number of far branches.",
+                ins_r, "insn"),
+        ])
+
+    return MetricGroup("lpm_br", [Total(), Taken(), Conditional(), Fused(), Far()],
+                       description="breakdown of retired branch instructions")
+
+
 def AmdUpc() -> Metric:
     ops = Event("ex_ret_ops", "ex_ret_cops")
     upc = d_ratio(ops, smt_cycles)
@@ -83,6 +187,7 @@ def main() -> None:
     _zen_model = int(_args.model[6:])
 
     all_metrics = MetricGroup("", [
+        AmdBr(),
         AmdUpc(),
         Idle(),
         Rapl(),
-- 
2.52.0.457.g6b5491de43-goog

