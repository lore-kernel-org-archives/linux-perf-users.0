Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9BD19CC39;
	Sat, 30 Aug 2025 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756539065; cv=none; b=C62nINBsOCDX1AzBXn7viPJtBJVYNetHkvquXPO+VhhdjcUNCxyTkRvtvhYUTOoBontV2PVzVZFrwiGtwtO+k0qfCENrYaZnmvp77nvuw0np2ywOHnq60sz+gRPVlKJGG3iihBUX3178iQYkiil+nE7iCrG2N7wPQaTJJGfWiHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756539065; c=relaxed/simple;
	bh=+Nb4MqxXTKnS1ljG6Gfu0099pT0i+02LE9muMh6CdUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9mkUEuwvDrmU9MeEUlmy3UKz3/zdOYfB/88q12pOl6n4oM3p1pF8lP+zpsnrbTWdb05s0Awcm3d320SZbE4jeg2EbN7m8p21U7PtJb7P9kH7StDCpGpvD23lV1dGwZtb3fh5M+BSMsFQflihQSBo07QwVFPZOzATov71kXTcHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thbXXHfx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thbXXHfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792EFC4CEEB;
	Sat, 30 Aug 2025 07:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756539065;
	bh=+Nb4MqxXTKnS1ljG6Gfu0099pT0i+02LE9muMh6CdUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thbXXHfxJVBds/Rpbkj4YEFWNZmpTdcmhli12SCdgHIbz2QYh0LtbwgnqPlxasCN6
	 CNkpa5acyS+evHJ2S1cPElH8ziFEYdzM+8XIFAT2jw6zFwhGYGjw6xbd0oSYpEovk+
	 gpNvrCMMIoLfJwz6zYUkh97j2vT6ly8KTRYrh2jIPJXZvuuErH40ciCUm759/3VxAP
	 8mX5dxbYrCBNOxY8jxh4016vEnw+OQrpaoevXeFpcEhX/GUoRwoMD0RRn/JsDeOND8
	 z2U28AptpuIYfLhHmKjs3U6cZ8O+M/Ueijv/UIEbAP7o8PS1UfUQQl/wMknGQfnGFK
	 qK9c837yegDhA==
Date: Sat, 30 Aug 2025 00:31:03 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] perf dwarf-aux: Skip check_variable for
 die_find_variable_by_reg
Message-ID: <aLKot1esgc3HHubX@google.com>
References: <20250825195806.226328-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825195806.226328-1-zecheng@google.com>

On Mon, Aug 25, 2025 at 07:58:06PM +0000, Zecheng Li wrote:
> In die_find_variable_by_reg, match_var_offset already performs
> sufficient checking and type matching. The additional check_variable
> call is redundant, and its need_pointer logic is only a heuristic. Since
> DWARF encodes accurate type information, which match_var_offset
> verifies, skipping check_variable improves both coverage and accuracy.
> 
> This change implements

Looks like you can split these into separate commits.

> 
> - Return type from die_find_variable_by_reg via a new `type` field in
>   find_var_data.

Sounds ok.

> 
> - In match_var_offset, use __die_get_real_type instead of
>   die_get_real_type to preserve typedefs. Move the (offset == 0) branch

Why do you want to preserve typedefs?  I think a variable type can be
typedef to a pointer then now it won't resolve that target type anymore.


>   after the is_pointer check to ensure the correct type is used, fixing
>   cases where an incorrect pointer type was chosen when the access
>   offset was 0.
> 
> - When comparing types from different scopes, first compare their type
>   offsets. A larger offset means the field belongs to an outer
>   (enclosing) struct. This helps resolve cases where a pointer is found
>   in an inner scope, but a struct containing that pointer exists in an
>   outer scope. Previously, is_better_type would prefer the pointer type,
>   but the struct type is actually more complete and should be chosen.

Can we improve is_better_type() then?

Thanks,
Namhyung

> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/annotate-data.c | 12 ++++++++----
>  tools/perf/util/dwarf-aux.c     | 30 +++++++++++++++++-------------
>  tools/perf/util/dwarf-aux.h     |  2 +-
>  3 files changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index e067e91f2037..b1a4b02afeb1 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1551,19 +1551,21 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  			if (!die_find_variable_by_addr(&scopes[i], dloc->var_addr,
>  						       &var_die, &type_offset))
>  				continue;
> +			/* Found a variable, see if it's correct */
> +			result = check_variable(dloc, &var_die, &mem_die, reg,
> +						type_offset, is_fbreg);
>  		} else {
>  			/* Look up variables/parameters in this scope */
>  			if (!die_find_variable_by_reg(&scopes[i], pc, reg,
> -						      &type_offset, is_fbreg, &var_die))
> +						      &mem_die, &type_offset, is_fbreg, &var_die))
>  				continue;
> +			result = PERF_TMR_OK;
>  		}
>  
>  		pr_debug_dtp("found \"%s\" (die: %#lx) in scope=%d/%d (die: %#lx) ",
>  			     dwarf_diename(&var_die), (long)dwarf_dieoffset(&var_die),
>  			     i+1, nr_scopes, (long)dwarf_dieoffset(&scopes[i]));
>  
> -		/* Found a variable, see if it's correct */
> -		result = check_variable(dloc, &var_die, &mem_die, reg, type_offset, is_fbreg);
>  		if (result == PERF_TMR_OK) {
>  			if (reg == DWARF_REG_PC) {
>  				pr_debug_dtp("addr=%#"PRIx64" type_offset=%#x\n",
> @@ -1575,7 +1577,9 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  				pr_debug_dtp("type_offset=%#x\n", type_offset);
>  			}
>  
> -			if (!found || is_better_type(type_die, &mem_die)) {
> +			if (!found || dloc->type_offset < type_offset ||
> +				(dloc->type_offset == type_offset &&
> +				 is_better_type(type_die, &mem_die))) {
>  				*type_die = mem_die;
>  				dloc->type_offset = type_offset;
>  				found = true;
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 6e8877ff2172..56e1b5690dc4 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1378,6 +1378,8 @@ struct find_var_data {
>  	Dwarf_Addr addr;
>  	/* Target register */
>  	unsigned reg;
> +	/* Access data type */
> +	Dwarf_Die type;
>  	/* Access offset, set for global data */
>  	int offset;
>  	/* True if the current register is the frame base */
> @@ -1390,29 +1392,28 @@ struct find_var_data {
>  static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
>  			     s64 addr_offset, s64 addr_type, bool is_pointer)
>  {
> -	Dwarf_Die type_die;
>  	Dwarf_Word size;
>  	s64 offset = addr_offset - addr_type;
>  
> -	if (offset == 0) {
> -		/* Update offset relative to the start of the variable */
> -		data->offset = 0;
> -		return true;
> -	}
> -
>  	if (offset < 0)
>  		return false;
>  
> -	if (die_get_real_type(die_mem, &type_die) == NULL)
> +	if (__die_get_real_type(die_mem, &data->type) == NULL)
>  		return false;
>  
> -	if (is_pointer && dwarf_tag(&type_die) == DW_TAG_pointer_type) {
> +	if (is_pointer && dwarf_tag(&data->type) == DW_TAG_pointer_type) {
>  		/* Get the target type of the pointer */
> -		if (die_get_real_type(&type_die, &type_die) == NULL)
> +		if (__die_get_real_type(&data->type, &data->type) == NULL)
>  			return false;
>  	}
>  
> -	if (dwarf_aggregate_size(&type_die, &size) < 0)
> +	if (offset == 0) {
> +		/* Update offset relative to the start of the variable */
> +		data->offset = 0;
> +		return true;
> +	}
> +
> +	if (dwarf_aggregate_size(&data->type, &size) < 0)
>  		return false;
>  
>  	if ((u64)offset >= size)
> @@ -1529,7 +1530,7 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
>   * when the variable is in the stack.
>   */
>  Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
> -				    int *poffset, bool is_fbreg,
> +				    Dwarf_Die *type_die, int *poffset, bool is_fbreg,
>  				    Dwarf_Die *die_mem)
>  {
>  	struct find_var_data data = {
> @@ -1541,8 +1542,11 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
>  	Dwarf_Die *result;
>  
>  	result = die_find_child(sc_die, __die_find_var_reg_cb, &data, die_mem);
> -	if (result)
> +	if (result) {
>  		*poffset = data.offset;
> +		*type_die = data.type;
> +	}
> +
>  	return result;
>  }
>  
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index f20319eb97a9..beb6926aaa71 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -167,7 +167,7 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
>  
>  /* Find a variable saved in the 'reg' at given address */
>  Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
> -				    int *poffset, bool is_fbreg,
> +				    Dwarf_Die *type_die, int *poffset, bool is_fbreg,
>  				    Dwarf_Die *die_mem);
>  
>  /* Find a (global) variable located in the 'addr' */
> -- 
> 2.51.0.261.g7ce5a0a67e-goog
> 
