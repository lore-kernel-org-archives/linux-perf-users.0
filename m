Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2777BC48BE5
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 03:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061FF61206
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 03:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFUDti (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 20 Jun 2021 23:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFUDth (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 20 Jun 2021 23:49:37 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BD0C061574;
        Sun, 20 Jun 2021 20:47:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h4so1521209pgp.5;
        Sun, 20 Jun 2021 20:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XjzJqJjSiOB4+jUz6E4pSc31aM/SmuZZng+bDkJYtHY=;
        b=pgCKxGRI855jC0c31kiotcLRH+Z5F2phuE1EkKnVgOuOewVdG8G80V64ZM3/vbPEsP
         YZifDNez0fuGhtLvwxKvGdtg3cCo+8nnE4aJN331L3igBNSfoGmKRDWkgCNY/RoCd61r
         24znASGejNAq7y5doKezBH6p8j8ubLzH6NEj5F2Q5gobGC9IzQLt3S32IcyBQhQRKCoG
         70DDHUpBOi4yB3709SeEXjVIvR/RCsl2kYQhYVYexI1kcpm2ZD/yOE6xMPdAx6XGVoPb
         rJTxkfVc4VK7vNbh7fJ5BSvWyxuLD6oHADlzcUNbIPV0tS4eAKybxWF9lzv790UGnVbc
         rx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XjzJqJjSiOB4+jUz6E4pSc31aM/SmuZZng+bDkJYtHY=;
        b=GoTMOYm7x+ZaVQSaCrvycTLHrChbKmMs9hW2iJYAaMb8mjzFvFQRTZEwpE1TTOszl1
         z12qex3GAfecUJ4yFBSMLOFtwf4CMw1L/PEbOERIrszrN5xpKqnIbVTeUXC73I4hVlV4
         /WGR4LpxEjGTQef4vc5qHMcQYCsIWgcGU4lRFYRRIPTg2JdJ+tjplJuSyOb/Nndt61oL
         3cB0VR3a6lYDtkmaRj6UETTUhv9f3konQCHreGu2yrIt2ossQo8JzR9hYilyicQ3DdMU
         tXeRGEW7gqD4a833kYesKTJnHwPIaviDuGxVGDpJYcpHZnzMgl8Pc7TPKuauPgM1H+u6
         VM8g==
X-Gm-Message-State: AOAM530d+Ld+r9cFKIcLvhPpWtPq/ZoBo59HJ0zHDOUFVW7GjGZ6H6+w
        w35NYFIpz8SGVDNIr5/BOBg=
X-Google-Smtp-Source: ABdhPJwgf33rwRK4Y5TUsfsyvhq5El9Zl97U1xjlCAIJ6cnGY5a0NBK9ISEogW5kWSd3FakzI+rrNg==
X-Received: by 2002:a63:903:: with SMTP id 3mr18365467pgj.147.1624247243059;
        Sun, 20 Jun 2021 20:47:23 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id f205sm6177317pfa.154.2021.06.20.20.47.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 20:47:22 -0700 (PDT)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>
Subject: [RESEND PATCH] perf/x86/intel: Fix PEBS-via-PT reload base value for Extended PEBS
Date:   Mon, 21 Jun 2021 11:47:10 +0800
Message-Id: <20210621034710.31107-1-likexu@tencent.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If we use the "PEBS-via-PT" feature on a platform that supports
extended PBES, like this:

    perf record -c 10000 \
    -e '{intel_pt/branch=0/,branch-instructions/aux-output/p}' uname

we will encounter the following call trace:

[  250.906542] unchecked MSR access error: WRMSR to 0x14e1 (tried to write
0x0000000000000000) at rIP: 0xffffffff88073624 (native_write_msr+0x4/0x20)
[  250.920779] Call Trace:
[  250.923508]  intel_pmu_pebs_enable+0x12c/0x190
[  250.928359]  intel_pmu_enable_event+0x346/0x390
[  250.933300]  x86_pmu_start+0x64/0x80
[  250.937231]  x86_pmu_enable+0x16a/0x2f0
[  250.941434]  perf_event_exec+0x144/0x4c0
[  250.945731]  begin_new_exec+0x650/0xbf0
[  250.949933]  load_elf_binary+0x13e/0x1700
[  250.954321]  ? lock_acquire+0xc2/0x390
[  250.958430]  ? bprm_execve+0x34f/0x8a0
[  250.962544]  ? lock_is_held_type+0xa7/0x120
[  250.967118]  ? find_held_lock+0x32/0x90
[  250.971321]  ? sched_clock_cpu+0xc/0xb0
[  250.975527]  bprm_execve+0x33d/0x8a0
[  250.979452]  do_execveat_common.isra.0+0x161/0x1d0
[  250.984673]  __x64_sys_execve+0x33/0x40
[  250.988877]  do_syscall_64+0x3d/0x80
[  250.992806]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  250.998302] RIP: 0033:0x7fbc971d82fb
[  251.002235] Code: Unable to access opcode bytes at RIP 0x7fbc971d82d1.
[  251.009303] RSP: 002b:00007fffb8aed808 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
[  251.017478] RAX: ffffffffffffffda RBX: 00007fffb8af2f00 RCX: 00007fbc971d82fb
[  251.025187] RDX: 00005574792aac50 RSI: 00007fffb8af2f00 RDI: 00007fffb8aed810
[  251.032901] RBP: 00007fffb8aed970 R08: 0000000000000020 R09: 00007fbc9725c8b0
[  251.040613] R10: 6d6c61632f6d6f63 R11: 0000000000000202 R12: 00005574792aac50
[  251.048327] R13: 00007fffb8af35f0 R14: 00005574792aafdf R15: 00005574792aafe7

This is because the target reload msr address is calculated
based on the wrong base msr and the target reload msr value
is accessed from ds->pebs_event_reset[] with the wrong offset.

According to Intel SDM Table 2-14, for extended PBES feature,
the reload msr for MSR_IA32_FIXED_CTRx should be based on
MSR_RELOAD_FIXED_CTRx.

For fixed counters, let's fix it by overriding the reload msr
address and its value, thus avoiding out-of-bounds access.

Fixes: 42880f726c66("perf/x86/intel: Support PEBS output to PT")
Signed-off-by: Like Xu <likexu@tencent.com>
---
 arch/x86/events/intel/ds.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1ec8fd311f38..8647713276a7 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1187,6 +1187,9 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 	struct debug_store *ds = cpuc->ds;
+	u64 value = ds->pebs_event_reset[hwc->idx];
+	u32 base = MSR_RELOAD_PMC0;
+	unsigned int idx = hwc->idx;
 
 	if (!is_pebs_pt(event))
 		return;
@@ -1196,7 +1199,12 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
 
 	cpuc->pebs_enabled |= PEBS_OUTPUT_PT;
 
-	wrmsrl(MSR_RELOAD_PMC0 + hwc->idx, ds->pebs_event_reset[hwc->idx]);
+	if (hwc->idx >= INTEL_PMC_IDX_FIXED) {
+		base = MSR_RELOAD_FIXED_CTR0;
+		idx = hwc->idx - INTEL_PMC_IDX_FIXED;
+		value = ds->pebs_event_reset[MAX_PEBS_EVENTS + idx];
+	}
+	wrmsrl(base + idx, value);
 }
 
 void intel_pmu_pebs_enable(struct perf_event *event)
@@ -1204,6 +1212,7 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 	struct debug_store *ds = cpuc->ds;
+	unsigned int idx = hwc->idx;
 
 	hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
 
@@ -1222,19 +1231,18 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 		}
 	}
 
+	if (idx >= INTEL_PMC_IDX_FIXED)
+		idx = MAX_PEBS_EVENTS + (idx - INTEL_PMC_IDX_FIXED);
+
 	/*
 	 * Use auto-reload if possible to save a MSR write in the PMI.
 	 * This must be done in pmu::start(), because PERF_EVENT_IOC_PERIOD.
 	 */
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
-		unsigned int idx = hwc->idx;
-
-		if (idx >= INTEL_PMC_IDX_FIXED)
-			idx = MAX_PEBS_EVENTS + (idx - INTEL_PMC_IDX_FIXED);
 		ds->pebs_event_reset[idx] =
 			(u64)(-hwc->sample_period) & x86_pmu.cntval_mask;
 	} else {
-		ds->pebs_event_reset[hwc->idx] = 0;
+		ds->pebs_event_reset[idx] = 0;
 	}
 
 	intel_pmu_pebs_via_pt_enable(event);
-- 
2.30.1 (Apple Git-130)

