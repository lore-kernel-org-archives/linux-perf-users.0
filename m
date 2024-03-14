Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43514594C
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396002; cv=none; b=jtl0PdKJg3shVx0P6lDpfzNI2NDzT1+4S8AKwMuBOH+d9PXka4wNuN2CU9p/gQP8iuwtq7Ibi7jBoV3iVd4eLvc45DoJLPym7PY8DiLX6yx7EQCO1xgClHzHqfKKxPN/kTSG+T7vIisKq6DlnxpTkopSatSC7xgVSfk2Yda3q/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396002; c=relaxed/simple;
	bh=ATIEU1OwZT5UPCeNuSu9+OJJ7mgcQCq56xVHEiwhOQo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HL8RAQGrg9p1kHSJYklUKOIzcWPu9cmObfWEUDNaejDfvEbPtdb3wJkbzz5AX6SEUYd/NvUVHp1ZVv4SPg2sMK/wqOFlLQz30LQKfCOxSx16m89RuoTX+vEgxjxtEw9J/EZSBCoKQMeh1kUhYnZn0LRyYqcwn2YMe2d+38Z75mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L//ABNds; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L//ABNds"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a54004e9fso12940147b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 23:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396000; x=1711000800; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dpf5hHVN3JuBV5acx4fDuNQxWamY4EcOXEKL6JOmADo=;
        b=L//ABNdsdXLmodTQ6SJNfN+MPpaKjkg2GvsVR4+3VtQ1DKImzLP0AeXF83Yz4FF9Pb
         5AxYKcmqfMxOK4+QbcvtHFHDn6kYbhaB20JLIv0JlN6flTyyI40KdBHj6MtwHa/0t7J0
         b4QVe+o1/0vSM0eGvi5x6rkFzmRVjbO87bJ2SrHjsFhBfjuyYVTnF66vq4KUPacQffja
         8YjdrvQHkCZveMQfG5cz+SyCJK2Wx1VDKjUdZNCfG3MMK1QZ7G3Y4HSe34Lx/l232Yjp
         hIzEX4ocJYJF9D2l2OB10uiI8zu3C+fI/+GRzQauXz//S607VbJOvPHeBDHcRtXKT2Xr
         bpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396000; x=1711000800;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dpf5hHVN3JuBV5acx4fDuNQxWamY4EcOXEKL6JOmADo=;
        b=n++qD+p5JlbF+UokCNB2NdJiyN/4KXq04d0OKC4U0KwWh0jO55QIXVwdzcPD+v9ZJZ
         pMthT+RY/nz3UxoB0AdH61d+YGNmkdILmu9C0vGLm74c8Re99ScpZWQJljU8FcbVeDf4
         KG7qqvs0TZ8qxs5nURg1sOHZYXap2U3a8Nu1PUD2PoODkjqmEK+0so1tn93R7aQOg85Q
         DjGdifiDW7ZE3Ed6igpPP52kuvxLRo4PTXwsIndQGjFyywacSPQMU7PdSIfH8q3Y3WV0
         ynLKpOJAcSAAUf2vcTfSRV8BMVCjnd7FVitYzARu9/czDu6+8VhaEdTX3sYHBagHIRed
         RdiA==
X-Forwarded-Encrypted: i=1; AJvYcCWpHLLhEF97d0wH1Hlh+4whW0oESXDprRcpWmeP4UBjX7z2CZYFEvg0c/b2BZcmFVHVu+2/v2bTrhjW8hTxA/L87DrpNKq9zkPmkv+jT8qEuQ==
X-Gm-Message-State: AOJu0Yz/HYIKEAST1BZwWqyREHFlqw+8/2LnjjHUG9qLAWnxTAOZqqMx
	0h8/AZSCndquULYpvtbiilpZMwpV3G+IXaY926/xuEHxsGsJtIw7d4Aww89eBmJXyFFv7Uegfbs
	9egKaSQ==
X-Google-Smtp-Source: AGHT+IGZTjZk04FELRhd0NJWv7Oiq9IKYNIMixNmG3acf5ytq9ZgxcP7xIUpAkvk/rTlh7aM/9Zepk/FZDZ5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a81:5297:0:b0:60c:b1d4:a9f9 with SMTP id
 g145-20020a815297000000b0060cb1d4a9f9mr210861ywb.10.1710396000037; Wed, 13
 Mar 2024 23:00:00 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:10 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 11/20] perf jevents: Add ILP metrics for Intel
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 4ac419212b3d..d15f9ac05204 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -266,6 +266,35 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelIlp() -> MetricGroup:
+  tsc = Event("msr/tsc/")
+  c0 = Event("msr/mperf/")
+  low = tsc - c0
+  inst_ret = Event("INST_RETIRED.ANY_P")
+  inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+  ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), core_cycles) for x in range(0, 4)]
+  ilp.append(d_ratio(inst_ret_c[4], core_cycles))
+  ilp0 = 1
+  for x in ilp:
+    ilp0 -= x
+  return MetricGroup("ilp", [
+      Metric("ilp_idle", "Lower power cycles as a percentage of all cycles",
+             d_ratio(low, tsc), "100%"),
+      Metric("ilp_inst_ret_0", "Instructions retired in 0 cycles as a percentage of all cycles",
+             ilp0, "100%"),
+      Metric("ilp_inst_ret_1", "Instructions retired in 1 cycles as a percentage of all cycles",
+             ilp[0], "100%"),
+      Metric("ilp_inst_ret_2", "Instructions retired in 2 cycles as a percentage of all cycles",
+             ilp[1], "100%"),
+      Metric("ilp_inst_ret_3", "Instructions retired in 3 cycles as a percentage of all cycles",
+             ilp[2], "100%"),
+      Metric("ilp_inst_ret_4", "Instructions retired in 4 cycles as a percentage of all cycles",
+             ilp[3], "100%"),
+      Metric("ilp_inst_ret_5", "Instructions retired in 5 or more cycles as a percentage of all cycles",
+             ilp[4], "100%"),
+  ])
+
+
 def IntelL2() -> Optional[MetricGroup]:
   try:
     DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
@@ -619,6 +648,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelIlp(),
       IntelL2(),
       IntelLdSt(),
       IntelPorts(),
-- 
2.44.0.278.ge034bb2e1d-goog

