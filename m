Received: from mx08-007fc201.pphosted.com (mx08-007fc201.pphosted.com [91.207.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E381A9F8D;
	Thu, 25 Sep 2025 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799735; cv=none; b=IAjr9ZS44zRtTrDNFWw+bpbOnmfQfJiQWm6o7Ns/AZWq2bIGmhbZ8Eb/gQpQNQcW4pWBLqB+zQqEp0i/HsPRreJrIxkzAf3yRxPWDQOZ/IpLzy/ZVZatd9H006Z94wNExFQRXTDfQXSoj+jd70py5T5BawzMRXdM4aEGudthldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799735; c=relaxed/simple;
	bh=n//kQk2JjRVSUucQLoAOM/UlpoLZ1+uIo2vOA+FAf8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oJoYggOTQevpg30z1XThwdYoKSBwRjYcCGboFsdKPFdo9KTt3MqE4svG0SvqZqzPV++cWZnF13MtH/NN6RSBlJjkSz117ndJp9un1HvZvmSkRIjrEzni8P00td6Ruv/cze0295jQlBBPKCJs1VpfrHUDh/MYBBbJogBAC1/NltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=Ul6+Dzbm; arc=none smtp.client-ip=91.207.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="Ul6+Dzbm"
Received: from pps.filterd (m0456229.ppops.net [127.0.0.1])
	by mx08-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58PBQpX83369470;
	Thu, 25 Sep 2025 13:26:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp-2025; bh=xOmvz7K2duDNjI8Wii2EUwvZ
	sLBKheS0OyLyZTw2tNg=; b=Ul6+Dzbm3BEsql8aj4MYod/fg9w2PRH9u0uPMPKA
	uLWTuTxaNaEx4HTd/OZTTZ7OpdBwlRlIxLKRhBzus8k17HhtXYi5QupetjaNDA5y
	zQpDJLUbAR+cGLpWncFpYNOcNrhm2WMkh9ZWl4Y6wx5WGGGUCXwOXJw+6DWkBw/M
	+jQRBup2QRoSvcu0/RZYqBQpW4st6j7fzEVdqNUycvJqe3mC+7vwBowIWG0yLK/Q
	glQklSry3XXu5DWXoxw2iOpZBk8Y8HNssVVO7zUFPfHSimqngdsydDDhe7otyI2C
	bi1rLbbmE0MJIo0+adp+mWOOYP0SEnIJOZGbZW6YG6dU/Q==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx08-007fc201.pphosted.com (PPS) with ESMTPS id 49a8cm1nf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 13:26:51 +0200 (MEST)
Received: from KAN23-025.cab.de (10.100.0.10) by Adranos.cab.de (10.10.1.54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Thu, 25 Sep
 2025 13:27:08 +0200
From: Markus Heidelberg <m.heidelberg@cab.de>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>
CC: Markus Heidelberg <m.heidelberg@cab.de>,
        Mark Rutland
	<mark.rutland@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang,
 Kan" <kan.liang@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf: fix duplicated words in documentation and comments
Date: Thu, 25 Sep 2025 13:26:13 +0200
Message-ID: <20250925112614.78061-1-m.heidelberg@cab.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Adranos.cab.de (10.10.1.54) To Adranos.cab.de (10.10.1.54)
X-Proofpoint-ORIG-GUID: Vgc1ZOC664-Y2YqskuPwBAMnmePj9_eQ
X-Authority-Analysis: v=2.4 cv=Z4bsHGRA c=1 sm=1 tr=0 ts=68d526fb cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=jB6W72bPsc8A:10 a=yJojWOMRYYMA:10 a=pE8xTA70gHHKGE-N-NMA:9
X-Proofpoint-GUID: Vgc1ZOC664-Y2YqskuPwBAMnmePj9_eQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwNyBTYWx0ZWRfX0eUJ7OhaxOaS
 9/rZuJ5Js7/6bBAbT2nOJNPLfkWRckdfunjZfqoXE1Pjfl2IK7V09rhpb+WQpHCie5gkk7T0nqv
 5L18Njf/+XXkSL5CrglD9MtoCdLshvIot/vxYmb5QRnPy4y2D/KnW5wMKpXiBmlcTX6xtW1IiWn
 Vzm2JEdPa9t38TW8GRAFZZAgZ41MkaRjMBV2OV3sCR/gGvaPqdgP1yHrbiolqWLGzB4yhj8ZWQi
 BWsdGtCzqnl8GKc0ur4xjqTtusIGt5dtIl1ePPRHhanK5rgmw6NetsFGBdP3BrIZ3IJHzhJ+92a
 XzQh63lC+emHPWtOjU+Zm0tKrVyLCm1HFvTUQQZxsXz491McAkUZfBvdE+oRHM=

- "the the"
- "in in"
- "a a"

Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
---
 tools/perf/Documentation/perf-diff.txt | 2 +-
 tools/perf/builtin-script.c            | 2 +-
 tools/perf/util/hwmon_pmu.h            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index f3067a4af294..58efab72d2e5 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -285,7 +285,7 @@ If specified the 'Weighted diff' column is displayed with value 'd' computed as:
 
   - period being the hist entry period value
 
-  - WEIGHT-A/WEIGHT-B being user supplied weights in the the '-c' option
+  - WEIGHT-A/WEIGHT-B being user supplied weights in the '-c' option
     behind ':' separator like '-c wdiff:1,2'.
     - WEIGHT-A being the weight of the data file
     - WEIGHT-B being the weight of the baseline data file
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d9fbdcf72f25..f731b6de7f23 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -223,7 +223,7 @@ enum {
 	OUTPUT_TYPE_MAX
 };
 
-// We need to refactor the evsel->priv use in in 'perf script' to allow for
+// We need to refactor the evsel->priv use in 'perf script' to allow for
 // using that area, that is being used only in some cases.
 #define OUTPUT_TYPE_UNSET -1
 
diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
index dc711b289ff5..d1e403c8b70b 100644
--- a/tools/perf/util/hwmon_pmu.h
+++ b/tools/perf/util/hwmon_pmu.h
@@ -37,7 +37,7 @@ enum hwmon_type {
 /**
  * enum hwmon_item:
  *
- * Similar to enum hwmon_type but describes the item part of a a sysfs filename.
+ * Similar to enum hwmon_type but describes the item part of a sysfs filename.
  *
  * This enum is exposed for testing.
  */
-- 
2.43.0

