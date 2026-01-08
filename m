Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458E3385A3
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899554; cv=none; b=m0SZGE0XxhmOWCgcvVNhQaJRqNn+edrDERFlcWO8W+HSCRYiPZrHKMh5Y7/NB8YUeknhoiACbKCZ93ybutnno4BCXhykGCkuOQbqj2zolDYhxN2Q7vr8aBEACuBrmTRKQA/jVtPVfio869Jkw7raBNpFG8K+gIubcdN7d6jz4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899554; c=relaxed/simple;
	bh=J+f02vC6vGMWfbo7N83jJBpPCUC7ojdATQyc1Sr4ucs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aItbuNuAM5HommVkKroHL8kr8FNRxwEaMlbfIQSFp1Ux+JT0GAZf8rVjiJFchcQFy72YrR/BwjoX9pWjpkto0Xook59ueX620MG0mqNIXjvtQH0/XSfTaadQ1DoCu9euioN0I5Ebf/Ez5DdBEyAA0AS6P6SuVgrhoQxXMs1LP5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RAozLpJY; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RAozLpJY"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11ddcc9f85eso1879809c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899552; x=1768504352; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbXTdK+dMmj1w20jlEWvuTScD9bjGDPfd4CifWDSxbc=;
        b=RAozLpJYhaO/GKIYtwnzpJdIM1oOvT4RpUiZAYEMHD55mnsz+VRxQL1qlsxMbuAhmc
         z7XMLumH09cipxf6lxtWjBLr6Z9bABhtclRDNrY5FDc1HCDbyTW7NaPkYNpgw7KABuSL
         JQKT/k/aTFPF2bOHf1rqkNKKDiUmKw5BYxlvH3tLr9iHUD0+j9fwtupfcSf1QOG59u39
         8I47/3hv0R8XySK8H8x5oX9gMQ4FITkALlHQ9mLkNZOlsdY8znyppRORrn4Gv53wWYlU
         muDIjm2NKZ4LC+gtG6eSu4kW7rfk8d/21PFhKKiaOZ/FFcVQvf9ZuItAmToEBUGeFrLa
         U/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899552; x=1768504352;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbXTdK+dMmj1w20jlEWvuTScD9bjGDPfd4CifWDSxbc=;
        b=DiU2euUGlrcbxCazHkdQ3bPsg1tsrbjTc9Bd9xh/4u5Atn4CZ45K2DQJ3imrD7OYMe
         Cljdek1bgBCpeGRxEQogpKeclRW+O5EHSg0GKhVpalg97LNC5evKvc/PdWW5tSTX9xVY
         ekqspoQyabZhRNzT+0FHoGaRbrc1rtkrHe6dn+v950dhPQmx4nCxouKVmHZBpIgme368
         9mICIHXhyVHNbZzhSoMD+zR2KUpaSU3q+HPFiXBOMmMtSN3TaQpdTRLeXXgwKXlDoiEB
         SduFy+qnJfWXqGY4sz7Rq8dHi23X3KX1spE429GNTJMdLF5tHmNHHL+5Mq6HxzE7C8Mn
         3Raw==
X-Forwarded-Encrypted: i=1; AJvYcCUf8az4Im8Jm6T5fBoc9CDUONZA+x8v7XSZbVRchBplI3S2h+cWMwunkl/fXDO89xhyb4yWeKW6H81Ui7h7CK8x@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbb3+JRe6ViFxnpyAoW6Fxg+CKAZV/lGYjczMqD+OV2cPBCvrm
	uXjNEw30afYzrL78Xx+myZUN7O3NlqoJAlmXjeOWK4AnKI/jzVWkcXYfceLuKAuhKozeN6LgmAt
	9qtb1yOoytw==
X-Google-Smtp-Source: AGHT+IGAA2yE/NJa3SzPn1/ZdLSyNxrmof7l6ODeKVPxDFp55Pp4RwkZHSNTayJhhJKuW5DvwlfGyvIYkpIB
X-Received: from dlbpk2.prod.google.com ([2002:a05:7022:3842:b0:119:78ff:fe11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec88:b0:11b:ca88:c4f1
 with SMTP id a92af1059eb24-121f865e7f7mr6749184c88.20.1767899551756; Thu, 08
 Jan 2026 11:12:31 -0800 (PST)
Date: Thu,  8 Jan 2026 11:11:05 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-36-irogers@google.com>
Subject: [PATCH v10 35/35] perf jevents: Validate that all names given an Event
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

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.457.g6b5491de43-goog

