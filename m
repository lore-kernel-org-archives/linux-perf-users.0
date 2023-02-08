Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F229C05027
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Feb 2023 20:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjBHUmk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Feb 2023 15:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjBHUmj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Feb 2023 15:42:39 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643323401B
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Feb 2023 12:42:38 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id pv1-20020a17090b3c8100b0022c1ab71110so1812737pjb.7
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Feb 2023 12:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zVWDTl0p8IeLDiHH3ugnUoxZ7xfcxn6x+ZxiZsMm1KE=;
        b=WPwZTTT6W7rLlFyK6g3SZsOgRN4KF7X/gJI2mYv+nPqGya9GQYbpivlSLH7pxH9ReX
         Ycdy8GW7qw+hGfGzLdCkUTd5iDSAauj/h6Ta0mQ+tV54mqO68SlssteuZua90Gqp8+iR
         1Ezxx37QtpW0xG/k04jRWUcTDKBevogtVIw3hP6+4gpF/SE7hg7D5qWj+sMmB/YrhzrK
         HPK/ZXkpi1YeeeU1K1SP+96nsuGS+m/RLcT629dZDIFpVqGIWFK3/0hEEUd0eeVgJeV0
         9ZWh2ox8GKZgGtzKvqPkjzx6S+JtjJl+pmb6UWELdgL0+6zcJQx6M3FuA0dmRmJKUNtq
         tT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVWDTl0p8IeLDiHH3ugnUoxZ7xfcxn6x+ZxiZsMm1KE=;
        b=twn7RNIi7a17CAHZFlzwQzeDqP+XQJPEWVP1dy3SYjvR5WTqeQ/VapA/3svu6Bg/Yl
         PW8mPrIiIhy2nlBAF09vwXBfinLileAdJrP2wzT8gyYjEr0mtamM+yQz5Klyqgz2oNF/
         WeMHIcJB7rlNtZGrssjsPiz8F7dXfwCHdm5OKZbIzJv8Zmt5/jgL0ciA7Oddo2QE1Y8Q
         NaDKmdQq1TZ6LtX+/9XeFsVX4XbeKptp5xd13+JsyeNajgUvRDLgJUUlrAQ/M3m0f8C9
         A9FiId5i1e/YGN4oRhDnEVeGB87dgFX81EbTlpck28tWLvwALeTr/etktUbBNgNR9qSH
         v9rg==
X-Gm-Message-State: AO0yUKVL2AJ6Tl4SKd/1ivHuJa2KUw/yJuhGZRMKxvN2TQ5C7Jpq+NKW
        YbzCUAHcXRHD6D4ZrNY94fJ7wwzf+/Y=
X-Google-Smtp-Source: AK7set/9M5lzkaYsVmbNoMuDWODbJ+CjIGMp3PmwMVqe+KA05wUxJoqkdvyG+iyqxk3/KTf1kMRS0WpkVGc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:701b:0:b0:4fb:3ee3:3a6a with SMTP id
 l27-20020a63701b000000b004fb3ee33a6amr384194pgc.125.1675888957652; Wed, 08
 Feb 2023 12:42:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  8 Feb 2023 20:42:30 +0000
In-Reply-To: <20230208204230.1360502-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230208204230.1360502-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230208204230.1360502-3-seanjc@google.com>
Subject: [PATCH v2 2/2] perf/x86: Refuse to export capabilities for hybrid PMUs
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
        kvm@vger.kernel.org, Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Now that KVM disables vPMU support on hybrid CPUs, WARN and return zeros
if perf_get_x86_pmu_capability() is invoked on a hybrid CPU.  The helper
doesn't provide an accurate accounting of the PMU capabilities for hybrid
CPUs and needs to be enhanced if KVM, or anything else outside of perf,
wants to act on the PMU capabilities.

Cc: stable@vger.kernel.org
Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/all/20220818181530.2355034-1-kan.liang@linux.intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 85a63a41c471..d096b04bf80e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2974,17 +2974,19 @@ unsigned long perf_misc_flags(struct pt_regs *regs)
 
 void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 {
-	if (!x86_pmu_initialized()) {
+	/* This API doesn't currently support enumerating hybrid PMUs. */
+	if (WARN_ON_ONCE(cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) ||
+	    !x86_pmu_initialized()) {
 		memset(cap, 0, sizeof(*cap));
 		return;
 	}
 
+	/*
+	 * Note, hybrid CPU models get tracked as having hybrid PMUs even when
+	 * all E-cores are disabled via BIOS.  When E-cores are disabled, the
+	 * base PMU holds the correct number of counters for P-cores.
+	 */
 	cap->version		= x86_pmu.version;
-	/*
-	 * KVM doesn't support the hybrid PMU yet.
-	 * Return the common value in global x86_pmu,
-	 * which available for all cores.
-	 */
 	cap->num_counters_gp	= x86_pmu.num_counters;
 	cap->num_counters_fixed	= x86_pmu.num_counters_fixed;
 	cap->bit_width_gp	= x86_pmu.cntval_bits;
-- 
2.39.1.519.gcb327c4b5f-goog

