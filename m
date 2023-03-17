Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B863DC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Mar 2023 19:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCQTvO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Mar 2023 15:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCQTvH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Mar 2023 15:51:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B673338B7C
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Mar 2023 12:50:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54476ef9caeso56239427b3.6
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Mar 2023 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679082648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SWp43EKSObLScNJyve8NVm0+M7i+tQFxyt9k8TiRe9g=;
        b=e0o+1QipaOeuxF3SQj+/1I0NUJYANsvskj+jz+/JVVr1JI/Gi8EhYKPNYf6VCam0BD
         BAsjPkgg5/ctjSm5fbatVkc37cbroqyTAJ5lMHDQqqUyK1lU4+hREwmj8Q8fnx7emkyA
         FqesCCLDpG94eJAu7iyFgDIMb2uvcOYUTcrQgwHxZ/qSMHGAbwYNX1NfDIvwCrf3/yLh
         Qlzcif76NWl2d5Dec/ik4T5zqD5Ogl0pkotQHRqs3F6j3Db5VjWme4evtJbL06vcVC8k
         5G2KHySl3FJNxq+4Y1E8Q2s1mqtvNv/IskSm5DyA1K7kEWGH1hY/bYV0pIPrlheqehC+
         Vjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679082648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWp43EKSObLScNJyve8NVm0+M7i+tQFxyt9k8TiRe9g=;
        b=qpY9Pe6cyVsP6bHtwFHlHtCim/sBZWmaZEGpXmrUbJ2IkQ9Usl66cb74rhSQ8ii9OJ
         eMBzh4jbq8uLJN9xba198uX+fSh43Hsfm80yAWX76361EqfFy4zqAn9MSJMCcK9qZQaR
         5PwrsMC5ZS6e7MT1n86BzSNfQybm7dA0ShW9ozIe2hOoC7uV7jFmbMMjrT7+YfDFROWp
         TXcAKU4y00Aeqe7J0vJnRCMtOcV0coV3MZgwqCqrJsf9eyjdYxcuW6JLTeo7qr07eUTN
         iBBo1jSlaVwfkoRxQMQte3OxhCOSyxgaa5vlFLjKatKxKmxjlgGHn2Mu16cJubRPj8uN
         Duag==
X-Gm-Message-State: AO0yUKX+4vXJ1LJ75XNj5e6qULedAelt/0QcazOQRTzai1GTEJe4uLKr
        KnIPz29xiIEZkxqZiiaVjeyIGGhgt38xgrM=
X-Google-Smtp-Source: AK7set+1dZfI1V93G2NNZOWgyqiVDUpszfGni5yoPVSFDzoxKaFlWRR3P5jO5zsNV2xWLmuL0WJ9RjPmhL3qVro=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a25:2d1a:0:b0:8ed:3426:8a69 with SMTP id
 t26-20020a252d1a000000b008ed34268a69mr511377ybt.1.1679082648198; Fri, 17 Mar
 2023 12:50:48 -0700 (PDT)
Date:   Fri, 17 Mar 2023 15:50:27 -0400
In-Reply-To: <20230317195027.3746949-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230317195027.3746949-1-zalbassam@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230317195027.3746949-9-zalbassam@google.com>
Subject: [PATCH v4 8/8] ARM: mach-virt: Select PMUv3 driver by default
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
        kvmarm@lists.cs.columbia.edu, f.fainelli@gmail.com
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
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bc12857e81f9..6f0a2576d17f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -401,6 +401,7 @@ config ARCH_VIRT
 	select ARM_GIC_V3
 	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
+	select ARM_PMUV3 if PERF_EVENTS
 	select HAVE_ARM_ARCH_TIMER
 
 config ARCH_AIROHA
-- 
2.40.0.rc2.332.ga46443480c-goog

