Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE11C64ED6
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Feb 2023 11:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjB1LxJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 06:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjB1LxH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Feb 2023 06:53:07 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A0F35AC
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 03:53:04 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c23so9506934pjo.4
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 03:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9P/WNNNsLKtkXIlBizDtRA5HEUxXu0PrB/8N0zALdo=;
        b=xtZQMpff+QWOaUFLpccpEDYz77bqJRqchLzhWGNtquHoPoTdhJMYdmUdKMNjw99h5n
         GtCXH4AwJaDvBj6Ma6yRRSsYOemJR92n5ViC2aLfr0zNW0fFS40b2yM7GTUE/qnSu6tJ
         xdbcxjp8KaTuB1P5l4NDtZvUbQQg7Dd9ZxNiIq4RDSgNQajlQowMV4kz6VaOpt71wZNS
         8Sf/LqhBKZt0ec/HQ+XZaJDGYvweeKfGg6FKAIuA18sTrrzCl0IWTW93S4fDy1EGvMbM
         yFK8176oqXcdXQSvEiKZsV84iNpgLKDCkae1wHeU11kgtmUxsaD32k0nf2tZqfNM3z3Q
         mNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9P/WNNNsLKtkXIlBizDtRA5HEUxXu0PrB/8N0zALdo=;
        b=Pn26dCr4gj+pTzJtZxkajgkrdpyQHIkUfLr1uIMwGSHzfdy8FVXo28xXRGZ6GOZEWc
         9gQ6p7XhufhvmEObgWDg5unuMbYmwqotdcORLWz/A9FtvROg8BDI8L2xRJGp0v9z5mtf
         AKSSBccy54a0OFd5lR1o7eDmyfuK6QuOZAmSfevhc6Io8efFa67lckOWLtavnKgyo3VI
         bexrGYrRUimQHAA/F/fS5eI0Nb9mz+7/OXNlUKKJA7USvQi7a9ezklfHFNpHilBZlmF9
         yPw/NutkBCPqWLJsjDAOnx2EAhc91Q4Pe+p3H3cDorc50mcoZJw6eCuGfamNsNRDA08W
         M2uw==
X-Gm-Message-State: AO0yUKX/0OVtL81E3VGDVPQtRuey/QzTGNBguZnkhgcRThgsMJtM3JBm
        psY9izCEPiYblUAPN6Y5HWy8Gw==
X-Google-Smtp-Source: AK7set+X+RCd9I9e6CQ52iQO/JLj9MHi60/nh04ESMcdfp+lHvPzHe4IllOmeh0Ov3U7ZxYhmxAm0w==
X-Received: by 2002:a17:90a:190f:b0:233:c9e7:c885 with SMTP id 15-20020a17090a190f00b00233c9e7c885mr2915100pjg.36.1677585184107;
        Tue, 28 Feb 2023 03:53:04 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:53:03 -0800 (PST)
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
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 03/14] perf kvm: Move up metrics helpers
Date:   Tue, 28 Feb 2023 19:51:14 +0800
Message-Id: <20230228115125.144172-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228115125.144172-1-leo.yan@linaro.org>
References: <20230228115125.144172-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch moves up the helper functions of event's metrics for later
adding code to call them.

No any functionality changes, but has a function renaming from
compare_kvm_event_{metric}() to cmp_event_{metric}().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-kvm.c | 72 ++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 3d2560ec6b37..62c097a37da9 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -49,6 +49,42 @@
 #include <math.h>
 #include <perf/mmap.h>
 
+#define GET_EVENT_KEY(func, field)					\
+static u64 get_event_ ##func(struct kvm_event *event, int vcpu)		\
+{									\
+	if (vcpu == -1)							\
+		return event->total.field;				\
+									\
+	if (vcpu >= event->max_vcpu)					\
+		return 0;						\
+									\
+	return event->vcpu[vcpu].field;					\
+}
+
+#define COMPARE_EVENT_KEY(func, field)					\
+GET_EVENT_KEY(func, field)						\
+static int cmp_event_ ## func(struct kvm_event *one,			\
+			      struct kvm_event *two, int vcpu)		\
+{									\
+	return get_event_ ##func(one, vcpu) >				\
+	       get_event_ ##func(two, vcpu);				\
+}
+
+GET_EVENT_KEY(time, time);
+GET_EVENT_KEY(max, stats.max);
+GET_EVENT_KEY(min, stats.min);
+COMPARE_EVENT_KEY(count, stats.n);
+COMPARE_EVENT_KEY(mean, stats.mean);
+
+#define DEF_SORT_NAME_KEY(name, compare_key)				\
+	{ #name, cmp_event_ ## compare_key }
+
+static struct kvm_event_key keys[] = {
+	DEF_SORT_NAME_KEY(sample, count),
+	DEF_SORT_NAME_KEY(time, mean),
+	{ NULL, NULL }
+};
+
 static const char *get_filename_for_perf_kvm(void)
 {
 	const char *filename;
@@ -461,42 +497,6 @@ static bool handle_kvm_event(struct perf_kvm_stat *kvm,
 	return true;
 }
 
-#define GET_EVENT_KEY(func, field)					\
-static u64 get_event_ ##func(struct kvm_event *event, int vcpu)		\
-{									\
-	if (vcpu == -1)							\
-		return event->total.field;				\
-									\
-	if (vcpu >= event->max_vcpu)					\
-		return 0;						\
-									\
-	return event->vcpu[vcpu].field;					\
-}
-
-#define COMPARE_EVENT_KEY(func, field)					\
-GET_EVENT_KEY(func, field)						\
-static int compare_kvm_event_ ## func(struct kvm_event *one,		\
-					struct kvm_event *two, int vcpu)\
-{									\
-	return get_event_ ##func(one, vcpu) >				\
-				get_event_ ##func(two, vcpu);		\
-}
-
-GET_EVENT_KEY(time, time);
-COMPARE_EVENT_KEY(count, stats.n);
-COMPARE_EVENT_KEY(mean, stats.mean);
-GET_EVENT_KEY(max, stats.max);
-GET_EVENT_KEY(min, stats.min);
-
-#define DEF_SORT_NAME_KEY(name, compare_key)				\
-	{ #name, compare_kvm_event_ ## compare_key }
-
-static struct kvm_event_key keys[] = {
-	DEF_SORT_NAME_KEY(sample, count),
-	DEF_SORT_NAME_KEY(time, mean),
-	{ NULL, NULL }
-};
-
 static bool select_key(struct perf_kvm_stat *kvm)
 {
 	int i;
-- 
2.34.1

