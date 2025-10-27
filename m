Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6032F743
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Oct 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591499; cv=none; b=DPb/UwnvDfCUrHVUA2hiDEKwaEavxk/qA+P/paqoYS+uStQBjdCLC3zeAvWmOFE+Ke2RZsY+n+BLHRIp7AOrKn/UUmv1K7F+os02EY7MPJ1tj2ld8ANEP28yWUEwgZflDEwUBLY1aNIeJX5cpWhpAYRrBXJvXoSBk1+Q5Cc+QQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591499; c=relaxed/simple;
	bh=yivRLRreMvYoOKA5pge2HSVernXCUKm/ubBcqD0DE+I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TlNJu5HI32mNKTAIyXGUP3a2yFLROnLk45vVUzxhUmzwJdI2CQZIHj5V0V0Ou3Q1hg5XwkedsQpujN71+4NEYMHINTVQUPqhtQ51jKvWiTjafg/du8eXj9/JZb/7RHC5OS2ZzAGJbwuavcYmS7NQNPxFIQFPIrjHDtnjP1BfmAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQzF42Az; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQzF42Az"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932FAC4CEF1;
	Mon, 27 Oct 2025 18:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761591498;
	bh=yivRLRreMvYoOKA5pge2HSVernXCUKm/ubBcqD0DE+I=;
	h=Date:From:To:Cc:Subject:From;
	b=gQzF42AzaB+QHdZdmupOXxi/ePWgML9rmYT+nyhbvIvRptMAgJvYexjdqnnw6ECjQ
	 ynRmSAwOEXhDbF/sTXAtfFpn0Ov4tnAhQRmlfYXyF4I3epxUZbX5RPmN4Kg2bA93GD
	 3VkXGxRDLEAQJXt+dZOoaku2uxU8YPJzA1TXtAmpS7CaJLP+KkTHiKxFUdQfQT8R7c
	 7GhJzDodqg4qnHkOkfEiP+ioOpoRMRA7lv2ER0SrliXvtHqyWryhfu2JW9sI1vBbMc
	 /17Oxp9nWhY16hx3c4dTRDeAI+OLs/OQI5Bfhsv6lIXobcD5SLYOoJvJPp8zRVijIL
	 2tInbT4esXmlA==
Date: Mon, 27 Oct 2025 11:58:17 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Subject: [RFC] perf tools: Update JSON event description
Message-ID: <aP_AyZAzBBGXaTgR@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Ian,

I'm trying to make this change in the JSON description for hardware and
software events.  But I got a build failure in the empty-pmu-events.c
even after I re-generated it like below.

  cd pmu-events
  ./jevents.py none none $PWD empty-pmu-events.c

Did I miss something?

Thanks,
Namhyung


diff --git a/tools/perf/pmu-events/arch/common/common/legacy-hardware.json b/tools/perf/pmu-events/arch/common/common/legacy-hardware.json
index 71700647f19b1866..c249bdef818688b2 100644
--- a/tools/perf/pmu-events/arch/common/common/legacy-hardware.json
+++ b/tools/perf/pmu-events/arch/common/common/legacy-hardware.json
@@ -1,12 +1,12 @@
 [
   {
     "EventName": "cpu-cycles",
-    "BriefDescription": "Total cycles. Be wary of what happens during CPU frequency scaling [This event is an alias of cycles].",
+    "BriefDescription": "Total cycles. Be wary of what happens during CPU frequency scaling.",
     "LegacyConfigCode": "0"
   },
   {
     "EventName": "cycles",
-    "BriefDescription": "Total cycles. Be wary of what happens during CPU frequency scaling [This event is an alias of cpu-cycles].",
+    "BriefDescription": "This event is an alias of cpu-cycles.",
     "LegacyConfigCode": "0"
   },
   {
@@ -26,12 +26,12 @@
   },
   {
     "EventName": "branches",
-    "BriefDescription": "Retired branch instructions [This event is an alias of branch-instructions].",
+    "BriefDescription": "This event is an alias of branch-instructions.",
     "LegacyConfigCode": "4"
   },
   {
     "EventName": "branch-instructions",
-    "BriefDescription": "Retired branch instructions [This event is an alias of branches].",
+    "BriefDescription": "Retired branch instructions.",
     "LegacyConfigCode": "4"
   },
   {
@@ -46,22 +46,22 @@
   },
   {
     "EventName": "stalled-cycles-frontend",
-    "BriefDescription": "Stalled cycles during issue [This event is an alias of idle-cycles-frontend].",
+    "BriefDescription": "Stalled cycles during issue.",
     "LegacyConfigCode": "7"
   },
   {
     "EventName": "idle-cycles-frontend",
-    "BriefDescription": "Stalled cycles during issue [This event is an alias of stalled-cycles-fronted].",
+    "BriefDescription": "This event is an alias of stalled-cycles-fronted.",
     "LegacyConfigCode": "7"
   },
   {
     "EventName": "stalled-cycles-backend",
-    "BriefDescription": "Stalled cycles during retirement [This event is an alias of idle-cycles-backend].",
+    "BriefDescription": "Stalled cycles during retirement.",
     "LegacyConfigCode": "8"
   },
   {
     "EventName": "idle-cycles-backend",
-    "BriefDescription": "Stalled cycles during retirement [This event is an alias of stalled-cycles-backend].",
+    "BriefDescription": "This event is an alias of stalled-cycles-backend.",
     "LegacyConfigCode": "8"
   },
   {
diff --git a/tools/perf/pmu-events/arch/common/common/software.json b/tools/perf/pmu-events/arch/common/common/software.json
index f2551f1107fd712c..48b31acf402ca325 100644
--- a/tools/perf/pmu-events/arch/common/common/software.json
+++ b/tools/perf/pmu-events/arch/common/common/software.json
@@ -14,37 +14,37 @@
   {
     "Unit": "software",
     "EventName": "faults",
-    "BriefDescription": "Number of page faults [This event is an alias of page-faults]",
+    "BriefDescription": "This event is an alias of page-faults",
     "ConfigCode": "2"
   },
   {
     "Unit": "software",
     "EventName": "page-faults",
-    "BriefDescription": "Number of page faults [This event is an alias of faults]",
+    "BriefDescription": "Number of page faults",
     "ConfigCode": "2"
   },
   {
     "Unit": "software",
     "EventName": "context-switches",
-    "BriefDescription": "Number of context switches [This event is an alias of cs]",
+    "BriefDescription": "Number of context switches",
     "ConfigCode": "3"
   },
   {
     "Unit": "software",
     "EventName": "cs",
-    "BriefDescription": "Number of context switches [This event is an alias of context-switches]",
+    "BriefDescription": "This event is an alias of context-switches",
     "ConfigCode": "3"
   },
   {
     "Unit": "software",
     "EventName": "cpu-migrations",
-    "BriefDescription": "Number of times a process has migrated to a new CPU [This event is an alias of migrations]",
+    "BriefDescription": "Number of times a process has migrated to a new CPU",
     "ConfigCode": "4"
   },
   {
     "Unit": "software",
     "EventName": "migrations",
-    "BriefDescription": "Number of times a process has migrated to a new CPU [This event is an alias of cpu-migrations]",
+    "BriefDescription": "This event is an alias of cpu-migrations",
     "ConfigCode": "4"
   },
   {
