Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0CD283FCF;
	Sun,  3 May 2026 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777851370; cv=none; b=MvD/6spvwIMaEEZ+lI0P6VAhAN2lFy4tvC37u49s3MV0aZoqeJHd2DKzXsQl5z9CH0RVxhh6m9Q9gPNdozmy3q3Xz3ufwtoeWl6s7pXeXLcApp2AinFOiuhpDAt5SXLWNtEHbK7nJmL4slNli9SeBfBCl6Kh2ZdZ7TrpWt7F2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777851370; c=relaxed/simple;
	bh=I9lNgx+QP3h44dz9qnDTI9JpGrYkiuizDKXtgLSqXtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba5+VeK+AcpAyLJU1edIyvcr51xP/H54m1Jwpv+hvzIfKqypfu8O8xAIivXYFlXil+ihKcHTqCUeWvdxVEawgTYwU0fHVr/5yzRi90lqYxeHwxbInFTHh9ByT0gcZjlNh5yMJ9MZ9NRJwHs3O3mptJ+OyQdcru5l07Q3y+M39fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW5TFrhS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW5TFrhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6220C2BCB4;
	Sun,  3 May 2026 23:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777851370;
	bh=I9lNgx+QP3h44dz9qnDTI9JpGrYkiuizDKXtgLSqXtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dW5TFrhS1P8r/6KrJPDgxwKCwIIakVl8weWZGhPGu82rV+suEGdNCBTS8beiqXCmE
	 sGmThR+U5eBv+zTcJ8JFedIjljcNqS6On0IISNPctTWsJ9MX7VOMcpAHezh0nP9i2r
	 da+F89MvCoRBnx5EFZydwpv3Luld7nvuaM/ucfdNPWCGJkvB8fHRcS9aT7t1O6mbjo
	 Tycjl42OSBUm6/Y83ZMy/Ogm2v9jCN34NN2OIS/mF6oWbbygSzeBucO1CDDIsgkFiP
	 u7DpF4mBRXfp/ocrC4IXxW73txhpPuYrqXqpLGfhF8Jx6TkuQxHi7wHajbLtq8xvb0
	 mHIiktvupOTuA==
Date: Sun, 3 May 2026 16:36:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] perf dwarf-aux: Fix libdw API contract violations
Message-ID: <affb6OqJdrhRbBgT@z2>
References: <20260503003552.1063540-1-irogers@google.com>
 <20260503171032.1559338-1-irogers@google.com>
 <20260503171032.1559338-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260503171032.1559338-3-irogers@google.com>

On Sun, May 03, 2026 at 10:10:28AM -0700, Ian Rogers wrote:
> Check return values of `dwarf_decl_line` (where non-optional),
> `dwarf_getfuncs`, and `dwarf_lineaddr` to prevent using uninitialized
> stack variables or incorrectly reporting success on failure.
> 
> For the root DIE in `die_walk_lines()`, `dwarf_decl_line` and
> `die_get_decl_file` are optional and their failures are handled
> gracefully to avoid breaking line walking on valid functions.
> 
> Additionally:
>  - Add NULL pointer protection for `strcmp()` in `die_walk_lines()`
>    when `inf` or `decf` are NULL to prevent crashes on generated
>    code.
>  - Use `dwarf_attr_integrate` in `die_get_data_member_location` to
>    correctly resolve inherited member locations (e.g. via abstract
>    origin or specification).
> 
> Fixes: 57f95bf5f882 ("perf probe: Show correct statement line number by perf probe -l")
> Fixes: 3f4460a28fb2 ("perf probe: Filter out redundant inline-instances")
> Fixes: 75186a9b09e4 ("perf probe: Fix to show lines of sys_ functions correctly")
> Fixes: e0d153c69040 ("perf-probe: Move dwarf library routines to dwarf-aux.{c, h}")
> Fixes: 6243b9dc4c99 ("perf probe: Move dwarf specific functions to dwarf-aux.c")
> Assisted-by: Gemini-CLI:Google Gemini 3
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v4:
>  - Fix strcmp(NULL) risk and inherited member location fallbacks in dwarf-aux.c.
> ---
>  tools/perf/util/dwarf-aux.c | 34 ++++++++++++++++------------------
>  tools/perf/util/dwarf-aux.h |  5 +++++
>  2 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 109a166a6d19..a8ab1c30d0ac 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -125,7 +125,8 @@ int cu_find_lineinfo(Dwarf_Die *cu_die, Dwarf_Addr addr,
>  	    && die_entrypc(&die_mem, &faddr) == 0 &&
>  	    faddr == addr) {
>  		*fname = die_get_decl_file(&die_mem);
> -		dwarf_decl_line(&die_mem, lineno);
> +		if (dwarf_decl_line(&die_mem, lineno) != 0)
> +			return -ENOENT;
>  		goto out;
>  	}
>  
> @@ -459,7 +460,7 @@ int die_get_data_member_location(Dwarf_Die *mb_die, Dwarf_Word *offs)
>  	size_t nexpr;
>  	int ret;
>  
> -	if (dwarf_attr(mb_die, DW_AT_data_member_location, &attr) == NULL)
> +	if (dwarf_attr_integrate(mb_die, DW_AT_data_member_location, &attr) == NULL)
>  		return -ENOENT;
>  
>  	if (dwarf_formudata(&attr, offs) != 0) {
> @@ -795,8 +796,7 @@ static int __die_walk_instances_cb(Dwarf_Die *inst, void *data)
>  
>  	/* Ignore redundant instances */
>  	if (dwarf_tag(inst) == DW_TAG_inlined_subroutine) {
> -		dwarf_decl_line(origin, &tmp);
> -		if (die_get_call_lineno(inst) == tmp) {
> +		if (dwarf_decl_line(origin, &tmp) == 0 && die_get_call_lineno(inst) == tmp) {
>  			tmp = die_get_decl_fileno(origin);
>  			if (die_get_call_fileno(inst) == tmp)
>  				return DIE_FIND_CB_CONTINUE;
> @@ -950,11 +950,6 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
>  		cu_die = dwarf_diecu(rt_die, &die_mem, NULL, NULL);
>  		dwarf_decl_line(rt_die, &decl);
>  		decf = die_get_decl_file(rt_die);
> -		if (!decf) {
> -			pr_debug2("Failed to get the declared file name of %s\n",
> -				  dwarf_diename(rt_die));
> -			return -EINVAL;
> -		}

Why is this part removed?


>  	} else
>  		cu_die = rt_die;
>  	if (!cu_die) {
> @@ -998,12 +993,11 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
>  			if (die_find_inlinefunc(rt_die, addr, &die_mem)) {
>  				/* Call-site check */
>  				inf = die_get_call_file(&die_mem);
> -				if ((inf && !strcmp(inf, decf)) &&
> +				if ((inf == decf || (inf && decf && !strcmp(inf, decf))) &&
>  				    die_get_call_lineno(&die_mem) == lineno)
>  					goto found;
>  
> -				dwarf_decl_line(&die_mem, &inl);
> -				if (inl != decl ||
> +				if (dwarf_decl_line(&die_mem, &inl) != 0 || inl != decl ||
>  				    decf != die_get_decl_file(&die_mem))
>  					continue;
>  			}
> @@ -1034,8 +1028,10 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
>  			.data = data,
>  			.retval = 0,
>  		};
> -		dwarf_getfuncs(cu_die, __die_walk_culines_cb, &param, 0);
> -		ret = param.retval;
> +		if (dwarf_getfuncs(cu_die, __die_walk_culines_cb, &param, 0) < 0)
> +			ret = -EINVAL;
> +		else
> +			ret = param.retval;
>  	}
>  
>  	return ret;
> @@ -1939,10 +1935,12 @@ static bool die_get_postprologue_addr(unsigned long entrypc_idx,
>  			break;
>  	}
>  
> -	dwarf_lineaddr(line, postprologue_addr);
> -	if (*postprologue_addr >= highpc)
> -		dwarf_lineaddr(dwarf_onesrcline(lines, i - 1),
> -			       postprologue_addr);
> +	if (dwarf_lineaddr(line, postprologue_addr) != 0)
> +		return false;
> +	if (*postprologue_addr >= highpc) {
> +		if (dwarf_lineaddr(dwarf_onesrcline(lines, i - 1), postprologue_addr) != 0)
> +			return false;
> +	}
>  
>  	return true;
>  }
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index a79968a2e573..161f0bf980b6 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -10,6 +10,11 @@
>  #include <elfutils/libdwfl.h>
>  #include <elfutils/version.h>
>  
> +static inline const char *die_name(Dwarf_Die *die)
> +{
> +	return dwarf_diename(die) ?: "<unknown>";
> +}
> +

Please move it where it's used.

Thanks,
Namhyung


>  struct strbuf;
>  
>  /* Find the realpath of the target file */
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
