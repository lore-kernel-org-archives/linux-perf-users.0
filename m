Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837703101A2;
	Wed, 11 Feb 2026 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770776986; cv=none; b=UAxlFg4SmUOMQKEvUwovM5PTPE/2u5MD6979FQIP0fI2qCBaSioRl6BfJvROa7Zoyp4DjrJuZrWj8uYEPUPQwSnnQNelAm2xZnPofZ/+31o3nAVxIGCHaE1jtQokCcjXQasreid82t8eTvTCgDod933texIJ9ltFg5c6+oki8ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770776986; c=relaxed/simple;
	bh=X5uVI3RWd8NgGTmB2Cu/NP0MbENbpF8QSQvF8I75YEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+vML5eLh37hByOnzYLCNt54lO9OHoPl6LcQ5M+x7thAVZWu7UJIOb+T1t9bRVLSAS38gUawa65PJBgD+VBcF9HzmRln1mqVwgW84DbhpvJPsnkR+4ilr64QW5tVR/ZP2O4BVeN79sb7Xsd348parv2DmHQyCXfp7pXGOwjBlHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdyl0Atm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdyl0Atm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D39C116C6;
	Wed, 11 Feb 2026 02:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770776986;
	bh=X5uVI3RWd8NgGTmB2Cu/NP0MbENbpF8QSQvF8I75YEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rdyl0AtmO/qREEkI+HyqxDabCZcP4Xx/4uCAnVSsecF6WgPP29JH2+YSRK4X4jvdN
	 R2gf7GyGD14Q82Ye4APF/yNAgSIjb65Cvos/b5B4HHF+MhlE5bjVqJVC5rMsPxXaVw
	 9FFxxLzFDyl747zoAi5CuqlbZtPu3g80xMs8lODUvLZ0voBP+/M2jjzD6+bylBuIp3
	 5zT29EjSLv4n1Cf+HKG+eeMye1R6RQW5CBamE2TYcG/u1rK5E5WHPdMgQ8vgrOVjG/
	 bEGm5mejPV282RfNTGuT2PKE3AD+dh/Giv+LkwtSzpOFqAZr+u3RlE70zSrdj133GN
	 PKVuzdOn5TN2w==
Date: Tue, 10 Feb 2026 18:29:44 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zli94@ncsu.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, xliuprof@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/11] perf annotate-data: Collect global variables
 without name
Message-ID: <aYvpmHZUtNx5O5qr@google.com>
References: <20260127020617.2804780-1-zli94@ncsu.edu>
 <20260127020617.2804780-7-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127020617.2804780-7-zli94@ncsu.edu>

On Mon, Jan 26, 2026 at 09:04:59PM -0500, Zecheng Li wrote:
> Previously, global_var__collect() required get_global_var_info() to
> succeed (i.e., the variable must have a symbol name) before caching a
> global variable. This prevented variables that exist in DWARF but lack
> symbol table coverage from being cached.

Do you have any example?  It's not clear to me why global variables
don't have name.

Thanks,
Namhyung

> 
> Remove the symbol table requirement since DW_OP_addr already provides
> the variable's address directly from DWARF. The symbol table lookup is
> now optional to obtain the variable name when available.
> 
> Also remove the var_offset != 0 check, which was intended to skip
> variables where the access address doesn't match the symbol start.
> The symbol table lookup is now optional and I found removing this check
> has no effect on the annotation results for both kernel and userspace
> programs.
> 
> Test results show improved annotation coverage especially for userspace
> programs with RIP-relative addressing instructions.
> 
> Signed-off-by: Zecheng Li <zli94@ncsu.edu>
> ---
>  tools/perf/util/annotate-data.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 8ea3e8b024e8..970238bc81b7 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -774,12 +774,7 @@ static void global_var__collect(struct data_loc_info *dloc)
>  			if (!dwarf_offdie(dwarf, pos->die_off, &type_die))
>  				continue;
>  
> -			if (!get_global_var_info(dloc, pos->addr, &var_name,
> -						 &var_offset))
> -				continue;
> -
> -			if (var_offset != 0)
> -				continue;
> +			get_global_var_info(dloc, pos->addr, &var_name, &var_offset);
>  
>  			global_var__add(dloc, pos->addr, var_name, &type_die);
>  		}
> -- 
> 2.52.0
> 
