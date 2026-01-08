Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7403C3321B3
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899531; cv=none; b=DAoDLPABDl6toOBbce1mfaAbE0z/S7CV5QHqaxfzKxesubmA4j9UGjPsRFgvyBksC6zhWmZDLDag4Bkjq1L38ZGa+kGL1w3JayjtSMWVKw9Hd1cJszFYudQgwNRApSGq/Fh/eoBhmY8EUxpK2HMmvj+oi75V8QI/bT7x4KTCkXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899531; c=relaxed/simple;
	bh=5xiZtz+7A1r9ki67YdNxm6S4vRgkIhkqUDeTkPmh6mI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=AY6N+1xT6of2adlkq0ggCrAwW/sjfYRbM4nGDMlkuJq3SB1fiu0Wirlh2HqkEHQc6tDWSWGxr2Q2Q2WQGW+m8J5eEwWggGLq0dDrDXggW17we18Z3taYdKZ32H4er1uX478EBgVwwHxR0hWZelzq+wpANwMWYgwD8wYC/fTSQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nq5GvhMk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nq5GvhMk"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b9090d9f2eso3845160b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899530; x=1768504330; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfvDdkmRBFYOyeN2O+RaG4K637ivAdshUHZLdNirJKE=;
        b=Nq5GvhMk8ozzZ4jnZqpQyW2pxD07rj5ay3xIyRQAxiBoS7M9wukHVjeODcoRQ8YwGX
         as77ZsKId06qEQffkSbC0mZ690YsMlhvQWx7iMK+Y4W7Al2Kspmb8iFbf4Qy0wtIKn5D
         xnfrzfSt4qkay8RwurTjsQqVQi2dSGcedOnHnCAQuPkb/aOlLl19Wo4P1cQWthanVLDy
         rddW/rYBe5ZVmrcOglHsasKaqvIz+IJBctqbaxkSSr/pO4vYAL3lYqLnsRIetjZ95nP2
         le0kLEulc80yUKZlqDWzwltwCBgPiri057svQET6Nem5pA6oNNu3F7Bn/yx1MJgoGDvr
         oNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899530; x=1768504330;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfvDdkmRBFYOyeN2O+RaG4K637ivAdshUHZLdNirJKE=;
        b=qU2gYK+KQFQAw7JxjgvQHJB7wCIflix8xQEWhxDTJu4MUsPlY8tu6/sadf7512b+TW
         DC17K4ZB0quMtnWDaMINkTTjTwq6u/8TM8yVEtgn229QNqwljdqAYMpyZOjw/XzBSz/C
         plxI2lYfZGv3DhREPMeFmFTC/tyuD/6y+EaIl0D0GOB2AEO8btPJpe0AyeNzQ1PdWEMn
         WNvVtAn0t1nso4oYe7jjzdHwleHzCAlrH4OhZvmRrw3HJ+iBLOYZrJWsFfnrbbp+lV1Y
         pPAk9ZB0srQbm3Nvb9icW8G3vKmt/+rNwlwkVAo2qqGDJ0B6lx3D7353YlXbLak/xRQF
         GtRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCdCw59wiMjj1BVktIxZuztzK7TAUj8q2K2AMkCkLKgsaj2eL+uviCtsOja2trVSsDx89XsTPH3+WdbxGd1yoM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JY+SVHTw72ZGca9TnKo/7RhC9kuml1xMUwvsewnaMX6fOfKe
	LA4Opb1WlH3LlmiIrhzPuSQc+es3ZeNWG0jp+WY8l8xkbtfTuxPXxqNRXgh4CpFsH0PIygPxoJE
	ikbZCp9eG8g==
X-Google-Smtp-Source: AGHT+IFozC1Eaou5LUjCJVDzbtJm3tK9WcS6bFE1tUsqEzHWArRFc8pd2b37WtYxG9w77W3k4O4kFciiUPPl
X-Received: from pgea7.prod.google.com ([2002:a05:6a02:5387:b0:bac:a20:5eef])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a7:b0:364:1337:647a
 with SMTP id adf61e73a8af0-3898f9b97bamr6248506637.38.1767899529821; Thu, 08
 Jan 2026 11:12:09 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:53 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-24-irogers@google.com>
Subject: [PATCH v10 23/35] perf jevents: Add ILP metrics for Intel
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 19a284b4c520..bc3c50285916 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -263,6 +263,45 @@ def IntelBr():
                        description="breakdown of retired branch instructions")
 
 
+def IntelIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("INST_RETIRED.ANY_P")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                        "CPU_CLK_UNHALTED.DISTRIBUTED",
+                        "cycles")
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), core_cycles)
+           for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], core_cycles))
+    ilp0 = 1
+    for x in ilp:
+        ilp0 -= x
+    return MetricGroup("lpm_ilp", [
+        Metric("lpm_ilp_idle", "Lower power cycles as a percentage of all cycles",
+               d_ratio(low, tsc), "100%"),
+        Metric("lpm_ilp_inst_ret_0",
+               "Instructions retired in 0 cycles as a percentage of all cycles",
+               ilp0, "100%"),
+        Metric("lpm_ilp_inst_ret_1",
+               "Instructions retired in 1 cycles as a percentage of all cycles",
+               ilp[0], "100%"),
+        Metric("lpm_ilp_inst_ret_2",
+               "Instructions retired in 2 cycles as a percentage of all cycles",
+               ilp[1], "100%"),
+        Metric("lpm_ilp_inst_ret_3",
+               "Instructions retired in 3 cycles as a percentage of all cycles",
+               ilp[2], "100%"),
+        Metric("lpm_ilp_inst_ret_4",
+               "Instructions retired in 4 cycles as a percentage of all cycles",
+               ilp[3], "100%"),
+        Metric("lpm_ilp_inst_ret_5",
+               "Instructions retired in 5 or more cycles as a percentage of all cycles",
+               ilp[4], "100%"),
+    ])
+
+
 def IntelL2() -> Optional[MetricGroup]:
     try:
         DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
@@ -639,6 +678,7 @@ def main() -> None:
         Smi(),
         Tsx(),
         IntelBr(),
+        IntelIlp(),
         IntelL2(),
         IntelLdSt(),
         IntelPorts(),
-- 
2.52.0.457.g6b5491de43-goog

