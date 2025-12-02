Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2132D877B
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697954; cv=none; b=FZIvx73eCEndFQnE1x0TCBAB6A3peHS/uhgVjJ/amI2bnPoozs3uiDjDWAn2QfS4hJVc2TdCmtu6mRjwnCtdW7hNP+kCuZA1YbaFaBsQ369P7mvQk7KRyHr99KATwQOTpA4Fkih9kpsIivmxfh9GfVbcBv2tEFvzlGGT/vxrIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697954; c=relaxed/simple;
	bh=7RnGkPZOpGKGatjj+MFrqJQE14RNbTv5rkqCzRl2MH0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UcMVZcCb5l4uO9TI+r11I7n+ZbdXrIfkl3nSYg8PJaYbgcSOT1QhtGOo79c3sdOUE+RO+1NRkqjXd3ZX7cu3VvpkgamHuaUQivPec3IDpjpq7WWOxll/KmzCTU/5DjdBUxAAqNTPltbOjH4HJtf+yclAnLUZLf2Xs9RAv3ve1A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wsgK+mru; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wsgK+mru"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bde2e654286so4563654a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697952; x=1765302752; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKDA0IrKz790dnyekDQWaFWB3MnJqfzTphK128DE4rY=;
        b=wsgK+mru92dCpHxwE5g9zGy31nZdqWeFGGyVG68DgesGeMfaxktMe0sgWm4aaW2fep
         NFAyoGArqU+s/YRl/yEs2d1TtdalAy+SBxbHUwJtbccojlBCKzMmEXzYF4/sESUi5qoM
         geQL5SPktU+aagi/mdgfoz1RGLzokyoaMX9/Pcs4cHvRsuJNDo7TP///FUuIE/SrFU9f
         Pt8wuJw1HWh+piMh4Rh7Crwz4jsz7oNeF7mBgQ12TMePJW7xCIgPI73Ksm958gxTHOMA
         gncLvEhNM1jTRB9prfv+2KTCFI2zss2hG2YxaosL0LNdNsq92aznFCbtNQIe9nJww6PO
         uRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697952; x=1765302752;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKDA0IrKz790dnyekDQWaFWB3MnJqfzTphK128DE4rY=;
        b=bSD27Dk2tFija15+3D5PuvcPHIkT8uP/Yr2XydHPEYVJLiWnAfwcMTtZ+M48LlYudK
         Yu6ofKceHEtgcjjZdN8CKlX7DvxrRedNGancPCpR5vyWaCIjcC4e63sWhlcrh+LpiGKm
         7lpYfref4cDw+k51ZVJGQbNaWGS2QplmC1/L5HWltVsPr1x+PPqkdONKR0ojHUp+k1dz
         hMxdKLOzdOpKCVNIQ+FnqCQTsUKSqwu98zp3jfxotortzvSxy+ie6I85U/Z0RolmkX0Q
         uJ5/HcKgb07eOuU8FEKbvKSLnUa0kW9W4gYwCnuJf8xwRoDhrTfB9P1vmbmDrrcWWELG
         MHaA==
X-Forwarded-Encrypted: i=1; AJvYcCWWL6Mb+H1npnjaOKxJVfMlHWkx5PHNvxYVSdfUAYIo5F+cgM3Odq3Ke8hdaMXsBpdnZSiHX3kmdfLgMTZc16BE@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4nKlY8mbHR/yVnQ5lDSFdjGTCDPOwcVc8Bi3ceOThFchC/0/
	PRq57P6fFURoab3PHIDikMGy3og2KYEdbOYj4aLCmpjDnm4EmWxospKvELlUy64MigI+zjq9slB
	LwEohgj0EnQ==
X-Google-Smtp-Source: AGHT+IFWM63cnWnkLe7ok63yjTdk6eHNw0ET7DDAEa0omGoKQKoWY4gPGg8hY8IO9Zc5sulUb+hNnVzRfsqe
X-Received: from dycou23.prod.google.com ([2002:a05:7300:dc97:b0:2a4:6577:68f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:9c91:b0:2a4:4f86:822a
 with SMTP id 5a478bee46e88-2a941887a80mr12900570eec.33.1764697951923; Tue, 02
 Dec 2025 09:52:31 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:13 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-19-irogers@google.com>
Subject: [PATCH v9 18/48] perf jevents: Add br metric group for branch
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

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/amd_metrics.py | 104 +++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 42e46b33334d..1880ccf9c6fc 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -18,6 +18,109 @@ cycles = Event("cycles")
 smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
 
 
+def AmdBr():
+    def Total() -> MetricGroup:
+        br = Event("ex_ret_brn")
+        br_m_all = Event("ex_ret_brn_misp")
+        br_clr = Event("ex_ret_msprd_brnch_instr_dir_msmtch",
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
+        br = Event("ex_ret_cond")
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
@@ -83,6 +186,7 @@ def main() -> None:
     _zen_model = int(_args.model[6:])
 
     all_metrics = MetricGroup("", [
+        AmdBr(),
         AmdUpc(),
         Idle(),
         Rapl(),
-- 
2.52.0.158.g65b55ccf14-goog

