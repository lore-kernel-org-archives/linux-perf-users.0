Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1068DC433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3FA60E0B
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 17:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbhJMRsx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbhJMRsq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Oct 2021 13:48:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B01C061753
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:46:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y16-20020a2586d0000000b005b752db8f97so3917660ybm.18
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/xV+yd8shPjaclxuqTvIDa73tXcckmYdVvwoghqARxQ=;
        b=kNJqEjH8HEILP8x2KxuakMlpCEGlctokNIlTLHGG42bIZEL+6NAxBqvH6ghU4VEggo
         BVyfMTsys3O3CfhHqlI9iTPOKmLY+dVX5X06eNzaaBx7NDMTPIMSM5GZJjgsom42CEoa
         /YzFSnbY5ApTDGVNpaxh3cFRyqSa7DG+C89Jdyh34FlVZFlOqz50IwhYBwMvL24t6FL2
         pye1WVYKXD64L2aVK0JvVYwl4ZLq8dwcBvBX2WEqVR5Kh/ldApVG7JxJw53OWQcZEqQf
         fyVDQrErbWtLxHivrWGtm7ZxTyayZMWQHftUN9rANyFRBPrOzoCCAMcFJ6wo70UaBVC2
         FySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/xV+yd8shPjaclxuqTvIDa73tXcckmYdVvwoghqARxQ=;
        b=1FIM6KXwAqPtR7yA8SumzwR/t64On4RbmdprIgG6yQe3kF2LGYirxiLtuctkj/j4Am
         5yumN5JVoiKO/vbh1A4THvmLPZcjXCd4ehGLp2pumms3ouMkr8BGu+pnuKVeFIDr/Bme
         EQv2FNQe5C/xRRm+ZzCuOc5DOe+tBzU37WBa6HRHVx+z66DKmW93uidPVMm2K25IqWO3
         pw4dZSMJri5IiXWo2NdZD25kFkHKlTf3rttJVbDe68BfWl841+baUxJ5bQ8ZYhptBsTn
         n66nqqIM/AfQ3DZcE+dWf0pj3nK09vAQU81coyQrV/zhzmllxwXiG8iV4FLUFHDTGQBy
         PsCA==
X-Gm-Message-State: AOAM530qFOe193OOzonPiiBUUL4KEedagewdCiAuOs7M2Lm54ORxJDSx
        zs6yiIkX+dLTczGZYJ1tlQqrzotdOAbU
X-Google-Smtp-Source: ABdhPJwgBN/PZSuLspT5sVvjyAgeaZZ/h/UlYlCoYCGoHGBWDu1hHtIKrhtMlELpREyy3MikUrW5qh1WXOs0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aeaf:8e9e:3df2:aad9])
 (user=irogers job=sendgmr) by 2002:a25:1186:: with SMTP id
 128mr780480ybr.547.1634147200702; Wed, 13 Oct 2021 10:46:40 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:45:50 -0700
In-Reply-To: <20211013174604.747276-1-irogers@google.com>
Message-Id: <20211013174604.747276-9-irogers@google.com>
Mime-Version: 1.0
References: <20211013174604.747276-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 08/22] perf test: Add skip reason to test case.
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
        David Gow <davidgow@google.com>
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
index a6d84feba483..916faeee04ff 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -142,6 +142,9 @@ static const char *skip_reason(const struct test_suite *t, int subtest)
 	if (t->subtest.skip_reason)
 		return t->subtest.skip_reason(subtest);
 
+	if (t->test_cases)
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
2.33.0.882.g93a45727a2-goog

