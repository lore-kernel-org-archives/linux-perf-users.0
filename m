Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916D4C7618B
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Mar 2023 14:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjCOOx4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Mar 2023 10:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjCOOxZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Mar 2023 10:53:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31C796C21
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 07:52:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so2072461pjv.5
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmJnfY2lbCc2C3dy6sxzWUeYnl8mSWLRJqM4XO3hbV8=;
        b=KypbBeFiiw071Rag2kqAVfUN+QVZTcqiKgxUGUU95LCFu9MmUtsYI+52dxV0Gv89Vy
         pvCdUgfGXRI6tPoC+r7RLW1BiF/XK9AmJdznQYzoS/HYtLWDcmCSSeflr+kVEeKLe4At
         SWjpbBLrLMBEltp6BVgmrJMqMhOjBu4+KbFYaw4+W+kuEtJe9qqUWwufhhMUJjwKMkXW
         UBSeVJ2/7gqCKip0CHurXPOnl1XVpTx+LrtS6vTTZQPVq77Pla+qZWnZATzQj7nDNFwc
         Jv1vNx+VfVH0Yahp0jDLw3tKhw+sbCtt5eRr+u60J23SyyNF0e5sas97TCOCDhbpSsfW
         KqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmJnfY2lbCc2C3dy6sxzWUeYnl8mSWLRJqM4XO3hbV8=;
        b=SnCdmNXNY7mEB8Kyq5jp1we0v+fYYFEXeVIM38ZuPlXOuFbign1aX1uqsmAxC2oHsE
         FOrAIoraGD+LiSbA6vNCCH1NryRTl1X6zn/kQOzu420rQ5SUNR70ToZPYoeQgG/Bm2+J
         uihqHgce5ySJEMWTReYlnCglLZ+CKQMO10QFphsxGZxJwwqThTNgov9SqcFIrGt//48w
         sNM4MtnDrpp2cNmiDV/M9LKAyE2V7hWg2uLA1BGBjd6Ln73TkuNycLKrHbUU1UyzZGI6
         1AednCjNU83NvjDGb0eTj9rasprrnEm7AeNa5cYnJo0oNwm618tzYmITtbSp9r8VYVI7
         fm/g==
X-Gm-Message-State: AO0yUKVIEhHvrmI/epTyCwfwI6+A72TcLRa8vznyp+x5b8tc2Ik4h0R3
        Hanny9Zr7gWZwxUsGTNdDizUFw==
X-Google-Smtp-Source: AK7set8CJNZe2JhTNOxg0QgEtz1dzP7EuN9M3xiZmEechhTZHY0AG3PLkB8JSV85l+21tYStSl89xg==
X-Received: by 2002:a17:902:e886:b0:19a:7f4b:3ef6 with SMTP id w6-20020a170902e88600b0019a7f4b3ef6mr3551199plg.3.1678891969844;
        Wed, 15 Mar 2023 07:52:49 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:52:49 -0700 (PDT)
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
Subject: [PATCH v5 14/16] perf kvm: Add dimensions for percentages
Date:   Wed, 15 Mar 2023 22:51:10 +0800
Message-Id: <20230315145112.186603-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315145112.186603-1-leo.yan@linaro.org>
References: <20230315145112.186603-1-leo.yan@linaro.org>
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

