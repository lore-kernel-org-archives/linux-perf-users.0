Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8BE21772B;
	Fri, 30 May 2025 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748648270; cv=none; b=JLr0JL5THN7Rj1NEwpQynqvLmYWEC7W8EX7IFebjJ07HVVTL3qoph5UWhB2qaC0KPNmdLcZVMvqVrMH/Hzlk8dYPIgtYr9+uU1MI/JJt6LdLkpjd5MJhtyS1s5IhZfK/w936+UeSYdvY/XX88IX/m6UZwxwin7P3JLYTn1WLKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748648270; c=relaxed/simple;
	bh=/UXsCZtc2O9lDOjvM3FiWNPNPFkOA+JStRUHC/bqQhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux4n7ZP14BTenrrSXa3Y1/Mq79dgdX2W94KFq30w4xB3eoXjE93am13jNS1vXkZgQMuEwwaltDBdaqvmGRTm0k1fFc+9Oze0I5zywb6JdG8ym3zuP6srnm6P/UafT2nGCYqJdyEoq4uTbgdZ7eVvkeNNnZmFSOpnGpDtPZfFtPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3AYWn5b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3AYWn5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C590C4CEE9;
	Fri, 30 May 2025 23:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748648270;
	bh=/UXsCZtc2O9lDOjvM3FiWNPNPFkOA+JStRUHC/bqQhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3AYWn5baEO9P3WFOaH6Nm98ZsXgL0PXyBrav1T1w40usoGFfu7HfeU2JuPn3xefL
	 zhJiOz1vywFieUxCqVsB1wRCw2gNzMK0mpGMCWyUXZQp7/j9FubOAUroLMHguAbFcF
	 O/Cj0ZDHgQRrbx1Wdjl9MPsvmnz0UJHpu/oDRt6OYr3qFSlzeZQGwNFIVk0NBxK+KP
	 72mVQa2Bh0K3pE1KpE/m30mcNUV7DNPWAAf207RkrvCmDr+0Tqb0PCL8DLMkfazXoD
	 ZPO7YBlLIled2gvaIx7d03A9lmO0kZ624NNbAYW4pmADBiV4vPmdegx/u1zC8Y0oSu
	 2eOiXY5vfPZZQ==
Date: Fri, 30 May 2025 16:37:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>
Subject: Re: [RFC PATCH v1] perf trace: Mitigate failures in parallel perf
 trace instances
Message-ID: <aDpBTLoeOJ3NAw_-@google.com>
References: <20250529065537.529937-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250529065537.529937-1-howardchu95@gmail.com>

Hello,

(Adding tracing folks)

On Wed, May 28, 2025 at 11:55:36PM -0700, Howard Chu wrote:
> perf trace utilizes the tracepoint utility, the only filter in perf
> trace is a filter on syscall type. For example, if perf traces only
> openat, then it filters all the other syscalls, such as readlinkat,
> readv, etc.
> 
> This filtering is flawed. Consider this case: two perf trace
> instances are running at the same time, trace instance A tracing
> readlinkat, trace instance B tracing openat. When an openat syscall
> enters, it triggers both BPF programs (sys_enter) in both perf trace
> instances, these kernel functions will be executed:
> 
> perf_syscall_enter
>   perf_call_bpf_enter
>     trace_call_bpf
>       bpf_prog_run_array
> 
> In bpf_prog_run_array:
> ~~~
> while ((prog = READ_ONCE(item->prog))) {
> 	run_ctx.bpf_cookie = item->bpf_cookie;
> 	ret &= run_prog(prog, ctx);
> 	item++;
> }
> ~~~
> 
> I'm not a BPF expert, but by tinkering I found that if one of the BPF
> programs returns 0, there will be no tracepoint sample. That is,
> 
> (Is there a sample?) = ProgRetA & ProgRetB & ProgRetC
> 
> Where ProgRetA is the return value of one of the BPF programs in the BPF
> program array.
> 
> Go back to the case, when two perf trace instances are tracing two
> different syscalls, again, A is tracing readlinkat, B is tracing openat,
> when an openat syscall enters, it triggers the sys_enter program in
> instance A, call it ProgA, and the sys_enter program in instance B,
> ProgB, now ProgA will return 0 because ProgA cares about readlinkat only,
> even though ProgB returns 1; (Is there a sample?) = ProgRetA (0) &
> ProgRetB (1) = 0. So there won't be a tracepoint sample in B's output,
> when there really should be one.

Sounds like a bug.  I think it should run bpf programs attached to the
current perf_event only.  Isn't it the case for tracepoint + perf + bpf?

> 
> I also want to point out that openat and readlinkat have augmented
> output, so my example might not be accurate, but it does explain the
> current perf-trace-in-parallel dilemma.
> 
> Now for augmented output, it is different. When it calls
> bpf_perf_event_output, there is a sample. There won't be no ProgRetA &
> ProgRetB... thing. So I will send another RFC patch to enable
> parallelism using this feature. Also, augmented_output creates a sample
> on it's own, so returning 1 will create a duplicated sample, when
> augmented, just return 0 instead.

Yes, it's bpf-output and tracepoint respectively.  Maybe we should
always return 1 not to drop syscalls unintentionally and perf can
discard duplicated samples.

Another approach would be return 0 always and use bpf-output for
unaugmented syscalls too.  But I'm afraid it'd affect other perf tools
using tracepoints.

> 
> Is this approach perfect? Absolutely not, there will likely be some
> performance overhead on the kernel side. It is just a quick dirty fix
> that makes perf trace run in parallel without failing. This patch is an
> explanation on the reason of failures and possibly, a link used in a
> nack comment.

Thanks for your work, but I'm afraid it'd still miss some syscalls as it
returns 0 sometimes.

Thanks,
Namhyung

> 
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  .../util/bpf_skel/augmented_raw_syscalls.bpf.c   | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index e4352881e3fa..315fadf01321 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -546,13 +546,14 @@ int sys_enter(struct syscall_enter_args *args)
>  	/*
>  	 * Jump to syscall specific augmenter, even if the default one,
>  	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
> -	 * unaugmented tracepoint payload.
> +	 * unaugmented tracepoint payload. If augmented, return 0 to reduce a
> +	 * duplicated tracepoint sample.
>  	 */
> -	if (augment_sys_enter(args, &augmented_args->args))
> -		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> +	if (!augment_sys_enter(args, &augmented_args->args))
> +		return 0;
>  
> -	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
> -	return 0;
> +	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
> +	return 1;
>  }
>  
>  SEC("tp/raw_syscalls/sys_exit")
> @@ -570,10 +571,7 @@ int sys_exit(struct syscall_exit_args *args)
>  	 * unaugmented tracepoint payload.
>  	 */
>  	bpf_tail_call(args, &syscalls_sys_exit, exit_args.syscall_nr);
> -	/*
> -	 * If not found on the PROG_ARRAY syscalls map, then we're filtering it:
> -	 */
> -	return 0;
> +	return 1;
>  }
>  
>  char _license[] SEC("license") = "GPL";
> -- 
> 2.45.2
> 
