Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30353C64EC7
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Feb 2023 08:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjB1Imo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 03:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjB1Ima (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Feb 2023 03:42:30 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983BF2BEED
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:42:21 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id d10so5135725pgt.12
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIt7hyoJVmNy/7vg+PJWYd0GZkeRWV7lG6iYd+8Wqps=;
        b=mS2P4aAtqjsWhcUJddXr23ZsJdr/sh+N0IF0kJbGeCvOX2S9jFSXWRTXzjCaYH5oOe
         cBtzrnH+LdZBzYFn1ZDiWpdnMFutST9mW4rYGVw8aMLDQRDeghAKpGtA+KIWlxM1Inz6
         4jmgEfEMaZYRHMIJ524Hkafcy80SxQc8AvmvBz/ofCWvXKmQJHJOSB85boiZhosuiHNE
         AvSOY5Tk2mGKZH+W0z8kCgQJRKy/v4hgW+jUDZlxoLW8fUTEzBIktHtK9n1t8mAkHvg9
         kgOPOJastla6hp0mZRj4BrtEjLjDTp3NxHnqTRdJcyZFfbIEStS8ELECfgjTlwLSqZpx
         4jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIt7hyoJVmNy/7vg+PJWYd0GZkeRWV7lG6iYd+8Wqps=;
        b=8M+dzJzjdUShRXEiKsNzuywoXxOIviQAuTkPnH1vZBNLYaiKUgzfEXMvr1VPjVgiKH
         zqTaEizSex9hYcboewVmna2W49Pt0dFRixFwRuaHHMylbzqCpu6Or/XCveVZkfSffmBX
         5jL3gfNuLkttzqFJ/48Pc5Tg8J2/CEzaL/q07Sp+LYsSO5EHBOOlyLYXPy+LRT/95L56
         N3L3jlVHfExeg/XsmeYDzwh1Ai8MT/O6O9oOtlkXEsxakL3lkeQ2/QXUJosRdRiXz0QT
         5yMe10+w1fv5gEKm3hTQGUSQK8bJk3z2s1OUnH8SpsKgtjtLhEQ5X3A1mig8yxqyYAAE
         Ycbw==
X-Gm-Message-State: AO0yUKXqMS0ZbaMDXAVUnTxnSKBv+2xPYTJmfFt+ZK+QgHHzYAv1I8b9
        ZZL0cm8sUTead08+a585CJpqaQ==
X-Google-Smtp-Source: AK7set/NrRxAzFchpNLziAy94c5DDBN/Q3U+Nn3NEMEEStq+wEfwWgcLPLfOaCiLBsFaQpTYbXUDZA==
X-Received: by 2002:a62:4dc1:0:b0:5dd:3f84:7d32 with SMTP id a184-20020a624dc1000000b005dd3f847d32mr1845280pfb.1.1677573741035;
        Tue, 28 Feb 2023 00:42:21 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:20 -0800 (PST)
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
Subject: [PATCH v2 04/14] perf kvm: Use subtraction for comparison metrics
Date:   Tue, 28 Feb 2023 16:41:37 +0800
Message-Id: <20230228084147.106167-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228084147.106167-1-leo.yan@linaro.org>
References: <20230228084147.106167-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently the metrics comparison uses greater operator (>), it returns
the boolean value (0 or 1).

This patch changes to use subtraction as comparison result, which can
be used by histograms sorting.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 62c097a37da9..6eec0db2dda6 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -66,7 +66,7 @@ GET_EVENT_KEY(func, field)						\
 static int cmp_event_ ## func(struct kvm_event *one,			\
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

