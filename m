Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB79C004D4
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Jan 2023 00:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjATAlP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 19:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjATAlI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Jan 2023 19:41:08 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC0CA57AB
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 16:41:01 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4ce566db73eso35848927b3.11
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 16:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RChfojZSEu0VpWRA0QiZt+0hmKVb1/N9i6LB2MMx+/U=;
        b=TMRgq1lYspF4qjU1PoMZ91855bnDMMbB5ZvqtNh8zuBj9om107AphBBPpPmTuXiMQT
         KQdgVkt13M3F8MTGeCyc39U9jpNKozdRkpMT+fzuCrJ9TmkJu+F22zR4ys2tx5zyEDnA
         uv02szvjoHhVrdjZs9AeaNb9J5J0b/mDNQsSgGYcxmIgEFdVucpejAzv5YRqxOHy3Tsn
         FW85FW089TjyGzTSk6SIlVWwpr+FFzGJbJkkx07EwGDJjliVmtcK1wHLpezjrMF7aeLB
         pnZUCK7Qt8rlfz5dJaceTuKUlr0VVGLxD7S8zg/ctKMU4FlSg8aSIViy5BpLBwzBcVD4
         Nrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RChfojZSEu0VpWRA0QiZt+0hmKVb1/N9i6LB2MMx+/U=;
        b=ppIy7PQoLgmJa2Xv2laHhpn1chq0XkfQAvxQGtHHak8PtLuW1Ioybptcjd+AJISyMa
         SnkIeJEjkQdFgt0J04CkZWWC4K7Pn5czrcl5GV1EmuAM+vMTIPH9TRh4hP1p7hZlA1DS
         0ksIHv3gm8GJ/SvAJeAlTe/zzlrc+Z5Puw+7mB9VG41tX6HtTNH+XWhRCo5MJwjpWjXW
         WwuX39y9qzplNBkmzMpQJt7ypybt+nkxWNgBFl2QfbGB0ukPR0LI1IkXCsT1kG8QAluj
         6i5OQ1NS/DKCMAS7J7X+QWjLEts2YDjTDygALNSkURQfhf9CNCVwlSnIdiM4t9P5Su1i
         gP0Q==
X-Gm-Message-State: AFqh2kpv32VX85eTLMMLipiDuvj04OwRYC5bKIQwsYiA7/ouLBHKpnMW
        cVrh55Lct43VE2Uou1kkJ8dHSEVY1Ws=
X-Google-Smtp-Source: AMrXdXs8FPNxBgA8z++xqECNoji6FVdv680vuxSLnYRNwmObaC4pEURTyKB1wY4wlC+eCeKQvFXrFGDfP9Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:990a:0:b0:4b6:dce2:93 with SMTP id
 q10-20020a81990a000000b004b6dce20093mr1600405ywg.164.1674175260087; Thu, 19
 Jan 2023 16:41:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 20 Jan 2023 00:40:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230120004051.2043777-1-seanjc@google.com>
Subject: [PATCH] perf/x86: KVM: Disable vPMU support on hybrid CPUs (host PMUs)
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Disable KVM support for virtualizing PMUs on hosts with hybrid PMUs until
KVM gains a sane way to enumeration the hybrid vPMU to userspace and/or
gains a mechanism to let userspace opt-in to the dangers of exposing a
hybrid vPMU to KVM guests.

Virtualizing a hybrid PMU, or at least part of a hybrid PMU, is possible,
but it requires userspace to pin vCPUs to pCPUs to prevent migrating a
vCPU between a big core and a little core, requires the VMM to accurately
enumerate the topology to the guest (if exposing a hybrid CPU to the
guest), and also requires the VMM to accurately enumerate the vPMU
capabilities to the guest.

The last point is especially problematic, as KVM doesn't control which
pCPU it runs on when enumerating KVM's vPMU capabilities to userspace.
For now, simply disable vPMU support on hybrid CPUs to avoid inducing
seemingly random #GPs in guests.

Reported-by: Jianfeng Gao <jianfeng.gao@intel.com>
Cc: stable@vger.kernel.org
Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/all/20220818181530.2355034-1-kan.liang@linux.intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Lightly tested as I don't have hybrid hardware.  For the record, I'm not
against supporting hybrid vPMUs in KVM, but it needs to be a dedicated
effort and not implicitly rely on userspace to do the right thing (or get
lucky).

 arch/x86/events/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 85a63a41c471..a67667c41cc8 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2974,17 +2974,18 @@ unsigned long perf_misc_flags(struct pt_regs *regs)
 
 void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 {
-	if (!x86_pmu_initialized()) {
+	/*
+	 * Hybrid PMUs don't play nice with virtualization unless userspace
+	 * pins vCPUs _and_ can enumerate accurate information to the guest.
+	 * Disable vPMU support for hybrid PMUs until KVM gains a way to let
+	 * userspace opt into the dangers of hybrid vPMUs.
+	 */
+	if (!x86_pmu_initialized() || is_hybrid()) {
 		memset(cap, 0, sizeof(*cap));
 		return;
 	}
 
 	cap->version		= x86_pmu.version;
-	/*
-	 * KVM doesn't support the hybrid PMU yet.
-	 * Return the common value in global x86_pmu,
-	 * which available for all cores.
-	 */
 	cap->num_counters_gp	= x86_pmu.num_counters;
 	cap->num_counters_fixed	= x86_pmu.num_counters_fixed;
 	cap->bit_width_gp	= x86_pmu.cntval_bits;

base-commit: de60733246ff4545a0483140c1f21426b8d7cb7f
-- 
2.39.0.246.g2a6d74b583-goog

