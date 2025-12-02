Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9F2E54CC
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698066; cv=none; b=HcI3JSADn7jK2qngm1qIO0/AoJqKhwXRh2XwfHgq5hMdVeRKjVWID9diUSlGX9GqUMVJtFewhH6G19jiwrgDajDEMi+jJ7M6YAM7wbIKNPR/jvvhRWOwqkX3pkI01O/j3d2EQCnQUBZleUsHCzbpEEZfphddFQbcgVSiWl3iYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698066; c=relaxed/simple;
	bh=DFB/FEt17GQJ+JkWYN3jloDSMAG1wUOHoceC5d8yzJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QW0fqvq2MTDETJSk8zz1Zga55igp8eMP2MtZ3xEZuXZdJ2dhYxUbsmzvLJf6zK/aoyy5FckWBHBiew+qtM3P9faOcndFDyVQqWOmWJ+h2Gzw/tUyTsB68Xt1jBC3ipgZooL7SdrBiGPrSTyM2gCSt7t0GA5mC8yM5gr86wosTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Znwu8fJv; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Znwu8fJv"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b969f3f5bb1so8323242a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698064; x=1765302864; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVYfJzXARSKLsQJ3BHueI5NPWshXYIemLwtLligKoO4=;
        b=Znwu8fJvnjdsfG3TB5BsLJVYBP4Pte2QtINO6AlNl5/0iDsYOIW4XAdR/sSziPDHMz
         q+OYFjJXtxl1AikWf088xdwVKyjJt/yR5FXUB2+twbu6XtSAyf9qNMOO4HnmMataTQza
         1JJSJTIMYC1/0UGry25KlBHsjl0cqD6XNErg6j3qn6CjoZjJOSBdELMTwzcZhaZtI83B
         dxxu13oOk9eq1jgwJvUcqBX71ApFVqw+IaE9Bvq1ge67S0vbge3sRO1a17C9QZiSV+JE
         LsBHtBXeV/GkeseW3j7AoFhUX94QhzJrJs5BoW4V8GRskLNVnDWqzz0uIurtdVmRMQl/
         5Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698064; x=1765302864;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVYfJzXARSKLsQJ3BHueI5NPWshXYIemLwtLligKoO4=;
        b=dRmxm0lhc7XbrCLnYXcH8qU1/OYTrtOmNAeue3mPtDm/fA+dn7/eZIFGC82CjFDoV4
         5efYmqAI1SezsNAOPPVadjaQlsqPVEVZcR2jGXPwaB7yA9tqnzSJxF9xzt/KT7kZDgOA
         EGo0/5EIRE9cRN8EvQDoTNze+TtAuiKefF6a4/pYvj2i6FQUdSYjNkGKDPj7Jl5k68WJ
         i4P7KOFpIXh6k+PNCD8vjxc1/Y3fck0/oUOEwAtu8tE5VEs6aajS/fxJ4BSPul+mRhf7
         NlMVuMwZRSeX9CyfsSi1fTUtJbukRdXjJjGk0z7H/2Qu0U2q6m854If6yPSs4NPL/gJs
         Br4w==
X-Forwarded-Encrypted: i=1; AJvYcCXml4ohDzH3hseZ4BZ+cO3qnh/rX7m03qwJZF8HZ7cwYUICyiMBNoT5Lq3a8VAaABY4sdi1WfBgwdHSsINiW3zn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9cGX/i+hTxx/l0F9hUAlLikBn9Z14JUG1xo+KDlhxU/UxItc5
	Q8XfjRKj8K83twh3Hs6NLoadz/mA2RKZV7j6mAbJ1dcYaymgOkVbVI6wWDLjryXR1U3Ta0XOEw4
	iycOkKB8YAQ==
X-Google-Smtp-Source: AGHT+IGNJWX2dv4aY45NTWL60AK3Uju57c+XfU19nkoreqO82slcZQsfMfm8Qv81FLYtKO9fyaIgM3tglOrD
X-Received: from dybgl36.prod.google.com ([2002:a05:7300:e024:b0:2a4:61a6:6c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5413:b0:2a4:3593:c7cb
 with SMTP id 5a478bee46e88-2ab8fa8ca3dmr163971eec.11.1764698063680; Tue, 02
 Dec 2025 09:54:23 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:35 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-41-irogers@google.com>
Subject: [PATCH v9 40/48] perf jevents: Add local/remote "mem" breakdown
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

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

