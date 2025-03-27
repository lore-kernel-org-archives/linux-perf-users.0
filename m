Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8438225D7;
	Thu, 27 Mar 2025 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743059801; cv=none; b=LrdNavx8RfSkjBt1i8xUuwEp5BT8ttNqPxWYFY/5qgz8mX4eYpBjy3KSkUxC4yU65xKAClHLPCN1yZ2+ohbjimPYXkUqnKbuaVSsM66gvA+h0JxdB3UrAuY168U2Ol/ejY0t2QKytiQ52GsgojXef4YtRrkS6WL1xQaKbXE+IK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743059801; c=relaxed/simple;
	bh=zhHvo/ZDWQ4l9fAWfTKydbGpXbrK382IHtHkv8djzso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHwyMXCWcPruIQ4+ajGEzjxHNdf41TsV1PRpV4nQQe1Fwez5NeKuxgf/HnMrnlqC9wCoIG/XXCBMvT5nTrZaNGaJNji0mNuRIxhKjg1LL1vDTkUo+aTNhsztwfhn7z052QrHw2qOQmm3cDCjJne/qPyqEBWQnP17iTDvV0wqW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMY1eFDG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMY1eFDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF28BC4CEE4;
	Thu, 27 Mar 2025 07:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743059800;
	bh=zhHvo/ZDWQ4l9fAWfTKydbGpXbrK382IHtHkv8djzso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMY1eFDGsR6/qHesdAg+bEH36xpcXqyVhojK6xUUy/weCfVN38VQW5WoOrJgZ6SKN
	 prjkSvgEnIRlKuQM114Vnh3NlTPa4m7V2aWqb2jN85/Ia1eNUrKMDQVwzbW87nI7CP
	 ynEFWaIPRJH40ZJCkxA4mGjt3ZqnieM2CIxgzVmNymMFTk07asw0p+ZYE6psYibJH7
	 kTS/nkgBoDGu34rIG87cnx6bjeF319p2l/IX/kYshTjKU6X5ITYbqtBHct1jlqNOKF
	 FUD/YZ5HBEAtrMSnzYTMaFPznx+uKZH4VYmVJlzClusUGyPed15IKIPBgkakzjQAIW
	 1/qzIyjGZ85Mw==
Date: Thu, 27 Mar 2025 00:16:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf trace: Fix possible insufficient allocation of
 argument formats
Message-ID: <Z-T7VohMjkNolhCi@z2>
References: <20250326200540.1843856-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326200540.1843856-1-howardchu95@gmail.com>

Hello,

On Wed, Mar 26, 2025 at 01:05:40PM -0700, Howard Chu wrote:
> Changes in v2:
> * Simplify the code (written by Namhyung)

Please move this below "---" after S-o-b tags so that it can be ignored
when applying.

> 
> In my previous fix of runtime error(Link:
> https://lore.kernel.org/linux-perf-users/20250122025519.361873-1-howardchu95@gmail.com/),
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

Also please add the Fixes tag.

Thanks,
Namhyung

> ---
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
