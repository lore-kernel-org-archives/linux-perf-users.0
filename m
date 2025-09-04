Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD42773EA
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014911; cv=none; b=ci6BEcx0vDVcFebYPoYe6KEW6D3MfK6mg7qzaozRbcriw/6w6GhoyKre9WUqnZBV9lILIZ+mcqCmjVAt8Am0jCCAj9B3t/mbZEtIHwY+ohy9QdnMbeRw6MwJ/XIEUsUukpGnUZS0ZNi7VV844SlWNM0QFUj7LMDDl30esmlTFqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014911; c=relaxed/simple;
	bh=tq+7uK3RNkzWKqgghouLXQ6ydvGUzT8I9ujvOYYLYpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=V/XH9jTQyz4Eiyjv8oioJzrVdi9ycFhwrrIV461SUCbZm9Ug3DbNMpagwMcwIS3GEdwE8ByeFBZkHcsgN0YwTaOUrb+9uUUG4GttOo9UA6lbNqDxh7SSm1HfgsZh5WwNlGaMDHE8WSZ3x9jQESe8dDgLnPaWl5MLjqbH35OMbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBS/cKkA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBS/cKkA"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24b2336e513so21033155ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Sep 2025 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757014909; x=1757619709; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sLeowBwbmQjy8Diimn5aYxWMz09beruC8PAjvN25K+s=;
        b=sBS/cKkAD9wMWwySnSLBpKYWLe3myp6B7euAEvVp41ZMZ2WmS3lrpqwdUMT7kjQA/f
         Kp/VTg4WIpee1YixfwSM365tpFSdAyCk21CqtdGdgU1zDitvhysqqjiXQcrs9SOrFIhW
         7o1Wmirt0bjcN1GIIsedl4jdaKp5DvB2fPAi9jH9AvPn1Kz6tnS4E0ScYa4Jmfti7gkq
         tEkfcoNQBKxlm2wF0Pcj6I18PwIoQD355gUT45Ua2Z7o6n1QIiCh85FIJY9xFdPh1Yzm
         rjc+ldPmuG9SSmBNJZQNuW07IHx4jQ4hFrmbyviXKmLblFpIbLL9KQ0PgLCRKKBc2Jsf
         RbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757014909; x=1757619709;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLeowBwbmQjy8Diimn5aYxWMz09beruC8PAjvN25K+s=;
        b=f2ircPsfeYkpaS9DvDwU+EOlAH4y4ECw5bFvgwO1hoyOo6sDxRniqyFE7H0Oed4CzU
         Eb7vQvXC/kiixmEdgVZqS78xQJoCOt/272eKTl4JP3dF1hs287SGMggsP7Z2fSRxnzAd
         8AGDm/ZarxRYn1+Oa3Vjt3/HxGcrFBTOtyaIJpgvmSW5EXkp0PmH32URyssxfPgo6fuJ
         4hMoSFYYPNsZzcg3oTK9108wyj5W7JALS7GcIFQb+BcC9L6psQKhfwwLDFYIA82ynsKc
         V8kN5+uy9tBgOZIn4JSHn4Ii8TO57+GOiM61FavbooGQ5/JzNL2AMVjRJ3F3QrH0QYEs
         kXJA==
X-Forwarded-Encrypted: i=1; AJvYcCUtmGGKYbVsP7BS3m8KkDyNyMrMWgraMc8n8ASlhJWdRlBu0zYZX3z/QJJKiot3AMEE5UcVRLA7uuSQ7NI3tHgD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfn3EHZyPFuHh9tTBQA3m2TVkzEpMFUW5VQrD2inKKABlj1fhd
	Etcy+8Thn431rdZY0Nu3l67Iff68G2ukFUaNym4lZk6uR/oBS7QPfm1X3V1+tubpa1AatOc6ocQ
	j+AX0Ti9Neg==
X-Google-Smtp-Source: AGHT+IHOB6CqGG31C3TB2oFy7ZLtb/1XgDWq9belMrFQZ/ICWYQNjGIhyYl39Z21TKgn08wM23bNH8G4iN8z
X-Received: from plblm13.prod.google.com ([2002:a17:903:298d:b0:248:9b66:3356])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e84a:b0:24b:270e:56c0
 with SMTP id d9443c01a7336-24b270e59d9mr133206195ad.36.1757014909264; Thu, 04
 Sep 2025 12:41:49 -0700 (PDT)
Date: Thu,  4 Sep 2025 12:41:39 -0700
In-Reply-To: <20250904194139.1540230-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904194139.1540230-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250904194139.1540230-4-irogers@google.com>
Subject: [PATCH v7 3/3] perf jevents: Validate that all names given an Event
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
	Benjamin Gray <bgray@linux.ibm.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Validate they exist in a json file from one directory found from one
directory above the model's json directory. This avoids broken
fallback encodings being created.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 2029b6e28365..585454828c2f 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -11,12 +11,14 @@ from typing import Dict, List, Optional, Set, Tuple, Union
 all_pmus = set()
 all_events = set()
 experimental_events = set()
+all_events_all_models = set()
 
 def LoadEvents(directory: str) -> None:
   """Populate a global set of all known events for the purpose of validating Event names"""
   global all_pmus
   global all_events
   global experimental_events
+  global all_events_all_models
   all_events = {
       "context\\-switches",
       "cpu\\-cycles",
@@ -42,6 +44,20 @@ def LoadEvents(directory: str) -> None:
         # The generated directory may be the same as the input, which
         # causes partial json files. Ignore errors.
         pass
+  all_events_all_models = all_events.copy()
+  for root, dirs, files in os.walk(directory + ".."):
+    for filename in files:
+      if filename.endswith(".json"):
+        try:
+          for x in json.load(open(f"{root}/{filename}")):
+            if "EventName" in x:
+              all_events_all_models.add(x["EventName"])
+            elif "ArchStdEvent" in x:
+              all_events_all_models.add(x["ArchStdEvent"])
+        except json.decoder.JSONDecodeError:
+          # The generated directory may be the same as the input, which
+          # causes partial json files. Ignore errors.
+          pass
 
 
 def CheckPmu(name: str) -> bool:
@@ -64,6 +80,25 @@ def CheckEvent(name: str) -> bool:
 
   return name in all_events
 
+def CheckEveryEvent(*names: str) -> None:
+  """Check all the events exist in at least one json file"""
+  global all_events_all_models
+  if len(all_events_all_models) == 0:
+    assert len(names) == 1, f"Cannot determine valid events in {names}"
+    # No events loaded so assume any event is good.
+    return
+
+  for name in names:
+    # Remove trailing modifier.
+    if ':' in name:
+      name = name[:name.find(':')]
+    elif '/' in name:
+      name = name[:name.find('/')]
+      if any([name.startswith(x) for x in ['amd', 'arm', 'cpu', 'msr', 'power']]):
+        continue
+    if name not in all_events_all_models:
+      raise Exception(f"Is {name} a named json event?")
+
 
 def IsExperimentalEvent(name: str) -> bool:
   global experimental_events
@@ -403,6 +438,7 @@ class Event(Expression):
 
   def __init__(self, *args: str):
     error = ""
+    CheckEveryEvent(*args)
     for name in args:
       if CheckEvent(name):
         self.name = _FixEscapes(name)
-- 
2.51.0.355.g5224444f11-goog

