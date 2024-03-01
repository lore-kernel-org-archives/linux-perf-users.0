Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9DB69D20
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319420; cv=none; b=lxI5TSIUevTvoHwzf9dVLTxCGOmCNo8LB94FtfPeRmipMS6QyfHt88HMwlD6QmBnxNKsDH/pqxWlzL/AD631T+Sw1haM19tK2VSFbZhjRVPcDnYuV+40wdvPEZA93WZAf/DVdEl82jFp0nwa9ToCQ9dmbJ0G8F+ZkMSLrGrx6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319420; c=relaxed/simple;
	bh=smAVN/GCgA5/MmqiHaxq1BP/CFOoXWsEkiW9uPTpG1E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pyOnxjy1tpNJXNxLyqQuRV+o4J1mMPLWoceMbU697pKUu45/OHfWrba4PMTJnb4RZorgI/L/TQtyoX9Rru3bhg3Gao0eUrVoStLmKABEWhg9VWmAHuadYqBWO+jaW6IuKnB7iTpajfKasMSPgjMDuAoR96F9Gb4DR0n+zUyzgWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t6G6qI99; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6G6qI99"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60804b369c7so30765337b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319418; x=1709924218; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbLHB0Wrr0NrYcqmEePKnNB9gjFn+6QmEJrv+HDup90=;
        b=t6G6qI99RwYDk8lLd8c+8YQSOw4EvEtnlkSUvumWBJf6eWsWySUW7gl2IylYg5P625
         UfxOxxIPjYv3ViXMhVv5xaw/q9DQ1QNyKz1s9xpGj6lHCATlIJjdd75Cr6d1rxTWaGs1
         r6Xaq9T2JIz3OOit3nDL8KI9z0Q2vPo3XlFRzZ3ilvFW9IxSwrICBFOBjKf3xMhbjx9w
         Fp8k9ARuT+IZi5qENBMRNSKtWNIyRxEdxqCGZvyKUXl99hn0dqmZXDyIFhfAgKZ/SG/b
         0wieEVfPAJ+/R6iRuqgVQEqOdtzuo5T5VfIKkAsnvTOF2y7Ozm/NGPHpNlR3ma6qFxZx
         ZzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319418; x=1709924218;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbLHB0Wrr0NrYcqmEePKnNB9gjFn+6QmEJrv+HDup90=;
        b=QZr5y76lJbjHF+9B/6eI5T2uGX7OLqL+Uzjur08b5UsAPg7oO4CdBXwqgCIvCVVZms
         CSnfIox/++E52E6JiWLaPDKaB13blKLXz7OYdELs8rqriJl2+Ddb9k/L8vAA9qsESKHg
         Zc1R9QKPZIQMF8YuB9ALW26+KlnOTJu/ydyYB8FNtAd6M+qdk0xMb8tLJAVycyM3Blt7
         JYw1mEZ7HqNqKnaWJGC3SwjDjeDlZI/FHOPUp9TCgYyahC9uAesJ1dg/YdPYwrmQXYtS
         RNLOBoBWpOGHDrumYh7akwxO89irsmElihWerahJjO1Duu1yuuH8qEKxtZO59+qr1o9G
         tSpw==
X-Forwarded-Encrypted: i=1; AJvYcCUdPccDERvsUnIeBW+quJcrj+3yP/hSCFkGnCX1PYS5/2bc/DsTrBIeMoe+1Qq+1mOHkF1DCJj3wVwhxyMt2GzuKR9TvzyHgz39NUup5vDp9w==
X-Gm-Message-State: AOJu0YzlJsSVysA7+NN0aPo4MLNohCY3LyFLw4Tn59eXGJYRPaYHmJ90
	lvbHeqbeqfpsZbDQG+Gm6j78O6814f6TZdQLaNuHjr2VIjNZSrineQn5AGCLJrhS+UxqoYTyESO
	pgg0y+A==
X-Google-Smtp-Source: AGHT+IGPaYTWA7DQPmtXyKutHOy7Zf8bDiW6iSVJS0oNgfz+N591zshd8V9MDXT27vNWrKGa9/wDtpZ6/gv5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a81:7908:0:b0:609:2cab:1bd7 with SMTP id
 u8-20020a817908000000b006092cab1bd7mr635579ywc.1.1709319418022; Fri, 01 Mar
 2024 10:56:58 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:57 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 18/20] perf jevents: Add C-State metrics from the PCU PMU
 for Intel
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

Use occupancy events fixed in:
https://lore.kernel.org/lkml/20240226201517.3540187-1-irogers@google.com/

Metrics are at the socket level referring to cores, not hyperthreads.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 8086aef3557a..2e076f695292 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -784,6 +784,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
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
+  return MetricGroup("cstate", [
+      Metric("cstate_c0", "C-State cores in C0/C1", d_ratio(c0, pcu_ticks), "cores"),
+      Metric("cstate_c3", "C-State cores in C3", d_ratio(c3, pcu_ticks), "cores"),
+      Metric("cstate_c6", "C-State cores in C6/C7", d_ratio(c6, pcu_ticks), "cores"),
+  ])
+
+
 def UncoreDir() -> Optional[MetricGroup]:
   try:
     m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
@@ -920,6 +946,7 @@ all_metrics = MetricGroup("", [
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
+    UncoreCState(),
     UncoreDir(),
     UncoreMem(),
     UncoreMemBw(),
-- 
2.44.0.278.ge034bb2e1d-goog

