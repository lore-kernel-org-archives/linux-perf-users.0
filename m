Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2AA329360
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539547; cv=none; b=sbG/jrIeIdPN2p8TYBzsgoPOqNk1xn4OxpafkgjKc9ZxxhB5ae4/AW283QKlJovfffNBtgvFrG20LVsz+Xtm8tdZR/erLrzjBXMSQdLZ4GE/W67b5qc/bEoA8+fCo/I1O4ed3JUZ2lJ/YS3fqOUps3BiS8jRSNxSFEG9pfra9Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539547; c=relaxed/simple;
	bh=cIu6eR1sR5Z5vTDJWp5UW5V0wvKX6WEDplqiXQUSFGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fcYqcBwxji0c19Qe6FlXDpY+XACBl+wQcnHbR3dqqXLPjjCRg2dLyhVWtSh3uDHGkp1YQHM9k0qe8uPeSU/2KF+DcyJhojozgfFKgXp61yqPdDrYvGc7/6/Qem9dGOJJjYC+gG7yK+FS8Wbp/toW6ysllAjcTqS4V0Yyv5T1JeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4Yh2tFw; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4Yh2tFw"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124627fc58dso10704552c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539546; x=1770144346; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79FcYdK/0zuRLjptxWds6JuhoHGCloD1d2+DIKaDNX0=;
        b=t4Yh2tFwL0D8IMN78XHMfmXSvzMN8r14YeEcFYyuBY56XQleyoYEobqrHVt/ClZMFM
         huEnTTjruCyVVuEOr4Rrd6FuZwxNvDyyhKFBM9WN0ruBfdR+IjMyHULZf6miyJum8Q++
         2ZDjIQsGURGG1GR34W1xAzXcwmNMw4gyZ/q4N+TxCLsna0qMOhP58+xoMW8cWrdo6ZWw
         kL76VCrKdhb4UiA4iTCNzxQ9nY0hFuUX3MCa8RxY1THAWpDoK3Os2XvMgDymuPIfXRHb
         PpLuwHFU4qjlLJxKUo8k0dJoYrn8nqJEcqPGolLd0BEgtF47b18vizzJ3G2wYdcb7+TO
         YJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539546; x=1770144346;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79FcYdK/0zuRLjptxWds6JuhoHGCloD1d2+DIKaDNX0=;
        b=uoe/QSv5tItO2Qpt1XXMrlhayXf6RAEzPh4Qp7HvjeFojUvBs1i5g8NjrX0lWT4MlF
         2i3cdpuUF5miRp41xBSt3jwtT5NPiDqBbQ+5sShpQdZgs48dfMQZ0jWzhCQJdEZ9jDoS
         YR9maHSR2DKjmcLAph2PirJijLX3rceGZxC5A0VFJ2+kis1BCx7h50Ux3EZ8AfjGoTh4
         FVgq6W4aKJRB2BUdSed6zypRAE216/P38xwoGec9unahcrvpkzlyqGU7G3g4nB6S/GDa
         2Wh+8oicP3XdclSFDWeNmBmhYNmHPHhTTZZaZtkEdkmvyBH0aq6Bb3UY2iFfJV6L0POM
         w2Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXvG9aslyAoLXX1bjXoY5fV7hRrRiMpw3JyHrcRT6RgJQ6tNJX8Ljn41JWfyTIUMPO3mjstcXX1JmVUMbYvTROe@vger.kernel.org
X-Gm-Message-State: AOJu0YwxETGax9OfZXiPX+SnK6CyAvOAqt8vvHSV3o9+W+ZuY9GaNmh+
	8EaOvtlMqcyqzU5/p1/2W3T96ZhXebjAZoc1t2LoBvtSIA/LDeUir04WgvWI0S7fOPv4vxEbaLu
	eRIuWOEyEig==
X-Received: from dlbpy18.prod.google.com ([2002:a05:7022:e992:b0:11f:42e8:ad40])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6a0:b0:11b:9386:826c
 with SMTP id a92af1059eb24-124a00d64dbmr1945062c88.41.1769539545636; Tue, 27
 Jan 2026 10:45:45 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:41 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-11-irogers@google.com>
Subject: [PATCH v11 10/35] perf jevents: Add load store breakdown metrics ldst
 for AMD
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

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index d71997177239..b3de74babe40 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -280,6 +280,80 @@ def AmdItlb():
     ], description="Instruction TLB breakdown")
 
 
+def AmdLdSt() -> MetricGroup:
+    ldst_ld = Event("ls_dispatch.pure_ld", "ls_dispatch.ld_dispatch")
+    ldst_st = Event("ls_dispatch.pure_st", "ls_dispatch.store_dispatch")
+    ldst_ldc1 = Event(f"{ldst_ld}/cmask=1/")
+    ldst_stc1 = Event(f"{ldst_st}/cmask=1/")
+    ldst_ldc2 = Event(f"{ldst_ld}/cmask=2/")
+    ldst_stc2 = Event(f"{ldst_st}/cmask=2/")
+    ldst_ldc3 = Event(f"{ldst_ld}/cmask=3/")
+    ldst_stc3 = Event(f"{ldst_st}/cmask=3/")
+    ldst_cyc = Event("ls_not_halted_cyc")
+
+    ld_rate = d_ratio(ldst_ld, interval_sec)
+    st_rate = d_ratio(ldst_st, interval_sec)
+
+    ld_v1 = max(ldst_ldc1 - ldst_ldc2, 0)
+    ld_v2 = max(ldst_ldc2 - ldst_ldc3, 0)
+    ld_v3 = ldst_ldc3
+
+    st_v1 = max(ldst_stc1 - ldst_stc2, 0)
+    st_v2 = max(ldst_stc2 - ldst_stc3, 0)
+    st_v3 = ldst_stc3
+
+    return MetricGroup("lpm_ldst", [
+        MetricGroup("lpm_ldst_total", [
+            Metric("lpm_ldst_total_ld", "Number of loads dispatched per second.",
+                   ld_rate, "insns/sec"),
+            Metric("lpm_ldst_total_st", "Number of stores dispatched per second.",
+                   st_rate, "insns/sec"),
+        ]),
+        MetricGroup("lpm_ldst_percent_insn", [
+            Metric("lpm_ldst_percent_insn_ld",
+                   "Load instructions as a percentage of all instructions.",
+                   d_ratio(ldst_ld, ins), "100%"),
+            Metric("lpm_ldst_percent_insn_st",
+                   "Store instructions as a percentage of all instructions.",
+                   d_ratio(ldst_st, ins), "100%"),
+        ]),
+        MetricGroup("lpm_ldst_ret_loads_per_cycle", [
+            Metric(
+                "lpm_ldst_ret_loads_per_cycle_1",
+                "Load instructions retiring in 1 cycle as a percentage of all "
+                "unhalted cycles.", d_ratio(ld_v1, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_loads_per_cycle_2",
+                "Load instructions retiring in 2 cycles as a percentage of all "
+                "unhalted cycles.", d_ratio(ld_v2, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_loads_per_cycle_3",
+                "Load instructions retiring in 3 or more cycles as a percentage"
+                "of all unhalted cycles.", d_ratio(ld_v3, ldst_cyc), "100%"),
+        ]),
+        MetricGroup("lpm_ldst_ret_stores_per_cycle", [
+            Metric(
+                "lpm_ldst_ret_stores_per_cycle_1",
+                "Store instructions retiring in 1 cycle as a percentage of all "
+                "unhalted cycles.", d_ratio(st_v1, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_stores_per_cycle_2",
+                "Store instructions retiring in 2 cycles as a percentage of all "
+                "unhalted cycles.", d_ratio(st_v2, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_stores_per_cycle_3",
+                "Store instructions retiring in 3 or more cycles as a percentage"
+                "of all unhalted cycles.", d_ratio(st_v3, ldst_cyc), "100%"),
+        ]),
+        MetricGroup("lpm_ldst_insn_bt", [
+            Metric("lpm_ldst_insn_bt_ld", "Number of instructions between loads.",
+                   d_ratio(ins, ldst_ld), "insns"),
+            Metric("lpm_ldst_insn_bt_st", "Number of instructions between stores.",
+                   d_ratio(ins, ldst_st), "insns"),
+        ])
+    ], description="Breakdown of load/store instructions")
+
+
 def AmdUpc() -> Metric:
     ops = Event("ex_ret_ops", "ex_ret_cops")
     upc = d_ratio(ops, smt_cycles)
@@ -366,6 +440,7 @@ def main() -> None:
         AmdBr(),
         AmdDtlb(),
         AmdItlb(),
+        AmdLdSt(),
         AmdUpc(),
         Idle(),
         Rapl(),
-- 
2.52.0.457.g6b5491de43-goog

