Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDCFC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Mar 2023 14:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjCOOwD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Mar 2023 10:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjCOOv7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Mar 2023 10:51:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B84993E2C
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 07:51:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso3623113pjf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9P/WNNNsLKtkXIlBizDtRA5HEUxXu0PrB/8N0zALdo=;
        b=kERtE0PayCcJQ3g8DvP/DKEm+wnQqWdaSqaR2NerLnXK+yX4pdUdXXbun86NaJWPip
         NaNxyTI5DDE93i1z0boAD2DCj4A/Q+JH5zKZBF+AtgiDmsI6LhKtHZRo3UmfqxaZkv4S
         gt0TLHk4YAc1EW2Y6k2KGJeQ/NUCeaiHOVq+qZ1LAkCDYUmjGguiHLs9W+i9MFdfzYXq
         bcW5anC2HFx14u31bHEJqluO8X8Rd2yETVU6V587+UuzxZ7KlZvv021+tcLpAjqeDRXn
         X8OnO6jDOEg9ifMzxC9reG7xPjJdBeEUWaXxO1oRVEkrJdrHYfZWWf+9xqxAp1gXnU/x
         Zq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9P/WNNNsLKtkXIlBizDtRA5HEUxXu0PrB/8N0zALdo=;
        b=AwkKUub6VZH/ak7RMrpbbbwUFIAyNRFnJC2dokwXPT7BeoIzgE5Tdm20AbaH9xisnF
         5F4a8173bmVAA/qB7AhlklS8Ye2rsgYDax7Erzb2/OpQ3cPNs5+wwO0NfyMZ6Y6imwYd
         +/ZaXlAHONc+5E72EEtM/QkOcuVris+QoO+67RWCyuG1QWfZ2noVdtEN5v5jC4ib68ax
         FBJShxV62KZI42MuwyrpKBWSM2JX7MWblPfOH4uxpDf2woRNqIDPM6Ey/GTMp3uhtSSk
         CENbkQe/xYOYkRRN0z9gJhu5nhU0bZ9mnyUj3mz0ftbiqhgCzRCMEj4BIpgBhF58x78H
         cxwQ==
X-Gm-Message-State: AO0yUKWq7+u3C30OT0lb1m4dX7mKLYx4+Y2cViNCsF1ZFzLRGufh38c7
        s/VaT5J37wZy8porYLj0t61QYw==
X-Google-Smtp-Source: AK7set9dml+fP8oxdvMnQArrcIveUFrdND0WQlnru3pW0iTofhwwc7D4RzHBKBI+q2LgpbbPbzhF4Q==
X-Received: by 2002:a17:902:d4d0:b0:19f:30be:ea06 with SMTP id o16-20020a170902d4d000b0019f30beea06mr3274410plg.50.1678891907507;
        Wed, 15 Mar 2023 07:51:47 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:51:47 -0700 (PDT)
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
Subject: [PATCH v5 03/16] perf kvm: Move up metrics helpers
Date:   Wed, 15 Mar 2023 22:50:59 +0800
Message-Id: <20230315145112.186603-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315145112.186603-1-leo.yan@linaro.org>
References: <20230315145112.186603-1-leo.yan@linaro.org>
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

