Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D55AC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Feb 2022 01:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiBAB7K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 Jan 2022 20:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiBAB7H (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 Jan 2022 20:59:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDECC06173E
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jan 2022 17:59:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so30497785ybg.8
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jan 2022 17:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AymeHIyeNEkJXID1khfAkGq+Ez00dJt89KKS/zaptAY=;
        b=DVRS25O9T7ak+jVGUIrWiNg+fYE926ffQOiOpgbtGML9OQYJnrSmRmvr3N33NUN+Cn
         AzBl2uAaArbdXooXe1UXgqzKliziBOBJfBgS8cC64p8rGbI5JpjUpVlYMC4iZ3Us4O7K
         jHhWJbyFrAsViecXR7PK0t9EfH/iRUisEY/I1ZP2YiCOqEXe03mFttBe7i/OhhCl+8dR
         SkCLQl9ZECjiGxVSxEWMEqfTdk2XUzRv2hcuP/XxM50MuVl0hBe9/nl0F8DETKRtyZ82
         PnBl5y+IWpxUS103dsmVKr5BpCcxLSPhdTT5fCoeCWEznTkON5cMKPWby8a238SM75/x
         oBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AymeHIyeNEkJXID1khfAkGq+Ez00dJt89KKS/zaptAY=;
        b=QoXJZ1FQfyCNNEDlaDr0hVHs27hg5nxBRA/IJziJyM/281niXvl3liprQyT81HI9CN
         NHCFtscRVtFWFabLV+glyeoCWaBRsJJ7mAMVyCjkxLX+4T1P/yFcw1C5tjcpPxKIrxPB
         syQdxP6lU1nABqfMoNm6KAO5TfuIV3qOqpYS1ZKftkv4/Vu8aOjoqim/C04KJhkfiPNn
         FH3z6dzMUeFJuTaBX7hRlihEYy665h1f0c9Rcq+GGJI+NZ0k3BQYkEeL6CjZOh0/urG+
         YKl6hPj1V+WOhOkO0w5FeTHzOQDxM8Yrb1S5H8+XiGgn72zhLmrEVUTYGBzOV7wvBI+B
         mhlw==
X-Gm-Message-State: AOAM530VPexFObpF3yEIeiatmMQf51PTSiifvbFAFr/AIzd3zq4IPAOk
        z5X/6idsPeSvsA24vwJifjbNs9CoFPsD
X-Google-Smtp-Source: ABdhPJxA36g6yvOYrzKcHsfyxS34FLtB7j2Yn8STDG6lcr5qTDMiG4ODtKfuPSxGYbAKK3+wnkvSKIeqT1i4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b14e:bc64:b7f6:5d4b])
 (user=irogers job=sendgmr) by 2002:a25:a89:: with SMTP id 131mr33008461ybk.234.1643680746352;
 Mon, 31 Jan 2022 17:59:06 -0800 (PST)
Date:   Mon, 31 Jan 2022 17:58:33 -0800
In-Reply-To: <20220201015858.1226914-1-irogers@google.com>
Message-Id: <20220201015858.1226914-2-irogers@google.com>
Mime-Version: 1.0
References: <20220201015858.1226914-1-irogers@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v2 01/26] perf test: Allow skip for all metrics test
From:   Ian Rogers <irogers@google.com>
To:     Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Some Intel TMA metrics compute a ratio that may divide by 0, which
causes the metric not to print. This happens for metrics with FP_ARITH
events. If we see these events in the result and would otherwise fail,
then switch to a skip.
Also, don't early exit when processing metrics.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index 7f4ba3cad632..e7c59e5a7a98 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -4,6 +4,7 @@
 
 set -e
 
+err=0
 for m in $(perf list --raw-dump metrics); do
   echo "Testing $m"
   result=$(perf stat -M "$m" true 2>&1)
@@ -14,9 +15,14 @@ for m in $(perf list --raw-dump metrics); do
     if [[ ! "$result" =~ "$m" ]]; then
       echo "Metric '$m' not printed in:"
       echo "$result"
-      exit 1
+      if [[ "$result" =~ "FP_ARITH" && "$err" != "1" ]]; then
+        echo "Skip, not fail, for FP issues"
+        err=2
+      else
+        err=1
+      fi
     fi
   fi
 done
 
-exit 0
+exit "$err"
-- 
2.35.0.rc2.247.g8bbb082509-goog

