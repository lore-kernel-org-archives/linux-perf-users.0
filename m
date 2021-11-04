Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500F2C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3009E60E98
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 06:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhKDGpn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhKDGpM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 02:45:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C8C061227
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Nov 2021 23:42:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q7-20020a25b007000000b005c1d1377abdso7341004ybf.23
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Nov 2021 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yz1NzSnO7t8LqDYgq7GV+A2XU6W8gVjMPj9Z9Ki7ucw=;
        b=SR3dOpqyqXpmZvcfIdf7nq8vdphhFx+uDJvHoZYq4CqL6zkVcmIZSO0aR71yx2yxfI
         3UZD9JTUbPVtK5ppOkcaoiOR/IVpqPBHp29SfJZFJbIoMOKyfyPK9Kd2ROZ+n4Fd0ic6
         CqF8XHZn2KdIk9F1Z6V06O84EnW7T+esj4hsX2awhxJhnIv3ofIthJhRDAwu9k9uCFVg
         HfYxZbQIpNHBXVwzHMkzHNncWiDlK3lmH0MO6/qXmvl30PUHtmi0vDkz/nShIKp8/Dp1
         UpVuNeau0sHLgGJaDNfvyaT2I2AZtqrzz8M5tCMlqwALYtscsOf5KWlhnDReeaeivLwU
         /6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yz1NzSnO7t8LqDYgq7GV+A2XU6W8gVjMPj9Z9Ki7ucw=;
        b=RXCJo11cMWR3/RnfBEZkjDsK3NSjkPSL8JWktlJcpPTlUNk6kYThMahF3JMoC5g+TH
         T94o+bpMyvWREb6kEyBjBH2oXPmVrwSOG7c2IjE28A8qzYiGd8Agu+6VXNLOrJAtBqrV
         EnjM6zoOzP+RkPpFCK017dz7LAZVVztZYltlXCXVrjyemUQCb00VhC5Vy5iRkd8C65Td
         d+DS5isJGp2JTbYsP0ojMBe5VOHqKleKNeGmKfczrfJ3KRtVn36j/3u5fHOBQkkjBnjb
         Q7lLH2CnOTZOE6pnv01+hYeGNdOMemHiojQXzAG47zDCxJaQ0b5TG5iAGoXlJW76YbBs
         21VQ==
X-Gm-Message-State: AOAM530oT/hQTUpD9FDaJoX6OWU1BYsSIsfMItYk+One8D0gO6ohzdBi
        Zgt3pO9Dz+XxKI3Ob/95iZhuQTq+pvYM
X-Google-Smtp-Source: ABdhPJw2zxdq6e9x11HcUMOMxj3W1AhMqih+YXDNUXWtZdgJ56VOK3mqaZqxWoaD6Eop6sHyQx8vWFDSk5XH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:e6cc:: with SMTP id
 d195mr42141687ybh.83.1636008152017; Wed, 03 Nov 2021 23:42:32 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:53 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-8-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 07/22] perf test: Add test case struct.
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

Add a test case struct mirroring the 'struct kunit_case'. Use the struct
with the DEFINE_SUITE macro, where the single test is turned into a test
case. Update the helpers in builtin-test to handle test cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 30 ++++++++++++++++++++++++------
 tools/perf/tests/tests.h        | 26 ++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 96eb486ffbc9..a6d84feba483 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -117,10 +117,19 @@ static struct test_suite **tests[] = {
 
 static int num_subtests(const struct test_suite *t)
 {
+	int num;
+
 	if (t->subtest.get_nr)
 		return t->subtest.get_nr();
 
-	return 0;
+	if (!t->test_cases)
+		return 0;
+
+	num = 0;
+	while (t->test_cases[num].name)
+		num++;
+
+	return num;
 }
 
 static bool has_subtests(const struct test_suite *t)
@@ -138,10 +147,13 @@ static const char *skip_reason(const struct test_suite *t, int subtest)
 
 static const char *test_description(const struct test_suite *t, int subtest)
 {
-	if (subtest < 0 || !t->subtest.get_desc)
-		return t->desc;
+	if (t->test_cases && subtest >= 0)
+		return t->test_cases[subtest].desc;
 
-	return t->subtest.get_desc(subtest);
+	if (t->subtest.get_desc && subtest >= 0)
+		return t->subtest.get_desc(subtest);
+
+	return t->desc;
 }
 
 static bool is_supported(const struct test_suite *t)
@@ -149,9 +161,15 @@ static bool is_supported(const struct test_suite *t)
 	return !t->is_supported || t->is_supported();
 }
 
-static test_fnptr test_function(const struct test_suite *t, int subtest __maybe_unused)
+static test_fnptr test_function(const struct test_suite *t, int subtest)
 {
-	return t->func;
+	if (t->func)
+		return t->func;
+
+	if (subtest <= 0)
+		return t->test_cases[0].run_case;
+
+	return t->test_cases[subtest].run_case;
 }
 
 static bool perf_test__matches(const char *desc, int curr, int argc, const char *argv[])
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 5139e24973cc..71b8d2c88e5c 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -31,6 +31,12 @@ struct test_suite;
 
 typedef int (*test_fnptr)(struct test_suite *, int);
 
+struct test_case {
+	const char *name;
+	const char *desc;
+	test_fnptr run_case;
+};
+
 struct test_suite {
 	const char *desc;
 	test_fnptr func;
@@ -40,6 +46,7 @@ struct test_suite {
 		const char *(*get_desc)(int subtest);
 		const char *(*skip_reason)(int subtest);
 	} subtest;
+	struct test_case *test_cases;
 	bool (*is_supported)(void);
 	void *priv;
 };
@@ -47,10 +54,21 @@ struct test_suite {
 #define DECLARE_SUITE(name) \
 	extern struct test_suite suite__##name;
 
-#define DEFINE_SUITE(description, name)		\
-	struct test_suite suite__##name = {		\
-		.desc = description,		\
-		.func = test__##name,		\
+#define TEST_CASE(description, _name)			\
+	{						\
+		.name = #_name,				\
+		.desc = description,			\
+		.run_case = test__##_name,		\
+	}
+
+#define DEFINE_SUITE(description, _name)			\
+	struct test_case tests__##_name[] = {           \
+		TEST_CASE(description, _name),		\
+		{	.name = NULL, }			\
+	};						\
+	struct test_suite suite__##_name = {		\
+		.desc = description,			\
+		.test_cases = tests__##_name,		\
 	}
 
 /* Tests */
-- 
2.33.1.1089.g2158813163f-goog

