Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C863D;
	Wed,  5 Jun 2024 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596406; cv=none; b=ff/KOvYa5dvRPtBXt1cmJS1yqQfCKbfEi39o2OXsrJ+suu/vlytfgZrp8om6vIIaRgYyPMULRGTY/Q9t7uLDJrtN9xlh2Id5n6JwSCct7HJ65dpG/awtLO5ksJPJLv4Kc1qixw0P8vk1/+Z5fiz+BVkIyWBryson6gkbpJhmK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596406; c=relaxed/simple;
	bh=5L3ycicBDAFMTgbU2z0VnBgN5rrFT5CqYmGZGAK1Yfc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hBqMV3WknZNkcIFtwcPYaXLT54qzVQu8jNQ4JTUkp3MDQHw8VqLFjFbMUAsk+BrkeMZeoRqLcQDlZmC5xRE8Bp/hvi3ZgDpPr+SARm+CYjdjZxA7QWU3a3c5zJTz+8N5wuQcUMnE9YtaAkUMi8ctGMh5PQfomdJ7LKN+Wzk70Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FKCYUlxA; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FKCYUlxA"
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455Bop5o018601;
	Wed, 5 Jun 2024 16:06:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=RywoIJl3pKPsvFCUc8QGsg
	MMilGIvPLCqmf45EgL15g=; b=FKCYUlxAmd3u6c3p/LCT9rjUoCMJnWdLzHpT2T
	JceHQQz9WxwEw24VKeO35gErNtf2bOLpf2jcaBAJmMM5Ho+nr7jkuSpMiGC8hhXO
	bWpK4SdG58ZWjaFHEHAPSRZ5mg6tkAJ62MnuYFIGN9WLn7yaSJLB0/3l4fXIB61m
	L3nsAyaoZpF7BoBJspa2yMF8WGb793yGxaBjNqeNVuJ3BZnELLrOqh+IRvVDYxaW
	ZNEzpJtaBNiBwaYo2m3Qd5BP1hRlWA7Tp6YQx/nce1Bc4shz8u1In7irXaMZgrDZ
	WkBx6anbiVppfcoSplXW0JfrcNqKC3r2EBWr3/COUNmQ9kEg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ygekhyn5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 16:06:07 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2D15640044;
	Wed,  5 Jun 2024 16:05:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 05D7C21A90C;
	Wed,  5 Jun 2024 16:05:01 +0200 (CEST)
Received: from localhost (10.48.86.107) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 16:04:58 +0200
From: =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clement.legoffic@foss.st.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        John Garry
	<john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>
CC: =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clement.legoffic@foss.st.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] perf: parse-events: Fix compilation error while defining DEBUG_PARSER
Date: Wed, 5 Jun 2024 16:04:53 +0200
Message-ID: <20240605140453.614862-1-clement.legoffic@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01

Compiling perf tool with 'DEBUG_PARSER=1' leads to errors:

$> make -C tools/perf PARSER_DEBUG=1 NO_LIBTRACEEVENT=1
...
  CC      util/expr-flex.o
  CC      util/expr.o
util/parse-events.c:33:12: error: redundant redeclaration of ‘parse_events_debug’ [-Werror=redundant-decls]
   33 | extern int parse_events_debug;
      |            ^~~~~~~~~~~~~~~~~~
In file included from util/parse-events.c:18:
util/parse-events-bison.h:43:12: note: previous declaration of ‘parse_events_debug’ with type ‘int’
   43 | extern int parse_events_debug;
      |            ^~~~~~~~~~~~~~~~~~
util/expr.c:27:12: error: redundant redeclaration of ‘expr_debug’ [-Werror=redundant-decls]
   27 | extern int expr_debug;
      |            ^~~~~~~~~~
In file included from util/expr.c:11:
util/expr-bison.h:43:12: note: previous declaration of ‘expr_debug’ with type ‘int’
   43 | extern int expr_debug;
      |            ^~~~~~~~~~
cc-1: all warnings being treated as errors

Remove extern declaration from the parse-envents.c file as there is a
conflict with the ones generated using bison and yacc tools from the file
parse-events.[ly].

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
I don't know how bison and yacc work together.
To me if those symbols are already generated (I don't know how), we
should get rid of them in the source file `parse-events.c`.
For my knowledge, if someone has the explanation of how they are
generated, I am interested as I didn't find any link to some part of
parse-events.[yl] files.

To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
To: John Garry <john.g.garry@oracle.com>
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/util/expr.c         | 4 ----
 tools/perf/util/parse-events.c | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index b8875aac8f87..b2536a59c44e 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -25,10 +25,6 @@
 #include <math.h>
 #include "pmu.h"

-#ifdef PARSER_DEBUG
-extern int expr_debug;
-#endif
-
 struct expr_id_data {
 	union {
 		struct {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6ed0f9c5581d..8d5fb05f20c2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -31,9 +31,6 @@

 #define MAX_NAME_LEN 100

-#ifdef PARSER_DEBUG
-extern int parse_events_debug;
-#endif
 static int get_config_terms(const struct parse_events_terms *head_config,
 			    struct list_head *head_terms);
 static int parse_events_terms__copy(const struct parse_events_terms *src,

base-commit: c3f38fa61af77b49866b006939479069cd451173
--
2.34.1

