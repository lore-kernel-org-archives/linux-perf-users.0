Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B70C7EE23
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Feb 2023 04:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBZEVM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 25 Feb 2023 23:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBZEVL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 25 Feb 2023 23:21:11 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874C5BDE5
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Feb 2023 20:21:10 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u5so134370plq.7
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Feb 2023 20:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6XdpHkz8A8bOxvOk1eGAORWD0fU8Q/VwNFknF3nlZE=;
        b=oFoLR3FiLT+h5TvDFl1GMv2yCpurUwpbMglbpeM+aHbUkBo57SGlAj4ysITb90pRAD
         RJ3V9S1eBxSMEfVi/I8ve+chS48IInvz4zhBCxbkjhk8ePeevlcGnhvHL7H2qkgvfGn6
         QOp+r2aLbM3gavUNPxXcV0yFWFpzC7632yZ5mcjdf4XgPapjcE/kFIO/pAFNYVQ/q+Fo
         qO6r1ooid1B+V8U0sm33s/nYeARnc+J2yWtxGa/ydAXudiqdHBjSN8Juwj5OohtDRMOU
         l47QGgZktZHueXcz4NmSS7ZJCan5UhNlTweSj1pBbKPuMRG9sYhGQlRL8ULigehujOwK
         sUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6XdpHkz8A8bOxvOk1eGAORWD0fU8Q/VwNFknF3nlZE=;
        b=c7PnREsBgV++N/aCqTlL1sNjfjREr21B1iD2DOYSaaSuVz8c6FeON9sjqTojBMewLz
         96wk5pvVZHDf//KNcXnQe1bjwOyWmekyNXH7tEmu4X8CvALIdNx5y7conDWl1DNrff0f
         TZj+O45Sy0mQT8G2IECivOnBjnWe6avT19As1lGVMSOoJOa1UPVi5yPEtiR1BF05Pr7p
         j8JNTb36Qj2GslJwGOYBUAN2nf/HBEZTIJ7yFxnPrnFscQ2oaFUrlIpkTDFFk6sz68/7
         fiMofeRQFu9oaDgBU3LJR6mIJRl7lY64pSTb3ea38L0/pGqZH+qy1K9Ai2BffyJAFFaC
         AyDg==
X-Gm-Message-State: AO0yUKXl8W/O+cZAPZI1gKeTukos3+tYYTNn8PEnvkavK7+UY8e4KKk/
        54ui8Z6eWdbCQzFyHvtnNqDAOQ==
X-Google-Smtp-Source: AK7set8d6gnX4LOmAYlzfD6ivuYo2gNNIR2DBnedvHEhU0G6tEEigiU79oAzkXZ6JvBQnI3lBRKSQQ==
X-Received: by 2002:a17:902:f903:b0:19d:7a4:4073 with SMTP id kw3-20020a170902f90300b0019d07a44073mr259328plb.59.1677385269877;
        Sat, 25 Feb 2023 20:21:09 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:09 -0800 (PST)
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
Subject: [PATCH v1 01/14] perf kvm: Refactor overall statistics
Date:   Sun, 26 Feb 2023 12:20:40 +0800
Message-Id: <20230226042053.1492409-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226042053.1492409-1-leo.yan@linaro.org>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently the tool computes overall statistics when sort the results.
This patch refactors overall statistics during events processing,
therefore, the function update_total_coun() is not needed anymore, an
extra benefit is we can de-couple code between the statistics and the
sorting.

This patch is not expected any functionality changes.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 641e739c717c..0172e5b0d26e 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -278,9 +278,14 @@ static double kvm_event_rel_stddev(int vcpu_id, struct kvm_event *event)
 				avg_stats(&kvm_stats->stats));
 }
 
-static bool update_kvm_event(struct kvm_event *event, int vcpu_id,
+static bool update_kvm_event(struct perf_kvm_stat *kvm,
+			     struct kvm_event *event, int vcpu_id,
 			     u64 time_diff)
 {
+	/* Update overall statistics */
+	kvm->total_count++;
+	kvm->total_time += time_diff;
+
 	if (vcpu_id == -1) {
 		kvm_update_event_stats(&event->total, time_diff);
 		return true;
@@ -399,7 +404,7 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
 		}
 	}
 
-	return update_kvm_event(event, vcpu, time_diff);
+	return update_kvm_event(kvm, event, vcpu, time_diff);
 }
 
 static
@@ -526,15 +531,6 @@ static void insert_to_result(struct rb_root *result, struct kvm_event *event,
 	rb_insert_color(&event->rb, result);
 }
 
-static void
-update_total_count(struct perf_kvm_stat *kvm, struct kvm_event *event)
-{
-	int vcpu = kvm->trace_vcpu;
-
-	kvm->total_count += get_event_count(event, vcpu);
-	kvm->total_time += get_event_time(event, vcpu);
-}
-
 static bool event_is_valid(struct kvm_event *event, int vcpu)
 {
 	return !!get_event_count(event, vcpu);
@@ -549,7 +545,6 @@ static void sort_result(struct perf_kvm_stat *kvm)
 	for (i = 0; i < EVENTS_CACHE_SIZE; i++) {
 		list_for_each_entry(event, &kvm->kvm_events_cache[i], hash_entry) {
 			if (event_is_valid(event, vcpu)) {
-				update_total_count(kvm, event);
 				insert_to_result(&kvm->result, event,
 						 kvm->compare, vcpu);
 			}
-- 
2.34.1

