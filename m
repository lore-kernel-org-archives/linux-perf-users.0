Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542523182D
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440697; cv=none; b=AsVtSeOK2kDU4qj3pMqwo1uanrA7QeeYVfD+WwNliSTIMaBm7+7wb/1nFyOGbSJ90eZviuOnKnz/8DPStdsazASe6hUYj/oEvjkg4To2nFO0MVb/ABA11J7GwhTzwkeO6V3Ds7Yzpom8aJpcZDWuuypKU+ODkbZLL5SrsnkGzNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440697; c=relaxed/simple;
	bh=joECuR1Dk7+k5vEaqGQaIvQm0WoUqvh9ot/ZaDm3uFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bv4M7yHB+QlyfPg8siB1K6zGgpD6NMuyKxzoGGrUYLkyNB9Sv9fns/7aIWWT+S4l6+YHpPOc+tLdvSg/QMytXksETgcHGkYBcUVPqHKx5YIMoW8n+TkvGKLo0AcEtB+ImB35KYu5K63qy0XBONyrHJXTpb/0sJjWMFSQiPrA/zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmKJt44L; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmKJt44L"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-771b23c0a6bso2877081b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440695; x=1757045495; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ItByjsoo2hIXvPCvY30XzJpXM8WuvqcV8s0HcZU4W0M=;
        b=OmKJt44LA7bxQa6L4Gowm0Zlz2gxJnWjgJcCKz5cMM0ckCNO6l98m2qMzVMciA9h99
         rhvlGSN2Qno0im1OSpHS40vAZf/t3Z8wqvMvdNhPcYmHHU5YbiAwNpKEnOMjZgiVuCCS
         aGw35j5t4qrmzMtVa2hz+lAs7NQOW1KQQ969BJB0XB1s5KXpsG5SaUXJ0oN5ic3yNVi+
         bKq10GaXQWHe29H+7buDg4AmJjA/oZXCBRiCcaqUXCY6AVy/KYW7sA5goe5lFd56/Vi0
         kFYYE4hPHxjFNctbOVdFAdD4rq5uvGDw8aDNU/cgbO/7AH+Y8j69fES2usxxmhI3gpar
         aDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440695; x=1757045495;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItByjsoo2hIXvPCvY30XzJpXM8WuvqcV8s0HcZU4W0M=;
        b=G4dMpXmrgk2UQ1g644O9K0JVgTqvO5qtAKEWO3Zmq/lMzYHPONG9aRmHgOcaQQnnF0
         h1oZh42UQl4lUvilZPKEIV0QGCUtiwwi1uMADzW7vyeYTkjY9xJaVKa57uUZRnR+g5iT
         8Top6j9owqR4vRlmPhubCv7Z8fNGHMs0trWJJpUp34bgJujAgOs8uKq8CEIa2lWeF+MJ
         UIE+17fZo/nYuE1Bv0tcrbOA5GYdbneJ5rDu6unU62+DfRBcG9vEzyADM+Q9TRMIE5es
         a4hzzsdJ9A9WkIfAX7ZgbRmWpLEScd+1a+htXEGtx9TVeNd/KvC+9dFSiOKM4C9tJovF
         BU8A==
X-Forwarded-Encrypted: i=1; AJvYcCXNzrgQSJdUgWqC+8e0dUbrMNhVWVG4eqbHHIU1/IdJYNRnOFFK3beG6Op74mppxLhiSPPgj/jwxi9aprmOeqTs@vger.kernel.org
X-Gm-Message-State: AOJu0YxIAP+tANt8W/sb7teC74Oq+mPNz3jBQDlqbFzkMyTRRCwU5f91
	J5xPA+RHsAAqA5v/6S815OTvfLmxIeo3B2ccxXRMmqJmER5ZJawCB3ZSFjsiGF4HUgbXkBc/E8W
	5zthC4Keyjw==
X-Google-Smtp-Source: AGHT+IHtQxxmwkW4HdttcwiHVyuLSUd4MwJSBf8lr0jbPLBHY74bfUImgOMcLv+E351JeBJ9veaaw3fWlqQO
X-Received: from pfbmy8-n1.prod.google.com ([2002:a05:6a00:6d48:10b0:771:fd7c:50e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d9a:b0:772:1fa1:be43
 with SMTP id d2e1a72fcca58-7721fa1c0ebmr3830088b3a.30.1756440694946; Thu, 28
 Aug 2025 21:11:34 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:44 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-4-irogers@google.com>
Subject: [PATCH v5 03/22] perf jevents: Add CheckPmu to see if a PMU is in
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
index 36e9cb3acf6a..4f62f252abef 100644
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
@@ -25,6 +27,8 @@ def LoadEvents(directory: str) -> None:
     if filename.endswith(".json"):
       try:
         for x in json.load(open(f"{directory}/{filename}")):
+          if "Unit" in x:
+            all_pmus.add(x["Unit"])
           if "EventName" in x:
             all_events.add(x["EventName"])
           elif "ArchStdEvent" in x:
@@ -35,6 +39,10 @@ def LoadEvents(directory: str) -> None:
         pass
 
 
+def CheckPmu(name: str) -> bool:
+  return name in all_pmus
+
+
 def CheckEvent(name: str) -> bool:
   """Check the event name exists in the set of all loaded events"""
   global all_events
-- 
2.51.0.318.gd7df087d1a-goog

