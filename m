Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C205C4708F
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 10:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48FB3613BF
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 10:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhFBKcL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhFBKcH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Jun 2021 06:32:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45590C06138B
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Jun 2021 03:30:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q25so1823928pfh.7
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jun 2021 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvAJvuDnRJDe9YMY5R2L+q2C0nSKQeIr4jFz4M7hp0E=;
        b=POWzSZ5TRT+9dr74+V15dGxhepckGw99Xtw70LETQ2z3VMGYTXTOwtdm6cl33wbAff
         LEsF+BxxrTAxWeVcYdCHSgWl+4xjHatzqqb84TDjSjM4cps1Xi43q0gRKuKehIGj6QQJ
         SMVld7CJ3kXmvcclqESa7CHe5OF5x/O7GIgLU8gTKMtOQmTEf73RqTyPY91NLA5ARmu5
         SF9IjG4Qhswx34IcxQZO+wWSocV3XUptIOGGHQl2UZyQvH901whvw+yf+Aawpxuak0+n
         UN8gron1YQzhcgYefKP7eI2zgGQoqzJCrDn84BJ71sbk1565GIGlKdAfNJOku6vlyGgQ
         7bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvAJvuDnRJDe9YMY5R2L+q2C0nSKQeIr4jFz4M7hp0E=;
        b=Ouw3ZlMYSKyvOjUqQ+btyMLIV3Y4ihTi2JgbkZ9uKhwdneVFtHRKLCSx09gaguJj49
         O1acQcjb7svTqK12UcwLeGQXdl5WlqF4X6F6lIOJ+PIrffgcuCjssx8YOhARY58H0gQ3
         SCBkcp90xeUuwQaOOgByTbRJxYiBIpTsgeDXSJ8EBmfutFxRp+i129CIycYnd+xuleaR
         v6zkNUeEJYCgZmK79i/vkqY0RtkPqtwCQZ+odWF3bhqphWBTDDrp6Puxu4ztEu6DjhuB
         c/87N1HHqysY47+y0lyX4Q6YWk24dewzCqJbO7U5IXRVw+ui/BpPXsHuoCCKAbLdXelI
         aIFw==
X-Gm-Message-State: AOAM531YLP4Z9M2RrVLW9TfkamciIAeLAixna1CuYdSra3DvCCdM9Chm
        Zo3lR6jujq+zsO+xetRlyGnmIQ==
X-Google-Smtp-Source: ABdhPJy5pG1LjUfP91QAtl2t0ow2iEBMIl7BJdK1RWAS4sEnHwBJ5KdESYaC3yr/wQPQz544PM/Bvg==
X-Received: by 2002:a63:5a19:: with SMTP id o25mr32747476pgb.122.1622629822770;
        Wed, 02 Jun 2021 03:30:22 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id g141sm15568758pfb.210.2021.06.02.03.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:30:22 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/8] coresight: tmc-etr: Add barrier after updating AUX ring buffer
Date:   Wed,  2 Jun 2021 18:30:01 +0800
Message-Id: <20210602103007.184993-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602103007.184993-1-leo.yan@linaro.org>
References: <20210602103007.184993-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since a memory barrier is required between AUX trace data store and
aux_head store, and the AUX trace data is filled with memcpy(), it's
sufficient to use smp_wmb() so can ensure the trace data is visible
prior to updating aux_head.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index acdb59e0e661..713205db15a1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1563,6 +1563,14 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	 */
 	if (etr_perf->snapshot)
 		handle->head += size;
+
+	/*
+	 * It requires the ordering between the AUX trace data and aux_head
+	 * store, below smp_wmb() ensures the AUX trace data is visible prior
+	 * to updating aux_head.
+	 */
+	smp_wmb();
+
 out:
 	/*
 	 * Don't set the TRUNCATED flag in snapshot mode because 1) the
-- 
2.25.1

