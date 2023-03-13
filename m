Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E681C6FD1C
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 11:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjCMLlc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 07:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjCMLlY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 07:41:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5740A65130
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:40:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nn12so11676114pjb.5
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 04:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/nbi3g1G7blTIc7EqTO9R+UAXnIBnoxcjmSOAZ7Xck=;
        b=evWDaAHRTVMrCXo8odtG+XiiUQi/tIoaxy/YK2dWKYAJKc1YsgTzVcGbRMwl/jK+A2
         se7zCOxQLs0/AMm0R/Hhi+RHruUbuxn1oDGZPAGOfRrzGKFTMfkzP5AJ1vrEY24SqPj6
         U8QlLyFEj/m6hPLsidBw0kiRmNFqGEVPs0lrJSV2ii0F/aNS05n+LoTzlWtrKf9cVICX
         nxxlfGv8wfAiU5rqfpRciQ3k/egPgubfloC8K9Pq+dvRgpUbfugeEwPme8sOHuBvXGuC
         D1LMKU1U44tgTYfVr/K7MSsq73F/9BaP+WfFwm0fORwzQ+LDfFh+u4/B+dSRQoGTJG1o
         /mWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/nbi3g1G7blTIc7EqTO9R+UAXnIBnoxcjmSOAZ7Xck=;
        b=sWf5eNW+su0qb87N3ASNaPj0Mv+98eBxZ0w/x434Sy5/UqZpqTA2A4tngeP9kWz3Md
         Nwv5XDecCfvxdU0Qbbo8hGgczAImmOo/JrKvZJfLQPNb6oXrfQPEewh8jKtcz2NVdQwz
         ymE0+LEIWMv6ge1sZomIrg60WVvuEjDXUQsr6p5y7D3C+h++4D+f23sZHWpc6oWOZTN7
         y+iL36eGZ1IVxy1fIc87LuaNtKFCTvxCIvbijj4ddN8rJ3HTj4LQY8e8OPWR8RH0RYq6
         x7p2CAfWSetG4AGd0DHP06Wa6BE/bJcj7CaTAktgavfNlBWtIirnXpmGrHQ8URO40G4o
         UNYQ==
X-Gm-Message-State: AO0yUKWS1nbe8MkX8+0WKhEIcTd02lvXLVg5fzgL6gh5FMnQiEabLb42
        CYxlY8WxNTdEWTUeXFAlOYDuew==
X-Google-Smtp-Source: AK7set8teySbue549QBMEg2WXUd64gS+oeeOqp2p0guknoK0bwSJzOLunt6prvsrWSje1dQr+Go6YQ==
X-Received: by 2002:a17:90a:94c7:b0:23d:2b11:b39b with SMTP id j7-20020a17090a94c700b0023d2b11b39bmr34239pjw.31.1678707658713;
        Mon, 13 Mar 2023 04:40:58 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:40:58 -0700 (PDT)
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
Subject: [PATCH v4 04/16] perf kvm: Use subtraction for comparison metrics
Date:   Mon, 13 Mar 2023 19:40:06 +0800
Message-Id: <20230313114018.543254-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313114018.543254-1-leo.yan@linaro.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently the metrics comparison uses greater operator (>), it returns
the boolean value (0 or 1).

This patch changes to use subtraction as comparison result, which can
be used by histograms sorting.  Since the subtraction result is u64
type, we change the function return type from int to int64_t to avoid
overflow.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
-- 
2.34.1

