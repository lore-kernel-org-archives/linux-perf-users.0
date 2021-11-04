Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B073EC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7EB60E98
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhKDGpp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhKDGpO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:45:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32566C06120C
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b126-20020a251b84000000b005bd8aca71a2so7513673ybb.4
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CIgm9aOYABDFacjcOgWVtMt5SOTRrDoHBgwN9MizIcI=;
        b=OGVbBuC8tSuhNu2J9IidOZnlDgurGqAmeyH7b7kKE47xnRRjZ/LYscwDRs2XzDTfdO
         VFhOmmGDHIb9Rll/MzC8QCR2B+ds405YW0T5ZeQSTb5fhbmoSgM7ZNTPMnWLElBCqQuH
         LphBTMQhndB128YhgE2dIqFoKjLqvk2515LsyGyqmafvyqj1SNSBoO68mcz1ayDH5Jas
         lGOp6jzsG1Lu5oETNNSZ6xVDMLX8IZvBbb99dHndbpHzWPyP9T7v6RXT1eCAwlk54IgO
         OIFJob4JxiEUy8bpKiK1Hcw0vTQmW0DCxF1duVxBGHKCxy7Nx9Mx1Ra9SgqWPNs1XGwV
         K0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CIgm9aOYABDFacjcOgWVtMt5SOTRrDoHBgwN9MizIcI=;
        b=2V8t5LBL0GrlrZqQq9RN4zmnQPWH3+ME73wBkwjYLCINVrA72Mu+nyflWSdO07YmYz
         gTQXUzGGsdTxx4MTsx025cZAyeevAkPJJVO8lBXD3zccjjHYhsSa4i5OVjUjgQyH8i96
         aAG+3Tsdkk/eCzdwpvsPSKoP9Nojnh+lm/NrS+eGIM7DrgACMWvnhzZM5Jrh44MhC37q
         9nZtQQYX3U84EiHhwsMsbwmKS9xbHRXl4j+/V6l/zw5c+msr1oLg0FdQYeHbNgXfcQNm
         yrgppXcg8qD3w9JnXL54Z0UTWEYnXtLa0WAlppPoD5yxLmseOoiLEi7BMf7LV0s1hwpl
         O0xA==
X-Gm-Message-State: AOAM532pb8hRbuNYqBQIWb9OAq5c3kh0F3rBcQCB1GwDmfsfWrOeaTZO
        Am+hl7Y0EfhJKy1s4Xsmu3ZYeQvxXS+h
X-Google-Smtp-Source: ABdhPJzNwGwarPkdI0jOxicrlMxhkS+xo6wrtcMqGFM0WNni9KjP08LBQRmq4oOnRp/Mj4eGPvdmLxlwFAbU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:2444:: with SMTP id
 k65mr29175919ybk.94.1636008154413; Wed, 03 Nov 2021 23:42:34 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:54 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-9-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 08/22] perf test: Add skip reason to test case.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This doesn't exist in kunit, but will ease the transition from perf
tests.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c |  3 +++
 tools/perf/tests/tests.h        | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index a6d84feba483..db76d7d10749 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -142,6 +142,9 @@ static const char *skip_reason(const struct test_suite *t, int subtest)
 	if (t->subtest.skip_reason)
 		return t->subtest.skip_reason(subtest);
 
+	if (t->test_cases && subtest >= 0)
+		return t->test_cases[subtest].skip_reason;
+
 	return NULL;
 }
 
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 71b8d2c88e5c..f87129b63d92 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -34,6 +34,7 @@ typedef int (*test_fnptr)(struct test_suite *, int);
 struct test_case {
 	const char *name;
 	const char *desc;
+	const char *skip_reason;
 	test_fnptr run_case;
 };
 
@@ -61,7 +62,15 @@ struct test_suite {
 		.run_case = test__##_name,		\
 	}
 
-#define DEFINE_SUITE(description, _name)			\
+#define TEST_CASE_REASON(description, _name, _reason)	\
+	{						\
+		.name = #_name,				\
+		.desc = description,			\
+		.run_case = test__##_name,		\
+		.skip_reason = _reason,			\
+	}
+
+#define DEFINE_SUITE(description, _name)		\
 	struct test_case tests__##_name[] = {           \
 		TEST_CASE(description, _name),		\
 		{	.name = NULL, }			\
-- 
2.33.1.1089.g2158813163f-goog

