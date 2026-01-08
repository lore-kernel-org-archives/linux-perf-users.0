Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F33148B2
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899541; cv=none; b=q4hc3cVHOvylnEgE/+2+Y4Z/usrPadOQZslIKaQLED8RsLxAzTKVQHF75FkFAbqea5C9+W1vMrBGWQ16sgR6qMVz5Z2rskt2VTNq/UIs4S7XFgW+/BqpOB/qKZPb7QvNAALCsX5Shj3cjyHrXeU0xut4hv79UqZlOe1xvQ1qyII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899541; c=relaxed/simple;
	bh=iFgxYI8YkDQdRRykiWwbB91svFRxih0jHTs5Ccf/Mo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=b0SgkTuvtTiCK+2YLRco6Z2P5tUqKXNSAAS0QXJaBKeFmmViJYvKTE8sglsctDoUg1fMCozWJA5AdOMg80JOcht34jICyhNcP/Qwqd+S1ZEuVPhvwMY4Oa2Y0X0JCaFQ3BoWgde7KgTV5QJK/OVo70BvjVBBhZ5+OqF1GjTAEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2s0/UX/; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2s0/UX/"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11dd10b03c6so4499375c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899539; x=1768504339; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5NprC8R5leRz2bKlO+oNnE5MEyD18eL1u1cM1xoByk=;
        b=j2s0/UX/glgZNq127iJ6xRRny/9q394oDyspEAzXd1+tFbxcnpCbUXML/Sglcs1SQc
         iKH0Jpbc5ojktYStcpiBo/f+acgwKtobkxjDq6jLdNXbBBxPLC/+DMZoDKVmvaV6h24r
         KfdDuFB6rz426hGMO6Z4ANbReHjeSjdA3URxwDDb1zaZGaWfWxftqve1ZiRcERSlvhzD
         7mQHS5CNOhZptzBiX0rOgQBNIFELBt55QUZiZR5PED2OdY+KzDoB8QQ/ovIZTxDT3+eE
         hKK+BUywqwjdQi1ywVzYpX+xvjPSknWF0ThiIJ6g81LrBKnruBJx0HiS4uWoAaz29UbF
         ulXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899539; x=1768504339;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5NprC8R5leRz2bKlO+oNnE5MEyD18eL1u1cM1xoByk=;
        b=DN+cnut5Cow59cNsjkwp4AmNSL+EgiMeQlLLh/4b/FKn5gt1reCge9vomps6jzVuV/
         I5ArCMHqkerUa3AWeS9Hwjd4eISm/cn6X/4O+hL0auiYqwmHJfGoqnrEB+3EdBZoxnFr
         UOw9uIr23f4cE1xbPFpc3UcAl2u0/+3Nq0vAk8RZCg3R25iJHApsaTGBlBE0Hx4XgQBo
         TvHqOyG0zWBJ+EdYCzBDmmvysYMx1meKk/1658YWyUubwUH0vjerIyU4CQeAelUjRhHk
         /F4o6kH+Cqf0I/kIOCKVmeFLF05HgJ7NCE6FIQ4AIlvqOLMc6y3f/dcngePZuxjniSNU
         SDIA==
X-Forwarded-Encrypted: i=1; AJvYcCUUIgTkNxS92PxMVYX/dvxo3HoOyRCR9W0gs4/12S+MHC5ahv6Rvv/5xDbMwxIqQoGha/QSDsOA9uMVcWyxRj9i@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ldKGgkm6yO0PQsOfz9Z/OJg72MXNtr2E4YVVhti5nX0+FcEh
	5iCkeS1DHm0UJRZImD0FF/nM02P6l8UYMzjr7GCzAHlCJZBG18FVhWVDXA1zGsvZHyU9QPEHQbr
	hZ1pc9Y03Xw==
X-Google-Smtp-Source: AGHT+IHssv1lJq+ZRAgChOEAZYIXFLkt1Jz/1FBVXh/Ql/90xsmBTYzTMcMzs2V6vrwMNahyuFzfmMachatY
X-Received: from dll38.prod.google.com ([2002:a05:7022:226:b0:119:78ff:fe0f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6188:b0:119:e569:f620
 with SMTP id a92af1059eb24-121f8b7a9d1mr7194267c88.25.1767899538693; Thu, 08
 Jan 2026 11:12:18 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:58 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-29-irogers@google.com>
Subject: [PATCH v10 28/35] perf jevents: Add local/remote "mem" breakdown
 metrics for Intel
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

Breakdown local and remote memory bandwidth, read and writes. The
implementation uses the HA and CHA PMUs present in server models
broadwellde, broadwellx cascadelakex, emeraldrapids, haswellx,
icelakex, ivytown, sapphirerapids and skylakex.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f671d6e4fd67..983e5021f3d3 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -815,6 +815,36 @@ def IntelLdSt() -> Optional[MetricGroup]:
     ], description="Breakdown of load/store instructions")
 
 
+def UncoreMem() -> Optional[MetricGroup]:
+    try:
+        loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL",
+                        "UNC_H_REQUESTS.READS_LOCAL")
+        rem_rds = Event("UNC_CHA_REQUESTS.READS_REMOTE",
+                        "UNC_H_REQUESTS.READS_REMOTE")
+        loc_wrs = Event("UNC_CHA_REQUESTS.WRITES_LOCAL",
+                        "UNC_H_REQUESTS.WRITES_LOCAL")
+        rem_wrs = Event("UNC_CHA_REQUESTS.WRITES_REMOTE",
+                        "UNC_H_REQUESTS.WRITES_REMOTE")
+    except:
+        return None
+
+    scale = 64 / 1_000_000
+    return MetricGroup("lpm_mem", [
+        MetricGroup("lpm_mem_local", [
+            Metric("lpm_mem_local_read", "Local memory read bandwidth not including directory updates",
+                   d_ratio(loc_rds, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_local_write", "Local memory write bandwidth not including directory updates",
+                   d_ratio(loc_wrs, interval_sec), f"{scale}MB/s"),
+        ]),
+        MetricGroup("lpm_mem_remote", [
+            Metric("lpm_mem_remote_read", "Remote memory read bandwidth not including directory updates",
+                   d_ratio(rem_rds, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_remote_write", "Remote memory write bandwidth not including directory updates",
+                   d_ratio(rem_wrs, interval_sec), f"{scale}MB/s"),
+        ]),
+    ], description="Memory Bandwidth breakdown local vs. remote (remote requests in). directory updates not included")
+
+
 def UncoreMemBw() -> Optional[MetricGroup]:
     mem_events = []
     try:
@@ -914,6 +944,7 @@ def main() -> None:
         IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
+        UncoreMem(),
         UncoreMemBw(),
     ])
 
-- 
2.52.0.457.g6b5491de43-goog

