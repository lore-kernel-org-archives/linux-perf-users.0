Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16AC35F8BA
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539540; cv=none; b=Zq1nyHiVttwhxg35dFMav7/xduVwsjxi/3W9tQIjtMgY92+yuHm6sgoWK3abi8QwOe8RpXcPQGoxg+rq0J6IhJ7nUNqLlg6g1h6ni3dHEBooe+MlXJi4O1I7ftA5hZj8MgFJlclD83IBXxYMprvWj+xsgWZj/MzeZpOlQhKYwL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539540; c=relaxed/simple;
	bh=6ngkG0km3yB5xxyOrjatuk4rtbR7Z+mDw14r54hwsFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=u77n3muQ6F4XK05/LeMPD9SEDO8HI7gL+YLZhHhpQ4wd7GB8+FqGLnC1AuZEWZE47/maQ3Kh7aTuMzOHKJoW4XHf+Gy0isUCb7/6hCicsj3tUrynQsdW6lFUePkR0aJ9jKKZScfbewIWlbt0Npwye0bNQyFoIgoaD22IOfZoQyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ignUx1/z; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ignUx1/z"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b74aff34efso4921702eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539538; x=1770144338; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CoVpu9C7kwqCyjP7uTz46EcKVk9Lj7iUFKEqIBdIZM=;
        b=ignUx1/zsO9C19k9Pd/ywY9PKaqtYeKxvn0TNGsjfZRQHpqAsOIHz1lfjwxfHMIggi
         o9EIJWUybBAJpYFUWslOWDoBOfbL6ftxgsGtSFcUJ8RdcDmyeVi3z5GEqKfg6ugohxtF
         SlZUPuzItNUqLx79Rl+o2Rfc3yV54Go8qovdV2XqS+K1hh3nrA1udMTFEJoklSEGwnHq
         C/kzsNUHhimsDcFrLPcxhV/5EHZD2k0m03qYNI8milY2R6HQAPJlVydbEmnzlZw+fSZR
         MApaMm5miSrCNulHTjLqmaJYnHpfVm6vlDf2HuH12EyK2wGqMXArCOd/FwaUPmkX6Jut
         7IaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539538; x=1770144338;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CoVpu9C7kwqCyjP7uTz46EcKVk9Lj7iUFKEqIBdIZM=;
        b=ApySLZ7h9MZHc14Pc0sfwoC+G3L9f226S5Px+dmTrsTBGJvc26q4wwwSnQJF6GxMbX
         pJ0ZI30m8qB4CsTdm/+oEqqwIkGCdS+NY1PRiJICMuOmGLicy9zHJGgPNhPCyY/ZvJXb
         56mdcn2FhfxuoKITXugTvJZDkXuyadEE3B7N3SXwsuAlraZtAcmihVk6IXbnpvOOtEvn
         5cXv4tFl1Eg0JdujpJxq6SBJO3garO8JEPrse9s7jHdfmdQ/gUgmLnjtjfCNZKlMGMZj
         g+vi8sz89pwGEFeF27nV7jfG4ChUeereglzz02R6fwXlpc/JoUHz3WaHcIbLivU81svV
         yj/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaBylTxjH9Qh3qIVXuyrEm+Y/SDtXVW6N7LCgXTF/6pp7NvOf3ZtAIxnGGQ/ub+3WF5R1SkP+TgTurYzyKDJ1h@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOHRMU0RP5Z9wS9LG1JkGGH0wsxnEFajul7Wd6ne52P6xEldA
	/R52tYX+9TBywHTr9umAX+I/bpH/l0bXLkYTESQ1aW0c39sWTxol2IrR0a5nU0tWxzHi4n4aFXe
	U6c3QBgphQg==
X-Received: from dybdr31.prod.google.com ([2002:a05:7300:b29f:b0:2b6:bdce:fb0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:72c5:b0:2b0:51a7:509a
 with SMTP id 5a478bee46e88-2b78da12271mr1505624eec.33.1769539537837; Tue, 27
 Jan 2026 10:45:37 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:37 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-7-irogers@google.com>
Subject: [PATCH v11 06/35] perf jevents: Add br metric group for branch
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
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
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

