Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E8DC7EE26
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 May 2023 15:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbjEJPs3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 May 2023 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjEJPsX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2023 11:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4A97D80
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 08:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06D6D63ED1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 May 2023 15:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039FDC433EF;
        Wed, 10 May 2023 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683733700;
        bh=BSBdDucTQ1LbQb5i6Cu0YdtLjYS74p/J5WkZnshiUEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=imEVddkUMc3oIuhbaF+GvbKwBatHwR28FTLgxaL4MrYb3zLcQVZp0qyvX7wzS4+hK
         hyj8Z4onZ9aMXHtsmlv8TBH4btBoV9f5YGzzPan/MH3z9FRbJ1v4vLl/R5660HJPO7
         zWna9M8QKRq9gc7EIbKeljD4x4Mz1oaa0Q8rEoqSbQlrRTUHpBDkf+Bi5dfb+pKMVC
         NHbCM/8sY90+cqGx+kSMXFsaDMr624tIGZnnUtQ8UqKR7HqfcH0IHb0WNp+2Tpc5TV
         /zW/QhEEy/MsMmBaUU2ac8zEWka+i0EfKiIDWwuYuNCjhTiM4KWIY/rE6gFurkJxZ0
         Gi11eB9lKvmcQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 73744403B5; Wed, 10 May 2023 12:48:17 -0300 (-03)
Date:   Wed, 10 May 2023 12:48:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 13/17] tools arch x86: Sync the memcpy_64 with the
 kernel sources
Message-ID: <ZFu8wUIl+GbEjWhn@kernel.org>
References: <cover.1683712944.git.siyanteng@loongson.cn>
 <c1d2cde32b89c3bdb822ab5d1638f2b0f5513902.1683712945.git.siyanteng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1d2cde32b89c3bdb822ab5d1638f2b0f5513902.1683712945.git.siyanteng@loongson.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, May 10, 2023 at 06:24:50PM +0800, Yanteng Si escreveu:
> Picking the changes from:
> 
>   commit 68674f94ffc9dddc ("x86: don't use REP_GOOD or ERMS for small
>    memory copies")
> 
> Silencing these perf build warnings:
> 
>   Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs
>    from latest version at 'arch/x86/lib/memcpy_64.S'
>   diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
>   Warning: Kernel ABI header at 'tools/arch/x86/lib/memset_64.S' differs
>    from latest version at 'arch/x86/lib/memset_64.S'
>   diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S

Dropping this one:

In file included from bench/mem-memcpy-x86-64-asm.S:14:
bench/../../arch/x86/lib/memcpy_64.S:5:10: fatal error: linux/cfi_types.h: No such file or directory
    5 | #include <linux/cfi_types.h>
      |          ^~~~~~~~~~~~~~~~~~~
compilation terminated.

 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  tools/arch/x86/lib/memcpy_64.S | 35 ++++++++-----------------
>  tools/arch/x86/lib/memset_64.S | 47 ++++++++--------------------------
>  2 files changed, 22 insertions(+), 60 deletions(-)
> 
> diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
> index a91ac666f758..8f95fb267caa 100644
> --- a/tools/arch/x86/lib/memcpy_64.S
> +++ b/tools/arch/x86/lib/memcpy_64.S
> @@ -2,6 +2,7 @@
>  /* Copyright 2002 Andi Kleen */
>  
>  #include <linux/linkage.h>
> +#include <linux/cfi_types.h>
>  #include <asm/errno.h>
>  #include <asm/cpufeatures.h>
>  #include <asm/alternative.h>
> @@ -9,13 +10,6 @@
>  
>  .section .noinstr.text, "ax"
>  
> -/*
> - * We build a jump to memcpy_orig by default which gets NOPped out on
> - * the majority of x86 CPUs which set REP_GOOD. In addition, CPUs which
> - * have the enhanced REP MOVSB/STOSB feature (ERMS), change those NOPs
> - * to a jmp to memcpy_erms which does the REP; MOVSB mem copy.
> - */
> -
>  /*
>   * memcpy - Copy a memory block.
>   *
> @@ -26,17 +20,21 @@
>   *
>   * Output:
>   * rax original destination
> + *
> + * The FSRM alternative should be done inline (avoiding the call and
> + * the disgusting return handling), but that would require some help
> + * from the compiler for better calling conventions.
> + *
> + * The 'rep movsb' itself is small enough to replace the call, but the
> + * two register moves blow up the code. And one of them is "needed"
> + * only for the return value that is the same as the source input,
> + * which the compiler could/should do much better anyway.
>   */
>  SYM_TYPED_FUNC_START(__memcpy)
> -	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
> -		      "jmp memcpy_erms", X86_FEATURE_ERMS
> +	ALTERNATIVE "jmp memcpy_orig", "", X86_FEATURE_FSRM
>  
>  	movq %rdi, %rax
>  	movq %rdx, %rcx
> -	shrq $3, %rcx
> -	andl $7, %edx
> -	rep movsq
> -	movl %edx, %ecx
>  	rep movsb
>  	RET
>  SYM_FUNC_END(__memcpy)
> @@ -45,17 +43,6 @@ EXPORT_SYMBOL(__memcpy)
>  SYM_FUNC_ALIAS(memcpy, __memcpy)
>  EXPORT_SYMBOL(memcpy)
>  
> -/*
> - * memcpy_erms() - enhanced fast string memcpy. This is faster and
> - * simpler than memcpy. Use memcpy_erms when possible.
> - */
> -SYM_FUNC_START_LOCAL(memcpy_erms)
> -	movq %rdi, %rax
> -	movq %rdx, %rcx
> -	rep movsb
> -	RET
> -SYM_FUNC_END(memcpy_erms)
> -
>  SYM_FUNC_START_LOCAL(memcpy_orig)
>  	movq %rdi, %rax
>  
> diff --git a/tools/arch/x86/lib/memset_64.S b/tools/arch/x86/lib/memset_64.S
> index 6143b1a6fa2c..7c59a704c458 100644
> --- a/tools/arch/x86/lib/memset_64.S
> +++ b/tools/arch/x86/lib/memset_64.S
> @@ -18,27 +18,22 @@
>   * rdx   count (bytes)
>   *
>   * rax   original destination
> + *
> + * The FSRS alternative should be done inline (avoiding the call and
> + * the disgusting return handling), but that would require some help
> + * from the compiler for better calling conventions.
> + *
> + * The 'rep stosb' itself is small enough to replace the call, but all
> + * the register moves blow up the code. And two of them are "needed"
> + * only for the return value that is the same as the source input,
> + * which the compiler could/should do much better anyway.
>   */
>  SYM_FUNC_START(__memset)
> -	/*
> -	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
> -	 * to use it when possible. If not available, use fast string instructions.
> -	 *
> -	 * Otherwise, use original memset function.
> -	 */
> -	ALTERNATIVE_2 "jmp memset_orig", "", X86_FEATURE_REP_GOOD, \
> -		      "jmp memset_erms", X86_FEATURE_ERMS
> +	ALTERNATIVE "jmp memset_orig", "", X86_FEATURE_FSRS
>  
>  	movq %rdi,%r9
> +	movb %sil,%al
>  	movq %rdx,%rcx
> -	andl $7,%edx
> -	shrq $3,%rcx
> -	/* expand byte value  */
> -	movzbl %sil,%esi
> -	movabs $0x0101010101010101,%rax
> -	imulq %rsi,%rax
> -	rep stosq
> -	movl %edx,%ecx
>  	rep stosb
>  	movq %r9,%rax
>  	RET
> @@ -48,26 +43,6 @@ EXPORT_SYMBOL(__memset)
>  SYM_FUNC_ALIAS(memset, __memset)
>  EXPORT_SYMBOL(memset)
>  
> -/*
> - * ISO C memset - set a memory block to a byte value. This function uses
> - * enhanced rep stosb to override the fast string function.
> - * The code is simpler and shorter than the fast string function as well.
> - *
> - * rdi   destination
> - * rsi   value (char)
> - * rdx   count (bytes)
> - *
> - * rax   original destination
> - */
> -SYM_FUNC_START_LOCAL(memset_erms)
> -	movq %rdi,%r9
> -	movb %sil,%al
> -	movq %rdx,%rcx
> -	rep stosb
> -	movq %r9,%rax
> -	RET
> -SYM_FUNC_END(memset_erms)
> -
>  SYM_FUNC_START_LOCAL(memset_orig)
>  	movq %rdi,%r10
>  
> -- 
> 2.31.4
> 

-- 

- Arnaldo
