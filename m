Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED60C77B60
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Apr 2023 07:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbjDZHEn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Apr 2023 03:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbjDZHEK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Apr 2023 03:04:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073583AA5
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Apr 2023 00:03:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-555d93630e7so93710647b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Apr 2023 00:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492586; x=1685084586;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3TpL6YWGjupQ3WBzrUZ30H8DHXRPaH7nMpBJtPSJiI=;
        b=g30x9L8UgdVw6DJHtU2H0uB7Vxe8J7Y+RrY5Qf4ksV/3xQNCmkLP8CoVxeuUuBRtet
         DYV7P/d4ktzTe9C+X7S5fGJFx3DOMqbgeEsnMZJPD/XEkt7mUEUGhLoXbF7Hsx2ULcri
         0GwsN/eY4gbCWv1ZDSark0EkevkkI8UuV6X9FGjhIePbzOm0jXLPJBWecqxuNTGQLNmS
         LTnfOLXHEI1cSJsovHLG4tt5+SmNVW/jJtdc43QO85pRpHpFyEMWej91uUxIZ/6IGyx2
         L1VSkL1TKNDTAbkkYTg4zsMWXWzVfxtD2sPod7xapxxyujytUk6eF/sQMw3SOVa3uQuP
         Zy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492586; x=1685084586;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3TpL6YWGjupQ3WBzrUZ30H8DHXRPaH7nMpBJtPSJiI=;
        b=XXq5XtmXw1OZRISzKEnoAVH1k6QCj7iZfGBQPmasdw4+UiWDP2GqpBU5gDIdia/kdL
         l9B7BhvegX39V4qxbfL9thKNIMnWBpFzm/eXsKPJNw9bdg5puOdifi2RitUvpiUdqXZa
         ol/2G49Wmz3v4YSx527Avq6lc0of3x115GsGAFlNYQefE32YbeKOF8yc89uZYB7x/+JX
         X/o3pBUBiP13Z/eemOKm/p5mUVASCfh3DnfDsJ6hKj2mjq1bO4NCkK3NAnIMtCdaB+w/
         iw5rpiciCzDVT8KbAiYWLl+tOvtVD14qyy/p6u9NFzGlSqHHHz6V/u8Kz6KmQHPQXoGi
         QLjQ==
X-Gm-Message-State: AAQBX9d6QfrGM6DpSbuiLkbFlTaDMkN5SmqReyt30+cnX5+nM9Am46QS
        027DRdh9saNH+IMMsYghq5erSr6SfKMo
X-Google-Smtp-Source: AKy350ZOr84LhTx6WtgtzK7iSlsnlMgnj9gCw6aE0anxQxK4LjR4vAQGIdLpubzDlmqtK2frKlg0jawecRQt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a0d:ec48:0:b0:54f:ae82:3f92 with SMTP id
 r8-20020a0dec48000000b0054fae823f92mr9252414ywn.2.1682492586249; Wed, 26 Apr
 2023 00:03:06 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:26 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-17-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 16/40] perf test: Validate events with hyphens in
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Rewritten event parsing can handle event names that contain components
of legacy events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 6eadb8a47dbf..cb976765b8b0 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2198,18 +2198,6 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 			ret = combine_test_results(ret, TEST_SKIP);
 			continue;
 		}
-		/*
-		 * Names containing '-' are recognized as prefixes and suffixes
-		 * due to '-' being a legacy PMU separator. This fails when the
-		 * prefix or suffix collides with an existing legacy token. For
-		 * example, branch-brs has a prefix (branch) that collides with
-		 * a PE_NAME_CACHE_TYPE token causing a parse error as a suffix
-		 * isn't expected after this. As event names in the config
-		 * slashes are allowed a '-' in the name we check this works
-		 * above.
-		 */
-		if (strchr(ent->d_name, '-'))
-			continue;
 
 		dir = opendir(path);
 		if (!dir) {
-- 
2.40.1.495.gc816e09b53d-goog

