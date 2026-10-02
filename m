Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162A4EF14B;
	Fri,  2 Oct 2026 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957862; cv=none; b=nFGyr9Zj5RzI28hy5NorsC7nV8+5fyRl7jDx18ZlpZvw2JF/ej+lU4a1j6LijMhLFkv4DuGEo4AlOSZnRyFe7GIHLyp/ICngvU0dV05NHQNzbY0kaIBtXL0vBELjDKVwgpoPqeXiWGiivjAl6LljPP7ss6AsatByAuqzqHpb2Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957862; c=relaxed/simple;
	bh=2UTKHksEaCXV1vC+/5CjGX3Vmty1Raa+dblfQ/QZPEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFnfzk/if2ZBpIr6VQE/xw3KZVs2jLMdJykHKj4RrTdkJQwU7B8/LLDi4CxcMnHjqHPqW/JEi0DSS+7Z10wjDRCTyojsQbad9rcMXKgBnuFOTZyJbUx5Q7CSyMxYlv2/ntB/Hj0Mz3qUM22WNEEHg4r8mDvROrMYx6wN1MnkKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg3zhq1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg3zhq1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240981F000FF;
	Fri,  2 Oct 2026 16:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790957860;
	bh=rZN4P466B9E/iFmEdFu0SQsxiQmkN3TRjtaOfbQc9KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vg3zhq1gBz5u99dsJXJl9vvVsPfDihUcZa4m+QevYhmFHndST6FU/uwl3yhBnnhsM
	 awo/E9AwPDw9YgXxzJvWJymQDAPyWpemmSyy5LH6Tbpmq3HvlSKEr4XcUUillMUTYN
	 Ri+wfwqE9j3yl/KsQ8los+YzyOFsJHx8cwB4tflzq4gqJ5d+h3JPiSqsv/5BsmMTxf
	 e4ksjYQEjm2qfPBzu1dU+KufgJQuaBHj8Wv+SQeF9K5xps0PtlzfAqDDgsWyeORaMG
	 u6nV/fQCwEPRKdH+QuAwj+QMXEDOmJT4N8Au/N7yPYsfg0oSogecb/wnL5T22toSSb
	 l6Oz3qjEL8ETA==
Date: Fri, 2 Oct 2026 18:17:37 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, atomlin@atomlin.com, howardchu95@gmail.com,
	james.clark@linaro.org, jbrnak@redhat.com, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 1/2] perf trace: Only call bpf_get_current_pid_tgid()
 when filtering tasks
Message-ID: <ar_ZIdRIoo1p_RXH@x2>
References: <ar6nzTSj17IxCy0j@x2>
 <20261002065440.2781176-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002065440.2781176-1-irogers@google.com>

On Thu, Oct 01, 2026 at 11:54:39PM -0700, Ian Rogers wrote:
> In task_traced(), bpf_get_current_pid_tgid() was called before checking
> has_pids_to_trace. Because BPF helper calls are not marked pure, the
> compiler cannot sink the call past the has_pids_to_trace check, so the
> helper was called on every syscall enter and exit even when tracing
> system-wide.
> 
> Check has_pids_to_trace before calling bpf_get_current_pid_tgid().
> 
> Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks, appreciated, applied,

- Arnaldo

> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index d16e55706335..0b2ef9541f84 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -494,13 +494,15 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>  
>  static bool task_traced(void)
>  {
> -	u64 pid_tgid = bpf_get_current_pid_tgid();
> -	pid_t pid = uses_tgid ? pid_tgid >> 32 : (pid_t)pid_tgid;
> +	u64 pid_tgid;
> +	pid_t pid;
>  	bool *traced;
>  
>  	if (!has_pids_to_trace)
>  		return true;
>  
> +	pid_tgid = bpf_get_current_pid_tgid();
> +	pid = uses_tgid ? pid_tgid >> 32 : (pid_t)pid_tgid;
>  	traced = bpf_map_lookup_elem(&pids_to_trace, &pid);
>  	return traced && *traced;
>  }
> 
> base-commit: 148cd3adf2df9e53fd9b3070ae1178d4876f8c67
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
