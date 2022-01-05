Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116B2C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jan 2022 06:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiAEGP3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbiAEGO4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:56 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7D0C0617A0
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jan 2022 22:14:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i65-20020a252244000000b0060b2e5fd54cso56202894ybi.13
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jan 2022 22:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r8DPKd9/Sw54Ic+0J53LiDeJxVBy3KIktvCz7ol2teU=;
        b=HBMlA2KadWcwX2FzLRQ5h+1YJL9X3Dqma5iVPe+Xqm2XydhFFUMHc6CqJURQW/7C8B
         TL8VX3FBbdJWzc66C0vhI83a6bNagUWRbWe6FVWqRisLvGAZGOyUHeA+MVQ7vbCk9nzW
         Z/SBP93UGVNl2wH0DunhBTatoQdlqY1VeTKtW1Y0RUd9D40bDnVT+V1vbxpvx0FiAr+C
         rLKdmkh0aVltbOvt/AuM5d8TzHhaIMgV8vGJcK7rj+kavpOlIQEGDmwR7Fx44biaFQVb
         cJipVtLYk97VvX2imuKTUSWn8RSrv3vL+ZwxU92kQQ5IraQirXAuZid2mxHu+JfWmBeA
         koeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r8DPKd9/Sw54Ic+0J53LiDeJxVBy3KIktvCz7ol2teU=;
        b=Z790nKGiYZd4mucCIxnZFAAuyJ1ecp0o88Pe6ADVOtlxFjP78uTsQk0cQB+7kkbC5O
         gdpYomPtAoV2ZINO6IR7/0amjAp2cw4sEgpAwlhLS/zexd6hQm+aawPyDs1dSQzP2dT9
         ZESmIyQw7Y/A8+lf/JJRdfFxCobz+45NSkb7JkQ9Bsdlu2orfxvjndoHLl/oxXe7UiEK
         sPoassPcF6dK7uybVSAI5bMEROxMa6EScNY6WKk3are8lMCKcmmMX8xyDsBN5vefEc+g
         XXwmhlJTsCQaY+SoMXUDZmBtGEc3CwVu6iWPADILxfgfb1cRQil4cTtXMD6Crwc774Rv
         qq0A==
X-Gm-Message-State: AOAM531Hs4T82eI1q79VlurtpyvGa0iUSyWJOlKcn6goJGkp4qo5391G
        pPmbWBDbqkCmyr62EnL5gShOG4v8Ian2
X-Google-Smtp-Source: ABdhPJwMnPpSXvqStwNRxjWDSxSYlgpyBmDjbRt440xLrEAxRu1GX1iqvkntwe1DCVc13O39DOH+OJYRg+Ny
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:4cc5:: with SMTP id
 z188mr67981499yba.248.1641363294753; Tue, 04 Jan 2022 22:14:54 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:26 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-24-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 23/48] perf stat: Fix memory leak in check_per_pkg
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

If the key is already present then free the key used for lookup.

Found with:
$ perf stat -M IO_Read_BW /bin/true

==1749112==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 32 byte(s) in 4 object(s) allocated from:
    #0 0x7f6f6fa7d7cf in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x55acecd9d7a6 in check_per_pkg util/stat.c:343
    #2 0x55acecd9d9c5 in process_counter_values util/stat.c:365
    #3 0x55acecd9e0ab in process_counter_maps util/stat.c:421
    #4 0x55acecd9e292 in perf_stat_process_counter util/stat.c:443
    #5 0x55aceca8553e in read_counters ./tools/perf/builtin-stat.c:470
    #6 0x55aceca88fe3 in __run_perf_stat ./tools/perf/builtin-stat.c:1023
    #7 0x55aceca89146 in run_perf_stat ./tools/perf/builtin-stat.c:1048
    #8 0x55aceca90858 in cmd_stat ./tools/perf/builtin-stat.c:2555
    #9 0x55acecc05fa5 in run_builtin ./tools/perf/perf.c:313
    #10 0x55acecc064fe in handle_internal_command ./tools/perf/perf.c:365
    #11 0x55acecc068bb in run_argv ./tools/perf/perf.c:409
    #12 0x55acecc070aa in main ./tools/perf/perf.c:539

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 5c24aca0968c..c69b221f5e3e 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -345,9 +345,10 @@ static int check_per_pkg(struct evsel *counter,
 		return -ENOMEM;
 
 	*key = (uint64_t)d << 32 | s;
-	if (hashmap__find(mask, (void *)key, NULL))
+	if (hashmap__find(mask, (void *)key, NULL)) {
 		*skip = true;
-	else
+		free(key);
+	} else
 		ret = hashmap__add(mask, (void *)key, (void *)1);
 
 	return ret;
-- 
2.34.1.448.ga2b2bfdf31-goog

