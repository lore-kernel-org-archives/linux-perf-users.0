Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856BB1A9F90;
	Wed, 11 Feb 2026 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775734; cv=none; b=aCzak/RNyFpGs+/Raemjox5ojoLwz69RLIoFTL5U4R63LzpKgeU+NyKYJUyd4gb0Bgpi4WiHgdtMqlZHo2wtbORCHYnH9yU8rYLEj3aY0GB7SvCAiAa/gFTQAeqTWgafDHZg/WSqBc/iaAD/1X5NjEKBHRSmILgNNXuLedcfFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775734; c=relaxed/simple;
	bh=RR8qvWTUK+IEh93Ob8siU/qNIbwfviNUpkv/XDvmZF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enG0PPEy+vtELbeNgJ2aFfu4zu5tzjcf5gmF8IDtMhdDcupt29OcUKnKWK5oOxSKwIBMCUVRUCP14OMbCUqogyQg5d6+DNfvpIqm0IAgK95NSGGGahticiG2/oVo2mBxMc6jd3KpbGSUhLETrANtBTWauyCdqMOCY1C5P9Zrk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYusGBMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYusGBMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E65C116C6;
	Wed, 11 Feb 2026 02:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770775734;
	bh=RR8qvWTUK+IEh93Ob8siU/qNIbwfviNUpkv/XDvmZF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYusGBMJWFqWVZm5s/UA9xBLwQuWXrordMfJG+3sicf0ewk1g4ncxRo9oxiT1o3iK
	 ftxFPxy/ngw4L5i3CkI6f9QvEogprbiVm0sExKl914a2oaffG54urMcndqwBrsgGrR
	 aYvD5XKtlrSV6AvDg0/AeiOnOM/wWNAT6orghIFineLudIIVg2dA5UtF2G6h7SvWFU
	 yOz9Glo3ShkBzJMz1wtOIGEux9C4DvDzV21YuiA/oFHDn00Y73WeCno9wi9VDB6PiF
	 hucixr9ODiumlI/dPxxEVN6HcFvsBPPfWxuV3FXv/qKSJHlS3gcqhOTYGaNp5Bpvco
	 W8SYsevZk71OA==
Date: Tue, 10 Feb 2026 18:08:52 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zli94@ncsu.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, xliuprof@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zecheng Li <zecheng@google.com>
Subject: Re: [PATCH v1 01/11] perf dwarf-aux: Skip check_variable for
 die_find_variable_by_reg
Message-ID: <aYvktEITO1uudkGH@google.com>
References: <20260127020617.2804780-1-zli94@ncsu.edu>
 <20260127020617.2804780-2-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127020617.2804780-2-zli94@ncsu.edu>

Hello,

On Mon, Jan 26, 2026 at 09:04:54PM -0500, Zecheng Li wrote:
> From: Zecheng Li <zecheng@google.com>
> 
> In die_find_variable_by_reg, match_var_offset already performs
> sufficient checking and type matching. The additional check_variable
> call is redundant, and its need_pointer logic is only a heuristic. Since
> DWARF encodes accurate type information, which match_var_offset
> verifies, skipping check_variable improves both coverage and accuracy.

In that case, I think you also skip it for die_find_variable_by_addr
as it calls match_var_offset() too.

> 
> Return type from die_find_variable_by_reg via a new `type` field in
> find_var_data.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> Signed-off-by: Zecheng Li <zli94@ncsu.edu>
> ---
>  tools/perf/util/annotate-data.c |  8 +++++---
>  tools/perf/util/dwarf-aux.c     | 18 +++++++++++-------
>  tools/perf/util/dwarf-aux.h     |  2 +-
>  3 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 07cf9c334be0..99ffc6d70565 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1603,19 +1603,21 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
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

Then maybe we can just get rid of this check.

Thanks,
Namhyung


>  			if (reg == DWARF_REG_PC) {
>  				pr_debug_dtp("addr=%#"PRIx64" type_offset=%#x\n",
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 9267af204c7d..b57cdc8860f0 100644
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
> @@ -1390,7 +1392,6 @@ struct find_var_data {
>  static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
>  			     s64 addr_offset, s64 addr_type, bool is_pointer)
>  {
> -	Dwarf_Die type_die;
>  	Dwarf_Word size;
>  	s64 offset = addr_offset - addr_type;
>  
> @@ -1403,16 +1404,16 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
>  	if (offset < 0)
>  		return false;
>  
> -	if (die_get_real_type(die_mem, &type_die) == NULL)
> +	if (die_get_real_type(die_mem, &data->type) == NULL)
>  		return false;
>  
> -	if (is_pointer && dwarf_tag(&type_die) == DW_TAG_pointer_type) {
> +	if (is_pointer && dwarf_tag(&data->type) == DW_TAG_pointer_type) {
>  		/* Get the target type of the pointer */
> -		if (die_get_real_type(&type_die, &type_die) == NULL)
> +		if (die_get_real_type(&data->type, &data->type) == NULL)
>  			return false;
>  	}
>  
> -	if (dwarf_aggregate_size(&type_die, &size) < 0)
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
> index cd481ec9c5a1..b3ee5df0b6be 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -163,7 +163,7 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
>  
>  /* Find a variable saved in the 'reg' at given address */
>  Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
> -				    int *poffset, bool is_fbreg,
> +				    Dwarf_Die *type_die, int *poffset, bool is_fbreg,
>  				    Dwarf_Die *die_mem);
>  
>  /* Find a (global) variable located in the 'addr' */
> -- 
> 2.52.0
> 
