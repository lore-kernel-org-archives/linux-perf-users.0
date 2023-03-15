Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F10C61DA4
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Mar 2023 14:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjCOOxa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Mar 2023 10:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjCOOxG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Mar 2023 10:53:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422D9B2EC
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 07:52:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nn12so19073043pjb.5
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXjE1lNyQ6Ulq2wrJYSF6aHLvPPQtJdwrD75rVojf8A=;
        b=BCoP6UXH2x8VV6ZsOW13Ae9hQ4T2I9/6OiiOOf26BOC3ZUWn3FhlVxYrwF0uGT2820
         Z89j0GTbYPZbd2m0FTGAmQ3aeVDmEJtZzF1e/zHOZHQEwvVoNGq/xuYbvVwuqdT9d1ZE
         SMzXSpKbDY/rFapSOecLZBq8+zwdrzi6TujVS4OhT+wrSE/zUcm1EjBldfw1Mq+JajgA
         BwHIdRwEWuAS/5nOs4hcd4JPjVlkula1o2YjLf8HFYGm+SX7NX03Ph2xIXtoPM/cMhIv
         H8Lrwb4ru/Wj3svRHVKnevbHu7BtAfzHGDj+o4Dms7Ia98uaFLE1ZLCxRbiXzLeDdOr0
         sfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXjE1lNyQ6Ulq2wrJYSF6aHLvPPQtJdwrD75rVojf8A=;
        b=35DDnhKu83PS41BORbhk7gaxm2tlHSAqYHpSCfXKHcUumVqc0mSbwao1EqbYmjmjx2
         MXU1HqHSIL1NoMhJNv852SFk/Q3Hp67Nihp1aBwLr2WJvNbx3DSXHfGcqbSS5b5RqjDT
         lJdyXLyKNBZuKV4HutyiB4ir4xkFWxnBc3t2HkWTuSriY5y7GVcOofJrnl2ss2R8NCXq
         yenhwL08Ao/8PCkryew6tIYgCZQvn23MytGXYRGCZIAeRf9VFQGaU5lIfNN7fZ0B5HYy
         6S4wFs6Vrjs1kwB+sT4xFvFqnF9VS4L4rPREYY1sM2c0chx2KlYV/IDnognYTEz9RBqu
         FoAg==
X-Gm-Message-State: AO0yUKVzq8bDR2SKj2NL5sEZk8E+PCtYbmdLGNJ+kEoQqBqKvbFbLY4N
        Kxm3rQLRp8STFpCyTdT6faWKjQ==
X-Google-Smtp-Source: AK7set/x2sbhiI0KJMwBONL5ZF5YA0yPzV1seKM6HmyYEhYd4ut50lJhZLlgYJcc5Kcg6TFT3KxMtg==
X-Received: by 2002:a17:902:f54e:b0:1a0:76d1:545c with SMTP id h14-20020a170902f54e00b001a076d1545cmr2950647plf.10.1678891958787;
        Wed, 15 Mar 2023 07:52:38 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:52:38 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 12/16] perf kvm: Polish sorting key
Date:   Wed, 15 Mar 2023 22:51:08 +0800
Message-Id: <20230315145112.186603-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315145112.186603-1-leo.yan@linaro.org>
References: <20230315145112.186603-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since histograms supports sorting, the tool doesn't need to maintain the
mapping between the sorting keys and the corresponding comparison
callbacks, therefore, this patch removes structure kvm_event_key.

But we still need to validate the sorting key, this patch uses an array
for sorting keys and renames function select_key() to is_valid_key()
to validate the sorting key passed by user.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   | 29 ++++++++++-------------------
 tools/perf/util/kvm-stat.h |  8 --------
 2 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index ba3134613bcb..1e9338855239 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -76,15 +76,6 @@ COMPARE_EVENT_KEY(min, stats.min);
 COMPARE_EVENT_KEY(count, stats.n);
 COMPARE_EVENT_KEY(mean, stats.mean);
 
-#define DEF_SORT_NAME_KEY(name, compare_key)				\
-	{ #name, cmp_event_ ## compare_key }
-
-static struct kvm_event_key keys[] = {
-	DEF_SORT_NAME_KEY(sample, count),
-	DEF_SORT_NAME_KEY(time, mean),
-	{ NULL, NULL }
-};
-
 struct kvm_hists {
 	struct hists		hists;
 	struct perf_hpp_list	list;
@@ -757,18 +748,18 @@ static bool handle_kvm_event(struct perf_kvm_stat *kvm,
 	return true;
 }
 
-static bool select_key(struct perf_kvm_stat *kvm)
+static bool is_valid_key(struct perf_kvm_stat *kvm)
 {
-	int i;
+	static const char *key_array[] = {
+		"ev_name", "sample", "time", "max_t", "min_t", "mean_t",
+	};
+	unsigned int i;
 
-	for (i = 0; keys[i].name; i++) {
-		if (!strcmp(keys[i].name, kvm->sort_key)) {
-			kvm->compare = keys[i].key;
+	for (i = 0; i < ARRAY_SIZE(key_array); i++)
+		if (!strcmp(key_array[i], kvm->sort_key))
 			return true;
-		}
-	}
 
-	pr_err("Unknown compare key:%s\n", kvm->sort_key);
+	pr_err("Unsupported sort key: %s\n", kvm->sort_key);
 	return false;
 }
 
@@ -1198,7 +1189,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 		return ret;
 
 	if (!verify_vcpu(kvm->trace_vcpu) ||
-	    !select_key(kvm) ||
+	    !is_valid_key(kvm) ||
 	    !register_kvm_events_ops(kvm)) {
 		goto out;
 	}
@@ -1393,7 +1384,7 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	if (!verify_vcpu(vcpu))
 		goto exit;
 
-	if (!select_key(kvm))
+	if (!is_valid_key(kvm))
 		goto exit;
 
 	if (!register_kvm_events_ops(kvm))
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 3f0cbecb862c..35d03894fac3 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -49,13 +49,6 @@ struct kvm_event {
 	struct hist_entry he;
 };
 
-typedef int64_t (*key_cmp_fun)(struct kvm_event*, struct kvm_event*, int);
-
-struct kvm_event_key {
-	const char *name;
-	key_cmp_fun key;
-};
-
 struct child_event_ops {
 	void (*get_key)(struct evsel *evsel,
 			struct perf_sample *sample,
@@ -98,7 +91,6 @@ struct perf_kvm_stat {
 	const char *exit_reasons_isa;
 
 	struct kvm_events_ops *events_ops;
-	key_cmp_fun compare;
 
 	u64 total_time;
 	u64 total_count;
-- 
2.34.1

