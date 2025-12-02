Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5562EA171
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698086; cv=none; b=hv2g1XeCJjj4l6Z3VEnuIp59Xz8gmwbderwts7m+M8K+DqCcCCUQuuZmIKabSlji+UifQp08BQ+JvsTVUXcChMzfaJX8XxdDdCAgrnyTtp/sXhInZ10blENgBTwas0tEI6WFiaNJDn99VvdClX45dLZik/3EHt/SihAdtC0TR+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698086; c=relaxed/simple;
	bh=NThdRYCNtlYSZW1PU5R9Tup9FW5EJkaG8hpy/1kktlg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mTNAU6w2GrXMFwtjLRa5fNQZNXIFOajfu17glQlqWRSdydw2WIqUYsWy3Lv3F2TvE49w3TADEaGADPyQKl49yKhbkv6EfpXv9Z9Xeu6oLym6Paabrfe1MJuvDreSdewr0olGPXw9xKMau/V/gyV78Lwvds0nG3BLI06t7aieGMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=shEfZGmt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shEfZGmt"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b98e6ff908aso12797487a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698084; x=1765302884; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hpG0g9svAOA/ifhIkPcMdbZNaWTbft53MOj1l178nKA=;
        b=shEfZGmtPRn2Ckv/7iXxnjPMkKEldOunYM1vCQe0DB5vrSgmArPKTDQ4kNtc46opiB
         daepG1FgaeQev1iDduTCAbhkPlTHoRIX/tcpZXRRTXMK5toP/uJPkoL3kSe5m+ncUdKB
         hA4/74PEJACYP5oaHsm5OyRnWa0vpsxVTWxjKz64zQl+cdwcplKcTOKV+WkkkNvketo8
         LSHfru8vSa2JonE3Xb4BFwmeUJhFIh2JfXIttwHcYXNRV6swKjG86Xllvf25E8zkWeIw
         dvEGyNTl4GUNiqQOI+g6sjlEwc04/mrwvHGHZ4ScWgia1amXMlUAJfEFFjxH1cX9cEdH
         awsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698084; x=1765302884;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpG0g9svAOA/ifhIkPcMdbZNaWTbft53MOj1l178nKA=;
        b=cgk2bGvIgXp+yFR+o3ihJrjI4pYz/XTIo2vDeXLYlh3Ov5hBTvs9p1Ha7bxifsv/Ca
         xe+IsDosveC2cA33pnXvbCfyVUws+JR6Nzg/bZhU/RD2145aygCQSN1X4+kNklTDfwV9
         RVJs9eItR+puqrs7fb8oK8V0qK0sd3q0LloTOaRlkVNqgdNi4raCINpumbB1DRby2C9a
         IAYivxZv3sIJzvd1+a7vd7vprnS2253+3VoZMZsVcuGHqWpPDjyec/xtSCV2g5fxNeN8
         q3e60ZfDFavro1+/+7/4xAftySk4rhwTiuGQ7SvRnF7nS4IydnHarrh68BB+nVd3q/1Z
         nuAA==
X-Forwarded-Encrypted: i=1; AJvYcCWI1j8pD/p4UDCD9jOc2/P1AxVwrIL4ROazz6wL88FUNRvtLnSlvMZWGgc/+fdRtBbhmqLK0m4/tYe+YiMRBvyJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy65UW3YN8pdXtXKaakwrPKaxRNm81ZoLAkwJ02C/7KB2pKLpHx
	zMc3WBPmh3EZ7zGoBLFbmE3lCXrjT6G1ZUzFKAv30XQbyF9cdg+Dqieaicti+J2C8eoR09CfxfP
	sYAWPZ8rFnQ==
X-Google-Smtp-Source: AGHT+IEiOJtx1L/vRmXs2XCuIRpwv4DZI8C4Zm/hXM1RlAj8t+Am6utsOUHU4zFQZAoy0PPuTzlTeoM7fhXo
X-Received: from dycnl9.prod.google.com ([2002:a05:7300:d109:b0:2a2:2846:c4f7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7f01:b0:2a4:3592:cf7c
 with SMTP id 5a478bee46e88-2a94189ac9dmr16149909eec.32.1764698083732; Tue, 02
 Dec 2025 09:54:43 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:43 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-49-irogers@google.com>
Subject: [PATCH v9 48/48] perf jevents: Validate that all names given an Event
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
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

