Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0717EC61DA4
	for <linux-perf-users@archiver.kernel.org>; Wed, 15 Mar 2023 14:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjCOOwW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 15 Mar 2023 10:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjCOOwI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 15 Mar 2023 10:52:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFA097B5F
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 07:51:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v21so10174786ple.9
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Mar 2023 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd+dkas2glmconcA3nZgOv1IgDvFJOrEFeQZRwvRr9Q=;
        b=YfMLFLfFXMW5NCpCaRGVHpsK7tI9UBEjIKHVIzaHfGrbedKISm9IE63szUmP0A5hXc
         R89hHVJJt+esMau2kph4nwZrNEcq8uYxo6x2zXz/r+d7/1Okwxl+v3WF2xwrIDLWcdbs
         rKjbrgvUGpiPsxhu3jCpASTHDCYRUxlQkQZL/UpPYcesmaXrfepoteyH7ey556AoKLcV
         kgVebWHBYJbNVH6hI0+VGA6MgvbltWc4xx+/j9J3eeyRFLH5gEKiC5Atg7pquz8y8K4h
         oQyFyszZGeEd0EK8lsiKu8mQFMxAZsbFmp/dtszSePeLqEOnyuglHR6oSJuvjfqXPNPr
         M3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cd+dkas2glmconcA3nZgOv1IgDvFJOrEFeQZRwvRr9Q=;
        b=JLz+uOiz/0+vrkPhigKjUPBU/cDIhCo3WqpZT+UExsX4RsNfJPUWuoGnBvoiNYQHNL
         vTDaj7MQbbMrd02O7L4XxyemuZr1qZ3oEOrpsatwAMZuhTaGgdWfAww6YvYcTJBmYODY
         HKwZgyUTrInxP1cqdfnap/17+4LViVGJSwayiBMEpeXdLIejsjX+j4CX8Bp9yteUGxRO
         00OfNxzS0cKKAeb/+kbHfpNU2OPz6OcQJNRrWoIolvRbHlSVgh5hvBiFgqOpqb7r82wj
         sx14wpErqAbb7pQ50FzzqtPREVHMuJl9j102ogbsFnAGDFj9j2N+7eJpGHHy2OBFCk91
         gePg==
X-Gm-Message-State: AO0yUKVOz7bweWNe6VCPsZJ0n+pixANtYMLQgfH8Vx56Zp2ngSGqlRhb
        DwJIU9KhikaSiKqXttAwbI1sKA==
X-Google-Smtp-Source: AK7set+OD/ekdbUPyKgmlJavsWyrlHgkyNT+r7p946TYxjT0XL2xAzkm0EgeNF4uEnXoKDJhxpAPAQ==
X-Received: by 2002:a17:903:234a:b0:19f:3797:d8de with SMTP id c10-20020a170903234a00b0019f3797d8demr3589747plh.9.1678891913436;
        Wed, 15 Mar 2023 07:51:53 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:51:53 -0700 (PDT)
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
Subject: [PATCH v5 04/16] perf kvm: Use subtraction for comparison metrics
Date:   Wed, 15 Mar 2023 22:51:00 +0800
Message-Id: <20230315145112.186603-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315145112.186603-1-leo.yan@linaro.org>
References: <20230315145112.186603-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently the metrics comparison uses greater operator (>), it returns
the boolean value (0 or 1).

This patch changes to use subtraction as comparison result, which can
be used by histograms sorting.  Since the subtraction result is u64
type, we change key_cmp_fun's return type to int64_t to avoid overflow.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   | 6 +++---
 tools/perf/util/kvm-stat.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 62c097a37da9..4e9519390da6 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -63,10 +63,10 @@ static u64 get_event_ ##func(struct kvm_event *event, int vcpu)		\
 
 #define COMPARE_EVENT_KEY(func, field)					\
 GET_EVENT_KEY(func, field)						\
-static int cmp_event_ ## func(struct kvm_event *one,			\
+static int64_t cmp_event_ ## func(struct kvm_event *one,		\
 			      struct kvm_event *two, int vcpu)		\
 {									\
-	return get_event_ ##func(one, vcpu) >				\
+	return get_event_ ##func(one, vcpu) -				\
 	       get_event_ ##func(two, vcpu);				\
 }
 
@@ -523,7 +523,7 @@ static void insert_to_result(struct rb_root *result, struct kvm_event *event,
 		p = container_of(*rb, struct kvm_event, rb);
 		parent = *rb;
 
-		if (bigger(event, p, vcpu))
+		if (bigger(event, p, vcpu) > 0)
 			rb = &(*rb)->rb_left;
 		else
 			rb = &(*rb)->rb_right;
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 40a4b66cfee6..0c2400d9b227 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -40,7 +40,7 @@ struct kvm_event {
 	struct kvm_event_stats *vcpu;
 };
 
-typedef int (*key_cmp_fun)(struct kvm_event*, struct kvm_event*, int);
+typedef int64_t (*key_cmp_fun)(struct kvm_event*, struct kvm_event*, int);
 
 struct kvm_event_key {
 	const char *name;
-- 
2.34.1

