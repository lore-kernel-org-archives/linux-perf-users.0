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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5336EC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 19:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A898613D3
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 19:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhHWTiY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 15:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhHWTiN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Aug 2021 15:38:13 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B18DC061764
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Aug 2021 12:37:30 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id dv7-20020ad44ee7000000b0036fa79fd337so2813039qvb.6
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Aug 2021 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=rmYIpDdU3QK7p6S3HsrzN12lySY7VGfi8e7ewdZ2wvA=;
        b=wJL7Xz9VU1rOK6hlGPydrdtHKr/VbFayeoZuxgI/pClqesV+XUtE4QUu6XbrrGKUZV
         ITPHTHT20kry0avyUfIqLBA5JQIDxHabRE0taMXo5NdR5kv+wryPWEN84fvWo+bgfMCk
         gsHovFqh4jAGff4gsw+zhuTuVahcourpbCDWAlPWtNjHNgrYonayLLqtPlPy7tWmSIYj
         SV2v2u/HMZREXghd0Hpq/8lks5BDnj089jgrDv/KYMCPEauxiUC5forh8V9GGgO1yjGr
         oWDhGoeu9Dc2hqnIrJJb0hakosarXIXsCuDxJGiDyZkJO4UhCloFjVRUdM2sYTUdJq/C
         CGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=rmYIpDdU3QK7p6S3HsrzN12lySY7VGfi8e7ewdZ2wvA=;
        b=F37SOl+DOJORTt1SGIA9iN2YxWlLaAB3sULQXVzTlEgBD5m+nu1AEqyUSfWlDf54HL
         ZRIlbNBMsKO6MJFCC+0h3FbW8SPKWs4i9t7AQG/EbnnOfqZjVZshb8GK8svxpG8ON5W4
         iDFHp9pLPx1xNDE8WlNzbgu8vSFJoqk/UOK4HToymGhgkO5aexprLF8MmUX34P8tQIPp
         unpJ2TL5K/VZ89pYyn+zQN9LvMLN02UT93zc8nV1RFlsXvfxkf/9YYWEpFjms0x0f+ko
         3LOKl+fco2K8Ge+7OJh6lZd2Nf2OCTa28jAHIY7wiCiTBfcbnlY+QkuH1IrkhTztPRBt
         T9zg==
X-Gm-Message-State: AOAM532tDQcr3vPJ9/qKzpNrpDXoTQYSnWoakN5m+zQG6tiNwcTDl1XT
        UGASJpaqfdRWOYTYPg2JY/SfISaKL/M=
X-Google-Smtp-Source: ABdhPJxMughRTeNGSfkS7sQ5RCx/BDaAhNO0JOHhWF1MAuK3EB9WU/08l/gP2MCeN22B+W0LyWkDmS1X6TU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:109c:7eb8:d5ed:2e59])
 (user=seanjc job=sendgmr) by 2002:a05:6214:312:: with SMTP id
 i18mr2221144qvu.48.1629747449581; Mon, 23 Aug 2021 12:37:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 23 Aug 2021 12:37:09 -0700
In-Reply-To: <20210823193709.55886-1-seanjc@google.com>
Message-Id: <20210823193709.55886-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210823193709.55886-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH 3/3] perf/x86/intel: Fold current_vcpu check into KVM's PT
 intr handler
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Artem Kashkanov <artem.kashkanov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Move the check for a non-NULL current_vcpu into KVM's PT intr handler
instead of relying on the caller to perform the check.  In addition to
ensuring KVM's handler won't dereference a NULL pointer (and making it
obvious that it can't), this avoids a reptoline when KVM is configured to
run PT in "system mode", in which case handle_intel_pt_intr will be NULL.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 7 +++----
 arch/x86/kvm/pmu.h           | 2 +-
 arch/x86/kvm/x86.c           | 6 +++++-
 include/linux/perf_event.h   | 2 +-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fca7a6e2242f..060f1f1ebe15 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2852,10 +2852,9 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 */
 	if (__test_and_clear_bit(GLOBAL_STATUS_TRACE_TOPAPMI_BIT, (unsigned long *)&status)) {
 		handled++;
-		if (unlikely(perf_guest_cbs && perf_guest_cbs->is_in_guest() &&
-			perf_guest_cbs->handle_intel_pt_intr))
-			perf_guest_cbs->handle_intel_pt_intr();
-		else
+		if (likely(!perf_guest_cbs ||
+			   !perf_guest_cbs->handle_intel_pt_intr ||
+			   perf_guest_cbs->handle_intel_pt_intr()))
 			intel_pt_interrupt();
 	}
 
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index b06dbbd7eeeb..4e8a38eca72b 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -41,7 +41,7 @@ struct kvm_pmu_ops {
 	void (*reset)(struct kvm_vcpu *vcpu);
 	void (*deliver_pmi)(struct kvm_vcpu *vcpu);
 	void (*cleanup)(struct kvm_vcpu *vcpu);
-	void (*handle_intel_pt_intr)(void);
+	int (*handle_intel_pt_intr)(void);
 };
 
 static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b5ade47dad9c..3f289192f25f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8292,13 +8292,17 @@ static unsigned long kvm_get_guest_ip(void)
 	return ip;
 }
 
-static void kvm_handle_intel_pt_intr(void)
+static int kvm_handle_intel_pt_intr(void)
 {
 	struct kvm_vcpu *vcpu = __this_cpu_read(current_vcpu);
 
+	if (!vcpu)
+		return -ENXIO;
+
 	kvm_make_request(KVM_REQ_PMI, vcpu);
 	__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
 			(unsigned long *)&vcpu->arch.pmu.global_status);
+	return 0;
 }
 
 static struct perf_guest_info_callbacks kvm_guest_cbs = {
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2d510ad750ed..f812c2570285 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -30,7 +30,7 @@ struct perf_guest_info_callbacks {
 	int				(*is_in_guest)(void);
 	int				(*is_user_mode)(void);
 	unsigned long			(*get_guest_ip)(void);
-	void				(*handle_intel_pt_intr)(void);
+	int				(*handle_intel_pt_intr)(void);
 };
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-- 
2.33.0.rc2.250.ged5fa647cd-goog

