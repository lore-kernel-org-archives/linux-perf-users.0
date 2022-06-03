Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42B6C43334
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Jun 2022 04:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbiFCE5x (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiFCE5w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Jun 2022 00:57:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABAA21832
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Jun 2022 21:57:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30c2aa26ebfso59946337b3.4
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jun 2022 21:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MEQmxhdhzj6Wva0dy8UFtG14viIsjIrwd9QZHTnb4Sg=;
        b=WhkX3pc6B1nQlpibT1FYCsRiyGAaNvybNGGpmlm4CoUsKd3Wlca7WK5LjY5Z/KOsDs
         sdb/q6pSoMbrvKG6pr9gVgnRCEXycNiRCTZmrdiv1j+fIFZ3thVdebsjQ2mPTxKtTKZb
         wD+n0UaX57U6Ht3D61rYEIUV9p0fionYn2lmaYEbbjmbAL1FNBQb36bbvk0x95WWjkrE
         Cg1Ja4E0ue3ND3QaNDiRKi3O0frT587ZQ/LOdDa1bdLjoDRJQiISUvQjXPbKvHgJkZVD
         yA36QkodwQEPa3xec6pEe21dQnQ6GK8NERN1N4TOdvGvGf/Ka8wYO4dWy3xieJQmF8wB
         hAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MEQmxhdhzj6Wva0dy8UFtG14viIsjIrwd9QZHTnb4Sg=;
        b=k2wognEi/L3pOqGT9ITMxkbp+Nu8AdSvzySr14Gwf/Fi5767B/UzwsfyWwL+3k+6n8
         42t3pFjfqtSBFoB0j8s/quCQ9MnSlXjbhoViSDqLfRpnUUdNtFyZh3nRMBb/yt2wFqwg
         NPKLvG2clfVfGskykfC33cvdzxmPKitJ0DJjSppTlL7HSGz2HEI47JYCA6HFw2ddfw2S
         rpW5vVNL2aXoTu7B+7pPxgWq9pLV0nhFL63NinQUKRKkhO+JgOT0mD/c6WYDVXhcQrSN
         uKfJwz8jWj6Lb/wStCgnJIgfPXxEEdF2lyCasTAOVnGWMUo8kQeiQu1WR87+IxJiEtmk
         BhYw==
X-Gm-Message-State: AOAM531zm+jSDA+8u+HDTuOZ4aPK8AusDzChdXPX+dNm3QybWrKx51rY
        DemJCFvru7OwlKrG0HWq20+KccYcyITG
X-Google-Smtp-Source: ABdhPJxC68EAiBGvASOaIPffKNdFKZ0ETYvIPGwdmpWXvlMj0PsDeresPRUqm2vz4oret+2Hq1YldMxgGydC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:7125:61ca:dfbf:5f0b])
 (user=irogers job=sendgmr) by 2002:a25:bd8b:0:b0:657:8392:55c3 with SMTP id
 f11-20020a25bd8b000000b00657839255c3mr9130007ybh.452.1654232269215; Thu, 02
 Jun 2022 21:57:49 -0700 (PDT)
Date:   Thu,  2 Jun 2022 21:57:44 -0700
Message-Id: <20220603045744.2815559-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH] perf docs: Correct typo of event_sources
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Sandipan Das <sandipan.das@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Alyssa Ross <hi@alyssa.is>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Like Xu <likexu@tencent.com>,
        Joshua Martinez <joshuamart@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kevin Nomura <nomurak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The sysfs directory is called event_source.

Reported-by: Kevin Nomura <nomurak@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-record.txt | 2 +-
 tools/perf/Documentation/perf-stat.txt   | 2 +-
 tools/perf/Documentation/perf-top.txt    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index b4e9ef7edfef..cf8ad50f3de1 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -33,7 +33,7 @@ OPTIONS
         - a raw PMU event in the form of rN where N is a hexadecimal value
           that represents the raw register encoding with the layout of the
           event control registers as described by entries in
-          /sys/bus/event_sources/devices/cpu/format/*.
+          /sys/bus/event_source/devices/cpu/format/*.
 
         - a symbolic or raw PMU event followed by an optional colon
 	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 8d1cde00b8d6..d8a33f4a47c5 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -39,7 +39,7 @@ report::
 	- a raw PMU event in the form of rN where N is a hexadecimal value
 	  that represents the raw register encoding with the layout of the
 	  event control registers as described by entries in
-	  /sys/bus/event_sources/devices/cpu/format/*.
+	  /sys/bus/event_source/devices/cpu/format/*.
 
         - a symbolic or raw PMU event followed by an optional colon
 	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index cac3dfbee7d8..c1fdba26bf53 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -41,7 +41,7 @@ Default is to monitor all CPUS.
 	(use 'perf list' to list all events) or a raw PMU event in the form
 	of rN where N is a hexadecimal value that represents the raw register
 	encoding with the layout of the event control registers as described
-	by entries in /sys/bus/event_sources/devices/cpu/format/*.
+	by entries in /sys/bus/event_source/devices/cpu/format/*.
 
 -E <entries>::
 --entries=<entries>::
-- 
2.36.1.255.ge46751e96f-goog

