Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D876C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 00:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJFAEe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 20:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJFAEB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Oct 2022 20:04:01 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7055482624
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Oct 2022 17:03:31 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id m10-20020a170902db0a00b001789bd49db9so97801plx.23
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Oct 2022 17:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cEkG9GEBTiUE8th5TFZ42NZiqyxd5/5OjQ/JbzJymEQ=;
        b=HZpuKtQwKzlujbVYW3M11GQu0M8KWSz0k/1l9wTjCp+9BEGr2WT/wWmHO+zcKJ4mkS
         p6vnMq3+ZeY75KvwgsBZr/0R8nJTVeMbbU0rDuIYoHWnHllB83NE0YS/GXitghHa+995
         nER/VuLKCZKssKvFOKrMqnVe+wSTNJ7fbX5i0IDdDmKYZlm1x04g5eBH5aD7nStplxL4
         HMY6/ZNWZpqTopZXWJaqOl90rnZ05if94Lyrlbrcem5/sovXyehgVbIf8tDITvxTe3kT
         1aoCB0ZiaC37HHPRiDWbSejAwDHs0/cDAeh+dJkACaBDLcqJGCta2y9GsYXKAvRIgl0o
         U/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEkG9GEBTiUE8th5TFZ42NZiqyxd5/5OjQ/JbzJymEQ=;
        b=lazC4BhJbks8WoTI4QAmfMjx9i6yt2OArIsdSOHGcOQ7amnmArZpqzc0LTKsaam2qL
         XYy069gI3eQJP2wyyl8XSeelHsEzB8+55Wocj/UW6Ed2zypbBPcTyuUYj/llrVMq1xz8
         yWbJgvaj08uTrEh34VsbPebXCkq7XWlh5m9JPbC3XWhM9zhSB4lvQVs8CEJTc/p2tHLn
         4XkM5FL7pWAofTyM04bdu8sxvA4eko/1Vzz5ylEPWX3O+Pa9+Vy+xtJ4sktz8d1s5P+o
         shZUUJF2GvMiDOlxOBWSU5v197LqSV7kP9e4R+7mToaq6EZTanSwDEvocw1mir69L66/
         gAww==
X-Gm-Message-State: ACrzQf2o4YWm3y1HXPBaeLQibqQn+L3B4+D9uJIhKpbW+fUlaeclpZw9
        JKOSvGmmpRxQr3ntlIgMxAJvyXzSX1Y=
X-Google-Smtp-Source: AMsMyM4vYKF91WDVjIeLWeM1NERAi/CGUxBO8aM/E7dVqea8tHTIQPPArdz7NyDaAfOAviH4bem/pSr9+mU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f791:b0:17c:c1dd:a3b5 with SMTP id
 q17-20020a170902f79100b0017cc1dda3b5mr1821332pln.141.1665014609775; Wed, 05
 Oct 2022 17:03:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:03:13 +0000
In-Reply-To: <20221006000314.73240-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006000314.73240-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006000314.73240-8-seanjc@google.com>
Subject: [PATCH v5 7/8] KVM: x86: Handle PERF_CAPABILITIES in common x86's kvm_get_msr_feature()
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

Handle PERF_CAPABILITIES directly in kvm_get_msr_feature() now that the
supported value is available in kvm_caps.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 3 ---
 arch/x86/kvm/vmx/vmx.c | 3 ---
 arch/x86/kvm/x86.c     | 3 +++
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6b680b249975..0d8935e7a943 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2714,9 +2714,6 @@ static int svm_get_msr_feature(struct kvm_msr_entry *msr)
 		if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
 			msr->data |= MSR_F10H_DECFG_LFENCE_SERIALIZE;
 		break;
-	case MSR_IA32_PERF_CAPABILITIES:
-		msr->data = kvm_caps.supported_perf_cap;
-		return 0;
 	default:
 		return KVM_MSR_RET_INVALID;
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 850ff6e683d1..6ff832178e48 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1849,9 +1849,6 @@ static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 		if (!nested)
 			return 1;
 		return vmx_get_vmx_msr(&vmcs_config.nested, msr->index, &msr->data);
-	case MSR_IA32_PERF_CAPABILITIES:
-		msr->data = kvm_caps.supported_perf_cap;
-		return 0;
 	default:
 		return KVM_MSR_RET_INVALID;
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b6a973d53f93..9443ddb358e6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1653,6 +1653,9 @@ static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 	case MSR_IA32_ARCH_CAPABILITIES:
 		msr->data = kvm_get_arch_capabilities();
 		break;
+	case MSR_IA32_PERF_CAPABILITIES:
+		msr->data = kvm_caps.supported_perf_cap;
+		break;
 	case MSR_IA32_UCODE_REV:
 		rdmsrl_safe(msr->index, &msr->data);
 		break;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

