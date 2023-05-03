Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E1CC77B78
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 May 2023 13:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjECN4k (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 May 2023 09:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjECN4j (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 May 2023 09:56:39 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C50D5BBC
        for <linux-perf-users@vger.kernel.org>; Wed,  3 May 2023 06:56:30 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7516ef6b519so16729285a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 May 2023 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683122188; x=1685714188;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L7GSaDU+oT/ntMiaCollt+1Pf02SpPPlm+2u83gwZfE=;
        b=P6VWQ9FGuG+5pxcqIGRcMalIRKyHZ39lpp0TRDK0z4B1Wnvb5q1AAczJcVvnb1aKuQ
         wYdqzxKz5OSXScdPSJ3rRrIVEmc5Dkb+AwWSFx/bsV+W9XFY29xCFKd5UDsBsN5ElDwD
         EYrd8jYn/8ia1CQLAMhTZDmMtkWAkjPyR0uk5mbxeUEtyB4cPfk+tUHdg6coQJJdsVvl
         QA6quR6OmvLAKG9vrkwptNhuJUiRbbLVuRDhqbNiRyW8L1xemVkScwiLoyVjJHl+Mids
         hPJQX5na2YLh2cdxBkJSifAD5YPLvUWSlyJshcXW6B9ZxbJJvxjYJIVIYMggL9509Tly
         K72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683122188; x=1685714188;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7GSaDU+oT/ntMiaCollt+1Pf02SpPPlm+2u83gwZfE=;
        b=DOf9lWWEcRgMWLKVZ3UCCg3Sxxdi8pZcxlceq5HqN8AViWfc/wSgLPxse78NzQ/c3r
         vT4/o4Vx7i1cdrAQgM4v7S7gu2BxRwLMitWtE2rtStZzdydnHqdP04vHzY1bnwqjc8Wg
         +GfXiJtujN1m9p+EP8LNEgJU4+PPNSAJ3nAGKPVWy09QdOTUXwFNT62cyCBh3qOEY7R0
         jP4ZIBW9FML6PYrXU1XS7XnlgSPpr+XTuVmSC4pK20ZjMjqf2xwHXEorrCcJ3VlHYvW7
         4OtpoCm1BMfk04mXyOODgqXPjL39aoLVI6ViKmNeVewbVGlAbey4lvbqbpPH1Pij1PeK
         O89Q==
X-Gm-Message-State: AC+VfDxutISbq+yMDa61xugfpQrDrHXHnKC9jf0OZmHrqh8rYAplnGbA
        OkKVye1B9ylVXylkEUCpFnhjB0uW10LNtU4vodTkyxnGLBiGuJ9I
X-Google-Smtp-Source: ACHHUZ71pUcb7f5qcOzLQ4S+jjlUdTh7AgeYPVz5/+646nP04BHaN2+sgJJpTT709kEsB12vbCvn1/6ZS4sYv7D5ZLc=
X-Received: by 2002:a05:6214:622:b0:532:141d:3750 with SMTP id
 a2-20020a056214062200b00532141d3750mr8204131qvx.2.1683122188356; Wed, 03 May
 2023 06:56:28 -0700 (PDT)
MIME-Version: 1.0
From:   Danny Pereira <dannyjpereira1@gmail.com>
Date:   Wed, 3 May 2023 19:26:16 +0530
Message-ID: <CAOorKwEo703Mk0vaSG42sOJVaGnn36OAvx=XYOhwX9tuxikhsQ@mail.gmail.com>
Subject: Issue in inserting a kernel module for counting performance counters
 on Jetson Nano
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello All,

I am testing a kernel module which creates perf events on every core
and counts the total number of L2D_CACHE_REFILL.

System details are :

NVIDIA Jetson nano,
OS: Ubuntu  18.04.6 LTS,
Kernel: 4.9.255, L4T: 32.7.3,
Jetpack: 4.6.3

insmod is inserting module in kernel space. But throws WARNING message
in kernel log file. The log obtained using  dmesg command is :

[  977.838359] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G           O
4.9.299-BWv1.0 #1
[  977.838361] Hardware name: NVIDIA Jetson Nano Developer Kit (DT)
[  977.838364] task: ffffffc0fa7bb900 task.stack: ffffffc0fa7cc000
[  977.838368] PC is at armpmu_start+0x70/0x78
[  977.838372] LR is at cpu_pm_pmu_setup.isra.2+0x68/0xd8
[  977.838375] pc : [<ffffff8008ce1b48>] lr : [<ffffff8008ce1e30>]
pstate: 604000c5
[  977.838377] sp : ffffffc0fa7cfd20
[  977.838380] x29: ffffffc0fa7cfd20 x28: 0000000000000001
[  977.838385] x27: ffffff8009ed6000 x26: ffffff8009892b00
[  977.838391] x25: ffffffc0f7f88000 x24: ffffffc0f1cd2000
[  977.838396] x23: ffffffc0fefdfe00 x22: 0000000000000002
[  977.838400] x21: 0000000000000002 x20: ffffffc0f7f88000
[  977.838405] x19: ffffffc0f1cd2000 x18: 0000007f94f20a70
[  977.838410] x17: 0000000000021a3d x16: 0000000000000000
[  977.838414] x15: 000000000000003a x14: 0000000000022400
[  977.838419] x13: 0000000000000959 x12: ffffffc0fa7bb900
[  977.838423] x11: 000000000000000b x10: 0101010101010101
[  977.838428] x9 : fffffffffffffff9 x8 : 7f7f7f7f7f7f7f7f
[  977.838433] x7 : fefefeff646c606d x6 : 00170401e9e1acf4
[  977.838437] x5 : ffffff8008002004 x4 : 00000040f5744000
[  977.838441] x3 : 0000000000000001 x2 : 0000000000000001
[  977.838446] x1 : ffffff800a10d000 x0 : ffffffc0f1cd2148

[  977.838452] ---[ end trace aa706cb5bd510b65 ]---
[  977.843057] Call trace:
[  977.843063] [<ffffff8008ce1b48>] armpmu_start+0x70/0x78
[  977.843067] [<ffffff8008ce1e30>] cpu_pm_pmu_setup.isra.2+0x68/0xd8
[  977.843071] [<ffffff8008ce1fa0>] cpu_pm_pmu_notify+0x100/0x138
[  977.843076] [<ffffff80080dcbac>] notifier_call_chain+0x5c/0xa0
[  977.843080] [<ffffff80080dcd98>] __raw_notifier_call_chain+0x48/0x60
[  977.843085] [<ffffff80081acf84>] cpu_pm_exit+0x44/0x78
[  977.843089] [<ffffff8008ba6be0>] arm_enter_idle_state+0x80/0xc0
[  977.843092] [<ffffff8008ba45b4>] cpuidle_enter_state+0x84/0x380
[  977.843095] [<ffffff8008ba4924>] cpuidle_enter+0x34/0x48
[  977.843099] [<ffffff8008111664>] call_cpuidle+0x44/0x70
[  977.843102] [<ffffff80081119e0>] cpu_startup_entry+0x1b0/0x200
[  977.843106] [<ffffff8008091cc8>] secondary_start_kernel+0x190/0x1f8
[  977.843109] [<0000000084f841a8>] 0x84f841a8

This warning states that at line no. 199, the function armpmu_start()
is throwing a warning.

I tried checking the kernel source code. The kernel code snippet for
armpmu_start function from drivers/perf/arm_pmu file is as below:

 189 static void armpmu_start(struct perf_event *event, int flags)
 190 {
 191     struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 192     struct hw_perf_event *hwc = &event->hw;
 193
 194     /*
 195      * ARM pmu always has to reprogram the period, so ignore
 196      * PERF_EF_RELOAD, see the comment below.
 197      */
 198     if (flags & PERF_EF_RELOAD)
 199         WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
 200
 201     hwc->state = 0;
 202     /*
 203      * Set the period again. Some counters can't be stopped, so when we
 204      * were stopped we simply disabled the IRQ source and the counter
 205      * may have been left counting. If we don't do this step then we may
 206      * get an interrupt too soon or *way* too late if the overflow has
 207      * happened since disabling.
 208      */
 209     armpmu_event_set_period(event);
 210     armpmu->enable(event);
 211 }

Also when I try to remove the module with rmmod command my jetson nano
board is restarting.

Here are the few perf API's the kernel module is using:

Creating attributes structure of the perf event

 struct perf_event_attr sched_perf_hw_attr = {
        .type = PERF_TYPE_RAW,
        .config = 0x17,
        .size = sizeof (struct perf_event_attr),
        .pinned = 1,
        .disabled = 1,
        .exclude_kernel = 1,
        .sample_period = budget
        };

Creating perf event with event_overflow_callback function
     event = perf_event_create_kernel_counter (&sched_perf_hw_attr,
                                                                            cpu,

     NULL,

     event_overflow_callback,
                                                                            NULL
                                                                            );

Code to start the counter
     perf_event_enable (event);
     event->pmu->add (event, PERF_EF_START);

Code to stop the counter
     event->pmu->stop (event, PERF_EF_UPDATE);
     event->pmu->del(event,0);

In the event_overflow_callback function following activities are performed.
  *Stopping counter
          event->pmu->stop (event, PERF_EF_UPDATE);
 *Enable performance counter
          event->pmu->start (event, PERF_EF_RELOAD);

The same kernel module is working fine on Jetson Nvidia Xavier NX
without any warning messages.
Any help in diagnosing/resolving  the issue is highly appreciated.
Also, kindly provide learning resources on perf event counter programming.

Thank in advance
Danny
