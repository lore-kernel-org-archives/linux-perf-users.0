Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AED6C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 May 2022 04:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345191AbiETEdO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 May 2022 00:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343776AbiETEdM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 May 2022 00:33:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C3D57B0B
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 21:33:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h5so8695827wrb.11
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 21:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsigNR0JuNP0YckuzKTpyGQC2LiAaAhgt7nwjSQGL9k=;
        b=E8A1+g3llC9kBUKWpwAhB8u88qU0ljnfEM4sdhpzYmj2MgLkAjxtJvteY6s0viYl9q
         88ciBlHOOT0VrhRRakDRXCWuGGqyCYQxcCJ7cfRm93VGtfV+jP13SGi88DFU/quSO5g1
         XDVjgfr8Y4yC/0CrJ8f2py5ZwtJjh6QkyQphbuvgBdxEvkjQ4TzCB3uwIJDd7oOm69Y6
         280it63mC/SBEz3GafoHn7C8tyx5U9Y99232FJ10iErE8MXhslAUOxbhd7qWOp1bTKFv
         WKWeBKvPASjnh6rR1eg4Qqwq91S1JUZkLS+wbD2S1kVUVz/HML3PxdzmC4v8HLovgDRr
         du8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsigNR0JuNP0YckuzKTpyGQC2LiAaAhgt7nwjSQGL9k=;
        b=zrWoKLmiEf+yCE9Al/Jvu6HXmuWLc8a8M/PsdbUWa7YNyk2LEKFWb0i5Q2Q7wykibd
         RrTdPOekKYRnW7+9zLbfz+u+yCWf+cS8CdOjZ2I+2/K+ADBwyKSEV3C51g5uDmIsVHBf
         i05G7NAHKWMxbYgriukScUmrslNW7+tsfeLsF5cM53mYC2htxL54IuTdlIZQ1IYoARYw
         jh7eaFD69iI94BAGxaJpQQMRJslW+W/rRHwaQrmJ7B5o6sCynJd6247M2YZlpyBSb8Ey
         x6pK64cisHOtbH/ugkfM+IM62SrMlT17IUNqA03eTFBcrQhanK5YwZFHp2xbwtJKBDLI
         BuvA==
X-Gm-Message-State: AOAM533Z1D9NFizOxkiF9NQaR3zTlhz6vvu8n03ZHLWqtpB583wTdJNO
        xq10TH1vJ4YToC8MsW8Wq2hWBJzklXTmSEtjaRA7Xw==
X-Google-Smtp-Source: ABdhPJyJXfWp+3Nh59Q/OMnZlUA34UVQ/S/iPX6RmguFYtqgoOLSKfPUkcRFmR5+JULHS3GX7r9AkQx2DF0JqPM03aI=
X-Received: by 2002:adf:e70e:0:b0:20e:7523:f01d with SMTP id
 c14-20020adfe70e000000b0020e7523f01dmr2332987wrm.300.1653021186777; Thu, 19
 May 2022 21:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220519054355.477-1-ravi.bangoria@amd.com> <20220519054355.477-5-ravi.bangoria@amd.com>
 <CAP-5=fU5ArsMcTiYNgZ1U+i6mmtdc+OGx9_ny0x46+O7d4+dpQ@mail.gmail.com> <8b0fc830-a0f6-c2ca-a493-011a46dc190d@amd.com>
In-Reply-To: <8b0fc830-a0f6-c2ca-a493-011a46dc190d@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 May 2022 21:32:54 -0700
Message-ID: <CAP-5=fWiG4oZbZqFTuWbdYDPnD3mgOTK3vMvS=y-Y6qT4_5nEg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] perf tool ibs: Sync amd ibs header file
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, peterz@infradead.org, rrichter@amd.com,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 19, 2022 at 8:56 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Hi Ian,
>
> On 20-May-22 5:18 AM, Ian Rogers wrote:
> > On Wed, May 18, 2022 at 10:45 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >>
> >> IBS support has been enhanced with two new features in upcoming uarch:
> >> 1. DataSrc extension and 2. L3 miss filtering. Additional set of bits
> >> has been introduced in IBS registers to exploit these features.
> >> New bits are already defining in arch/x86/ header. Sync it with tools
> >> header file.
> >>
> >> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> >> ---
> >>  tools/arch/x86/include/asm/amd-ibs.h | 16 ++++++++++------
> >>  tools/perf/util/amd-sample-raw.c     |  4 ++--
> >>  2 files changed, 12 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
> >> index 765e9e752d03..9a3312e12e2e 100644
> >> --- a/tools/arch/x86/include/asm/amd-ibs.h
> >> +++ b/tools/arch/x86/include/asm/amd-ibs.h
> >> @@ -29,7 +29,10 @@ union ibs_fetch_ctl {
> >>                         rand_en:1,      /* 57: random tagging enable */
> >>                         fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
> >>                                          *      (needs IbsFetchComp) */
> >> -                       reserved:5;     /* 59-63: reserved */
> >> +                       l3_miss_only:1, /* 59: Collect L3 miss samples only */
> >> +                       fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
> >> +                       fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
> >> +                       reserved:2;     /* 62-63: reserved */
> >>         };
> >>  };
> >>
> >> @@ -38,14 +41,14 @@ union ibs_op_ctl {
> >>         __u64 val;
> >>         struct {
> >>                 __u64   opmaxcnt:16,    /* 0-15: periodic op max. count */
> >> -                       reserved0:1,    /* 16: reserved */
> >> +                       l3_miss_only:1, /* 16: Collect L3 miss samples only */
> >>                         op_en:1,        /* 17: op sampling enable */
> >>                         op_val:1,       /* 18: op sample valid */
> >>                         cnt_ctl:1,      /* 19: periodic op counter control */
> >>                         opmaxcnt_ext:7, /* 20-26: upper 7 bits of periodic op maximum count */
> >> -                       reserved1:5,    /* 27-31: reserved */
> >> +                       reserved0:5,    /* 27-31: reserved */
> >>                         opcurcnt:27,    /* 32-58: periodic op counter current count */
> >> -                       reserved2:5;    /* 59-63: reserved */
> >> +                       reserved1:5;    /* 59-63: reserved */
> >>         };
> >>  };
> >>
> >> @@ -71,11 +74,12 @@ union ibs_op_data {
> >>  union ibs_op_data2 {
> >>         __u64 val;
> >>         struct {
> >> -               __u64   data_src:3,     /* 0-2: data source */
> >> +               __u64   data_src_lo:3,  /* 0-2: data source low */
> >>                         reserved0:1,    /* 3: reserved */
> >>                         rmt_node:1,     /* 4: destination node */
> >>                         cache_hit_st:1, /* 5: cache hit state */
> >> -                       reserved1:57;   /* 5-63: reserved */
> >> +                       data_src_hi:2,  /* 6-7: data source high */
> >> +                       reserved1:56;   /* 8-63: reserved */
> >>         };
> >>  };
> >>
> >> diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
> >> index d19d765195c5..3b623ea6ee7e 100644
> >> --- a/tools/perf/util/amd-sample-raw.c
> >> +++ b/tools/perf/util/amd-sample-raw.c
> >
> > nit: given the commit message this should probably be a separate patch.
>
> Renaming of an existing field in only header file creates a build issue.
> So I had to include it in this patch. Would documenting it in the patch
> description help?
>
>   Also rename existing ibs_op_data field "data_src" to "data_src_lo".
>
> Thanks for the review,
> Ravi

Perfect fix. Thanks!
Ian

> >
> > Thanks,
> > Ian
> >
> >> @@ -98,9 +98,9 @@ static void pr_ibs_op_data2(union ibs_op_data2 reg)
> >>         };
> >>
> >>         printf("ibs_op_data2:\t%016llx %sRmtNode %d%s\n", reg.val,
> >> -              reg.data_src == 2 ? (reg.cache_hit_st ? "CacheHitSt 1=O-State "
> >> +              reg.data_src_lo == 2 ? (reg.cache_hit_st ? "CacheHitSt 1=O-State "
> >>                                                      : "CacheHitSt 0=M-state ") : "",
> >> -              reg.rmt_node, data_src_str[reg.data_src]);
> >> +              reg.rmt_node, data_src_str[reg.data_src_lo]);
> >>  }
> >>
> >>  static void pr_ibs_op_data3(union ibs_op_data3 reg)
> >> --
> >> 2.27.0
> >>
