Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F06D3BB3F
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319387; cv=none; b=ROKpMz+G3//XpaVigdhmtvKyMbXDk8saVYt40g/UpiY7/ZYYh/4izLfqQ8c+QAjudcUDG2sRXFyyoc4+DQQifAGUgvhDTPJp6i09E2sgVGJ0BbY3x7hM+QsShX+lJBIvUI3OiOA0nMgvZG14Sp/g02WWC2pznk732EoXOBMPihM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319387; c=relaxed/simple;
	bh=SYzzekKsm56SYljV7D2+Kgk899aiMFZ1uqVugeWMohc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tBF5MxUWieyzbtlHGeKKBLrzydKwAxHSwVGeQVN25HscvXGvDp8EjaCFOsAl4s1QL6mosH2HAc/o9dIqk8knUfxdjkAgWCllVOMpRVXXDj8JlrMbhp7TFb6lGcHRXEtUHjstWqGQOLmoB37GWoG+Ll+dyFqOD782EH899ZuqWlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtFccn+7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtFccn+7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60971264c48so31095947b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319385; x=1709924185; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/hkLOGxFb+NGL6rpwIzI3DU/bCodQ7sPVZDGihfs7c=;
        b=JtFccn+7YxCk4qNDXYazHzLXmlV3Z3oh7BOuZZKHn7etAW3CVaXJg1tCGt0cHcJ7cA
         etYUUdHBtQcUNC8AusKqdipp/GU4vDiGBdIgRpkSSWRZLjng/jpg1MTWDx2lXStUxSyE
         PbPD9UD1+N0c3Eb2h5/EED5HQUoBTsfGpgW7HoWB5P4E19rBG/kdFWhVTrh38oK3tYWU
         7yqfFpJTqNnmW8bubi0IF1O8dg7rIH9UiqB6Vs0gqUdVuADFMZFrwfQXtpg57rj4clYv
         f2kxrH8SEC4a6dGOPqzERuOpgy744CkHOUJE92EQsE8lO45GcjH7fUue0uFzlpJiiB4T
         tzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319385; x=1709924185;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/hkLOGxFb+NGL6rpwIzI3DU/bCodQ7sPVZDGihfs7c=;
        b=X59o8d4G6oE7z/EYUBb2unxO2IEuGYjX0RtYuvuzRFeDG9scSV7MEP5vQDq6efEfXV
         h7OUHNUP+Blu8Mw8urYbOx64JegqVhCxCPh3iGxzhdJtqkTpkKJPFGkjI02ue7n03NeX
         jNBXUEi6ki8QT7pMlffrWhd94IgR0bH4ibwj92NSHeVViSNMmo5vzZZyHVFWWAu6MrIT
         V9lET6CqYiim5nb1tSBv1No8/WTcipTQ2qLIYeJqFeL/YcistuxkZFDr5UJ4Mv7G2mHw
         PTUNIir9Ea1RF+j9PbATOtXbj37ayZtvHxbVsy+uaYfI1t/MZkfA5g/tobuFMzgERMS8
         keuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4NPSa9uAohnrLd9YoUSbgYrvFLVL9/KIoc9wZTkPhFyB/FnTGTR/rhoBafCVf0WOQbRCsFMU3VsQGqnrLL/sBOdloa3SxUhfdxWMlZVPhCQ==
X-Gm-Message-State: AOJu0YzL9yyTo/m4mX28T2t69C2IwR5hrUfhJNHC9K9ddK++pahmG6eE
	QA6Way31iH0J8i6vHlJkzeJleGT29kS6aFKXy/JbkJhzyAPRKcltm0I5lajFilP5d4HWkBgKOJK
	SHm72PQ==
X-Google-Smtp-Source: AGHT+IGXrMDUUSzU6gg4XPlADHX21Or8/UHujHN85RnAMUy671BE6MjzRQ6oTcUcCleDiGdhvAPRQGvVHMLh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1821:b0:dc7:9218:df3b with SMTP
 id cf33-20020a056902182100b00dc79218df3bmr100391ybb.10.1709319385391; Fri, 01
 Mar 2024 10:56:25 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:44 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 05/20] perf jevents: Add CheckPmu to see if a PMU is in
 loaded json events
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

CheckPmu can be used to determine if hybrid events are present,
allowing for hybrid conditional metrics/events/pmus to be premised on
the json files rather than hard coded tables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 7d445e47ae09..0b84506cf2f7 100644
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
@@ -24,12 +26,17 @@ def LoadEvents(directory: str) -> None:
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
 def CheckEvent(name: str) -> bool:
   """Check the event name exists in the set of all loaded events"""
   global all_events
-- 
2.44.0.278.ge034bb2e1d-goog

