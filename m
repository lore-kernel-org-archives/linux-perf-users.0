Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0E2184551;
	Mon, 12 Aug 2024 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478980; cv=none; b=dYVzPkOE9h+KJqN4daCHLIkRmJXDEH9pO6KukCEMKT7lM55ep9K7iQLmIntrEJpK2v/Z+xKg+oqVVkWUfCfMcSMYE2WD+8Rgx35+DIelkUkqUPAylvcj8cDDM2IU4TzuDUbi0xbyhRLexdxbtdw3EW3KmOvtORQOhgsoSw7f2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478980; c=relaxed/simple;
	bh=XEQFdZn0JcBv7lziDHtuupzEEgUzEa0OPsdy8jUBTSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVJ+tR60bTI3HNeCJbFoaYb6eimO1Er2g+embY8acO5n4iEcZYqyuZWcyG1eBUCdutgy/VQ9aFdlMu3yi2hDSuHmMqEzZMShjFAzrAuRgjfUuWubR0W4U8IBTKPVM3XCSZ09RJin3MflPmaxT8QfvS3uZLdTTsd4MZDX3enRHrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvOSN8IN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvOSN8IN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AC1C4AF09;
	Mon, 12 Aug 2024 16:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723478979;
	bh=XEQFdZn0JcBv7lziDHtuupzEEgUzEa0OPsdy8jUBTSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nvOSN8INE8dDYhypKFxDz1CqaVB2ZiqdiXe6+qpZijdlzK78wRUyShZhbrAdN88pJ
	 DM8A4aTStnQFIq8GSeGb//g5SStVZ2vdVCRVcjB4+dkoWyODi7SWYh0evb6/fSxEFs
	 KpCrh2LUuqrrw0+mmaoLMjqssIsLCm/xD9bppgU9DHmPeZC3gRLnuLGcbWqKgQ387V
	 Emq9Bzqae+wlNktq/PQlT7bwaL1QDnAf2j6H2QhZWF4eKQDQ69ymJh4GPUl4ty6bBd
	 8qsqHa7ccoAZOQEBvSct/zpZcyZwOOxlmE3+ETgwznLkOeU0birpdOnn6btBlH8k6+
	 8lOS8puX+WiXg==
Date: Mon, 12 Aug 2024 13:09:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] perf lock contention: Change stack_id type to s32
Message-ID: <ZrozwIQcB_viRsKt@x1>
References: <909abbc8-efca-40df-9876-8c36b6942a83@stanley.mountain>
 <20240810191704.1948365-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810191704.1948365-1-namhyung@kernel.org>

On Sat, Aug 10, 2024 at 12:17:04PM -0700, Namhyung Kim wrote:
> The bpf_get_stackid() helper returns a signed type to check whether it
> failed to get a stacktrace or not.  But it saved the result in u32 and
> checked if the value is negative.
> 
>       376         if (needs_callstack) {
>       377                 pelem->stack_id = bpf_get_stackid(ctx, &stacks,
>       378                                                   BPF_F_FAST_STACK_CMP | stack_skip);
>   --> 379                 if (pelem->stack_id < 0)
> 
>   ./tools/perf/util/bpf_skel/lock_contention.bpf.c:379 contention_begin()
>   warn: unsigned 'pelem->stack_id' is never less than zero.
> 
> Let's change the type to s32 instead.
> 
> Fixes: 6d499a6b3d90 ("perf lock: Print the number of lost entries for BPF")

Thanks, applied to perf-tools-next,

- Arnaldo

> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_skel/lock_data.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
> index 36af11faad03..de12892f992f 100644
> --- a/tools/perf/util/bpf_skel/lock_data.h
> +++ b/tools/perf/util/bpf_skel/lock_data.h
> @@ -7,11 +7,11 @@ struct tstamp_data {
>  	u64 timestamp;
>  	u64 lock;
>  	u32 flags;
> -	u32 stack_id;
> +	s32 stack_id;
>  };
>  
>  struct contention_key {
> -	u32 stack_id;
> +	s32 stack_id;
>  	u32 pid;
>  	u64 lock_addr_or_cgroup;
>  };
> -- 
> 2.46.0.76.ge559c4bf1a-goog
