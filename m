Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCBDC64ED6
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Feb 2023 04:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBZEWt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 25 Feb 2023 23:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjBZEWL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 25 Feb 2023 23:22:11 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D8B13D66
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Feb 2023 20:21:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so2347059pjg.4
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Feb 2023 20:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NEkdhqDMouB1zUi5eCnhcHJNUH+bFnGQLi//L7nojk=;
        b=rutgprXkcCVQHOHCa7qujzCTs/ZmwgPeBYglbDY1OzBhRd7fX0ULgHQ+m4xp/gJYBv
         Jhta71b2jIcoP8N4zkn8Enn6l7iI56wdtUQ5v/FGE56afGr9+uI6pSqOkqSDfhOjRFoQ
         kWcpjvZD5ljh/d7nwh5YdNN267zs3knak0z59rW2R1RqCedbTLIn8el6vS5HKPWjbU2j
         CGTQaBj8wYOSKN5qxIj1XUqb09I0oseoiToRG8LLN4D9rvh7uCRnb+MrNIEozkLVDjla
         8P8hyex7pt1WeKBa9ZOpgH5tMBRSvAfOYNDQjE975DjStVCL8fTCfElvaRx/b4X0Bta4
         4O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NEkdhqDMouB1zUi5eCnhcHJNUH+bFnGQLi//L7nojk=;
        b=5ilYJuXFEe92hNbKM+QnsPPHARYgD94ERU1dG6PBL9/3bYBx3QmoadZQ/YdD4Ljtd+
         JXsfWJrQs8Oew5MP6V1XUOlTZgNcC6bypZhzrZXx6yZwi24/72jf7Nki1bYYx3cV/+aP
         EU2v9ZWN4FzFu/qzXcWqrVpUvcOpP4iC7OFtWydrju25dIqluNQrkUNfcIJPCuuHHIwO
         bCt9NWmXnMtPvrR/4L+cQL4xWBo2YfQwQ4YtqYtOXL5AtvSHHmA4taO8tQppAcViWiLz
         1qfN08W/cxY8nfbfp42WFmaOGhAF25IUeWaYhkHkMMaoLTHCp6ivj7U/r1DiijsvGQMb
         Bs0A==
X-Gm-Message-State: AO0yUKUc07zGVghjYYQnR3qQ/rXJS8HbEA7WQih9/kls+q1cQMEASCM5
        9BgJPNSCk2gUF+i3QrBnE/9lpw==
X-Google-Smtp-Source: AK7set+xUHmsZA49mTitD/+OxCt6JFCx6tqse954NH5qz7xYCmY/uNS3na/e9vIESrj6Z185SkCMcw==
X-Received: by 2002:a17:902:e883:b0:19a:d7d8:a080 with SMTP id w3-20020a170902e88300b0019ad7d8a080mr25758344plg.22.1677385312286;
        Sat, 25 Feb 2023 20:21:52 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:51 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 12/14] perf kvm: Add dimensions for percentages
Date:   Sun, 26 Feb 2023 12:20:51 +0800
Message-Id: <20230226042053.1492409-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226042053.1492409-1-leo.yan@linaro.org>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add dimensions for count and time percentages, it would useful for user
to review percentage statistics.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c | 98 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index a56d0983c585..5b1b2042dfed 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -230,10 +230,105 @@ static struct kvm_dimension dim_mean_time = {
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
@@ -406,7 +501,8 @@ static int kvm_hpp_list__parse(struct perf_hpp_list *hpp_list,
 
 static int kvm_hists__init(struct perf_kvm_stat *kvm)
 {
-	const char *output_columns = "name,sample,time,max_t,min_t,mean_t";
+	const char *output_columns = "name,sample,percent_sample,"
+				     "time,percent_time,max_t,min_t,mean_t";
 
 	__hists__init(&kvm_hists.hists, &kvm_hists.list);
 	perf_hpp_list__init(&kvm_hists.list);
-- 
2.34.1

