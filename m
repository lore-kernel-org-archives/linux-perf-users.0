Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A655C43334
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Jun 2022 03:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiF2DkW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Jun 2022 23:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2DkU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Jun 2022 23:40:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D59118E13
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 20:40:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z188-20020a2565c5000000b0066c086258ddso11573760ybb.9
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 20:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8RjJYdBEhWa5aatIqYt/+XHoNzjc8NbJULBjsluYrVE=;
        b=jLGZbFhMtG722wzXR5XwfWchvwR72cPKTIpobAg8wvD70E5RqeB3lvA6SatbU7elpm
         vt+MQ/ZhkpIcW7UVc/hstqVf8mFkPB/fg+GY0qPCwcvb7ofuJSxt9qJlQ2R7j3xV3bPY
         16gVFGNQg1q6fxUo1T41huOihcyeh+17WtTNVCMFjC4YZHCDHisyRfR/Oil2zK73k1HJ
         QIA85R2Ox9X0Jp3eHrZUkY3cNSzh/1Ea64UFWETJowKxFVGfvQkMkDGk1CNtNckoauVn
         FGeyaghBfNu9x65AzTFHcbhTXVSyMeY4ywtEXWXp9YLjG0L83aSjlGaUwa6P8kqjesKY
         SYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8RjJYdBEhWa5aatIqYt/+XHoNzjc8NbJULBjsluYrVE=;
        b=73pR156diJE4Q6Udn0U23yJen6geXCuoVovSY20koNdxM5DkSfB2pTy1YuPa7HIn/b
         bnOS6wgqnsTg8GS8C3CzGmKEoewwFrMb7e9uHnIJ9x0puuW62jRHkb1NE71N9Psn8H5r
         gdlqCLz/t76BH2sGLVNQurGungt7xgFBLPwl02q7P9gm6P1W5JU1mT/XzqOe4K+9RMr1
         7os+BEye2g3j8FrMNtWwMANdP6LZR3Lzm1d1/L0/KcDdiGJR80rKrP4ZfrLyeKIcv80O
         dFkyIxWS0+tTrgTATaRrIfrna9mnA9wapi1do3P/NHvmamKjWtc/rlWStr7R3xef8AHq
         1LOA==
X-Gm-Message-State: AJIora9ekirJgROCVr9JeUpJKXOX8xu9FNY47pXczXUzdecY0kGhkf5p
        mFTUhk2iLnfyqAyXZt/jSdnvHgIOYN+2
X-Google-Smtp-Source: AGRyM1vF1/Ms3NeGo8pVqEI3ypqHRU7b3dURRNAvivVmfK2Vf/5cSVDGylX6xTncJcRD1uf3YUIFQkYp9Rno
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5a1:84fb:df7d:bd89])
 (user=irogers job=sendgmr) by 2002:a05:690c:110:b0:2ec:2d79:eee1 with SMTP id
 bd16-20020a05690c011000b002ec2d79eee1mr1732489ywb.21.1656474018652; Tue, 28
 Jun 2022 20:40:18 -0700 (PDT)
Date:   Tue, 28 Jun 2022 20:40:07 -0700
Message-Id: <20220629034007.332804-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] perf test: Skip for paranoid 3
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Claire Jensen <cjense@google.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add skip tests for paranoid level being 3.
Rather than skipping lines starting "Failed", skip lines containing
"failed" - making the behavior consistent with the previous python
version.

Fixes: ec906102e5b7 ("perf test: Fix "perf stat CSV output linter" test on s390")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+csv_output.sh | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index 38c26f3ef4c1..b165c81fccb4 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -26,9 +26,8 @@ function commachecker()
 
 	while read line
 	do
-		# Check for lines beginning with Failed
-		x=${line:0:6}
-		[ "$x" = "Failed" ] && continue
+		# Skip lines containing failed.
+		(echo "$line" | grep -q "failed") && continue
 
 		# Count the number of commas
 		x=$(echo $line | tr -d -c ',')
@@ -51,6 +50,11 @@ function ParanoidAndNotRoot()
 check_no_args()
 {
 	echo -n "Checking CSV output: no args "
+	if ParanoidAndNotRoot 2
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
 	perf stat -x, true 2>&1 | commachecker --no-args
 	echo "[Success]"
 }
@@ -83,6 +87,11 @@ check_system_wide_no_aggr()
 check_interval()
 {
 	echo -n "Checking CSV output: interval "
+	if ParanoidAndNotRoot 2
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
 	perf stat -x, -I 1000 true 2>&1 | commachecker --interval
 	echo "[Success]"
 }
@@ -91,6 +100,11 @@ check_interval()
 check_event()
 {
 	echo -n "Checking CSV output: event "
+	if ParanoidAndNotRoot 2
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
 	perf stat -x, -e cpu-clock true 2>&1 | commachecker --event
 	echo "[Success]"
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

