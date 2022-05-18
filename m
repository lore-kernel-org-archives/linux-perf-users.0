Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6384C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 04:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiEREUo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 00:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiEREUn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 00:20:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAB16393
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 21:20:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r206-20020a2576d7000000b0064d82e5b692so890095ybc.11
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 21:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kOmtF4LnMuuQ/gYjp/xxv4tsoB08CtJrje0cWKy7hYw=;
        b=hWhJnnH0w5iGS/GIOoqC3YyLdpf9RPFFxzQRXWn1cfjUu8CCUQ1G7gXpOXinWF6KWe
         65MKumXCZHhuUk9OJ8M4piP7avxlCnYNiked6F5G2gyK8kcbS/qAQ2x+6DEJYCbOMmUo
         ah+X6RrmXP+37TkuQkEEkmKiyfPRd+ypteVXqhZDrUi2Ifv79IjRInSdotFycX3lsK0m
         1NuobwHUtsTDL76MFgHI7oVdPrVGSXLFBGyFL4Tk7UiiaNrCqYpLNBa5k0jsDf20xaDu
         Vl5KgOsedi8KooEKXJR1RlkcfrtwKO68u3HhhVDIQs+7x51wHPoG+vw8FhYDWEmGWMzS
         BPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kOmtF4LnMuuQ/gYjp/xxv4tsoB08CtJrje0cWKy7hYw=;
        b=UK+IaMrnMUaBoeVR8q16Uonxq48W3vV/VK8h2LaV/s8NiVJfI/T4p/+z5PV+gAlHJG
         OOxdH6SgQNIG+pkXNasujjBcKCPrhr14c8U+fRkJwt2l9z8DxgOKqKYO1/RvovAwG4bh
         QnRN9sLKHjCsu0tvn1t2mcVqEJT9qNEqwdnaJwVlnpV9xbygNblq4IwVvtf8UK4hWexc
         d8aF/esd2UN95WC/drP/KVIFJLijhrWktpG8DBKmnSCC4FJC0eXeLbHQWdMR5eKdWSMJ
         DMBFydS1XA/rRMSyQ0FA7THjouanoUlD+45MlAJ6t9rIhuAtZybA6K4Ofp6XLwWmBJQ6
         NOEw==
X-Gm-Message-State: AOAM532CDptMM4iUvpWkK0LSVCQgjW7jUs77x9eHUNCEB7acritl7y6m
        AbJoB78fTyfHkvN3ILxD5ePr+zEcWy2a
X-Google-Smtp-Source: ABdhPJwa1yFHsKuws2qp1gAJ3FcCd+gq92TewZjLW654L9XrDnT3QHmktY5N+Lwvws51YRwziIVR33ixRnIZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a25:8b81:0:b0:64b:3ea3:5cd with SMTP id
 j1-20020a258b81000000b0064b3ea305cdmr24520130ybl.542.1652847642452; Tue, 17
 May 2022 21:20:42 -0700 (PDT)
Date:   Tue, 17 May 2022 21:20:23 -0700
In-Reply-To: <20220518042027.836799-1-irogers@google.com>
Message-Id: <20220518042027.836799-5-irogers@google.com>
Mime-Version: 1.0
References: <20220518042027.836799-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 4/8] perf test: Basic mmap use skip
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

If opening the event fails for basic mmap with EACCES it is more
likely permission related that a true error. Mark the test as skip
in this case and add a skip reason.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/mmap-basic.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index c3c17600f29c..30bbe144648a 100644
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
@@ -83,6 +83,10 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		evsels[i] = evsel__newtp("syscalls", name);
 		if (IS_ERR(evsels[i])) {
 			pr_debug("evsel__new(%s)\n", name);
+			if (PTR_ERR(evsels[i]) == -EACCES) {
+				/* Permissions failure, flag the failure as a skip. */
+				err = TEST_SKIP;
+			}
 			goto out_delete_evlist;
 		}
 
@@ -166,4 +170,14 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
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

