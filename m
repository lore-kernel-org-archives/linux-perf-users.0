Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6651C77B7C
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 May 2023 15:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjEJP0r (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjEJP0r (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 11:26:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C79BF
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 08:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57C8663EAC
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 15:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A01C433EF;
        Wed, 10 May 2023 15:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683732404;
        bh=I7FCoBO3H3paLd9cXnGLEZa5y4ILPQJOJQAeinopW5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q4jiWkISLih/LyrM2GdXzK/m5bXJyARtw77M1y0QfARVSgZWyr7Y2fvBUx3lj16Mb
         bsvdQ0+Lp6aGO93Vxpm0dcDx+V57BoeSoTajpLPB/HmReBfkCwibNV0n04wjBi7nEW
         9JgDf+XqLpimlEhHnKIiECdUK06Ffc+OQ7b4TGC3mjTO53UzGbq72DY2eGfMYOSMG+
         UHdgUnig1V0S1/5nlPwd+QxnYp9xqtllZ20KAyEUFrYFrYny6SSIuKU5/DysSmfWYj
         WJN0u7r6lrmkPhkz7iSNJacBk2TnskHQkRCGWDT0UvYWQ/jjKs/ua6zGJFapUgcvFJ
         RUQjnRGFjCyvw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF607403B5; Wed, 10 May 2023 12:26:41 -0300 (-03)
Date:   Wed, 10 May 2023 12:26:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 17/17] tools arch arm64: Sync the perf_regs headers
 with the kernel sources
Message-ID: <ZFu3sY4AuuCGb9Nw@kernel.org>
References: <cover.1683712944.git.siyanteng@loongson.cn>
 <84e48c9d165a71c30b7a299baaa87a22c578ca0a.1683712945.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84e48c9d165a71c30b7a299baaa87a22c578ca0a.1683712945.git.siyanteng@loongson.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, May 10, 2023 at 06:25:24PM +0800, Yanteng Si escreveu:
> Picking the changes from:
> 
>   commit aa3e49b606e0796a ("arm64: asm/perf_regs.h: Avoid C++-style
>    comment in UAPI header")
>   commit 2ee0d7fd36a3f87b ("ARM64: perf: add support for perf
>    registers API")
>   commit cbb0c02caf4bd98b ("perf: arm64: Add SVE vector granule
>    register to user regs")
> 
> Silencing these perf build warnings:
> 
>   Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi
>    /asm/perf_regs.h' differs from latest version at 'arch/arm64
>     /include/uapi/asm/perf_regs.h'
>   diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64
>    /include/uapi/asm/perf_regs.h
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  tools/arch/arm64/include/uapi/asm/perf_regs.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/arch/arm64/include/uapi/asm/perf_regs.h b/tools/arch/arm64/include/uapi/asm/perf_regs.h
> index fd157f46727e..86e556429e0e 100644
> --- a/tools/arch/arm64/include/uapi/asm/perf_regs.h
> +++ b/tools/arch/arm64/include/uapi/asm/perf_regs.h
> @@ -36,11 +36,13 @@ enum perf_event_arm_regs {
>  	PERF_REG_ARM64_LR,
>  	PERF_REG_ARM64_SP,
>  	PERF_REG_ARM64_PC,
> +	PERF_REG_ARM64_MAX,
>  
>  	/* Extended/pseudo registers */
> -	PERF_REG_ARM64_VG = 46, // SVE Vector Granule
> -
> -	PERF_REG_ARM64_MAX = PERF_REG_ARM64_PC + 1,
> -	PERF_REG_ARM64_EXTENDED_MAX = PERF_REG_ARM64_VG + 1
> +	PERF_REG_ARM64_VG = 46,				/* SVE Vector Granule */
> +	PERF_REG_ARM64_EXTENDED_MAX
>  };
> +
> +#define PERF_REG_EXTENDED_MASK	(1ULL << PERF_REG_ARM64_VG)
> +
>  #endif /* _ASM_ARM64_PERF_REGS_H */

This needs some more work, note that -DCORESIGHT=1 in the make command line.

I added some ARM folks that may help you,

- Arnaldo

  CC      /tmp/build/perf-tools/util/arm64-frame-pointer-unwind-support.o
  CC      /tmp/build/perf-tools/util/perf_regs.o
  CC      /tmp/build/perf-tools/util/header.o
In file included from util/arm64-frame-pointer-unwind-support.c:9:
util/../../arch/arm64/include/uapi/asm/perf_regs.h:46: error: "PERF_REG_EXTENDED_MASK" redefined [-Werror]
   46 | #define PERF_REG_EXTENDED_MASK  (1ULL << PERF_REG_ARM64_VG)
      | 
In file included from /var/home/acme/git/perf-tools/tools/perf/arch/x86/include/perf_regs.h:7,
                 from util/perf_regs.h:33,
                 from util/arm64-frame-pointer-unwind-support.c:5:
/var/home/acme/git/perf-tools/tools/arch/x86/include/uapi/asm/perf_regs.h:56: note: this is the location of the previous definition
   56 | #define PERF_REG_EXTENDED_MASK  (~((1ULL << PERF_REG_X86_XMM0) - 1))
      | 
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:97: /tmp/build/perf-tools/util/arm64-frame-pointer-unwind-support.o] Error 1
make[4]: *** Waiting for unfinished jobs....
In file included from util/perf_regs.c:26:
util/../../arch/arm64/include/uapi/asm/perf_regs.h:46: error: "PERF_REG_EXTENDED_MASK" redefined [-Werror]
   46 | #define PERF_REG_EXTENDED_MASK  (1ULL << PERF_REG_ARM64_VG)
      | 
In file included from /var/home/acme/git/perf-tools/tools/perf/arch/x86/include/perf_regs.h:7,
                 from util/perf_regs.h:33,
                 from util/perf_regs.c:4:
/var/home/acme/git/perf-tools/tools/arch/x86/include/uapi/asm/perf_regs.h:56: note: this is the location of the previous definition
   56 | #define PERF_REG_EXTENDED_MASK  (~((1ULL << PERF_REG_X86_XMM0) - 1))
      | 
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:97: /tmp/build/perf-tools/util/perf_regs.o] Error 1
make[3]: *** [/var/home/acme/git/perf-tools/tools/build/Makefile.build:140: util] Error 2
make[2]: *** [Makefile.perf:676: /tmp/build/perf-tools/perf-in.o] Error 2
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf-tools/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools -C tools/perf install-bin':

       12326009385      cycles:u                                                              
       20646679547      instructions:u                   #    1.68  insn per cycle            

       4.225375000 seconds time elapsed

       2.853093000 seconds user
       1.630218000 seconds sys


⬢[acme@toolbox perf-tools]$
