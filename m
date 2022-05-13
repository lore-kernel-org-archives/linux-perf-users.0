Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E505C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 May 2022 04:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376929AbiEMEFl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 May 2022 00:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376943AbiEMEFg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 May 2022 00:05:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E018D29B03D
        for <linux-perf-users@vger.kernel.org>; Thu, 12 May 2022 21:05:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g129-20020a25db87000000b0064b0d671050so6249835ybf.6
        for <linux-perf-users@vger.kernel.org>; Thu, 12 May 2022 21:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YnV5trOl0KkVtbfV7+spiE3dNbfJVrO/n7Q27X48qls=;
        b=KAfbU78oWArs3iQP9D8et6l1CENXxZLiD9Xik6r+YK9/Y+/IH5m66bvk4kXon9QT6U
         iwTuHDJFwZl26xdQGjsV1ZaiDEs+NYnJYEp8Q3nmgQNFhHbSkPy4zTtUcjzfBtPyNfqa
         lK8jKjh0H/ufSKjJZsrNC7RTrTXILvWs0vWq2vHWeJrF8hOjWgv0n6GK7kIRb6lgFGWP
         DyRCxS9NBPZvXyz5NwQcWajq7bgxRjYEAZO6T/BV1h0aCCiVjsWl9ltuLGs2IGCC1Fss
         4LCysmf+P+eo/W2hlrke/e+IL2kRaSZ0ozPYYuQizhGpO5j0i+alxiq/l+3ADDmy5gfi
         nqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YnV5trOl0KkVtbfV7+spiE3dNbfJVrO/n7Q27X48qls=;
        b=3KIHxKqT0NDg6Sc4HbJ75oq/yR+28HDwbYb7dsKMqEx5cn97KITGGRNh7Tn3BkVDvX
         iMw8GMCILgAWSM0c+itsnTD81p71nWMbb0CCvTQQQqQmFpYUv92rCEFCEWY04MPmKlz/
         iTuy1SWBMFXpI2OAuZhwZD9igyqu0FJ1iwVsXN+meOD4ynT6elxmneycv1+1/sRQsGnH
         J6kbiu0Xb2K4D/Np1GUn22AGWqD1KwDKftk7t/nmhXpSRFPJgHSWgyx0gB0iGyQPyHsT
         CNksHmw/w0G0QZRwwtgmqgo330eHMTqWFlqE7xNf4PcTsbPJxseu6nzZzc7w/Jv4LqNz
         kckg==
X-Gm-Message-State: AOAM531sfLpOO+xhqpbqy46c9b55Y2Cd73OgiqyD8bW/7H1+xl1/luVI
        5bo7viP4WQjfckCnXwTFh2EQ5xxlDNro
X-Google-Smtp-Source: ABdhPJwQBA1Wj8Te1Bc3ceC61d+MP096QHfl+4mpcj4AdvZwLGmUgP2gIQyb1UNvQW9zY/RiSQ98mZ49Df3J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9b61:c91f:ca29:ae54])
 (user=irogers job=sendgmr) by 2002:a25:e606:0:b0:648:402e:598a with SMTP id
 d6-20020a25e606000000b00648402e598amr2974368ybh.170.1652414733975; Thu, 12
 May 2022 21:05:33 -0700 (PDT)
Date:   Thu, 12 May 2022 21:05:16 -0700
In-Reply-To: <20220513040519.1499333-1-irogers@google.com>
Message-Id: <20220513040519.1499333-5-irogers@google.com>
Mime-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 4/7] perf test: Basic mmap use skip
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

If opening the first event fails for basic mmap it is more likely
permission related that a true error. Mark the test as skip in this
case and add a skip reason.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/mmap-basic.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index c3c17600f29c..32f0a63fa157 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -31,7 +31,7 @@
  */
 static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	int err = -1;
+	int err = TEST_FAIL;
 	union perf_event *event;
 	struct perf_thread_map *threads;
 	struct perf_cpu_map *cpus;
@@ -83,6 +83,14 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		evsels[i] = evsel__newtp("syscalls", name);
 		if (IS_ERR(evsels[i])) {
 			pr_debug("evsel__new(%s)\n", name);
+			if (i == 0) {
+				/*
+				 * Failure to open first event is more likely
+				 * related to permissions so flag the failure as
+				 * a skip.
+				 */
+				err = TEST_SKIP;
+			}
 			goto out_delete_evlist;
 		}
 
@@ -166,4 +174,14 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 	return err;
 }
 
-DEFINE_SUITE("Read samples using the mmap interface", basic_mmap);
+static struct test_case tests__basic_mmap[] = {
+	TEST_CASE_REASON("Read samples using the mmap interface",
+			 basic_mmap,
+			 "permissions"),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__basic_mmap = {
+	.desc = "Read samples using the mmap interface",
+	.test_cases = tests__basic_mmap,
+};
-- 
2.36.0.550.gb090851708-goog

