Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4015FC4338F
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 04:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14ABE60E74
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 04:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhHDEXI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhHDEXH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Aug 2021 00:23:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73294C0613D5
        for <linux-perf-users@vger.kernel.org>; Tue,  3 Aug 2021 21:22:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so3758859pji.5
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Aug 2021 21:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=i04VfYofLYKCIG1Z6skleSNL7OKcr09RxkFflI43t/Q=;
        b=mwMdGF9iwdQXOz5cWezZNFZBuH4MXIGpo34e3rrYRHna/vjpbhQx3tVW1NW4f261zr
         5vIvDizIhY/Jp2BgVohOgBKcU8FrOZEBkTlVmOKO7eQLyx5zRR1CabdK2wvzJs42RBqK
         2KZQsI0kHFjZ4BEgpWqgavfLQxWCBA6mHC0Ol1IiepsnsnACKXQgdXNmoNS/s/t3CzGp
         pqk6zeCviLcPHWek6b/UOGJfmXX27pHNLC/ynz5sP2cADVhpyKbCqbO2mSKF6nfWdtMp
         B2fYxmee1mJGwZJUGQApJF10lhozDLK7uiI8UopN1RVr2VxE0imPvvXO+/8gLfJwzh/q
         N/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=i04VfYofLYKCIG1Z6skleSNL7OKcr09RxkFflI43t/Q=;
        b=Cx91mCJ6K5AI3wiQVFYbXP19Z7041qXaZTPaNoK5C0U9aW+alBKJGrpRFAGvPjMM98
         b1W0pzSes38KaYd3GYRU5rjeBGFsdUFz+lqBqislj2C4P+oE3HspOHqT4kkKjBCXoMBc
         VCLHMw1nTaZIiTnzxlcPD7Um4drRbLCN9TJIbqimuLptemzoR43McemlN69MqGs3Uxy/
         zCCawt0YgfwjgkiqeuvJW2MbxLu5JZCzSI2dksZpGoblcMPxYmybnZSwl9f5qjtIxLK3
         XzVy6mgmMgstLeJfjh2fkfoRBaE1fL3fy3D+lLhL/tCZ5gWZ7Iq2Auhi31WAFuT2fuiL
         QaSw==
X-Gm-Message-State: AOAM530JRXN5e8xcyD0OHQOoiVxNWRMagR4VuFtnLs0zfYQdBiSTqdbv
        3lHY0NbuAOJyJIG90bsK6wyhYg==
X-Google-Smtp-Source: ABdhPJz2rvddHcEo28ed9rl2wL1JFcrDn7cljKcQ4AfRhN3PpF0qgvY/h2xt6pHPI7PasNsMKcBtSA==
X-Received: by 2002:a62:e714:0:b029:3c4:8544:b2b7 with SMTP id s20-20020a62e7140000b02903c48544b2b7mr4265679pfh.5.1628050974761;
        Tue, 03 Aug 2021 21:22:54 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q2sm816324pfu.205.2021.08.03.21.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:22:54 -0700 (PDT)
Date:   Tue, 03 Aug 2021 21:22:54 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Aug 2021 21:22:49 PDT (-0700)
Subject:     Re: [PATCH 1/4] tools/perf/arch/riscv: record registers needed for --call-graph=dwarf
In-Reply-To: <20210705232524.4024832-2-edwin@etorok.net>
CC:     linux-riscv@lists.infradead.org, edwin@etorok.net,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        jolsa@redhat.com, namhyung@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-perf-users@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     edwin@etorok.net
Message-ID: <mhng-3ff979c8-3e24-48a4-8a22-8aa3f14f42ac@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, 05 Jul 2021 16:25:21 PDT (-0700), edwin@etorok.net wrote:
> For libdw-based callgraph sampling to work we need to sample registers.
>
> Tested on HiFive Unmatched with a trunk version of OCaml:

These generally LGTM, but I don't have patch #2.  Sometimes that means 
they're just not targeted at the RISC-V tree, which is fine with me but 
I'm happy to take some time to look closer and take them if that's what 
you're looking for.

A cover letter can be a good bet, to describe this sort of stuff.

> ```
>  # perf record --user-regs=?
> available registers: pc ra sp gp tp t0 t1 t2 s0 s1 a0 a1 a2 a3 a4 a5 a6 a7
>  s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 t3 t4 t5 t6
>
>  # sed -e 's/(\*\*//' -e 's/\*\*)//' \
> testsuite/tests/misc-unsafe/almabench.ml >almabench_benchmark.ml
>  # ocamlopt almabench_benchmark.ml -unsafe -o almabench_benchmark
>  # perf record -e cpu-clock -v --call-graph=dwarf -F 99 \
> ./almabench_benchmark
>
> callchain: type DWARF
> callchain: stack dump size 8192
> nr_cblocks: 0
> affinity: SYS
> mmap flush: 1
> comp level: 0
> mmap size 528384B
> mmap size 528384B
> Control descriptor is not initialized
> 0 17.00 -26.06
> 1 12.34 1.29
> 2 6.83 22.95
> 3 0.04 -1.26
> 4 2.30 12.54
> 5 2.93 14.35
> 6 21.27 -16.57
> 7 20.41 -19.04
> [ perf record: Woken up 65 times to write data ]
> Looking at the vmlinux_path (8 entries long)
> Failed to open /proc/kcore.
> Note /proc/kcore requires CAP_SYS_RAWIO capability to access.
> Using /proc/kallsyms for symbols
> failed to write feature CPUDESC
> failed to write feature CPUID
> failed to write feature NUMA_TOPOLOGY
> failed to write feature MEM_TOPOLOGY
> [ perf record: Captured and wrote 16.265 MB perf.data (1997 samples) ]
>
>  # perf script
> ...
> almabench_bench  1193 14816.399235:   10101010 cpu-clock:
>  3fbbd63d54 reduce_sincos+0x268 (inlined)
>  3fbbd63d54 __cos+0x268 (/lib/libm-2.33.so)
>  2aac4b261b Almabench_benchmark.planetpv+0x25f
>     (/home/root/ocaml/almabench_benchmark)
>  2aac4b3e03 Almabench_benchmark.entry+0x12bb
>     (/home/root/ocaml/almabench_benchmark)
>  2aac4b0097 caml_program+0x143
>     (/home/root/ocaml/almabench_benchmark)
>  2aac4e4e3d caml_start_program+0x71
>     (/home/root/ocaml/almabench_benchmark)
>  2aac4e5409 caml_startup_common+0x18f
>     (/home/root/ocaml/almabench_benchmark)
>  2aac4e5465 caml_startup_exn+0x9 (inlined)
>  2aac4e5465 caml_startup+0x9 (inlined)
>  2aac4e5465 caml_main+0x9
>     (/home/root/ocaml/almabench_benchmark)
>  2aac4afe89 main+0x9
>     (/home/root/ocaml/almabench_benchmark)
>  3fbbc47b0b __libc_start_main+0x85 (/lib/libc-2.33.so)
>  2aac4afebb _start+0x2b (/home/root/ocaml/almabench_benchmark)
> ```
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Edwin Török <edwin@etorok.net>
> ---
>  tools/perf/arch/riscv/util/perf_regs.c | 32 ++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/tools/perf/arch/riscv/util/perf_regs.c b/tools/perf/arch/riscv/util/perf_regs.c
> index 2864e2e3776d..8c9f511e8322 100644
> --- a/tools/perf/arch/riscv/util/perf_regs.c
> +++ b/tools/perf/arch/riscv/util/perf_regs.c
> @@ -2,5 +2,37 @@
>  #include "../../util/perf_regs.h"
>
>  const struct sample_reg sample_reg_masks[] = {
> +	SMPL_REG(pc, PERF_REG_RISCV_PC),
> +	SMPL_REG(ra, PERF_REG_RISCV_RA),
> +	SMPL_REG(sp, PERF_REG_RISCV_SP),
> +	SMPL_REG(gp, PERF_REG_RISCV_GP),
> +	SMPL_REG(tp, PERF_REG_RISCV_TP),
> +	SMPL_REG(t0, PERF_REG_RISCV_T0),
> +	SMPL_REG(t1, PERF_REG_RISCV_T1),
> +	SMPL_REG(t2, PERF_REG_RISCV_T2),
> +	SMPL_REG(s0, PERF_REG_RISCV_S0),
> +	SMPL_REG(s1, PERF_REG_RISCV_S1),
> +	SMPL_REG(a0, PERF_REG_RISCV_A0),
> +	SMPL_REG(a1, PERF_REG_RISCV_A1),
> +	SMPL_REG(a2, PERF_REG_RISCV_A2),
> +	SMPL_REG(a3, PERF_REG_RISCV_A3),
> +	SMPL_REG(a4, PERF_REG_RISCV_A4),
> +	SMPL_REG(a5, PERF_REG_RISCV_A5),
> +	SMPL_REG(a6, PERF_REG_RISCV_A6),
> +	SMPL_REG(a7, PERF_REG_RISCV_A7),
> +	SMPL_REG(s2, PERF_REG_RISCV_S2),
> +	SMPL_REG(s3, PERF_REG_RISCV_S3),
> +	SMPL_REG(s4, PERF_REG_RISCV_S4),
> +	SMPL_REG(s5, PERF_REG_RISCV_S5),
> +	SMPL_REG(s6, PERF_REG_RISCV_S6),
> +	SMPL_REG(s7, PERF_REG_RISCV_S7),
> +	SMPL_REG(s8, PERF_REG_RISCV_S8),
> +	SMPL_REG(s9, PERF_REG_RISCV_S9),
> +	SMPL_REG(s10, PERF_REG_RISCV_S10),
> +	SMPL_REG(s11, PERF_REG_RISCV_S11),
> +	SMPL_REG(t3, PERF_REG_RISCV_T3),
> +	SMPL_REG(t4, PERF_REG_RISCV_T4),
> +	SMPL_REG(t5, PERF_REG_RISCV_T5),
> +	SMPL_REG(t6, PERF_REG_RISCV_T6),
>  	SMPL_REG_END
>  };
