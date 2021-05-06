Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0995C433B4
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 May 2021 22:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E934600D4
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 May 2021 22:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhEFW5p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 May 2021 18:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhEFW5o (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 May 2021 18:57:44 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88972C061761
        for <linux-perf-users@vger.kernel.org>; Thu,  6 May 2021 15:56:45 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id k13-20020ac8140d0000b02901bad0e39d8fso4533052qtj.6
        for <linux-perf-users@vger.kernel.org>; Thu, 06 May 2021 15:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9qAE3ylGIgIN6z2XX1IF/s7yDr0HR2DijcyVu3luS2o=;
        b=LvBA82++LFbBBQHWRIMTP7rmFgicJqfMG3jSxbkB7T5QcBm7BJ0ko3KZrvnZcJdtnm
         Kcny3KUZawdrREvwexS0ova/q8laLz80mZrE5SungnHflsqQf14pO5ZRBw63MoJ3LD3T
         SwV6vIQDNfVqA2EpxLzV+Di6SWndWkDUTXgoKWozhL0gpXGW4h0KtizpTJ64Fy19m6GK
         o55wJfViNi7uF+xX6DVG5qCieptHr+mkJQEzQXPaGA3u+mgZcPeXhjuVkZKYc6sCYNs+
         ZM30VgUj78UB/5yGW+sq4RL5yrFLfERC959kBb/1zm1L8cXv6IwS+VxR/IigKjsUst5B
         Uciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9qAE3ylGIgIN6z2XX1IF/s7yDr0HR2DijcyVu3luS2o=;
        b=I/FPSH16Xxvkn0OWTjvL2bNesLc0j8h4GiF6IcGV1wJfXbjikpzpwZ0u4EQbLjJbC9
         Qg3LukLobc9qrK7tALGlfFu6PEn2uQEpj2W9nvCHvW4Yss1M8W1HfOns19UTTj3bHgin
         lpvv+GLiOGoCcIQ87TkmJ/6qseFyZSxOGNkKWrFvxkMc3C6rflETykvmKWOeRmAVKkea
         eYG9BBHnH3v+m+0txyfTffUE8jh+RfG23LAzKKPFSeu5+lP6rLtsDhO459G1kcp3vOd0
         WpRHuUHtxcD29N+3rkfEgaaJ57gBQ7GkMKZVP2yRC/2F/VsHPZpUjIuw5goAffD2Pi8I
         wOrQ==
X-Gm-Message-State: AOAM5309OQGhPgY1Z2k0gIIFkm0WyBGT8JBZMxxXDHWFp+j9RI03ENHZ
        MWmDsz2jPU+mLNo7ok8TwImXmdX0Zd4R
X-Google-Smtp-Source: ABdhPJxrLR+FGblybNHDE6jvh8Ihl3/eLAPTzEmh/u5wOptAg8BXKztPxYiW9C3O4KAEBdbKjuY1WBRM4tm9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:e9b2:d505:ffb2:fde1])
 (user=irogers job=sendgmr) by 2002:a0c:e486:: with SMTP id
 n6mr6918259qvl.21.1620341804683; Thu, 06 May 2021 15:56:44 -0700 (PDT)
Date:   Thu,  6 May 2021 15:56:40 -0700
Message-Id: <20210506225640.1461000-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH] perf jevents: Silence warning for ArchStd files
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

json files in the level 1 directory are used for ArchStd events (see
preprocess_arch_std_files), as such they shouldn't be warned about.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index ed4f0bd72e5a..7422b0ea8790 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -1123,8 +1123,10 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 			mapfile = strdup(fpath);
 			return 0;
 		}
-
-		pr_info("%s: Ignoring file %s\n", prog, fpath);
+		if (is_json_file(bname))
+			pr_debug("%s: ArchStd json is preprocessed %s\n", prog, fpath);
+		else
+			pr_info("%s: Ignoring file %s\n", prog, fpath);
 		return 0;
 	}
 
-- 
2.31.1.607.g51e8a6a459-goog

