Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A53E0749;
	Thu, 24 Sep 2026 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290186; cv=none; b=LRYRrU1F4tt8uysCXbtx8AZAHbW3yHQDGsAZ1fZZH5mW26cu7kvHskryzz8dZTSWFk/7QK6+3A6CjOrxSjjLBXoyzIy2Iy4DcX9Gc4hm4nItpX33DWkHAEIPss3qh52hf+9PjGL/LgOWSaM0bfJrlwc7uCeU+xRlWgpFN8Vo0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290186; c=relaxed/simple;
	bh=X4N46zTnr8zPk2L5jVsXS384xSnr2JuLk2Bx7PaxCXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Klrv/NMibaFXnQNPcpC7e+qse6R+wFLj4RNNzfLqg0wsxDFzTfr6M3b5TGvsiQX7rg7Gza7br7gi5+3vFu+/NWf8uBJHT9OJImv7SbX4+rDRft499ijxQ4FyT5mg2jqreTFTirKUWeJdiKP1wn3snyDlIatxHmCBtpcjHpCybC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8VZZiY8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8VZZiY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B131F000FF;
	Thu, 24 Sep 2026 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790290184;
	bh=SBnRjlZiMD6GNwF5HV2vUPlpIGI4oceGD3wHaGXf4Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G8VZZiY8GSq6qLx3F0yb/nl8UQ8v87ci1lltEYNHB/PoOGluwTgcQg+opo/BMMeIW
	 /HkO/pQC+NIW0XMN1GmfL217dv7ldbMpHIdaYrQ0YR5MTaQtnV1gi5up+S4rraA4vt
	 RM2Ja5SG0sr8YyhFsWCv+x8U6+F5pfHApqOl8HV1G/cLTl+A5xG5YQ6ueX2YhzP2Sr
	 cuAQeKmM1WagS68C9s7YWtP37hYwDlSxPsswUvuetWWEDuw1NimqLQTsxs1/R0ej2E
	 Hz2zNpJbBrRfn4mf8/WAaDHtLH5m4MXNPQulxmXUYkVeR036WV+eJzILpDvwbwjjWX
	 REks5oJyrbM0A==
Date: Thu, 24 Sep 2026 15:49:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, howardchu95@gmail.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v5 11/23] perf trace: Do not set unaugmented BPF program
 on sys_exit map
Message-ID: <arWpBizG27rMsHmZ@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <42dc47785bdb78054500591b193a1cb653ef39b7.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42dc47785bdb78054500591b193a1cb653ef39b7.1790145937.git.irogers@google.com>

On Wed, Sep 23, 2026 at 12:13:51AM -0700, Ian Rogers wrote:
> In trace__init_syscalls_bpf_prog_array_maps(), the BPF program array map
> for sys_exit (syscalls_sys_exit) was populated with the result of
> trace__bpf_prog_sys_exit_fd().
> 
> When a syscall had no specific exit augmenter,
> trace__find_syscall_bpf_prog() fell back to unaugmented_prog
> (syscall_unaugmented). However, syscall_unaugmented is a sys_enter
> program that outputs enter arguments to __augmented_syscalls__.
> 
> As a consequence, when an unaugmented syscall exited, sys_exit
> tail-called syscall_unaugmented, which interpreted the exit arguments as
> enter arguments and emitted a duplicate, corrupt sys_enter event into
> __augmented_syscalls__ right as the syscall completed.

Do you have a reproducer of this problem?  I've never seen this before.
IIRC there's no augmentation at exit, then do we need to keep the tail
call?

Thanks,
Namhyung

> 
> Fix this by:
> 1. Returning NULL from trace__find_syscall_bpf_prog() when looking up exit
>    augmenters and none is found.
> 2. Returning -1 from trace__bpf_prog_sys_exit_fd() when no exit program
>    is present.
> 3. Only updating map_exit_fd when prog_fd >= 0.
> 4. Clearing err = 0 when trace__bpf_sys_enter_beauty_map() returns
>    non-zero (indicating the syscall has no augmentable pointer arguments)
>    before continuing the loop, so a trailing run of such syscalls (e.g.
>    'perf trace -e close') does not leave err non-zero on return and abort
>    the session.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index aa2d64eb56bd..0ae14ecd9f00 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4176,7 +4176,12 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace __ma
>  	pr_debug("Couldn't find BPF prog \"%s\" to associate with syscalls:sys_%s_%s, not augmenting it\n",
>  		 prog_name, type, sc->name);
>  out_unaugmented:
> -	return unaugmented_prog;
> +	/*
> +	 * Do not set unaugmented_prog for exit: syscall_unaugmented is a
> +	 * sys_enter program that outputs enter arguments. Exit without a
> +	 * specialized return augmenter returns 1 directly from sys_exit.
> +	 */
> +	return !strcmp(type, "exit") ? NULL : unaugmented_prog;
>  }
>  
>  static void trace__init_syscall_bpf_progs(struct trace *trace, int e_machine, int id)
> @@ -4199,7 +4204,7 @@ static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int e_machine, int
>  static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int e_machine, int id)
>  {
>  	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
> -	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(unaugmented_prog);
> +	return sc && sc->bpf_prog.sys_exit ? bpf_program__fd(sc->bpf_prog.sys_exit) : -1;
>  }
>  
>  static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, int key, unsigned int *beauty_array)
> @@ -4454,16 +4459,27 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_m
>  		err = bpf_map_update_elem(map_enter_fd, &key, &prog_fd, BPF_ANY);
>  		if (err)
>  			break;
> +		/* Only update the exit prog array map if an exit augmenter exists */
>  		prog_fd = trace__bpf_prog_sys_exit_fd(trace, e_machine, key);
> -		err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
> -		if (err)
> -			break;
> +		if (prog_fd >= 0) {
> +			err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
> +			if (err)
> +				break;
> +		}
>  
>  		/* use beauty_map to tell BPF how many bytes to collect, set beauty_map's value here */
>  		memset(beauty_array, 0, sizeof(beauty_array));
>  		err = trace__bpf_sys_enter_beauty_map(trace, e_machine, key, (unsigned int *)beauty_array);
> -		if (err)
> +		if (err) {
> +			/*
> +			 * Not a failure: the syscall just has no augmentable
> +			 * arguments. Clear err, or a trailing run of such
> +			 * syscalls, e.g. all of them for 'perf trace -e close',
> +			 * would leave it set on return and abort the session.
> +			 */
> +			err = 0;
>  			continue;
> +		}
>  		err = bpf_map_update_elem(beauty_map_fd, &key, beauty_array, BPF_ANY);
>  		if (err)
>  			break;
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
