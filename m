Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BCA37D10A
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381592; cv=none; b=mHhTtuSt46mW72kh8vmVIqn4lu6eu/ohla5FAUQiRl4YFSrQj5eKK8YO2tZDYt+eduhxfTu5DX5FkDX5k8J4fQcQmrQo8FxRQx610oSUh1Jky76NAd5fDrQkj250s5wTE7Ur2uIfUtgbCbBt9GbET+H89hsfO0cUv3vOFleMjHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381592; c=relaxed/simple;
	bh=YHPvEd+7R3rd3MNNDRNixFdLdi1rBU4Tb/PT9XoaD6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VWZ/DMRvXUQPw1U7NGd2vtEWeOOfvJ/8hifOavOHH8SScrlEd8IsA/lOqZkTRWptTOC1e8mFZNP0XUh615WgW7TUHFSHxmlUNhbM1XcWxb91MLwDjPUOYySwpNJdjv9fsjZ3zNg9XtRHOC5KG4MoCeAy5ZLQg/Ae/95FgDp0v5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgVfNvxZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgVfNvxZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2FB1F000E9;
	Thu, 21 May 2026 16:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779381591;
	bh=mjLi6CvR6vrgd0iqo9Pctjav/W0QtN8rLeOjYi1E7+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QgVfNvxZ1XUwOLU2t1eILVKby78HjopyZVT5cRbZDVQJhYpWLe9KZnKDhxL9gOoS7
	 F4BIRHur8Lqg8vCVIHr9ETxPULClSs9VlpKgaWrSndWLz0G/LtkV63UGh41TmOoRVh
	 n+HaGiVlOhyEUQdqjGQLwVxUsl9jS9fbVFQHRvadeatpfAgkE8KC3hKpdt90sIfD3c
	 6ioUlfySF5/7LhgA/CqwSwWnQqKNsn9I2Ng9+xwXP3V97ZVqIL0rRPf/B1AgcZHroJ
	 sTrSxFvbN88fKwDRI2nrK1bSAfVIt+KzR0kCrKwrGdInjbDGNlaFkRkvxO2x26YLT7
	 80He+R9zZ+VNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf bench: add --write-size option to sched pipe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260521-perf_bench_pipe-v2-1-720b6ff7f0fa@debian.org>
References: <20260521-perf_bench_pipe-v2-1-720b6ff7f0fa@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 16:39:50 +0000
Message-Id: <20260521163951.2E2FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] File descriptors allocated for pipes are leaked when returning e=
arly due to an fcntl() failure.
--

commit a15da46bb7bbcff2fe4b600fd4cd1fdf6d6d3ff0
Author: Breno Leitao <leitao@debian.org>

perf bench: add --write-size option to sched pipe

This commit adds a --write-size option to the sched pipe benchmark in perf =
to
allow testing the pipe page-allocation path. It updates the benchmark to
allocate a buffer per thread and resize the pipe capacity via fcntl() when a
larger write size is specified.

> diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
> index 70139036d68f0..216d3121d438d 100644
> --- a/tools/perf/bench/sched-pipe.c
> +++ b/tools/perf/bench/sched-pipe.c
[ ... ]
> @@ -233,12 +238,39 @@ int bench_sched_pipe(int argc, const char **argv)
[ ... ]
>  	BUG_ON(pipe2(pipe_1, flags));
>  	BUG_ON(pipe2(pipe_2, flags));
> =20
> +	/*
> +	 * On a custom write_size, resize the pipes so a single payload fits.
> +	 */
> +	if (write_size > sizeof(int)) {
> +		int r1 =3D fcntl(pipe_1[1], F_SETPIPE_SZ, write_size);
> +		int r2 =3D fcntl(pipe_2[1], F_SETPIPE_SZ, write_size);
> +
> +		if (r1 < 0 || r2 < 0 ||
> +		    (unsigned int)r1 < write_size ||
> +		    (unsigned int)r2 < write_size) {
> +			fprintf(stderr,
> +				"--write-size %u exceeds /proc/sys/fs/pipe-max-size\n",
> +				write_size);
> +			return -1;

[Severity: Medium]
Are the file descriptors allocated for pipe_1 and pipe_2 leaked on this err=
or
path?

The pipe2() calls just above this block allocate four file descriptors. If =
the
fcntl() operations fail and this path returns -1, those descriptors appear =
to
be left open.

> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-perf_bench=
_pipe-v2-1-720b6ff7f0fa@debian.org?part=3D1
