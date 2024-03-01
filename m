Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969873C468
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319390; cv=none; b=ZMYei5VsuFaXxCMRVL3MB/uIApaLMp02KE06m77D8f7i2d3HN3OO+MMrbsRNirUbjujkbKhTjhSFhM7prv18jyC27ZQgV/ztlH2KngIprl/lvrOZ3Vg4I2CAn2CL8WI2/2M7u2ROG6oTl8s0A4QZJ+7fNe+8RR5Tjn2fK5oWKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319390; c=relaxed/simple;
	bh=FlRrp5/2ztkczVrYoDn9EIOjChMK8yWEJSgo0hdGptg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DJhbK4OmfRirTVmBVNizVDE2/0bbGYglHhUOlVXVNrBO5hrS6eHn1/KCvdlhdllZT66D1Irg2X+96dyV1j+ytso0bXfsoqnh/WI9y3ggGefQcO8B/OJaQMttN1tcZrA7wmnb0XAed8DPGEMtBAGfTGOyjvejgPAty1UI8P7rqYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Te/Hdd6G; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Te/Hdd6G"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6098d88e994so5228157b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319388; x=1709924188; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6YYq7rNB/18JZA6R+41hP3nh0swy3CSvJmc4i9vc/I=;
        b=Te/Hdd6GkTttIGnVb8ne7pbex0pE1TKDXdKlCGkU2SNU9drPIJcZpRs5fWGRAQUvE/
         sqjKhdGL5Bm3EJE+hUaizykOsfgN8pAVJkO/kH+Hh1mp2R8elmhyH4QxwR/E4vfv3v1A
         ClXrGSp4NvAjYhr5QsGzHCTa+XU/IM9sFnESFGTZN5YCe5SbZXCyuxEyq6RI3BnuD/+u
         jJPNG7HjAsrwD1Y2fI7EK/+N6X0UOXPmAmbjNx8yGFu00/QqltBwuXStihHlCTDmeEa/
         atQZ7g7302GxxPQun6rqXf0+Nb9nSmcW0vmsWGTHdrQPQ6oBlL+Jb1ppSo5DRFSHta0C
         +zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319388; x=1709924188;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6YYq7rNB/18JZA6R+41hP3nh0swy3CSvJmc4i9vc/I=;
        b=FhbMeEle/+aI5P+Rcf60r6szQTZnMfwSx1VIRX5LjEtjiX+FUFOvqNQTrjEs2xt5k7
         MSbhnK77VKrX/AEb4IAf51KtkTjo+oRdM+NVCn8D1TcfKQ2ikF/CA2fznGRXhYQcEhIw
         KUBe6Uaytwy4UB+qpmwA/Wopw6ALrAdUCiSqXNU/2V99vShWPRQrXGkKLWzAms3IqXT4
         MwiZErMwWxly6pKourlExABBYHQFtdJN4y4COoPSt6qLLnVkdE2GrarKZitRMvZjj2ki
         Pg1WGwp4TRTcZMyvVWxG7UCDBmO2TnKi1yGSwajRtt4jw8RSC0VkPOwDF3tk3CMiJYtM
         sghg==
X-Forwarded-Encrypted: i=1; AJvYcCUXDbfY60l73LyLiFS8ytdUPqrB0QxvvRYu1cTUanrmmM7xfLLKgiw9rYviEQXunEORAkP3wtJk0SIkQ8A8KrB1wzgBfBPotocHC4N2PffW/Q==
X-Gm-Message-State: AOJu0Yzi4EarMRkCLbrkG4QGJTEoDSX3wegV3uJzNVOS6qf+E8JG6tQu
	Vm8kWwX1zV/91aW9NvFSGq/WvQQ9DL5EzM6fG71UHA0VyM5ffj2WDdJ6lQ5RaHJsx+iOID1mrQj
	UqFR7iA==
X-Google-Smtp-Source: AGHT+IF0SCtTKp5nSixBXxa+KCdU3JBeSisYQpUC3iGglb9/UNXOpoXdpDtgjlw6HfhtNUsxAwkkYoM7BZWZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a81:9949:0:b0:609:2fba:12a0 with SMTP id
 q70-20020a819949000000b006092fba12a0mr634883ywg.3.1709319387865; Fri, 01 Mar
 2024 10:56:27 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:45 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 06/20] perf jevents: Add br metric group for branch
 statistics on Intel
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

The br metric group for branches itself comprises metric groups for
total, taken, conditional, fused and far metric groups using json
events. Conditional taken and not taken metrics are specific to
Icelake and later generations, so the presence of the event is used to
determine whether the metric should exist.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 138 +++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 3d80b555fac9..562db0a1df79 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -129,11 +129,149 @@ def Tsx() -> Optional[MetricGroup]:
   ], description="Breakdown of transactional memory statistics")
 
 
+def IntelBr():
+  ins = Event("instructions")
+
+  def Total() -> MetricGroup:
+    br_all = Event ("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+    br_m_all = Event("BR_MISP_RETIRED.ALL_BRANCHES",
+                     "BR_INST_RETIRED.MISPRED",
+                     "BR_MISP_EXEC.ANY")
+    br_clr = None
+    try:
+      br_clr = Event("BACLEARS.ANY", "BACLEARS.ALL")
+    except:
+      pass
+
+    br_r = d_ratio(br_all, interval_sec)
+    ins_r = d_ratio(ins, br_all)
+    misp_r = d_ratio(br_m_all, br_all)
+    clr_r = d_ratio(br_clr, interval_sec) if br_clr else None
+
+    return MetricGroup("br_total", [
+        Metric("br_total_retired",
+               "The number of branch instructions retired per second.", br_r,
+               "insn/s"),
+        Metric(
+            "br_total_mispred",
+            "The number of branch instructions retired, of any type, that were "
+            "not correctly predicted as a percentage of all branch instrucions.",
+            misp_r, "100%"),
+        Metric("br_total_insn_between_branches",
+               "The number of instructions divided by the number of branches.",
+               ins_r, "insn"),
+        Metric("br_total_insn_fe_resteers",
+               "The number of resync branches per second.", clr_r, "req/s"
+               ) if clr_r else None
+    ])
+
+  def Taken() -> MetricGroup:
+    br_all = Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+    br_m_tk = None
+    try:
+      br_m_tk = Event("BR_MISP_RETIRED.NEAR_TAKEN",
+                      "BR_MISP_RETIRED.TAKEN_JCC",
+                      "BR_INST_RETIRED.MISPRED_TAKEN")
+    except:
+      pass
+    br_r = d_ratio(br_all, interval_sec)
+    ins_r = d_ratio(ins, br_all)
+    misp_r = d_ratio(br_m_tk, br_all) if br_m_tk else None
+    return MetricGroup("br_taken", [
+        Metric("br_taken_retired",
+               "The number of taken branches that were retired per second.",
+               br_r, "insn/s"),
+        Metric(
+            "br_taken_mispred",
+            "The number of retired taken branch instructions that were "
+            "mispredicted as a percentage of all taken branches.", misp_r,
+            "100%") if misp_r else None,
+        Metric(
+            "br_taken_insn_between_branches",
+            "The number of instructions divided by the number of taken branches.",
+            ins_r, "insn"),
+    ])
+
+  def Conditional() -> Optional[MetricGroup]:
+    try:
+      br_cond = Event("BR_INST_RETIRED.COND",
+                      "BR_INST_RETIRED.CONDITIONAL",
+                      "BR_INST_RETIRED.TAKEN_JCC")
+      br_m_cond = Event("BR_MISP_RETIRED.COND",
+                        "BR_MISP_RETIRED.CONDITIONAL",
+                        "BR_MISP_RETIRED.TAKEN_JCC")
+    except:
+      return None
+
+    br_cond_nt = None
+    br_m_cond_nt = None
+    try:
+      br_cond_nt = Event("BR_INST_RETIRED.COND_NTAKEN")
+      br_m_cond_nt = Event("BR_MISP_RETIRED.COND_NTAKEN")
+    except:
+      pass
+    br_r = d_ratio(br_cond, interval_sec)
+    ins_r = d_ratio(ins, br_cond)
+    misp_r = d_ratio(br_m_cond, br_cond)
+    taken_metrics = [
+        Metric("br_cond_retired", "Retired conditional branch instructions.",
+               br_r, "insn/s"),
+        Metric("br_cond_insn_between_branches",
+               "The number of instructions divided by the number of conditional "
+               "branches.", ins_r, "insn"),
+        Metric("br_cond_mispred",
+               "Retired conditional branch instructions mispredicted as a "
+               "percentage of all conditional branches.", misp_r, "100%"),
+    ]
+    if not br_m_cond_nt:
+      return MetricGroup("br_cond", taken_metrics)
+
+    br_r = d_ratio(br_cond_nt, interval_sec)
+    ins_r = d_ratio(ins, br_cond_nt)
+    misp_r = d_ratio(br_m_cond_nt, br_cond_nt)
+
+    not_taken_metrics = [
+        Metric("br_cond_retired", "Retired conditional not taken branch instructions.",
+               br_r, "insn/s"),
+        Metric("br_cond_insn_between_branches",
+               "The number of instructions divided by the number of not taken conditional "
+               "branches.", ins_r, "insn"),
+        Metric("br_cond_mispred",
+               "Retired not taken conditional branch instructions mispredicted as a "
+               "percentage of all not taken conditional branches.", misp_r, "100%"),
+    ]
+    return MetricGroup("br_cond", [
+        MetricGroup("br_cond_nt", not_taken_metrics),
+        MetricGroup("br_cond_tkn", taken_metrics),
+    ])
+
+  def Far() -> Optional[MetricGroup]:
+    try:
+      br_far = Event("BR_INST_RETIRED.FAR_BRANCH")
+    except:
+      return None
+
+    br_r = d_ratio(br_far, interval_sec)
+    ins_r = d_ratio(ins, br_far)
+    return MetricGroup("br_far", [
+        Metric("br_far_retired", "Retired far control transfers per second.",
+               br_r, "insn/s"),
+        Metric(
+            "br_far_insn_between_branches",
+            "The number of instructions divided by the number of far branches.",
+            ins_r, "insn"),
+    ])
+
+  return MetricGroup("br", [Total(), Taken(), Conditional(), Far()],
+                     description="breakdown of retired branch instructions")
+
+
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
     Smi(),
     Tsx(),
+    IntelBr(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog

