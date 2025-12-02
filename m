Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868252C15AE
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694472; cv=none; b=PLmFp5bFmzCJYEA6ybMOAZDBAvYNnmOXG/Ovy0LtWWuwMO3UkP9JoFBiC+7hko5vofvxHj1tgAHEvoNa7Tr3K9+E0/pIwfp0vj7uIH3tpgmtBVORrIgVLbL346+WpVh2iKZ9v60NOT6KgfBUQ7M0scm4ips1fo9Gb/2eFqnaXd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694472; c=relaxed/simple;
	bh=dMPiEJqhTQrqM9jY+GU+CYDgMZtlgTczzFi6ePhvfSc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uL6hGa3eA7pUBaIhZYsOEz/BE41bt+20HpMcravdl2iGTE17p7yHMrls5uuXDRNtn7IX3hvGPd524P5xgZdO4wA2jNmgYgrMohhnGLHNbJTbE5tDxCmBpk77WOpdTQGONstI2SLqRzViAhNVG/BDFAUhfaGIB6emil+Y0RW1/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bl2sqHIC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bl2sqHIC"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-298535ef0ccso63246365ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 08:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764694470; x=1765299270; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K84JVfd6nc0TWm7Ivp9+lw5icoZHps5d9JkR4sf1L5w=;
        b=Bl2sqHICTxzFAhOiNWM0PqhAFUt3MaGkbkY0Ftbt03Sgpi91jn3U5ZngyODhssiA9m
         gLUitEJMT/yHKtNh+GVRUpEB4U56BRziS4XLXlujP9nIIHnABzCneGIquIDF3mC/b1er
         v+9R+fqZThIG+qtV7TKao1pf9kgdLiVEvLbh9Hk7sXlWKDL0fjV4hdGAWdPCw4LJlEQ/
         IhHt4Fl1He1s1lJPukRr3L0nwtDinkN53xTGx276mwMEARI3pUCh813xtQ6UQlEUHon+
         rjcU78SdHuO3M5TH17RmAB991BezS5z0uK7fprNpZ8t3Pj/BKdaL7BhgE+XyWD+MFPx+
         Yvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764694470; x=1765299270;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K84JVfd6nc0TWm7Ivp9+lw5icoZHps5d9JkR4sf1L5w=;
        b=U4xmB1Tc5F8HEipLuCoeILdCc5vItobGsWw9NEWufjG8eiJIgnmpXSV5c8ytRzmBIS
         +RwCrMWpm5sAaq4bqaykuSxHgGFH/AXf3CI0K+kpbwH4QI/j28520bAvg3fv0TJRemrm
         k1FUfo2NwbpHIMbsEcwtj9snadFosLKxOYPS2oxxyODuLNKvbuTTYShGoiu8rnVpk7H4
         xnAbg2bxf2hmrDj6MpV9iXWI5HnRl0hRWaUfeJR6DaxIaTorwJcyBMrjxw1LdZDJUHqj
         dZm/yE4yuK4DJv5H1xPZvpCujo3sxzMr/MiVtjLtge24F/5YYnNZ3wrxfA1X1A6e/at0
         SbKA==
X-Forwarded-Encrypted: i=1; AJvYcCV2VzFKPEaTsgvPaQFuTd3q3hmtW6Nu7fau/etR99tV+C/ijTwc1AltxzRqEDSsrT+2YnkFQFKMN5U+qon3tU6X@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87MzJlmF6MP1hs5XI1jl9GyCPciyqYxpCWaZaLl2tgk+k9Ytu
	acv/wZ4OdoiuaRpvYRseONkrpC6Ru952G5iW4lZe5rkk0axh6Fhr2gO4jXe+IjutjEEtntseKOh
	3SMdxyjprwA==
X-Google-Smtp-Source: AGHT+IGNvaepsZR4Awrvn0eMqZ2433BCbm323MXti+bFgk6bHXo9NjSQ/tb2HlVFmHTPkycQpS3hLDrPIvXr
X-Received: from dll14.prod.google.com ([2002:a05:7022:20e:b0:11d:cfca:1df5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:208f:b0:11b:9e5e:1a40
 with SMTP id a92af1059eb24-11cb3ef2589mr12728800c88.15.1764694469496; Tue, 02
 Dec 2025 08:54:29 -0800 (PST)
Date: Tue,  2 Dec 2025 08:53:38 -0800
In-Reply-To: <20251202165340.555375-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202165340.555375-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202165340.555375-8-irogers@google.com>
Subject: [PATCH v1 7/9] perf vendor events intel: Update meteorlake events
 from 1.17 to 1.18
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The updated events were published in:
https://github.com/intel/perfmon/commit/348f33fae477f281812c32e1c07812b7e35614dd

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 20 +++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 3bed131e242d..558e4f8a1419 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -23,7 +23,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.19,lunarlake,core
-GenuineIntel-6-(AA|AC|B5),v1.17,meteorlake,core
+GenuineIntel-6-(AA|AC|B5),v1.18,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-CC,v1.00,pantherlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
index d4731e300d6d..d3fc04b2ffbd 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -970,7 +970,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
@@ -982,7 +982,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
@@ -994,7 +994,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
@@ -1006,7 +1006,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
@@ -1018,7 +1018,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
@@ -1030,7 +1030,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
@@ -1042,7 +1042,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
@@ -1054,7 +1054,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
@@ -1066,7 +1066,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
@@ -1078,7 +1078,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5,6,7",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
-- 
2.52.0.158.g65b55ccf14-goog

