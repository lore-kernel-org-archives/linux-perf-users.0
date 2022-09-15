Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890AFC6FA82
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Sep 2022 01:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIOBtV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Sep 2022 21:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiIOBtH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Sep 2022 21:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52C58E4DC
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Sep 2022 18:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663206545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vyIZddjeESAlDqXeIF2q65Vg8hP+pwUa3dNgluNVH+A=;
        b=got3qFiebqVnXkoATp6Ph7Fq0lHkx4X6VgXGJh6VbtwBiSPQv8oTz3SAcYTf2zJmw1JZkL
        OW+wYNE3VuAfGEIDFcmtkPCEolgE0xDE5qMJFxoD6yNvqFE4y48NxwJN4vk5xXbRbxkKBx
        Q7sNyHNYhcPFcX3Fa8qI7IH/BjE1pLY=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-GxJpnRxkPlKWL_5mWBy_PA-1; Wed, 14 Sep 2022 21:49:04 -0400
X-MC-Unique: GxJpnRxkPlKWL_5mWBy_PA-1
Received: by mail-ua1-f69.google.com with SMTP id h19-20020ab01353000000b00392f0767f64so4555103uae.17
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Sep 2022 18:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vyIZddjeESAlDqXeIF2q65Vg8hP+pwUa3dNgluNVH+A=;
        b=fpdQKqIXxkUAAm8PR3nSacdXqvFAcy9YyIamxM69amb4A/z0G1Ievyjk8wZ73bBOV+
         dy70CV3D3XAqU+I9mR+EIigk53gqr/UfCP65fFfdgffOTh6o3sDWK3GVF3rzaXCSxU/z
         4YXc+GrW0Dg/+WAqCKjzCdLYD6Py2YPkbE39NYxj/MREMQ3fSi1MTlgtfXH+szfSw17b
         Bbf86x3pAyMTnBiqit4BH+O21w9tTnca2LoeXSycF2EXhiQL04srXCTbWHTDHh5jItz6
         rMdujHWZBKg8wTOMxUdlr9s5d5/FdfK+tKkvuofQaznIeQ6jMILvFoHicF8eQhMJGAL5
         l2zA==
X-Gm-Message-State: ACgBeo2hsPlVGQ0i4ttDgaqhL+Jb0p6MlXD1NtnzNEoPNgZQX2lo3VRc
        Uc5czQ4u4+Wh0Btxnn0pkm3qgbVUYL3f5VcSXHNGJbwXN9anAQWygq556Eos7i/n9VxVIUzkC17
        NQERy0iz7KJ5Oa9k2RA/27b8zv+FEV3t4l80f3b1UD+s0Wg==
X-Received: by 2002:a05:6102:2267:b0:398:c5f3:dfc2 with SMTP id v7-20020a056102226700b00398c5f3dfc2mr1827384vsd.60.1663206543557;
        Wed, 14 Sep 2022 18:49:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5UBRMC7CXWubzISmI8kPwXxTfgPPMAsuRhjKyIzS74QhlZ2RSV0YEv/SFwiI9QFmvOCoz1LN/SUFTY8viJasY=
X-Received: by 2002:a05:6102:2267:b0:398:c5f3:dfc2 with SMTP id
 v7-20020a056102226700b00398c5f3dfc2mr1827379vsd.60.1663206543299; Wed, 14 Sep
 2022 18:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9gC9RSvG_F++6=v3wn9QThgh5g=TT+wET6MDW2eWMoUA@mail.gmail.com>
 <02ecc849-06de-d558-3750-a8bf878869e9@amd.com>
In-Reply-To: <02ecc849-06de-d558-3750-a8bf878869e9@amd.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 15 Sep 2022 09:48:51 +0800
Message-ID: <CAHj4cs_W4=EGPqv-nG5M3X=hDCmaYMUtYjnXGAr_ha800ohB3Q@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed after system boots up with amd cpu
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-perf-users@vger.kernel.org, x86@kernel.org,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Yeah, it was fixed by the patch, feel free to add:
Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Wed, Sep 14, 2022 at 2:32 PM Sandipan Das <sandipan.das@amd.com> wrote:
>
> Hi,
>
> On 9/14/2022 11:55 AM, Yi Zhang wrote:
> > Hello
> > Below kmemleak observed after the system boots up on 6.0.0-rc5, here
> > is the cpu and kmemleak info, feel free to let me know if you need
> > more info/test for it, thanks.
> >
> > # lscpu
> > Architecture:        x86_64
> > CPU op-mode(s):      32-bit, 64-bit
> > Byte Order:          Little Endian
> > CPU(s):              16
> > On-line CPU(s) list: 0-15
> > Thread(s) per core:  2
> > Core(s) per socket:  8
> > Socket(s):           1
> > NUMA node(s):        1
> > Vendor ID:           AuthenticAMD
> > BIOS Vendor ID:      AMD
> > CPU family:          23
> > Model:               49
> > Model name:          AMD EPYC 7232P 8-Core Processor
> > BIOS Model name:     AMD EPYC 7232P 8-Core Processor
> > Stepping:            0
> > CPU MHz:             3100.000
> > CPU max MHz:         3100.0000
> > CPU min MHz:         1500.0000
> > BogoMIPS:            6188.28
> > Virtualization:      AMD-V
> > L1d cache:           32K
> > L1i cache:           32K
> > L2 cache:            512K
> > L3 cache:            8192K
> > NUMA node0 CPU(s):   0-15
> > Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
> > pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
> > fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
> > cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
> > sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
> > cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
> > osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
> > perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
> > stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap
> > clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
> > cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
> > rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale
> > vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic
> > v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca
> > sev sev_es
> >
> > # cat /sys/kernel/debug/kmemleak
> > unreferenced object 0xffff888140be6540 (size 32):
> >   comm "swapper/0", pid 1, jiffies 4294683141 (age 2488.140s)
> >   hex dump (first 32 bytes):
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<000000009569963d>] __kmalloc_node+0x10e/0x270
> >     [<000000005ec49251>] amd_uncore_cpu_up_prepare+0x1c3/0x780
> >     [<00000000b48a1e7c>] cpuhp_invoke_callback+0x40e/0x1760
> >     [<00000000555aab25>] cpuhp_issue_call+0x18f/0x6b0
> >     [<00000000b4dd3935>] __cpuhp_setup_state_cpuslocked+0x2c0/0x8f0
> >     [<0000000066ebf481>] __cpuhp_setup_state+0xbb/0x210
> >     [<000000000949b7a4>] amd_uncore_init+0x385/0x46f
> >     [<000000008505629b>] do_one_initcall+0xfc/0x580
> >     [<00000000192522a5>] kernel_init_freeable+0x67d/0x710
> >     [<00000000613746f8>] kernel_init+0x18/0x160
> >     [<00000000813ba43a>] ret_from_fork+0x22/0x30
> > unreferenced object 0xffff888140bdd800 (size 64):
> >   comm "swapper/0", pid 1, jiffies 4294683141 (age 2488.140s)
> >   hex dump (first 32 bytes):
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<000000009569963d>] __kmalloc_node+0x10e/0x270
> >     [<0000000037b0b577>] amd_uncore_cpu_up_prepare+0x41f/0x780
> >     [<00000000b48a1e7c>] cpuhp_invoke_callback+0x40e/0x1760
> >     [<00000000555aab25>] cpuhp_issue_call+0x18f/0x6b0
> >     [<00000000b4dd3935>] __cpuhp_setup_state_cpuslocked+0x2c0/0x8f0
> >     [<0000000066ebf481>] __cpuhp_setup_state+0xbb/0x210
> >     [<000000000949b7a4>] amd_uncore_init+0x385/0x46f
> >     [<000000008505629b>] do_one_initcall+0xfc/0x580
> >     [<00000000192522a5>] kernel_init_freeable+0x67d/0x710
> >     [<00000000613746f8>] kernel_init+0x18/0x160
> >     [<00000000813ba43a>] ret_from_fork+0x22/0x30
> >
>
> Thanks for reporting this. A fix has already been sent and it can be found here:
> https://lore.kernel.org/all/4fa9e5ac6d6e41fa889101e7af7e6ba372cfea52.1662613255.git.sandipan.das@amd.com/
>
> It would be great if you can test it and report your findings.
>
> - Sandipan
>


-- 
Best Regards,
  Yi Zhang

