Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2625286D74;
	Wed, 28 May 2025 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748454806; cv=none; b=iyaTiNuHwQl88psVaLIXSPCER+w1oaGP08SBnFF1u9/ijw391xsT269dm+nD/C0J/i5/cmr4w1sbHKHxMlC7oy8ihvoAkmun4uIX7EEasIMX4uNBXxMATCr4ZfULr3EgZDEluZ4LrsNDkr5Ehz7k0nLo080ckR2Zp2W+OaiwLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748454806; c=relaxed/simple;
	bh=txwMqlXNU9+DDo1w9gEc1+xw1vo/6bNTsoaIA2zH9nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjtWBF1mdLu3fhRjp4DC0LbBw5+bSQsRVAIwapSPEhLgMwjqPe675JtVVx3y55fFepCAFDagD4rof38jfeKnX1uuKtHPCDZhrfJyZ1AHZ+9x2kENh+dNLUq6KG2wY1YA2V30CrigO/GFb5FZlkVmJ1f6a2bL5QZpUOXbO7HA3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEb3o9Dg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEb3o9Dg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7F8C4CEE3;
	Wed, 28 May 2025 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748454806;
	bh=txwMqlXNU9+DDo1w9gEc1+xw1vo/6bNTsoaIA2zH9nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEb3o9DgCaiGjyTJfIoKbrlt3oW0FNUtBTIODtBd6j9Fqt+8LvHPEyoFqN2rD+oqk
	 1eH8g/wsHv3/LGRzjkNit86QX/x2l7Yabd0xP/fzsTMmNbQvewI6UVYU4yP8FFbt1y
	 2akAv9ylAzuRGgFn+bMoexXxp27GD8WRkHK02s1IaVT4+rkSwHfUCzS4IWHBk7R08z
	 PzRGjLqBPvlkx7kjQPMbAiqB5AXN+XYUHYAfuS9XV7ibVv8/PswMISFyFR+VOT4O+M
	 uHL8aHLH8KJkwptFwNfJou/ZcAMgC8ZobId5/gjueBPh6f0ggKsT+8wZaRV8xdH+hc
	 UwiIJU/RKZ4Og==
Date: Wed, 28 May 2025 10:53:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] perf intel-tpebs: Avoid race when evlist is being
 deleted
Message-ID: <aDdNk1IOqtyM44AX@google.com>
References: <20250528032637.198960-1-irogers@google.com>
 <20250528032637.198960-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250528032637.198960-5-irogers@google.com>

Hi Ian,

On Tue, May 27, 2025 at 08:26:34PM -0700, Ian Rogers wrote:
> Reading through the evsel->evlist may seg fault if a sample arrives
> when the evlist is being deleted. Detect this case and ignore samples
> arriving when the evlist is being deleted.
> 
> Fixes: bcfab08db7fb ("perf intel-tpebs: Filter non-workload samples")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/intel-tpebs.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index 4ad4bc118ea5..3b92ebf5c112 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -162,9 +162,17 @@ static bool is_child_pid(pid_t parent, pid_t child)
>  
>  static bool should_ignore_sample(const struct perf_sample *sample, const struct tpebs_retire_lat *t)
>  {
> -	pid_t workload_pid = t->evsel->evlist->workload.pid;
> -	pid_t sample_pid = sample->pid;
> +	pid_t workload_pid, sample_pid = sample->pid;
>  
> +	/*
> +	 * During evlist__purge the evlist will be removed prior to the
> +	 * evsel__exit calling evsel__tpebs_close and taking the
> +	 * tpebs_mtx. Avoid a segfault by ignoring samples in this case.
> +	 */
> +	if (t->evsel->evlist == NULL)
> +		return true;
> +
> +	workload_pid = t->evsel->evlist->workload.pid;

I'm curious if there's a chance of TOCTOU race.  It'd certainly help
the segfault but would this code prevent it completely?

Thanks,
Namhyung


>  	if (workload_pid < 0 || workload_pid == sample_pid)
>  		return false;
>  
> -- 
> 2.49.0.1238.gf8c92423fb-goog
> 
