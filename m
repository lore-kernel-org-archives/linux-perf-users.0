Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944952417D4
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961225; cv=none; b=abdW4ZK97gObZmcrgo8tOqWWkODsP/36CwQSIoOdRPKsL0UV+1TTyEtGGAGilzjPGXUqjOxNXvRkNj8lVvbB2QW1xa6xO+5PGGJxy/eaHfkSo/n/qfQstWQ3ajhXRkOlTZwn7R+zr8o1a0oSbQEJplh9jxXGJoyaqY7Y9CuJ5q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961225; c=relaxed/simple;
	bh=6tOoJg4KWe2yZeGCw8xnj2DIBatU0NoVTYxxEyCfdms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kGIRn9EZZglrktm2VGDSPGI24ovrTKj1TcYOLeKh5IXjnJoposESewvJa2TpcEzP/6h8vz8g1yTAc23Fl6HLtLNptsrpNRZcKvdh5hbVFzZD+jb62EWuElAFgbKIMx0o3bs/i5iCbUOTTeCBX+SJsSwad/QUvVHnIkTCtZf6Uqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aTk2fHbe; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTk2fHbe"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329dca88b5aso2086019a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961223; x=1757566023; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LH7186V5/IqnZ4SzNaXMf39oYTvCKyvAIASH+gNRNt4=;
        b=aTk2fHbeVBmcLltguI7G38x/+LVgjXEHWFD+0/8SzXMxSgN4rHaGSYU/V2yIG/edRz
         z7Gmj1JYqWtJ9kFIW2AcktzTr5JiYUFbNVEhCDrIxE9hSdGJh4sUtRCB0x5K/OpfesiD
         SFC+GQ3NB2UDnbN16y7S8MSDo4iKXip4cycNiH1zfkHewsAwKWTvZxcJ6TjrvNW/x6du
         9zeXwDVsSAiTVbjbkx4kXTf4BjNtk2lrneuKKAN2Bs3BpzpEV7juB2QxNu9Dj/sJKQuH
         apK4ludC3P1TkJMQj7niZrZlVe3Wy/9o1CujuvF0Untof/dzM7qhVfGZKKGxgr4OOrwm
         wccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961223; x=1757566023;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LH7186V5/IqnZ4SzNaXMf39oYTvCKyvAIASH+gNRNt4=;
        b=PpOI+dfoe51ehK/QmCgGnOwn4vioiKouSI4b1LAAazCnT+EdQC6reqwT4ZuIifXkaJ
         gnC+ARpfakZ+JkWw6+Uw9kgpE2E4sTzbyOz/72QO0M6Fq83YjtAgU4pVU9L1oHcmpj3o
         K8upU/H90PIbWqk5R8OD1EgfaYAe0OQ7ZcGWlBHVPRGNW1X0uVlP8wu028oNj5JX/WfZ
         ofFJTGtv7IwFdWc5wwker81GGvtIAfHtvIuY4oUTG1zICVXJPb74DZmj9gVvFZbR1rCJ
         vcbR2/jNWAwmZ9pOSOYP0HElapmKgnGofURxZk7ETydTnDy1nS/1+U10/BD0nxccySE/
         jU4A==
X-Forwarded-Encrypted: i=1; AJvYcCX42vQXKr8VAGDQBMWiRxIY0Iem/VWKOn7VLsijGfM6pIjbNQNv7GUfev1XDvrC6WrBAy06gaAqZgOdSW/Dz31l@vger.kernel.org
X-Gm-Message-State: AOJu0YzEiuKVifJn+xMiCPhIFMXKRvwZ8/Wd7zmLp0D2ghbaeK8Ycw63
	I+KuaO+XVWNRDIMdLJrMbmPLFl7ixqjQgeOx4/6DoF3/JCxWM9XIg+D+F24utIXjdao3N0w/7Qv
	hsUvfsLlhng==
X-Google-Smtp-Source: AGHT+IGbNBIZRRXlehmzTL2WQ8wGUyQD1mW1Qje7wUiLgUUmGWjGqvq48ym7ZTxCo6BwTdyJ7CuqFfkY7A0d
X-Received: from pjjz1.prod.google.com ([2002:a17:90a:6d01:b0:329:7040:8862])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57e7:b0:32a:15cc:57d5
 with SMTP id 98e67ed59e1d1-32a15cc9665mr9334729a91.13.1756961222947; Wed, 03
 Sep 2025 21:47:02 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:34 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-4-irogers@google.com>
Subject: [PATCH v6 03/22] perf jevents: Add CheckPmu to see if a PMU is in
 loaded json events
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

CheckPmu can be used to determine if hybrid events are present,
allowing for hybrid conditional metrics/events/pmus to be premised on
the json files rather than hard coded tables.

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
2.51.0.338.gd7d06c2dae-goog

