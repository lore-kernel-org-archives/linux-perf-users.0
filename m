Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB181514C9
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Sep 2024 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727679329; cv=none; b=RYkmB3ItGwz6Uh+b94lFzUTmFL0cCYcrkc5XylFEZwcMGgSiJYxCgY82sUWuAxfPvRD8GAJSWQkKOOxt7j/2HIiDKCu8rh40vXhqa6Pp4XaliZ4J3I50YE0zF3VAp+o50icB2L39VBqJK1UnglT4xjN3wkvrnhmZiuedFYvfu88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727679329; c=relaxed/simple;
	bh=EEjSDK1UR8WHDupSm4DRXnLaNur3mvrPMRCe3D1JLCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qO7TbNPzfZOOQGMWDMDa0oPSoNPVlZbdRVTWR8vWGnJPgxM71vmACzilCOYjNoOg5ZNV7E8nidjrJln8HmqEzc8EL9BVzf/SyEInuUj6xsf2JjZm/j3g2nJOEO2FUH1pvslgbrib7DM5EGQ8Alo1D9csZC/465s0SVPRYAuEcYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE7I6LkW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE7I6LkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5E7C4CEC7;
	Mon, 30 Sep 2024 06:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727679328;
	bh=EEjSDK1UR8WHDupSm4DRXnLaNur3mvrPMRCe3D1JLCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VE7I6LkWXcTMNu85KvRKtkGgseJaqNKqsc5gtOdzBlycCUDfCUcux78jiLPGnNkBB
	 qwXARcOUgvn0iASfGt+JXfO1VfwHH6PB44EoCfjSDHt65KbG2zWRhTKxhpjHY6jey7
	 vZgZnHPZamuhlqns6pWN6j/1D7K+43hdBZL0RxuAD5xS+UQwUGX5QfZBmERsFg1pMx
	 So6Z31eAIW53SSQRvJRTgW/Snin9QuPXQJgCBli/eq162K8b7m9gtGywlLHLd0Uymd
	 UA+p0+emi7fYl4vgXydayQot2X4FuiapT1QqrrZJ9xe165mQZqiwm8ao33fYcBo1KQ
	 pMiieJHsYu4ZQ==
Date: Sun, 29 Sep 2024 23:55:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, vmolnaro@redhat.com,
	irogers@google.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com
Subject: Re: [PATCH] perf trace: Keep exited threads for summary
Message-ID: <ZvpLX5ECs7gdDLSM@google.com>
References: <20240927151926.399474-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927151926.399474-1-mpetlan@redhat.com>

On Fri, Sep 27, 2024 at 05:19:26PM +0200, Michael Petlan wrote:
> Since 9ffa6c7512ca ("perf machine thread: Remove exited threads by
> default") perf cleans exited threads up, but as said, sometimes they
> are necessary to be kept. The mentioned commit does not cover all the
> cases, we also need the information to construct the summary table in
> perf-trace.
> 
> Before:
>     # perf trace -s true
> 
>      Summary of events:
> 
> After:
>     # perf trace -s -- true
> 
>      Summary of events:
> 
>      true (383382), 64 events, 91.4%
> 
>        syscall            calls  errors  total       min       avg       max       stddev
>                                          (msec)    (msec)    (msec)    (msec)        (%)
>        --------------- --------  ------ -------- --------- --------- ---------     ------
>        mmap                   8      0     0.150     0.013     0.019     0.031     11.90%
>        mprotect               3      0     0.045     0.014     0.015     0.017      6.47%
>        openat                 2      0     0.014     0.006     0.007     0.007      9.73%
>        munmap                 1      0     0.009     0.009     0.009     0.009      0.00%
>        access                 1      1     0.009     0.009     0.009     0.009      0.00%
>        pread64                4      0     0.006     0.001     0.001     0.002      4.53%
>        fstat                  2      0     0.005     0.001     0.002     0.003     37.59%
>        arch_prctl             2      1     0.003     0.001     0.002     0.002     25.91%
>        read                   1      0     0.003     0.003     0.003     0.003      0.00%
>        close                  2      0     0.003     0.001     0.001     0.001      3.86%
>        brk                    1      0     0.002     0.002     0.002     0.002      0.00%
>        rseq                   1      0     0.001     0.001     0.001     0.001      0.00%
>        prlimit64              1      0     0.001     0.001     0.001     0.001      0.00%
>        set_robust_list        1      0     0.001     0.001     0.001     0.001      0.00%
>        set_tid_address        1      0     0.001     0.001     0.001     0.001      0.00%
>        execve                 1      0     0.000     0.000     0.000     0.000      0.00%
> 
> Fixes: 9ffa6c7512ca ("perf machine thread: Remove exited threads by default")
> 
> Reported-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

Looks good

But I'd really like to have system-wide summary mode so that I can see
the syscall overhead altogether.  Of course, this can be a future work.

Thanks,
Namhyung

> ---
>  tools/perf/builtin-trace.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f6e847529073..1a12ed71c809 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -5449,6 +5449,10 @@ int cmd_trace(int argc, const char **argv)
>  	if (trace.summary_only)
>  		trace.summary = trace.summary_only;
>  
> +	/* Keep exited threads, otherwise information might be lost for summary */
> +	if (trace.summary || trace.summary_only)
> +		symbol_conf.keep_exited_threads = true;
> +
>  	if (output_name != NULL) {
>  		err = trace__open_output(&trace, output_name);
>  		if (err < 0) {
> -- 
> 2.43.5
> 
