Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5335CC64EC7
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Feb 2023 21:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBMVDq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Feb 2023 16:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjBMVDo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Feb 2023 16:03:44 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D091C5A3
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Feb 2023 13:03:43 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id o19-20020a63fb13000000b004fb5e56e652so3562599pgh.9
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Feb 2023 13:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNlCxue8f7lOs6QuvM7/2EAnGBBamHm0s0gmH31uJ+I=;
        b=U058KpMINjh/TIWfjHqmqrzoZS+zo6kQ3qBHMGBc/zxuaVSMiK2aoKmOj9MVkOtqiH
         kQv+V8ppdbQr3FiXtnTo48s1embSUNk9+M2x/tDoErzuwTHbvafGS5z6hPD6+GWuYEPW
         uZSZ7pD6wZg/ji/Ee08N75aHmpCGZs0oRo1k8TmWL/nbIAzTTqF6j+kzGC0cGpO5sKRZ
         3Di7zJrx8vMmDb+mBOROXRu4C4pC5sfeowRAAL1tgiNYmWN9CQmKOwhVOOARyOyi/HSp
         TETl92ToaFLbPJB8RatdASWp5YMsJK9xcUT0MEjgmm8etExgbW3gKRELybDRmrFH7WJD
         85mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNlCxue8f7lOs6QuvM7/2EAnGBBamHm0s0gmH31uJ+I=;
        b=qvyU3Z6KLPN/+7/RJhNY6BsL3X0V1KP998NJ344RSmXUTBRu6yuJsE1CKhQOSkRfQh
         2FwyOdyimdsLm8UbwP4jZk40m21Wwa0rqoRNMtmyxbwXwNUgdQ2btmxtCoNnfQSepMyW
         NHArVpTd8gwTZl+ld7BmPEY9wyz6ikCE9MuEruugGFpZYE3/q+p5II7auN3EF3UwWBha
         Khq+bsDBwDs0JvA/CYBhRvTbdsAA6Q5aVUpy7RDikhEwi8rpyk6yvvLcqGP9GYwJ6qfy
         +r/sz/HFp8uTKnccTj7mx3PrZ0Vb9LC5pmdVO9Qoljpk/H6YlIYdkHd0WJKyfqoE2Qet
         e6Og==
X-Gm-Message-State: AO0yUKUTIBejXOROl6wzUPe8IM5wY3gc9sejA5VnWN0CO96mqxsLS0ci
        UAmMZ+vksSfm1EafplInPVQXWshYtM/jFQs=
X-Google-Smtp-Source: AK7set+80DDsCF1md9COtpoXmv7reEuLQsu7dVpGY6/rfogIf19/pYZcTTCpC8Ysd1iYqvJlAziEz4DFcLpoalI=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:902:9682:b0:19a:9980:854 with SMTP
 id n2-20020a170902968200b0019a99800854mr102676plp.3.1676322222866; Mon, 13
 Feb 2023 13:03:42 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:03:17 -0500
In-Reply-To: <20230213210319.1075872-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230213210319.1075872-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213210319.1075872-7-zalbassam@google.com>
Subject: [PATCH v3 6/8] ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 implementations
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
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Zaid Al-Bassam <zalbassam@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

ARMv8 is a superset of ARMv7, and all the ARMv8 features are
discoverable with a set of ID registers. It means that we can
use CPU_V7 to guard ARMv8 features at compile time.

This commit simply amends the CPU_V7 configuration symbol comment
to reflect that CPU_V7 also covers ARMv8.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index e949e84a2decd..b77f4a0d9072e 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -403,7 +403,7 @@ config CPU_V6K
 	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V6 if MMU
 
-# ARMv7
+# ARMv7 and ARMv8 architectures
 config CPU_V7
 	bool
 	select CPU_32v6K
-- 
2.39.1.581.gbfd45094c4-goog

