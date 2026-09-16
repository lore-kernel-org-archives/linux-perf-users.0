Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84074F4746;
	Wed, 16 Sep 2026 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566940; cv=none; b=Gv5qcgzoCKigzAUCY3TPVazDg66qIbbcnAwd1f351GVOk/I4X/0OKpA7xIsnAZR8WRHQEz9q6JDsUGoaL/C33v/Iao3QWEa3tX5xoJWz2fKb2uMWVnXNXT/5mxHuf5PoxD2RFHxUIupMYCMIUGEh6GZ5CjalB2RJc3yRLeNhWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566940; c=relaxed/simple;
	bh=r5iSzj8clLV7VEGkPNoN6Ep2Cm/5urm4aGSrADjdWa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTMeBbqe6Lev63Ih1acf4780U0vruBYVwhJ3tKlVuwiyPUpuW2o5UZzC2lK+i05XagPGg0wc4n1KZlYkdUrgA/y+KjcJYoUMVAtj9XhDzgK8hBY06Hy35IxSlmJ2zR1/SzhSGczmqJmsE6Ob+hqT296FOXKKStuvmgLc/9g+WrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS0ciWPm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS0ciWPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E79A1F000FF;
	Wed, 16 Sep 2026 13:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566926;
	bh=OTxyEhJMxuk5Pjf/eVkUDSq9wsvcYeccJugcO02f5B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JS0ciWPmY0kaKtJYyMAEptYFHghx7v9oQMf7Q8/dzrIfeE1ZSiCg5jFmgxMoWZDWT
	 OynqQMe5FslIETBnS6JdcNxEtTYocCNZX/wxR+swBe8jYvTdYWsST7rum5c0xCYkjX
	 pYtbXaBARInTB6vump61zFyskVkBmHkT1+5yNxFtYZ0b2xdvr3tYxYiN0x9+ZUS84W
	 by/DrUsjwSFFUwqUIy7g8ceaxFOWe6QX2oNfW/6tbIznh/xfdEKW0MkfDIJhbC4I+w
	 Kr/7DgeBlmts7N7wdutrKAnPdFSP7WuO2WIn6ttnD67cD8e1HIJdNgH/wKFqFvy/R8
	 AfgSvWTa4h6lg==
Date: Wed, 16 Sep 2026 10:55:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: Re: [PATCH] perf bench messaging: Fix the formatting issue when
 printing.
Message-ID: <aqqfyX9nkOrVqwUb@x2>
References: <20250922091736.2798-1-liujing@cmss.chinamobile.com>
 <20260915221122.2174928-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915221122.2174928-1-irogers@google.com>

On Tue, Sep 15, 2026 at 03:11:22PM -0700, Ian Rogers wrote:
> From: liujing <liujing@cmss.chinamobile.com>
> 
> The unsigned int type should use the %u format specifier when
> printing with printf or related functions.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> Reviewed-by: Ian Rogeres <irogers@google.com>

s/Rogeres/Rogers/g

Applied,

- Arnaldo

> ---
>  tools/perf/bench/sched-messaging.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
> index 4fb6657fc826..c5c9a7a1d7db 100644
> --- a/tools/perf/bench/sched-messaging.c
> +++ b/tools/perf/bench/sched-messaging.c
> @@ -338,9 +338,9 @@ int bench_sched_messaging(int argc, const char **argv)
>  
>  	switch (bench_format) {
>  	case BENCH_FORMAT_DEFAULT:
> -		printf("# %d sender and receiver %s per group\n",
> +		printf("# %u sender and receiver %s per group\n",
>  		       num_fds, thread_mode ? "threads" : "processes");
> -		printf("# %d groups == %d %s run\n\n",
> +		printf("# %u groups == %u %s run\n\n",
>  		       num_groups, num_groups * 2 * num_fds,
>  		       thread_mode ? "threads" : "processes");
>  		printf(" %14s: %lu.%03lu [sec]\n", "Total time",
> -- 
> 2.55.0.1032.g73a4cd73de-goog
