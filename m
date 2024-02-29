Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05DF5F47A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165946; cv=none; b=etHtAGi4LMttnOrRHKuHS81tpvI3toY6jHuXIZUS5FeuFJ5hC3dYKsqzkwWuW+vetH3ScU/LmzGjjF3XsBl0Wo/S2EeqLXSGHvCaUrvzoIwNRSfJ7JkzQoahOLOTyXGZIAW3ljOQsdWZeVjg619NQwuyKirrW5F2Hcp9rYB3lyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165946; c=relaxed/simple;
	bh=xlzja/1NTHsdXbKI9l/ne67VG4rMNc4Dj/LOyY65h08=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DPcgMhLTiBYg1iNEm0QtwaByzAskCI/ahhMUGN8CRgq7J0/olvw2MFoReLtww+yBP39nLU2QCSXjg+JdXGT7Gj8gVOQVnW5gSeAAgGnwOaNO+j7H5RG7xHmnnCrsaHtLJ0uauvQsmN3UyWjZj8V+HdiWaddVFj4qReFPq4JuUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OB3v5o4y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OB3v5o4y"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608e4171382so4781867b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165944; x=1709770744; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBmMTFqHwHtPnnqhBPb22111ik/LzYAYuMu6eaqCRZo=;
        b=OB3v5o4ycIEF9dUEtS6bl03w8Fd6HEcJX4aemqEEA5Gfu4miFOPsn9g8E76Pjbrk7J
         viGr0gf6mrtt/3kpKjxtm2GSFrZcxPlp1ODukd1s8IzLahNajZfYKzTMCpAyWpnk4O01
         /B2sF1e0kDQEMhEGjArzAzNE6EoMZddtFRMxgaOBFAdntDdPqnA1XYcW7u8jw1cWb+ee
         wrYqvFczuMppXnEScALhCF/dfyXzBR0LVuDmd4X3SeXPQaVNhd9LtCrF7wT/u4HfF2Jo
         9Ssjluq52IsZGrO1UM9fuIIg7nhPoF21jN8VWlBedL+21PIEKb0lfQd7cp5FlYwkvG0m
         PsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165944; x=1709770744;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBmMTFqHwHtPnnqhBPb22111ik/LzYAYuMu6eaqCRZo=;
        b=EM9w3nv/VaibdC3+YqxuxZNC8MH/bFtpvK+RwjeqNwmN8HOLQHIEuiOWvUTQ6iP0F0
         wbWn6BPsd4XxRCXRgzGvd4gvjZQVf4X92fD37B18wq07yvaG5TRIYDmuJ7zWgelDNJKt
         rvCXqdGdcTWA+EU10KOKwQmT4Qd3tyNnvuGDquOy7oD3gTOSi/jaEfZcupKuPvwYoHV2
         e4nbQ+vOQp+PjKf24WiCJO84X2xnqAAbwl+6kv5Bs0Qu/F4DifrbYUzNktJ24MGkKhpQ
         mTECYk4PFPcXvlMrFc8wZlq0ekNRXUJNYJrvCu3ZWDBtIbUXFQFbPPXpaBlILuExuVy7
         BkVg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Cc2cEeiu0WQ1rE1shohyhqozXWD7ri1+kXsVEf4Qa43H40tbf9Q5EtbcFnulqXW3m9PPG6igHN+CfV4K6DP8bzFksW+UjxVZ9U4aLG4acw==
X-Gm-Message-State: AOJu0YyakvtqdknLeXa4kIfEU25nknOdn4bkg8rMz9hS2LyHB6Fa/y4b
	4H395z/zxx5l4zBGnYsUGZSS8Whe9Ve2OhYJ1WBe6H9j5uBCVSi1p+ez3rfMrUDP/Fh4S/ZFnDW
	rzqmkMQ==
X-Google-Smtp-Source: AGHT+IHCDdO9dFzWK3In6vqUH2OND0Fpp0Sp9Y3gyvXw3DO6CgLSy8ApIj8iFIAYm3j9m5+eO7k+MnNbGIqg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a81:9b4c:0:b0:609:51a3:b409 with SMTP id
 s73-20020a819b4c000000b0060951a3b409mr147135ywg.0.1709165943906; Wed, 28 Feb
 2024 16:19:03 -0800 (PST)
Date: Wed, 28 Feb 2024 16:18:02 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 17/20] perf jevents: Add dir breakdown metrics for Intel
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

Breakdown directory hit, misses and requests. The implementation uses
the M2M and CHA PMUs present in server models broadwellde, broadwellx
cascadelakex, emeraldrapids, icelakex, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 82fd23cf5500..07aafdf77f79 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -800,6 +800,41 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreDir() -> Optional[MetricGroup]:
+  try:
+    m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
+    m2m_hits = Event("UNC_M2M_DIRECTORY_HIT.DIRTY_I")
+    # Turn the umask into a ANY rather than DIRTY_I filter.
+    m2m_hits.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_HIT.ANY/"
+    m2m_miss = Event("UNC_M2M_DIRECTORY_MISS.DIRTY_I")
+    # Turn the umask into a ANY rather than DIRTY_I filter.
+    m2m_miss.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_MISS.ANY/"
+    cha_upd = Event("UNC_CHA_DIR_UPDATE.HA")
+    # Turn the umask into a ANY rather than HA filter.
+    cha_upd.name += "/umask=3,name=UNC_CHA_DIR_UPDATE.ANY/"
+  except:
+    return None
+
+  m2m_total = m2m_hits + m2m_miss
+  upd = m2m_upd + cha_upd # in cache lines
+  upd_r = upd / interval_sec
+  look_r = m2m_total / interval_sec
+
+  scale = 64 / 1_000_000 # Cache lines to MB
+  return MetricGroup("dir", [
+      Metric("dir_lookup_rate", "",
+             d_ratio(m2m_total, interval_sec), "requests/s"),
+      Metric("dir_lookup_hits", "",
+             d_ratio(m2m_hits, m2m_total), "100%"),
+      Metric("dir_lookup_misses", "",
+             d_ratio(m2m_miss, m2m_total), "100%"),
+      Metric("dir_update_requests", "",
+             d_ratio(m2m_upd + cha_upd, interval_sec), "requests/s"),
+      Metric("dir_update_bw", "",
+             d_ratio(m2m_upd + cha_upd, interval_sec), f"{scale}MB/s"),
+  ])
+
+
 def UncoreMem() -> Optional[MetricGroup]:
   try:
     loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL", "UNC_H_REQUESTS.READS_LOCAL")
@@ -902,6 +937,7 @@ all_metrics = MetricGroup("", [
     IntelMlp(),
     IntelPorts(),
     IntelSwpf(),
+    UncoreDir(),
     UncoreMem(),
     UncoreMemBw(),
 ])
-- 
2.44.0.278.ge034bb2e1d-goog

