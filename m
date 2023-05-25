Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5325DC7EE29
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 11:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbjEYLkO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 07:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbjEYLjs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 07:39:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5B31AB
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 04:39:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-25566708233so1264091a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685014770; x=1687606770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PUDrtObFSBZgAV2FphIxE7ETarjCEzRZSp3iZ5qQ7xU=;
        b=LW/h5mlzeb+iWkFocmKnDCuTMkpl3bHgnWK23XTWQ0ZyICI20itwciK8Y4Y0lwUQZ2
         +68u3K/C1tGxAuOGzck/5y1xmFL8pXrvRV+nleeraz7ETUzPtZfDvVEX2g+fF6QjE0Lj
         1bnv2CDbuJWtrDN58fqRbhuPcQKV1UlisVtd+YSKSZgzptDLBjHHnSl+I/Pc+SHLHwwx
         NG4OkgNsw5GGMzJbhXDfiFQb2nhXKBUx0XgHtP18yVcntwa1dQBTBFEmWugZPbZebfhk
         Wd8D50WpybzjWRfoQnbQiUtlIQFHeNTey/IM5F5lBZESIH5pveq6ETEOVvIDive3l/zJ
         tCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685014770; x=1687606770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUDrtObFSBZgAV2FphIxE7ETarjCEzRZSp3iZ5qQ7xU=;
        b=RWEZMyoKSuC9T1KFC1dfFtovTrohC1aD2rFr5aWBtX0A2ETN1kzPq0Zy2B4jnOF//s
         OYdOovSi7HHffUZPads6x3siQfDDLMW6qquaiNegWrL9pT1to/mMsOxO+5kGBjOuEILA
         rhAwA9JG+NBdKohKOat8+6eCuAn8tWdrblUg+sQxiRoM5Hi4nmnfns8/5cvD95p/kXht
         x4aey8h0UE4dNgwpXZqyM1Ng7zJ2Z186FGs3/3kDGADDRoxtko0kVZIDU69sXdXSx8iF
         vu/bhVDajVBpFY8ntuwpiINOKQlAtBF6sCVB+m0tlQs3xfp8JhU9JHDzoyl05KiRbIK5
         XVcA==
X-Gm-Message-State: AC+VfDwzOHsZ6A3sQMmbbomyvAS3fQoLXdGXxDG5gle+seoYRSG8GVl7
        KgZ5x3mFOe068efZv8A6JuNkGEoFHH12RsmAI9ZqnQ==
X-Google-Smtp-Source: ACHHUZ4+JiqoNvQVvKNyZMGJ8vWo3Bi+H4/d5i2P/2lN35RD/4oagIbG1Q8InsP3EZCDIhydFPcwGbNiu63egbM2uhA=
X-Received: by 2002:a17:90a:7047:b0:255:ee94:df7 with SMTP id
 f65-20020a17090a704700b00255ee940df7mr1434634pjk.16.1685014769951; Thu, 25
 May 2023 04:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230524131958.2139331-1-james.clark@arm.com> <20230524131958.2139331-5-james.clark@arm.com>
In-Reply-To: <20230524131958.2139331-5-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 25 May 2023 12:39:18 +0100
Message-ID: <CAJ9a7VioqoCTLOKmPPbS9ogs9n+2sV3szn-ZSDE3+mZTEgP0UQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf cs-etm: Add exception level consistency check
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, denik@chromium.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

My concern here is that for etmv3 trace, OpenCSD will only provide
memory spaces as either secure or non-secure, The ETMv3 does not
trace, and hence OpenCSD cannot provide the different ELs.
The memory callback will be either OCSD_MEM_SPACE_S or OCSD_MEM_SPACE_N.

Can this patch - and the set handle this. (assuming perf supports our
ETMv3 coresight kernel driver)

Regards

Mike

On Wed, 24 May 2023 at 14:20, James Clark <james.clark@arm.com> wrote:
>
> Assert that our own tracking of the exception level matches what
> OpenCSD provides. OpenCSD doesn't distinguish between EL0 and EL1 in the
> memory access callback so the extra tracking was required. But a rough
> assert can still be done.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  6 +--
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  4 +-
>  tools/perf/util/cs-etm.c                      | 37 +++++++++++++------
>  3 files changed, 32 insertions(+), 15 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index ac227cd03eb0..50b3c248d1e5 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -52,15 +52,15 @@ struct cs_etm_decoder {
>  static u32
>  cs_etm_decoder__mem_access(const void *context,
>                            const ocsd_vaddr_t address,
> -                          const ocsd_mem_space_acc_t mem_space __maybe_unused,
> +                          const ocsd_mem_space_acc_t mem_space,
>                            const u8 trace_chan_id,
>                            const u32 req_size,
>                            u8 *buffer)
>  {
>         struct cs_etm_decoder *decoder = (struct cs_etm_decoder *) context;
>
> -       return decoder->mem_access(decoder->data, trace_chan_id,
> -                                  address, req_size, buffer);
> +       return decoder->mem_access(decoder->data, trace_chan_id, address,
> +                                  req_size, buffer, mem_space);
>  }
>
>  int cs_etm_decoder__add_mem_access_cb(struct cs_etm_decoder *decoder,
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 21d403f55d96..272c2efe78ee 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -11,6 +11,7 @@
>  #define INCLUDE__CS_ETM_DECODER_H__
>
>  #include <linux/types.h>
> +#include <opencsd/ocsd_if_types.h>
>  #include <stdio.h>
>
>  struct cs_etm_decoder;
> @@ -19,7 +20,8 @@ struct cs_etm_packet_queue;
>
>  struct cs_etm_queue;
>
> -typedef u32 (*cs_etm_mem_cb_type)(struct cs_etm_queue *, u8, u64, size_t, u8 *);
> +typedef u32 (*cs_etm_mem_cb_type)(struct cs_etm_queue *, u8, u64, size_t, u8 *,
> +                                 const ocsd_mem_space_acc_t);
>
>  struct cs_etmv3_trace_params {
>         u32 reg_ctrl;
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index b9ba19327f26..ccf34ed8ddf2 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -931,7 +931,8 @@ static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address,
>  }
>
>  static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
> -                             u64 address, size_t size, u8 *buffer)
> +                             u64 address, size_t size, u8 *buffer,
> +                             const ocsd_mem_space_acc_t mem_space)
>  {
>         u8  cpumode;
>         u64 offset;
> @@ -947,6 +948,20 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
>         if (!tidq)
>                 return 0;
>
> +       /*
> +        * We've already tracked EL along side the PID in cs_etm__set_thread()
> +        * so double check that it matches what OpenCSD thinks as well. It
> +        * doesn't distinguish between EL0 and EL1 for this mem access callback
> +        * so we had to do the extra tracking.
> +        */
> +       if (mem_space & OCSD_MEM_SPACE_EL1N) {
> +               /* Includes both non secure EL1 and EL0 */
> +               assert(tidq->el == ocsd_EL1 || tidq->el == ocsd_EL0);
> +       } else if (mem_space & OCSD_MEM_SPACE_EL2)
> +               assert(tidq->el == ocsd_EL2);
> +       else if (mem_space & OCSD_MEM_SPACE_EL3)
> +               assert(tidq->el == ocsd_EL3);
> +
>         cpumode = cs_etm__cpu_mode(etmq, address, tidq->el);
>
>         if (!thread__find_map(tidq->thread, cpumode, address, &al))
> @@ -1195,8 +1210,8 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
>  {
>         u8 instrBytes[2];
>
> -       cs_etm__mem_access(etmq, trace_chan_id, addr,
> -                          ARRAY_SIZE(instrBytes), instrBytes);
> +       cs_etm__mem_access(etmq, trace_chan_id, addr, ARRAY_SIZE(instrBytes),
> +                          instrBytes, 0);
>         /*
>          * T32 instruction size is indicated by bits[15:11] of the first
>          * 16-bit word of the instruction: 0b11101, 0b11110 and 0b11111
> @@ -1387,8 +1402,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
>         else
>                 sample->insn_len = 4;
>
> -       cs_etm__mem_access(etmq, trace_chan_id, sample->ip,
> -                          sample->insn_len, (void *)sample->insn);
> +       cs_etm__mem_access(etmq, trace_chan_id, sample->ip, sample->insn_len,
> +                          (void *)sample->insn, 0);
>  }
>
>  u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp)
> @@ -1940,8 +1955,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
>                  * so below only read 2 bytes as instruction size for T32.
>                  */
>                 addr = end_addr - 2;
> -               cs_etm__mem_access(etmq, trace_chan_id, addr,
> -                                  sizeof(instr16), (u8 *)&instr16);
> +               cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr16),
> +                                  (u8 *)&instr16, 0);
>                 if ((instr16 & 0xFF00) == 0xDF00)
>                         return true;
>
> @@ -1956,8 +1971,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
>                  * +---------+---------+-------------------------+
>                  */
>                 addr = end_addr - 4;
> -               cs_etm__mem_access(etmq, trace_chan_id, addr,
> -                                  sizeof(instr32), (u8 *)&instr32);
> +               cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr32),
> +                                  (u8 *)&instr32, 0);
>                 if ((instr32 & 0x0F000000) == 0x0F000000 &&
>                     (instr32 & 0xF0000000) != 0xF0000000)
>                         return true;
> @@ -1973,8 +1988,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
>                  * +-----------------------+---------+-----------+
>                  */
>                 addr = end_addr - 4;
> -               cs_etm__mem_access(etmq, trace_chan_id, addr,
> -                                  sizeof(instr32), (u8 *)&instr32);
> +               cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr32),
> +                                  (u8 *)&instr32, 0);
>                 if ((instr32 & 0xFFE0001F) == 0xd4000001)
>                         return true;
>
> --
> 2.34.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
