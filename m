Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09BE363C64
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539544; cv=none; b=CobP8DH0pKQUTfTVMJVPUirb9xCSJpqDrQLECLMrPZcxYTI5V3ZB6KXBcRhyGJ5t7Wb6H0KNBe89vN+IQD0dw58ScnZnnggvXOa51w8AvTO+m65Q9gXEIeAbZq7Y/1aJVAhqb4whBYF+KCQJBL2nT4ctjKviNQKznp9AfiTvzS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539544; c=relaxed/simple;
	bh=wEwAu69dqy7FwpW88ji7Ds3Y/ObVL48wrOVgUzJIELw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uTwkdRsK+NBJlZjmHctOUeoGlPJQLpq3++PSdou7gHwtubKaTpws3/C+OqrFX6E3hmRv5+MJRkTkZPDKH2xhcE/TtK58wLuC2HS9LUvOjydbehldT1Q+FECiEWOuxyHuUrTB9YVWgztAUHOp2MxGSLrwHlrem6vuylM1LMbKm/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1sAItDkE; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1sAItDkE"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124627fc58dso10704267c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539542; x=1770144342; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+LtPwfdvum8VZ9vGv/kPmqTwGJ31j4ut7cChRLWG0yY=;
        b=1sAItDkEfzbYv71pDAd2l8TIk/YpRgbeL/qtgtO2s9ZyFdyo4xUWi6RGT6V+45wsbK
         AyJkH25COBHzIgPL5hLreJY6YKRcaWlBxm0yfKGM/ok6PkQl3kZWdQV/3Nny21LRvDor
         YB/rRmH4jnrVDP3MJ3Yr4TgVg+uP8ArJ200zJNbStTzligM8FPO7mGpztzsgwYdfot1I
         wtDgxIHkg6V5gxxVqNQaaNHWlZ7ve9FFP1ZAKE5pb6NJ6VxgTk+9ytEJlXIF468gBALt
         8mZROiH1foc4Aj+mh5e0okAvwNvxaBIVH6N4ItUj7NyPAL4Hf0La8YkwHomQriSS6FWQ
         kBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539542; x=1770144342;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LtPwfdvum8VZ9vGv/kPmqTwGJ31j4ut7cChRLWG0yY=;
        b=E/M7OFsZVBwFukmZle8X+4Xb7jhy3srOgOGkLuY+AgflbehOclWAMTSctPsM/uvoZE
         WneJAcBcFjT3kdZ+7srVLdpx5R+HHm8OuYfBBT4z/+lvjj8HRXJqiUm6kHkw6675Oh1b
         XyVYglHatOYzUF74ZIzYdbstHg75tUxO8QjeUUqvic/irwyjIACjWs+gMbKFvEQmiPX3
         MAYbjPXGLQ6B7W7OSHAVZF3HuMdUWz8/rF2ZI6tTZ5qaKNcNVQ1hDh9t4YF+NL9D64nT
         akMttoT9Uq57PE6iR4svDgApFYLiUxcqDZzokHghLuU4EUzXGs0d4k9ji1+V8oiw6fib
         qrrA==
X-Forwarded-Encrypted: i=1; AJvYcCUgLjJ1fQFRnWwgFEFAr6jLCSDtUZaRz5XfMmCWwIVp2Lk0KXQobivZpbMCWiCs3mGaOQe5ba0eTF5tLQV3gokh@vger.kernel.org
X-Gm-Message-State: AOJu0YxQcpD77E7Vwr1KEwHAe36Ty0qE2zIxgZIijOdiYKK8AqkJoXcd
	WVNR9j2kC3l57PAhWmFd7nrPJrpDMQQe6csG49EeuwXLnCsmw6jVSgDVHXtzN+6xoRN2KFT2rrR
	t7FLnXaSmBA==
X-Received: from dlbut9.prod.google.com ([2002:a05:7022:7e09:b0:124:a635:44d1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:306:b0:11b:9386:8271
 with SMTP id a92af1059eb24-124a00ddc17mr1936944c88.46.1769539541703; Tue, 27
 Jan 2026 10:45:41 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:39 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-9-irogers@google.com>
Subject: [PATCH v11 08/35] perf jevents: Add dtlb metric group for AMD
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

Add metrics that give an overview and details of the dtlb (zen1, zen2,
zen3).

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 111 +++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 8fb0b55074a2..a4ff88de08b5 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -122,6 +122,116 @@ def AmdBr():
                        description="breakdown of retired branch instructions")
 
 
+def AmdDtlb() -> Optional[MetricGroup]:
+    global _zen_model
+    if _zen_model >= 4:
+        return None
+
+    d_dat = Event("ls_dc_accesses") if _zen_model <= 3 else None
+    d_h4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit")
+    d_hcoal = Event(
+        "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit") if _zen_model >= 2 else 0
+    d_h2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit")
+    d_h1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit")
+
+    d_m4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss")
+    d_mcoal = Event(
+        "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss") if _zen_model >= 2 else 0
+    d_m2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss")
+    d_m1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss")
+
+    d_w0 = Event("ls_tablewalker.dc_type0") if _zen_model <= 3 else None
+    d_w1 = Event("ls_tablewalker.dc_type1") if _zen_model <= 3 else None
+    walks = d_w0 + d_w1
+    walks_r = d_ratio(walks, interval_sec)
+    ins_w = d_ratio(ins, walks)
+    l1 = d_dat
+    l1_r = d_ratio(l1, interval_sec)
+    l2_hits = d_h4k + d_hcoal + d_h2m + d_h1g
+    l2_miss = d_m4k + d_mcoal + d_m2m + d_m1g
+    l2_r = d_ratio(l2_hits + l2_miss, interval_sec)
+    l1_miss = l2_hits + l2_miss + walks
+    l1_hits = max(l1 - l1_miss, 0)
+    ins_l = d_ratio(ins, l1_miss)
+
+    return MetricGroup("lpm_dtlb", [
+        MetricGroup("lpm_dtlb_ov", [
+            Metric("lpm_dtlb_ov_insn_bt_l1_miss",
+                   "DTLB overview: instructions between l1 misses.", ins_l,
+                   "insns"),
+            Metric("lpm_dtlb_ov_insn_bt_walks",
+                   "DTLB overview: instructions between dtlb page table walks.",
+                   ins_w, "insns"),
+        ]),
+        MetricGroup("lpm_dtlb_l1", [
+            Metric("lpm_dtlb_l1_hits",
+                   "DTLB L1 hits as percentage of all DTLB L1 accesses.",
+                   d_ratio(l1_hits, l1), "100%"),
+            Metric("lpm_dtlb_l1_miss",
+                   "DTLB L1 misses as percentage of all DTLB L1 accesses.",
+                   d_ratio(l1_miss, l1), "100%"),
+            Metric("lpm_dtlb_l1_reqs", "DTLB L1 accesses per second.", l1_r,
+                   "insns/s"),
+        ]),
+        MetricGroup("lpm_dtlb_l2", [
+            Metric("lpm_dtlb_l2_hits",
+                   "DTLB L2 hits as percentage of all DTLB L2 accesses.",
+                   d_ratio(l2_hits, l2_hits + l2_miss), "100%"),
+            Metric("lpm_dtlb_l2_miss",
+                   "DTLB L2 misses as percentage of all DTLB L2 accesses.",
+                   d_ratio(l2_miss, l2_hits + l2_miss), "100%"),
+            Metric("lpm_dtlb_l2_reqs", "DTLB L2 accesses per second.", l2_r,
+                   "insns/s"),
+            MetricGroup("lpm_dtlb_l2_4kb", [
+                Metric(
+                    "lpm_dtlb_l2_4kb_hits",
+                    "DTLB L2 4kb page size hits as percentage of all DTLB L2 4kb "
+                    "accesses.", d_ratio(d_h4k, d_h4k + d_m4k), "100%"),
+                Metric(
+                    "lpm_dtlb_l2_4kb_miss",
+                    "DTLB L2 4kb page size misses as percentage of all DTLB L2 4kb"
+                    "accesses.", d_ratio(d_m4k, d_h4k + d_m4k), "100%")
+            ]),
+            MetricGroup("lpm_dtlb_l2_coalesced", [
+                Metric(
+                    "lpm_dtlb_l2_coal_hits",
+                    "DTLB L2 coalesced page (16kb) hits as percentage of all DTLB "
+                    "L2 coalesced accesses.", d_ratio(d_hcoal,
+                                                      d_hcoal + d_mcoal), "100%"),
+                Metric(
+                    "lpm_dtlb_l2_coal_miss",
+                    "DTLB L2 coalesced page (16kb) misses as percentage of all "
+                    "DTLB L2 coalesced accesses.",
+                    d_ratio(d_mcoal, d_hcoal + d_mcoal), "100%")
+            ]),
+            MetricGroup("lpm_dtlb_l2_2mb", [
+                Metric(
+                    "lpm_dtlb_l2_2mb_hits",
+                    "DTLB L2 2mb page size hits as percentage of all DTLB L2 2mb "
+                    "accesses.", d_ratio(d_h2m, d_h2m + d_m2m), "100%"),
+                Metric(
+                    "lpm_dtlb_l2_2mb_miss",
+                    "DTLB L2 2mb page size misses as percentage of all DTLB L2 "
+                    "accesses.", d_ratio(d_m2m, d_h2m + d_m2m), "100%")
+            ]),
+            MetricGroup("lpm_dtlb_l2_1g", [
+                Metric(
+                    "lpm_dtlb_l2_1g_hits",
+                    "DTLB L2 1gb page size hits as percentage of all DTLB L2 1gb "
+                    "accesses.", d_ratio(d_h1g, d_h1g + d_m1g), "100%"),
+                Metric(
+                    "lpm_dtlb_l2_1g_miss",
+                    "DTLB L2 1gb page size misses as percentage of all DTLB L2 "
+                    "1gb accesses.", d_ratio(d_m1g, d_h1g + d_m1g), "100%")
+            ]),
+        ]),
+        MetricGroup("lpm_dtlb_walks", [
+            Metric("lpm_dtlb_walks_reqs", "DTLB page table walks per second.",
+                   walks_r, "walks/s"),
+        ]),
+    ], description="Data TLB metrics")
+
+
 def AmdItlb():
     global _zen_model
     l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
@@ -236,6 +346,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdDtlb(),
         AmdItlb(),
         AmdUpc(),
         Idle(),
-- 
2.52.0.457.g6b5491de43-goog

