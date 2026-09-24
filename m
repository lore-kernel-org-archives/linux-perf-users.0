Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48DE3DE448;
	Thu, 24 Sep 2026 05:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228356; cv=none; b=mmN+5fvrd0rgbO1wiN518hqnhGID2p+koSUlxT0uYhLCGRyAenKjLbjdBJvQG7JX6bCSO1KMdjHCOh61tXjRTHMY5Wb9riPut2z3w5XhWN9IvezdDyHDZbnVUVU60ccyANtKyuQXenuYmNofUWRdIkacCd3iEnYOE81u9JhTnj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228356; c=relaxed/simple;
	bh=+5rGqoBHjVn8jYEY7VxKzQ+/1KhRfEC2WFuq4lhuvPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8BCf+JHLvB3wYeTXAquh5SGcJfn30FciVjLkVRbAd2R9p/i0PuLXnJ/R0Ls1ZIELiGt+biDgFKiJ2sawGiTePsTq0EIHcfAAFofToZdsePRcMvrzHWtgXhEL61yd4RNCsw1fFdNXoL7tBhQ2s/ly/KEMjaxpWgARZV0SB2iOeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+3hu81f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+3hu81f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A3A1F000FF;
	Thu, 24 Sep 2026 05:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228353;
	bh=NrsOgEgOVd37kxt7b9JCPntqT/RFqQC5MM0+b4DyVxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A+3hu81fkEMAcafgC+v4ydDIQJ836oZPbMddpkmdrF5QnV2u1fBmLSv3TdLh8vmxX
	 srZAIjHQ9k3xgZAnLaO4LKJTXgyVh4p7g8V174wsW8/f4EJ6Tuvb5DvStMzXMKtxFT
	 LBn+694FuOdJpPqAvboZIyVRMofvBlMQZnI9shFOKQXLGFGZoiztGwVeTd+qrowfUc
	 eEqr7zKdqqnT21R/DL4H7XhtwYBbRPRNafcmT/m+3+tbqrBYGesMspWXCUZCo5w0FH
	 l1CUQhPF9Z/aMeRQshZzkZ4ZQ5dGvZlKhy/puvEZtCIthBUSbVxTcXxdAJitq45suN
	 s+aXnUxPSQSig==
Date: Wed, 23 Sep 2026 22:39:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, howardchu95@gmail.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v5 01/23] perf trace: Set the augmented arg header in the
 augmenters that omit it
Message-ID: <arS3f8bio-m1WNML@z2>
References: <cover.1790145937.git.irogers@google.com>
 <aa751d26ad55f8a7d72db30dc23a67fae66e4b6b.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa751d26ad55f8a7d72db30dc23a67fae66e4b6b.1790145937.git.irogers@google.com>

On Wed, Sep 23, 2026 at 12:13:41AM -0700, Ian Rogers wrote:
> An augmented argument is a struct augmented_arg header, holding the
> length of the payload and an error code, followed by the payload. The
> augmenters build it in augmented_args_tmp, a single entry per-CPU array
> reused by every syscall on that CPU, so a field left unassigned holds
> whatever the previous syscall on that CPU put there rather than anything
> about this one.
> 
> The string augmenters get both fields from augmented_arg__read_str(),
> and sys_enter_perf_event_open() bails out when its read fails, but
> sys_enter_connect(), sys_enter_sendto(), sys_enter_clock_nanosleep() and
> sys_enter_nanosleep() copy the payload and output the record without
> ever describing it, and augment_arg() sets the length but not the error.
> 
> This has gone unnoticed because the beautifiers for those payloads take
> a fixed sized type and so read the value without consulting the header:
> syscall_arg__scnprintf_augmented_sockaddr(),
> syscall_arg__scnprintf_augmented_timespec() and
> syscall_arg__scnprintf_augmented_perf_event_attr() all cast
> augmented.args->value directly. Nothing has yet read a length that was
> never written.
> 
> Describe the payload everywhere one is produced, so that a reader can
> bound it by its length.
> 
> These reads can fail, and none of the four checked whether they had.
> Rather than claim a payload that was not read, report a length of zero
> and the error, so the record describes what it holds and leaves the
> scratch out of it. A reader that bounds the payload by the header then
> shows the pointer, as it does for a syscall with no augmentation at
> all, rather than another task's data.
> 
> The error is set for the same reason the length is, that the header is
> in a buffer the next syscall on this CPU will reuse and so carries the
> previous one's value if it is not written, rather than because anything
> reads it yet: beauty.h still calls the field int_arg and no beautifier
> looks at it. augment_arg() reported a string it could not read as an
> empty one before this and still does.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 53 ++++++++++++++++---
>  1 file changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 3bc9e28a9b8a..dd3aa5bd910b 100644
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
> @@ -217,9 +218,16 @@ int sys_enter_connect(struct syscall_enter_args *args)
>  	_Static_assert(is_power_of_2(sizeof(augmented_args->arg.saddr)), "sizeof(augmented_args->arg.saddr) needs to be a power of two");
>  	socklen &= sizeof(augmented_args->arg.saddr) - 1;
>  
> -	bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
> +	err = bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockaddr_arg);
> +	/*
> +	 * A failed read leaves the scratch holding whatever the previous
> +	 * syscall on this CPU put there, so say there is no payload and why,
> +	 * rather than describing another task's data as this task's sockaddr.
> +	 */
> +	if (err < 0)
> +		socklen = 0;
>  	augmented_args->arg.size = socklen;
> -	augmented_args->arg.err = 0;
> +	augmented_args->arg.err = err < 0 ? err : 0;

It seems we can simply use the return value of bpf_probe_read_user()
as it only returns 0 or a negative error according to the doc.

https://docs.ebpf.io/linux/helper-function/bpf_probe_read_user/

>  
>  	return augmented__output(args, augmented_args, len + socklen);
>  }
> @@ -231,13 +239,19 @@ int sys_enter_sendto(struct syscall_enter_args *args)
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
> +	/* As in sys_enter_connect(), do not describe scratch as a sockaddr. */
> +	if (err < 0)
> +		socklen = 0;
> +	augmented_args->arg.size = socklen;
> +	augmented_args->arg.err = err < 0 ? err : 0;
>  
>  	return augmented__output(args, augmented_args, len + socklen);
>  }
> @@ -372,6 +386,9 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
>  	if (bpf_probe_read_user(&augmented_args->arg.value, size, attr) < 0)
>  		goto failure;
>  
> +	augmented_args->arg.size = size;
> +	augmented_args->arg.err = 0;
> +
>  	return augmented__output(args, augmented_args, len + size);
>  failure:
>  	return 1; /* Failure: don't filter */
> @@ -384,6 +401,7 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
>  	const void *rqtp_arg = (const void *)args->args[2];
>  	unsigned int len = sizeof(u64) + sizeof(augmented_args->args); // the size + err in all 'augmented_arg' structs
>  	__u32 size = sizeof(struct timespec64);
> +	int err;
>  
>          if (augmented_args == NULL)
>  		goto failure;
> @@ -391,7 +409,12 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
>  	if (size > sizeof(augmented_args->arg.value))
>                  goto failure;
>  
> -	bpf_probe_read_user(&augmented_args->arg.value, size, rqtp_arg);
> +	err = bpf_probe_read_user(&augmented_args->arg.value, size, rqtp_arg);
> +	/* As in sys_enter_connect(), do not describe scratch as a timespec. */
> +	if (err < 0)
> +		size = 0;
> +	augmented_args->arg.size = size;
> +	augmented_args->arg.err = err < 0 ? err : 0;
>  
>  	return augmented__output(args, augmented_args, len + size);
>  failure:
> @@ -405,6 +428,7 @@ int sys_enter_nanosleep(struct syscall_enter_args *args)
>  	const void *req_arg = (const void *)args->args[0];
>  	unsigned int len = sizeof(augmented_args->args);
>  	__u32 size = sizeof(struct timespec64);
> +	int err;
>  
>          if (augmented_args == NULL)
>  		goto failure;
> @@ -412,7 +436,12 @@ int sys_enter_nanosleep(struct syscall_enter_args *args)
>  	if (size > sizeof(augmented_args->arg.value))
>                  goto failure;
>  
> -	bpf_probe_read_user(&augmented_args->arg.value, size, req_arg);
> +	err = bpf_probe_read_user(&augmented_args->arg.value, size, req_arg);
> +	/* As in sys_enter_connect(), do not describe scratch as a timespec. */
> +	if (err < 0)
> +		size = 0;
> +	augmented_args->arg.size = size;
> +	augmented_args->arg.err = err < 0 ? err : 0;
>  
>  	return augmented__output(args, augmented_args, len + size);
>  failure:
> @@ -445,6 +474,7 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>  			      struct beauty_payload_enter *payload, u64 offset)
>  {
>  	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
> +	int read_err = 0;
>  	struct augmented_arg *payload_offset;
>  	s64 aug_size, size;
>  	bool augmented;
> @@ -467,8 +497,18 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
>  	if (size == 1) { /* string */
>  		aug_size = bpf_probe_read_user_str(payload_offset->value, value_size, arg);
>  		/* minimum of 0 to pass the verifier */
> -		if (aug_size < 0)
> +		if (aug_size < 0) {
> +			/*
> +			 * Record why nothing was read. The header sits in
> +			 * scratch that the next syscall on this CPU reuses,
> +			 * so an error left unwritten is the previous one's.
> +			 * No beautifier reads it yet, beauty.h still calls
> +			 * the field int_arg, so the string is still shown
> +			 * as an empty one.
> +			 */

Do we really need this comment?  Looks too verbose.

Thanks,
Namhyung


> +			read_err = aug_size;
>  			aug_size = 0;
> +		}
>  
>  		augmented = true;
>  	} else if (size > 0 && size <= value_size) { /* struct */
> @@ -498,6 +538,7 @@ static inline int augment_arg(struct syscall_enter_args *args, int i,
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
