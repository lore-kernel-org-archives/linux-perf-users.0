Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133A53B297
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395994; cv=none; b=gMMKWMlu+zAqMeMBiRbENjv6XTIS3asInToUtcpTurFDemu+CkcwAzYFiSNxRDmVCI+b6fFqI18zDBZrpxXKj404Tb+q+VCb+luZWJUgr+c+RT2n98GFqY25VQv6EXGX73YHCrtQjw5s6d5VQlHc1W5QvKYwhgbqK+YbRTHo4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395994; c=relaxed/simple;
	bh=nJWLpagX3fnUwoQICD5hV02eLFbaofPniJ75oRrnaLI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fYKoOeI8wdzHdK/AA2Ttq9gdRG/a8ytyEnanxEKlB+PGYMqpPpa3gYh1GxGTFFgMrySzm+f9VQqtwcuZWmxOExDSrHjTKIpfEV07n8zAbKutGvpMSxbOt1Vg0me/NGGnvBJpS7E7S9v66SZiMuUI8APzJQ+JjSyRimPMDchjos0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B97USwWV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B97USwWV"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so744465276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395992; x=1711000792; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5XPP3oK+Thn/1zVInzu5FDzzEZZaV5BcTwipAM2LAc=;
        b=B97USwWVUKN+k84mKYQlKEOwh4jVIQCLYh1MwvkDI04ynl7ldGEyRzK7XRDzFk6+P1
         8SRLjmvhS38bjSUCD6FCa2XH7NCiuM1Z7GBvzw26WzIwPcPbKYieHC+5x2Y6cpTR2P2T
         cx+QK6fK1UbBwprzDZ+oxImstTMCDPDKSrkDEI6DbrOeqYqVGYWhvxvNULWr5sJW+MGX
         hTOHRW695xoea2s4x+XRBSMVJsDs7suSIbg4krITON1ax8o8g/AkcSmUeXYmBvjjpovk
         KcB4bMrxjaUCKkPibKe0KIpj4+5ESzaYEM0RGQDpO+r9YSo/wZkJUwUFdMh9I8vLCLF2
         3T6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395992; x=1711000792;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5XPP3oK+Thn/1zVInzu5FDzzEZZaV5BcTwipAM2LAc=;
        b=TjehFVCpY8q3ZDyjJSkNVuW/7p1BLKz7NvlCg8cJdFmc2q2ZYUDc7yEEL8T4Bvp/9S
         OV52FmtUEBsTbLn0+KLcDsjxZgXdBNPOXI7rOjrcPAi74O4nEIuPHr7qulswd/LryHHc
         OiQ+bKOrqjt0LKW2XDX2+n5f7sKYoBSU69mKAk2p5duhMVcJ8Qr37UPDpQ7ucB+pRb8u
         Ki0AmKj9ZAJb6rE+VOFm3vuVpJn3cBVAGmwfxTwSSv/jQtzV/dZ4ZRCp/N6MmR8RuG+h
         qYmnvg5ZRo8WNAo3z40ZgWOD401kV+gCJWeZvg/wQ2IXT+5r0mAApEl0M0ymBekGFHX1
         zv2A==
X-Forwarded-Encrypted: i=1; AJvYcCVj6bPSTNzireQywwpEC9EjJVrJhPOu2WOgJa4S49g/mudjjtL2uQPgzCGLNda8fxqxQgHlveOwjK5F+3BiouobKh2ucphWDtHxD9K5M3jPyw==
X-Gm-Message-State: AOJu0Yyg0Rr23labJzFdZBoyjtcUx73w/qzeYRaYlDDXh/UiotkWzwd6
	L5oupMKIrdLmjmmlE2z7eAXwXbtTcnazLMAo9GTjgWG2K8TI6hD5hwjBNob953u/f7guqX1TmPj
	bZRFPgg==
X-Google-Smtp-Source: AGHT+IH5I8Fe3CBTlfB/EPtyqAz2vDrc+lU9Zc5GRy3nAjmfR9sDsnN7X2mAQs+C8FR01oh4LdpOBQfYymAI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2503:b0:dcb:fb69:eadc with SMTP
 id dt3-20020a056902250300b00dcbfb69eadcmr20434ybb.6.1710395992101; Wed, 13
 Mar 2024 22:59:52 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:06 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 07/20] perf jevents: Add software prefetch (swpf) metric
 group for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Add metrics that breakdown software prefetch instruction use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 65 ++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 09f7b7159e7c..b02d0c0c3793 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -260,6 +260,70 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelSwpf() -> Optional[MetricGroup]:
+  ins = Event("instructions")
+  try:
+    s_ld = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+    s_nta = Event("SW_PREFETCH_ACCESS.NTA")
+    s_t0 = Event("SW_PREFETCH_ACCESS.T0")
+    s_t1 = Event("SW_PREFETCH_ACCESS.T1_T2")
+    s_w = Event("SW_PREFETCH_ACCESS.PREFETCHW")
+  except:
+    return None
+
+  all_sw = s_nta + s_t0 + s_t1 + s_w
+  swp_r = d_ratio(all_sw, interval_sec)
+  ins_r = d_ratio(ins, all_sw)
+  ld_r = d_ratio(s_ld, all_sw)
+
+  return MetricGroup("swpf", [
+      MetricGroup("swpf_totals", [
+          Metric("swpf_totals_exec", "Software prefetch instructions per second",
+                swp_r, "swpf/s"),
+          Metric("swpf_totals_insn_per_pf",
+                 "Average number of instructions between software prefetches",
+                 ins_r, "insn/swpf"),
+          Metric("swpf_totals_loads_per_pf",
+                 "Average number of loads between software prefetches",
+                 ld_r, "loads/swpf"),
+      ]),
+      MetricGroup("swpf_bkdwn", [
+          MetricGroup("swpf_bkdwn_nta", [
+              Metric("swpf_bkdwn_nta_per_swpf",
+                     "Software prefetch NTA instructions as a percent of all prefetch instructions",
+                     d_ratio(s_nta, all_sw), "100%"),
+              Metric("swpf_bkdwn_nta_rate",
+                     "Software prefetch NTA instructions per second",
+                     d_ratio(s_nta, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_t0", [
+              Metric("swpf_bkdwn_t0_per_swpf",
+                     "Software prefetch T0 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t0, all_sw), "100%"),
+              Metric("swpf_bkdwn_t0_rate",
+                     "Software prefetch T0 instructions per second",
+                     d_ratio(s_t0, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_t1_t2", [
+              Metric("swpf_bkdwn_t1_t2_per_swpf",
+                     "Software prefetch T1 or T2 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t1, all_sw), "100%"),
+              Metric("swpf_bkdwn_t1_t2_rate",
+                     "Software prefetch T1 or T2 instructions per second",
+                     d_ratio(s_t1, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_w", [
+              Metric("swpf_bkdwn_w_per_swpf",
+                     "Software prefetch W instructions as a percent of all prefetch instructions",
+                     d_ratio(s_w, all_sw), "100%"),
+              Metric("swpf_bkdwn_w_rate",
+                     "Software prefetch W instructions per second",
+                     d_ratio(s_w, interval_sec), "insn/s"),
+          ]),
+      ]),
+  ], description="Sofware prefetch instruction breakdown")
+
+
 def main() -> None:
   global _args
 
@@ -288,6 +352,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelSwpf(),
   ])
 
 
-- 
2.44.0.278.ge034bb2e1d-goog

