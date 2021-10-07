Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257E5C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A1A61040
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbhJGRAM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242996AbhJGQ7y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 12:59:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB0BC06177E
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Oct 2021 09:57:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso8665118ybq.10
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OwtG3KcDJxke5D774Uab+PiyO85QX1RNGG5ovQh35I4=;
        b=ZIv5H5CoJQJWz3tWkWfYKWgy5tn4MRtuJCihwj9WfaMa5yJhRb2Nn8rmaf7yNVaXBs
         NDrknjUj37h0k4YznfQSqDxwyVjGE+mUjN7GVluoP47gHKz+wmuNRFJdR80m4+0B9Q9D
         5DSBnuuwrt2iM0qFZe91Y8WFnSV7GR3MLUtpyBo/BMO9iiKoKhp2WFroeiLQ8iqMEKzT
         ewmMUvrm9VzjsTziU1eSVZxj6pjwhQpa+J3VGXnfxUpc2NQWX3BbWx3RPs6rLDA1bMXw
         3P+zD4SM5WvQkHzmC7ajYdAzT8NCBB2MO9gYIavdpxLX33f0r5ERZj3c5NnsqPD2F/5L
         b8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OwtG3KcDJxke5D774Uab+PiyO85QX1RNGG5ovQh35I4=;
        b=aD9jF4F4Yq8pDJ7/xGyzT+Lmai+YTQ3BPhbOMIt/dFYGSdvJ1U5hZ11ANPDVKkC0pD
         LaDEfGuzq1/mMpV9uVgOg28qZVOjj9LlTT3x7+s2xUbHPNnr7uQtbKGPmEjodQ1XUTFe
         Zwi3OIZl7GWY3QRb1t8YgaDh4lqQfwMFEg+PCe7oeqyqnsPzhNWyBD1ZUVD4E6SPmTWr
         Ohn7x3JAcVeGrzExzo0WuM4dPB50mKngCg0JsUDnwW5/M7j9qIcT4WA3eu/hl2e1WA6e
         /QXwuwm6Z+D+dFbLJtxqohfkdtqif0TUr9gI4SztcBZH9swRamszczkADJEbt4YqaXpw
         vG/Q==
X-Gm-Message-State: AOAM531oK6r0pg+Pl6KkQxiFxLgYeJHL+tR/y7ixe7NZx/fz3mvYc/3+
        P1PWVRLW3z3GD5oiExqmQoiPvwwSW8oB
X-Google-Smtp-Source: ABdhPJxe5+Ly7EVn336VFPaVmpq3P4GYEHE8cZE+sVDwfR24/Ifl3ueo+wt/UYxaEWVuotrFrE+ukYamM3Zo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:a25:d607:: with SMTP id
 n7mr6776021ybg.96.1633625868586; Thu, 07 Oct 2021 09:57:48 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:34 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-9-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 08/21] perf metric: Only add a referenced metric once
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If a metric references other metrics then the same other metrics may be
referenced more than once, but the events and metric ref are only needed
once. An example of this is in tests/parse-metric.c where DCache_L2_Hits
references the metric DCache_L2_All_Hits twice, once directly and once
through DCache_L2_All.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index e4ce19389258..6c4c51e35aa7 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -870,12 +870,18 @@ static int __add_metric(struct list_head *metric_list,
 		*mp = m;
 	} else {
 		/*
-		 * We got here for the referenced metric, via the
-		 * recursive metricgroup__add_metric call, add
-		 * it to the parent group.
+		 * This metric was referenced in a metric higher in the
+		 * tree. Check if the same metric is already resolved in the
+		 * metric_refs list.
 		 */
 		m = *mp;
 
+		list_for_each_entry(ref, &m->metric_refs, list) {
+			if (!strcmp(pe->metric_name, ref->metric_name))
+				return 0;
+		}
+
+		/*Add the new referenced metric to the pare the parent group. */
 		ref = malloc(sizeof(*ref));
 		if (!ref)
 			return -ENOMEM;
-- 
2.33.0.882.g93a45727a2-goog

