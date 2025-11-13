Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F43043B7
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004079; cv=none; b=tnHGCNxM/PH6QKwCaZsxa8cQwYLl6q1lS6v8+TT+2E0MKCd3q7UUeATVBUDGjVf8H3E6dFf57r/jX78sbeOoNRE6vAkxiDnIrjPl4mJD/3uzrmnY8rGkck7xbJ8W5JfvpUdPEThP4hzxsfTTG3jrmH8rDJn5fPiBQ4/CPZpp9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004079; c=relaxed/simple;
	bh=S1p+yEIWKmlOuwkc2RFrG5ZPvCF6Q3F5ykdkFTvIhxs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oZW10t6PamjXlEiYzQrsugkJRKgVlwxdAnwvVP4wCBxnIqRD4tLL97vcJkyiCttkYGwAXEOjuQvKFKUjNATRNvenihrf5sVr5pNObFrDC0yVfjdoOXaO3ZH0HcjPzl9TK9e5wpfRTn9uf0603jt0D5d0iINLFnlUgmpkgjXnwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzLToy6k; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzLToy6k"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-341661973daso440931a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004077; x=1763608877; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GoM4uSXCA6CGzeSczR6SGCvajUfHPXwjqqeVHJsq28=;
        b=tzLToy6kKlUUsPMs8SmCh07ihCJNDFTaK9wL/IBuRtP88MbGlZFwygc9bkHNYytFDz
         rZreA2Gxj0kGfbf4GnUp495BhncQFR00xqHWTd5NmHzFwBa6eL2CIf+kUGs8DaSxgJ9b
         B9HfjSXeeo8woPu/PAYX+QqQjmEqR3dwFSwF9c9O9+xVWs00feK9dHQ4PgeeKnBU0TcG
         qSaopnr/BTFjbLM3nB8JAq7mKTAyzTMr4FqaFolQoencFpbqEYZtUcR0fltOo2xZR32b
         rrx9akfcY/pdyrxgi+zN8j+SGrt6/wSUPHkIF/AlSZQjv2VSVWFBaegdblGY/6+s3IgX
         SJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004077; x=1763608877;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GoM4uSXCA6CGzeSczR6SGCvajUfHPXwjqqeVHJsq28=;
        b=aN1/Km4bANSy3J4E0s1q3KV3ayBxFtg+i/1PlPJHkZbV3lQiQ8RdMQ5W21NTZF/SF5
         C9VU/XQaiJGG2eI1ELVOFXGK7A9OFrVnBf4vGG/1FRpoUgCFh7+eeTZ6/CJxoO+JRAde
         noP//9mxHufo+WvEtZ8ZGu5sr4rW/Nl2KUZnZSFqosovF2WsbJjKP+CRJth2kWhvpwIR
         yhVUNn8Prk5G42yTmCCYA5s8TDHzoMp/AzcAB27eJV3xCrc8kDtXs0K0poOHQZ3WUs/f
         Yn1+ZcheeGeDQn+hBkKM1y0TtiLc1dP77t/WVqlMfJSRdW0+36zQQpdYub1z3GznyyaC
         Dh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVc4cfUGY/ypHmJYebu0KwgkNs9/WclO6IQwNSYlDgqsaTwl/Jjj0C8TStYp7hkMTokoo18/Kce0ccKS8sR/JhK@vger.kernel.org
X-Gm-Message-State: AOJu0YzILwZvBH/PizYy1psJh+r+Sn5a5QDGh1EdnM+IOGw+KeVX9XPp
	y4j/XqBQXIdn+9OtxpquNfj6SOWO7v/yyaeeyck/WX+Y27OUr3D6ZnCZvzk3gyGw/EgbVkdQvME
	vcAsE1y5tPQ==
X-Google-Smtp-Source: AGHT+IG5nBgQyb0tQ5Wgrbm72paCCXQH17KCARhUYhe9s1wIJyHK5FZWjUO47LlQ9KaCyQ2iGhz9H5qrVSjd
X-Received: from pjnj12.prod.google.com ([2002:a17:90a:840c:b0:340:4910:738f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1646:b0:32b:baaa:21b0
 with SMTP id 98e67ed59e1d1-343dde1030cmr6855910a91.6.1763004077385; Wed, 12
 Nov 2025 19:21:17 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:00 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-13-irogers@google.com>
Subject: [PATCH v8 12/52] perf jevents: Skip optional metrics in metric group list
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

For metric groups, skip metrics in the list that are None. This allows
functions to better optionally return metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index b39189182608..dd8fd06940e6 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -493,13 +493,15 @@ class MetricGroup:
   """
 
   def __init__(self, name: str,
-               metric_list: List[Union[Metric, 'MetricGroup']],
+               metric_list: List[Union[Optional[Metric], Optional['MetricGroup']]],
                description: Optional[str] = None):
     self.name = name
-    self.metric_list = metric_list
+    self.metric_list = []
     self.description = description
     for metric in metric_list:
-      metric.AddToMetricGroup(self)
+      if metric:
+        self.metric_list.append(metric)
+        metric.AddToMetricGroup(self)
 
   def AddToMetricGroup(self, group):
     """Callback used when a MetricGroup is added into another."""
-- 
2.51.2.1041.gc1ab5b90ca-goog

