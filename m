Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3AAECAAD8
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Sep 2022 06:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiINGZm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Sep 2022 02:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiINGZm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Sep 2022 02:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76B3303C4
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Sep 2022 23:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663136739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=44i+FqU0FLnF0lFHl/5hxKW2WUxjdKprC+EJIaQ0Mz8=;
        b=aKVLG6HaXyZae/h/joqaoea68+gH61GMWlqpgVb87dWdhjYES9JdVEHprky2iWPAjCnI0J
        lHGQFWLYYd8wKKsJvVXWpwkn0igPSF3y99WTZNHyJX9h+p5UAEeWqKbjiHYu20ezSQ8cnB
        u2UKjqGKT/w69auGMTmC14ZEFr53EoI=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-e3t3SDq1PmeU2Hj5Bfjg4Q-1; Wed, 14 Sep 2022 02:25:38 -0400
X-MC-Unique: e3t3SDq1PmeU2Hj5Bfjg4Q-1
Received: by mail-vk1-f197.google.com with SMTP id n205-20020a1fa4d6000000b0037d1d4d3237so3257507vke.6
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Sep 2022 23:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=44i+FqU0FLnF0lFHl/5hxKW2WUxjdKprC+EJIaQ0Mz8=;
        b=7FqGGQjJVJM16U8hLH7l6X87kcLbuZnOgcztrrJDv+cmhHKkkZ6hQkA4gOp8ppy388
         Z8m7gRkvrhCVdY5LCEJrht9TgU7SGM471PeibmfIVFih7EPAoaElqU7zODOpA/rAPgta
         ZwiPOcsuJPrxyAnxF5gGGsTnl7m+oO2hWfzkJ453Z2AIgc82SLJhm7A1gci1M0OrwfB6
         cHwYBMnCpM0LIUQwDe6R6sqZiCrAnzJg1PukM+nOHw4EbciI5ePgOkghCjoTVl1h44Om
         ZcB/lOEizHQRceaSrSW3WFmjdp+49b5zYahGo5c23tQgeGf/AzlusOs4MdHfinfkRuTk
         9PoQ==
X-Gm-Message-State: ACgBeo3PRQbGnsrkAi7xi3c/YxItFvd4NR2mqTi1VWctTcUwKNT/cOzI
        Umvdcvbbz4ExzT39u+sxJzrHuyXyim6zLLQZhlOMX6Dv814yVwx2WhFUo+SxyhLkyFFKIDKe9KA
        j/8E+MvSOoQBCpbd51JPxPtXP++vq3ocGwuzqnT02s90EiQ==
X-Received: by 2002:a05:6102:319c:b0:398:c9a8:ef0f with SMTP id c28-20020a056102319c00b00398c9a8ef0fmr73089vsh.43.1663136736992;
        Tue, 13 Sep 2022 23:25:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5uIObG6xJ39M0lb1dh1eUN/HAdU4e00QtFbXiLaZ0GXnCDc3jkP6NoTYXHGJigiyHTImg+ytQPImHVjlVk4D0=
X-Received: by 2002:a05:6102:319c:b0:398:c9a8:ef0f with SMTP id
 c28-20020a056102319c00b00398c9a8ef0fmr73081vsh.43.1663136736743; Tue, 13 Sep
 2022 23:25:36 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 14 Sep 2022 14:25:25 +0800
Message-ID: <CAHj4cs9gC9RSvG_F++6=v3wn9QThgh5g=TT+wET6MDW2eWMoUA@mail.gmail.com>
Subject: [bug report] kmemleak observed after system boots up with amd cpu
To:     linux-perf-users@vger.kernel.org, x86@kernel.org
Cc:     ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello
Below kmemleak observed after the system boots up on 6.0.0-rc5, here
is the cpu and kmemleak info, feel free to let me know if you need
more info/test for it, thanks.

# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              16
On-line CPU(s) list: 0-15
Thread(s) per core:  2
Core(s) per socket:  8
Socket(s):           1
NUMA node(s):        1
Vendor ID:           AuthenticAMD
BIOS Vendor ID:      AMD
CPU family:          23
Model:               49
Model name:          AMD EPYC 7232P 8-Core Processor
BIOS Model name:     AMD EPYC 7232P 8-Core Processor
Stepping:            0
CPU MHz:             3100.000
CPU max MHz:         3100.0000
CPU min MHz:         1500.0000
BogoMIPS:            6188.28
Virtualization:      AMD-V
L1d cache:           32K
L1i cache:           32K
L2 cache:            512K
L3 cache:            8192K
NUMA node0 CPU(s):   0-15
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap
clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale
vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic
v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca
sev sev_es

# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff888140be6540 (size 32):
  comm "swapper/0", pid 1, jiffies 4294683141 (age 2488.140s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000009569963d>] __kmalloc_node+0x10e/0x270
    [<000000005ec49251>] amd_uncore_cpu_up_prepare+0x1c3/0x780
    [<00000000b48a1e7c>] cpuhp_invoke_callback+0x40e/0x1760
    [<00000000555aab25>] cpuhp_issue_call+0x18f/0x6b0
    [<00000000b4dd3935>] __cpuhp_setup_state_cpuslocked+0x2c0/0x8f0
    [<0000000066ebf481>] __cpuhp_setup_state+0xbb/0x210
    [<000000000949b7a4>] amd_uncore_init+0x385/0x46f
    [<000000008505629b>] do_one_initcall+0xfc/0x580
    [<00000000192522a5>] kernel_init_freeable+0x67d/0x710
    [<00000000613746f8>] kernel_init+0x18/0x160
    [<00000000813ba43a>] ret_from_fork+0x22/0x30
unreferenced object 0xffff888140bdd800 (size 64):
  comm "swapper/0", pid 1, jiffies 4294683141 (age 2488.140s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000009569963d>] __kmalloc_node+0x10e/0x270
    [<0000000037b0b577>] amd_uncore_cpu_up_prepare+0x41f/0x780
    [<00000000b48a1e7c>] cpuhp_invoke_callback+0x40e/0x1760
    [<00000000555aab25>] cpuhp_issue_call+0x18f/0x6b0
    [<00000000b4dd3935>] __cpuhp_setup_state_cpuslocked+0x2c0/0x8f0
    [<0000000066ebf481>] __cpuhp_setup_state+0xbb/0x210
    [<000000000949b7a4>] amd_uncore_init+0x385/0x46f
    [<000000008505629b>] do_one_initcall+0xfc/0x580
    [<00000000192522a5>] kernel_init_freeable+0x67d/0x710
    [<00000000613746f8>] kernel_init+0x18/0x160
    [<00000000813ba43a>] ret_from_fork+0x22/0x30

-- 
Best Regards,
  Yi Zhang

