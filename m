Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D774AECAAD5
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 Aug 2022 00:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiHaABH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 Aug 2022 20:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiHaABB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Aug 2022 20:01:01 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE94F6BD4A
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Aug 2022 17:00:59 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d6-20020a170902cec600b00174be1616c4so4888973plg.22
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Aug 2022 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=qJXKs+ZLE9emDk3uVMrPeQaTARYDAHlXW11oK3RW2Wc=;
        b=SeC4SpEUA9Pj0gJ4NsFdHazet6GE9bdJ1dT6nWyveIfGZuo4CKCEVpytHC64cm9plj
         wOdcAYiLeQSXoHXjHQY2kqRBjQVhPudE0imZ22YGjYoIbrM6bDxeQOE8AH7eLW7f0ezd
         WH2vXQB6njqucYikofJ7Ee/NM6nFuGUTwz+7SftSDtbcPOENu0gg/MUl2PUczy8BJJz2
         hyExUDUd77eEx4pxmLpyzU7b8ABB1IT93OerKqZeCNQBastYtbtlIAtEIRdyfksk+1oR
         ONRzuizCjC3rQ1A3LaB9bt6kB1/BWGcmbDAw/SZNbE+uA0DXDJMXodqMZrpiCfvsJWxA
         SMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=qJXKs+ZLE9emDk3uVMrPeQaTARYDAHlXW11oK3RW2Wc=;
        b=UkmuSp8eNskJoXIdqMK1N4O+Ad/UHTmJNKc/eeEsSPPI5dkxtEJX9dpAbd1DPmijNU
         CQnINxuUH4XPU4ZJVCXFu4DXID3TO90gD2E63zWDypx+XLYDRle4EK/m5/6sDdbtPRwC
         5jR5mABrPIjKxJ1J40l9mRzv96LuKt+CffSVTJsSCRi5WtbnzSDKKqXvI+nqtaAgfXIK
         tFeR7uStn0SZBUW53KgLo7KGBBYdUxO0NsIUXXzlKm9wMvTLNcDkYOpSgbyBQm/mC8p2
         iyGFkm6fApqbBwwuB01ZkaiCzEpZhgTONjDLoE0Vnqa7rxY3s3UBT0CXC8ngCDp61x02
         /2+g==
X-Gm-Message-State: ACgBeo2FZbtZwCOZqT7nEDQk7CPaXvUKKF/UJzWzGMdxa4ltPgGKJxJU
        kjZdAGQxwpv5cTv6sh2EFfti2OYLkXI=
X-Google-Smtp-Source: AA6agR7Ex184XlJZTk1AEwJjTtBbOvVyb+1EL7HgzEsb95OcRUH5oln+KYkb9WpAdL/XG36FFJKIVlM6JxA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9430:0:b0:537:ab14:6cd8 with SMTP id
 y16-20020aa79430000000b00537ab146cd8mr23155574pfo.29.1661904059303; Tue, 30
 Aug 2022 17:00:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 31 Aug 2022 00:00:51 +0000
In-Reply-To: <20220831000051.4015031-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220831000051.4015031-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831000051.4015031-4-seanjc@google.com>
Subject: [PATCH v3 3/3] KVM: VMX: Advertise PMU LBRs if and only if perf
 supports LBRs
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Advertise LBR support to userspace via MSR_IA32_PERF_CAPABILITIES if and
only if perf fully supports LBRs.  Perf may disable LBRs (by zeroing the
number of LBRs) even on platforms the allegedly support LBRs, e.g. if
probing any LBR MSRs during setup fails.

Fixes: be635e34c284 ("KVM: vmx/pmu: Expose LBR_FMT in the MSR_IA32_PERF_CAPABILITIES")
Reported-by: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/capabilities.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index c5e5dfef69c7..d2fdaf888d33 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -404,6 +404,7 @@ static inline bool vmx_pebs_supported(void)
 static inline u64 vmx_get_perf_capabilities(void)
 {
 	u64 perf_cap = PMU_CAP_FW_WRITES;
+	struct x86_pmu_lbr lbr;
 	u64 host_perf_cap = 0;
 
 	if (!enable_pmu)
@@ -412,7 +413,9 @@ static inline u64 vmx_get_perf_capabilities(void)
 	if (boot_cpu_has(X86_FEATURE_PDCM))
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
 
-	perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
+	x86_perf_get_lbr(&lbr);
+	if (lbr.nr)
+		perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
 
 	if (vmx_pebs_supported()) {
 		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
-- 
2.37.2.672.g94769d06f0-goog

