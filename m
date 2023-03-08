Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B09C678D5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 08:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjCHISF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 03:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCHIR7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 03:17:59 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACB312BEA
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 00:17:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536cb268ab8so163850137b3.17
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 00:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678263475;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywTh5n03SqFTSvl6jepwvheFrqPaSHAy7v4KxsLV2lY=;
        b=k37Zel3K78y2RXeX59p9IX3jO1BCWDMXFQICKa5aOp8uyNc9Fo6TSxvZTfud5WfZmy
         bbuEA9vKQXt/45E7yOe1rPGuM+mMZdsmRRn6Id24WjXl2K6d9t2tSkTCAdqZo8MPrtHH
         LtIotovSED/S9C5a83fKPCgCqx08g01zJw1PTmySborNq9XHGGd6XMIu6CoAvgc5cngS
         GNosj4nFEwQ5YhrGUTIMThG5lmhFeM90/L4ua5aOEMLxBkujfvKftxEGP/ZaMcaTm1GN
         NABl3um2vEo77k4AqR8GYMwWxISH9w59rrhsKaQKcGR37VGDjVOrdvYfEpXIoQ3zQCiQ
         FiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263475;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywTh5n03SqFTSvl6jepwvheFrqPaSHAy7v4KxsLV2lY=;
        b=Y5lqh9GhJvPWTInDJrCET/xVwL61I5AcRr3NvFf8bs45uG2/J70Qt13X1Ev+EskQZd
         DyO3waB/r6a//8J6vXF1TEeS/s3l/pRaqeunuFnzSvNVytsPjJv5nZFgfToFyxS5gcbu
         G7BnBYETk1PFsimgNYfSnz8AqOf2j0XDdslYCEtXC2Pqx5i5Xwz6knq05FSW+kM1oysb
         kwdLLX6fVRRnxmo1iK1PqmiHNm9W1iGu8edc+qCXzxjKwSVY3QzyrP/HgRiJpKvAAwtX
         r8Lzs++KoSaRfqAJGivInuhDGNAV7TAcC25HFuDYO8lvGrTVfdJRPYrmCyHK/YsK7qKk
         WaRA==
X-Gm-Message-State: AO0yUKWLljZ5YiHYUXNn1a/TBJAP8EgLNYreX+e4dF0KMknRJEfwsg2I
        Hqf6bXbguvXs8FcKcJKCVUHSdVme3wkd
X-Google-Smtp-Source: AK7set+/+vEn8fMSc0dc71hwtQ6ZSPMUQDWUafdkCj5lAKVUx8HRElKYsfX5hn/Cg6AXKK1+0RRVejmsbE/f
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a5b:542:0:b0:a67:c976:c910 with SMTP id
 r2-20020a5b0542000000b00a67c976c910mr8271656ybp.7.1678263475634; Wed, 08 Mar
 2023 00:17:55 -0800 (PST)
Date:   Wed,  8 Mar 2023 00:17:21 -0800
In-Reply-To: <20230308081731.1887278-1-irogers@google.com>
Message-Id: <20230308081731.1887278-2-irogers@google.com>
Mime-Version: 1.0
References: <20230308081731.1887278-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v3 01/11] libperf evlist: Avoid a use of evsel idx
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Setting the leader iterates the list, so rather than use idx (which
may be changed through list reordering) just count the elements and
set afterwards.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 61b637f29b82..2d6121e89ccb 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -687,15 +687,14 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
 
 void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader)
 {
-	struct perf_evsel *first, *last, *evsel;
-
-	first = list_first_entry(list, struct perf_evsel, node);
-	last = list_last_entry(list, struct perf_evsel, node);
-
-	leader->nr_members = last->idx - first->idx + 1;
+	struct perf_evsel *evsel;
+	int n = 0;
 
-	__perf_evlist__for_each_entry(list, evsel)
+	__perf_evlist__for_each_entry(list, evsel) {
 		evsel->leader = leader;
+		n++;
+	}
+	leader->nr_members = n;
 }
 
 void perf_evlist__set_leader(struct perf_evlist *evlist)
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

