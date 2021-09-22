Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C81AC4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 00:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1895861166
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 00:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhIVAJE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 20:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhIVAIW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Sep 2021 20:08:22 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4088BC0617AA
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 17:06:15 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id h18-20020a0cffd2000000b0037e78fb2552so7642082qvv.12
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 17:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=hykBvrf8DnzH3Q8YHjL/Y0GXRoABX5ADBK+0/12MWfw=;
        b=jKopPzwiybt9fB96grPLhcmov4eHABK3Rn1V3+jC89gDcrIoprd65bnGYY9DP7ju4b
         85kkPs7ZPkL8WlWgMXplyIY3a/z2qIzxH+/FI3XjcdmrliPkx8nPrp2a5kX5Pjc1ywob
         ByTND1+iT+q5EbaKv8lVZV94ko5nNdJrrzXW+BlrNXXtl2FDDO+EPFHPKuUM6DjPG5xB
         A3Kj4DmZiicnBCVFqv70LMvPNdNZybwucvdKO2/8ODrWoNpkysFbo74lUlyrUvFEKlBi
         o1a2jdJRabm/xdF8RFOfzaw+a+ydqqTbWa982xz/HRYZHvnoWhQfVxgfpJMjXOW1pVY7
         0TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=hykBvrf8DnzH3Q8YHjL/Y0GXRoABX5ADBK+0/12MWfw=;
        b=Epb6nG3N7o6mBrRPVwadLtvf/AEsUMF4CtY9/nbY1Ap62GbdyReDoAEuA4II9P/3Di
         pmPF/iMI22+aYgYw+pcoxw6WbFA/uvOtLK7wgmc0C4+l4H0CJdATx1nlMTKjgBwJAScz
         gIkRCemwraSFtjXZUE/Z2NFjMydupiIRrrxqAW9yc50jZsKhwkU0n8usNPKDSM1/PQXR
         RBOkran8ceEyCApt8ftxyEc+uIGWYcnVUpqCRUPSubUguJ4sanedY4aIjEUtmklR1aYZ
         7Roi5v7myRzXPuR9VSDvzQUxAnyM7RvsSJTV7K5vWaNVE8mxBktzp6X2AmyQuCHBWvY2
         q5eA==
X-Gm-Message-State: AOAM532Bny5s6HQuqjtKFQfu8DgDG7QSJkm1rzLlbkJQu/TU/fVdDEiA
        GRcKI3boQvsz+YBtpA4+gwLsyGmAMmk=
X-Google-Smtp-Source: ABdhPJy5GySvAYc4kjGUgxPeiS0d5MaL33kPbz4EVAybMqnGUcP/K+XpH6FqRymRPMD4ga0cIEmdn6OzCzE=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:b022:92d6:d37b:686c])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1143:: with SMTP id
 p3mr39279294ybu.420.1632269174363; Tue, 21 Sep 2021 17:06:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Sep 2021 17:05:31 -0700
In-Reply-To: <20210922000533.713300-1-seanjc@google.com>
Message-Id: <20210922000533.713300-15-seanjc@google.com>
Mime-Version: 1.0
References: <20210922000533.713300-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 14/16] KVM: arm64: Convert to the generic perf callbacks
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

Drop arm64's version of the callbacks in favor of the callbacks provided
by generic KVM, which are semantically identical.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/perf.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
index 3e99ac4ab2d6..0b902e0d5b5d 100644
--- a/arch/arm64/kvm/perf.c
+++ b/arch/arm64/kvm/perf.c
@@ -13,45 +13,15 @@
 
 DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
 
-static unsigned int kvm_guest_state(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-	unsigned int state;
-
-	if (!vcpu)
-		return 0;
-
-	state = PERF_GUEST_ACTIVE;
-	if (!vcpu_mode_priv(vcpu))
-		state |= PERF_GUEST_USER;
-
-	return state;
-}
-
-static unsigned long kvm_get_guest_ip(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-
-	if (WARN_ON_ONCE(!vcpu))
-		return 0;
-
-	return *vcpu_pc(vcpu);
-}
-
-static struct perf_guest_info_callbacks kvm_guest_cbs = {
-	.state		= kvm_guest_state,
-	.get_ip		= kvm_get_guest_ip,
-};
-
 void kvm_perf_init(void)
 {
 	if (kvm_pmu_probe_pmuver() != 0xf && !is_protected_kvm_enabled())
 		static_branch_enable(&kvm_arm_pmu_available);
 
-	perf_register_guest_info_callbacks(&kvm_guest_cbs);
+	kvm_register_perf_callbacks(NULL);
 }
 
 void kvm_perf_teardown(void)
 {
-	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
+	kvm_unregister_perf_callbacks();
 }
-- 
2.33.0.464.g1972c5931b-goog

