Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECEF3C680
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319392; cv=none; b=EiIEGTXRL40DHFJdpg+LOpKKGRhLBgDORcf2ivUgmPbry0hzUQcxvbVRbTcICEFqrRNqLhufmENBLIjqBGa923lv4xPu9fKk2PUIus0hSKhtgrUKgYYUtyQ/6tMhvwMGA/fQtPcmdenOXmxToyLGUecCHqeTYZzH2ZeUJShIAEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319392; c=relaxed/simple;
	bh=/54YRscTrPrGaSdpjdXFm+80xMNflZRfzwa7Hsf5/WI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TehiNFovaHJ1/Crv3RSZSebZ3ngS4AY7v7jigpzcEDWqJNLBCa+00HnXYxa7FTv1cnNBFlj4WTdqPsR7szyd5rOFVTGCTNelIY/Rl2cxEBxyQ3/MXlcGlfz24cOTrteGSm9UMeAnrosa6RmaKKQmy8lNQpkH9rpzQGsSHcrQcYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gqfI9v9B; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gqfI9v9B"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so4734534276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319390; x=1709924190; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCqcOkno42A4mj5+uGyBsE4UljIV8p5MIV2GTsxx0/Y=;
        b=gqfI9v9BFL/2xmUnHAgMklwRYAkkOxw7WWox+C8ZL5jiWe+qP1OzPDdClw5GDdYe2R
         BvYtI9mzixLN4Ao5s/T+850s8EyHWZb28uvQFJRM7DSZ0LdfJSLiBhRBvwdsZMft9nj3
         qGvyqmgseNt7HebVv/4hKeWKpomSJwj9FAfU07OJj2yLTr305e21jxLxxXAkGqJ3Lbw1
         7E8Apl5TzIrNxDjBsIs9g4vei07Q7bq+mqIcikLJFqE2xQmsJhwDXmbD0jrvM2KCiD2t
         y0n6gfu/FMN1ucMhREvfVC2ri6H0/4GNUjFB3fT1Tfy+AmEWcDw30XzshNabAotKcSW6
         Mlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319390; x=1709924190;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCqcOkno42A4mj5+uGyBsE4UljIV8p5MIV2GTsxx0/Y=;
        b=npVruJWvb3B0NhFxudHPtEpipNSSEzJcxeH1g8JpkIxapBVF19aRhP39J4R5itlE8D
         q3W2LCOiLYD+0TZ3B+sv/1pb4vFqLISbtUPAydBky6unN67NJElYUsExyXZPNISw5Jt1
         q8qTmG6/IKsApSu0LI6fxjCK8cApoiW5Ts3iDLKAO25LnvNhM1XbGx+cDKEokzubS/jX
         xJhReaevNi4Ugk2lIIWsu1D++vdMMhGt98BSwOoo+5Jo8JrBQZRNTOBDkFknrL7Mhthy
         SBfQqi1qhD9x5dN5DYILOAZP3uMThYyywFpL8ISMEKN7Ied8cM+PD/NsRzgLkf4D8oJr
         UEog==
X-Forwarded-Encrypted: i=1; AJvYcCW1ZSmCy6NT9GEzqA3jmmV8aLGCtIyVrQtPahIREy3pYDMx9XRnGiCOGzsQCDr2fct2qZI0ZN/SfKAEWzlOHtGA2gjkPd0Hzq5+wPTKpp/eyA==
X-Gm-Message-State: AOJu0YxpNsbfc8lYbvsZY1zL6xS/IwtSnA7GxWn+t1At85dEXK2t36Hr
	ZDR30uQdQIaQdsGz22bhbjqFWix71/OyjDQtAzEW5GOd93S6U5Bv6vkiA7eq4hA++fIfIuOdOxC
	FQi0XRg==
X-Google-Smtp-Source: AGHT+IEVKYqSb1RJP04tzj1IpHZ72wqswmtzlfQnV49UiPSHcWuectfxWge0I8mzChan/LCCgyQFrzFNe3Nf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:aea8:0:b0:dcd:ad52:6932 with SMTP id
 b40-20020a25aea8000000b00dcdad526932mr551687ybj.5.1709319390095; Fri, 01 Mar
 2024 10:56:30 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:46 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 07/20] perf jevents: Add software prefetch (swpf) metric
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
index 562db0a1df79..6c42c8947652 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -266,12 +266,77 @@ def IntelBr():
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
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
     Smi(),
     Tsx(),
     IntelBr(),
+    IntelSwpf(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog

