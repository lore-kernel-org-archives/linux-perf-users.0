Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0B7C54EBE
	for <linux-perf-users@archiver.kernel.org>; Mon, 16 Jan 2023 12:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjAPMud (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 Jan 2023 07:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjAPMtr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Jan 2023 07:49:47 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A4C1E5E5
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jan 2023 04:49:44 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso2165466wms.3
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jan 2023 04:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UhRbA3Bqp5wzwk6l8nkMnlzM8NPWC0TqClYGwAsB7GE=;
        b=m40ji9um9rIDYtcSBCzb6wsXOm/+4ZmSZ0PolpM4qGrslipjQc1xEq5i8ANf1CwMJq
         QpNb+wGIKmEQukxBdW1asUI2YQC64wfuO1L3+klA7pR12I+TIw3us81Hon5uCmEzclXR
         3wAycOW5mr8fiH6beZ9tDneJirIhtQpOJsu9f+qieextJ5+Njw/9vHyGAaRgsmiYnZjA
         52IWNOmsFxh7jmXDtoQSpWxMscIUnv4evVfahHv6Lz1zJ+8yEO5P4D6aWOC/ZH9zNB5a
         gM6+djsGMmpwqVw4UOmSJgz94yM081Itav8bUQ+GexXWtR4t9PEGC47MhVP+nbc7Y9eY
         963A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhRbA3Bqp5wzwk6l8nkMnlzM8NPWC0TqClYGwAsB7GE=;
        b=r17aP2dqkAmFYGI2lg8XSLn0e6U0nFR8jtQiByDFlRP900HrNAZov+hfhAPmi/5Sf8
         oj5xPbSQgc21KPvPN2WJXZH1JUEKKZ0u8FMiw34q6Y1GJ2rmeFWLtbke6Ke+sSKrWPqR
         1fj6Ff7Ewc9XgOt3w2jElairjkGWQzHRKp83ZZFSuCVSDcOvdaB+SYLBspa7rhz01S/R
         tfe0SoQtliGCJxR4XeMnC6kSCw+W6620VdR6GAmHBOoSupbWHg68Kkw1l6OeWBIrtVxo
         DyReclkmL/cN8oka1l47/YEVb2ySNNiKvaXcR4V5sTwfFEIkwP0w94oEAkTYFCzERu9e
         BgUA==
X-Gm-Message-State: AFqh2kqk9bOU1f+QuNVxLQJ9M9i3SPf4zuVmslQw52PbOoJOws26UPkf
        4IuioWFA5J8cri2gkc3WwnAyjg==
X-Google-Smtp-Source: AMrXdXuQYumzTqPmmsJ0ti/I9VoFo5/pKOswmOHwMggL/DaN9gZlGveuCdz5DpENUn8FqD2C8t3SeQ==
X-Received: by 2002:a05:600c:4a28:b0:3da:f9e9:3a1a with SMTP id c40-20020a05600c4a2800b003daf9e93a1amr3896373wmp.20.1673873383205;
        Mon, 16 Jan 2023 04:49:43 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:6c91:710d:9433:e868])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b003dab40f9eafsm6896832wmb.35.2023.01.16.04.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:49:42 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 08/15] coresight: trace id: Remove legacy get trace ID function.
Date:   Mon, 16 Jan 2023 12:49:21 +0000
Message-Id: <20230116124928.5440-9-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230116124928.5440-1-mike.leach@linaro.org>
References: <20230116124928.5440-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Removes legacy coresight_get_trace_id() function now its use has been
removed from the ETM code.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/coresight-pmu.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index ffff4e6277e5..624f4843453e 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -8,7 +8,6 @@
 #define _LINUX_CORESIGHT_PMU_H
 
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
-#define CORESIGHT_ETM_PMU_SEED  0x10
 
 /*
  * The legacy Trace ID system based on fixed calculation from the cpu
@@ -44,15 +43,4 @@
 #define ETM4_CFG_BIT_RETSTK	12
 #define ETM4_CFG_BIT_VMID_OPT	15
 
-static inline int coresight_get_trace_id(int cpu)
-{
-	/*
-	 * A trace ID of value 0 is invalid, so let's start at some
-	 * random value that fits in 7 bits and go from there.  Since
-	 * the common convention is to have data trace IDs be I(N) + 1,
-	 * set instruction trace IDs as a function of the CPU number.
-	 */
-	return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
-}
-
 #endif
-- 
2.17.1

