Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AEE33AD9A
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890852; cv=none; b=hZ5HJdBa2q2sIlLU7UxLPsyBRSoRpevWT1HO106wENFH2tps6SRU0EuTe7PlGHR79b9xJqudAtDu0lu4TJxv0rAyL7VLLKTBT4t5JJw8tjGe/hyK+Iruz1RQQIgXPzdzHnM3TJIFffnUe/o8w72JTqxm6ezTwiK2MJo1zep9ks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890852; c=relaxed/simple;
	bh=wN5MfpZAYjtdexqPlYeXWvcEhLHqLe0D810E8XvW+uE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MovA6vrvVQNRiCXUaV/EUiGjyzygE5U888H/snwTS9H4V+XGP4l60pZ4bgYa0jO8XW+4T/6IY36ytEX17rL3WI3vmyzI0punPWM+76QUjM/Buhmgmg0KYmOCgLJbWpb6dRH4oRyIodj8GR11FyPKKH4PFNFbISo/04mBEd+tebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayp/BuVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayp/BuVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E3E1F00A3F;
	Wed, 27 May 2026 14:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779890851;
	bh=dNcbyiU2lNyvcsumZ2NuSgNoeBYbmcWXgRxROCIsyg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ayp/BuVn/fNWabL0420HJjp2bOcYZBAmKpOYe5/rf7eHJxc6w40rhAOE+f8uFyNIB
	 r1XxZc+UCvcJboVZVW1oq/uEg0/Vc2XZ7Rrep2iDkTtqkbcenuYk67jTW3/zzPpZD6
	 x8BtMylq/t7LDNCaa6lWTHIsMq9o9XsGk5h5XQG15VP7fV0fyZgs/jbeVm0MJO0e83
	 RVYsOONSyF0jl5QHEgh5y93gMZ3ZAEdLgyBFi608uZhMFQyWxUBJMrf3lLDXPAMj3p
	 IxXgfxRyza9T9veaTVIhrN6lfBHlFguzqz5M7RRMONaQ9J/oQvYtQrHPtLI3hE6B6c
	 WYpyYbiKwtUQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf bench: add --write-size option to sched pipe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260527-perf_bench_pipe-v3-1-9eee9465d673@debian.org>
References: <20260527-perf_bench_pipe-v3-1-9eee9465d673@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 14:07:30 +0000
Message-Id: <20260527140731.32E3E1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The non-blocking write path introduces a tight busy-wait loop on=
 EWOULDBLOCK, causing starvation and potential deadlocks.
- [Low] File descriptors and memory are leaked on newly introduced early re=
turn paths.
--

commit c7942cedee2c5b9a3322f72facfe0fec690b4acf
Author: Breno Leitao <leitao@debian.org>

perf bench: add --write-size option to sched pipe

This commit adds a --write-size option to the sched pipe benchmark to set
the bytes written and read per ping-pong iteration. It replaces the on-stack
integer with a dynamically allocated buffer and resizes the pipe to match
the write size.

> diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
> index 70139036d68f0..7a14abc360473 100644
> --- a/tools/perf/bench/sched-pipe.c
> +++ b/tools/perf/bench/sched-pipe.c
[ ... ]
> @@ -170,25 +175,57 @@ static void exit_cgroup(int nr)
>  	free(cgrp_names[nr]);
>  }
> =20
> +/*
> + * Loop on short read()/write(): the kernel may return fewer bytes than
> + * requested, and in non-blocking mode the writer can transiently hit
> + * EWOULDBLOCK while the peer is still draining a full pipe (capacity is
> + * sized to write_size).
> + */
> +static inline int write_pipe(struct thread_data *td)
> +{
> +	unsigned int done =3D 0;
> +	int ret;
> +
> +	while (done < write_size) {
> +		ret =3D write(td->pipe_write, td->buf + done, write_size - done);
> +		if (ret < 0) {
> +			if (nonblocking && errno =3D=3D EWOULDBLOCK)
> +				continue;

[Severity: Medium]
Could this tight-loop on EWOULDBLOCK without an epoll_wait() or yield cause
issues?

Since the benchmark runs in a ping-pong fashion and resize_pipes() sizes
the capacity close to write_size, the pipe can fill quickly. Does this
artificial spinning distort the context-switch latency measurements?

Also, is there a risk of deadlocking if the threads are running under a
real-time scheduler (like SCHED_FIFO) on the same CPU?

> +			return ret;
> +		}
> +		done +=3D ret;
> +	}
> +	return done;
> +}
[ ... ]
> @@ -233,12 +293,25 @@ int bench_sched_pipe(int argc, const char **argv)
> =20
>  	argc =3D parse_options(argc, argv, options, bench_sched_pipe_usage, 0);
> =20
> +	if (write_size =3D=3D 0 || write_size > INT_MAX) {
> +		fprintf(stderr, "--write-size must be in 1..%d\n", INT_MAX);
> +		return -1;
> +	}

[Severity: Low]
Does returning early here bypass cgroup cleanup?=20

It appears parse_options() allocates memory for cgroups which is normally f=
reed=20
by exit_cgroup() at the end of the function.

> +
>  	if (nonblocking)
>  		flags |=3D O_NONBLOCK;
> =20
>  	BUG_ON(pipe2(pipe_1, flags));
>  	BUG_ON(pipe2(pipe_2, flags));
> =20
> +	if (resize_pipes(pipe_1[1], pipe_2[1]) < 0)
> +		return -1;

[Severity: Low]
Similarly, could this early return leak the newly opened pipe file
descriptors, as well as the cgroup allocations?

> +
> +	for (t =3D 0; t < nr_threads; t++) {
> +		threads[t].buf =3D calloc(1, write_size);
> +		BUG_ON(!threads[t].buf);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527-perf_bench=
_pipe-v3-1-9eee9465d673@debian.org?part=3D1
