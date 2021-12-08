Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5247C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 02:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243811AbhLHCux (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243666AbhLHCuh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CF7C0698CB
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Dec 2021 18:47:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s7-20020a5b0447000000b005fb83901511so2102754ybp.11
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Dec 2021 18:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NkX3KvDSHRuiAq+LRg9aiI3XOvvC67NwXsfw+Gc/9l4=;
        b=VBMi5n0xn14QikZgO1V2df5AmaIlpCWXK5U6dqgZQ+lhdKffn6J4Sj5e21OR8ZY0ix
         QFixu8Hy0X/O8ZQBfBADSfLPJyMOGYy4306E3nA5C9zu+KALzWHHK42XD29Imq04W/Ac
         sWPTVB/DKbXtsRQUEOn0iY1Wr/9EQ1g2tugTwxryT9jvhiulbQafyGOqpJIXpbq49v+L
         cS2h0zy9vhuDo8qwFodW6LaU0ZtaI7EZs62tpjXxE9itf6GWhdE5Hy5NTPAMGnWUfsWm
         hIRvqLxW0gKw8VECXCMMyE4TAnTNNYvh5wP+OI7Oie7x8/Pjju/YR/5oiCrLUvVv68Ci
         7Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NkX3KvDSHRuiAq+LRg9aiI3XOvvC67NwXsfw+Gc/9l4=;
        b=SpKLzqYPYVvU5hDy/VCWht1AxsMXdzZNw/gSjd8a8NabcOFv1rwr1Dfqv25o8rIFwc
         4RnC9M4UY/zmAKVjl3UfGAKMnkKWUuBes67nSza0Meobe3IoqFCuY9oYGrMqv6iSZegG
         eWUG2Iy2jAgCHWzmSwCgFwxMDWkv53gRTR9zYo861RcdWu8GW9bCd1nsfJdwKD40vkrY
         gmdg8xfDrRDU7L+fX5eBsYiLiRQC5c8zOZRUVi0uIaKCi/nmP+JKtoHBwz/ylejRCZVA
         MLaCPj5eGvE2vVIvD8lfxX2dL9t2eHWnPnGjyzhW5b4+jo54S5g0rK8bHD0E0XEedDgC
         AAzA==
X-Gm-Message-State: AOAM5313EwG0JCmJUAr4biI6CzYQJznxLJD6G4GFtse7B0DVQMbR4y4Y
        dVYjQGse8Zxmu7w0fnOs1aYyNoVMwUbm
X-Google-Smtp-Source: ABdhPJyoGRMQihsAu/draf45ckQVcDZHcW0RnmZO7HeS2qA9TqQPXK7+X1r6RHgehf0o7BYpInuzrMLTox9D
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:ad27:: with SMTP id
 y39mr55896029ybi.494.1638931625357; Tue, 07 Dec 2021 18:47:05 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:46:07 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-23-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 22/22] perf stat: Fix memory leak in check_per_pkg
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
        linux-arm-kernel@lists.infradead.org
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
2.34.1.400.ga245620fadb-goog

