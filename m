Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8857CC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 00:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJFAE1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 20:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJFADr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Oct 2022 20:03:47 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB2487094
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Oct 2022 17:03:32 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id m16-20020a17090ab79000b0020abf0d3ff4so129996pjr.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Oct 2022 17:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YG4VlFLS486HR6XzTWZkeVrEikhzGg3oNMrJdR09xN0=;
        b=SH/m0hye551j67TpeTG6UDh5pXgMwDYYEnADzE2VuZ/b0h5xJTZIFXFQfrUcz+GaBQ
         8IvfIWHd9N4aVrxw/FwvJHFG+ppWqdYUfPE4SsloicHC9tVPMl+9sv3szHZNeWm7ttha
         +JQZ9+vTMCBsM7iSbFcZ6yaX/sQuprgHUqH1aK9+CuP0Qqq9KMT80txUpy4raFdzOBs1
         +lNiIG479aHHd+4OsZH4zeziTA3Rpi43hD0ylG9e/JP2vWkcaw9Pc2FqY/f/TBRtdJMC
         u1rUD2ti+37tzBCErE5ZBF6DydlE2GRp31nLL1kS9vKF5GTW+M1JTyQ0MYftCdHV6EjV
         boQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YG4VlFLS486HR6XzTWZkeVrEikhzGg3oNMrJdR09xN0=;
        b=CBYb1bDwmkjX9Xx8zi6K2XPKx5tWG8jHTVSHHoxAyyZU06Zy5kTGHAuds7urUu9U6T
         0Pe0ib0OsHC2Qka6OvWPDnN+nCbBoTcCcte4JctjMvBFrEKemA8aIpWCERkK+N3ilivh
         V4lArKOS87H9fQHjTjW/8UTo/uOHxieimD4pTGqOnRyZvPd+67X1h8tREwwO19A5hn9i
         VrwpibVeq1CdWE7JUlznXQKxHw0wf0a9EVcJ6+g4MO2ixHBArIsHmIx91Irvrcaeftp4
         DmDVCab/ow4d9zT8R8EOqfe9VI0O9QgJKiuC4xOG4fOv5Uu7VUL1zd61EPxWXCqFKQmd
         RPoQ==
X-Gm-Message-State: ACrzQf3nBxurhuclzweuD16o44lYx11q+aqZSP5EJ7tkMPwAepVXOxM/
        SKM1+Xg+3pYicstEGlh9xId1GKozoYM=
X-Google-Smtp-Source: AMsMyM5ri2aBfQ5w9YqA3ahxTnjdm1oMk3Qr0A+RS8JT6NaMggeExdrUcGVCtoFNOX7TgNWElm4jFLYfsoY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c986:b0:205:f08c:a82b with SMTP id
 w6-20020a17090ac98600b00205f08ca82bmr146218pjt.1.1665014611232; Wed, 05 Oct
 2022 17:03:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:03:14 +0000
In-Reply-To: <20221006000314.73240-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006000314.73240-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006000314.73240-9-seanjc@google.com>
Subject: [PATCH v5 8/8] KVM: x86: Directly query supported PERF_CAPABILITIES
 for WRMSR checks
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

Use kvm_caps.supported_perf_cap directly instead of bouncing through
kvm_get_msr_feature() when checking the incoming value for writes to
PERF_CAPABILITIES.

Note, kvm_get_msr_feature() is guaranteed to succeed when getting
PERF_CAPABILITIES, i.e. dropping that check is a nop.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9443ddb358e6..3afe5f4b1a40 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3568,20 +3568,15 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		vcpu->arch.arch_capabilities = data;
 		break;
-	case MSR_IA32_PERF_CAPABILITIES: {
-		struct kvm_msr_entry msr_ent = {.index = msr, .data = 0};
-
+	case MSR_IA32_PERF_CAPABILITIES:
 		if (!msr_info->host_initiated)
 			return 1;
-		if (kvm_get_msr_feature(&msr_ent))
-			return 1;
-		if (data & ~msr_ent.data)
+		if (data & ~kvm_caps.supported_perf_cap)
 			return 1;
 
 		vcpu->arch.perf_capabilities = data;
 		kvm_pmu_refresh(vcpu);
 		return 0;
-	}
 	case MSR_EFER:
 		return set_efer(vcpu, msr_info);
 	case MSR_K7_HWCR:
-- 
2.38.0.rc1.362.ged0d419d3c-goog

