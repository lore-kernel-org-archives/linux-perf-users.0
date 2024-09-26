Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62948176FB8
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373054; cv=none; b=qAf5fO4FGWneV5Aw3zftZpPsoC4NnLB4Izq6NaUgryf8owtnonuJ/tAFXS6pwRSGkqI5Zu5YmxJP2TtC+jSV/MSLR08RyP6YkogBh3Ra+Sm0emLiSJdlIhQ0u/O6lIIF2Q48fXVvc3RPtBxkrewcYN12b4ouZgzja62Ma5xv/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373054; c=relaxed/simple;
	bh=igdjcVeSBNdpas96QJTqhaTEvBNXZAj2tpTOV09EYxo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nN75Zl1R5DGx73OUVVAD2FKEPdxt89oQ8HAVPj/VZf5c0XWZT6H1WppTVLN6uJeOBGoCJdq+mBO8Ytkz5Gpd1FYMAyLGecTkm+Kg6/LAB6IM7al4EOr/oOwJQhA6yP3BxcsRnaXbxsOSgkAcj40gG10Bd1YK37ZCffwGsjbBkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fqpFoIda; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqpFoIda"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2317d1cb7so17780697b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373052; x=1727977852; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGQgy8ZopxkauWxHyK3qOU/sEGEKBL16T+Yf1IyLOIU=;
        b=fqpFoIdaF0c1UHgxFEjZKHGkOhhlx+lANROBMEUzHnywlGKVuq5x8/Kc4xHWONiwKP
         gIMOtlB7hWU/gUY+QNZq1S5QeJVrmdAPYZpCGqxqNX7w5bysUat25zjbqnWldYA12DoT
         +pOYAexxfGkapsiU8bKiN14MGarY9d1ipch/bQXfHUFyqFGXLec4aLGa3311/RHqDXQ/
         uzzktEFxXrBfY6qh58/Lx7kYDCwHyEMKM/oRu9aOzoy4lAyzjm4cPbKAtJzvqteHF72a
         SiIby2MuB8AqK1g5x9J3KE7z7uaqReriAcWjAnEpeC2zVOCiiPMuE5yD6/PwsJbpXJsF
         lC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373052; x=1727977852;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGQgy8ZopxkauWxHyK3qOU/sEGEKBL16T+Yf1IyLOIU=;
        b=IljOjBPdkRxOu/LjyE3HGyX4cEM7JyfUMjVKWqfDZ11RlBV4vmoowEnAA+jEkmOMYS
         MIXETZtYN1PEeIDDjtOr+fHnE9eNJhnayBohP8Fkz5vlxbkOvYZ9WOrs9Q0btPHLyCf2
         RTfgwrXLd+BA8AxseNv4QXeb0nvCzASdzGIr3A0p39gdpIw2XDaa43GHq9Y8IhOstUAV
         +me/ShvuBrXVODbjX9i/Yl+7pUiP5r0y+4ushfjQKg5PZ3es/4Uxt/Z8I6zJs16E4+sJ
         t4PDqjP/2rAZLCxCXccj9zssGDQIFz8EoJkZEzeGgTr1ps1zLqCGdWZxXbb/F9xhTMbB
         1N/A==
X-Forwarded-Encrypted: i=1; AJvYcCVOiEZxD2tIcymUSRtQPdrTy+YEmkasdhpgSAG8InY/evENaCQkjCmQFl7wFg45wCgFMXaXflsHqjh1A7OuaL+e@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4dq09+GtNlvA6wery1UX8I7KuVPhDcHBCBFqQjeI6yOVwtp5
	a8YBha7rHDAzwWIVGzNe0PYJM/jIHpdXgCRRB4K8xoEDps8UpAXtudXvA/LSq/elXEKh30WvxGx
	TIfxzHw==
X-Google-Smtp-Source: AGHT+IF/LyuuqNsHGggzUKI4CZBBmqUSsh5FFZZC1B7GeNvpGibPGbP95IMucWwg/4DOkUa4ywyqykhVl/uc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:884:0:b0:e11:584c:76e2 with SMTP id
 3f1490d57ef6-e2604b1a4d8mr290276.2.1727373052478; Thu, 26 Sep 2024 10:50:52
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:17 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 04/22] perf jevents: Add CheckPmu to see if a PMU is in
 loaded json events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

CheckPmu can be used to determine if hybrid events are present,
allowing for hybrid conditional metrics/events/pmus to be premised on
the json files rather than hard coded tables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 03312cd6d491..e1847cccfdb0 100644
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
@@ -24,12 +26,18 @@ def LoadEvents(directory: str) -> None:
     filename = os.fsdecode(file)
     if filename.endswith(".json"):
       for x in json.load(open(f"{directory}/{filename}")):
+        if "Unit" in x:
+          all_pmus.add(x["Unit"])
         if "EventName" in x:
           all_events.add(x["EventName"])
         elif "ArchStdEvent" in x:
           all_events.add(x["ArchStdEvent"])
 
 
+def CheckPmu(name: str) -> bool:
+  return name in all_pmus
+
+
 def CheckEvent(name: str) -> bool:
   """Check the event name exists in the set of all loaded events"""
   global all_events
-- 
2.46.1.824.gd892dcdcdd-goog

