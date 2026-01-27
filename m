Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224A366074
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539555; cv=none; b=YM2MiYq/Aa13d1B2WHOTOXQfGzMhPRA+fakjzlPoseaKBfiGYzdthxw7FukdsWB4jL61FtJbaFzKznFq3vFiWVW/81GcIuwFLJDYT0q42WyHF55dqZj4XmONGIhxC/yZ5Qb5jmShvfoP7i3BcMBoOSQtTni2Mm93A7DfH0o0P7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539555; c=relaxed/simple;
	bh=bp7wUYlwFQ9u8p8yyH/LWJ+nT+cGLAukFIDqJoid0TM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lIYT46d8V/TwUt+AFNjyPpPxw5R7d9dIp9ye0DaAbCxtmmx1fozhXR2pQ5x4r2T0EEQ/jbwY08iS6WpIlHmVIgoiZUROS8+yJ0isyMVAy35ogzt5sQOpvKOngpK1zc1b/8LJpY3p3ldIJicPCVe650KSJPzjlvfABs3l7ytmYcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1lmNwqFL; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1lmNwqFL"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b72b6fc371so4682940eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539553; x=1770144353; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlwDSvXJTA5pQkOVBh7Jgz1PRQVOZ1b1qdOJqVwcy94=;
        b=1lmNwqFLo6EicyM7YjFBIxNJfVMyw8vRNWwjaMRI6NhrXuorxRrVQ6wpdu5/BW307D
         RKHIV8u3d8ZbKNynJeQdyyFBsL75HRwS7GPibuY22HCdJO2DifiKxqicxPsHZM2CndYI
         CLJnJlpPKlS4qdBBIVWKDg+EjVMmJepQo65IwZdooFYbpPH0jQHyMHJTKOUK/eRedC8e
         m83L/qYJM6ws7Xov5lvPdr4t/yqVGIByOyhbTj/wylrLSIIKUJcFpns7GTpb2eL7fQUe
         VHAX1YaXbQCQJLCz1n8uzq3WQ+9PbOtth7Nnb+UfgZSfC4kbuYWIOfpuOXwu5NOhB16c
         WGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539553; x=1770144353;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlwDSvXJTA5pQkOVBh7Jgz1PRQVOZ1b1qdOJqVwcy94=;
        b=dn6YUAk9TTnpyI48ad2NfsnUlCdEq9iSP6niSpWsiygQLjxULIXYm2AVftC17Kyqmo
         2S7vlMnpx1KeK6ekmRznDy30r7G2MEdV18cmzAnp8VbATpbtSqnMbXrurb9cOGvhykze
         w9nYYMg5Klk2TpHHUu85HYcWv9BEowEj8JR17ixfGQwSGAgsZ3j7xyEWIxPeaCbRVX0q
         PoNzKshmMsTitRqF4oJ1ql3voonC2WwXOcaM2pD2wjWLgFF0WQB5RnfSJTBLDjY4c8Jy
         sx3LqBgwhWbxeJ6TJc7ivAK/PTcECMExbRGhVXfIrOc1mKZvwK79J/LGgGI9HJyA/Tir
         N5Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVSWU7uqWpqTpznG2NPzubv7d9A6byys7cm+MEnrHyKDDT0Ftcg23l6LETIq8p6RAtw4DxH+wMj85+t5Nh2ctSQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyPZkDq4wTf79+lQFZTkEFaCLrjmhG1PWy4cMcj7fUgBsjEENeb
	AxFUihWxGlNUwR/d8Hu2yQZwhjJsOljjn5EjjSuhBrds4Bg/ez1nu7tJFU6bkLoYPC6sUXNWWrj
	i2kBOwcwARw==
X-Received: from dlbrs24.prod.google.com ([2002:a05:7022:f698:b0:124:9f56:9bb7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e0e:b0:11b:c1ab:bdd4
 with SMTP id a92af1059eb24-124a00dfa79mr1639604c88.38.1769539553255; Tue, 27
 Jan 2026 10:45:53 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:45 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-15-irogers@google.com>
Subject: [PATCH v11 14/35] perf jevents: Add CheckPmu to see if a PMU is in
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
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

CheckPmu can be used to determine if hybrid events are present,
allowing for hybrid conditional metrics/events/pmus to be premised on
the json files rather than hard coded tables.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.457.g6b5491de43-goog

