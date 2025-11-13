Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC3311944
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004104; cv=none; b=SCiunr4SSkV3Ew+LAO3Q4GnEpnwZ+BuHkNU8H3oaK/Vn7o5+OUvxQYlMPEoTHVsenTa0ZP5F/Lp0gqa40sUkXtTlDMzjI0v4uKwX42TPPhu+I0aNpnK4VDGbvzSxobNNSi4i8GkGR7NYhvbF2RKp3JAS1ybKULpC7mZl6IwXEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004104; c=relaxed/simple;
	bh=ogGh2om0DC9PMjOzZti3DANsfTcUWimWRSDgAsS7fkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LxFOuVuyF+P2X04iKIdz8JwZv2Si5/NdddolA+bGlO9o7uHK8NKY5soUk8c0p2Q6effJYrOLK43JMtF1pKAsVE4CQVee6/IqmAcslsd3l6I8YJLp1d8fP2nlY8Jug9dMzFy9lr18gPPvmtK7XHlp6TJSA1pZa0JFpSMAwlSQaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LuejWpjQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuejWpjQ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340c261fb38so805259a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004102; x=1763608902; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwOooBJgARuZx3xvFM9lWStOej6it0RXeAICfjsNzzw=;
        b=LuejWpjQTFIJ2gDghn1Wt9MBrBUBBS4OixSxkB8kSZtciFMdpwsEORoDQfoulyo5fw
         2GZYTeUgYUQZK4QymBKr9cC2nnYDnAsQyODNM5YJZHMgNicLIodFKtr4RDGRxwTTh16r
         xfUTqYuhQGo6ZoIU0yLxh1xLt7iHLwAPwNb7rfO/y28v3MMULSIUVTB2mstVJ7sL2bn5
         idJCBVrt9cvXxy8Reg28MiWS6YwIw7lWBqONgLmo+oOAo8izL/0cF6phExM1uqPPps5T
         3q2j3xskdpl5gVq/rHW2GWpZY4KTK9xXhDj0GzfTWNKkJL6DyDDDpV+k4ecvnK+TDrJs
         fNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004102; x=1763608902;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwOooBJgARuZx3xvFM9lWStOej6it0RXeAICfjsNzzw=;
        b=iY3QSJFUlicqv0ysKcK81liix6kMBzzXbBtP2773P/JATaJVJbFrLLb1BTXf6zUu4I
         KxrDbxhJ7o6+1B1P0gjPf5getyO3fcCYU4MAhqXSzX3PM2QyWszc5tRAMG6y5z1WnEKr
         lOsIUPyLxm8XiiO4p5xnuXxR5fPb2ZUDrw/akq7q1K/RxYFIHLldw8RGDeOnl+U6e/W8
         rnG6Pv/YwryPW6hICRlsjn4oPisuZbsdFOehpHpxB7EseCGzPLaFVoqNs0V0t20KRokY
         rFy/8zXopFEB9R79ztSB064KaH0i70jw0tVEhvULu+bT+S0fMA2jojcrn5HRPf1ak5Cq
         CO0w==
X-Forwarded-Encrypted: i=1; AJvYcCVgCmTie2RU5FgdknH3xsvuqDHPOZKQPs2njuxcjYesZJHmKu111NxVgXoqTY4+iwGw7fjzuuQV5c276OcCbRX5@vger.kernel.org
X-Gm-Message-State: AOJu0YzaxmmF7DY0Um/+71r2XP9cbS3/Mg0y/beBToDWhQAabhC7Xt4S
	LWqFm9tlayLo1Rk9XsTgXluWB2/i2BF8AFsuzgjR/n3ebxGCRHJsPnMj1KGnHNBVpXd3Y+ZAYQU
	mnubD+DK3ow==
X-Google-Smtp-Source: AGHT+IEhvLLZuZN0ZsEhaTGlzhZ6B8CVINpNvIBTNMAGx56cbqlPEsYvdUwZE7aEMtKifSEHxmFO/vdDfPvN
X-Received: from dybfx25.prod.google.com ([2002:a05:7300:c399:b0:2a4:6f7f:e6f0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b63:b0:298:4ee2:19f3
 with SMTP id d9443c01a7336-2984ee21a2cmr68747545ad.49.1763004101727; Wed, 12
 Nov 2025 19:21:41 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:13 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-26-irogers@google.com>
Subject: [PATCH v8 25/52] perf jevents: Add ILP metrics for AMD
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 37 ++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 53f7c2198147..9a39e23075b8 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -121,6 +121,42 @@ def AmdBr():
                        description="breakdown of retired branch instructions")
 
 
+def AmdIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("ex_ret_instr")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), cycles)
+           for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], cycles))
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
 def AmdDtlb() -> Optional[MetricGroup]:
     global _zen_model
     if _zen_model >= 4:
@@ -600,6 +636,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdIlp(),
         AmdDtlb(),
         AmdItlb(),
         AmdLdSt(),
-- 
2.51.2.1041.gc1ab5b90ca-goog

