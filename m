Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2E9C77B76
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Mar 2023 03:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCTDjk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Mar 2023 23:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCTDjZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Mar 2023 23:39:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629B42210D
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Mar 2023 20:39:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y144-20020a253296000000b00b69ce0e6f2dso3480794yby.18
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Mar 2023 20:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283548;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWDjPPDoVS0JDf2qDq/S5D6izq+O5FLiZzLIDYhTDcw=;
        b=nLz4ieuq6UQ5762iyzEeXxWSNK23K6yAuzQg63tWTPUIEyVjby55CsOVPeUtvgl1yI
         HcneNx08ADteLp+/O4bi+8YI0ur6CZ7cZBuHbFdrn/k2l5ddq7nfLQILexB0idnupNXt
         w//iLOiyCoxAN57trk5THriviyko0qKJ5C0TCMc24ZSufaekqPSTiY2CwqtDNhcW91BN
         07P8aJ15SRl2/dwVRVr0S6lrQYbmxbFi/IwX/Ecr9HTBRoRLBSVu7S4R3Dm6qFRT66IW
         +ums7G4p3gNHeT9ZvVnnPnnTzYl3upmQoDXnwHM6tvEhQjSqj9mSuYE4OFEdrsf+z/+E
         djGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283548;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWDjPPDoVS0JDf2qDq/S5D6izq+O5FLiZzLIDYhTDcw=;
        b=57qbMvUSTHBUrORuZrPK8p2V5H40xu4DroTMNDQ8oi5KiiCSUkRDwHrygyWO1/D+CH
         ZNHYLNyJ2VGcdfRsh2e0NtwLIp3W+AqF8dqZn9mrLGIFqEMQ6b4MoJG0R6vtqeC6JHUi
         1lEQ1pq5S+LYsac6EsFjgh/SXjslkA2orSwNn7Gnr5RPDSlxTU5U56wqRkHrcir+AWG4
         VIPoS6/HU0zrOBseeK/PuCRWkXraFeT8CGeK5o9WAY8Xje5Asv4fqGWV9R6CkzcYUSyi
         hIzyQ7oe40LZwZ3XBsIKwDZRk62COtvdtop27IvljFv3Pm0VCDq4ElWJVFQWfjiN4lva
         yilA==
X-Gm-Message-State: AO0yUKUAnXf2UXpL8XeIYuuoKjz5nbf3zt44Bveps3XokRgX5Jvt+4Sb
        euJUmF8JcbvioxLGlR+zu92W1Kt/+jOT
X-Google-Smtp-Source: AK7set+e/p/tdOZmnVTvRXJkVG1NofWhKYs0Acw/s+ryqCYiUJ57g7N82BnK7fiHBi5vw8sOBCGCb/J/FUzC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a81:af02:0:b0:541:822f:af40 with SMTP id
 n2-20020a81af02000000b00541822faf40mr9649912ywh.10.1679283548003; Sun, 19 Mar
 2023 20:39:08 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:37:52 -0700
In-Reply-To: <20230320033810.980165-1-irogers@google.com>
Message-Id: <20230320033810.980165-5-irogers@google.com>
Mime-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 04/22] perf test: Fix memory leak in symbols
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

machine__delete doesn't delete threads. Add call to delete threads
ahead of deleting the machine.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/symbols.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index 057b16df6416..0793f8f419e2 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -38,6 +38,7 @@ static int init_test_info(struct test_info *ti)
 static void exit_test_info(struct test_info *ti)
 {
 	thread__put(ti->thread);
+	machine__delete_threads(ti->machine);
 	machine__delete(ti->machine);
 }
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

