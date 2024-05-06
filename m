Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604EC1534FC;
	Mon,  6 May 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006658; cv=none; b=QqSBc4Nxbw399d6W4WfKNqzLSGr3M/xLIgIQ6BDIhp/IdbN/NCB3em/7xFeHBVMGOj5w6hO0lYz60qfWmd/JWkY17aOKs/Vc6Tsr4w03a1bGckp0qoXDhavXBDW4WhWGFLF7OVRqkT7lBqFE4Mv0u/nBot8NbrusVUsbnovIj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006658; c=relaxed/simple;
	bh=A2c3A5/WXG3mtNfwLsgIRSeWrBlKt+rdHKlZtOo3tXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgpTPjI2iyJ6X28I0VG2oPyCCLPLtG48lHT1voRu+tq4CRjk+0FzTkz3gZMrdlSpp+1/GGH2b+MCrAPL9nlObP15ljlcXAwxFH/zQSsZwbm+trZK7ZvM6rTAXDisi9tApHfMq1mqGAWFA9pHir4jrlBYID2jqTU5WzwnzZLiLyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7VuGzo/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7VuGzo/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005C0C116B1;
	Mon,  6 May 2024 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715006657;
	bh=A2c3A5/WXG3mtNfwLsgIRSeWrBlKt+rdHKlZtOo3tXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7VuGzo/kg3TXvOHe25aNMbRxl1I9oWRQatk4Ax7ppKWM47oQn2nBVideN29oZ7N7
	 A4vlGqf7ynLeWZmywHc+XhHpPDMOZGQ9HIBDJDV0snp2w+7ReSg0puHdaisfnlS10c
	 N4CadJ5UlavGR0GqlY6dHpofSMMAnH+QIdI07eSVgDZlIjHD7QwurOLf7SFUz4Y+ZL
	 O6W03jrgYk0cRJNTKFUwwMO6KLJQXMZh5AVwdx0GFAJ+Ggdifhk68iEkSRxaY8+nax
	 5gfE8TCr4aq5eaWIHWPmx75uRkT2OFV3Qcq+Nghgv5nvTR4ebVZPNnnJw8Ck0FUPxW
	 aI/rTSnRvckKQ==
Date: Mon, 6 May 2024 11:44:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>,
	Song Liu <song@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ben Gainey <ben.gainey@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Changbin Du <changbin.du@huawei.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dima Kogan <dima@secretsauce.net>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Chengen Du <chengen.du@canonical.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] perf dso: Reference counting related fixes
Message-ID: <Zjjsvah8TU_Yubdn@x1>
References: <20240504213803.218974-1-irogers@google.com>
 <20240504213803.218974-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504213803.218974-7-irogers@google.com>

On Sat, May 04, 2024 at 02:38:02PM -0700, Ian Rogers wrote:
> Ensure gets and puts are better aligned fixing reference couting
> checking problems.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/machine.c    |  4 +--
>  tools/perf/util/map.c        |  1 +
>  tools/perf/util/symbol-elf.c | 51 ++++++++++++++++++------------------
>  3 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 0b8fb14f5ff6..4a4541a2e887 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -683,7 +683,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  					     struct perf_sample *sample __maybe_unused)
>  {
>  	struct symbol *sym;
> -	struct dso *dso;
> +	struct dso *dso = NULL;
>  	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
>  	int err = 0;
>  
> @@ -696,7 +696,6 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  		}
>  		dso__set_kernel(dso, DSO_SPACE__KERNEL);
>  		map = map__new2(0, dso);
> -		dso__put(dso);
>  		if (!map) {
>  			err = -ENOMEM;
>  			goto out;
> @@ -735,6 +734,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  	dso__insert_symbol(dso, sym);
>  out:
>  	map__put(map);
> +	dso__put(dso);
>  	return err;
>  }

This seems to match the patch description, good, just aligning the puts
  
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 117c4bb78b35..e1d14936a60d 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -200,6 +200,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>  				dso__set_build_id(dso, dso__bid(header_bid_dso));
>  				dso__set_header_build_id(dso, 1);
>  			}
> +			dso__put(header_bid_dso);
>  		}
>  		dso__put(dso);
>  	}

But this is a missing one, so not aligning, but fixing a separate issue,
i.e. a missing put? Should go on a different patch, probably with a
Fixes.

> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 3be5e8d1e278..e398abfd13a0 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1419,7 +1419,7 @@ void __weak arch__sym_update(struct symbol *s __maybe_unused,
>  static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  				      GElf_Sym *sym, GElf_Shdr *shdr,
>  				      struct maps *kmaps, struct kmap *kmap,
> -				      struct dso **curr_dsop, struct map **curr_mapp,
> +				      struct dso **curr_dsop,

This one removes an argument, so look like a separate patch as well,
needs a description of why removing the argument is the right thing to
do here.

>  				      const char *section_name,
>  				      bool adjust_kernel_syms, bool kmodule, bool *remap_kernel,
>  				      u64 max_text_sh_offset)
> @@ -1470,8 +1470,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  			map__set_pgoff(map, shdr->sh_offset);
>  		}
>  
> -		*curr_mapp = map;
> -		*curr_dsop = dso;
> +		dso__put(*curr_dsop);
> +		*curr_dsop = dso__get(dso);
>  		return 0;
>  	}
>  
> @@ -1484,8 +1484,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  	 */
>  	if (kmodule && adjust_kernel_syms && is_exe_text(shdr->sh_flags) &&
>  	    shdr->sh_offset <= max_text_sh_offset) {
> -		*curr_mapp = map;
> -		*curr_dsop = dso;
> +		dso__put(*curr_dsop);
> +		*curr_dsop = dso__get(dso);
>  		return 0;
>  	}
>  
> @@ -1507,10 +1507,10 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  		dso__set_binary_type(curr_dso, dso__binary_type(dso));
>  		dso__set_adjust_symbols(curr_dso, dso__adjust_symbols(dso));
>  		curr_map = map__new2(start, curr_dso);
> -		dso__put(curr_dso);
> -		if (curr_map == NULL)
> +		if (curr_map == NULL) {
> +			dso__put(curr_dso);
>  			return -1;
> -
> +		}
>  		if (dso__kernel(curr_dso))
>  			map__kmap(curr_map)->kmaps = kmaps;
>  
> @@ -1524,21 +1524,15 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  		dso__set_symtab_type(curr_dso, dso__symtab_type(dso));
>  		if (maps__insert(kmaps, curr_map))
>  			return -1;
> -		/*
> -		 * Add it before we drop the reference to curr_map, i.e. while
> -		 * we still are sure to have a reference to this DSO via
> -		 * *curr_map->dso.
> -		 */
>  		dsos__add(&maps__machine(kmaps)->dsos, curr_dso);
> -		/* kmaps already got it */
> -		map__put(curr_map);
>  		dso__set_loaded(curr_dso);
> -		*curr_mapp = curr_map;
> +		dso__put(*curr_dsop);
>  		*curr_dsop = curr_dso;
>  	} else {
> -		*curr_dsop = map__dso(curr_map);
> -		map__put(curr_map);
> +		dso__put(*curr_dsop);
> +		*curr_dsop = dso__get(map__dso(curr_map));
>  	}
> +	map__put(curr_map);
>  
>  	return 0;
>  }
> @@ -1549,11 +1543,9 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  {
>  	struct kmap *kmap = dso__kernel(dso) ? map__kmap(map) : NULL;
>  	struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
> -	struct map *curr_map = map;
> -	struct dso *curr_dso = dso;
> +	struct dso *curr_dso = NULL;
>  	Elf_Data *symstrs, *secstrs, *secstrs_run, *secstrs_sym;
>  	uint32_t nr_syms;
> -	int err = -1;
>  	uint32_t idx;
>  	GElf_Ehdr ehdr;
>  	GElf_Shdr shdr;
> @@ -1656,6 +1648,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  	if (kmodule && adjust_kernel_syms)
>  		max_text_sh_offset = max_text_section(runtime_ss->elf, &runtime_ss->ehdr);
>  
> +	curr_dso = dso__get(dso);
>  	elf_symtab__for_each_symbol(syms, nr_syms, idx, sym) {
>  		struct symbol *f;
>  		const char *elf_name = elf_sym__name(&sym, symstrs);
> @@ -1744,9 +1737,13 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  			--sym.st_value;
>  
>  		if (dso__kernel(dso)) {
> -			if (dso__process_kernel_symbol(dso, map, &sym, &shdr, kmaps, kmap, &curr_dso, &curr_map,
> -						       section_name, adjust_kernel_syms, kmodule,
> -						       &remap_kernel, max_text_sh_offset))
> +			if (dso__process_kernel_symbol(dso, map, &sym, &shdr,
> +						       kmaps, kmap, &curr_dso,
> +						       section_name,
> +						       adjust_kernel_syms,
> +						       kmodule,
> +						       &remap_kernel,
> +						       max_text_sh_offset))

Can you please avoid reflowing to reduce the cost of reviewing? If this
was just:

-			if (dso__process_kernel_symbol(dso, map, &sym, &shdr, kmaps, kmap, &curr_dso, &curr_map,
 						       section_name, adjust_kernel_syms, kmodule,
 						       &remap_kernel, max_text_sh_offset))
+			if (dso__process_kernel_symbol(dso, map, &sym, &shdr, kmaps, kmap, &curr_dso,
 						       section_name, adjust_kernel_syms, kmodule,
 						       &remap_kernel, max_text_sh_offset))

The actual change would be quickly spotted as just the line where it
takes place gets changed.

I applied all the patches in this series but this one, please split it
as described.

The tests I run after each patch before this one passed, thanks for
addressing the issues I reported,

I'm pushing what I have to tmp.perf-tools-next,

- Arnaldo

>  				goto out_elf_end;
>  		} else if ((used_opd && runtime_ss->adjust_symbols) ||
>  			   (!used_opd && syms_ss->adjust_symbols)) {
> @@ -1795,6 +1792,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
>  		nr++;
>  	}
> +	dso__put(curr_dso);
>  
>  	/*
>  	 * For misannotated, zeroed, ASM function sizes.
> @@ -1810,9 +1808,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  			maps__fixup_end(kmaps);
>  		}
>  	}
> -	err = nr;
> +	return nr;
>  out_elf_end:
> -	return err;
> +	dso__put(curr_dso);
> +	return -1;
>  }
>  
>  int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 
