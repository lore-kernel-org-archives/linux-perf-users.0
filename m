Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC74376F3
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395989; cv=none; b=mfkWIMtSIDFRhmUPb3qn4l3UzxSiQhg3DOsXt5gjcVJVOGnrRl3ZrIlX13k3irfdnxY0+clnw5sVikk5y4zeY2TVEr5io2+atopXW6+DkgFrS+igmlunlP0ncHF12gClPRJ5w3MQIuwyPRGIOEime7IoR8FI3LbDXM2YrdQ6mVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395989; c=relaxed/simple;
	bh=eF7ssQY3Gy21CwAhmYSgaNrkiuCVKaXgj6K+L8MWMqQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lZc+PZ+xG15XlP4OFl7VQm4YG8tvdT+YT5yKIlNSk/0ZRFZL9qP7ljkmTEkAVFAGhyYlv+fEfAd0XxEm8FGLFEXWqA+3plM/zpDeXDVgqdK1NIKWjlODp/R0YXTGvvnR32PAKcoj+KJLrGVS5gqH2TbChxfu11VXH8SoTYqpZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1KwtR3TE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1KwtR3TE"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so654411276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395985; x=1711000785; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0sG6qEZhABASQQZa8hhsLFbDsdErIcnzVgtt+v1EnQ=;
        b=1KwtR3TEbz2pSx9I9DDjVy11CEvYU64Rzy844tjN5ONp2k/nPVi/ktdpS4m8rtwHPL
         2ikDADxVUISluJ/OFc6K0BcI96NW9UIW44bsXzAxoyl5vtHUOmqKFSMBbpe+TEHFpvYJ
         CAkaz+z5l8j5llIEPhqunJtOvQkfyuT6uaWs/1O2dG4HPq3upTWoVekoz0LVHJ2lrfw0
         vsZPFswO32sPmLWHScrVoY57VAE4kMSBpM4gSB+ezghihUP71fCYI33lJb7SFETl0Xvv
         9gKW6MaPi4wbpgTjSrtdoB+45L6owFqb3xFVoe/ifg2bJyS33Xxzpws9OF/HieL7LKg7
         YJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395985; x=1711000785;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0sG6qEZhABASQQZa8hhsLFbDsdErIcnzVgtt+v1EnQ=;
        b=tCBYzxbpJjv9ZSOaOb4XIRdDfbbX1C32lnSlTBHu9PSQinn9i9JQOpyVbevdSObbBd
         ym8L2HeVUOYMKxJO9T7clyKk/w5MrmL1ZQVXEeYfe9HdScukmr01WfIbgwBV5WI+bEnh
         6JmHGh1NbqeP2KXk7UbUBXtPJWfTIGwM3FAc3biqARajY6Y23OzvquuZkV/E2Lqycc74
         3/OyhJc3RT7v7BIbsEBkQw1syxOSWq3yoceYVRvK2eL2e/nwp+TPIRuIBJ8INoL1q06g
         /djRc+ELAeF9R5Jo6Mev80Ux4mAC16rPNYs4kadKMFNNvJN7JPKxlGp9wL1Y+BdkdkuP
         vDlw==
X-Forwarded-Encrypted: i=1; AJvYcCWd+8WMuRHpcKxfMKdklWzqHNX8E+yveCs5/vzuQyGmtR6Y6tZgDbbVgZr/fIKBOuewisMUYa+Qy9hN6/z0iCH44VH6JuoM43OkmB94psVBTA==
X-Gm-Message-State: AOJu0Yyw1e/luXtQ4dsXQBHRKDH7JAYWeh8bC0lvuNnz7jrwrDvZoigp
	79LszseO+eDap9kfMfxYOCEsrc3Ph1h5TRUsGtH7xLInJeQc9iVVvmL6ItGHowvfXh/u6eXht4B
	plDr2DQ==
X-Google-Smtp-Source: AGHT+IHL6Y/lYpr4DVd9H5tWZ6+PnYPxXSSQjocWmXv3H8ehp9WgmcYOHntDqL0eAQFrhyAS4KgtIKhOXyZC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:1a46:b0:dc7:66ec:9038 with SMTP
 id cy6-20020a0569021a4600b00dc766ec9038mr20440ybb.1.1710395985568; Wed, 13
 Mar 2024 22:59:45 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:03 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 04/20] perf jevents: Add CheckPmu to see if a PMU is in
 loaded json events
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

CheckPmu can be used to determine if hybrid events are present,
allowing for hybrid conditional metrics/events/pmus to be premised on
the json files rather than hard coded tables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 03312cd6d491..e1847cccfdb0 100644
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
       "context\-switches",
@@ -24,12 +26,18 @@ def LoadEvents(directory: str) -> None:
     filename = os.fsdecode(file)
     if filename.endswith(".json"):
       for x in json.load(open(f"{directory}/{filename}")):
+        if "Unit" in x:
+          all_pmus.add(x["Unit"])
         if "EventName" in x:
           all_events.add(x["EventName"])
         elif "ArchStdEvent" in x:
           all_events.add(x["ArchStdEvent"])
 
 
+def CheckPmu(name: str) -> bool:
+  return name in all_pmus
+
+
 def CheckEvent(name: str) -> bool:
   """Check the event name exists in the set of all loaded events"""
   global all_events
-- 
2.44.0.278.ge034bb2e1d-goog

