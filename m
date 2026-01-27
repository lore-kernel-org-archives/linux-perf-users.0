Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23FB356A0D
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539595; cv=none; b=FqyOjFmamfHNqS1X1gegWXjznVI8Dw7R5U50Dmyl9UehUS0TCJvmqU3z6iZwxMh/fIqoThdxuGPdIDUwZPSK3mUnep8KTVP0//FZSXcjXhabqxR1OFRhh5wd29ocUbGvA7a/pwdF448sqdqlaGTefhK7jO11aWjE5ItP61+KP6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539595; c=relaxed/simple;
	bh=J+f02vC6vGMWfbo7N83jJBpPCUC7ojdATQyc1Sr4ucs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=a3UrFakw1QK/i/fjF8VlsYJYgyh3FfXHlAqtrxAB6VubEQNYGgFhJ/jjum/2Fm+/g00pjEy3FBTUnC63kobaCBPLiDtXo9Y57yJ411ztK9bjlMoFS6ENIANwDlLycTr+AbzV896BIJOfVmpdnxz5p/+TPvMf1yJu2OS266B1HxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WslYIB4t; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WslYIB4t"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124743cf760so5124926c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539593; x=1770144393; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbXTdK+dMmj1w20jlEWvuTScD9bjGDPfd4CifWDSxbc=;
        b=WslYIB4tvvY6N3zionTBQFmFLxHDc2nGAxGF9pc1yydjYnCHynz31f/wafZocfyUOj
         vvv8qccnLl9ArQbJugI8KPenKt9oQe/vF3QlPvunigkGo25niLZ5Y67r1oul5YuSgmYZ
         TnG53xwM+3cML6Dk3x55L/WvXlcyEWsYysX5JElVZVw/hKwqzn1V5DqbPpTF9sXKmDol
         bvb4uPLswRi0fsJvWtFukgCEKDKIyyXHI3W3urtGogDvUKnvl911c246E/X6roeyIBJD
         i0XN5jwV3lq7kZbIpCv5Psey2rvt6UUs1vS4Qol/hlhNrSqixFLYO0M19cc8ZhA8ogZC
         0U7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539593; x=1770144393;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbXTdK+dMmj1w20jlEWvuTScD9bjGDPfd4CifWDSxbc=;
        b=MCkTijoGu5hwkOAxe1tTUHt7hnAlfZm/QJ8QyFDLUhJciv104Z43beXfkvJTuCInAz
         BtM4K1NB1sgAqvGDkBhB59Desby0IxGkLjJJmV72i7bXbNlK5c4u33jZd39yeGQq9I1O
         yMDg+HYZyeBkZZyY9hgnh+kVnS5MtUUxHijDWNIa45TL2ZQ7lnyZsyzNcCS6q8Qlgl74
         XNJuIThUlEhGeNsvk54DTqy5Xu09SnH6T+Vw8ZRNJ4ETAsfp5J53j5217C46mlScXWeJ
         v7R/VIzI1/9OoT1MYuHthv25qB0MwEr0phfylYrYW4qyf6LukPEHzNid4Cy9b/rKnmxW
         wDSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmbk71ORz9kOWMP/U8qYH8qT0w2emQOaY6rLZ728aAbtssNFoP2J0+jZt27bHn4zMF5dt5WmOc+ezHsJpoFrxd@vger.kernel.org
X-Gm-Message-State: AOJu0YyhiC3+IbiwU06R/g8QdHI+yc3PxBrMFmk7eeUAMGf3bKoADMo/
	GtCeQ7U/sgMnD/jOaCDRrmL9GBuBCWqcBjwG+mDIXO7fT0fbszva3/s94YjB7urCm2jnU19Ty7/
	GlIHJXyll2Q==
X-Received: from dlbsv14.prod.google.com ([2002:a05:7022:3a0e:b0:124:9d31:3581])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6082:b0:119:e56b:c762
 with SMTP id a92af1059eb24-124a00df67fmr1557216c88.39.1769539592876; Tue, 27
 Jan 2026 10:46:32 -0800 (PST)
Date: Tue, 27 Jan 2026 10:45:06 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-36-irogers@google.com>
Subject: [PATCH v11 35/35] perf jevents: Validate that all names given an Event
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
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

