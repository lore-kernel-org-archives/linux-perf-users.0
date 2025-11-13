Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132BF320CDB
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004154; cv=none; b=NwHjbO3x2EWXBZw0bCcd55LpRaf+j0ZXqgbN5ljewQzNOsx1WpVdZ2S5NDyh0j5/wnBq1YRqK1ov6q4mUINDlTH1rkqWmLmMN5OqsgQz+wWwtXYTv51jySnr8MSqrfubQdfFpkotY3EyHW064Dz1IpCMjEbwp+aQianXhPp/9XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004154; c=relaxed/simple;
	bh=PYYj0BU/XGMQcfYDNwI5vZ9QIwJJl77gXefIpVh8h6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iTvS3VgpwIOJX3UwBQy1X6JgTrou8T1E8VbZyMvskTeT0NOftaUe/0yfhODkJu83SIlt8olDvWy5MlWhYMGojm90pq6TaEVYeHKUrPvnTpC21d5vfMUXwg7+R1K4yQLEft+sII4Rbfqz833YSVjsiwqz12ZZMc7lc8oBedjBiHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z1jwEihb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z1jwEihb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2958a134514so4598625ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004152; x=1763608952; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpiV5EOs3sfeUi27FfFfkzyZAK5h+RJI1H4AImCQC2s=;
        b=z1jwEihb833qgx6lwt7G8LED0bvXxjOmoXKk2hli9jK+YfiOuXIjV8NF3VgYxuwZKk
         tUDNSzPsxCYB7swJVTXtlSbSaGlOJ2Q20y3EDrYxVghVKdmKvLUS110HPERQEPICUBf5
         3A00aBzVeELOlnSpDxbcBrgjVRoBvXGWpdcIj1H9FspcTToz/i8OivKnw6AUkVp4lftC
         ouFL8yD5Sxk73wxXB+Q9RXv1CN9jxS/apo3vFJhVe8fXF77zAUdolzarhoxvP7QK3Eap
         n27gQBsOO73lnihX20xXn6MfP13AzsgQrKbFEnaomlijj9PWjL40E4RRyuWlMGNJGQQt
         GX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004152; x=1763608952;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpiV5EOs3sfeUi27FfFfkzyZAK5h+RJI1H4AImCQC2s=;
        b=wjtB9FQ2phGMj9uRN4rQ4uZQpLDlRUfUtWGtrr/LotL2yNYihBJzeEHH9j4LXncBRh
         uqT3hWsX84crHh0ZvWmi/BCjZNHKPG2ASGD/+Hd86+IcLUgJwqannYN5pFPftp0On+j1
         9HPbqGM//PZX9Vpxdy8nBDIrEhCt4T9O5JBSN/Y2sc45fj55TCv+tK0fcpyjPewuRz2J
         Objh3nCNE1H9DSto/ofUr6OTn3bf357/lj95CCc5mi7JTct2dMA9R7cAOlUspEt4gZv2
         EC+iaBw4+eXefKz3RuYhSPUQfBKVQCGUTxPm67FbOYFpDBotDLCcE/llkveBNRuWXVkj
         FH0w==
X-Forwarded-Encrypted: i=1; AJvYcCUhv2jJSU62QiYLESwWyhb96g8n5+ZOMW6sH19yqkSfQ0Kdiw1ujnFnDH6rNS64TOULJdRTBbcxd0mT21jxYEju@vger.kernel.org
X-Gm-Message-State: AOJu0YxXjRNApCHECbozQC2q0uOTVAoM+rFjyN3gH6wFA1a5jsz5ASJT
	pizc6/sH7Oa41ZPya+b0Wuc7LFYFQRdgsMO3Ah5i3zYIEM+aj17LVQwXvKH8SXEr2x0Y79mMDfX
	YRe8t5Qe5iA==
X-Google-Smtp-Source: AGHT+IGwLbEYZHnLyWaZ1D+XpbNhBJmfreqS26xY8slF2pPAsU5UgWmp2DKmUKpTsYFsPo2XCG9i/zA5d4VO
X-Received: from dycrq23.prod.google.com ([2002:a05:693c:2c17:b0:2a4:633b:7a61])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce10:b0:298:3a2f:2333
 with SMTP id d9443c01a7336-2984ede9f70mr69159195ad.31.1763004152511; Wed, 12
 Nov 2025 19:22:32 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:40 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-53-irogers@google.com>
Subject: [PATCH v8 52/52] perf jevents: Validate that all names given an Event
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
2.51.2.1041.gc1ab5b90ca-goog

