Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511653148CC
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004114; cv=none; b=g4CFHq7micK+TkjJwZSSvqNKSlWP3Tj9entqe8Nm9Q3cnxkbftQYiBOxiG3+tLgrtVVisaLKr9kBnPYnBDFvPUmn5U45ASIyZViGPh+9pIYrlPSYG4zgZE1w9kWtxl5JbRqjz61CrkZh8D5jIKsTXVrpRIq+ZhtAEJrDhpBL7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004114; c=relaxed/simple;
	bh=dtrcmDW/syC/1uX9xiFrYNyeKD9cKYmOXKfr3PnzzHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dNDUhPbeSLfqC7KDsfgeA2krNL+is0LYr6n8iIeVQo0ZcJVMMu1E30XLYT/aeJJ/mRPwKLR1qV82J5wATOhZbgmn/UHbrA6IJ994AYN53SRirThIoGA0Y6rOTjWwzsvjt/l/GVCAsShvFGYlOQmWF+xqa9d5kbXkm/ZU6+FC2pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NQkcQQAr; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQkcQQAr"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297f587dc2eso4394475ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004112; x=1763608912; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmEuf1+eWrnDRkHWvOdDXellq4Hkis7ltgRYwnn7UgQ=;
        b=NQkcQQArSCJeI8oK7n88gtgksjeTe92hgvn9NTMy1DGBpLK8hjhBsebY5/u20E3Lxl
         9KeDLFf+MA72ggGpkRvydpWrrD2rllvn/JMLJrOCM1XGnz0sEfC9JiAAc1nDNqxg7F0u
         Ck6zVXxrOPRO2zrijAktDlg/5rtV7rdqoTVRCHNu3VnHrHx81oiOADpCOcGyuWZQZU7e
         gYhvGAq1GiYeQeEcMVgyLaI7VR51nWP8DikgnkWPFbEjdj4iM+DhznBi7gWCENCDBxof
         +0yAc1k9ysvWCkOe3pGjH2ooQDLKnc8FpLwVIoPnDcZKWAyoSbtfn0+pOD0AWVwJzZew
         wtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004112; x=1763608912;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmEuf1+eWrnDRkHWvOdDXellq4Hkis7ltgRYwnn7UgQ=;
        b=Ku/Ou3ilnfPa5MpHkpHoF2FQFhXuO0+3rx67fZii/wnAVP0man5RwnVYYmNx+VKCV4
         HHzj6PpWbl68zcWzWYm/yy2sU8Zh+DSmOEUrw5lOdcrOphUm0wzjTqzKYx9uJ2hl1LUY
         Rev8kgjkh/rEyUVqJYZ7yebwTyvQOhssU5noY3hQDlBRgoSrHwfSccjLGt/rqgR9GXAx
         c2jAFM+2St57pon8lMN6tuBgpzMiDCQuVV7Gmx1uJtUbyk84vccGnTXh0GWDtNMlADHG
         4+1RfBzB0JxQXkZxhmQzysXFW+JhFAK8OWI3fLJsvhmx7LFEMDeYNvqt8klB4GbhrIss
         mGmg==
X-Forwarded-Encrypted: i=1; AJvYcCUA68ONsIKOBOs3K7JnLq5CaxDb41oQ0bElswZ2DFBGm6cIwUJXCdEH5IToIyRAkvzcIvt2XjgVcNiQpSpCRssz@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgK+hi2inpRNs2mqVyz/BvJuiRRVu8fOFODn52iOe9bE3lxUe
	AUD6UwXVyuas2yNXtrdKufwocNFDlIfIJGLj5Fbn4q05npy164BwX7Adta73qHV/QSOBlF05weq
	5UEGgXCUZCQ==
X-Google-Smtp-Source: AGHT+IELChdLGepD16cMdJFlCGSq1vQv0//kOzXIur+0B6dP8L4hB1a2ag4vLjYxov3UcU9S5KBpkbBCw231
X-Received: from dlbqj6.prod.google.com ([2002:a05:7022:ec06:b0:11a:4c58:f398])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:944:b0:295:32ea:4cf6
 with SMTP id d9443c01a7336-2984ed27f0emr67157975ad.5.1763004111750; Wed, 12
 Nov 2025 19:21:51 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:18 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-31-irogers@google.com>
Subject: [PATCH v8 30/52] perf jevents: Add CheckPmu to see if a PMU is in
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
2.51.2.1041.gc1ab5b90ca-goog

