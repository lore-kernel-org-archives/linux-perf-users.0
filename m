Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD65C05027
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Feb 2023 16:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjBJQzz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Feb 2023 11:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjBJQzk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Feb 2023 11:55:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747FC7B16D
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Feb 2023 08:55:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v63-20020a254842000000b008f257b16d71so1755783yba.15
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Feb 2023 08:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9xr7inanUxvnhbT5e3KgIdxiMjmahu/YJZqJj0STyM=;
        b=dorYTVJY81IW8njZuZmcIkXwowwBggAihpo2PrUJFXxOns0g6cYH0r0Oh3CIk0/EpG
         09LvwEViXEJLDblRrkESm2N7DmIiMkq6MNY3K8s44kuozzJakiZSM52iDmpNwZg3O1he
         3x9hLXK482NAnKK246NGclWsTncJSMYtCfIu4oqPw8XaaqXcIAcjSaONYXAfeEf4U9Bu
         XF6O9pt03u+T2EdZqy1thJVjD7DJkCrkkfzmnjy/dKukLi/i2SBNPa06qYUKwKw3fFiv
         5tR5wi0SHBhSHjEPOKTAgVtdkFiuKPp1d+yur02vCPKrlDJnpxvdWzsJB5nPx7P0nFeM
         UC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9xr7inanUxvnhbT5e3KgIdxiMjmahu/YJZqJj0STyM=;
        b=yAkQ+pwjD40fNPt/Dx51KtF6WY4tfh2109PLb7zOUmIMlCigA+tpQDda7bf7+HpuB7
         6OULT5HzAwCbmCxvtJEWTraCIk4qEsquqY9ClmIxHlIQBxlJN+lUZILBmJLW6q3PHlHM
         v3JtzFblFu0rEXBMotpSItQJqG4kIoxTL/kCHIXk0Z+iiEyEVRYASNQpoJKsNomxpyHS
         hPi4FvQ49Dk8otFy+ir0xzPSkkXN2Md7rAeA/WmKHW8xfx9DgVEHtEJ87n0iqoBIGkkB
         uXHNtVTbecgyBK6TeHVE7r2EXX3kgwVYYFky3W1dTnP1Zhoc/bHV77H20dxRKj7xbXlk
         JWAw==
X-Gm-Message-State: AO0yUKVMQw3gFbxmenEzgijPulbhZsgDV0AeGBr4esfTH1hUong8Zw7R
        jHOFrJIP883lCRS4nRAFrf4aqXp0C084ivE=
X-Google-Smtp-Source: AK7set+aaGC8ED1Z1V48dR1v+sHl5MfnTu8+R57SOtAi0NcxeUy9VenwVgsenFBOObiltCmLkVHcnl3/u4biTJQ=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a81:9b17:0:b0:52e:cacb:d7c4 with SMTP id
 s23-20020a819b17000000b0052ecacbd7c4mr0ywg.5.1676048130025; Fri, 10 Feb 2023
 08:55:30 -0800 (PST)
Date:   Fri, 10 Feb 2023 11:55:00 -0500
In-Reply-To: <20230210165500.2292608-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230210165500.2292608-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210165500.2292608-9-zalbassam@google.com>
Subject: [PATCH v2 8/8] ARM: mach-virt: Select PMUv3 driver by default
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

Since 32bit guests are not unlikely to run on an ARMv8 host,
let's select the PMUv3 driver, which allows the PMU to be used
on such systems.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230126204444.2204061-9-zalbassam@google.com
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 137f89ad05211..3802997fb36e6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -400,6 +400,7 @@ config ARCH_VIRT
 	select ARM_GIC_V3
 	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
+	select ARM_PMUV3 if PERF_EVENTS
 	select HAVE_ARM_ARCH_TIMER
 
 config ARCH_AIROHA
-- 
2.39.1.581.gbfd45094c4-goog

