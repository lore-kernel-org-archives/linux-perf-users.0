Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E17C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED8F60273
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242269AbhJORYL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242243AbhJORYE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 13:24:04 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50488C061762
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:21:58 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id q9-20020ad45749000000b00382b7c83aa1so8821183qvx.11
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=saTdX1OS8/RkEbmI7IafbCeo19AfbaExGBL4qsFfKCI=;
        b=CTTi5a4CTUhk7/nowaumv7wyLcNPBLya+Q23bqT+fZEPGNpSvRZiuvdGzljb3SS9VA
         m701i4VunyWbOOemrneCmI6yzgfMhNJU9uofenMBzA2bcuXysuzfeqtyoW7d/czifCd5
         KEgcvZOnFpP6FTkmXZj0cGwiXZUpKPNL+GTVQWmIeTlaAShfNWrGTaLOW9I8i21MiPBU
         uRlzphCv8QrGjerccmW1ThgqFs2YgLpCEqf6tVJk541kBIKc9QEHJy2SzaVSc5B3xwMj
         vzasiC1KinsV78RiZ0dD/dKXCE++0roP6JzFPw8M9P5ZNpYB77FGr9sZ+/bamPe1H44H
         iUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=saTdX1OS8/RkEbmI7IafbCeo19AfbaExGBL4qsFfKCI=;
        b=nBMNG6CVB8KODmV0eBniNj3qKMaQGPPkoC+p5wcSJgx4TlthiNxXbOkzNLlxA0BfCl
         nzyznd1qmGKhAKb/HwKyEykCqioPKx/qwzUccrpp7AYwl2ZGIiOWBzh0YsjBN6FdrcwO
         rqXujJhMr2Z0v6OZYD4aawulnMBlVqwBQ9Hvt/oqph1bVbtJcJFYEAuTYxSZapTnKQef
         IC/aurOTWu3bSgsacvjXov0t1pnEIlTQXpA82uc7FCjpZ0fA0Xhp8sVUHmUKPHdLv3pa
         MZrKbqzi49x2OOsGzoEA148uQhNAvvW7IQGiKDM+vCq4PoZ0ck43Ui4Ikmj4gAHL6dZK
         8Z1A==
X-Gm-Message-State: AOAM530mfMCGaeoJr3fpwcStaRXyVp8/ISmu9gCUMuZyw+pfybMIU1Hh
        CjVrwCHw9hI7KBMD3RD21AIyaZ5jyyY9
X-Google-Smtp-Source: ABdhPJzOKAq5CPIASDYyRYGNTqsz2Gs4ajq2c7AlxB44WdMYCvuoPwSjXSyO6nDYN4rrvtDqdSmX+H0qNoU0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a05:622a:1a90:: with SMTP id
 s16mr11710297qtc.97.1634318517388; Fri, 15 Oct 2021 10:21:57 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:19 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-9-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 08/21] perf metric: Only add a referenced metric once
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>
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

Acked-by: Andi Kleen <ak@linux.intel.com>
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
2.33.0.1079.g6e70778dc9-goog

