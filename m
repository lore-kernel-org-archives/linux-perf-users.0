Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39801C43334
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jul 2022 17:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiGSRpx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jul 2022 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiGSRpw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jul 2022 13:45:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249095F4F;
        Tue, 19 Jul 2022 10:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3F68B81CAD;
        Tue, 19 Jul 2022 17:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFADC341CE;
        Tue, 19 Jul 2022 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658252748;
        bh=Iu6171Ov6tYWeYfqKo856Ob0jccBWrdUq3RrbhohZE8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZQrQAXo9l6LBE4PHnnev44PDyHcEAHqL3E87JR/Qm3FBDvy3nb0b9JK+R27gPnZR+
         zU/Yyt8+jd2SG9TrND6bXGTI2Jz/XjWJVdQzTGjNikmWQxD0QAteh0GL3DRd662arZ
         WzhAbOU5co0FxDUQYs3XT4e57G54v+EERL/MI43YksefjDxgFNSdp+FR6TlP4Wy1a1
         1t0R6iUoEHxmDA3zudqPbNOeL9sPwoSR+PYeUCtbo/VftPBFuq4isrxBOwl7BVro0m
         Ueunjy3A8XKm23dLShoVZWf1GIxoivzQlUdQwW2skenuKRReYGr4jD4umrUdIu6ugE
         aStqsi5oH69UQ==
Received: by mail-vs1-f51.google.com with SMTP id l190so14152131vsc.0;
        Tue, 19 Jul 2022 10:45:48 -0700 (PDT)
X-Gm-Message-State: AJIora+SHcdg9XwNjWMODMjHYC934SOBM7ATgI7su8EG9JPTFXI5n+Yi
        zUVuvVibm1qqDlLqAuv0yfOjUuNGxtEUWC7C0w==
X-Google-Smtp-Source: AGRyM1smPKbVUPDamU+9pu2gLgpmWL2emgLBBBluGP/BWT6sdCHvb0oahmRWmRUrwpPCbIKgh7HQr37S9uuYKLLAUFQ=
X-Received: by 2002:a67:c088:0:b0:358:bb1:fdf7 with SMTP id
 x8-20020a67c088000000b003580bb1fdf7mr1192720vsi.85.1658252747373; Tue, 19 Jul
 2022 10:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220609052355.1300162-1-irogers@google.com> <20220609052355.1300162-3-irogers@google.com>
In-Reply-To: <20220609052355.1300162-3-irogers@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Jul 2022 11:45:35 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+RSv2_VLdH2bum31cwM3pJuySi4_FhqB4=2vDOHqCdMA@mail.gmail.com>
Message-ID: <CAL_Jsq+RSv2_VLdH2bum31cwM3pJuySi4_FhqB4=2vDOHqCdMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf: Align user space counter reading with code
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 8, 2022 at 11:24 PM Ian Rogers <irogers@google.com> wrote:
>
> Align the user space counter reading documentation with the code in
> perf_mmap__read_self. Previously the documentation was based on the perf
> rdpmc test, but now general purpose code is provided by libperf.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/uapi/linux/perf_event.h       | 32 ++++++++++++++++-----------
>  tools/include/uapi/linux/perf_event.h | 32 ++++++++++++++++-----------
>  2 files changed, 38 insertions(+), 26 deletions(-)
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index d37629dbad72..3b84e0ad0723 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -538,9 +538,13 @@ struct perf_event_mmap_page {
>          *
>          *     if (pc->cap_usr_time && enabled != running) {
>          *       cyc = rdtsc();
> -        *       time_offset = pc->time_offset;
>          *       time_mult   = pc->time_mult;
>          *       time_shift  = pc->time_shift;
> +        *       time_offset = pc->time_offset;
> +        *       if (pc->cap_user_time_short) {
> +        *         time_cycles = pc->time_cycles;
> +        *         time_mask = pc->time_mask;
> +        *       }
>          *     }
>          *
>          *     index = pc->index;
> @@ -548,6 +552,9 @@ struct perf_event_mmap_page {
>          *     if (pc->cap_user_rdpmc && index) {
>          *       width = pc->pmc_width;
>          *       pmc = rdpmc(index - 1);
> +        *       pmc <<= 64 - width;
> +        *       pmc >>= 64 - width;
> +        *       count += pmc;
>          *     }
>          *
>          *     barrier();
> @@ -590,25 +597,24 @@ struct perf_event_mmap_page {
>          * If cap_usr_time the below fields can be used to compute the time
>          * delta since time_enabled (in ns) using rdtsc or similar.
>          *
> -        *   u64 quot, rem;
> -        *   u64 delta;
> -        *
> -        *   quot = (cyc >> time_shift);
> -        *   rem = cyc & (((u64)1 << time_shift) - 1);
> -        *   delta = time_offset + quot * time_mult +
> -        *              ((rem * time_mult) >> time_shift);
> +        *   cyc = time_cycles + ((cyc - time_cycles) & time_mask);
> +        *   delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);

I still think this chunk should stay as-is because mul_u64_u32_shr
isn't defined here. At least a comment as to what the C version does:

/* time_offset + (u64)(((unsigned __int128)cyc * time_mult) >> time_shift) */

>          *
>          * Where time_offset,time_mult,time_shift and cyc are read in the
>          * seqcount loop described above. This delta can then be added to
> -        * enabled and possible running (if index), improving the scaling:
> +        * enabled and possible running (if index) to improve the scaling. Due
> +        * to event multiplexing, running maybe zero and so care is needed to

s/maybe/may be/

> +        * avoid division by zero.
>          *
>          *   enabled += delta;
> -        *   if (index)
> +        *   if (idx)

This should remain 'index'.

>          *     running += delta;
>          *
> -        *   quot = count / running;
> -        *   rem  = count % running;
> -        *   count = quot * enabled + (rem * enabled) / running;
> +        *   if (running != 0) {
> +        *     quot = count / running;
> +        *     rem  = count % running;
> +        *     count = quot * enabled + (rem * enabled) / running;
> +        *   }
>          */
>         __u16   time_shift;
>         __u32   time_mult;
