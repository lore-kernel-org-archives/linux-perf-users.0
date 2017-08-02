From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] perf report fix module symbol adjustment for s390x
Date: Wed, 2 Aug 2017 15:42:02 -0300
Message-ID: <20170802184202.GK12201@kernel.org>
References: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752285AbdHBSmG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Aug 2017 14:42:06 -0400
Content-Disposition: inline
In-Reply-To: <20170724143514.55574-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: brueckner@linux.vnet.ibm.com, zvonko.kosic@de.ibm.com, linux-perf-users@vger.kernel.org

Em Mon, Jul 24, 2017 at 04:35:13PM +0200, Thomas Richter escreveu:
> +++ b/tools/perf/util/symbol-elf.c
> @@ -793,6 +793,12 @@ static u64 ref_reloc(struct kmap *kmap)
>  void __weak arch__sym_update(struct symbol *s __maybe_unused,
>  		GElf_Sym *sym __maybe_unused) { }
>  
> +u64 __weak arch__sym_set_address(GElf_Sym *sym, GElf_Shdr *shdr,
> +				 struct map *map __maybe_unused)
> +{
> +	return sym->st_value - (shdr->sh_addr - shdr->sh_offset);
> +}
> +
>  int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  		  struct symsrc *runtime_ss, int kmodule)
>  {
> @@ -973,7 +979,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  
>  			/* Adjust symbol to map to file offset */
>  			if (adjust_kernel_syms)
> -				sym.st_value -= shdr.sh_addr - shdr.sh_offset;
> +				sym.st_value = arch__sym_set_address(&sym, &shdr, map);

Since this is just used when "adjusting" the symbol wrt file offset,
can we have a more descriptive name? Like:

void __weak arch__adjust_sym_map_offset(GElf_Sym *sym, GElf_Shdr *shdr,
					struct map *map __maybe_unused)
{
	sym->st_value -= shdr->sh_addr - shdr->sh_offset;
}

Then have it as:

-			/* Adjust symbol to map to file offset */
 			if (adjust_kernel_syms)
-				sym.st_value -= shdr.sh_addr - shdr.sh_offset;
+				arch__adjust_sym_map_offset(&sym, &shdr, map);

I.e. the weak function name becomes the comment :-)

>  
>  			if (strcmp(section_name,
>  				   (curr_dso->short_name +
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 41ebba9..beb8737 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -343,6 +343,9 @@ int setup_intlist(struct intlist **list, const char *list_str,
>  #ifdef HAVE_LIBELF_SUPPORT
>  bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
>  void arch__sym_update(struct symbol *s, GElf_Sym *sym);
> +u64 arch__sym_set_address(GElf_Sym *sym,
> +			  GElf_Shdr *shdr __maybe_unused,
> +			  struct map *map __maybe_unused);
>  #endif
>  
>  #define SYMBOL_A 0
> -- 
> 2.9.3
