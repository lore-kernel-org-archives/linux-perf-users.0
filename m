Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E46C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Nov 2022 07:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiKPHNP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 02:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiKPHNJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 02:13:09 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33A12018C
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 23:13:08 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id r126-20020a632b84000000b004393806c06eso8866604pgr.4
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 23:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVCMLdIaGKYl515v9BSPBB+0JzpaXzttaEc2YraX+wA=;
        b=YBypCi/EgROQraVH/pC6M9CYoxe2JUhU33fWhx/1ZIT2+vPvTKkBb3E6wsNNiCtmO1
         T52/NNdz/qmL4tHIZzdA8Jid+rFwh5E1mxSJU/rQe9N2flMehzZ5+KYViypk9Gap8Ipa
         ycW4RH5w/HD9PtSzaCepkSW4ZQV7kGaS4pxw5rhdoJZNASDkmL2H1ZcUo5iquj78GHh2
         o32wRcdJS1LgBhX475WE6YVdIPvjqSmKdEM4XEe4Gw8d9rPMCqH3ZZWU31bxu+0yAGXw
         G79ILt8QsdeDMgoSGREhRNzYWZF4Kmu5qJAZih6OttXSgEePNViLoSm9Om/k5GdcSuqS
         sGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVCMLdIaGKYl515v9BSPBB+0JzpaXzttaEc2YraX+wA=;
        b=m5Ym5CAPwGKhIKnGrvk5/ZG6i4dlcZ/e18krQmJmteaIAA8fKBm2mzYPXr6ChP8Ajy
         JEGFIMt2lITlBElhci6HJZmB/ur0n/BYdCRj1DP0R2sojXGVJqYYhO7fvudjFNjPvdng
         vd3Uh4absO5cakuoQaS9ScuaJn39/g0vtnGDCU+hICg3Zsu9Vdz6znRU4PZb3wsWpeeW
         G6+GvincK3NQLantekkR57rtHy9MLPEJ5BaMrc8iT/S9U++wX7CEL2sHvrWXbG9k7y7O
         ZN1g4o8dzj7Ssi37u6Y6eH9HocO5tMZJqmUEB26eHpvQT6KgAx6k6EOKVBh5E4RgT6ht
         UBtA==
X-Gm-Message-State: ANoB5pk9cKsgZV7gBe5HCXgcd0gSdunjnIVyAoylKxesD80sJWm+t2mS
        NY+jTD6cWvnoG568/ti8WmJ+xpckTkTk
X-Google-Smtp-Source: AA0mqf5yOlyfg23shcD/S8pZEuV65Yr6XU4+Cu8EefLfLGvQd24JxozE1zWMO4ySuQt8AswjPsOipUHBRcJt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf0f:58f3:342e:c1ec])
 (user=irogers job=sendgmr) by 2002:aa7:8f0d:0:b0:56b:d738:9b with SMTP id
 x13-20020aa78f0d000000b0056bd738009bmr21882110pfr.61.1668582788294; Tue, 15
 Nov 2022 23:13:08 -0800 (PST)
Date:   Tue, 15 Nov 2022 23:12:57 -0800
In-Reply-To: <20221116071259.2832681-1-irogers@google.com>
Message-Id: <20221116071259.2832681-3-irogers@google.com>
Mime-Version: 1.0
References: <20221116071259.2832681-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 2/4] perf list: Support newlines in wordwrap
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Rather than a newline starting from column 0, record a newline was
seen and then add the newline and space before the next word.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 0450fbfd0a5c..43c635d58627 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -73,17 +73,19 @@ static void wordwrap(const char *s, int start, int max, int corr)
 {
 	int column = start;
 	int n;
+	bool saw_newline = false;
 
 	while (*s) {
-		int wlen = strcspn(s, " \t");
+		int wlen = strcspn(s, " \t\n");
 
-		if (column + wlen >= max && column > start) {
+		if ((column + wlen >= max && column > start) || saw_newline) {
 			printf("\n%*s", start, "");
 			column = start + corr;
 		}
 		n = printf("%s%.*s", column > start ? " " : "", wlen, s);
 		if (n <= 0)
 			break;
+		saw_newline = s[wlen] == '\n';
 		s += wlen;
 		column += n;
 		s = skip_spaces(s);
@@ -145,7 +147,7 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 		wordwrap(desc, 8, pager_get_columns(), 0);
 		printf("]\n");
 	}
-
+	long_desc = long_desc ?: desc;
 	if (long_desc && print_state->long_desc) {
 		printf("%*s", 8, "[");
 		wordwrap(long_desc, 8, pager_get_columns(), 0);
@@ -153,7 +155,8 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 	}
 
 	if (print_state->detailed && encoding_desc) {
-		printf("%*s%s", 8, "", encoding_desc);
+		printf("%*s", 8, "");
+		wordwrap(encoding_desc, 8, pager_get_columns(), 0);
 		if (metric_name)
 			printf(" MetricName: %s", metric_name);
 		if (metric_expr)
-- 
2.38.1.431.g37b22c650d-goog

