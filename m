Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2785C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Aug 2021 22:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A766101A
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Aug 2021 22:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhHSW5i (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Aug 2021 18:57:38 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:37377 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhHSW5i (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Aug 2021 18:57:38 -0400
Received: by mail-lf1-f46.google.com with SMTP id k5so16305671lfu.4;
        Thu, 19 Aug 2021 15:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DtmDHm6iEeZhrRsIVkxQzbw6v5F41EdvHmd3bbIlldY=;
        b=i4LJmNBv9NjJtKxY4viacRJW8RjWKFQsP36oZblWq4q45o5wjO2IB07u0EN6bv2pT9
         0ges27/VZyiomBVV2cx6rcw3i8OfMr4p/axIcsXmFdye8lrISSF6WdFjo0s+DP+JZRy6
         zJCyNVFVKL5CP0zENGPJvqC5QgaeEbmcXKSppz7ogB7bHeDa1Guk4XL5nuJjvJ+enUGl
         NQtKk8xMu86WllNPVzbHY3CJwXxRN69Z7oJdLYQBl7RyqSLBXjTGwwbMHjwdCAAK6uzE
         PoKCSDcSQFwVSSEASOG8Tg5nphVB17ax6OOURxfcqUp6KrWIYzE5cFSA4owhrm5DJtjs
         QyFg==
X-Gm-Message-State: AOAM533wzw5xzySY/oYCXl+hzzlSfDCOhpU/ZxWYoZHnFc6nOmIsUIpl
        A90uHNJ6xdgoT4+OE2PPJ1P3Oe15Gz888sB1V/E=
X-Google-Smtp-Source: ABdhPJydnbDseVdl7+JqM9Y0azBwne+O4ApItblShrV0JaktaOxkjwbWN2yzWTR0AhFTpwkY2u7vN/66whOGIAo+j2Q=
X-Received: by 2002:a05:6512:ac9:: with SMTP id n9mr12113603lfu.635.1629413820114;
 Thu, 19 Aug 2021 15:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210817221048.88063-1-kim.phillips@amd.com> <20210817221048.88063-9-kim.phillips@amd.com>
In-Reply-To: <20210817221048.88063-9-kim.phillips@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 19 Aug 2021 15:56:48 -0700
Message-ID: <CAM9d7cgVu6YEJwF5kezonxY0vdUCizu0T2zZoBf-nGGrAt_LJw@mail.gmail.com>
Subject: Re: [PATCH 8/8] perf/x86/amd/ibs: Add bitfield definitions in new header
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Aug 17, 2021 at 3:12 PM Kim Phillips <kim.phillips@amd.com> wrote:
>
> Add arch/x86/include/asm/amd-ibs.h with bitfield definitions for
> IBS MSRs, and demonstrate usage within the driver.
>
> Also move struct perf_ibs_data where it can be shared with
> the perf tool that will soon be using it.
>
> No functional changes.
>
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Robert Richter <robert.richter@amd.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: x86@kernel.org
> ---
[SNIP]
> diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
> new file mode 100644
> index 000000000000..46e1df45efc0
> --- /dev/null
> +++ b/arch/x86/include/asm/amd-ibs.h
> @@ -0,0 +1,132 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * From PPR Vol 1 for AMD Family 19h Model 01h B1
> + * 55898 Rev 0.35 - Feb 5, 2021
> + */
> +
> +#include <asm/msr-index.h>
> +
> +/*
> + * IBS Hardware MSRs
> + */
> +
> +/* MSR 0xc0011030: IBS Fetch Control */
> +union ibs_fetch_ctl {
> +       __u64 val;
> +       struct {
> +               __u64   fetch_maxcnt:16,/* 0-15: instruction fetch max. count */
> +                       fetch_cnt:16,   /* 16-31: instruction fetch count */
> +                       fetch_lat:16,   /* 32-47: instruction fetch latency */
> +                       fetch_en:1,     /* 48: instruction fetch enable */
> +                       fetch_val:1,    /* 49: instruction fetch valid */
> +                       fetch_comp:1,   /* 50: instruction fetch complete */
> +                       ic_miss:1,      /* 51: i-cache miss */
> +                       phy_addr_valid:1,/* 52: physical address valid */
> +                       l1tlb_pgsz:2,   /* 53-54: i-cache L1TLB page size
> +                                        *        (needs IbsPhyAddrValid) */

What about adding an enum for the page size?

> +                       l1tlb_miss:1,   /* 55: i-cache fetch missed in L1TLB */
> +                       l2tlb_miss:1,   /* 56: i-cache fetch missed in L2TLB */
> +                       rand_en:1,      /* 57: random tagging enable */
> +                       fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
> +                                        *      (needs IbsFetchComp) */
> +                       reserved:5;     /* 59-63: reserved */
> +       };
> +};
> +
> +/* MSR 0xc0011033: IBS Execution Control */
> +union ibs_op_ctl {
> +       __u64 val;
> +       struct {
> +               __u64   opmaxcnt:16,    /* 0-15: periodic op max. count */
> +                       reserved0:1,    /* 16: reserved */
> +                       op_en:1,        /* 17: op sampling enable */
> +                       op_val:1,       /* 18: op sample valid */
> +                       cnt_ctl:1,      /* 19: periodic op counter control */
> +                       opmaxcnt_ext:7, /* 20-26: upper 7 bits of periodic op maximum count */
> +                       reserved1:5,    /* 27-31: reserved */
> +                       opcurcnt:27,    /* 32-58: periodic op counter current count */
> +                       reserved2:5;    /* 59-63: reserved */
> +       };
> +};
> +
> +/* MSR 0xc0011035: IBS Op Data 2 */
> +union ibs_op_data {
> +       __u64 val;
> +       struct {
> +               __u64   comp_to_ret_ctr:16,     /* 0-15: op completion to retire count */
> +                       tag_to_ret_ctr:16,      /* 15-31: op tag to retire count */
> +                       reserved1:2,            /* 32-33: reserved */
> +                       op_return:1,            /* 34: return op */
> +                       op_brn_taken:1,         /* 35: taken branch op */
> +                       op_brn_misp:1,          /* 36: mispredicted branch op */
> +                       op_brn_ret:1,           /* 37: branch op retired */
> +                       op_rip_invalid:1,       /* 38: RIP is invalid */
> +                       op_brn_fuse:1,          /* 39: fused branch op */
> +                       op_microcode:1,         /* 40: microcode op */
> +                       reserved2:23;           /* 41-63: reserved */
> +       };
> +};
> +
> +/* MSR 0xc0011036: IBS Op Data 2 */
> +union ibs_op_data2 {
> +       __u64 val;
> +       struct {
> +               __u64   data_src:3,     /* 0-2: data source */

and for data source too.

Thanks,
Namhyung


> +                       reserved0:1,    /* 3: reserved */
> +                       rmt_node:1,     /* 4: destination node */
> +                       cache_hit_st:1, /* 5: cache hit state */
> +                       reserved1:57;   /* 5-63: reserved */
> +       };
> +};
> +
> +/* MSR 0xc0011037: IBS Op Data 3 */
> +union ibs_op_data3 {
> +       __u64 val;
> +       struct {
> +               __u64   ld_op:1,                        /* 0: load op */
> +                       st_op:1,                        /* 1: store op */
> +                       dc_l1tlb_miss:1,                /* 2: data cache L1TLB miss */
> +                       dc_l2tlb_miss:1,                /* 3: data cache L2TLB hit in 2M page */
> +                       dc_l1tlb_hit_2m:1,              /* 4: data cache L1TLB hit in 2M page */
> +                       dc_l1tlb_hit_1g:1,              /* 5: data cache L1TLB hit in 1G page */
> +                       dc_l2tlb_hit_2m:1,              /* 6: data cache L2TLB hit in 2M page */
> +                       dc_miss:1,                      /* 7: data cache miss */
> +                       dc_mis_acc:1,                   /* 8: misaligned access */
> +                       reserved:4,                     /* 9-12: reserved */
> +                       dc_wc_mem_acc:1,                /* 13: write combining memory access */
> +                       dc_uc_mem_acc:1,                /* 14: uncacheable memory access */
> +                       dc_locked_op:1,                 /* 15: locked operation */
> +                       dc_miss_no_mab_alloc:1,         /* 16: DC miss with no MAB allocated */
> +                       dc_lin_addr_valid:1,            /* 17: data cache linear address valid */
> +                       dc_phy_addr_valid:1,            /* 18: data cache physical address valid */
> +                       dc_l2_tlb_hit_1g:1,             /* 19: data cache L2 hit in 1GB page */
> +                       l2_miss:1,                      /* 20: L2 cache miss */
> +                       sw_pf:1,                        /* 21: software prefetch */
> +                       op_mem_width:4,                 /* 22-25: load/store size in bytes */
> +                       op_dc_miss_open_mem_reqs:6,     /* 26-31: outstanding mem reqs on DC fill */
> +                       dc_miss_lat:16,                 /* 32-47: data cache miss latency */
> +                       tlb_refill_lat:16;              /* 48-63: L1 TLB refill latency */
> +       };
> +};
> +
> +/* MSR 0xc001103c: IBS Fetch Control Extended */
> +union ic_ibs_extd_ctl {
> +       __u64 val;
> +       struct {
> +               __u64   itlb_refill_lat:16,     /* 0-15: ITLB Refill latency for sampled fetch */
> +                       reserved:48;            /* 16-63: reserved */
> +       };
> +};
> +
> +/*
> + * IBS driver related
> + */
> +
> +struct perf_ibs_data {
> +       u32             size;
> +       union {
> +               u32     data[0];        /* data buffer starts here */
> +               u32     caps;
> +       };
> +       u64             regs[MSR_AMD64_IBS_REG_COUNT_MAX];
> +};
> --
> 2.31.1
>
