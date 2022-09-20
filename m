Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77391C6FA82
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Sep 2022 20:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiITUKg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiITUKf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Sep 2022 16:10:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436CC6747B
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Sep 2022 13:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B8FE8CE139A
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Sep 2022 20:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFB1C433C1;
        Tue, 20 Sep 2022 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663704631;
        bh=3/sLZfi26H7GUw5D9fzfiUiRsonsEJkiaOfjC+ZYbYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aTwNY64YsXtZ2m6LyqmKJQpHlkBilDMcerOe6EdBRZcAUp7LcbaLEXxeqITYHQmry
         AJtj/l/TABiG/a7zHHKtljKsE4ZbbMTPNdy6GFz4Zsrvr5KGv2xy0KAPGuJNRN/j9t
         MuVO7CRJHGEPzkS/FNPzH/5mPVYRsfjvEbH2GJZeGMoVlPEPrSdjXCbiLbFiIdKJc+
         I+nQ8G4WaBnEhq+4qAKSS7ad9KjFKJsJIV0Agbc0uJLr0wjYfn14gDoDXWKSyyYSpu
         p5++qqHyzcm1vxdG+/5Q15JFgEDXA195CucQK3E+pCk0R9JHq3Wje5z/uGTnECmntC
         cwPvwpUd3uRSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7BA8C40856; Tue, 20 Sep 2022 21:10:28 +0100 (IST)
Date:   Tue, 20 Sep 2022 21:10:28 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Lieven Hey <lieven.hey@kdab.com>
Cc:     linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2] perf jit: Include program header in elf files
Message-ID: <YyoeNGZ8wK8pFUjr@kernel.org>
References: <20220915092910.711036-1-lieven.hey@kdab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915092910.711036-1-lieven.hey@kdab.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 15, 2022 at 11:29:10AM +0200, Lieven Hey escreveu:
> The missing header makes it hard for programs like elfutils to open
> these files.
> 
> Fixes: 2d86612aacb7805f ("perf symbol: Correct address for bss symbols")
> Signed-off-by: Lieven Hey <lieven.hey@kdab.com>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/util/genelf.c | 14 ++++++++++++++
>  tools/perf/util/genelf.h |  4 ++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> index 953338b9e887..02cd9f75e3d2 100644
> --- a/tools/perf/util/genelf.c
> +++ b/tools/perf/util/genelf.c
> @@ -251,6 +251,7 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
>  	Elf_Data *d;
>  	Elf_Scn *scn;
>  	Elf_Ehdr *ehdr;
> +	Elf_Phdr *phdr;
>  	Elf_Shdr *shdr;
>  	uint64_t eh_frame_base_offset;
>  	char *strsym = NULL;
> @@ -285,6 +286,19 @@ jit_write_elf(int fd, uint64_t load_addr, const char *sym,
>  	ehdr->e_version = EV_CURRENT;
>  	ehdr->e_shstrndx= unwinding ? 4 : 2; /* shdr index for section name */
>  
> +	/*
> +	 * setup program header
> +	 */
> +	phdr = elf_newphdr(e, 1);
> +	phdr[0].p_type = PT_LOAD;
> +	phdr[0].p_offset = 0;
> +	phdr[0].p_vaddr = 0;
> +	phdr[0].p_paddr = 0;
> +	phdr[0].p_filesz = csize;
> +	phdr[0].p_memsz = csize;
> +	phdr[0].p_flags = PF_X | PF_R;
> +	phdr[0].p_align = 8;
> +
>  	/*
>  	 * setup text section
>  	 */
> diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
> index ae138afe6c56..b5c909546e3f 100644
> --- a/tools/perf/util/genelf.h
> +++ b/tools/perf/util/genelf.h
> @@ -53,8 +53,10 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
>  
>  #if GEN_ELF_CLASS == ELFCLASS64
>  #define elf_newehdr	elf64_newehdr
> +#define elf_newphdr	elf64_newphdr
>  #define elf_getshdr	elf64_getshdr
>  #define Elf_Ehdr	Elf64_Ehdr
> +#define Elf_Phdr	Elf64_Phdr
>  #define Elf_Shdr	Elf64_Shdr
>  #define Elf_Sym		Elf64_Sym
>  #define ELF_ST_TYPE(a)	ELF64_ST_TYPE(a)
> @@ -62,8 +64,10 @@ int jit_add_debug_info(Elf *e, uint64_t code_addr, void *debug, int nr_debug_ent
>  #define ELF_ST_VIS(a)	ELF64_ST_VISIBILITY(a)
>  #else
>  #define elf_newehdr	elf32_newehdr
> +#define elf_newphdr	elf32_newphdr
>  #define elf_getshdr	elf32_getshdr
>  #define Elf_Ehdr	Elf32_Ehdr
> +#define Elf_Phdr	Elf32_Phdr
>  #define Elf_Shdr	Elf32_Shdr
>  #define Elf_Sym		Elf32_Sym
>  #define ELF_ST_TYPE(a)	ELF32_ST_TYPE(a)
> -- 
> 2.37.3

-- 

- Arnaldo
