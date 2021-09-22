Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA4FC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 00:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8EC460EFF
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 00:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhIVAIF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 20:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhIVAHf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Sep 2021 20:07:35 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5DBC0613EF
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 17:06:04 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id az30-20020a05620a171e00b00432eb71d467so5399484qkb.18
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 17:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=lHJOof24VqkiYhFcIRNTWKzKjki/p0Ze5CnPJ3pN3mI=;
        b=NAVCfHnfawHtrL2iCYw8HgTBlFYN7yri+HxZMhsBlfVlSZIQEmh1AdRNXtYQ9FoGZS
         jRIrxb0XEtBmkG58IBs5w+mP9+jXc2C3HLEK37fIIPlowXZ4g2A0PlKvfuqb2ADJxmfT
         gWcyAqrNLMzTqwoc6qruf1z2Si6VfevO8CbFRhssYP8/HJFWfja6Iw9rCUyZd9oSQg+F
         9XbckVVG4ADd3HGel6flTZI1kY7ZlS2ePo2n4ME18ZOc0prkN5QAWF7paKBJF7TwSTpL
         +vKX7u3jx0Z8b6TwojXazIBTpdi6hKJXbUEPbqRRJ9J3bLcqDW1CgpBqnGXO30fQFOsf
         UrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=lHJOof24VqkiYhFcIRNTWKzKjki/p0Ze5CnPJ3pN3mI=;
        b=akmsYvBzxBPsG2XnoBVAgdQxvk4DLjsbzOWiFwmfw8+2SgPD/VQ4E7hn4po3YUNzlW
         436hP8g53krrLTs3uqQJKFJplKotbZmPCU1C4+plLZIveDbNlQk4//IBNtQOExSry2gq
         U2Y6bKROHv1/UgkFxPdUd0EP5fF3uRAVuPw6HZkQO9zqG5qcl6M2N2hHI1lMdsonmGa+
         CmDeCr0EHm4uMfiey/+5WmwUrEj1HcQKxge9dKJJox5CSmaM10Ejfe58CZHGodg0EICe
         LWg68k08UlG9kA5f64eLeKbd3onUT16v7B02xOlC3+gQbmRZdK8g59seGIMHJ7VTPhsy
         Tu+A==
X-Gm-Message-State: AOAM533Cc3bIhmcdwsawTUL3cQdo7Pku15jUXSv35kaUCO16mPChbk2f
        mUmZZAjPYVmJ18QsRm+6dZfhKV5FK88=
X-Google-Smtp-Source: ABdhPJxiVysqs+seAL8tPuZXn+zjjV1XTgLeF1Hv4M206n5zRNvGf9PMhGCvhpJwuIHM26SWahcPIvZUjtg=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:b022:92d6:d37b:686c])
 (user=seanjc job=sendgmr) by 2002:a05:6214:732:: with SMTP id
 c18mr33750621qvz.9.1632269163200; Tue, 21 Sep 2021 17:06:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Sep 2021 17:05:26 -0700
In-Reply-To: <20210922000533.713300-1-seanjc@google.com>
Message-Id: <20210922000533.713300-10-seanjc@google.com>
Mime-Version: 1.0
References: <20210922000533.713300-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 09/16] perf/core: Use static_call to optimize perf_guest_info_callbacks
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

Use static_call to optimize perf's guest callbacks on arm64 and x86,
which are now the only architectures that define the callbacks.  Use
DEFINE_STATIC_CALL_RET0 as the default/NULL for all guest callbacks, as
the callback semantics are that a return value '0' means "not in guest".

static_call obviously avoids the overhead of CONFIG_RETPOLINE=y, but is
also advantageous versus other solutions, e.g. per-cpu callbacks, in that
a per-cpu memory load is not needed to detect the !guest case.

Based on code from Peter and Like.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/perf_event.h | 28 ++++++----------------------
 kernel/events/core.c       | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index eefa197d5354..d582dfeb4e20 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1240,37 +1240,21 @@ extern void perf_event_bpf_event(struct bpf_prog *prog,
 
 #ifdef CONFIG_GUEST_PERF_EVENTS
 extern struct perf_guest_info_callbacks *perf_guest_cbs;
-static inline struct perf_guest_info_callbacks *perf_get_guest_cbs(void)
-{
-	/* Reg/unreg perf_guest_cbs waits for readers via synchronize_rcu(). */
-	lockdep_assert_preemption_disabled();
+DECLARE_STATIC_CALL(__perf_guest_state, *perf_guest_cbs->state);
+DECLARE_STATIC_CALL(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
+DECLARE_STATIC_CALL(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->handle_intel_pt_intr);
 
-	/* Prevent reloading between a !NULL check and dereferences. */
-	return READ_ONCE(perf_guest_cbs);
-}
 static inline unsigned int perf_guest_state(void)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
-
-	return guest_cbs ? guest_cbs->state() : 0;
+	return static_call(__perf_guest_state)();
 }
 static inline unsigned long perf_guest_get_ip(void)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
-
-	/*
-	 * Arbitrarily return '0' in the unlikely scenario that the callbacks
-	 * are unregistered between checking guest state and getting the IP.
-	 */
-	return guest_cbs ? guest_cbs->get_ip() : 0;
+	return static_call(__perf_guest_get_ip)();
 }
 static inline unsigned int perf_guest_handle_intel_pt_intr(void)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
-
-	if (guest_cbs && guest_cbs->handle_intel_pt_intr)
-		return guest_cbs->handle_intel_pt_intr();
-	return 0;
+	return static_call(__perf_guest_handle_intel_pt_intr)();
 }
 extern void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
 extern void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c6ec05809f54..79c8ee1778a4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6485,12 +6485,23 @@ static void perf_pending_event(struct irq_work *entry)
 #ifdef CONFIG_GUEST_PERF_EVENTS
 struct perf_guest_info_callbacks *perf_guest_cbs;
 
+DEFINE_STATIC_CALL_RET0(__perf_guest_state, *perf_guest_cbs->state);
+DEFINE_STATIC_CALL_RET0(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
+DEFINE_STATIC_CALL_RET0(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->handle_intel_pt_intr);
+
 void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 {
 	if (WARN_ON_ONCE(perf_guest_cbs))
 		return;
 
 	WRITE_ONCE(perf_guest_cbs, cbs);
+	static_call_update(__perf_guest_state, cbs->state);
+	static_call_update(__perf_guest_get_ip, cbs->get_ip);
+
+	/* Implementing ->handle_intel_pt_intr is optional. */
+	if (cbs->handle_intel_pt_intr)
+		static_call_update(__perf_guest_handle_intel_pt_intr,
+				   cbs->handle_intel_pt_intr);
 }
 EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
 
@@ -6500,6 +6511,10 @@ void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 		return;
 
 	WRITE_ONCE(perf_guest_cbs, NULL);
+	static_call_update(__perf_guest_state, (void *)&__static_call_return0);
+	static_call_update(__perf_guest_get_ip, (void *)&__static_call_return0);
+	static_call_update(__perf_guest_handle_intel_pt_intr,
+			   (void *)&__static_call_return0);
 	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
-- 
2.33.0.464.g1972c5931b-goog

