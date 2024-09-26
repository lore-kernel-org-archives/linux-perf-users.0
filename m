Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DF188598
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373088; cv=none; b=FpVIEjpGnYoMsN10B6N0xNdd4nU/6lI/WzA4icRNFIsIfkfxBM/6qZ/NFtN1dpQeM/D0eQl3UUwnPqSxdDxYXSJC0LG9twYMdJD7MqJstGDqsbPz7uMPJLf8tL9/bhmFVoTOqLDCX3ofkj4vKUjkaR7/LwgV2Q+/kkbvwyhypP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373088; c=relaxed/simple;
	bh=foXPCyI9uJrt93GKz0k1BW3ly2utLN/4L6ObgiunCuI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=m4azgqiayUvOX7q0oo0PhTtaqezT1lN3k/g2PV7REpHdGmn9NbTuLfO0bJ90G0PqvkuPGRhOUeq4+xXu4k+e5Pa9xZxTyrJiw0UJhoHwLZjHRAxqcHNhLGEPhwBDtpb1yTiP1mdMdq0xBT0kbQGl2Mqygp0bDDlu9AlUPgFLZvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FcCzoFNk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcCzoFNk"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25cc76cae1so1336415276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373086; x=1727977886; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xqwUZ5eUe4iklF8Xk+lZXZRX46OOuvGthrg/T/Zy3Mk=;
        b=FcCzoFNkQyW8ZKPw/Gt/qDnkwuoKtunGmt5okQTyTl9//TlfaN9qU8AU8eFe26j4EJ
         zuuDIxb8tmuCYdWec9rToVZ263IgNHc0U1ze3wSISdH7yp1PxvolcLK3tiM1jL3jlrKh
         MqoZzdRQbzHt8bFw0Sn3N8ooiIutkTWuwbDQBDXOJd+rHk9j8ikXQh+yQ4Kff2DDQJGf
         IGvuCZnHTrOY50CIDeMsibvfKS4HxHf1Xfcxz5MlNq0XB9EgBA41Z07ITFMQgQTboAVa
         +ODG/uTl2owpxtp350Ref27hZNXReOmE2fEzeOiNQ8I8bQs7HHcr/i4qRgzcVc2vyKQa
         quCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373086; x=1727977886;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqwUZ5eUe4iklF8Xk+lZXZRX46OOuvGthrg/T/Zy3Mk=;
        b=jtrXoe07wZ1ovw884wdkHG4nX5UGLJs6ATTjYFYB4ILbq4dOsuTXrOXWO5m94/hRoF
         Cijn8qupfMJCIrS379QvdF1vKczC52SSbBcSXXIqMmQX33dZlbYzLBXxhmBUPjVqiiPL
         02sEwWsU4sQQD7uu9pgwyrmBeuKcViwRu5l1Mz/gfvnMFYwHBbRMZkgBjrYfYmHlMc8j
         8K9yNIjhVewnPvqRu1jIFZCvKiZoXBVLJdLx/MME3Fx3mZqozkWuzvMt3orbswN3uQe6
         aLc3rkbvfygChcEzRGWVr0Y9hQighuxK8FZ08l7ykLLcMjj6tPzW9C0KKXeSubzZg7HO
         jT2A==
X-Forwarded-Encrypted: i=1; AJvYcCWCBRZ5i8o0aAAmzvxSLdWhq5s13PUyul65BhLYIJQDFnGPuv/4Mq2laAy9Fc60Z/9W7DEpvjlMxLdvnRHSrjMz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9bMgf44eN+lzxzM1+YDGaDBk7tuq2nDnJ8hj+7OZKxHlPHOJB
	u5xNwwoU0V9Mun8xInmT0Qw0xHUTsneNFQk2Qohi4khssxbpEDgBf9Ylgd8EgNF9gSjBQq3Z2yn
	OBEi6sA==
X-Google-Smtp-Source: AGHT+IFgHj1mWv3ulmIT4mivZPGYAAFQtyIqw+hluK5Yu81t3+mtz7zbOrhohYQVbuo7YHb8sF3VDmH81Xxp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a05:6902:2:b0:e25:e2af:7e7b with SMTP id
 3f1490d57ef6-e25e2b00185mr20989276.0.1727373086533; Thu, 26 Sep 2024 10:51:26
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:31 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 18/22] perf jevents: Add dir breakdown metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Breakdown directory hit, misses and requests. The implementation uses
the M2M and CHA PMUs present in server models broadwellde, broadwellx
cascadelakex, emeraldrapids, icelakex, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 62d504036ba0..77ac048c5451 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -781,6 +781,41 @@ def IntelLdSt() -> Optional[MetricGroup]:
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
@@ -904,6 +939,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
   ])
-- 
2.46.1.824.gd892dcdcdd-goog

