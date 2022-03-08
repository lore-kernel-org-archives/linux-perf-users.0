Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40A9C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Mar 2022 20:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350286AbiCHUvV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Mar 2022 15:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350282AbiCHUvU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Mar 2022 15:51:20 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE75D340CF
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Mar 2022 12:50:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e24so17431334wrc.10
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Mar 2022 12:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sw4xwZRTTjBJM4wcsTZt554bc360dKae0Yk+cjG+3LM=;
        b=VovctRatE/Hh/GbXDnfGoZ7kGZelTUslgwp4Sr6q2UrJWHkCaO6RSfDfl4AMzv13JX
         tpRiLWLlhDDJ4PRVMp5J3dj/yvSuyaHxdzAoEX9qHPlVAyQsGnltVOxnjroBs91k9Y0H
         SfZgQm5YTJVvrJfij2goljk0j4JVm+BpUKq+d8VTuCd4ZDdPVqJ/0RIWJSATf29tKmAC
         bfSy+KN0am/pKhXgICoe9gGBanbaSd6Y3WlQGFslO7tCwEm/sU79DQiV6c9l9hWd9RmO
         FE4CRw57GkoAn2UysKML38x61E22SMbG2iUVlXa5jnNTyTRoUYgByjQxVIemEEa6c9MK
         sSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sw4xwZRTTjBJM4wcsTZt554bc360dKae0Yk+cjG+3LM=;
        b=b6WmUkWTvbY0PPc6YzE/5zpAQi2hABH/LJzZ6or65CiWTEH5gM58hBxV7U3ajmQIsk
         NbuLfijx61BZNVHAj+fSUTbgQicDQ1Hijs0atzYyPKSIDU5JUxgIZrgfIGDOW+UASslE
         84EWyWDIz9MD5ZyDSrNXZh71pSesRw3mmRfdGGXKLMp9TMaEcGpvVZqSKVmvGloSeBPN
         tFoBf6TgqKkT4Ni/68JGiMoFzFf8agsPt1U1vGmy18MJeVNbJwh0AdwWJM1KzuZzjaz8
         UlJjRyf7RdAayjA7i0Mu+69A2TrOdiMrA1z+FI9kNplhSYaQ+b6LTGEZitfZuj12JeV3
         M8LA==
X-Gm-Message-State: AOAM533Xn4oNr7ddjVl+Cfllh9hE2EW8kGnkeiX2GKbzoVOw33BO4Qsa
        NLMsnDBEwFsZ7Gi2qS9/HKud5Q==
X-Google-Smtp-Source: ABdhPJxXSIbBxcT9dt3sJvdZKh8iPGJdFd/p52e4WRJecsc9Nrorp/W6kWWMjyBtM1B3Y6peeKsZgg==
X-Received: by 2002:a5d:4892:0:b0:1ed:beaa:778a with SMTP id g18-20020a5d4892000000b001edbeaa778amr13409236wrq.35.1646772611303;
        Tue, 08 Mar 2022 12:50:11 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b00389ab9a53c8sm3245758wmc.36.2022.03.08.12.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:50:11 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 08/10] coresight: Remove legacy Trace ID allocation mechanism
Date:   Tue,  8 Mar 2022 20:49:58 +0000
Message-Id: <20220308205000.27646-9-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220308205000.27646-1-mike.leach@linaro.org>
References: <20220308205000.27646-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This static 'cpu * 2 + seed' was outdated and broken for systems with high
core counts (>46).

This has been replaced by a dynamic allocation system.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 include/linux/coresight-pmu.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 4ac5c081af93..bb4eb4de3c77 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -8,7 +8,6 @@
 #define _LINUX_CORESIGHT_PMU_H
 
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
-#define CORESIGHT_ETM_PMU_SEED  0x10
 
 /*
  * Below are the definition of bit offsets for perf option, and works as
@@ -32,15 +31,4 @@
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

