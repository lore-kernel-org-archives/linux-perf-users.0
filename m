Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317F0C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 May 2022 23:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbiESXra (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 May 2022 19:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343775AbiESXr0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 May 2022 19:47:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BFC12816C
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 16:47:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k30so9317401wrd.5
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 16:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vPK8wc5zOViATG719VftJnzHbV2j0aW5K7wg+jNhWKg=;
        b=OdTy66Ta0QHJB+ttCi1/JPIkXvmMd0vhCIQ/Y+olgbATvohhIHce9pTkcPFmEIjBgi
         rG0EpbkafRrQxR+IpgVGJCdwT28vMWH8Q+bgHrM2Em37cstckNvzMCGPX5JdnuWKiHnP
         1wxMo5t2VXOtJ9ebhkbD4eNEhko5ff6LRSzxKydfhM9e7+LccjcSC4R0lcHPfACMk3/L
         pOZ3n5im9bhtuLdCTdITtRg/GmqTDqCKCjvJG9/w+IfAqULdrWcc8xYQ4RaLHRhMcSLC
         qsu5xu1YE1h30qil90iTs8mwg2cROF8Znq0QRM7czHE5JCExUdAedWZj4ak9N91veuE4
         m9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPK8wc5zOViATG719VftJnzHbV2j0aW5K7wg+jNhWKg=;
        b=iKsgDzhN5lN4WTiiC4I601+n85Z4kVxJAOApgNX3rGNRrf4INMKUsAv1ByLqqWtCsi
         9qYBn1mNhD9gWw/bqmK6cnPwVZWAasrPquMPjfux4YhjuYcrJhashY6STjNvtoC+cTp7
         x83h0OnvNhz2AdX7EG3rVYbhznN1sXsAK/jkE4FvsjsNjBXrDacHBg/BYU628r+kGbd4
         5m4tP4SxISNXoScFhrOKlOUlvREFXJq+PKIewce7Lw8bxS+3L+gpu8/PKratHGjqxw1W
         rghoRSeVE2jfxcWKdu0KHq2ugJJJb4PQz7n6BBFvnX+/zHr6HCYcAiitQLo3wzUE/WTd
         TPJw==
X-Gm-Message-State: AOAM530bNHBpJLLOxFfgZfoCn1uCxynZJyQ7su08TyPvT13tnF7p2r/l
        Bb0VX0iJRcifqby/YQpbMRFrZVu1ZkpqR2S7Nd54XA==
X-Google-Smtp-Source: ABdhPJyUKCEf/GzuZtEA40j66mf5zlFXj4Y7JyuPq42sGiR2I6swgRotPczVvOhouaUPQ0E49qHLBPnNGKySLYXFXmI=
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id
 n15-20020a5d598f000000b0020c83c9b05bmr5990109wri.343.1653004041339; Thu, 19
 May 2022 16:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220519054355.477-1-ravi.bangoria@amd.com> <20220519054355.477-4-ravi.bangoria@amd.com>
In-Reply-To: <20220519054355.477-4-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 May 2022 16:47:07 -0700
Message-ID: <CAP-5=fWY+e-HrXmWMAqgucWmVgRBv0F=2NSkSkLgX4CRDYjupg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] perf/x86/ibs: Add new IBS register bits into header
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

On Wed, May 18, 2022 at 10:45 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> IBS support has been enhanced with two new features in upcoming uarch:
> 1. DataSrc extension and 2. L3 miss filtering. Additional set of bits
> has been introduced in IBS registers to exploit these features. Define
> these new bits into arch/x86/ header.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/include/asm/amd-ibs.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
> index aabdbb5ab920..f3eb098d63d4 100644
> --- a/arch/x86/include/asm/amd-ibs.h
> +++ b/arch/x86/include/asm/amd-ibs.h
> @@ -29,7 +29,10 @@ union ibs_fetch_ctl {
>                         rand_en:1,      /* 57: random tagging enable */
>                         fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
>                                          *      (needs IbsFetchComp) */
> -                       reserved:5;     /* 59-63: reserved */
> +                       l3_miss_only:1, /* 59: Collect L3 miss samples only */
> +                       fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
> +                       fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
> +                       reserved:2;     /* 62-63: reserved */
>         };
>  };
>
> @@ -38,14 +41,14 @@ union ibs_op_ctl {
>         __u64 val;
>         struct {
>                 __u64   opmaxcnt:16,    /* 0-15: periodic op max. count */
> -                       reserved0:1,    /* 16: reserved */
> +                       l3_miss_only:1, /* 16: Collect L3 miss samples only */
>                         op_en:1,        /* 17: op sampling enable */
>                         op_val:1,       /* 18: op sample valid */
>                         cnt_ctl:1,      /* 19: periodic op counter control */
>                         opmaxcnt_ext:7, /* 20-26: upper 7 bits of periodic op maximum count */
> -                       reserved1:5,    /* 27-31: reserved */
> +                       reserved0:5,    /* 27-31: reserved */
>                         opcurcnt:27,    /* 32-58: periodic op counter current count */
> -                       reserved2:5;    /* 59-63: reserved */
> +                       reserved1:5;    /* 59-63: reserved */
>         };
>  };
>
> @@ -71,11 +74,12 @@ union ibs_op_data {
>  union ibs_op_data2 {
>         __u64 val;
>         struct {
> -               __u64   data_src:3,     /* 0-2: data source */
> +               __u64   data_src_lo:3,  /* 0-2: data source low */
>                         reserved0:1,    /* 3: reserved */
>                         rmt_node:1,     /* 4: destination node */
>                         cache_hit_st:1, /* 5: cache hit state */
> -                       reserved1:57;   /* 5-63: reserved */
> +                       data_src_hi:2,  /* 6-7: data source high */
> +                       reserved1:56;   /* 8-63: reserved */
>         };
>  };
>
> --
> 2.27.0
>
