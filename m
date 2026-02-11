Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7372318BA7;
	Wed, 11 Feb 2026 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811310; cv=none; b=qd9wPJK3xMVHnN7Luas/LX/0Kqqkp2IFOb0/eFGzLhsuRA5grNu/eBbRl/DvpZKQ8OaQCZLAfSwL30GlKjOQvnUr0J1TmFHAaCfhu+rZSqLeLXfSNamZ9P+cwdHSUY+41TY7kskg+6CrRFU6HsNGIQKzMaF3oL7SfcwPBoxuork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811310; c=relaxed/simple;
	bh=McuLMSlGddF2uo8OP2j+Uw1HsJkJDUqgLzWOqo6zZ1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/6gX5Bb4teBpevLNGHeRm/EkCO84449WzaL+iPJtNuf4cvi7Wega6a7z9FW2sNI5XVJTZ7JbEIC2Eg3X+1vtEEUyO+i1gKOfsZSgMcTtbXvIIJfBj40yvAb5SWXkaj3xXxNdi715eYM0zraot1km8xx2cXo036UZhaXirAYSCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjJpjlIm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjJpjlIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1DEC4CEF7;
	Wed, 11 Feb 2026 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770811310;
	bh=McuLMSlGddF2uo8OP2j+Uw1HsJkJDUqgLzWOqo6zZ1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjJpjlImbTKLf4lhZrWaFb3qqV/nAa4idmDzZxcWjgz1CHw66GQLwH4557pnUAw75
	 g2wYe2Q2mE8MdvlOA6PRLAV1ZraOXsZm6OXRDzN0IaP4Pa0RVc0f67cZkjS1d/861/
	 Q8p29KUzepyGnzN6rY2fkbPVT8je7ZgzmySuRFJsYxZc0RqbAKKY39ehkW14A/MSy+
	 2DFZph/hIXuTCD5wdAQvNCZrPFjhbaysXE96rx7ElrfML1AI2QVR38kePwzqTJoYIB
	 gGYoNRNn2+0l1hJ/igGlJEpJwkuAUIAZWRGMQKbUhA7xTpSzK2dQ091DZoLNkO+235
	 PRCy+uuZ+WuGw==
Date: Wed, 11 Feb 2026 09:01:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf libunwind: Fix calls to thread__e_machine
Message-ID: <aYxvqoTR5NGYy1uj@x1>
References: <20260211053827.140534-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211053827.140534-1-irogers@google.com>

On Tue, Feb 10, 2026 at 09:38:27PM -0800, Ian Rogers wrote:
> Add the missing e_flags option to fix the build.
> 
> Fixes: 4e66527f8859 ("perf thread: Add optional e_flags output argument to thread__e_machine")
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
> ---
>  tools/perf/util/unwind-libunwind-local.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> index ecf0c01fe51f..5b39ce21e333 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -584,7 +584,9 @@ static int access_mem(unw_addr_space_t __maybe_unused as,
>  	}
>  
>  	ret = perf_reg_value(&start, perf_sample__user_regs(ui->sample),
> -			     perf_arch_reg_sp(thread__e_machine(ui->thread, ui->machine)));
> +			     perf_arch_reg_sp(thread__e_machine(ui->thread,
> +								ui->machine,
> +								/*e_flags=*/NULL)));
>  	if (ret)
>  		return ret;
>  
> @@ -733,7 +735,7 @@ static void _unwind__finish_access(struct maps *maps)
>  static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
>  		       void *arg, int max_stack)
>  {
> -	uint16_t e_machine = thread__e_machine(ui->thread, ui->machine);
> +	uint16_t e_machine = thread__e_machine(ui->thread, ui->machine, /*e_flags=*/NULL);
>  	u64 val;
>  	unw_word_t ips[max_stack];
>  	unw_addr_space_t addr_space;
> -- 
> 2.53.0.239.g8d8fc8a987-goog
> 
