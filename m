Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B8BC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 00:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJFADZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 20:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJFADW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Oct 2022 20:03:22 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803CC2FC2C
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Oct 2022 17:03:21 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id cb7-20020a056a00430700b00561b86e0265so196998pfb.13
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Oct 2022 17:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuL2WMiGYze3NRMdfPj3MoHFJUJYGCMiGE6H5e3qchw=;
        b=mWjjFMysPgnbZbFgdefAEx2kRBsVhavP43kyucIJt8jdHM/sTIeM8/nrm27y0nTdpB
         3KDpayu47Wl4wb7uRxPiI/OAtjMEWyffz852gWqdUiLHcxh2AXto+H/RgzVO4IrGT2BB
         PeQmdoOnJ8aUJB3yLZPh50+fJ/HuPUqFZ5KX/+Rfen6BaSt0tvzit14GTnDeiDixYb8F
         VoFb6shWMcdqhPS0xIAn/zPp+hwC+WrcYpT6YYhP2sOc63LLXlvfVVv4NackFLRO128z
         TBX2F7JtCKwCMC9bq2SMY56QED0Lo4G+whthTouWif9FedYgR85/xWrzizJkZRkjmYn4
         tA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuL2WMiGYze3NRMdfPj3MoHFJUJYGCMiGE6H5e3qchw=;
        b=mqcukJTcMrWnS49Ux/5fHVk7lBa8hPbC0sgE/2J5M3VmlcT5y4qlyoNAwEaaGkGcgP
         PFNm+PzhAX9NWxK+ECQxkuIo2Z7TgmIhk0aoWl4InH7vk/lHjj5bziUr3JWz1fYGzDU+
         JyH+8SV08s522wxNWCO1EK/cuJj6LTSNBFhsjed+H3FwgAQLJ6S5MTf2Ji/hEKkrRtsJ
         cHoiHhk1mhtu9ktWu8NvBPMbiMoGlxEfNjVWxQkiJAhn5TjOffXjKEz+kcS3ipppV7WV
         KhUxjUzHEih/ry3FhOf//CHgu4vzbeakT/UiwMDXsA7UjAh/QZZEJUmtjRZhDV6UgKTW
         5y6g==
X-Gm-Message-State: ACrzQf0oJrSY+RQXM7TvpgYpw2+biBDlnVrMxJbSOGo6SU+zfEpcBCvT
        kZkutpGk6Ur5kUYltGQCPX6Cto+x3vI=
X-Google-Smtp-Source: AMsMyM4kcuwbKLEWnGSBZIg5beqUVqfaQqN51gbsFgZ4VCZpviwVuV9lXyFgLBijtS+5dTsgFqY8DdCH3U0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2409:b0:54e:a3ad:d32d with SMTP id
 z9-20020a056a00240900b0054ea3add32dmr1929000pfh.70.1665014601268; Wed, 05 Oct
 2022 17:03:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:03:08 +0000
In-Reply-To: <20221006000314.73240-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006000314.73240-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006000314.73240-3-seanjc@google.com>
Subject: [PATCH v5 2/8] KVM: VMX: Advertise PMU LBRs if and only if perf
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
index 87c4e46daf37..a6689bf06542 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -400,6 +400,7 @@ static inline bool vmx_pebs_supported(void)
 static inline u64 vmx_get_perf_capabilities(void)
 {
 	u64 perf_cap = PMU_CAP_FW_WRITES;
+	struct x86_pmu_lbr lbr;
 	u64 host_perf_cap = 0;
 
 	if (!enable_pmu)
@@ -408,7 +409,9 @@ static inline u64 vmx_get_perf_capabilities(void)
 	if (boot_cpu_has(X86_FEATURE_PDCM))
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
 
-	perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
+	x86_perf_get_lbr(&lbr);
+	if (lbr.nr)
+		perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
 
 	if (vmx_pebs_supported()) {
 		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

