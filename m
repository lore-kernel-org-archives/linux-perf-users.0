Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08425FA2C
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440726; cv=none; b=lscSyibf6pM+HJdGkOxNsSTGtfMfjqJDFmaPfMwtPioCBL604E24TvblnN6PDvf61RSTaLyagUmWM4FnC2SJeTdB8lbj4HeRxnzJ67VaODKh+gZGGX9VwHc+I9yvqAuf8oX52VnJvevaPRfqshyiwHK2NMuvm7Jut3rPySJXC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440726; c=relaxed/simple;
	bh=Zmg5fiaGvVB2oAbAa8cyTmxLXHJNaqMAFuVzYAZ7E7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Lni5O2mGKctvcFbRj+ZnqAghenABr+ZIKdqLEovAuVNX9rhqy+AuEzrMz9VuTd6YGqn+DNPIhyqMs3rW0BG0Y+C5azoypyV1/qQDTE+4a9wgsgZZZBBgS+AbrnZkJwIt6M9lvrldN/KSTxcEU2tSvk0P3vIPvdeHTEgcfpskpNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EociVruX; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EociVruX"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32769224506so1656654a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440724; x=1757045524; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0n569qf5LRDqKDozKnwC4zMI79CFARCiF4XIPmnDZ4=;
        b=EociVruXVFnXOvBjvCVjzjYXMJKLj2cqF9s0SoxAX2PhMnHaipt6SFGjv8nUz6dB9s
         26vjOLVSkLOp2H8VeILY6YQLGEeBVxDVhblKVssjmlSkB+q8eeD8ZYP2/9KFuUs4uB14
         PvPfYJ0ua+IrmuQd55ABuS2HP2CBIQJMb+DJaFAJE9pB4lWGYaejwY6dtQn8bQkbJ3ds
         FCzl5aSgPakgVM4kJ1u+WR7VSc/b3+33t1fjmtAjTKdixJat60fYmm1QKt5vJ6HJo05A
         glxluFSg0kEVMY/XjsFzVRkO5PcHPBJ0qehVTbcFpldrxcJdQ1dSnk7FYrh7xFY5F3cS
         S2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440724; x=1757045524;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0n569qf5LRDqKDozKnwC4zMI79CFARCiF4XIPmnDZ4=;
        b=E7rsg64okh+7YsG6BCOCPF9iSQQRWrfUTBLYnsIGm0q3WFTJ6BjCt1U1ISjS6u2ESa
         /7TJJwD2ChrTCtJKRMOR6Ev5sfM4QSaCZK1gd9Rxq/m00Utfssaz8DOuYI1uNi4TF9EJ
         HkGf7yIhO8MZ5nTK9XceUBnCJ357juOnmGFMUuOs9aFBOj2tiqg2LQHV6wqGxG9bcd4t
         gBaQmPpvRO/lWCnPgjMpFeY5+kM381htj6a3BQWWsqUDCu5fdVvod/xT5wwzEui1854H
         DdcYM4B+bZLlDo993uDdtHAtZVOzPw0blm6XtUOolAXAzWy76oWYYuamV/cIx2t0wLHE
         Q3xg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ8YbqqvGWjFH0uOyxNSN7i5JWzGca0pq6w1igvBskR1e0Fmc3zZq6FkRj+tEgDkBTP5TYi9IGrYJm4BELRXkP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3nHBFviiaj2qh2T06dtU5L45cwJFFGZruxL7i8fMB5dadn5UB
	rPR8yZPWWICF3I4lZ1pi7/Mncwbmx3DKZWrxz3fufvsnm2MFeck73xrhJJZg/LmhbtTjyb/C2Hi
	riPFtTdbDkQ==
X-Google-Smtp-Source: AGHT+IE1G+MehOwF6KjzzHtb+fdHuNYJEKdpccHtKGcwif7meAE6X7UTGKKmVU+J2s7OKnVu9NUbR8+gbf3Z
X-Received: from pjkk12.prod.google.com ([2002:a17:90b:57ec:b0:327:4fa6:eaa1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58ce:b0:323:7e80:8819
 with SMTP id 98e67ed59e1d1-32518b825b3mr29015147a91.36.1756440724439; Thu, 28
 Aug 2025 21:12:04 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:11:00 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-20-irogers@google.com>
Subject: [PATCH v5 19/22] perf jevents: Add C-State metrics from the PCU PMU
 for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Use occupancy events fixed in:
https://lore.kernel.org/lkml/20240226201517.3540187-1-irogers@google.com/

Metrics are at the socket level referring to cores, not hyperthreads.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 808e006addda..d822352139f2 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -800,6 +800,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreCState() -> Optional[MetricGroup]:
+  try:
+    pcu_ticks = Event("UNC_P_CLOCKTICKS")
+    c0 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C0")
+    c3 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C3")
+    c6 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C6")
+  except:
+    return None
+
+  num_cores = Literal("#num_cores") / Literal("#num_packages")
+
+  max_cycles   = pcu_ticks * num_cores;
+  total_cycles = c0 + c3 + c6
+
+  # remove fused-off cores which show up in C6/C7.
+  c6 = Select(max(c6 - (total_cycles - max_cycles), 0),
+              total_cycles > max_cycles,
+              c6)
+
+  return MetricGroup("lpm_cstate", [
+      Metric("lpm_cstate_c0", "C-State cores in C0/C1", d_ratio(c0, pcu_ticks), "cores"),
+      Metric("lpm_cstate_c3", "C-State cores in C3", d_ratio(c3, pcu_ticks), "cores"),
+      Metric("lpm_cstate_c6", "C-State cores in C6/C7", d_ratio(c6, pcu_ticks), "cores"),
+  ])
+
+
 def UncoreDir() -> Optional[MetricGroup]:
   try:
     m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
@@ -958,6 +984,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreCState(),
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
-- 
2.51.0.318.gd7df087d1a-goog

