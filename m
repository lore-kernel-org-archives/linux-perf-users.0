Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E43C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbhL3HWa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbhL3HWC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:02 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B92C061376
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:48 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id f13-20020a17090a664d00b001b10156c751so15400401pjm.9
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=awNrzmXXwhgHegLo/XT1TXhJodtpZbEQSRhdkuOAA7A=;
        b=PG2diDhkb5i7ogEM5VvdDCDHxrJYDQzZwNMq4MtIk6SnVaypQKlShQlUuhPeWSh1Kj
         9M8Nl+9CT0Y/Ky1eReJa4PSxNm1ytCwF+LS/7ujzbJjxZ4+XUVv5Bdk8GosiaZTAl/6M
         8tcxJEC4yJm/wkb+WvldQ1MQYgmCNlxI8hqiLP/wVqcSslcgrguLVYHYPbbblV48U29N
         JV+LjNQSQ6vDw1hMQM96+0C/QIZd/mqyfXunlffbLoNv/HbwW2IBG3Ge8ZA0SLLvTEES
         tJK4vRxJokHa8njyWH4u62vFUlBP1RbQrPlCb7O0keKwoVCaXXVdTVmMZvbTfgRZLWML
         a7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=awNrzmXXwhgHegLo/XT1TXhJodtpZbEQSRhdkuOAA7A=;
        b=jFCKjRagx7D9B2Kkxp5Nc2ARJIGBOLdB2wQo/inlgtUJLDlaixlW4/9snzUGbNlA3h
         iwCkuCUGIpbgg1BTd44E3aZJuG7C1OiYOlY7d0Tad3hgyC2l/mwd832ISyV7LuOvV3Uk
         S3SftxKy9FDWwJmP4Frcv1/+PegbXMNl8xm5Qh8vaURL1c280QQua5rlFt0sQRTP4KN4
         2Hf6BiPVi3bXmVZAOFmQJp74/yf+GpWwSmCzxhA+6iNywGA+E0qQ+ws2EzYxY6X4GEDw
         C9waqnQnacWxKd8vnu1amjlBOEs/VVtBQPWv3pvNrt5EedqjS5laMOJub8a1BZ0BA574
         s2eQ==
X-Gm-Message-State: AOAM533lBsgETf/gpSVHceiTTSNUTXC1Hc/zzaaAF2KdAl97KBZRYspc
        AUiHDq+kAtZEs4eM86M/rTHxdsh0vHYR
X-Google-Smtp-Source: ABdhPJzV/t/Mm6XrZ55WBlWiVBPAgYNKl8mk/J4YgsYsaDqr7uQSS9skiOIuSxze7KHWOuzFZh9/58Wx3cG4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a63:a744:: with SMTP id
 w4mr4176724pgo.142.1640848908047; Wed, 29 Dec 2021 23:21:48 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:10 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-30-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 28/48] libperf: Use cpu not index for evsel mmap
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix issue where evsel's CPU map index was being used as the mmap cpu.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 8028b5a4da69..f1e1665ef4bd 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -252,6 +252,7 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
 			int *fd = FD(evsel, idx, thread);
 			struct perf_mmap *map;
+			int cpu = perf_cpu_map__cpu(evsel->cpus, idx);
 
 			if (fd == NULL || *fd < 0)
 				continue;
@@ -259,7 +260,7 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 			map = MMAP(evsel, idx, thread);
 			perf_mmap__init(map, NULL, false, NULL);
 
-			ret = perf_mmap__mmap(map, &mp, *fd, idx);
+			ret = perf_mmap__mmap(map, &mp, *fd, cpu);
 			if (ret) {
 				perf_evsel__munmap(evsel);
 				return ret;
-- 
2.34.1.448.ga2b2bfdf31-goog

