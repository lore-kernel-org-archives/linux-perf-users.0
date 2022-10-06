Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E238C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 00:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJFAEP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 20:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJFADl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Oct 2022 20:03:41 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95785868B3
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Oct 2022 17:03:29 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id w15-20020a17090a8a0f00b0020afece09efso670917pjn.5
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Oct 2022 17:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OOUVOx92e9TPbHiMSq0GFIi0JU6k8DvZUcmie6j5t9E=;
        b=eL/uz7eLgvELZ04pGzDuj2OMzJCUZuUVaPwvFBeZMIboI6rKy6nEP5EnUouwL6jZYy
         5XvfIKLr0XgaExVQkeaB1uRq767AWbDrqdMBA202GJFPWdMXZnKQ3rGL1KOo2A3yX/kU
         tl4mpDFSjPqbhAp7QT/Vi+NvBjxJ+JRJNnUh4anob9bsVrvfjb8wtS4gEb5UWynbtFyR
         8MTtlSKCnOJkDSbnJQMK3jNGFZGamvaNruD34ZVaIEhx90ZbdydGzWl4n4yRP34kTi81
         e+V5gLSdjvi7oSbqf8jSJP6P2oDueisaiM4Za7/qduvhGnrAm+bc1ebwq2/SyfGgdHHM
         itzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOUVOx92e9TPbHiMSq0GFIi0JU6k8DvZUcmie6j5t9E=;
        b=FfmON8NO5BWcwf7TIsZBOezUDyHc5PBttAKM5Xqn11P8/XgjKo0+1AAnxXT8qhxhIm
         6jzOE1PdIZUpIz8XKOapVWrs/QziSwmcDHJKLfAog0+FtquNNHV7gVtKtx/h4rBFIt/n
         I/tyep9Cg0gcb8lWT7FfuZp0kij4uEgu4b06TLzwM5tkiWg7CTsqc2le8B/uCcHYlDTe
         zSChH7rnYTd/FPteEAwvIlPwwhDRNnS4RltE+sbis9UlB29EFNEEGd0tr3N4rKP6oqXR
         rPbIc1KAaplx+MbggMtaE2h/PfRnaDXUHBBs6LhbhhI5IUP9DHzhNnFPoxDssJu71RuL
         a08w==
X-Gm-Message-State: ACrzQf3ShFW6dz01I+1Bbj5lTfrIt+oe+9IDvGkF8jesWNqcQynDQTae
        IiJwbCXY2aOgTaZYWGrrG/XsI46pG78=
X-Google-Smtp-Source: AMsMyM6ihFR3Fgp9UWKZShMmVif5xSTGipKmZyOjO6hfiLOnqQy5RAaUef7tz5vYtJEmsELaX8tp+hDd1Wc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:7c4a:b0:20a:b201:461a with SMTP id
 e10-20020a17090a7c4a00b0020ab201461amr2195880pjl.181.1665014608006; Wed, 05
 Oct 2022 17:03:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:03:12 +0000
In-Reply-To: <20221006000314.73240-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006000314.73240-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006000314.73240-7-seanjc@google.com>
Subject: [PATCH v5 6/8] KVM: x86: Init vcpu->arch.perf_capabilities in common
 x86 code
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

Initialize vcpu->arch.perf_capabilities in x86's kvm_arch_vcpu_create()
instead of deferring initialization to vendor code.  For better or worse,
common x86 handles reads and writes to the MSR, and so common x86 should
also handle initializing the MSR.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 1 -
 arch/x86/kvm/x86.c           | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 24f4c22691f8..49343ee48062 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -631,7 +631,6 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 		pmu->fixed_counters[i].current_config = 0;
 	}
 
-	vcpu->arch.perf_capabilities = kvm_caps.supported_perf_cap;
 	lbr_desc->records.nr = 0;
 	lbr_desc->event = NULL;
 	lbr_desc->msr_passthrough = false;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4bd5f8a751de..b6a973d53f93 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11821,6 +11821,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.pat = MSR_IA32_CR_PAT_DEFAULT;
 
 	kvm_async_pf_hash_reset(vcpu);
+
+	vcpu->arch.perf_capabilities = kvm_caps.supported_perf_cap;
 	kvm_pmu_init(vcpu);
 
 	vcpu->arch.pending_external_vector = -1;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

