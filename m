Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BCB319610
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004132; cv=none; b=IlJXcaBDW1TEHant16sCzLm+GlkZjjFzbrM3voCHWYKUzOaGTt4TLzmpnVYOGJprdvUVyM8sqIuB+iKdAEndiwsdX7Kw60j19Y0CYVg5nFFSPMXn2+ijflGSu+k8sJhVtUidBd2Pc1C0TrO/g0YZdUrQD5IpNWp8iBBLIBNdd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004132; c=relaxed/simple;
	bh=3V2VLVo4pUTUZsrMQpMZJINP/Qhv3zRsmNC+KVt29MA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LGGuGYJASLLawULEkeuVsiQcsQphx2mMjLHEuYIGj/AY10lwvmq2px5843NWIIad36QDBiK9V/SUEkInAaHtmGdelWIiucvy5fzAev5OHepIXl1ieBv6VV90Sd8SY0eZWL9wplBrtc1NPr9aSLWvVMQGoffOZLcZZJXIF+fevQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2FRAtxD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2FRAtxD"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297ddb3c707so3238945ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004130; x=1763608930; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KkSWIFF9K6+WvuhLC3J+ZaMa6l3rfvikZA5lkR5D2LU=;
        b=l2FRAtxD86PaPFkiLyxjSsRLpL7ujq+KfVFuDW9g5IdtVr0sEdk6sUL9auQUDJGBey
         DFvbmojrLcySrDuYrglmRRz4scDVCMLN8zQs/j/YoKekmNa6mc3i4PZ7uZgB686kv90z
         cwYbXAEMANYyvrqZYFDnV7+dt8L/d41LEDqmusTeYli0N9KGg7YpZ71BX3WdHt/Hb1Vr
         2qVg6rLyw6UEiQikyncaC1UWujGf+J8nL+qEsqlKSfZmZ1NEC5QI2MIvmkeNE4NBVm4f
         9gw8nBXkdR5ZQHIIq64AB8zyUp8mnbAOuqQSSZWRarcBHzc905yGczF/Ly9eDbkHuiHp
         Z4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004130; x=1763608930;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkSWIFF9K6+WvuhLC3J+ZaMa6l3rfvikZA5lkR5D2LU=;
        b=Sbg3zB8CLQ9dfo2BL2bUe4rVxpJlch/QCW/nQMIsSmWY+ENxtRBOcGORb0JwgrFqcV
         wpI54exXhZ2N8Bx3CdzOTkTUhzK5qxcqPc0W2ZqfMp9Gsr6v/DAETQiE7GumEccRspzL
         PRckmbDfw3RufWdMYgkW9W1TBCakQ7zt0p53ozgEeq8RTXmhBl6b2y8ARSVHWC1abKNz
         bATdS3dKKz6pA/nv86CW/tO8/FWevJdb285jp1zsrH1K3sGqGao94xhCFBaYoQtRXV5s
         nxH2e0P2wxaGIPORJrQoG2hOOwVMJ6ozG1nEoecmvUhyyS29aZbdEfxeHhg9zz8Y7Cb6
         mTCg==
X-Forwarded-Encrypted: i=1; AJvYcCWjAogNarcdlLxaThAjXG6Hh3VI1O9Dn2n5p6HmlUrzyo/1w6yHTNwowMxTObUwdzqwqxsnjcWBNbBL0r+8HDel@vger.kernel.org
X-Gm-Message-State: AOJu0YyNnq0Sb7V59178oQ9obtCZRGJnn+v2GASUjkH0aS7H3V7xNflm
	XQKYQHRaiGmxNVJPA2fCZiRPpFtfTQGNnpfpRAjWkKRH98CwCkgbfpz6b3Lr/9mxfXCjGEjXZnt
	+wEFsI6EA3A==
X-Google-Smtp-Source: AGHT+IEyKyltlyCDbU4hqbiexDDPHzceFc98l5CXkwmdG5KoGmmnni7fKQrLRjEIkACVFV7MlkhharS/1GA+
X-Received: from dlbuy17.prod.google.com ([2002:a05:7022:1e11:b0:119:9f33:34a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b0f:b0:297:f09a:51db
 with SMTP id d9443c01a7336-2984ed45caemr68610415ad.15.1763004130509; Wed, 12
 Nov 2025 19:22:10 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:28 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-41-irogers@google.com>
Subject: [PATCH v8 40/52] perf jevents: Add context switch metrics for Intel
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

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index bc3c50285916..9cf4bd8ac769 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -263,6 +263,63 @@ def IntelBr():
                        description="breakdown of retired branch instructions")
 
 
+def IntelCtxSw() -> MetricGroup:
+    cs = Event("context\\-switches")
+    metrics = [
+        Metric("lpm_cs_rate", "Context switches per second",
+               d_ratio(cs, interval_sec), "ctxsw/s")
+    ]
+
+    ev = Event("instructions")
+    metrics.append(Metric("lpm_cs_instr", "Instructions per context switch",
+                          d_ratio(ev, cs), "instr/cs"))
+
+    ev = Event("cycles")
+    metrics.append(Metric("lpm_cs_cycles", "Cycles per context switch",
+                          d_ratio(ev, cs), "cycles/cs"))
+
+    try:
+        ev = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+        metrics.append(Metric("lpm_cs_loads", "Loads per context switch",
+                              d_ratio(ev, cs), "loads/cs"))
+    except:
+        pass
+
+    try:
+        ev = Event("MEM_INST_RETIRED.ALL_STORES",
+                   "MEM_UOPS_RETIRED.ALL_STORES")
+        metrics.append(Metric("lpm_cs_stores", "Stores per context switch",
+                              d_ratio(ev, cs), "stores/cs"))
+    except:
+        pass
+
+    try:
+        ev = Event("BR_INST_RETIRED.NEAR_TAKEN", "BR_INST_RETIRED.TAKEN_JCC")
+        metrics.append(Metric("lpm_cs_br_taken", "Branches taken per context switch",
+                              d_ratio(ev, cs), "br_taken/cs"))
+    except:
+        pass
+
+    try:
+        l2_misses = (Event("L2_RQSTS.DEMAND_DATA_RD_MISS") +
+                     Event("L2_RQSTS.RFO_MISS") +
+                     Event("L2_RQSTS.CODE_RD_MISS"))
+        try:
+            l2_misses += Event("L2_RQSTS.HWPF_MISS",
+                               "L2_RQSTS.L2_PF_MISS", "L2_RQSTS.PF_MISS")
+        except:
+            pass
+
+        metrics.append(Metric("lpm_cs_l2_misses", "L2 misses per context switch",
+                              d_ratio(l2_misses, cs), "l2_misses/cs"))
+    except:
+        pass
+
+    return MetricGroup("lpm_cs", metrics,
+                       description=("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def IntelIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -678,6 +735,7 @@ def main() -> None:
         Smi(),
         Tsx(),
         IntelBr(),
+        IntelCtxSw(),
         IntelIlp(),
         IntelL2(),
         IntelLdSt(),
-- 
2.51.2.1041.gc1ab5b90ca-goog

