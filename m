Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3CB25D536
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440724; cv=none; b=CgXrQCFUY/ijG1EsgspQd/Z6s0d8j/sQbIpoSKDSvshDZeSTIAG7rQOPr5X+SKH1f+LA/Dqob71OksQ2vaBzHT0ouQhx48CNrJVoBTmcWpxsllzBHHw3T1/HzjCkc88Jw85tQNp7yu6twVriZOnfksdyVWZ1OZdRbXEMqVqkSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440724; c=relaxed/simple;
	bh=vf9NxO2PinCQQsEd0DvFHj+1PNzNsbqkEiru0ThpODE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=E9UT9yoCCVbRMNiEIMxm3ebgdYDkKKflLSf9kxLLLAwXvOKaZzYLhjREtS6F8NMjSgoVfmyHQS3wg9MiGHK0/VR3RzachRvfimR+7abP1s9fyfzX6fAvSMM/vlLOcpWd5wRAy71r1ixRWGGXAc1hhTXPAuBsZkcV2bCKraqaj4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gaMHmoaw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gaMHmoaw"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24456ebed7bso23236245ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440723; x=1757045523; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0Vli+NKdcmDTDJurkTANCCd4S+V5izlUAV4FqwwqbY=;
        b=gaMHmoawO3bUmbcLMxWJ2nPJQhVn2mYDChy81wU/iMUTduIwCopmz7LOH0Vp2eQrYT
         RDoUsA+89LwP2nkSE4ohkeNzL1M32U68M666GR0ypBMENK9S1GXZloqwsTT0ZRuqOUzk
         k6Mdk64F6i3OmjzGnQjcgsP+OlMMTHaO9ooHl3bUu7qmwytN/aSYC54rzADXI+D7liyt
         xtzUIQ/PQvjNF3d0sIrTX3TpjNORFL4Wrr0Xy/XyODYQeOM+t4QvQK5OPNlDe3QEsJMx
         NS02aMC5wDoZMZPNrU2P7zjqX2Rv1/Zfjn58FAFzIGzdouWT1u3e8QXRTtO2dQUCpf74
         VCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440723; x=1757045523;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0Vli+NKdcmDTDJurkTANCCd4S+V5izlUAV4FqwwqbY=;
        b=qCzEFa/qHBBG9H2op5LU208qywtm0wX57u88WdqAN7rWr9QDb5jAQtc9Ucfdz80zgS
         q9GQbu03K+Z4LgM00GivBHg8wAkib5Mw4wJk4g9dJ7TcLeOLtMasg6MQyrh6XxVwcku6
         RRZ1jDymwgBEoSenagHUlGfYJl1D4GKygxouCKOEN8CKxQjXxbr3MSa2dQYF2gkNoMmE
         XIBGDo3BnBFwdXsKalnFItnLNPFNVYvYmxDx7e0scxu0fF4XJ2sOh+PXvXEo2Su/ZDh4
         vPjYnYI+Lowj5teTqbALhTwDnKqmVitOaUTpIaVyjRddZEVXye+ddbAyPdykPYvLw5i0
         TBlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqhT/bYMD/24HhsE4+PpOKjIkhyBEY8yLsarAcYAN/U4/+PGYal/VrkAEUiLYELEPbSalHYDR8x9uw5Ma4CrHQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+asOAA9/f2Ca5pVCwJdxAR5fbK3jOekvp7umdnXUJiDZwN4nb
	ZOgZ0gsI62jFeZGz17HF8ly9bFZFjoKuu0+afeCq5lkQZE8uQaGHZ1H8XWZ0iGhtjoIxozy7TiP
	C4TPNbr8sBw==
X-Google-Smtp-Source: AGHT+IFQnygiIn/u5drWuyF3c1r5WwGV2aObUmoqamTVxlg1PZliHyd7vXIq2fN1QjU+TK4SnglJL2B5AGcX
X-Received: from pjcc15.prod.google.com ([2002:a17:90b:574f:b0:325:8e70:8d5e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5cc:b0:246:d5b3:6310
 with SMTP id d9443c01a7336-2487539f6b8mr132335905ad.23.1756440722758; Thu, 28
 Aug 2025 21:12:02 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:59 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-19-irogers@google.com>
Subject: [PATCH v5 18/22] perf jevents: Add dir breakdown metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Breakdown directory hit, misses and requests. The implementation uses
the M2M and CHA PMUs present in server models broadwellde, broadwellx
cascadelakex, emeraldrapids, icelakex, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 782bc7f8926b..808e006addda 100755
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
+  return MetricGroup("lpm_dir", [
+      Metric("lpm_dir_lookup_rate", "",
+             d_ratio(m2m_total, interval_sec), "requests/s"),
+      Metric("lpm_dir_lookup_hits", "",
+             d_ratio(m2m_hits, m2m_total), "100%"),
+      Metric("lpm_dir_lookup_misses", "",
+             d_ratio(m2m_miss, m2m_total), "100%"),
+      Metric("lpm_dir_update_requests", "",
+             d_ratio(m2m_upd + cha_upd, interval_sec), "requests/s"),
+      Metric("lpm_dir_update_bw", "",
+             d_ratio(m2m_upd + cha_upd, interval_sec), f"{scale}MB/s"),
+  ])
+
+
 def UncoreMem() -> Optional[MetricGroup]:
   try:
     loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL", "UNC_H_REQUESTS.READS_LOCAL")
@@ -923,6 +958,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
   ])
-- 
2.51.0.318.gd7df087d1a-goog

