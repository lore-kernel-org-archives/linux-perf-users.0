Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39546C05027
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Feb 2023 16:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjBJQzi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Feb 2023 11:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjBJQzZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Feb 2023 11:55:25 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B755C55E77
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Feb 2023 08:55:24 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x9-20020aa79409000000b00593a1f7c3d8so2932414pfo.14
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Feb 2023 08:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676048124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+p08AfrdrQMfpJn1ylcvtO2Ig9cnBH4qygeKLOxyr4=;
        b=SJJd0x95oNZ+eJQfXnvXcpugz/a/cJ+t9ikkLVEfVtRWYvweJlyL3WsO4eM7MJcg/c
         AvuIkRDYmJfWt6mBsXaQDLbUYUv3iGwzyNiSTYdCbjk5NTtwPRCibsiHvcZPRYnkKCNj
         4vFEqat3l1uNf6/MAVgldhCHeMCpAWjiqKddoQZ2bu07652Sv7UUo0O9PZ7XLU0YGlhH
         o8+55/RBTztktn9Vpf63AFfTrFUym6cc66WxvRBEQgxqBxunk42UE7pYxOTFK/lysFhk
         1s4Osm/IfUcqfAnVjhZii9KLaMfHR7HFObkNzRTMRYTPuqXC64V60/lqDTHenBHt6+kd
         GPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676048124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+p08AfrdrQMfpJn1ylcvtO2Ig9cnBH4qygeKLOxyr4=;
        b=nlAIQfEuoedN4CjNxr5/lf9X9UpgyWn4f51SAx0bjVJsE0F4fTdtQCbZb+qYx1PxH6
         aGepB+AjN++pnIpjAt8t9en2VisOquaLPDD0glJ6hdsdGpPRkG19GR+f6rU4zVYizfp+
         mhP511batHnXcuOypAWtWAKlx7Zwvck3h3D1e3gPoVwR3gKxqE47fVFSlWY7pE5f3gxD
         /eTH+f53aw7KaxfuNcPlFUTMzl1Aaz7qRqZrGPEF/PVEO2ViCRotjRUXp+zBkSXEJMEn
         RUv05ztTx20We8TNLcdabjpWyo0cHNq6bmWyeF9kbPENJ0PO1NmbnWEXhwGKQamngzaR
         5vIw==
X-Gm-Message-State: AO0yUKWNeQiVVAv4Q1XB83r5JkcN9YsmT86Ed+pIHhQMtLyr6sd9+rcA
        IUkI0h5VNGuTbU8RoA2X9rB6z9s5bmA2aTY=
X-Google-Smtp-Source: AK7set/PQpe51rDPvh02XY2GdXIh+tKbGt2sc7iL1OsES4twfuke9JZKzmdezrhfCssa+/AlaHlxPxaE7ZVOG9U=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:902:ea0e:b0:196:64bf:ed7a with SMTP
 id s14-20020a170902ea0e00b0019664bfed7amr3779552plg.29.1676048124218; Fri, 10
 Feb 2023 08:55:24 -0800 (PST)
Date:   Fri, 10 Feb 2023 11:54:57 -0500
In-Reply-To: <20230210165500.2292608-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230210165500.2292608-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210165500.2292608-6-zalbassam@google.com>
Subject: [PATCH v2 5/8] perf: pmuv3: Change GENMASK to GENMASK_ULL
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
Cc:     Zaid Al-Bassam <zalbassam@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

GENMASK macro uses "unsigned long" (32-bit wide on arm and 64-bit
on arm64), This causes build issues when enabling PMUv3 on arm as
it tries to access bits > 31. This patch switches the GENMASK to
GENMASK_ULL, which uses "unsigned long long" (64-bit on both arm
and arm64).

Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230126204444.2204061-6-zalbassam@google.com
---
 drivers/perf/arm_pmuv3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index b3683fdf8d0b9..dc8b8c8f1b3ed 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -489,7 +489,7 @@ static bool armv8pmu_event_needs_bias(struct perf_event *event)
 static u64 armv8pmu_bias_long_counter(struct perf_event *event, u64 value)
 {
 	if (armv8pmu_event_needs_bias(event))
-		value |= GENMASK(63, 32);
+		value |= GENMASK_ULL(63, 32);
 
 	return value;
 }
@@ -497,7 +497,7 @@ static u64 armv8pmu_bias_long_counter(struct perf_event *event, u64 value)
 static u64 armv8pmu_unbias_long_counter(struct perf_event *event, u64 value)
 {
 	if (armv8pmu_event_needs_bias(event))
-		value &= ~GENMASK(63, 32);
+		value &= ~GENMASK_ULL(63, 32);
 
 	return value;
 }
-- 
2.39.1.581.gbfd45094c4-goog

