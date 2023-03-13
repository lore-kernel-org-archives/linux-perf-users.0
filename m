Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414F5C6FD19
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 11:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjCMLmz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 07:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjCMLmM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 07:42:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1598B5D8B3
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:41:44 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h8so12568029plf.10
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmJnfY2lbCc2C3dy6sxzWUeYnl8mSWLRJqM4XO3hbV8=;
        b=pNiVNpQ25MN3oYBxt5/TM6uCwUc4SXP1Z4o4vh/+qLyntiFU4wcRaE6ohhV/RNqOW2
         rHce4CMogEGfwLFpKWTQmXNWgcGLssUlmb0X/DKabDIagp5i2zz+Jdjidy5OC0XvprT2
         PUnrmmSDm9cTgl7DCgzx/Me6o22O8ESkhhqpCoUaTz23F7oXPEujB7FZ7E5pfLPmMS8d
         pkohfPUjdUSS3Kb56DFZ8y/kaO8KXmAMWhKJW5tFCu+c9ws0jBh5YE8UuxjnkIgI9D8g
         egVm1EeGUu0qQ6ulKO5sksvYjDegOtWElEXfyuLiVgE5l33GDU59cQnj+z3mfo5QUqdu
         WhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmJnfY2lbCc2C3dy6sxzWUeYnl8mSWLRJqM4XO3hbV8=;
        b=gi6W53aVdWgJ355EDDWeHthLgY8zQSKFBPmCecZSzNw433kHdZkzbJJlpjrs6N+Wx4
         3zAkSSGlzZ2b0vvPCsegWh36vEWP34ZHlOFuJzNJMDmINfoaW4H/LydzxhPynQ71t+Hq
         /O31RHTUIKjfwEL8z0vymrqdlKTLykfNucGaljUAfkyWyRcY9w2ZlYBmh4e/gn90BMjm
         W8FpMNi2VrnS/y4qZl6U8PDAnNkNJTywVqWm6dT8OnJKUMlhqG1Hxpywb8BvjOxryotn
         aQ6oPFfdhMEaczyXPnML/3KGGcamw8Cff397UVkLa4ACKfWhyOPd0shaHmketwXCp+4t
         tUpQ==
X-Gm-Message-State: AO0yUKWxxsLL7dJrvqSKFYFBuTsUI6OW1euONkSr1hHHDg+l2XSnAYIF
        /9bKq7q21n83boit+eED0MkTFA==
X-Google-Smtp-Source: AK7set83wd4oHHArPR4ZCKuSZNrPw2lV7a4yfTBhkyt3/X3CHFU6GXj7CbeJUDTJqy3RCZTfnL321g==
X-Received: by 2002:a17:90a:c7c3:b0:23b:4bf6:bbee with SMTP id gf3-20020a17090ac7c300b0023b4bf6bbeemr6415765pjb.21.1678707701711;
        Mon, 13 Mar 2023 04:41:41 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:41 -0700 (PDT)
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
Subject: [PATCH v4 14/16] perf kvm: Add dimensions for percentages
Date:   Mon, 13 Mar 2023 19:40:16 +0800
Message-Id: <20230313114018.543254-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313114018.543254-1-leo.yan@linaro.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add dimensions for count and time percentages, it would be useful for
user to review percentage statistics.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-kvm.c | 98 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 0d857df826cf..ab1cd6b5e528 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -222,10 +222,105 @@ static struct kvm_dimension dim_mean_time = {
 	.width		= 14,
 };
 
+#define PERC_STR(__s, __v)				\
+({							\
+	scnprintf(__s, sizeof(__s), "%.2F%%", __v);	\
+	__s;						\
+})
+
+static double percent(u64 st, u64 tot)
+{
+	return tot ? 100. * (double) st / (double) tot : 0;
+}
+
+#define EV_METRIC_PERCENT(metric)					\
+static int ev_percent_##metric(struct hist_entry *he)			\
+{									\
+	struct kvm_event *event;					\
+	struct perf_kvm_stat *perf_kvm;					\
+									\
+	event = container_of(he, struct kvm_event, he);			\
+	perf_kvm = event->perf_kvm;					\
+									\
+	return percent(get_event_##metric(event, perf_kvm->trace_vcpu),	\
+		       perf_kvm->total_##metric);			\
+}
+
+EV_METRIC_PERCENT(time)
+EV_METRIC_PERCENT(count)
+
+static int ev_entry_time_precent(struct perf_hpp_fmt *fmt,
+				 struct perf_hpp *hpp,
+				 struct hist_entry *he)
+{
+	int width = fmt_width(fmt, hpp, he->hists);
+	double per;
+	char buf[10];
+
+	per = ev_percent_time(he);
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int64_t
+ev_cmp_time_precent(struct perf_hpp_fmt *fmt __maybe_unused,
+		    struct hist_entry *left, struct hist_entry *right)
+{
+	double per_left;
+	double per_right;
+
+	per_left  = ev_percent_time(left);
+	per_right = ev_percent_time(right);
+
+	return per_left - per_right;
+}
+
+static struct kvm_dimension dim_time_percent = {
+	.header		= "Time%",
+	.name		= "percent_time",
+	.cmp		= ev_cmp_time_precent,
+	.entry		= ev_entry_time_precent,
+	.width		= 12,
+};
+
+static int ev_entry_count_precent(struct perf_hpp_fmt *fmt,
+				  struct perf_hpp *hpp,
+				  struct hist_entry *he)
+{
+	int width = fmt_width(fmt, hpp, he->hists);
+	double per;
+	char buf[10];
+
+	per = ev_percent_count(he);
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int64_t
+ev_cmp_count_precent(struct perf_hpp_fmt *fmt __maybe_unused,
+		     struct hist_entry *left, struct hist_entry *right)
+{
+	double per_left;
+	double per_right;
+
+	per_left  = ev_percent_count(left);
+	per_right = ev_percent_count(right);
+
+	return per_left - per_right;
+}
+
+static struct kvm_dimension dim_count_percent = {
+	.header		= "Sample%",
+	.name		= "percent_sample",
+	.cmp		= ev_cmp_count_precent,
+	.entry		= ev_entry_count_precent,
+	.width		= 12,
+};
+
 static struct kvm_dimension *dimensions[] = {
 	&dim_event,
 	&dim_time,
+	&dim_time_percent,
 	&dim_count,
+	&dim_count_percent,
 	&dim_max_time,
 	&dim_min_time,
 	&dim_mean_time,
@@ -875,7 +970,8 @@ static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
 
 static void sort_result(struct perf_kvm_stat *kvm)
 {
-	const char *output_columns = "ev_name,sample,time,max_t,min_t,mean_t";
+	const char *output_columns = "ev_name,sample,percent_sample,"
+				     "time,percent_time,max_t,min_t,mean_t";
 
 	kvm_hists__reinit(output_columns, kvm->sort_key);
 	hists__collapse_resort(&kvm_hists.hists, NULL);
-- 
2.34.1

