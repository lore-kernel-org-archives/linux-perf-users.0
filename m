Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B727C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 13:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0136613B2
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 13:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFVNif (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 09:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFVNif (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 09:38:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64B0C061574;
        Tue, 22 Jun 2021 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZMVUEa2ftu4FuJfVBY24GiGS9yAP+xLlFfBh5dASAjQ=; b=Y15Sro6mF/ZIERWCYj4rfBGnD9
        pXk15J5EwKJaUdT5xwRI6kPHj26CgJU4wYy6MH/7Doq9VkHC3clV5941/G11jeXHxa85wD7+E+6a9
        vj1MAaTq/uBQ2fbwh49bFJLC2uooJjgArmm35T3+Y/7f3p487EfIGnzgeWFFHrKYsS85PKFY8mv7X
        p/WxLe+dWA2oFov5QPXUcFuVUrsfbuppAAfAJjffWKycnTvTBNx7UesBiU8F5jEi+Kax2yGJVf1TU
        ZI5iTcntKeHZCNjLvAor1U2mRC1EwVvERSC0zjVdYMT7oN6Q88f4ZBkDWzhNCGN1rfd5NxA777mOo
        wpKiDJqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvgZL-00Abs3-77; Tue, 22 Jun 2021 13:36:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA75830021A;
        Tue, 22 Jun 2021 15:36:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C9572C733666; Tue, 22 Jun 2021 15:36:03 +0200 (CEST)
Date:   Tue, 22 Jun 2021 15:36:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix PEBS-via-PT reload base value
 for Extended PEBS
Message-ID: <YNHnQzECTcFGOoHO@hirez.programming.kicks-ass.net>
References: <20210621034710.31107-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621034710.31107-1-likexu@tencent.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 21, 2021 at 11:47:10AM +0800, Like Xu wrote:
> If we use the "PEBS-via-PT" feature on a platform that supports
> extended PBES, like this:
> 
>     perf record -c 10000 \
>     -e '{intel_pt/branch=0/,branch-instructions/aux-output/p}' uname
> 
> we will encounter the following call trace:
> 
> [  250.906542] unchecked MSR access error: WRMSR to 0x14e1 (tried to write
> 0x0000000000000000) at rIP: 0xffffffff88073624 (native_write_msr+0x4/0x20)
> [  250.920779] Call Trace:
> [  250.923508]  intel_pmu_pebs_enable+0x12c/0x190
> [  250.928359]  intel_pmu_enable_event+0x346/0x390
> [  250.933300]  x86_pmu_start+0x64/0x80
> [  250.937231]  x86_pmu_enable+0x16a/0x2f0
> [  250.941434]  perf_event_exec+0x144/0x4c0
> [  250.945731]  begin_new_exec+0x650/0xbf0
> [  250.949933]  load_elf_binary+0x13e/0x1700
> [  250.954321]  ? lock_acquire+0xc2/0x390
> [  250.958430]  ? bprm_execve+0x34f/0x8a0
> [  250.962544]  ? lock_is_held_type+0xa7/0x120
> [  250.967118]  ? find_held_lock+0x32/0x90
> [  250.971321]  ? sched_clock_cpu+0xc/0xb0
> [  250.975527]  bprm_execve+0x33d/0x8a0
> [  250.979452]  do_execveat_common.isra.0+0x161/0x1d0
> [  250.984673]  __x64_sys_execve+0x33/0x40
> [  250.988877]  do_syscall_64+0x3d/0x80
> [  250.992806]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  250.998302] RIP: 0033:0x7fbc971d82fb
> [  251.002235] Code: Unable to access opcode bytes at RIP 0x7fbc971d82d1.
> [  251.009303] RSP: 002b:00007fffb8aed808 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
> [  251.017478] RAX: ffffffffffffffda RBX: 00007fffb8af2f00 RCX: 00007fbc971d82fb
> [  251.025187] RDX: 00005574792aac50 RSI: 00007fffb8af2f00 RDI: 00007fffb8aed810
> [  251.032901] RBP: 00007fffb8aed970 R08: 0000000000000020 R09: 00007fbc9725c8b0
> [  251.040613] R10: 6d6c61632f6d6f63 R11: 0000000000000202 R12: 00005574792aac50
> [  251.048327] R13: 00007fffb8af35f0 R14: 00005574792aafdf R15: 00005574792aafe7
> 
> This is because the target reload msr address is calculated
> based on the wrong base msr and the target reload msr value
> is accessed from ds->pebs_event_reset[] with the wrong offset.
> 
> According to Intel SDM Table 2-14, for extended PBES feature,
> the reload msr for MSR_IA32_FIXED_CTRx should be based on
> MSR_RELOAD_FIXED_CTRx.
> 
> For fixed counters, let's fix it by overriding the reload msr
> address and its value, thus avoiding out-of-bounds access.
> 
> Fixes: 42880f726c66("perf/x86/intel: Support PEBS output to PT")
> Signed-off-by: Like Xu <likexu@tencent.com>

Thanks!
