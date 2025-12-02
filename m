Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9293B2DC76B
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698000; cv=none; b=lH6SpvS1cj8Tfq8cVMFLwlavmgVI2aTSSVbToiMaGOoupVF0nVfUdLwmKR7yOkUCkUPpwzxPxqq5E+Q1VE4SYtho2oX3s/Si2B7TFCRcQ3pHvwB/rOS0LnYbl6mA4l7E6Qyynt08Qk1xdNIYIyHwuw+Q8E0S21YSovUMOawLfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698000; c=relaxed/simple;
	bh=0DvT/kiE3vDrT5HO98Kd9HGHFwaVslnLeu4gouFC/WU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=s/H5q0mttjzzhYeqd9TM+0bmw0qhAsyH+Bv2NutMFlduF3m2nqONQVayzpdBprkUuu4CVrLhABHVpif+dpsGz3dGFSApzfc0u97roYROpUHSCTG21c9TtytHW0hmpmYyjd028alDKpZ06CRKTHRu5Btv3pjJ3TYGl4RVQPj8YRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1JBoHo6O; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1JBoHo6O"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b99f6516262so13929382a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697998; x=1765302798; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkviML1WbWjNToyw1Pdo6Gg+vsZfxTwblnh9KfvYqw4=;
        b=1JBoHo6O9+oMe/ARGxUBOAVQ3JUIVnh10oTcAVR7Nem9tJdsz/WDYXqUXww/ubB0+K
         DhZTYq4qRAq1QASEcA5d7Zv2B0hrzmoMK5867UjAJ4kM8tiYhbiFYOJndbUgaEEBFWDW
         t8cg58JCPKeYvLsP1qrpP8/Ip/omp2GOFU2c/0wS/trSUUR6QWEburfqWtihiG6kRLvd
         GehSXiOubvLdo9RshfdnCFHg+qErLpz6ABDyhLLSMKOIj6sscc18mGUhf86JaSfL+P8o
         T2/4KKllVJFR5Q3FssCo9dfWkAAMk+vSUsjJ5vpo44San6oCKHbGZdL4uEQQgoE7CodY
         WfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697998; x=1765302798;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkviML1WbWjNToyw1Pdo6Gg+vsZfxTwblnh9KfvYqw4=;
        b=Jm7j6jhRPHgmZ1EdAibkzs+j9zcmp/kxX+SHOksKG/91F+lduUr0Wiucc+ViRiwF9k
         ++1t1ezR+3puhkZFJ/tL4dOVKqDkhgSHH5lR8OofjzUlEI4ybduQE+T8rmWUmnCqQYr9
         SCtTdts11ijeRiZWPZFIuMnOwpBvM2uvmSjpJIspr1paMm4CZ74xcpLXWQ5cPfudZqlm
         ivcSIHLAJlBxq788cN1Y6aiEKkeBJoFKnDDMBmEbkXI1LDBXErEdlykovlKEYGcHgxpk
         M7L/g00/crNUsIf6w1YXwHKcQDISkgugj7sO4h+Z2MqB5aMmu0p6LeVatSwWDWGjiqUE
         7NNA==
X-Forwarded-Encrypted: i=1; AJvYcCW/qfunxoj8YVqivmYi7SAAqqY6fX2JCWjeFBq/Ej+eHH3zsroMae0QsN0sfFzEhkS/hy79/QH414TzgpP6oH4t@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6m0DaSKJXG2gCmmWXk+W1OXiy2F7wstmf0xml2OTXykWQ436
	q6cazHcm512pC9gkPrfyjeAeooPb/RQtHHL3PUTdTQGcJA9kb5ns2M3hZN25lFHNwyVyB6uxbRT
	nrAectQ+C0A==
X-Google-Smtp-Source: AGHT+IHooDxEK5JcM/PYoCMjCixu2mwH53pk8hETZAz0niJvf+nPh0Zz8qPLbKKgt0PCgIxZiDzXSuWuD1Ea
X-Received: from dybfx7.prod.google.com ([2002:a05:7300:c387:b0:2a4:75c7:9884])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6424:b0:2a4:3592:cf5c
 with SMTP id 5a478bee46e88-2a9413be9c5mr17153733eec.0.1764697997595; Tue, 02
 Dec 2025 09:53:17 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:21 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-27-irogers@google.com>
Subject: [PATCH v9 26/48] perf jevents: Add CheckPmu to see if a PMU is in
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
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

