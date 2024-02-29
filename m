Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141A52E62C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165754; cv=none; b=pZvxolnLXhRoQA01ACoCQA0DpFjd7EtP4yltaG1RxWO7Vk4wpaHdVGyQm72nKehjkicIlln2KxrMs97f57UZgm6NSFaoFIsA/owFEz+27RoZpggnrmBtl1Y8DBvKzgrEXDhe935z+Uz9gRoBpbQBaES2Q2kiQMy1EkDbCYx4Okc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165754; c=relaxed/simple;
	bh=YIxmuBzBhglh4md55W8onI4xgQ9tn1Wuzd6FPGsaM/I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=NftwCEHWfNz47cQv5q7DOadD7osuXRhLxzdatnKZMHL7pbmVdyg/Gw5q5Dn19EekohGbKQLa7Jdh1msLkWmntbxFHOWBmg5GKh+n4X0bdwI0KSNOx4EdKEo/HRzm9KRgbxOJLNsNBgqvmUWDZQqWRwsTsLbTJf2OZRfBjJETd3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=itbrC+ka; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="itbrC+ka"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6092bf785d7so6952577b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165752; x=1709770552; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWgiWiE03exBg0PhwlQIGByRAV21o9JQjLn06/BhBfg=;
        b=itbrC+kadF0E0a++Y7xmZz1cYtR15CWYJY/LNUWqrWSGp28vZHT001p0uYPR7TtDKJ
         yvWTjYegglb1tE5fxsquytXvCWvSscnBrbsrxOP5kIM5gH/VE9rLQ1EupJl8fjvxmEmV
         BkkQPw0qEWX8bqzXJjR+M4lMi5JjDE2FD2kFawXr+PofoItzFUaQc1asUs18PMFS2JFd
         t/abkxWwc2J09D2FPVzmu0qTGQ7lj87RRQQKMzJPChHQ73fA4iYv5JMC3O9PW56V+PEv
         39Td476tW0+sJQCMCKzJ1plkEfHDPfuf+ILbrr+SHw2F34Q7GlZ5zKVRjSXk4TgqpVL8
         JqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165752; x=1709770552;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWgiWiE03exBg0PhwlQIGByRAV21o9JQjLn06/BhBfg=;
        b=ErQmaRGnhlwzwOThFxgH240+C69BoDr7U7pfsg+agpemZ4zR4R7h/m4aCHM8lvFr50
         qji4Ag8cPUMnMNe8MQbSMTpIoMqpvohbRIAdjfOsxM55jJX9GWP7Ifvy3WACpZiXYClp
         kRUMBf+tEY7LUyihNZYE2pG5zaTQpf8P6bjjXBEJzHUH7FffDWqvc1DSi8Ks5SDAWNR4
         QFhxz4vA/54/uIf7gXJa/o5oIB6e4SG1ZMXJZC8PoB+ip8YtgNfDTLmosjjBX45PIAWf
         Fa2DFG7Ok8TECIQ31+brx1jIkqQvq3Ln+7bIysyjOWiMI/0RQMFme7haWy6zdusNaAxM
         Axfg==
X-Forwarded-Encrypted: i=1; AJvYcCWArk7QLpKAntjt4ZAtrEg+ZWr1dk/TOLrC6CA3YkfkojvgzxOBikM/0fXeD/GcCNxs81peaXP6Z6hCbPF0OLv0eb2ciZEDpNQ28Yr4jj1ufw==
X-Gm-Message-State: AOJu0Yzu5gxUeMT3nk8f7TMpZW6EZfC7k1I2rj+zYQPlFHPuF7O6k5CK
	2ecwiCE952qxjTcuRZlcJF/mgju1wRuZHQXoDQHNACPz+vBXSDL6LqQZzClst/UOAaLqe+mba8R
	n5s3C3g==
X-Google-Smtp-Source: AGHT+IHt9jWLmKQEdk4k5LlJrlMxqklKIlYDKc6C/dX9t5F+2Km1V1+uqq2XterkXbkPChEFNBWz6Cz+MqrM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:722:b0:dcd:b431:7f5b with SMTP id
 l2-20020a056902072200b00dcdb4317f5bmr210121ybt.0.1709165752053; Wed, 28 Feb
 2024 16:15:52 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:28 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 04/13] perf jevents: Add br metric group for branch
 statistics on AMD
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

The br metric group for branches itself comprises metric groups for
total, taken, conditional, fused and far metric groups using json
events. The lack of conditional events on anything but zen2 means this
category is lacking on zen1, zen3 and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 104 +++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index ce3d1535483a..f8d5ba2861ee 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -7,6 +7,7 @@ import argparse
 import json
 import math
 import os
+from typing import Optional
 
 parser = argparse.ArgumentParser(description="AMD perf json generator")
 parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
@@ -18,10 +19,112 @@ LoadEvents(directory)
 
 zen_model = int(args.model[6:])
 interval_sec = Event("duration_time")
+ins = Event("instructions")
 cycles = Event("cycles")
 # Number of CPU cycles scaled for SMT.
 smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
 
+def AmdBr():
+  def Total() -> MetricGroup:
+    br = Event("ex_ret_brn")
+    br_m_all = Event("ex_ret_brn_misp")
+    br_clr = Event("ex_ret_msprd_brnch_instr_dir_msmtch", "ex_ret_brn_resync")
+
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    misp_r = d_ratio(br_m_all, br)
+    clr_r = d_ratio(br_clr, interval_sec)
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
+               "The number of resync branches per second.", clr_r, "req/s")
+    ])
+
+  def Taken() -> MetricGroup:
+    br = Event("ex_ret_brn_tkn")
+    br_m_tk = Event("ex_ret_brn_tkn_misp")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    misp_r = d_ratio(br_m_tk, br)
+    return MetricGroup("br_taken", [
+        Metric("br_taken_retired",
+               "The number of taken branches that were retired per second.",
+               br_r, "insn/s"),
+        Metric(
+            "br_taken_mispred",
+            "The number of retired taken branch instructions that were "
+            "mispredicted as a percentage of all taken branches.", misp_r,
+            "100%"),
+        Metric(
+            "br_taken_insn_between_branches",
+            "The number of instructions divided by the number of taken branches.",
+            ins_r, "insn"),
+    ])
+
+  def Conditional() -> Optional[MetricGroup]:
+    br = Event("ex_ret_cond")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+
+    metrics = [
+        Metric("br_cond_retired", "Retired conditional branch instructions.",
+               br_r, "insn/s"),
+        Metric("br_cond_insn_between_branches",
+               "The number of instructions divided by the number of conditional "
+               "branches.", ins_r, "insn"),
+    ]
+    if zen_model == 2:
+      br_m_cond = Event("ex_ret_cond_misp")
+      misp_r = d_ratio(br_m_cond, br)
+      metrics += [
+          Metric("br_cond_mispred",
+                 "Retired conditional branch instructions mispredicted as a "
+                 "percentage of all conditional branches.", misp_r, "100%"),
+      ]
+
+    return MetricGroup("br_cond", metrics)
+
+  def Fused() -> MetricGroup:
+    br = Event("ex_ret_fused_instr", "ex_ret_fus_brnch_inst")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    return MetricGroup("br_cond", [
+        Metric("br_fused_retired",
+               "Retired fused branch instructions per second.", br_r, "insn/s"),
+        Metric(
+            "br_fused_insn_between_branches",
+            "The number of instructions divided by the number of fused "
+            "branches.", ins_r, "insn"),
+    ])
+
+  def Far() -> MetricGroup:
+    br = Event("ex_ret_brn_far")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    return MetricGroup("br_far", [
+        Metric("br_far_retired", "Retired far control transfers per second.",
+               br_r, "insn/s"),
+        Metric(
+            "br_far_insn_between_branches",
+            "The number of instructions divided by the number of far branches.",
+            ins_r, "insn"),
+    ])
+
+  return MetricGroup("br", [Total(), Taken(), Conditional(), Fused(), Far()],
+                     description="breakdown of retired branch instructions")
+
+
 def AmdUpc() -> Metric:
   ops = Event("ex_ret_ops", "ex_ret_cops")
   upc = d_ratio(ops, smt_cycles)
@@ -58,6 +161,7 @@ def Rapl() -> MetricGroup:
                      description="Processor socket power consumption estimates")
 
 all_metrics = MetricGroup("", [
+    AmdBr(),
     AmdUpc(),
     Idle(),
     Rapl(),
-- 
2.44.0.278.ge034bb2e1d-goog

