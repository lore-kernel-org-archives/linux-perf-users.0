Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C9A2E2852;
	Wed, 30 Sep 2026 04:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741685; cv=none; b=Lcy+NtVYI6/mnLOrTFVjxfOJM2iCegED9ibKPd2BubH62NAzospx2hnfpX0DEEhUGuX82VCXGjFThk592V+8K5UxIis4VLcj218uJoOMKgW+kAANdqG3zl29qgSiHfmWR8b2Q1a2Ejo23dFcrJrenVWYM89K6qTQasErdoHVfQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741685; c=relaxed/simple;
	bh=jjr0x9GEMe59oN8Fe5oSAuhyMph0s3vcqGFw7Zq42Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0txriScs3/F96yKIsznWX6Xz6njeWaQ9jC6CjUmTvZnlTbPRLMqnMefbSV7Nnvp9uIY7ZJP/uM6urcJQhlA6uYOtxUgpH/BV6WpU1rJLVI5VwiXwJHDC7qas5WXf4m+rjssrSZ0ijts9A73/La9QeScMYhNJxh13/ShOOIJY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fahy4+/+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fahy4+/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEF51F000FF;
	Wed, 30 Sep 2026 04:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790741683;
	bh=GBdO+MUgx6omg7Ncxw/r9w3/Tp4/zvfEcWT1UDOH9q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fahy4+/+g0fFOrIa796o2tCEY8y0vlQbvOkYZXffp2qwNLKp/Pnx9dgHTWt4QxStP
	 afgvqmcVSYdzXrgHvvZn5EnLjQlUlfnE3nlo0FFyHc1d/t5277vW7mU7L4VqGonN8x
	 JPlAvZO+p6/0BrPl8+u50l2dzCNj778Y5DKnqNCRNjTpii2cud/AiAmLy9icJtkfCa
	 wP0TiUgGcBp22rCj8efaFT2L8MhSNyvH3ua5IUW2WIBTIHZk1/kZtOxTYh4istLFKI
	 wG609PcjnXUYhNyRx7WhRsOWYe9CoJiAAjIG6oGwUcVyBjwlp42WhNZq0DON0XWUxl
	 borVVABtFevqQ==
Date: Tue, 29 Sep 2026 21:14:41 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/26] perf trace: Don't read sample padding as an
 augmented argument
Message-ID: <aryMsXXeXba1Q6Vx@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928182605.3649015-4-irogers@google.com>

On Mon, Sep 28, 2026 at 11:25:42AM -0700, Ian Rogers wrote:
> The kernel pads PERF_SAMPLE_RAW data to a u64 boundary without zeroing
> the padding, so a syscall record without augmented arguments still has
> up to 7 trailing bytes of stale data. syscall__augmented_args() passes
> these to the beautifiers as a struct augmented_arg, whose size is then
> garbage, causing a crash in syscall_arg__scnprintf_buf().
> 
> Ignore trailing data shorter than a struct augmented_arg.
> 
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/arJ-gpzqOHk-gF8T@x2/
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index d327603ae454..c39de91140a0 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2961,26 +2961,29 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
>  	 * traffic to just what is needed for each syscall.
>  	 */
>  	int args_size = raw_augmented_args_size ?: sc->args_size;
> +	static uintptr_t argbuf[1024]; /* assuming single-threaded */
>  
>  	*augmented_args_size = sample->raw_size - args_size;
> -	if (*augmented_args_size > 0) {
> -		static uintptr_t argbuf[1024]; /* assuming single-threaded */
> -
> -		if ((size_t)(*augmented_args_size) > sizeof(argbuf))
> -			return NULL;
> +	/*
> +	 * The raw data is padded to a u64 boundary with stale bytes, so less
> +	 * than a struct augmented_arg is only padding.
> +	 */

Confusingly we have a very large struct augmented_arg in the BPF code
and it made me wonder..  Maybe we need to rename one of them later.

Anyway this looks good now.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> +	if (*augmented_args_size < (int)sizeof(struct augmented_arg) ||
> +	    (size_t)(*augmented_args_size) > sizeof(argbuf)) {
> +		*augmented_args_size = 0;
> +		return NULL;
> +	}
>  
> -		/*
> -		 * The perf ring-buffer is 8-byte aligned but sample->raw_data
> -		 * is not because it's preceded by u32 size.  Later, beautifier
> -		 * will use the augmented args with stricter alignments like in
> -		 * some struct.  To make sure it's aligned, let's copy the args
> -		 * into a static buffer as it's single-threaded for now.
> -		 */
> -		memcpy(argbuf, sample->raw_data + args_size, *augmented_args_size);
> +	/*
> +	 * The perf ring-buffer is 8-byte aligned but sample->raw_data
> +	 * is not because it's preceded by u32 size.  Later, beautifier
> +	 * will use the augmented args with stricter alignments like in
> +	 * some struct.  To make sure it's aligned, let's copy the args
> +	 * into a static buffer as it's single-threaded for now.
> +	 */
> +	memcpy(argbuf, sample->raw_data + args_size, *augmented_args_size);
>  
> -		return argbuf;
> -	}
> -	return NULL;
> +	return argbuf;
>  }
>  
>  static int trace__sys_enter(struct trace *trace,
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
