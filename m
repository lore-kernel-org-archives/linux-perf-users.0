Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29B94CB3D
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319415; cv=none; b=NMKIIuii+ajmDi7Rq9zk2iBIDuxFhBB4PqBdgqZsrX3eJkuFsA323I8+ReNXtR5h+vPCfCYdq8rCmY+YEwlDjo1pZaNcvfXZcq+BG2fpolNMIsxfetq3TkT0MFOFiDlSZS1lZPKZEQnLSVLBIJ1Ul6HXTu4w8SUYtUKqwZJNeFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319415; c=relaxed/simple;
	bh=zsfAdzqNvQWvzalFsOpTfd82DF9L2jXbTJgB7wNHPc8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=M6IuXzAOTiHp72q10cm7qIZ385ElXbrB677psIkHU2rL65tgtgtLA+q2Y4TSCTf0PBcPg+duCcuCp6QaEvO5fXBhdg8aKEGnr9br5xWuvREuUm+UdM38T/wf+3aXoXutrfxoYx3PY8Rd5Q0jb0YUptSRZ1aHx0cJfs3EwYCM4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+yRUIUF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+yRUIUF"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60987370f06so9890197b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319413; x=1709924213; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDxjwfTbKIrn1N686Z4rZ9XKDC8dsWniG1Tg4NyRgEw=;
        b=a+yRUIUFKsAJv/B0w7AxZau5Xx1UytXkK3u0j2iJROfZs1+V3G+S10phf/n8yUEwr3
         n2b0hUq5oOZ7Zs+63zWKb4yDHlEq5VfCtvh+8tYh5DeD+0OBVPDckcfzh2eXIIAUEzGx
         +apCXwgzOwPjSJjWBva0cHRi1Xa/aJfO7kQ2rlp+uKgZep+RQZUOtXZVlaygx3pKF9p7
         oLZ6TUoVukkNBsQ2g3LTcYJQeE4I7B42INvCUaCNtUrAZ0y+l1EiV6zYlgdCx1nLnqmL
         FT52innv/qBw6UuIfj5ViVtl6Lc8m4iaI4A3dvgFoP3SSR19XauY/+MYos9oOPcW1gdg
         Orag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319413; x=1709924213;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDxjwfTbKIrn1N686Z4rZ9XKDC8dsWniG1Tg4NyRgEw=;
        b=e/ABlY3Qu6PcQt5K9dbpyY/LFBLolIGzCb9E6exTHDonQsftRj/HiKxDXzpw7a/mmo
         gUx6ay+NE9BGdGB9pcdh1EBVTK5KsAO9YnoaWigskq3BRilqygF0skm9XfoqjpCDv9IR
         BbFpt16oiXMxnMyVlibk2yVJH2u/wwHidTy2ushjQ1wVcJd6FjJdiLmKyfRNDQra5jV5
         o/JpjS1mxdtjyTE3dVQUrgb9MK4KcYGYthXaZSN///U9vxHnhhqJuN8Is4ueGHH6cvVZ
         ZNuRLiGSCbJB76OP4i5Hp5hqSWnLnlOVJHy0LQw5vBhdgHagcfS4yMmEhQaHPOVYmjnU
         K5wA==
X-Forwarded-Encrypted: i=1; AJvYcCVETIpTU2qhGpiSrdI70ZmtN9IpSUOMgHRboGrO2QMlYKmMdVK1aXruvh8tj4FqEEXA85JoTww3oyu6UsVoudjvwCHsHvkvx1QnxEIVFnXssA==
X-Gm-Message-State: AOJu0YyTlJ5CKJ2MJVD9rvCPqzaIsxjHmkZ9gIBmuXqhxPDLiHer4p/V
	yupcjVD72G3zImTe8zhezHIAkICJFx00P3ruiiYDYjKrTO4QiizKdY14agB8pnl/0FB3xEDfmMp
	LW55UoA==
X-Google-Smtp-Source: AGHT+IFcTTyu5RZjJnXeSWT6rp6vToR2nFN5tVjEEa509a6ZpN8KHnYfYnzjmWPK8VsMEIHdXXVBxXALr2ZT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a81:9a05:0:b0:608:2ad5:cd28 with SMTP id
 r5-20020a819a05000000b006082ad5cd28mr464509ywg.4.1709319413260; Fri, 01 Mar
 2024 10:56:53 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:55 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 16/20] perf jevents: Add local/remote "mem" breakdown
 metrics for Intel
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

Breakdown local and remote memory bandwidth, read and writes. The
implementation uses the HA and CHA PMUs present in server models
broadwellde, broadwellx cascadelakex, emeraldrapids, haswellx,
icelakex, ivytown, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index a5d68b7deab3..76e71f11a579 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -784,6 +784,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
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
@@ -859,6 +885,7 @@ all_metrics = MetricGroup("", [
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
+    UncoreMem(),
     UncoreMemBw(),
 ])
 
-- 
2.44.0.278.ge034bb2e1d-goog

