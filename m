Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46505C19F2C
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Aug 2022 19:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiHCT1H (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Aug 2022 15:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiHCT1F (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Aug 2022 15:27:05 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1895564E5
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Aug 2022 12:27:04 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id f128-20020a636a86000000b0041a4b07b039so7105163pgc.5
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Aug 2022 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:reply-to:from:to:cc;
        bh=nm7CFbOdnKtZDNkgkKBzXQSPp+dIl3jdjLzC+jO16zk=;
        b=UJ2itWk2ezkIYRhnzAmzoIQO8u9ey77vKkdIhOd9vs8Zeh71OH2Ir0xFAgTl5ekOdQ
         zg4kSUzcMulV8zPGAmflfEkY8hdvqVxKfwgo3tN6kvzJ7cctBjo+NdAb+qPg81Z31eH1
         2k8GX3GntwsZ70h5FT00xRMSJlk7Ms902eCR6sQsk14inYSRrJn4PoHnxsJ6cCx+xWx6
         A8tH6ERH0TGgjMT6bjFklvTFBR5/PHNbdqm1O3lq8/lEI/G+5r7PEnb2vhv19udY9ok7
         V9hse3EWlAzb3IF2d7b2PyMdFA8w2Bj/vQj3EZzWcyi0aZAb+hIdq1wBC6EoFxSHijIr
         b9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=nm7CFbOdnKtZDNkgkKBzXQSPp+dIl3jdjLzC+jO16zk=;
        b=Q6fiEQwSF/CLbrfy2CdAcKMdSFhGSWHdLOgtdTZNBIMnWAlzjZ9cmVw3vj9b8kVaTe
         CUwRKB8PwQx+d/oJRhmMT1FHWMNLpZPRSbQbWwD0dqjNTjsJe6BQ5WY/RQx8gcR8Awjz
         ekN5O27wyT6QMg+ssN7Njh5GM+jvnAEklbuwHxGNXLUoGtCfKd6LhQMUt8Z7e0agJ6eN
         bzGYu+d9KsdWmOt90pXeapiC3gO5WfarW5O5/zRIAXeXxQgWcZXIp99d9NWwcMq2VGqV
         YBC0VCVXyjmqYXNh4YSkxmpvtNTzxeVJug7MLVWNuY6vMqyNyzbnhux0k8r8eJacnyQm
         ZOYQ==
X-Gm-Message-State: AJIora9b735iynh+NOYQVYgGI2dPy6E6zMZzi/DUTUqPN4bxW2qyAwXh
        Hjw5VayxO/SUAQMt0qbxJR4BFyJGy3Q=
X-Google-Smtp-Source: AGRyM1smK3BViI7TxhEbyAjRfforzWrdjCXIGbu9LuouDuELMs/W7f0KHUYaF4H+R7SWS+UD94l95eGoDe8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:e258:0:b0:41a:d92b:64f9 with SMTP id
 y24-20020a63e258000000b0041ad92b64f9mr21846257pgj.148.1659554824574; Wed, 03
 Aug 2022 12:27:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  3 Aug 2022 19:26:52 +0000
In-Reply-To: <20220803192658.860033-1-seanjc@google.com>
Message-Id: <20220803192658.860033-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220803192658.860033-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 1/7] KVM: x86: Refresh PMU after writes to MSR_IA32_PERF_CAPABILITIES
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

Refresh the PMU if userspace modifies MSR_IA32_PERF_CAPABILITIES.  KVM
consumes the vCPU's PERF_CAPABILITIES when enumerating PEBS support, but
relies on CPUID updates to refresh the PMU.  I.e. KVM will do the wrong
thing if userspace stuffs PERF_CAPABILITIES _after_ setting guest CPUID.

Note, KVM may do the "wrong" thing if userspace changes PERF_CAPABILITIES
after running the vCPU, i.e. after KVM_RUN.  Similar to disallowing CPUID
changes after KVM_RUN, KVM should also disallow changing feature MSRs
after KVM_RUN to prevent unexpected behavior.  That problem will be
addressed separately at it affects MSRs other than PERF_CAPABILITES.

Opportunistically fix a curly-brace indentation.

Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Cc: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 33560bfa0cac..dc19298e7150 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3546,9 +3546,9 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 
 		vcpu->arch.perf_capabilities = data;
-
+		kvm_pmu_refresh(vcpu);
 		return 0;
-		}
+	}
 	case MSR_EFER:
 		return set_efer(vcpu, msr_info);
 	case MSR_K7_HWCR:
-- 
2.37.1.559.g78731f0fdb-goog

