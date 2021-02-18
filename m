Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47A4C433E0
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Feb 2021 02:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8FA64E45
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Feb 2021 02:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhBRCGD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Feb 2021 21:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhBRCGD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Feb 2021 21:06:03 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9561C061756
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Feb 2021 18:05:22 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d24so1905612lfs.8
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Feb 2021 18:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRqnyo0A/Ngb0B9utqQ0v5uQIkO9iM7mTad/b3vka3o=;
        b=UqMFwr3Tl05UchPAb3NOYalbORNF0wYrty40/FRdB7CZkN5BmfKhuNDkPBQXRalaMm
         aqmCIsAJG83joj1/altr+r9eUESiNEXOl7I10PcecXF6vUn+0e2bf2bKttbXaURlenrs
         63BiruZUpUT0fhJOjcD67bAG8cW3XWBfET7Th/zoqbEIAvJy7w2S4c7+SotPPw4jhaEV
         P0iMhBZPm1AsXpGaLEg40Tti6nCD/f3bpwcVliuxkvubBQPZvmm5d41NebvR2tJmcr9W
         CjUKNgFUBAmAo6Pxq7+u9ey/FwpVYF6wj+b4DKf8wodu8YgtbLWETuXh9x1oZwaeSFXC
         aJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRqnyo0A/Ngb0B9utqQ0v5uQIkO9iM7mTad/b3vka3o=;
        b=SrFC1X+WE73gOWJPvYn12RVCiFXYfPfn+YCWcfnavin8MWqLiP1f33u+e5QFByoiuZ
         gM887CUW586h5VCZRMOiZMLnNAGOt3YDLlDkjdnwyzxyb+xRd/bvp54o2W3zmGB50YOE
         UAHniqd0ECzUxJXq0HY55MsPH9dVKBQUP7bazvBWtSXAjZYZ/kLgAK25gLDleYEepKj/
         fCO4OwVeRIkXy69zTYpBwCyyuggypnWvCXirvIaeQErQem3VUjBbJizti6GgHIQ01ERc
         PcHDdaYL7EGpoMeTI9pjJNTM+pmPECL+zbOpJ9Bz2ooqXwN9zrT0Iu/HwrP/oo6ha1Fp
         l0rA==
X-Gm-Message-State: AOAM530WkP63bMmpvayoC8h6yUvXrgVju185eKrHWNChUSDjQ0EcHGHB
        eHn9b3G+Sg/4eisRVdXN9IXEFDsao661ta4qoULWOO2BqtsXvcLY
X-Google-Smtp-Source: ABdhPJzwOy0Y1TyOdOGku9OTu2TwfmGr67O5CDDx4qvxtHwiqR+b61ETbmRKCscr024r/OH38zkSxF1X1Ad2QCAZ9z8=
X-Received: by 2002:a19:4043:: with SMTP id n64mr1014191lfa.47.1613613921273;
 Wed, 17 Feb 2021 18:05:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHb-xavRszhCbGcs0DgrdoJCHmOznHC4UzhLXxtXz=gXXk+wMQ@mail.gmail.com>
 <CAM9d7cg2qfQcNkH__XL8HUPSfsFqSwnYUXWCJZQLr06dip9RCw@mail.gmail.com>
In-Reply-To: <CAM9d7cg2qfQcNkH__XL8HUPSfsFqSwnYUXWCJZQLr06dip9RCw@mail.gmail.com>
From:   rainkin <rainkin1993@gmail.com>
Date:   Thu, 18 Feb 2021 10:04:45 +0800
Message-ID: <CAHb-xau-HhbuLL0aKyzmHjCixETcMNV7xGxGj_bBYoSVQd_R2w@mail.gmail.com>
Subject: Re: [Question] How to sample PERF_TYPE_HARDWARE
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Namhyung,
Thanks for your reply.
Let me make my goal more clear: record the number of occurring branch
instructions (PERF_COUNT_HW_BRANCH_INSTRUCTIONS) every N cycles
(PERF_COUNT_HW_CPU_CYCLES).

For the command you mentioned : perf record -e branches -c N

I use strace to capture the syscall invoked by the above command:

perf_event_open({type=PERF_TYPE_HARDWARE, size=PERF_ATTR_SIZE_VER6,
config=PERF_COUNT_HW_BRANCH_INSTRUCTIONS, sample_period=100000,
sample_type=PERF_SAMPLE_IP|PERF_SAMPLE_TID|PERF_SAMPLE_TIME|PERF_SAMPLE_ID|PERF_SAMPLE_CPU,
read_format=PERF_FORMAT_ID, disabled=1, inherit=1, pinned=0,
exclusive=0, exclusive_user=0, exclude_kernel=0, exclude_hv=0,
exclude_idle=0, mmap=0, comm=0, freq=0, inherit_stat=0,
enable_on_exec=0, task=0, watermark=0, precise_ip=0 /* arbitrary skid
*/, mmap_data=0, sample_id_all=1, exclude_host=0, exclude_guest=1,
exclude_callchain_kernel=0, exclude_callchain_user=0, mmap2=0,
comm_exec=0, use_clockid=0, context_switch=0, write_backward=0,
namespaces=0, wakeup_events=0, config1=0, config2=0,
sample_regs_user=0, sample_regs_intr=0, aux_watermark=0,
sample_max_stack=0, aux_sample_size=0}, -1, 10, -1,
PERF_FLAG_FD_CLOEXEC)

In my understanding ,WHAT this command actually does is recording
IP,TID, and so on
(sample_type=PERF_SAMPLE_IP|PERF_SAMPLE_TID|PERF_SAMPLE_TIME|PERF_SAMPLE_ID|PERF_SAMPLE_CPU)
every N (here N = 100000) branches
(config=PERF_COUNT_HW_BRANCH_INSTRUCTIONS). Thus this cannot meet my
goal.

Thanks,
Rainkin
