Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0437347D954
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846751; cv=none; b=gY2rNfGWqxGd1dqtJrZrsilV6sJluGzjP84E8eNcHaZAwTazhtuNAwq7oQop1Jg11Kv/C3ru6y9oAUqwuqlmMs1H8CYxdek8A6PcNOAhZ+64SBHekkXkwhg1+rSs4clUoiq9Wpv+p6UH3O9M3g4FGaL78TuhoFIBQaOlUtmIRes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846751; c=relaxed/simple;
	bh=sRGE8mXLDUTfkE3eGAR7T5bSwiYW1LNHaldJT+5g0CM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cFA42obptn7BXxYTtVUyOE4/CuXXhUIiWGwzLeQuojcSntPPWQyRr6W7rfOw4s2gkA9O+90kGpBxnfis2rW9VJhUYYOVXhe/tsgcEweYIzSbVbOGmlRSRVx0LN641YU2VoZV4T4/LYEFwuhS70iE+lC5LQvngbPw8mzITJxcoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRrsIFGP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRrsIFGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEA0C2BCB0;
	Fri, 15 May 2026 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778846750;
	bh=sRGE8mXLDUTfkE3eGAR7T5bSwiYW1LNHaldJT+5g0CM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rRrsIFGP2PeM6nqrgIZHl0BV4RvOsQcQ0dMDSpymUuWelQxEr1q7Fds8QVyz81BCJ
	 sMaZLuxfubhDjY5UPaJFno8hrt7DfQV1hgAtHf/v+kOMB4/UmuLI7UledjDSOboi5Y
	 WK3lOhE33uHefY0wNn8RLZuMRfl8OHJtnTc9WqZyVLDO86AtzlIT/Yj0xjiXMoKh1k
	 wy0IycG0Wgp4Qpiwsci1bB+YqGOUnebpymetbA3+hDqzr8Ys+fEl1TaOXy/GqUrYRz
	 B8qGwNZedF9JeTMxCDb1laexgNs5VbbDh4aUeTkE8BcjPNKlXmaVylJc79CCN9V+2y
	 iEoFV3oUQniZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf bench: add --write-size option to sched pipe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260515-perf_bench_pipe-v1-1-3c5b805ba178@debian.org>
References: <20260515-perf_bench_pipe-v1-1-3c5b805ba178@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 12:05:49 +0000
Message-Id: <20260515120550.8DEA0C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Integer overflow in write_size cast bypasses pipe capacity validat=
ion and causes a deadlock.
- [High] Missing validation for write_size =3D=3D 0 causes benchmark hangs =
or bogus results.
- [Medium] File descriptor leak on the fcntl error path.
--

commit 2c945dc323a6b416d95bca3f92808b828bcc9c74
Author: Breno Leitao <leitao@debian.org>

perf bench: add --write-size option to sched pipe

This commit adds a -s/--write-size option to the sched pipe benchmark to set
the bytes written and read per ping-pong iteration. It also resizes the pipe
using F_SETPIPE_SZ to match the requested size.

> diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
> --- a/tools/perf/bench/sched-pipe.c
> +++ b/tools/perf/bench/sched-pipe.c
[ ... ]
> @@ -48,6 +49,7 @@ static	int			loops =3D LOOPS_DEFAULT;
>  static bool			threaded;
> =20
>  static bool			nonblocking;
> +static unsigned int		write_size =3D sizeof(int);

Is there a missing lower-bound check for write_size? If a user passes 0,
the vfs_write system call will return 0 immediately without invoking
pipe_write(), meaning no data is transferred and no readers are woken up.

In blocking mode, both threads could instantly spin through their loops
transferring 0 bytes, generating a falsely fast benchmark result without
measuring context switch latency. In non-blocking mode, the threads rely
on epoll_wait(), which would hang forever since the 0-byte write wouldn't
trigger EPOLLIN.

[ ... ]
> @@ -204,10 +209,10 @@ static void *worker_thread(void *__tdata)
>  	}
> =20
>  	for (i =3D 0; i < loops; i++) {
> -		ret =3D write(td->pipe_write, &m, sizeof(int));
> -		BUG_ON(ret !=3D sizeof(int));
> +		ret =3D write(td->pipe_write, td->buf, write_size);
> +		BUG_ON(ret !=3D (int)write_size);

Could this cast to (int) cause an unexpected crash? If write_size is larger
than INT_MAX, the cast results in a negative number, and positive return
values from write() would be compared against this negative number,
triggering the BUG_ON.

>  		ret =3D read_pipe(td);
> -		BUG_ON(ret !=3D sizeof(int));
> +		BUG_ON(ret !=3D (int)write_size);
>  	}
> =20
>  	return NULL;
> @@ -239,6 +244,22 @@ int bench_sched_pipe(int argc, const char **argv)
>  	BUG_ON(pipe2(pipe_1, flags));
>  	BUG_ON(pipe2(pipe_2, flags));
> =20
> +	/*
> +	 * On custom write_size, set the pipe size to acommodate write_size
> +	 */
> +	if (write_size > sizeof(int) &&
> +	    (fcntl(pipe_1[1], F_SETPIPE_SZ, write_size) < (int)write_size ||
> +	     fcntl(pipe_2[1], F_SETPIPE_SZ, write_size) < (int)write_size)) {

Does this signed cast bypass the pipe capacity validation when write_size
exceeds INT_MAX?

If fcntl() fails because the size exceeds system limits and returns -1, the
check evaluates as -1 < (negative number). Since -1 is not less than any
negative number, this evaluates to false, silently bypassing the error
handler.

The benchmark would then proceed with default 64KB pipes but attempt to
write >2GB payloads into them. Because the ping-pong design requires both
threads to fully execute write() before read(), both threads would fill
their respective pipes and block indefinitely, resulting in a deadlock.

> +		fprintf(stderr, "--write-size %u exceeds /proc/sys/fs/pipe-max-size\n",
> +			write_size);
> +		return -1;

Does this return path leak the pipe file descriptors? The benchmark allocat=
es
four file descriptors via pipe2() just above this block. If the early return
is taken, it appears to exit without passing through a cleanup path to close
the acquired file descriptors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515-perf_bench=
_pipe-v1-1-3c5b805ba178@debian.org?part=3D1
