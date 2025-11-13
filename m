Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD531B100
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004140; cv=none; b=nlfnqUUGrSuWkKjdYzzM2JJjcF1qlbMmFix8NjkPYeJ9lAPNiXqCVOcyZUWC+pKjrEquH2cjENkEuQi8sZCRfnrOwZiV9ozx6Q0dcpoFiNFXVSOU7JWjKsvwP6FYK9UHl72mfwe8htU7EQG5QgwxFNS1LiPHWKrVW943ahH8N+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004140; c=relaxed/simple;
	bh=lXLTlXYkMozj3jIiw3KIl1Ckfzke53CA+5xZr5zxW48=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Kvdj13P6ipjsaHxQifDJj+dJNlnMjMRcP5nEGihl3Aw3aEaxF0MYTp5+JwUkYROp9HO7kidp5loIwagtq4lLwfbyxIW73Z05PvgPrWKMbmez8EJHzT40PmCFCEUalch1I37HQ7zKWvsTKr3dsQALHZt879bSZTcsRFQgAoV6TQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kwe7uTNW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kwe7uTNW"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297fbfb4e53so6660445ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004138; x=1763608938; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0TucWF4PwieCGC/x8w64I5/j2ZTqiIY9tNTYUgbMZpY=;
        b=Kwe7uTNWIou97R5PBN3NLxl0JoZkrtzGlCCHrlsbt6WSM0OwhmhIHF1w5ftPJSv0xV
         6nmFLnmsvPQE425ABoUo6eSnpMmVjDm7DU5SynHo82UFiZMHQVHKhK3YNTPB+iDvyhQY
         mBrzu9FbyoEwD4u7XCpJUrIjlzaqb2wwcI5st8HsEtbxrTFbgMk98JoYf93l2t4ddtTF
         7qNRmoa/Q6Jvz2bZNQnIHP2IVwARakvOKTsFnFEQR4Ux1qpDN2QRRx7HVZBC662O2MrT
         Y9zpnOEbTx7EgpFISkYTEIcxkSMifZdWtx5VfmmXOdjanPNVI1NegcYuy3v3BlMVB2SG
         5pEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004138; x=1763608938;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TucWF4PwieCGC/x8w64I5/j2ZTqiIY9tNTYUgbMZpY=;
        b=gE/Ics2l1by3QaySl+fI6OiUT2btdy4Ve6MyHSbBMwOPdRROli4gF5nFkzMzmaVQap
         jmmjMFnGpxXQ5Z5y3fJeexXew1EFtUxJeyB1RUvx/03ICaGCZhHeZX7DsOpIkHDZUO9g
         Mpz9OYU6AiNtYveTqln/r49SeTmf9GrVGmFdHXqXd/7Z5BgyA6Bcc86iBGDNfbwMdtL7
         So8cTxpT4Xq3TLo4982+n/R6wKBLz9fE2GLM4p2oeOqcbDyDq+JdcJ0gUbbT4P6ETUOK
         EGuJoVVrsyQA7+PmzQgu9DpGmE707TI7B4hoUZTnhXpnChHOA1tlDoeeohioRCsNPQw+
         /MkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2QHqa3RS3sAmYJ7YCsGV2sPLai28YPebBD0mxWRSyoRAiTV8udP8sSXWsz0qqENQ6nPH/JzksTt1sfH1rDLbt@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBwM969RtK6OwYLdTLIj3FiBIEoeq1IL/nZzgj/c3eQ7NsVxN
	0kIXe4uhViq5iPijTX3NMqHWjl1r3+mFQHZxV5ycFjiWeqVS6FWSqjVtzYKdpqv3I21Gqa2RrAV
	VG8Chl20liA==
X-Google-Smtp-Source: AGHT+IHysAQYHS4kPNj5jjWLgGYrrdQwUGr7MM5sKTK0QIrvTOQJTaMMXJXEMFACThC+ZwyCdZ0XiPQKIkBc
X-Received: from dldoa11.prod.google.com ([2002:a05:701a:ca8b:b0:119:b185:ea75])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19ee:b0:276:d3e:6844
 with SMTP id d9443c01a7336-2984edc8ea9mr64852155ad.33.1763004137979; Wed, 12
 Nov 2025 19:22:17 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:32 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-45-irogers@google.com>
Subject: [PATCH v8 44/52] perf jevents: Add local/remote "mem" breakdown
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
2.51.2.1041.gc1ab5b90ca-goog

