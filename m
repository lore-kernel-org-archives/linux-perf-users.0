Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A9F2F7EFE;
	Wed, 30 Sep 2026 03:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790740256; cv=none; b=dcci0G3RinvxhYE2ZV9KLWgTIT2Swm50n6rZKqMX+KqvuY0YWVJYU4T0zThFuGWtaJpB9LA/tSzrOIfaM5el4Bh9gCPZ+FGaSCj+I02s6x7lebbkLmUMkLuP3/RFlSaZiYW+g+qjWVm/6/SEJ6mYDepqKEjzwWa/SP9vNIO1oHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790740256; c=relaxed/simple;
	bh=MY0hnxQ8zicQMoF+nFHkYkdiuqPro4ONr3l+kY7pIio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHFMuBMahNAvQuEOZ8Z5ZmdKJ4UGhYJeOBFLFFzoRHdKUM0TCO20zqA6E+EPC6FO6sygM6MWK6u3vRgpD9uctSet+bHkZTIkDi9CkE6dGPvZq/oxZbt0wN7mqadzvCQno9QUlxLGJ01E7sFJamu3axtFatchX4+Kf/hzfOmwQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idijhjYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idijhjYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581471F000FF;
	Wed, 30 Sep 2026 03:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790740254;
	bh=2G/WSetac0z27j/7WYeDBAR0yQWWa8dcPZZs1aY5FPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=idijhjYWm5maSd7p9ZG/AevsjHRYgJeMzKBXI9aLLhJL6AinAj/heB1jrroLSb9pw
	 +k1aIFoTJtrwjItwlTIz8j02F40uT5HI4gM8GsU8phhcKsff/3b5JzG4PjA4subfRP
	 U3lnfr9SDEm7vNz7dBjK2eCEqD+/Q93GqHiCKxMx6QCwGGQTJoC2y6bFJo5OwYRX9H
	 Iuy+gzsj++PkW06lt825Ew2jnzh93azLowvGAnTdfuXNWEV7WzMwC+0e3TAspT6uh+
	 KM3KVDMUyHOoMSnEoxseLU+ugSLYuODvBIzgp8fiVbbJ1UXQAXzGtRC0SZyIvaCmLr
	 htz7AWjnX2Okg==
Date: Tue, 29 Sep 2026 20:50:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/26] perf trace: Set the augmented arg header in the
 augmenters that omit it
Message-ID: <aryHG8O0JUM2F9GA@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928182605.3649015-2-irogers@google.com>

On Mon, Sep 28, 2026 at 11:25:40AM -0700, Ian Rogers wrote:
> The augmenters build records in augmented_args_tmp, a per-CPU scratch
> buffer reused by every syscall, so a header field that isn't written
> holds a stale value from an earlier syscall. sys_enter_sendto(),
> sys_enter_perf_event_open(), sys_enter_clock_nanosleep() and
> sys_enter_nanosleep() never set the struct augmented_arg size and err,
> and augment_arg() doesn't set err.
> 
> Set both. When bpf_probe_read_user() fails in the connect, sendto and
> nanosleep augmenters, report a zero sized payload and the error rather
> than the stale scratch contents.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 37 ++++++++++++++++---
>  1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 3bc9e28a9b8a..f7c9eb49648f 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -210,6 +210,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
>  	const void *sockaddr_arg = (const void *)args->args[1];
>  	unsigned int socklen = args->args[2];
>  	unsigned int len = sizeof(u64) + sizeof(augmented_args->args); // the size + err in all 'augmented_arg' structs
> +	int err;
>  
>          if (augmented_args == NULL)
>                  return 1; /* Failure: don't filter */
> @@ -217,9 +218,11 @@ int sys_enter_connect(struct syscall_enter_args *args)
>  	_Static_assert(is_power_of_2(sizeof(augmented_args->arg.saddr)), "sizeof(augmented_args->arg.saddr) needs to be a power of two");
>  	socklen &= sizeof(augmented_args->arg.saddr) - 1;
>  
> -	bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
> +	err = bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
> +	if (err)
> +		socklen = 0;
>  	augmented_args->arg.size = socklen;
> -	augmented_args->arg.err = 0;
> +	augmented_args->arg.err = err;
>  
>  	return augmented__output(args, augmented_args, len + socklen);
>  }
> @@ -231,13 +234,18 @@ int sys_enter_sendto(struct syscall_enter_args *args)
>  	const void *sockaddr_arg = (const void *)args->args[4];
>  	unsigned int socklen = args->args[5];
>  	unsigned int len = sizeof(u64) + sizeof(augmented_args->args); // the size + err in all 'augmented_arg' structs
> +	int err;
>  
>          if (augmented_args == NULL)
>                  return 1; /* Failure: don't filter */
>  
>  	socklen &= sizeof(augmented_args->arg.saddr) - 1;
>  
> -	bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
> +	err = bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
> +	if (err)
> +		socklen = 0;
> +	augmented_args->arg.size = socklen;
> +	augmented_args->arg.err = err;
>  
>  	return augmented__output(args, augmented_args, len + socklen);
>  }
> @@ -372,6 +380,9 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
>  	if (bpf_probe_read_user(&augmented_args->arg.value, size, attr) < 0)
>  		goto failure;
>  
> +	augmented_args->arg.size = size;
> +	augmented_args->arg.err = 0;
> +
>  	return augmented__output(args, augmented_args, len + size);
>  failure:
>  	return 1; /* Failure: don't filter */
> @@ -384,6 +395,7 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
>  	const void *rqtp_arg = (const void *)args->args[2];
>  	unsigned int len = sizeof(u64) + sizeof(augmented_args->args); // the size + err in all 'augmented_arg' structs
>  	__u32 size = sizeof(struct timespec64);
> +	int err;
>  
>          if (augmented_args == NULL)
>  		goto failure;
> @@ -391,7 +403,11 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
>  	if (size > sizeof(augmented_args->arg.value))
>                  goto failure;
>  
> -	bpf_probe_read_user(&augmented_args->arg.value, size, rqtp_arg);
> +	err = bpf_probe_read_user(&augmented_args->arg.value, size, rqtp_arg);
> +	if (err)
> +		size = 0;
> +	augmented_args->arg.size = size;
> +	augmented_args->arg.err = err;
>  
>  	return augmented__output(args, augmented_args, len + size);
>  failure:
> @@ -405,6 +421,7 @@ int sys_enter_nanosleep(struct syscall_enter_args *args)
>  	const void *req_arg = (const void *)args->args[0];
>  	unsigned int len = sizeof(augmented_args->args);
>  	__u32 size = sizeof(struct timespec64);
> +	int err;
>  
>          if (augmented_args == NULL)
>  		goto failure;
> @@ -412,7 +429,11 @@ int sys_enter_nanosleep(struct syscall_enter_args *args)
>  	if (size > sizeof(augmented_args->arg.value))
>                  goto failure;
>  
> -	bpf_probe_read_user(&augmented_args->arg.value, size, req_arg);
> +	err = bpf_probe_read_user(&augmented_args->arg.value, size, req_arg);
> +	if (err)
> +		size = 0;
> +	augmented_args->arg.size = size;
> +	augmented_args->arg.err = err;
>  
>  	return augmented__output(args, augmented_args, len + size);
>  failure:
> @@ -445,6 +466,7 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>  			      struct beauty_payload_enter *payload, u64 offset)
>  {
>  	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
> +	int read_err = 0;
>  	struct augmented_arg *payload_offset;
>  	s64 aug_size, size;
>  	bool augmented;
> @@ -467,8 +489,10 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>  	if (size == 1) { /* string */
>  		aug_size = bpf_probe_read_user_str(payload_offset->value, value_size, arg);
>  		/* minimum of 0 to pass the verifier */
> -		if (aug_size < 0)
> +		if (aug_size < 0) {
> +			read_err = aug_size;
>  			aug_size = 0;
> +		}
>  
>  		augmented = true;
>  	} else if (size > 0 && size <= value_size) { /* struct */
> @@ -498,6 +522,7 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>  			return -1;
>  
>  		payload_offset->size = aug_size;
> +		payload_offset->err = read_err;
>  		return written;
>  	}
>  
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
