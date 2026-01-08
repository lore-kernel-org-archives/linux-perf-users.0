Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18537329C7D
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899518; cv=none; b=jDTmxb9yGV45cDcQ2B5bXECjYINzxNYnUuvv8qDCkYI1eWSzK/XWwk5+U34s2c9dAN4EvJrlacNYzjzVlnjhR4fBcFCpRa5GU73x9AxdNUnhZMIJP8EH1Qs35niHsFszJko2zidBA8706CEe/p1YiPshcCL9fcapVJhCq4ppUPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899518; c=relaxed/simple;
	bh=bp7wUYlwFQ9u8p8yyH/LWJ+nT+cGLAukFIDqJoid0TM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=e3L9wmsWLeErmBdHmXvB059MtkVOzhrBiVQM/WeMMB4iEmHfNhA2iqMQi3vFBfSORT4O+1BS+UaGUicd5wKgclCvKUMYuqA4yfhvW9BRQ2th1KzcxceCQ62K+d7DTg3dT0eC0GTbeHSInBP+7fXzuO+ltcjn1VpouE3K6uXzcBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gOGU9+Xz; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOGU9+Xz"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12175e560b3so4290417c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899513; x=1768504313; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlwDSvXJTA5pQkOVBh7Jgz1PRQVOZ1b1qdOJqVwcy94=;
        b=gOGU9+Xzra1JXS/KFB9TeYMLGDl8SuULiFMd9jkEOYzgH4OrmOsnXzku6DMk6pdIJS
         Q2SVqkpJAADh8oxeyDG0qSBZSQ6qMvAsxhjZeN7v350N2lmkCVR4IK4weD/YP5p23R73
         W041w3HQSIoQQy1U6h4LA4vsXCinFIjC5zPTLrPXm4e5bgV6fSfXhjduTpi8oB3wSlua
         XdiyzJbMyUfnhLa0irmzcqazeoAVrOM5LnootJ+GT7unz8FOCESLDTO47SMIScGWQHpQ
         w2kxHAc5/3Tw42NtI1L7zM8DBY25Rv2mXt7zmbcnKEQMHsHsiNKhoiEsi70pl4K2x8pK
         EYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899513; x=1768504313;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlwDSvXJTA5pQkOVBh7Jgz1PRQVOZ1b1qdOJqVwcy94=;
        b=lOt6l3z0ORXgrcdVUP48BJGmPRxGKfMZPQcqGjfJ9qoVKa7XgAlItDnaLpeFcS8ol5
         Xo7LA2DFd+sUTHtgraRZnK1pSVtq0Ikp2nqpn+B1BjX1gkcRlGu2b2w9Gy8ZDkazGO4P
         m3m19LucNyqJuKOHhJlYQZWUSXdKszsQluKTQa9ZNdqwf2MpIdacN7OtwSUHQTql/8Xu
         vYsT0O+colDzdFeOykxUUnIGkk6giFVaFDzSioDbFkMXr54s07D9kUEx1YRO0NNy9p6v
         I+g38AMqpoWQGbLgpgD4Hc6AGFI6WCep5xinKr6efthbPoDwwzjBJf0BKKFf/14oxMbC
         MbtA==
X-Forwarded-Encrypted: i=1; AJvYcCUIAQCizyncj3hcphfZMxhdZo2JiLB1AjEJPt6ZjCPZIiFLlJKvJAeM4pyGpieIgJ0m/8ZWbxKEA1wsIJ2rFXhA@vger.kernel.org
X-Gm-Message-State: AOJu0YztSqZnM16GPX3US8zDHijO/oxfcXtE68cwBeG7vE/A7eGPPMdL
	d8Jck8m58pPWzJDd34N6PHjJV8C1oJAzQOQ/EEPO98OWgkR16zba/gj8uoRZ/agrcwX2xMBu7m7
	8q2nzdAjF7Q==
X-Google-Smtp-Source: AGHT+IGJJ/p0fhtPUPumCcKcm6lbsZ6C8U1Qdqbs2veuIqkmDamfVsqWWn/On2uRaOydb1Ld8CGqKXpAaTnu
X-Received: from dlbdt22.prod.google.com ([2002:a05:7022:2596:b0:11f:30f6:ea10])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b82:b0:11b:9386:8258
 with SMTP id a92af1059eb24-121f8b76b79mr6229029c88.45.1767899513332; Thu, 08
 Jan 2026 11:11:53 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:44 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-15-irogers@google.com>
Subject: [PATCH v10 14/35] perf jevents: Add CheckPmu to see if a PMU is in
 loaded json events
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

CheckPmu can be used to determine if hybrid events are present,
allowing for hybrid conditional metrics/events/pmus to be premised on
the json files rather than hard coded tables.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index e33e163b2815..62d1a1e1d458 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -8,10 +8,12 @@ import re
 from enum import Enum
 from typing import Dict, List, Optional, Set, Tuple, Union
 
+all_pmus = set()
 all_events = set()
 
 def LoadEvents(directory: str) -> None:
   """Populate a global set of all known events for the purpose of validating Event names"""
+  global all_pmus
   global all_events
   all_events = {
       "context\\-switches",
@@ -26,6 +28,8 @@ def LoadEvents(directory: str) -> None:
     if filename.endswith(".json"):
       try:
         for x in json.load(open(f"{directory}/{filename}")):
+          if "Unit" in x:
+            all_pmus.add(x["Unit"])
           if "EventName" in x:
             all_events.add(x["EventName"])
           elif "ArchStdEvent" in x:
@@ -36,6 +40,10 @@ def LoadEvents(directory: str) -> None:
         pass
 
 
+def CheckPmu(name: str) -> bool:
+  return name in all_pmus
+
+
 def CheckEvent(name: str) -> bool:
   """Check the event name exists in the set of all loaded events"""
   global all_events
-- 
2.52.0.457.g6b5491de43-goog

