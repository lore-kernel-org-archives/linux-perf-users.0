Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECDC225397
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445574; cv=none; b=a6nwV0W1ndf6WDKcvVvw7VzQH/zwJ1YoAtLTibkSVnIOD5inwiZAcMrmWBl8n0ow4YQnAh0TqYAJbo1tXAecYQ7nO64AD7QGQUttaT8gvEuVZ2cLR39GvFK6WSiPePNK6tJn6V3k05MktNaUw/OQQi/H3S2TKrluNhj6iJ+/Poc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445574; c=relaxed/simple;
	bh=fwAL01LE19lhQ9UMyPpq4PFhYNoK6DT1X94dohuXWL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cau2wNBXib2MHAbC+VOXGMMYBHc/E5F/5P047GCLsdG2KAoCDKJqt1WiZlF6nTstdNfBCq4WOjL1IPo2xejmIMGd2KfqAd3sbK4mo1RoeMrduMAXXPsrobHb+Wfqm3BpxwC69ZNOOpI+gW9LEDMHQRxiSjRFyKytCsYgDAyHT+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHMMB876; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHMMB876"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457ef983fso34129535ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 22:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756445572; x=1757050372; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pU2fAeE5oM19Gv08YDHyl9/3IFT39lq/g2I7zGvb/Xc=;
        b=LHMMB876jLun872dFqLtXNrEzb9/HB65UEX79j0mbz5/J4QQGCbUrxdHb0OcvORILu
         h29CaKSkfMun6ysZGw6Gh+Szf3u8bWE6+4pVTULYwF+aOe+jbi9OLKlc0qGPVVwpL/P2
         Ppy2FOrYRDDcqy+Ytug/hE7ypGBkrYK4POqbL3kMl16/eBFRL+DeImk4VAelLxkpb9V5
         isYCFRpSHohY64aFgDwr7fZihMvbXbYbmdcmEpzD+OaT/DH66YyciMPmN/3J/LNhDtcl
         KmyT+ULgNEgvucHUXQk5k+y1yQnsLAX9Dxq5gh/oxS0RKCGKiOevybP4gLiZezEyBtOZ
         dc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756445572; x=1757050372;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pU2fAeE5oM19Gv08YDHyl9/3IFT39lq/g2I7zGvb/Xc=;
        b=WCsPoyUdD1vvPwoy6Avz9TfkJ25QIk2QEj4SxSbDMgMYpiF69vcBYbpbl8DRFa5Icl
         f7qYq4SRXdNl8GMfAZEZs+bvZL8u5tHArwrmbZmjFBSWZEsb02TuJprLljzo/jRbTm8W
         oHS8Ag2HpJQuzCVutFlVGSZ17FWeV8Mi4DRxY32brsUIxkfvYJwMpNqdIrJeM8eMeyz2
         zhLWBe00PkNBLzmqqZsfxynr2dPCZ64mHRI40xCoi5x6LBp9oDrhm01Mpd+SrvSt8EV2
         i2SwjTRxBU3cVTreXLIrcrlj7FhtPkPEq0pm1m/LFb2WzNHY+hE72FwgOs1vbJc3b5gC
         Fz3w==
X-Forwarded-Encrypted: i=1; AJvYcCW4VFxOjADlU0LLFiy5mpSKUuSDW+Bn8cOuO7k/yEDPdoFEJMBiiqgz3liV04pUUHVixrmPIuqDv9vbLvFG6c1Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jlzSdFKEYKOj5BbFgbDwQy7UDOksK0fei/LM3+WrIekMRRnQ
	xHEf08pXCyB7LNc+lydIiQo43hHGy8790VbzfSY+KMa14k1AlfcpI6m/yPLYP3f40aC7iRS3jdf
	TBGC2nB7lvA==
X-Google-Smtp-Source: AGHT+IEXo8lujkPD6NwKIYSQQ44USgnCa80S8P2/L/lAYZbF7W+ElqRCMv4FbfFb51L26IXnQPyD74pxYC28
X-Received: from pjbdb3.prod.google.com ([2002:a17:90a:d643:b0:327:5941:b2fd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c403:b0:242:9bca:863c
 with SMTP id d9443c01a7336-2462ef47b04mr396377635ad.54.1756445571769; Thu, 28
 Aug 2025 22:32:51 -0700 (PDT)
Date: Thu, 28 Aug 2025 22:32:35 -0700
In-Reply-To: <20250829053235.21994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829053235.21994-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829053235.21994-4-irogers@google.com>
Subject: [PATCH v5 3/3] perf jevents: Validate that all names given an Event
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
index 315350f3b6ed..92dcd4cd9d54 100644
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
       "context\-switches",
       "cycles",
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
2.51.0.318.gd7df087d1a-goog

