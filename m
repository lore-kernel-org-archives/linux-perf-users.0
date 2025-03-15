Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6231199B9;
	Sat, 15 Mar 2025 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742001122; cv=none; b=EsZazueF354IkfPmPJ3+BoQo4CTwtYGlM6NoYFTDBvV83OZ7QyBfOGsV1eaOwwsr6vnT/6rT/QvL4dist5Y/qSGUnKmfqvT/zJoAV73uNiFtDP8mP9ABFm6kPUQ0wDbrBKXOzlPUhV11xV7CWYx7e3H3gKsicpejMdKbD07Thfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742001122; c=relaxed/simple;
	bh=VxVUeQhVDSDp3eITSl7EuMQGY6SLNqQttr8K5TBU5UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M19lW4bt/j5N+w/lyaWYFUFdfLfmIE/hrDobTocUp6hkmkj64TphS8e0KZNQFcMNvqF9i0dyULA2OUslUn9CVRkPjam9wBgT8ingPNpXCEOVJbwZMi8uhOmNIcGNjLtCgHtmUgkFyFQYdCqxTNF1amzdeENFnjg64hdMJmkKEu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcPBYv+w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcPBYv+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E22C4CEE3;
	Sat, 15 Mar 2025 01:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742001121;
	bh=VxVUeQhVDSDp3eITSl7EuMQGY6SLNqQttr8K5TBU5UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NcPBYv+w5et57n2X/eulWxinRoNDsQQ5Gpf0iLPNuN+MKseTHDULxnv6jqaolDWtt
	 1HERGD7lzI/xupScsE/DCQR5DOh5iYlHnhAWlktRTiBHIR2x/UAW0H/uOXDRxhQ2om
	 erLQaWCtQFAXRMIwDjBqk3T/DuAvfaxiaEW+DjkEvxn0FrTn50qPGSpRRMR6u9Om7n
	 uvU2yssZZsE8VPdvj74UBKBqMvLMS6aVpXpuKJvp5fwAY01ASZbSaxnziccTAr54Se
	 vWNMAMe7UZJw4kSaEfPPkO3wkm3NLT1GbR6qMFc0ZX34XhSbns8y6S/KS+6sPjxMuw
	 xd7SUxdrB4hrg==
Date: Fri, 14 Mar 2025 18:11:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yunseong Kim <yskelg@gmail.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@linux.dev>,
	Michael Petlan <mpetlan@redhat.com>,
	Tavian Barnes <tavianator@tavianator.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf libunwind: Fixup conversion
 perf_sample->user_regs to a pointer
Message-ID: <Z9TT3tGq4TJ76Tm9@google.com>
References: <20250313033121.758978-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313033121.758978-1-irogers@google.com>

On Wed, Mar 12, 2025 at 08:31:21PM -0700, Ian Rogers wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> The dc6d2bc2d893a878 ("perf sample: Make user_regs and intr_regs optional") misses
> the changes to a file, resulting in this problem:
> 
>   $ make LIBUNWIND=1 -C tools/perf O=/tmp/build/perf-tools-next install-bin
>   <SNIP>
>     CC      /tmp/build/perf-tools-next/util/unwind-libunwind-local.o
>     CC      /tmp/build/perf-tools-next/util/unwind-libunwind.o
>   <SNIP>
>   util/unwind-libunwind-local.c: In function ‘access_mem’:
>   util/unwind-libunwind-local.c:582:56: error: ‘ui->sample->user_regs’ is a pointer; did you mean to use ‘->’?
>     582 |         if (__write || !stack || !ui->sample->user_regs.regs) {
>         |                                                        ^
>         |                                                        ->
>   util/unwind-libunwind-local.c:587:38: error: passing argument 2 of ‘perf_reg_value’ from incompatible pointer type [-Wincompatible-pointer-types]
>     587 |         ret = perf_reg_value(&start, &ui->sample->user_regs,
>         |                                      ^~~~~~~~~~~~~~~~~~~~~~
>         |                                      |
>         |                                      struct regs_dump **
> <SNIP>
>   ⬢ [acme@toolbox perf-tools-next]$ git bisect bad
>   dc6d2bc2d893a878e7b58578ff01b4738708deb4 is the first bad commit
>   commit dc6d2bc2d893a878e7b58578ff01b4738708deb4 (HEAD)
>   Author: Ian Rogers <irogers@google.com>
>   Date:   Mon Jan 13 11:43:45 2025 -0800
> 
>       perf sample: Make user_regs and intr_regs optional
> 
> Detected using:
> 
>   make -C tools/perf build-test
> 
> Fixes: dc6d2bc2d893a878 ("perf sample: Make user_regs and intr_regs optional")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Charlie Jenkins <charlie@rivosinc.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Leo Yan <leo.yan@linux.dev>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tavian Barnes <tavianator@tavianator.com>
> Cc: Veronika Molnarova <vmolnaro@redhat.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Reviewed-by: Ian Rogers <irogers@google.com>

I think you need to add your own Signed-off-by in this case.
I'll change it for you, ok?

Thanks,
Namhyung


> ---
> v2: Ensure user_regs isn't NULL when read, spotted by Namhyung.
> ---
>  tools/perf/util/unwind-libunwind-local.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> index 16c2b03831f3..5f4387e2423a 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -579,12 +579,12 @@ static int access_mem(unw_addr_space_t __maybe_unused as,
>  	int ret;
>  
>  	/* Don't support write, probably not needed. */
> -	if (__write || !stack || !ui->sample->user_regs.regs) {
> +	if (__write || !stack || !ui->sample->user_regs || !ui->sample->user_regs->regs) {
>  		*valp = 0;
>  		return 0;
>  	}
>  
> -	ret = perf_reg_value(&start, &ui->sample->user_regs,
> +	ret = perf_reg_value(&start, perf_sample__user_regs(ui->sample),
>  			     perf_arch_reg_sp(arch));
>  	if (ret)
>  		return ret;
> @@ -628,7 +628,7 @@ static int access_reg(unw_addr_space_t __maybe_unused as,
>  		return 0;
>  	}
>  
> -	if (!ui->sample->user_regs.regs) {
> +	if (!ui->sample->user_regs || !ui->sample->user_regs->regs) {
>  		*valp = 0;
>  		return 0;
>  	}
> @@ -637,7 +637,7 @@ static int access_reg(unw_addr_space_t __maybe_unused as,
>  	if (id < 0)
>  		return -EINVAL;
>  
> -	ret = perf_reg_value(&val, &ui->sample->user_regs, id);
> +	ret = perf_reg_value(&val, perf_sample__user_regs(ui->sample), id);
>  	if (ret) {
>  		if (!ui->best_effort)
>  			pr_err("unwind: can't read reg %d\n", regnum);
> @@ -741,7 +741,7 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
>  	unw_cursor_t c;
>  	int ret, i = 0;
>  
> -	ret = perf_reg_value(&val, &ui->sample->user_regs,
> +	ret = perf_reg_value(&val, perf_sample__user_regs(ui->sample),
>  			     perf_arch_reg_ip(arch));
>  	if (ret)
>  		return ret;
> @@ -808,7 +808,7 @@ static int _unwind__get_entries(unwind_entry_cb_t cb, void *arg,
>  		.best_effort  = best_effort
>  	};
>  
> -	if (!data->user_regs.regs)
> +	if (!data->user_regs || !data->user_regs->regs)
>  		return -EINVAL;
>  
>  	if (max_stack <= 0)
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog
> 
