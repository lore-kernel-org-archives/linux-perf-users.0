Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D94C25B0F
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Aug 2022 22:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiHIWew (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Aug 2022 18:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiHIWe0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Aug 2022 18:34:26 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA34D6566E
        for <linux-perf-users@vger.kernel.org>; Tue,  9 Aug 2022 15:34:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h13so15825951wrf.6
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Aug 2022 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aQd1+sXptG+dXZkMCM1QB94Fz8Pu2kkVLyqLPUwsHlw=;
        b=KfyPZURWlklvfmYT3VEFPFFamPr8Uj2ht16c+zF2xnXiTDOiSrgmcoN4rGRx9kmLdA
         txDPiUbXSloZIWzcwh46XiAhQtaahH18D3reai0ISdHNrLBmUPzrGIZmIbT8rIGyaCbj
         dP41MCi93zKmFloo0SK1KIt/GOttlc6WlTtOdDFQiFqJcehoFqRpAEYADdIii0rKB6U6
         FHHjQDlU8h9IM4lx05PQD7EUj0x4fwMWXkbMl/bkdNMSve8WAGgzM5xs7Nln5l3jAjXi
         dNiU8Vxm1CLCWcZSrt0HIXDYlTE9ox/QYUJMC5ItCcdWaqrGGYAPrmrTIYmNPppnTHia
         hRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aQd1+sXptG+dXZkMCM1QB94Fz8Pu2kkVLyqLPUwsHlw=;
        b=Q1EeAdh9X2ahJMwQ/7lpZKZINbs05iLJSzCMJ2SpCKK65x6dU/67jHIewTya/QNL38
         ecmQLjIFVmGetNvAxb1hnPLwOi6O96mpFUTbSffhiQbIFasNkB9G1M8u7LTjfs3u4oEB
         2mCzUInzqaJ71pZ2o9Cpgv+9nWU7zs3xUL8c5ev5kVLDz56WFQyDTroJnyh9x8NYhLaS
         uV7gzfPQqQsH/MCzkxi7hZZt+ju7Ebej2d5O73x+ikUu4PApMqaeWaBZnPzdQGxcKbsZ
         DLP20Lin9oMJMsaXLxAldx6jLXmT9ya0wwvvZKQl9GIE/tK/YUcMYVrXAVdt2X9I3HRu
         1nmA==
X-Gm-Message-State: ACgBeo3AKnVqYDRlcu/Uo89CE/xR8OnWqQD1XZqGzu6Fw4rqAdHMeCpI
        YwVZqkFq5vFDu0OiwGgdxPFc/A==
X-Google-Smtp-Source: AA6agR5PnwDdpAvLHMvCp6HiwJ28jxHiC1oddi+y/u1VMjCdhK6oOz7Ycxefb97Yha0mnATrTvJhvA==
X-Received: by 2002:a05:6000:1102:b0:220:5c10:5cbe with SMTP id z2-20020a056000110200b002205c105cbemr16129284wrw.359.1660084456145;
        Tue, 09 Aug 2022 15:34:16 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a6:74a6:5a0e:f3e2])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4b9400b003a2cf1ba9e2sm311650wmp.6.2022.08.09.15.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:34:15 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v3 10/13] kernel: events: Export perf_report_aux_output_id()
Date:   Tue,  9 Aug 2022 23:33:58 +0100
Message-Id: <20220809223401.24599-11-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220809223401.24599-1-mike.leach@linaro.org>
References: <20220809223401.24599-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

CoreSight trace being updated to use the perf_report_aux_output_id()
in a similar way to intel-pt.

This function in needs export visibility to allow it to be called from
kernel loadable modules, which CoreSight may configured to be built as.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80782cddb1da..f5835e5833cd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9117,6 +9117,7 @@ void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
 
 	perf_output_end(&handle);
 }
+EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
 
 static int
 __perf_event_account_interrupt(struct perf_event *event, int throttle)
-- 
2.17.1

