Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FE6C19F2C
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Aug 2022 19:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbiHCT1S (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Aug 2022 15:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiHCT1L (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Aug 2022 15:27:11 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09695B057
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Aug 2022 12:27:10 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id oo11-20020a17090b1c8b00b001f285a3bdf0so1544548pjb.5
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Aug 2022 12:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:reply-to:from:to:cc;
        bh=pubjVED0BoBlj/p5UniQdmKFhKP0erdMehcit07w1Xc=;
        b=V/n/vMZRu+2+sx1k/94A1X+hKQmzD4su5cyvN0W8gCb+UDecM7Dzc0xv9fxSXNlzbg
         WrhFFxqVaCUv8c+72XHzpgT9KPhxgIVj92G8orOu0r2DNchv+9GzjRRyT4hIA5YinsjM
         snGjCqI4NIydpKY3u/9H4s2FNN8wMXyEOaWMlydbCNrz+/ixl1+0OE/mI9oajENTUB9M
         hshvVMs5lxYdozh0MAYYbYwwPbZFJS4XHI1/qmx1Yrm7A1h9p4vxUgj5/Rw5LivYhI/q
         LSgckFpjYIp/4OeZttuaIrxJ+A6wBll4G0+m3gaGmuKQ38MnZlLvpv34a1fNOSZLfpQD
         GzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=pubjVED0BoBlj/p5UniQdmKFhKP0erdMehcit07w1Xc=;
        b=k6x0q7WoSj2RJWZOJN6HmkGcSLdV1I27nFXPbt807kNNaXruXQm9VsMSq28vPAPhHh
         TIXltAMpbPAT2TURx9EakDjvQRbpintyVklkxAJ5Y3goQpXmlHRV+bp0zrFSQVT5plnt
         mdOAKs5GO2N5a8WYYe0A5kfnzyuuIXAkIkWcZ+XCXbAKzPtHnAddsL6xJswQ4ql2blQK
         m/ljcWlIIBxhxb5HIBG77twEHncl+y9Tb+tPpeKHkJnYQVtORQFPOlAQDaWlwOfua9Ym
         cr3A3lba0RTghgLw1dgjk6hQ/2jw/ZD6f1KDP5bT4J9CTaj+ZZtS0mhrEFMQYtpv61/n
         EW8w==
X-Gm-Message-State: ACgBeo0RR3xPOH0xjr+F7O9BJxJPWfuPDAlMkHpQ3IWZJGts5pYw4jTQ
        NRSaENhcCg/8sOJoBfwsP1TWHJZtfLs=
X-Google-Smtp-Source: AA6agR4SmuyM1ck3bZ1o8K58VylIsD5sfq4HiuedgIvq/RCqq3O2egwmPnV3LEHYaJ84anCSgkQUKLE2jlA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:80c7:0:b0:41c:62dd:2109 with SMTP id
 j190-20020a6380c7000000b0041c62dd2109mr7897814pgd.449.1659554829551; Wed, 03
 Aug 2022 12:27:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  3 Aug 2022 19:26:55 +0000
In-Reply-To: <20220803192658.860033-1-seanjc@google.com>
Message-Id: <20220803192658.860033-5-seanjc@google.com>
Mime-Version: 1.0
References: <20220803192658.860033-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 4/7] KVM: VMX: Advertise PMU LBRs if and only if perf
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
2.37.1.559.g78731f0fdb-goog

