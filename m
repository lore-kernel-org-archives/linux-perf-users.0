Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB2117756
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396014; cv=none; b=WayCp+PJW+pdJhNrPZDzFLbIZTfqNQSLnFC111MeOmuNBswzLFW3ioaJGIJFe/ddbOfPouhyaRGYmrH6B1r7PhRfqpkjGjIpC2KVA+8OnYLHtvCfiVaRPzpEw+UwaFVyh+yDJ8EMJQ6CuCAISLbmUt8JeHqksrsdXGGR7H4I51w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396014; c=relaxed/simple;
	bh=slsQ486FDmV+ZxtCxqAbpTjZ7e+5jcmyOmviohPSGHw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=vGs52C+8cWYL9fnbnYwh6Besm+bwmUEJ/NnNFfMURkaCqgL89SlN6FzqaqT5LyeDZ2ctYO+ZmnQGIy/vfAAAhy3YqBy+v98jFUFwPqcPrQUKdLt4vPXip3HRtoiGTjfSZZPKHwzq9PUU2BREbgkOxgkEatXObS1qfDLM6CVPbuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2774U4L; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2774U4L"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609f2920b53so10462447b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 23:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710396012; x=1711000812; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oiroQH+MCh0YtGdpUEh3/X3CQ0/YTeWJYjgikZKNUY4=;
        b=B2774U4L4HCRIePlS+y/OPKxfEeWLGxyQSKiA5oWPYv9k5CP6a5w0A9B3gGsMJKdet
         n/FC+RVUS+tOE7eM4bhEpzt/cBGhfo9lSSEUVAhjJxCBEwadKcwVobEsefd8zjQleGIC
         1UHVF/u1dMYSA5hqkcad/aoOQhkpNVF4VqDrNQ3dV1gQ9EhW/mwF5N7KpiBnachbWqwi
         QvDqU0V66kU4JvYR1F3ZcH/ii1qlYNB84Az6GU224O186qFOD7RituPi84mQ7NBli6We
         6E84yZo6sDu06Kowf+6aDxy32PkeJJ93QFBJR0Ko60V94ofsRtWqq2m3u/by5zhQelA8
         WPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710396012; x=1711000812;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiroQH+MCh0YtGdpUEh3/X3CQ0/YTeWJYjgikZKNUY4=;
        b=QuHSmq/VtTs3s/Mt3KtPnsEzGrbIK+/+8ow1AB7ZJf1xoFsA3CcPRvy8GlNmmILOZ9
         51xQjrzh9/kqDHEYqkqpmGoIraTY3ypxE2Dee48dOw8H3rASwc2Gn+etfB7tyCZ6Hb8c
         CSlz//jMKYWrtJdqDhVLRzS1yn2USE9Zjb/8ZZsMNhKA5/KV3FWDQEDREE7LPaHfaZFN
         +O466tCvMymy/61b02Hpfo1x1zd33hyBF1S+q7RVyElC4VhAdcoU5P4QRrvoB0KP4rEZ
         wqpdF3dAb5Tk6qYcIPtdcac0G9Z+Dwa4lTjXVReFccCTKlpDe0s6x87je7FIrKxdc6rJ
         tCkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrXKg8/g7JX/9W1QDnoSVjBe20ddCBJmp/Z7biLRcZDhFU0S7uRA9lNcGJdAJg5NsXw0Aez0neAxgZh3ZgBpTxfcS8yYBP+AHPUnHP/C+FJQ==
X-Gm-Message-State: AOJu0YxQuhPm1gZ7uiJMJTeCfWg4TbQMCRy0obwca8oFrtFevf/xloBg
	XRpy2CAChvlUw/qX8tNYJIZmDkk03vgxDRHnn0Nf92h8qaAa8re3HzFdcZhiYh75DFikMWkC3Mq
	ZjW5LsA==
X-Google-Smtp-Source: AGHT+IEBOHkXOSZG2uOqq0iESlfzDouCBFleNoS96ZHpCr1eVUtAUfnBTxPymOArK82g0zZQIQu2G4azM8HM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a81:4ed3:0:b0:60a:5d76:a875 with SMTP id
 c202-20020a814ed3000000b0060a5d76a875mr126603ywb.5.1710396012545; Wed, 13 Mar
 2024 23:00:12 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:16 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 17/20] perf jevents: Add dir breakdown metrics for Intel
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

Breakdown directory hit, misses and requests. The implementation uses
the M2M and CHA PMUs present in server models broadwellde, broadwellx
cascadelakex, emeraldrapids, icelakex, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 254a4e73d926..0e3ead0fa0b1 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -777,6 +777,41 @@ def IntelLdSt() -> Optional[MetricGroup]:
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
@@ -900,6 +935,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
   ])
-- 
2.44.0.278.ge034bb2e1d-goog

