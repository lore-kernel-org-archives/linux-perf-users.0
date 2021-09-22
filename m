Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72188C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 00:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54DB361278
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 00:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhIVAHV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 20:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhIVAHU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Sep 2021 20:07:20 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0C0C061575
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 17:05:51 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s18-20020a05620a255200b00433885d4fa7so6212884qko.4
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 17:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=WoefsUy8P8uVLjBhkd6fplSxv9zXtwFfZO3aWK09BqE=;
        b=W3dvAswYaFrMhdUxOnj+C5EXMMEyJrI4w2EWKYkJvgEgkHuR8IaKKfSJHg9j0xw5+k
         fgorvfW1/YzGQUtW4RZ95gDG0qA72H/qeIgYOd+4TOG6c+1wocOOu3VRxQzsB6jGSO5g
         yRDdyBni9EhmFEE/PynpUeNnGYgcYXTu6HydYJ60R/86lZ/rosIKMEDAP+lTix9jhUIs
         1g7+eQ1MkKa4HLPulfOq0mS5b56v1Wn9wTgMBlG9vvFK/yuOUIxbO5OMIO050BN1ziI7
         quI8vYbT72gL4MHo6ScRZ81Wr5yMBwO1kb48G3KB1R6pXXjpQyqrpGzih9Su7JxvCNCF
         qqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=WoefsUy8P8uVLjBhkd6fplSxv9zXtwFfZO3aWK09BqE=;
        b=jTbcdvj1hxO/dpU3WWHRldruOgEOAahcMkO3RLdVg3mlslXvIqPmaVb1VCJeXzy+Wo
         cW36/We6Pv99OZOLFzWJjFtr1HtMteFozSmw2HxCdwMvaq5mJcpvUEBxU769uASppv/s
         8TaOjyUxAyEHd85LBM5m3mwHy6XphOXaWB6vqQwjGHDvkwrgZwidIMMN7QQoBes4cnv+
         rm4q9f1UQcHO2SLINdVuichBK8DcJ22pl+w8xiSqhmEs+kxL6HE45lNLPEpd7G1cq5f0
         BYy2J5stz09yzInMv5w9iJWcBhLSn+1O+xkTfolAq/lkpXbzwop2+gpbsZ6kXgIUI+sH
         lLUg==
X-Gm-Message-State: AOAM530Ok9sGPwIvvm+CJQtaAl0BxUS2wzxV1RqnF6nDtO6XKy8huvQi
        Uur7gV2f+i9QH1u4jss561u0cv5bINQ=
X-Google-Smtp-Source: ABdhPJydgoIIy+PWW+KTdPOq8w+CNl9+TVcl5SdFV/4H0FYG9MktEVuetKxR7qEx7VklEO7jLEzl555CBZg=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:b022:92d6:d37b:686c])
 (user=seanjc job=sendgmr) by 2002:a25:2cd6:: with SMTP id s205mr42869270ybs.445.1632269150043;
 Tue, 21 Sep 2021 17:05:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Sep 2021 17:05:20 -0700
In-Reply-To: <20210922000533.713300-1-seanjc@google.com>
Message-Id: <20210922000533.713300-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210922000533.713300-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 03/16] KVM: x86: Register Processor Trace interrupt hook
 iff PT enabled in guest
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Override the Processor Trace (PT) interrupt handler for guest mode if and
only if PT is configured for host+guest mode, i.e. is being used
independently by both host and guest.  If PT is configured for system
mode, the host fully controls PT and must handle all events.

Fixes: 8479e04e7d6b ("KVM: x86: Inject PMI for KVM guest")
Cc: stable@vger.kernel.org
Cc: Like Xu <like.xu.linux@gmail.com>
Reported-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reported-by: Artem Kashkanov <artem.kashkanov@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/vmx.c          | 1 +
 arch/x86/kvm/x86.c              | 5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 09b256db394a..1ea4943a73d7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1494,6 +1494,7 @@ struct kvm_x86_init_ops {
 	int (*disabled_by_bios)(void);
 	int (*check_processor_compatibility)(void);
 	int (*hardware_setup)(void);
+	bool (*intel_pt_intr_in_guest)(void);
 
 	struct kvm_x86_ops *runtime_ops;
 };
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fada1055f325..f19d72136f77 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7896,6 +7896,7 @@ static struct kvm_x86_init_ops vmx_init_ops __initdata = {
 	.disabled_by_bios = vmx_disabled_by_bios,
 	.check_processor_compatibility = vmx_check_processor_compat,
 	.hardware_setup = hardware_setup,
+	.intel_pt_intr_in_guest = vmx_pt_mode_is_host_guest,
 
 	.runtime_ops = &vmx_x86_ops,
 };
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fb6015f97f9e..ffc6c2d73508 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8305,7 +8305,7 @@ static struct perf_guest_info_callbacks kvm_guest_cbs = {
 	.is_in_guest		= kvm_is_in_guest,
 	.is_user_mode		= kvm_is_user_mode,
 	.get_guest_ip		= kvm_get_guest_ip,
-	.handle_intel_pt_intr	= kvm_handle_intel_pt_intr,
+	.handle_intel_pt_intr	= NULL,
 };
 
 #ifdef CONFIG_X86_64
@@ -11061,6 +11061,8 @@ int kvm_arch_hardware_setup(void *opaque)
 	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
 	kvm_ops_static_call_update();
 
+	if (ops->intel_pt_intr_in_guest && ops->intel_pt_intr_in_guest())
+		kvm_guest_cbs.handle_intel_pt_intr = kvm_handle_intel_pt_intr;
 	perf_register_guest_info_callbacks(&kvm_guest_cbs);
 
 	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
@@ -11091,6 +11093,7 @@ int kvm_arch_hardware_setup(void *opaque)
 void kvm_arch_hardware_unsetup(void)
 {
 	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
+	kvm_guest_cbs.handle_intel_pt_intr = NULL;
 
 	static_call(kvm_x86_hardware_unsetup)();
 }
-- 
2.33.0.464.g1972c5931b-goog

