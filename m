Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882F8C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 22:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbhKWWvh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 17:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbhKWWvg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 17:51:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C71C061574
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2021 14:48:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e131-20020a25d389000000b005fb5e6eb757so977048ybf.22
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Nov 2021 14:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BE9W5dYXRuteSIzxFKw6y4qrDKv5SGXcrKZqAacKRNs=;
        b=NZNcHbKhOUKQa/aMDyQ7fSvzj/L4di4hDVgLsqBULy9ZUgBQfI5nu9Q737c3x3SdVO
         7P+eF4hYR4WDgTXxZ98G+9hyZAPBtlkDC/yUVVG3locC1T+V0c7Wjr9nFp9jG2N2J9GE
         c+D1HHiEHgJ1QQA8Rual5/uoaDtvh0oEg2CASHbviseqqf6yvJY6QTQnyZ88vO7NiU7S
         YLE39CI2IgPTYx2DlEDZ/X2YGnMJeWXWEKeJD+S/x3Lkjo4Pica7QzD762k65MVS5DVM
         QRqMBcLr0l0pNU6s0BGha15Yei+wKmwhKYPHJ3HxhhRpVDOgkCmUyHcMr0R3hfNW3ntd
         YmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BE9W5dYXRuteSIzxFKw6y4qrDKv5SGXcrKZqAacKRNs=;
        b=ggDIr8AX/8DwjUsMBsrOE2qoPuiM0LV44o3J1wdNM2DPevZB4UqkuKC4FpAYkZnWS5
         /zZA6bzo4ACwrTkc3deAs4nepJpkqES80WMhh8WM5CLJRgsXLHBWgqhLuQ2jWSE67bba
         H24oEmJq8atSh245C+VwWe12+XnoalwRfvFvWRRD4TWTE4+dbGJiEtp6zboCeOTVoEK4
         zzi0yoqSpHvrwCKRZNLLaNG7wsGhiKJ5uDbiFh78bSN+1QN1YYThGpQ0k9qalOe0Y0+p
         RPLzCmxfty1A26PS+LrlhcQEGULFVqnoA9XII5z0km6VMwcJhElksvaUeH/NiRCWrAmz
         YZdg==
X-Gm-Message-State: AOAM531YY975if1zgqsN+mLjSgLM6ncnaIs6IyT13JTrJnRIjH0+UQlw
        RTVvr53gLBXE594QDAnHsE2466myuBAv
X-Google-Smtp-Source: ABdhPJxVD4jOrOL/6lULybhJrF9vv4Aaf751br6ibmeq0qdzyk1Xaw6PeijOaTcYKgzCWCX1oHPLfN9mi7rj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dbab:a6fe:1e3a:91fa])
 (user=irogers job=sendgmr) by 2002:a25:25d2:: with SMTP id
 l201mr10472217ybl.136.1637707707386; Tue, 23 Nov 2021 14:48:27 -0800 (PST)
Date:   Tue, 23 Nov 2021 14:48:20 -0800
In-Reply-To: <20211123224821.3258649-1-irogers@google.com>
Message-Id: <20211123224821.3258649-2-irogers@google.com>
Mime-Version: 1.0
References: <20211123224821.3258649-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 2/3] perf tools: Fix SMT not detected with large core count
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

sysfs__read_int returns 0 on success, and so the fast read path was
always failing.
strtoull can only read a 64-bit bitmap. On an AMD EPYC core_cpus may look
like:
00000000,00000000,00000000,00000001,00000000,00000000,00000000,00000001
and so the sibling wasn't spotted. Fix by writing a simple hweight string
parser.

Fixes: bb629484d924 (perf tools: Simplify checking if SMT is active.)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/smt.c | 68 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 20bacd5972ad..2636be65305a 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -5,6 +5,56 @@
 #include "api/fs/fs.h"
 #include "smt.h"
 
+/**
+ * hweight_str - Returns the number of bits set in str. Stops at first non-hex
+ *	       or ',' character.
+ */
+static int hweight_str(char *str)
+{
+	int result = 0;
+
+	while (*str) {
+		switch (*str++) {
+		case '0':
+		case ',':
+			break;
+		case '1':
+		case '2':
+		case '4':
+		case '8':
+			result++;
+			break;
+		case '3':
+		case '5':
+		case '6':
+		case '9':
+		case 'a':
+		case 'A':
+		case 'c':
+		case 'C':
+			result += 2;
+			break;
+		case '7':
+		case 'b':
+		case 'B':
+		case 'd':
+		case 'D':
+		case 'e':
+		case 'E':
+			result += 3;
+			break;
+		case 'f':
+		case 'F':
+			result += 4;
+			break;
+		default:
+			goto done;
+		}
+	}
+done:
+	return result;
+}
+
 int smt_on(void)
 {
 	static bool cached;
@@ -15,9 +65,12 @@ int smt_on(void)
 	if (cached)
 		return cached_result;
 
-	if (sysfs__read_int("devices/system/cpu/smt/active", &cached_result) > 0)
-		goto done;
+	if (sysfs__read_int("devices/system/cpu/smt/active", &cached_result) >= 0) {
+		cached = true;
+		return cached_result;
+	}
 
+	cached_result = 0;
 	ncpu = sysconf(_SC_NPROCESSORS_CONF);
 	for (cpu = 0; cpu < ncpu; cpu++) {
 		unsigned long long siblings;
@@ -35,18 +88,13 @@ int smt_on(void)
 				continue;
 		}
 		/* Entry is hex, but does not have 0x, so need custom parser */
-		siblings = strtoull(str, NULL, 16);
+		siblings = hweight_str(str);
 		free(str);
-		if (hweight64(siblings) > 1) {
+		if (siblings > 1) {
 			cached_result = 1;
-			cached = true;
 			break;
 		}
 	}
-	if (!cached) {
-		cached_result = 0;
-done:
-		cached = true;
-	}
+	cached = true;
 	return cached_result;
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

