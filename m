Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3515D734
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165943; cv=none; b=cTfWFQkj3jm2EWqAQib6A5u7B+LLc4M6pv4DbrYmsbcomVk4B5HHeDGWB92LeOEpjI2K7ylGkQI076UphlNY3U8JhvAiAoTDQoQnNZ7G6DchioSVTxSPNL3KXNlZXUkMRQt0Vg0ClHvNtHsPqOUtTPOV2j5S3Jd7Bhew1CDJXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165943; c=relaxed/simple;
	bh=fOe0QR0t4OQ65kB5h4f3RSwkpTEtB27EsEiIpAN0gXA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QQ5IgUMSpIE4bkCzB0SIATkwsTyPiHXjUjZnzzPuAbVaAVVJC58YFoSmYDmSzEiOjKPTy20U8kTZ7SnxIs7N1Dqg/mcMlhLOwfi3TwSIBQYasmv/+dw8ShhR97AkdQ5lA6jE/0Mirz25Yt2/nwoV77qfvWaLZrFefBvvqu5nXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eOrbWy3X; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOrbWy3X"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so584810276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165941; x=1709770741; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzyPImOsBkhbJpUz/fKV9tFh3RhaMmxr7x9cFs/2Ci0=;
        b=eOrbWy3XkobnNHUpheVs5/38HAuJR8zepnCXhE/r4dM258Hh/x4RN+U8NGZ1KIUGqa
         +xM0gwnlsHBPBcGpQR8lP9RoQpkEXSXTXOySo1U+0yBZ+WZfbLGREJtZ2GM5isW8KPqa
         6Yoz3BCNwnMWjOChFYnQaC4mjqAum9Wz4UBVXIn58OpigW9jEV04Cij68ggi3TsUYt0A
         s+3Cg3TxSQwRDilCbMwft/uK50FIuf2iDnqFx+k1nAZv3WOi4rSy9BVu5fP66tFnZsAu
         lnRQxMTaGJ391NtjU0LNbp+NntkxH0TPG9huEv9oMASKbeDN6O3KHzH5gPq7ZKRR7smE
         K8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165941; x=1709770741;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzyPImOsBkhbJpUz/fKV9tFh3RhaMmxr7x9cFs/2Ci0=;
        b=e3KAYZjc5lRZZTADImkkUwIrHAYgJjBMMIkFwNy0SN3GplNXh7gTNjVPibIqdSOCIs
         h1vlZEuicSfgUwPrUf71+g5iFZsFxHA4DD0mIioc21bW50umB1L/woAGVfH0qsfj84rl
         DRKdAQsQD7uJNFfTbootLB9roVDUZivfMaTH1Gwof8SKjE1nwSKiyrS+ju3of1Ydi1zK
         hRcxKuO1Fy3MUNesxWjBC0MxssbpY1nVCZW4HHbL1HPRDcl3Oyuu/o838mtLLd2UFXSH
         ZlFz5jBKDKIDKjgK58SJqkvHJfCiaGt6KPEfmxr6LJtQr6vo3HKFys9QtzwVfZyBD3JN
         pU6w==
X-Forwarded-Encrypted: i=1; AJvYcCW64SwzvddhgBJKK9/VZ00dAzd5yGoMdf16twPme7nuiyKLwaFOPJxpTXK/M0q8SX6UGoJ5sTLBNlSoEIoMcreIGrFZAoJX3He9r0Rc5e6w5g==
X-Gm-Message-State: AOJu0YxITo4tvNC5kb44XpUnnSVx4LPEuzHAJJWfzkUuCpZTlVNRZVzj
	iX9nDwMmjzmklhQceqiGt+orkokEQ9KjFg9DVitix2VC73g/LR7NUFfsr7SONKpbxQn9QD75uKp
	Ck/1l5w==
X-Google-Smtp-Source: AGHT+IEVS8gW8zIntOpNBjyl59fNAzTOBz14U9enaTIw+HW7zVKv/3puDP01JMib5kEznj873PCq4xWf+k8O
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:d45:b0:dc7:5c0d:f177 with SMTP id
 cs5-20020a0569020d4500b00dc75c0df177mr193731ybb.6.1709165941515; Wed, 28 Feb
 2024 16:19:01 -0800 (PST)
Date: Wed, 28 Feb 2024 16:18:01 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 16/20] perf jevents: Add local/remote "mem" breakdown
 metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
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

Breakdown local and remote memory bandwidth, read and writes. The
implementation uses the HA and CHA PMUs present in server models
broadwellde, broadwellx cascadelakex, emeraldrapids, haswellx,
icelakex, ivytown, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 8d02be83b491..82fd23cf5500 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -800,6 +800,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreMem() -> Optional[MetricGroup]:
+  try:
+    loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL", "UNC_H_REQUESTS.READS_LOCAL")
+    rem_rds = Event("UNC_CHA_REQUESTS.READS_REMOTE", "UNC_H_REQUESTS.READS_REMOTE")
+    loc_wrs = Event("UNC_CHA_REQUESTS.WRITES_LOCAL", "UNC_H_REQUESTS.WRITES_LOCAL")
+    rem_wrs = Event("UNC_CHA_REQUESTS.WRITES_REMOTE", "UNC_H_REQUESTS.WRITES_REMOTE")
+  except:
+    return None
+
+  scale = 64 / 1_000_000
+  return MetricGroup("mem", [
+      MetricGroup("mem_local", [
+          Metric("mem_local_read", "Local memory read bandwidth not including directory updates",
+                 d_ratio(loc_rds, interval_sec), f"{scale}MB/s"),
+          Metric("mem_local_write", "Local memory write bandwidth not including directory updates",
+                 d_ratio(loc_wrs, interval_sec), f"{scale}MB/s"),
+      ]),
+      MetricGroup("mem_remote", [
+          Metric("mem_remote_read", "Remote memory read bandwidth not including directory updates",
+                 d_ratio(rem_rds, interval_sec), f"{scale}MB/s"),
+          Metric("mem_remote_write", "Remote memory write bandwidth not including directory updates",
+                 d_ratio(rem_wrs, interval_sec), f"{scale}MB/s"),
+      ]),
+  ], description = "Memory Bandwidth breakdown local vs. remote (remote requests in). directory updates not included")
+
+
 def UncoreMemBw() -> Optional[MetricGroup]:
   mem_events = []
   try:
@@ -876,6 +902,7 @@ all_metrics = MetricGroup("", [
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
+    UncoreMem(),
     UncoreMemBw(),
 ])
 
-- 
2.44.0.278.ge034bb2e1d-goog

