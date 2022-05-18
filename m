Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD303C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 04:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiEREU4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 00:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiEREUw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 00:20:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039D12127A
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 21:20:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fee45054e4so10669677b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 21:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ulc7jVR4esIc7uAea3k2kp75KCKMXlF4y2JGNUw/UGw=;
        b=bxid9/puL5bhxOXx2DTa8x8S1jgQCq5ay8qtP8LgiP6EyAB9Jn/k76q9uY+42eXvyT
         7ZP0zMdq/j1OnIk//ijsmuz6SH1sN4KDPXScFDLgtlLjwqHonUI8XOUEn1HfFSbhdfJr
         BjWr6JBk+5YusFdxIF/xgJuhHNA8LdL+WFERkJbck2kMhpFWX3H93AAVl1RDqGxoEpIO
         cxU53lF8O8g4Rl+CbZ1W9tMvTGBkhD426abmXzh7kl24a+/5D1A2EYPmhd0wvIrSAgyL
         MITt5pQLPyDvsOgutXaR4QDTMIpr8URZnJ1svgVo/dYHBbohIpIzEv6wr8cZiRWiZy73
         2fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ulc7jVR4esIc7uAea3k2kp75KCKMXlF4y2JGNUw/UGw=;
        b=5PHYboij0IqBPpOzT/RA88d4WhpXD4CVnXQLvzTXqBhAf8q7o6KqO9YIYssS5gpwTX
         Qib6WavQqw1CLRPuqvE5wdjDJZbfSTOLwM+LDIFuQXob40preroqwgw/xhRrZIqqU5bI
         iR00XK5j1XvxT23POzdNpB5OYypnRXsrIgdOccmYqyN2jLxqBk5scKBJtHZnUPIsqqZ9
         jJ066RtY3gKE5QsyOhna/epxgQMotMj6o57eP4Ddps0KcmsRWEE/JYGokk3Z4E89WPQc
         IVAvJJQQL010dWJjerYjNAPr5So0uHkcfpx9eE1vmBM6DajHah8MWyHVSSJuU/Wry1Wb
         m9Qw==
X-Gm-Message-State: AOAM531HO2HHRVHlOR8XWd/s6oZHVV0LEXCbOxFYgbVi5zOdwdN/xDDP
        Ie0yAeS8dpDl0LUSO8NEup2CsW0H46RG
X-Google-Smtp-Source: ABdhPJyi/kenzf5f6IvXdgmpjEuRxks7EA7p2I2jEiPI1ZIU8yY0XO2JOXI4l5qnLfdLCvciyP4mtpcve1ex
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a25:230f:0:b0:64d:76e2:6aa5 with SMTP id
 j15-20020a25230f000000b0064d76e26aa5mr16689099ybj.116.1652847651210; Tue, 17
 May 2022 21:20:51 -0700 (PDT)
Date:   Tue, 17 May 2022 21:20:27 -0700
In-Reply-To: <20220518042027.836799-1-irogers@google.com>
Message-Id: <20220518042027.836799-9-irogers@google.com>
Mime-Version: 1.0
References: <20220518042027.836799-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 8/8] perf test: Use skip in PERF_RECORD_*
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Check if the error code is EACCES and make the test a skip with
a "permissions" skip reason if so.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/perf-record.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 6354465067b8..6a001fcfed68 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -330,7 +330,21 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 out_delete_evlist:
 	evlist__delete(evlist);
 out:
-	return (err < 0 || errs > 0) ? -1 : 0;
+	if (err == -EACCES)
+		return TEST_SKIP;
+	if (err < 0)
+		return TEST_FAIL;
+	return TEST_OK;
 }
 
-DEFINE_SUITE("PERF_RECORD_* events & perf_sample fields", PERF_RECORD);
+static struct test_case tests__PERF_RECORD[] = {
+	TEST_CASE_REASON("PERF_RECORD_* events & perf_sample fields",
+			 PERF_RECORD,
+			 "permissions"),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__PERF_RECORD = {
+	.desc = "PERF_RECORD_* events & perf_sample fields",
+	.test_cases = tests__PERF_RECORD,
+};
-- 
2.36.0.550.gb090851708-goog

