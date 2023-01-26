Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD926C54EAA
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Jan 2023 20:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjAZUpj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Jan 2023 15:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjAZUpX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Jan 2023 15:45:23 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CC173760
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jan 2023 12:45:07 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id v23-20020aa78097000000b005748c087db1so1412848pff.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jan 2023 12:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gau1yQskHf3VXQpkYLtjLur+Qip6kit3p9HDDaJBRs4=;
        b=f1tvDTkJ9Rdj2sN9ssxN48UvzmplgYwTrZ0hhtRdBm9fRaPLn8g8VcDs0rLpbFcHEO
         27uS/Yu9hQmGtLZ99VCsQzwNchjpqj2B6r0Xr8JbcX69qEPLXE/ORk0iBr0fjYz0+nu9
         5FqcIFvNu4h5DsqJ5X6gcJE+XAjXWHcCit7jhK0MSJYvkTi209/LoB2JzX79iYN4FFQm
         K4XiVxY0vElKce6pOAA4fTVctu57lRe6ssarPx+s4HXm82RDYdSwG6tVPxToUsj+qnzK
         sNnF9xQEuFU6bWgkzcAgoyJ8kaKUPKPhSg7qXZMzPNbTFJyUSaAxOjzq7Jy1Wce9mH6r
         SUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gau1yQskHf3VXQpkYLtjLur+Qip6kit3p9HDDaJBRs4=;
        b=kYSz5AReZAbffuE47cNxcMsYXnTxbEBOU++FZ6kyYUUsFXJerB/Cj/FPE5ovzmWQ10
         HfAFYHwpc8hvDTl26YcbjE4DPFJIiQzrA4dhLi0/w2Qjq+mJobCnMbTnyOUeQ0QSPwI0
         SY926UBg28py6hEM72I+6I3JEtRR2N5TDzZYxlcIMcln3v5sqs7GghB++dnOV7hgELGa
         AH3vV1JOKST3dO0KCeNH4BW22Ub7aF33Axo0UllQke/nYeLEF5DxvmWKJGF2chNethfv
         Z3lZcLJ+dewPNvCbLMcqzFiL2r0dAea80aYYyIqQNdBhd1NtZ0CIXxSShfmFYIjP+uUo
         oxKQ==
X-Gm-Message-State: AO0yUKXahYcCCj1cqQ5e1bzR3s/5sze5ZEPYaMPBRtJ/gPvs9RIc5TvZ
        1W7q1OWPiz4/5Igx3mc73uEBaepXMIfaoSs=
X-Google-Smtp-Source: AK7set/TbnBjmUgqAAFzQMjbref3OlBWOk5pcb13kQePVWLM6NrlJPmaTSILrlFJ/sogPIbjRGpVECGiCbZN5ng=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:90a:2983:b0:22c:4174:3ad with SMTP
 id h3-20020a17090a298300b0022c417403admr156376pjd.24.1674765906698; Thu, 26
 Jan 2023 12:45:06 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:44:44 -0500
In-Reply-To: <20230126204444.2204061-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230126204444.2204061-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126204444.2204061-9-zalbassam@google.com>
Subject: [PATCH 8/8] ARM: mach-virt: Select PMUv3 driver by default
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
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 137f89ad0521..3802997fb36e 100644
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
2.39.0.246.g2a6d74b583-goog

