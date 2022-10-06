Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7F5C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 00:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJFADV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 20:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiJFADU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Oct 2022 20:03:20 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065EE84E5D
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Oct 2022 17:03:20 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id mp3-20020a17090b190300b0020af8232049so119093pjb.9
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Oct 2022 17:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RhM6iZSMqYtBZOLPIkknX0vr2yAb2zl+Qo+V+WJBCzM=;
        b=QeCiF3Wy7QypRn8LL6KEND4sblDwtIs2fywt4CssoMs9BpJHlhBJcHOH3u43seZLRE
         qMg27TeaFQ0Skzfkp4wyjubVvS7ovR02YzTtPff43g1mSM+LkapNVwe62udL+/hKa5J2
         zgtEJPXtDjfeMCM+FF0PRPDQvbOgBWaPr8Wfw5K2vQnHtva2TP9+3rvBceYBJa9THvGH
         NcFsMd6akL0ZMAN06laMZAJkq9k29RUydhmc7cEQGVqa9/DrtPkW7kOmXIUzmWZMd1Xq
         hM2NB1jtMICf+WgaqGs3z8I8akjjg20Jwutnhg7RvSoZuQc7wjHnbr1aiiM01y0lZPoi
         whNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhM6iZSMqYtBZOLPIkknX0vr2yAb2zl+Qo+V+WJBCzM=;
        b=7tkt072FepJgt7tvJgnEoGipjvHZKTbuIrA/0huwgdVSaJ7wYL5guSvPGsk91mhZKQ
         Lti2kkMtKzmgL9P2TCYUljKyFJnUYaxg+EHU0sZNKgANXy7/+YpZRFE1VY/nGnMGprCm
         PozDEy/CcL+BcGtF21wcRGxvolKCVxeNv5ZZYpM+ZNqU9TY04avQArEv9HilHQbYg8XN
         /B/Q/9/IQg6qBijqXqogt0pkNooPISlG9OKAc52o4nmjY1AmFdB9WjDOnyKbS4G5+Aym
         YS8tKK0OJyJt5u44JQIq5jH0lXE18jlWgE7Hs+DX1smYy2+EHnSnn1WxsMSlZGhC6ZVm
         wbQg==
X-Gm-Message-State: ACrzQf3MCrAsu8FqxQBi/l+0DUZWZvR8msr41ZdbPX85/nVfWK+GSdfk
        iAiim0+ZHO+rI1YeMdZYh4CGpCXCbgk=
X-Google-Smtp-Source: AMsMyM6Krv128iFVqVqEOV6EZrfbhUl8komxmlaBGDQkso9y7sj6k62Ayi2e7U/8PAwFvB9I8ORgP6hUqEI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:179c:b0:561:71d3:e112 with SMTP id
 s28-20020a056a00179c00b0056171d3e112mr1899973pfg.12.1665014599587; Wed, 05
 Oct 2022 17:03:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:03:07 +0000
In-Reply-To: <20221006000314.73240-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006000314.73240-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006000314.73240-2-seanjc@google.com>
Subject: [PATCH v5 1/8] perf/x86/core: Zero @lbr instead of returning -1 in
 x86_perf_get_lbr() stub
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

Drop the return value from x86_perf_get_lbr() and have the stub zero out
the @lbr structure instead of returning -1 to indicate "no LBR support".
KVM doesn't actually check the return value, and instead subtly relies on
zeroing the number of LBRs in intel_pmu_init().

Formalize "nr=0 means unsupported" so that KVM doesn't need to add a
pointless check on the return value to fix KVM's benign bug.

Note, the stub is necessary even though KVM x86 selects PERF_EVENTS and
the caller exists only when CONFIG_KVM_INTEL=y.  Despite the name,
KVM_INTEL doesn't strictly require CPU_SUP_INTEL, it can be built with
any of INTEL || CENTAUR || ZHAOXIN CPUs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/lbr.c       | 6 +-----
 arch/x86/include/asm/perf_event.h | 6 +++---
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 47fca6a7a8bc..3abf7b041220 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1876,10 +1876,8 @@ void __init intel_pmu_arch_lbr_init(void)
  * x86_perf_get_lbr - get the LBR records information
  *
  * @lbr: the caller's memory to store the LBR records information
- *
- * Returns: 0 indicates the LBR info has been successfully obtained
  */
-int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
+void x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 {
 	int lbr_fmt = x86_pmu.intel_cap.lbr_format;
 
@@ -1887,8 +1885,6 @@ int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 	lbr->from = x86_pmu.lbr_from;
 	lbr->to = x86_pmu.lbr_to;
 	lbr->info = (lbr_fmt == LBR_FORMAT_INFO) ? x86_pmu.lbr_info : 0;
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index f6fc8dd51ef4..18c105571d11 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -542,12 +542,12 @@ static inline void perf_check_microcode(void) { }
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data);
-extern int x86_perf_get_lbr(struct x86_pmu_lbr *lbr);
+extern void x86_perf_get_lbr(struct x86_pmu_lbr *lbr);
 #else
 struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data);
-static inline int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
+static inline void x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 {
-	return -1;
+	memset(lbr, 0, sizeof(*lbr));
 }
 #endif
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

