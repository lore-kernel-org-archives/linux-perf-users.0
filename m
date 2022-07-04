Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1543C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Jul 2022 08:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiGDIMD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiGDIL7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Jul 2022 04:11:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC35A38A6
        for <linux-perf-users@vger.kernel.org>; Mon,  4 Jul 2022 01:11:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e28so12325578wra.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Jul 2022 01:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XdfZuCz31I3dZ9oZhErj8lvxSYGHlQH77vSFPPyQopc=;
        b=Ge1INB7cKd6HbqaH4ZXMeX/l3dO8/q5UGHnCGDbV+bcEPzZWk+k0IHWd3Z3kBG5MU0
         Z7fR+3LRRwMTEMET3bg12K3bNHWwz6GkI9xvsDcQhOCi1j/AD18o7ZQHRVaOPJQKuL+q
         eeyS4+Bvc93d1Rn/mNy4wBGwdTwZzKGMVhaRwMZCGPtElDKdHttoh6zYhUn7WhGuR0Fq
         GaUVhRUHxfYAcjaXB4vo8ZeA7uA3/a7qlpCGkLFp3DOyrqxQy9V3eokzUHq1ojU/F/Yp
         N4ha7h1jp3Ku1cgimvDXbeA1TgxrP1FPNhn7j/62mJpKJbYfzcXygex429chSmifkc29
         x7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XdfZuCz31I3dZ9oZhErj8lvxSYGHlQH77vSFPPyQopc=;
        b=uu//TGCIMWovjZmj6PBX6coZRchl1HclS1iTlyGOKs4VeEhM7wTbJ5SpFTLlwo4O84
         A46AxJsRBnUhhy9hZqNOklSCfwh2GItzUrTwi5dSqzwygNI9zBACAoOOsO8r4083yupK
         lKFc21ST+shhIk5rSixVkiiOck1bJaW/0j7ygrFroPJsrEtyNzABNyCq5KNCDO/o/XWe
         9rGCHMOo5lNurKgKGgUYUKnfLiZsTK1Why2l0JtuBnJPWVcBKJ1bHiZMAurh/LFvUx5M
         +cFa40ZKJf0HmvKZKdGlZj5PGt2+4ZUZZZL7ehRuOiYfac+pjRrcnp7eSRwqJjq/hEoh
         W5Zg==
X-Gm-Message-State: AJIora8f3t1HmjRp2MKB1kfD7b3IUfEZksdL5dQuz5uGWjpsFLvrKdyE
        W367gYtSmP3cqXevT58IRDISLw==
X-Google-Smtp-Source: AGRyM1uHtXRF4rfVMvWkJuFgqxnQW29twRsyx5gVj0TcSf6ZxXjLvxDofjYD1B9qmSYGx/LI2JBs+w==
X-Received: by 2002:a5d:52d0:0:b0:21d:3626:6cc3 with SMTP id r16-20020a5d52d0000000b0021d36266cc3mr21378760wrv.334.1656922318576;
        Mon, 04 Jul 2022 01:11:58 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:c4c4:4ed1:ae43:27f2])
        by smtp.gmail.com with ESMTPSA id u3-20020adfdd43000000b0021d650e4df4sm4388276wrm.87.2022.07.04.01.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:11:58 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 07/13] coresight: perf: traceid: Add perf notifiers for Trace ID
Date:   Mon,  4 Jul 2022 09:11:43 +0100
Message-Id: <20220704081149.16797-8-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704081149.16797-1-mike.leach@linaro.org>
References: <20220704081149.16797-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adds in notifier calls to the trace ID allocator that perf
events are starting and stopping.

This ensures that Trace IDs associated with CPUs remain the same
throughout the perf session, and are only released when all perf
sessions are complete.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index c039b6ae206f..ad3fdc07c60b 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -22,6 +22,7 @@
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static struct pmu etm_pmu;
 static bool etm_perf_up;
@@ -228,6 +229,9 @@ static void free_event_data(struct work_struct *work)
 		*ppath = NULL;
 	}
 
+	/* mark perf event as done for trace id allocator */
+	coresight_trace_id_perf_stop();
+
 	free_percpu(event_data->path);
 	kfree(event_data);
 }
@@ -314,6 +318,9 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		sink = user_sink = coresight_get_sink_by_id(id);
 	}
 
+	/* tell the trace ID allocator that a perf event is starting up */
+	coresight_trace_id_perf_start();
+
 	/* check if user wants a coresight configuration selected */
 	cfg_hash = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >> 32);
 	if (cfg_hash) {
-- 
2.17.1

