Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51344C4708F
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 13:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B4B613B4
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 13:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhFANKW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 09:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233409AbhFANKV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 09:10:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D83B6136E;
        Tue,  1 Jun 2021 13:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622552920;
        bh=F5l3pFKtESBtIzN5XEefSEsjZDV84ZcGAOVvlKQ6dD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2yGYPumXx1S7rpQuwiaxT4yo/Q4hMAa39ejN1WjdV07gw2vU+i2/5fYsEZiBOvzU
         vEypnZigDti/wBgL29ASBANLjfb/eOUT8vTV3Eub3WAnQoI0E7NBExhcEdLNhdUrWW
         hyJ/UQrl+0vdhpRWBUKYj/xMc380s5pT6CeuyzmLC+0JL6WrVqzXwDyM/7MUgMF1bG
         3jDuvwGZX0/5DxhjOAJGGm37ZZrrWMtyT6xLrN+KfWjNieL7vbafmjbnTXvj5cTU1W
         9GG7dQafz4rWNFir/Ho4Jf+5VE6k2iTCXP0LFAf8vr2t8P0Z77ji5xKhbVHiCUzl/O
         aZ8IZ6Dw5/6ZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 37C3D4011C; Tue,  1 Jun 2021 10:08:37 -0300 (-03)
Date:   Tue, 1 Jun 2021 10:08:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] perf tools: Copy uapi/asm/perf_regs.h from the kernel
 for MIPS
Message-ID: <YLYxVXevS2kL4EVK@kernel.org>
References: <1622548436-12472-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622548436-12472-1-git-send-email-yangtiezhu@loongson.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jun 01, 2021 at 07:53:56PM +0800, Tiezhu Yang escreveu:
> To allow the build to complete on older systems, where those files are
> either not uptodate, lacking some recent additions or not present at
> all.
> 
> And check if the copy drifts from the kernel.
> 
> This commit is similar with
> commit 12f020338a2c ("tools: Copy uapi/asm/perf_regs.h from the kernel")
> 
> With this commit, we can avoid the following build error in any case:
> 
> tools/perf/arch/mips/include/perf_regs.h:7:10:
> fatal error: asm/perf_regs.h: No such file or directory
>  #include <asm/perf_regs.h>
>           ^~~~~~~~~~~~~~~~~
> compilation terminated.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/arch/mips/include/uapi/asm/perf_regs.h | 40 ++++++++++++++++++++++++++++
>  tools/perf/Makefile.config                   |  1 -
>  tools/perf/check-headers.sh                  |  1 +
>  3 files changed, 41 insertions(+), 1 deletion(-)
>  create mode 100644 tools/arch/mips/include/uapi/asm/perf_regs.h
> 
> diff --git a/tools/arch/mips/include/uapi/asm/perf_regs.h b/tools/arch/mips/include/uapi/asm/perf_regs.h
> new file mode 100644
> index 0000000..d0f4ecd
> --- /dev/null
> +++ b/tools/arch/mips/include/uapi/asm/perf_regs.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _ASM_MIPS_PERF_REGS_H
> +#define _ASM_MIPS_PERF_REGS_H
> +
> +enum perf_event_mips_regs {
> +	PERF_REG_MIPS_PC,
> +	PERF_REG_MIPS_R1,
> +	PERF_REG_MIPS_R2,
> +	PERF_REG_MIPS_R3,
> +	PERF_REG_MIPS_R4,
> +	PERF_REG_MIPS_R5,
> +	PERF_REG_MIPS_R6,
> +	PERF_REG_MIPS_R7,
> +	PERF_REG_MIPS_R8,
> +	PERF_REG_MIPS_R9,
> +	PERF_REG_MIPS_R10,
> +	PERF_REG_MIPS_R11,
> +	PERF_REG_MIPS_R12,
> +	PERF_REG_MIPS_R13,
> +	PERF_REG_MIPS_R14,
> +	PERF_REG_MIPS_R15,
> +	PERF_REG_MIPS_R16,
> +	PERF_REG_MIPS_R17,
> +	PERF_REG_MIPS_R18,
> +	PERF_REG_MIPS_R19,
> +	PERF_REG_MIPS_R20,
> +	PERF_REG_MIPS_R21,
> +	PERF_REG_MIPS_R22,
> +	PERF_REG_MIPS_R23,
> +	PERF_REG_MIPS_R24,
> +	PERF_REG_MIPS_R25,
> +	PERF_REG_MIPS_R26,
> +	PERF_REG_MIPS_R27,
> +	PERF_REG_MIPS_R28,
> +	PERF_REG_MIPS_R29,
> +	PERF_REG_MIPS_R30,
> +	PERF_REG_MIPS_R31,
> +	PERF_REG_MIPS_MAX = PERF_REG_MIPS_R31 + 1,
> +};
> +#endif /* _ASM_MIPS_PERF_REGS_H */
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 406a951..73df23d 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -90,7 +90,6 @@ endif
>  ifeq ($(ARCH),mips)
>    NO_PERF_REGS := 0
>    CFLAGS += -I$(OUTPUT)arch/mips/include/generated
> -  CFLAGS += -I../../arch/mips/include/uapi -I../../arch/mips/include/generated/uapi
>    LIBUNWIND_LIBS = -lunwind -lunwind-mips
>  endif
>  
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index dd8ff28..c783558 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -39,6 +39,7 @@ arch/x86/lib/x86-opcode-map.txt
>  arch/x86/tools/gen-insn-attr-x86.awk
>  arch/arm/include/uapi/asm/perf_regs.h
>  arch/arm64/include/uapi/asm/perf_regs.h
> +arch/mips/include/uapi/asm/perf_regs.h
>  arch/powerpc/include/uapi/asm/perf_regs.h
>  arch/s390/include/uapi/asm/perf_regs.h
>  arch/x86/include/uapi/asm/perf_regs.h
> -- 
> 2.1.0
> 

-- 

- Arnaldo
