Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55B6C3A589
	for <linux-perf-users@archiver.kernel.org>; Sat, 19 Nov 2022 01:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiKSBxk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Nov 2022 20:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiKSBwp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Nov 2022 20:52:45 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E120BC4C18
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Nov 2022 17:35:00 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id cw4-20020a056a00450400b00561ec04e77aso3997131pfb.12
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Nov 2022 17:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TighIegw0FVxEDaBlZjjTMFerelt3ds/i85zL8CdikU=;
        b=rmXe3VvPa8zVoj+4dcS77sndQg/asQbzYB56Apv5ggGW1UuoVvHp+A5nMUNJLLDfT3
         0SofbaNG1mdy2xYr69bYijAVWvASmZ+BqpR/39RMUQ9fkkgAxOfAbbiCLxjhwxFDSnJD
         CYvPDNSf4OyAJDiay7zq/RREBEcBoCo+j9xnBGDg3cCGMQQFHgk7xqMIHyhqLMB+bCwR
         NAaB2xI/+noK1nArryRf5o2AI/YWSXe/+BtRdDtBj4KcS5PatRnf6S7gkyW5Yh4ep5o2
         9FIQoQ8VkWuppw661uC0FbLCjWmBTrmiieXQzRAdkvaLBoGT3HMeR/wJf7SYLzVFCqzk
         4tiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TighIegw0FVxEDaBlZjjTMFerelt3ds/i85zL8CdikU=;
        b=fCGewwfdqDJQslSb6AP+io1BdQwOTCdy9XgZ4qqNwNP+MWaHdIyzuTAPf2xK6CpBo+
         szYN9kn/WTU0Y08WclhXnMDE0nkNJunhl4A2MomQdDI57GsSiWNlL01TsuR0oT0cOMzY
         +vmY05mmsg6plg654e0JP7pPTrrw7duk2EAvypRKZyzbA0rYXvMtQGfBXTUY9bhGsZDN
         +SL2A3ap6t7Itn+aWt7usN1YYfUv6gsbM2eRcwkxreYW0cN4eHI0ZowVzESvS849I3/T
         5RAirlOKTOcIHXsZHwgNJjp2W7m5kHD8OgBm0PG4/PkdqRkkfsGziqfyhs6tIThzWI++
         s+nQ==
X-Gm-Message-State: ANoB5plSbwqHUOxSFZ4ywGiS2H2x/IDvR3dubinqvQQHHim/tAkWC7pv
        6FgPFKmf8FY4MCI2rtRoiUWhyIqtxOE=
X-Google-Smtp-Source: AA0mqf7npHfQc5LwOz0q7JCYBS7uttfoGJCbriNRIIB73IIE/vGbpLSdnE48DGaUO0X9NP3W41W4iWnhxeQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:8d88:0:b0:562:69d4:f9f3 with SMTP id
 i8-20020aa78d88000000b0056269d4f9f3mr10570461pfr.5.1668821700033; Fri, 18 Nov
 2022 17:35:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 19 Nov 2022 01:34:45 +0000
In-Reply-To: <20221119013450.2643007-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221119013450.2643007-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221119013450.2643007-5-seanjc@google.com>
Subject: [PATCH 4/9] tools: Take @bit as an "unsigned long" in
 {clear,set}_bit() helpers
From:   Sean Christopherson <seanjc@google.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Take @bit as an unsigned long instead of a signed int in clear_bit() and
set_bit() so that they match the double-underscore versions, __clear_bit()
and __set_bit().  This will allow converting users that really don't want
atomic operations to the double-underscores without introducing a
functional change, which will in turn allow making {clear,set}_bit()
atomic (as advertised).

Practically speaking, this _should_ have no functional impact.  KVM's
selftests usage is either hardcoded (Hyper-V tests) or is artificially
limited (arch_timer test and dirty_log test).  In KVM, dirty_log test is
the only mildly interesting case as it's use indirectly restricted to
unsigned 32-bit values, but in theory it could generate a negative value
when cast to a signed int.  But in that case, taking an "unsigned long"
is actually a bug fix.

Perf's usage is more difficult to audit, but any code that is affected
by the switch is likely already broken.  perf_header__{set,clear}_feat()
and perf_file_header__read() effectively use only hardcoded enums with
small, positive values, atom_new() passes an unsigned long, but its value
is capped at 128 via NR_ATOM_PER_PAGE, etc...

The only real potential for breakage is in the perf flows that take a
"cpu", but it's unlikely perf is subtly relying on a negative index into
bitmaps, e.g. "cpu" can be "-1", but only as "not valid" placeholder.

Note, tools/testing/nvdimm/ makes heavy use of set_bit(), but that code
builds into a kernel module of sorts, i.e. pulls in all of the kernel's
header and so is getting the kernel's atomic set_bit().  The NVDIMM test
usage of atomics is likely unnecessary, e.g. ndtest_dimm_register() sets
bits in a local variable, but that's neither here nor there as far as
this change is concerned.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/include/asm-generic/bitops/atomic.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/asm-generic/bitops/atomic.h b/tools/include/asm-generic/bitops/atomic.h
index 2f6ea28764a7..f64b049d236c 100644
--- a/tools/include/asm-generic/bitops/atomic.h
+++ b/tools/include/asm-generic/bitops/atomic.h
@@ -5,12 +5,12 @@
 #include <asm/types.h>
 #include <asm/bitsperlong.h>
 
-static inline void set_bit(int nr, unsigned long *addr)
+static inline void set_bit(unsigned long nr, unsigned long *addr)
 {
 	addr[nr / __BITS_PER_LONG] |= 1UL << (nr % __BITS_PER_LONG);
 }
 
-static inline void clear_bit(int nr, unsigned long *addr)
+static inline void clear_bit(unsigned long nr, unsigned long *addr)
 {
 	addr[nr / __BITS_PER_LONG] &= ~(1UL << (nr % __BITS_PER_LONG));
 }
-- 
2.38.1.584.g0f3c55d4c2-goog

