Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B5D2550D5;
	Sun,  6 Sep 2026 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715773; cv=none; b=GB0oV/miEigIkXk2oDeMjvmQrwqFc6yW+bahonoDMrDhncwjVw/qYeu4LSdcZCb/+i3GWlmmsaMf/b+Y4JQKcy2FgI6RDNhVXKz4nT1nfFGx5oVKaB+tUSKfPjSEhJeOQV7BjPEvw4nzobyi4lVq7kxbIAc6ANZgBaMItoU3YxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715773; c=relaxed/simple;
	bh=0Dqconh04ftg2h8VeKcfsWTv4Da3T/HTpfrzoUAYz7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YEpd42BjfUx6FTlsVftAby2XkUKvF6J7h77aILSwlDIrrea7PE3c3Lq5GWgiiaiKLCOyiOGSjihJiDoBPOZXNV5ZZTRvP2B5b1A9YbAx3FWCfxdbtqFq7vsPYgLc2kTyKVlQRQDrZvjWIfb/eBkPL8O52jDtXzKf6R3zxE0bl6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X43cKvB7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X43cKvB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E04D1F00A3A;
	Sun,  6 Sep 2026 17:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788715770;
	bh=VWScQdM791uL4Y7CuT8K52/Yd/BEJ2OT7Sk+qX3YNqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X43cKvB7m9RP8jyLzI4kaOYVXxpRgkabnY2NfEkDegrV1yGUqZH7qQ6e6aiU6Taqp
	 uTY6P/RQETmlESWnNMqRo6+c8mEsC7VZ6vaD3TaFfjug/gYWhceAtQgMHiPJVG86fw
	 UmBCjy7h1ViBdZwbW60a6nEEQSZHQKYPYxBNJj1SmjHmOUMzqOqyMiWfCKDh1fb1zP
	 IG8dCP+I0y+r06taWtEho9MXEVTfuP8pShQmyD7tZX+ZkjiSRxi3lO3jMLrCwMm28m
	 BKRMZys5RUO7uqRBslpY0heABmNCoAUBKvxCbNm3Z5wZAHavH6l2cFhEyihjkO1RmW
	 OZ9q9CvCcTC/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] perf tools: fix GTK4 leftover show/hide calls
 and error-loop list race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260906-perf-gtk2-v4-3-97e92ee07214@gmail.com>
References: <20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com>
 <20260906-perf-gtk2-v4-3-97e92ee07214@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 17:29:30 +0000
Message-Id: <20260906172930.9E04D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Using sigprocmask() to protect a shared list from a signal handl=
er is insufficient in a multithreaded process, leaving a cross-thread race =
condition unfixed.
--

commit af57548ca0fbe17de3fec0bdb3270cfd5750a038
Author: Matt Turner <mattst88@gmail.com>

perf tools: fix GTK4 leftover show/hide calls and error-loop list race

This commit updates legacy GTK functions for GTK4 compatibility. It also
attempts to fix a list corruption issue in the error dialog by wrapping list
modifications with a signal block.

> diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
> index 8a922851257e7..f1dbd96e2370e 100644
> --- a/tools/perf/ui/gtk/util.c
> +++ b/tools/perf/ui/gtk/util.c

[ ... ]

> @@ -48,6 +49,25 @@ void perf_gtk__quit_error_dialog(void)
>  	g_slist_foreach(perf_gtk__error_loops, perf_gtk__quit_loop, NULL);
>  }
> =20
> +/*
> + * perf_gtk__signal() runs perf_gtk__quit_error_dialog() from a signal
> + * handler, which can preempt perf_gtk__error() while it is updating
> + * perf_gtk__error_loops below. Block those signals around the update so
> + * the list is never traversed half-modified.
> + */
> +static void perf_gtk__block_exit_signals(sigset_t *old_set)
> +{
> +	sigset_t set;
> +
> +	sigemptyset(&set);
> +	sigaddset(&set, SIGSEGV);
> +	sigaddset(&set, SIGFPE);
> +	sigaddset(&set, SIGINT);
> +	sigaddset(&set, SIGQUIT);
> +	sigaddset(&set, SIGTERM);
> +	sigprocmask(SIG_BLOCK, &set, old_set);

[Severity: Medium]
Is sigprocmask() sufficient to prevent signal handler execution in a
multithreaded application?

Since perf uses multiple threads, sigprocmask() will only mask these
signals for the local thread. Can the kernel still deliver a signal like
SIGINT to another unmasked thread, causing it to execute the handler
concurrently?

Additionally, does blocking synchronous signals like SIGSEGV and SIGFPE
using sigprocmask() result in undefined behavior per the POSIX standard?

> +}
> +
>  static void perf_gtk__dialog_response(GtkDialog *dialog,

[ ... ]

> @@ -86,7 +107,9 @@ static int perf_gtk__error(const char *format, va_list=
 args)
>  	 * outlive the dialog and hang.
>  	 */
>  	loop =3D g_main_loop_new(NULL, FALSE);
> +	perf_gtk__block_exit_signals(&old_set);
>  	perf_gtk__error_loops =3D g_slist_prepend(perf_gtk__error_loops, loop);
> +	sigprocmask(SIG_SETMASK, &old_set, NULL);

[Severity: Medium]
Because local signal masking doesn't prevent other threads from executing
the signal handler globally, can a user sending SIGINT still trigger the
signal handler on a different thread while the GTK thread is actively
modifying perf_gtk__error_loops here?

Would this concurrent modification and traversal of the GLib linked list
lead to memory corruption or crashes?

>  	g_signal_connect(dialog, "response",
>  			 G_CALLBACK(perf_gtk__dialog_response), NULL);
>  	g_signal_connect_swapped(dialog, "destroy",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-perf-gtk2-=
v4-0-97e92ee07214@gmail.com?part=3D3
