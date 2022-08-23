Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6F5C38145
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Aug 2022 10:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbiHWKpH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354616AbiHWKm6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Aug 2022 06:42:58 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC68FAB051
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so7376325wms.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Aug 2022 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=aQd1+sXptG+dXZkMCM1QB94Fz8Pu2kkVLyqLPUwsHlw=;
        b=LG0uBul7JWvbK6rlaTen26I5SXJEv/D7DhhHJp6FhtNH2DaSus7+I3xfk4h9h8cBxY
         ju4ArQTKNm+S0ZIVLPqoV/KU/WxjS1OSM1Q6rGiQPYbal2gzih3Rfd1Z6B0NPAYtWw0U
         wVaeolxhGcg+lWcx3tt9AuR8zz70Nz/HCITxS5npAfmC8MrHsmDzlDSp/4I9Xwxn1PJi
         4aTaFfS1/awdlj9KmBI9MS1RnJj+vdHai6IFfvUjglgL3nXjeeKhwKYWnFIIegfjSLHv
         3A4J4dKECJWAU52w/v1gykJTeOWmWSOLY4961lhUWVCk0Tq0+V4iyvFxUvsrI/pW1BLO
         REQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=aQd1+sXptG+dXZkMCM1QB94Fz8Pu2kkVLyqLPUwsHlw=;
        b=mN9XDhfs9Y9b8XK8PMR90Gu5ac/OhSjO4dLinTLsK2PyUUBrhjyQDapZLVW8HbnnEK
         uCd263C9ZnlRBIdIydeKyvhUO2TNpyZCPmUfd/LAzCHSYJfSbn1FbJW1JkW1QSZ+9ls0
         aEdQihkomL3YmBzcgDIgOsb8h8QBZp9asn8wu9Te1EwYp02V5Otbq2+EtxnYf5gGCNw3
         DU6KGo8kkbHkYFRhAVj23ux8dhHPLeL7aLcxtjk17qjSny6S0b0tCpxB4llbhiXN6hjS
         WiYPQTjQGMVdEw5NgggADBbih6NnGiUsLiAHyBLILJXdW2KZ8pwZY30dnukUXpjAmUpx
         WHCA==
X-Gm-Message-State: ACgBeo2RSn9JImehOIJl/dz/j3/XZRDjgrx7v3vJxm6xs4X4ug1CkBnM
        9c6l5oed0J++V29Z1Cf0omAmE82Nn3UaLrQP
X-Google-Smtp-Source: AA6agR5i0OGJJj/Hn6w7u4mF0zrw3CvQptA+b0ncS08T4HuYTJy2luWzxhEJienGgJdv18Byld9Igg==
X-Received: by 2002:a05:600c:154b:b0:3a6:1863:acc0 with SMTP id f11-20020a05600c154b00b003a61863acc0mr1541219wmg.29.1661245824501;
        Tue, 23 Aug 2022 02:10:24 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:4553:cf11:6cff:b293])
        by smtp.gmail.com with ESMTPSA id w6-20020adfde86000000b002253d162491sm10760721wrl.52.2022.08.23.02.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:10:23 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 10/13] kernel: events: Export perf_report_aux_output_id()
Date:   Tue, 23 Aug 2022 10:10:06 +0100
Message-Id: <20220823091009.14121-11-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220823091009.14121-1-mike.leach@linaro.org>
References: <20220823091009.14121-1-mike.leach@linaro.org>
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

