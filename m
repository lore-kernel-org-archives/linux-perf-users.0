Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C27D3D0C1
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318893; cv=none; b=bMaWiBdQsHKAl81/flnb8QbCzEisLn2HW3RI3RcEmxuNijCqj9CBmb4l81N4kR42GO1dT4q2denwyyOfG1J9Rlf9FqkCr3PtCaEklZizuaFQ1lOR9A9uqSUYrHj96LgXx8UIsG4uGLiBCcVxTaC/10DbrZcXPfNoE5tl0ZqC/48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318893; c=relaxed/simple;
	bh=D/pwwQ6dXV1q6dCmwwHAP89kxtCQNH4Hvs09U28fH3I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bdhGKV6N9UgoYXHoBCzJNQDGT01Z1CwUdLrASuA4MJRQrleU2wQXgquR27Dy6ReNQItp9bsTzAA71IHh7U509ELRPfctjR7LxkmR1iOhJZ+c7S72Sm3hgLMLaybhYlpL6gSzgnvzXc0fSDT8wwA78jjXavQmXiErCVnoVhpSCHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MClWlq8y; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MClWlq8y"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so3077720276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318889; x=1709923689; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=riQkIrg8TOM4HvcpMUBBinltQ/7KCgNPQM/xCcL0170=;
        b=MClWlq8y/bQU6H1OOaWHyivNZhpJWu4W3rSpyHfIwhAkmT8lh1FUBHAKU4vaybXo1/
         tKFkCLq65yFP0YRkyf1pPiYsE8hJD7aGOykAiFwQPPI5qsvmEUqvDgJvrQLrgJAathVJ
         DUNR3LaMMEvtLetZUkjCzol7Padal//yzJZrIba/jgxmhoj8raLKMpo225lUGsdVaQSL
         fOARpAfXiy9M4ZdI6bSfERHisEp7ulOQzO+IeA39AnpKlnnllerDk5GInJuiu3XOYYlv
         1XxGv/9wg3vfh/HjklDQhH4yzRdk2gDQ2NBloeprx9js/ZND6GrcqftNtw7SNqAHdil4
         7tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318889; x=1709923689;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=riQkIrg8TOM4HvcpMUBBinltQ/7KCgNPQM/xCcL0170=;
        b=Ep6NCbUDSQqp991xjKeUePbbbOoXan1b6X1oI7h5TJZzGILm8rmOVrEpfl2xhiwwEA
         kjTozo6PI2o8iQRhxNdFQOWqll90orv0ujKT6YjyyUSTzsEuougaEKRZcAbNI91AU6Bd
         wnNrD15tKBqzxRM15Lk7BbLE9RcacsFrBYzCPK1t5zViR+A+XUFEerpFRFOHdWfBHDLz
         fgfwiMEry1RjnRCVcNivD5RddEYIiYXqWEC3YrMijA1ZbirjpDlYoqNE9c+pgtQgiEY5
         gRw1GwdZPTOAqTb/+uQ5jgitdNja3ydmkTbq2nToifYr2o9A2Uk3dYhUQH+B6EXR1345
         1d9g==
X-Forwarded-Encrypted: i=1; AJvYcCXTdNr+Cej5VSlXtD81/iFzXt9T/w9zjip86n6CJNl/VRjllW8WNkd8LmHk3z+FeVJ7Iaa2b5GPjnGMlF4dWe7ZHJFuTu4c1MZ+rBhO/FPsQg==
X-Gm-Message-State: AOJu0Yx3EoNmlcV2GLZuwMsWWkNpXAT2YESaficOTTdvkvMfn7TIvGO9
	rpm67q99rizFueLLTsiG7KSuj9zEOirX4OgquTfXinrLiQ8UuNG0/tH6dYbyUxFdEFEwZhcBRWE
	rb26gpg==
X-Google-Smtp-Source: AGHT+IGKl/EimfAxq0j60lx+151fOhkYxKOTMCbSD2ybMldYtk9I3CKI66mul3vhkJIfCM2cttp3HPOtz/H9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1821:b0:dc7:9218:df3b with SMTP
 id cf33-20020a056902182100b00dc79218df3bmr100318ybb.10.1709318889581; Fri, 01
 Mar 2024 10:48:09 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:35 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 10/12] perf jevents: Add load store breakdown metrics ldst
 for AMD
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

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index f4a4ece551ef..6b182a9bbfe5 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -278,6 +278,80 @@ def AmdItlb():
   ], description="Instruction TLB breakdown")
 
 
+def AmdLdSt() -> MetricGroup:
+  ldst_ld = Event("ls_dispatch.ld_dispatch")
+  ldst_st = Event("ls_dispatch.store_dispatch")
+  ldst_ldc1 = Event(f"{ldst_ld}/cmask=1/")
+  ldst_stc1 = Event(f"{ldst_st}/cmask=1/")
+  ldst_ldc2 = Event(f"{ldst_ld}/cmask=2/")
+  ldst_stc2 = Event(f"{ldst_st}/cmask=2/")
+  ldst_ldc3 = Event(f"{ldst_ld}/cmask=3/")
+  ldst_stc3 = Event(f"{ldst_st}/cmask=3/")
+  ldst_cyc = Event("ls_not_halted_cyc")
+
+  ld_rate = d_ratio(ldst_ld, interval_sec)
+  st_rate = d_ratio(ldst_st, interval_sec)
+
+  ld_v1 = max(ldst_ldc1 - ldst_ldc2, 0)
+  ld_v2 = max(ldst_ldc2 - ldst_ldc3, 0)
+  ld_v3 = ldst_ldc3
+
+  st_v1 = max(ldst_stc1 - ldst_stc2, 0)
+  st_v2 = max(ldst_stc2 - ldst_stc3, 0)
+  st_v3 = ldst_stc3
+
+  return MetricGroup("ldst", [
+      MetricGroup("ldst_total", [
+          Metric("ldst_total_ld", "Number of loads dispatched per second.",
+                 ld_rate, "insns/sec"),
+          Metric("ldst_total_st", "Number of stores dispatched per second.",
+                 st_rate, "insns/sec"),
+      ]),
+      MetricGroup("ldst_percent_insn", [
+          Metric("ldst_percent_insn_ld",
+                 "Load instructions as a percentage of all instructions.",
+                 d_ratio(ldst_ld, ins), "100%"),
+          Metric("ldst_percent_insn_st",
+                 "Store instructions as a percentage of all instructions.",
+                 d_ratio(ldst_st, ins), "100%"),
+      ]),
+      MetricGroup("ldst_ret_loads_per_cycle", [
+          Metric(
+              "ldst_ret_loads_per_cycle_1",
+              "Load instructions retiring in 1 cycle as a percentage of all "
+              "unhalted cycles.", d_ratio(ld_v1, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_loads_per_cycle_2",
+              "Load instructions retiring in 2 cycles as a percentage of all "
+              "unhalted cycles.", d_ratio(ld_v2, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_loads_per_cycle_3",
+              "Load instructions retiring in 3 or more cycles as a percentage"
+              "of all unhalted cycles.", d_ratio(ld_v3, ldst_cyc), "100%"),
+      ]),
+      MetricGroup("ldst_ret_stores_per_cycle", [
+          Metric(
+              "ldst_ret_stores_per_cycle_1",
+              "Store instructions retiring in 1 cycle as a percentage of all "
+              "unhalted cycles.", d_ratio(st_v1, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_stores_per_cycle_2",
+              "Store instructions retiring in 2 cycles as a percentage of all "
+              "unhalted cycles.", d_ratio(st_v2, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_stores_per_cycle_3",
+              "Store instructions retiring in 3 or more cycles as a percentage"
+              "of all unhalted cycles.", d_ratio(st_v3, ldst_cyc), "100%"),
+      ]),
+      MetricGroup("ldst_insn_bt", [
+          Metric("ldst_insn_bt_ld", "Number of instructions between loads.",
+                 d_ratio(ins, ldst_ld), "insns"),
+          Metric("ldst_insn_bt_st", "Number of instructions between stores.",
+                 d_ratio(ins, ldst_st), "insns"),
+      ])
+  ], description="Breakdown of load/store instructions")
+
+
 def AmdHwpf():
   """Returns a MetricGroup representing AMD hardware prefetch metrics."""
   if zen_model <= 1:
@@ -488,6 +562,7 @@ all_metrics = MetricGroup("", [
     AmdBr(),
     AmdDtlb(),
     AmdItlb(),
+    AmdLdSt(),
     AmdHwpf(),
     AmdSwpf(),
     AmdUpc(),
-- 
2.44.0.278.ge034bb2e1d-goog

