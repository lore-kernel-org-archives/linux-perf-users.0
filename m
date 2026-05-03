Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DA29AB1A;
	Sun,  3 May 2026 23:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777852439; cv=none; b=s8vfKbbRB2bVn+LkOhnjUlgxDltGv2ZY38Co5oTureTi/OxFbTJiMgGC2zRHDS0dPVExKuB6mrxEJa5W9PNZTvpPdjpZ7VCOp1qE/bpXEUUcXlmtTr/yUYzbjWuPOYKxDO9foQsocAWLxwL/+DlI5Txi+e723CL0MUUIU9fJBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777852439; c=relaxed/simple;
	bh=rEFi151vOXN0oR6hSnac9cwr3nnupvnjPypyEmOZan8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZB4WLMTugsEmL0E4PCrxi7NjsR61duLdzTwX8LA6GhTjANdk7OqWBTPQw/oHM9y6OK98tvm9RS0LPFvj7Vuu/i2AaXWiH42kBFyi2Y4QZewqhXUtTXkKwPZgxyusdhU8fg7T5hnLtkFV2sBwSsqC7783EGtnCfpmHQQhrxctMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkuaHrMy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkuaHrMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299F3C2BCB4;
	Sun,  3 May 2026 23:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777852438;
	bh=rEFi151vOXN0oR6hSnac9cwr3nnupvnjPypyEmOZan8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkuaHrMyrv1cRfifn2FWemM+c/C63gVyay9vdRGLfh0HSXly+22NcoLdu1sQTcutc
	 QPMzdIljcXpvoW/svZoJg04pkNX7v/LQcFu7ymghQCIFMzFTyWpQqkLJXc3UEKI0JO
	 KqENnoiSM7FQEwgHGLciBi1+IiVMLjl8PpCGumfCgpPp7174azmNSFcSrnLLh+nI+K
	 xy90nUWH7hV9Jn5c0025S8V2IBKFED0g8wbaNs7fb2pCGr0HSkTIatsVL5ySj6DfvL
	 VHsvrm5zZ7WwnJwwAd1urGLrhHmAsDbOQwdSkckfjo3GjVDhIErCzCywzU9d1wfhiV
	 QX19uuHltIphQ==
Date: Sun, 3 May 2026 16:53:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] perf annotate-data: Fix libdw API contract
 violations
Message-ID: <affgFLhoLVT31zzW@z2>
References: <20260503003552.1063540-1-irogers@google.com>
 <20260503171032.1559338-1-irogers@google.com>
 <20260503171032.1559338-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260503171032.1559338-6-irogers@google.com>

On Sun, May 03, 2026 at 10:10:31AM -0700, Ian Rogers wrote:
> Check return values of `dwarf_aggregate_size` and `dwarf_formudata`.
> 
> Additionally:
>  - Avoid `vfprintf` undefined behavior with `NULL` strings by using
>    the `die_name()` helper for `dwarf_diename()` in `pr_*` calls.
>  - Use `die_get_data_member_location()` (updated to use
>    `dwarf_attr_integrate`) to correctly parse location expressions
>    for inherited member locations in the fallback path when
>    `dwarf_formudata()` fails.
> 
> Fixes: 2bc3cf575a16 ("perf annotate-data: Improve debug message with location info")
> Fixes: 4a111cadac85 ("perf annotate-data: Add member field in the data type")
> Fixes: 8b1042c425f6 ("perf annotate-data: Set bitfield member offset and size properly")
> Fixes: fc044c53b99f ("perf annotate-data: Add dso->data_types tree")
> Assisted-by: Gemini-CLI:Google Gemini 3
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v4:
>  - Safe DWARF name printing in annotate-data.
>  - Fix fallback location expression parsing for inherited data members.
> ---
>  tools/perf/util/annotate-data.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 1eff0a27237d..2eacbba51f32 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -74,7 +74,8 @@ void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
>  		break;
>  	}
>  
> -	dwarf_aggregate_size(die, &size);
> +	if (dwarf_aggregate_size(die, &size) != 0)
> +		size = 0;
>  
>  	strbuf_init(&sb, 32);
>  	die_get_typename_from_type(die, &sb);
> @@ -146,9 +147,9 @@ static void pr_debug_scope(Dwarf_Die *scope_die)
>  
>  	tag = dwarf_tag(scope_die);
>  	if (tag == DW_TAG_subprogram)
> -		pr_info("[function] %s\n", dwarf_diename(scope_die));
> +		pr_info("[function] %s\n", die_name(scope_die));
>  	else if (tag == DW_TAG_inlined_subroutine)
> -		pr_info("[inlined] %s\n", dwarf_diename(scope_die));
> +		pr_info("[inlined] %s\n", die_name(scope_die));
>  	else if (tag == DW_TAG_lexical_block)
>  		pr_info("[block]\n");
>  	else
> @@ -250,9 +251,12 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  	if (dwarf_aggregate_size(&die_mem, &size) < 0)
>  		size = 0;
>  
> -	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr))
> -		dwarf_formudata(&attr, &loc);
> -	else {
> +	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr)) {
> +		if (dwarf_formudata(&attr, &loc) != 0) {
> +			if (die_get_data_member_location(die, &loc) != 0)
> +				loc = 0;
> +		}
> +	} else {
>  		/* bitfield member */
>  		if (dwarf_attr_integrate(die, DW_AT_data_bit_offset, &attr) &&
>  		    dwarf_formudata(&attr, &loc) == 0)
> @@ -273,7 +277,9 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  				     dwarf_diename(die), (long)bit_size) < 0)
>  				member->var_name = NULL;
>  		} else {
> -			member->var_name = strdup(dwarf_diename(die));
> +			const char *name = dwarf_diename(die);
> +
> +			member->var_name = strdup(name);

This can be:		member->var_name = name ? strdup(name) : NULL;

Thanks,
Namhyung


>  		}
>  
>  		if (member->var_name == NULL) {
> @@ -370,7 +376,8 @@ static struct annotated_data_type *dso__findnew_data_type(struct dso *dso,
>  	if (dwarf_tag(type_die) == DW_TAG_typedef)
>  		die_get_real_type(type_die, type_die);
>  
> -	dwarf_aggregate_size(type_die, &size);
> +	if (dwarf_aggregate_size(type_die, &size) != 0)
> +		size = 0;
>  
>  	/* Check existing nodes in dso->data_types tree */
>  	key.self.type_name = type_name;
> @@ -1569,7 +1576,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  	offset = loc->offset;
>  
>  	pr_debug_dtp("CU for %s (die:%#lx)\n",
> -		     dwarf_diename(&cu_die), (long)dwarf_dieoffset(&cu_die));
> +		     die_name(&cu_die), (long)dwarf_dieoffset(&cu_die));
>  
>  	if (reg == DWARF_REG_PC) {
>  		if (get_global_var_type(&cu_die, dloc, dloc->ip, dloc->var_addr,
> @@ -1636,7 +1643,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
>  		}
>  
>  		pr_debug_dtp("found \"%s\" (die: %#lx) in scope=%d/%d (die: %#lx) ",
> -			     dwarf_diename(&var_die), (long)dwarf_dieoffset(&var_die),
> +			     die_name(&var_die), (long)dwarf_dieoffset(&var_die),
>  			     i+1, nr_scopes, (long)dwarf_dieoffset(&scopes[i]));
>  
>  		if (reg == DWARF_REG_PC) {
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
