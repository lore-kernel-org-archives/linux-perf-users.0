Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D96284B50;
	Wed, 28 May 2025 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436670; cv=none; b=DdkGwa1VyWLk7nMfmOqDArRfnEmJ7RvDTASrw3Xpp0mnFbMe+6/txdzBAk/jlHs+vIxtrekoinMD1o64fsw63u3tkGar6aTJLxR7JhZgFAwtN18mLTz93sKNKWCN9yhmw1pFNjzeeIwNUkwhkHZEnMpEopXfgP84nu0NB2zBRP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436670; c=relaxed/simple;
	bh=cLH9qffAGEku8VAcA1NrwyVqoqY9fO9tSWVZlmurDRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ2VGlJNSDGclZGEoHKT2duGyN8kF/vCDIUw/WYcgf7zorj+Xli+/l/P83aUH8IIf6zvwiWg8QV4gsDzRSBL5iW+YFq9yzG/Q1x/kXubKsz1N5Bq1CXvXOIWAIPbnn1po9YVQRGfq9uSYTGlECquXsAlvFa6+qXtrA8RPNSmjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCl0VbJJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCl0VbJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B976C4CEED;
	Wed, 28 May 2025 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748436669;
	bh=cLH9qffAGEku8VAcA1NrwyVqoqY9fO9tSWVZlmurDRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCl0VbJJYSTxtsSM0wq5JtaYgNdWBxXSGev4c807eFT2cV0Gk7WtBct0tOIb4NUYd
	 3+TAXbamprgrXeBEJltFYsgApJkycB2LPzp5v6k26B3D2f6nLoTTK5y/vTDSmTYisT
	 S265Obji7Ruw1g/U4o/KtKC1WsqV/R3ZqWcAOQySG8d9RZUtw9XxClmxNLCRw56o5X
	 S8EEquEI1YYGqGwe/JYbUY5PGI8kl929Q/FNLe3cqCbGkx7AJ3WY0wPrW7ADja9QWQ
	 MxjZoH2mUsUGdY/+oEQdhE/MMFVPnmCDt2JglVpzlN8FS/2fkl9RiSu41y1ysQVRGs
	 qmIy29xfDUx0g==
Date: Wed, 28 May 2025 09:51:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
Subject: Re: [PATCH v1 4/6] perf intel-tpebs: Avoid race when evlist is being
 deleted
Message-ID: <aDcGukvGcklMWe8E@x1>
References: <20250527180703.129336-1-irogers@google.com>
 <20250527180703.129336-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527180703.129336-5-irogers@google.com>

On Tue, May 27, 2025 at 11:07:01AM -0700, Ian Rogers wrote:
> Reading through the evsel->evlist may seg fault if a sample arrives
> when the evlist is being deleted. Detect this case and ignore samples
> arriving when the evlist is being deleted.

Thanks, applied to perf-tools-next,

- Arnaldo
 
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
>  	if (workload_pid < 0 || workload_pid == sample_pid)
>  		return false;
>  
> -- 
> 2.49.0.1204.g71687c7c1d-goog
