Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02156320F;
	Sun, 30 Mar 2025 05:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743312664; cv=none; b=cfHfLhUPSOHvrHdAMaJstzmyBiEE73Z9qzl+73k2A8NUEVNA44ZQNzm8+BnfIzjH/FAzrFRyV3lWk0/G0Y2UOSSOtCE1asw9X9i1U0PrhO/GJNiGXr2YxWGH7rAVk1FPMwgUlwSIItp47O/GQC7et/8k9jl7/6RD17NhRHBCue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743312664; c=relaxed/simple;
	bh=NFU/YikADQxcJQeCAfrzyx+W1ZgmCapXzp4xW1oVzkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZEiUclA9+juxBAHOgypCjPpndxV6mrgUsSakb4ofDqgH9Wn0a6TVf5HH9oOOszoTxHV3Tb1kGlAGWkbrANSkbmAYCJgeJJJEM3cdWdEcrLIgzc+YceubSmkAxpuqik7tpukZQWIHQaL8gfDx2NoEVOsQj9IP9Rw0EFTFkP1yjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMljdRl6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMljdRl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5EBC4CEDD;
	Sun, 30 Mar 2025 05:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743312663;
	bh=NFU/YikADQxcJQeCAfrzyx+W1ZgmCapXzp4xW1oVzkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMljdRl6RVvimS+EeN6782HtBFiJjgINqI62G+m+pB30edB9+/37x+Qm4IhmpHevi
	 5uWHIndM1LCpGOjbqTk4hEoOrzM8LqqHKiBv9eRL/2/DpH1OMP9rmdiLqmbc3joQYW
	 Zynlii8eRjmXmnatXyzaWNn+BhkWN/Tc3SPW1sHKxhsfMP/6rF7dRBcgQqfDLXNM65
	 +wwsIqnSdfoiSBDvYlwMV29V0wKwnPX5a5b4B+dZxZ074PiUfQFwkG4PggXp7HShn1
	 4Cnmn2C84BTgeocjOKS0Izg0a5yBSYD4nx0abnHiUF74eP6tlaGa27OnT4Yqqo1haw
	 jog/dWHYhA4vQ==
Date: Sat, 29 Mar 2025 22:31:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf trace: Fix possible insufficient allocation of
 argument formats
Message-ID: <Z-jXFffv8MMuo2p3@z2>
References: <20250327150712.1966188-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327150712.1966188-1-howardchu95@gmail.com>

Hello,

On Thu, Mar 27, 2025 at 08:07:12AM -0700, Howard Chu wrote:
> In my previous fix of runtime error(Link:
> https://lore.kernel.org/linux-perf-users/20250122025519.361873-1-howardchu95@gmail.com/),

We usually handle this by adding a footnote style link like, [1].

> I made a mistake of decrementing one unconditionally, regardless of
> whether an extra 'syscall_nr' or 'nr' field was present in
> libtraceevent's tp_format. This may cause perf trace to allocate one
> fewer arg_fmt entry than needed for the accurate representation of syscall
> arguments.
> 
> This patch corrects the mistake by checking the presence of'syscall_nr' or
> 'nr', and adjusting the length of arg_fmt[] accordingly.
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Fixes: c7b87ce0dd10 ("perf trace: Fix runtime error of index out of bounds")

And add the link here.

[1] (actual URL here)

Also you need to keep three dashes "---" before the change log so that
it can be treated as comments (and not added to the commit message).

Please take a look at my previous posting.

https://lore.kernel.org/r/20250326044001.3503432-1-namhyung@kernel.org

Thanks,
Namhyung


> 
> Changes in v4:
> - Make the patch apply
> 
> Changes in v3:
> - Add 'Fixes:' tag
> 
> Changes in v2:
> - Simplify the code (written by Namhyung)
> 
>  tools/perf/builtin-trace.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index a102748bd0c9..439e152186da 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2022,9 +2022,6 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
>  {
>  	int idx;
>  
> -	if (nr_args == RAW_SYSCALL_ARGS_NUM && sc->fmt && sc->fmt->nr_args != 0)
> -		nr_args = sc->fmt->nr_args;
> -
>  	sc->arg_fmt = calloc(nr_args, sizeof(*sc->arg_fmt));
>  	if (sc->arg_fmt == NULL)
>  		return -1;
> @@ -2034,7 +2031,6 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
>  			sc->arg_fmt[idx] = sc->fmt->arg[idx];
>  	}
>  
> -	sc->nr_args = nr_args;
>  	return 0;
>  }
>  
> @@ -2176,14 +2172,9 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
>  		return err;
>  	}
>  
> -	/*
> -	 * The tracepoint format contains __syscall_nr field, so it's one more
> -	 * than the actual number of syscall arguments.
> -	 */
> -	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - 1))
> -		return -ENOMEM;
> -
>  	sc->args = sc->tp_format->format.fields;
> +	sc->nr_args = sc->tp_format->format.nr_fields;
> +
>  	/*
>  	 * We need to check and discard the first variable '__syscall_nr'
>  	 * or 'nr' that mean the syscall number. It is needless here.
> @@ -2194,6 +2185,9 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
>  		--sc->nr_args;
>  	}
>  
> +	if (syscall__alloc_arg_fmts(sc, sc->nr_args))
> +		return -ENOMEM;
> +
>  	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
>  	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
>  
> -- 
> 2.45.2
> 
