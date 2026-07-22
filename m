Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5391E33937A
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716512; cv=none; b=j/9dHJOrQZFMZzZyM3ClBpFpDnKDzJK7lJfnCkH+TgFxnUsofwsralsF/jpWU8JuyEf0gKEFg1nvDdPsrBF+f3b+c9MGq3TNj0vHWkYuhU0W4NKvqBbUxt288CnQTUAJwJdyBh6jr+eMJJ3FRZYBtPjlCwtWpA7zQte65uuctMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716512; c=relaxed/simple;
	bh=wKbYxs5eUZ1/wN/eV8FFPZ4MQ25kfzn1s7ZHsMLljP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rF0dASrFVk0DlzCH3wPXiUy7n5I5qfn6rg+XIeoCUlCLTKDJ+rJFrbLR0L3HjSlZVgbNMyyUakoXun5T4wsyWH6KCQEkfReOsueuU2NnhnLm7H8cuS3wZykg8voDA1hw4HkFaq9ANcBekv6xQwLLDoWZAZ6fGYR5TOWyk32fwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuxZ2DK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuxZ2DK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F241F000E9;
	Wed, 22 Jul 2026 10:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784716510;
	bh=/071TebtdtkR8nn76hb5KRenjnQMVO4jANNjbwX/WAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CuxZ2DK3YTEMdhvgG/KJYI2xdsAjff6L6uwKbTb/Ud42TVFELWlkT0jLfwjGt3ZNt
	 /Jx6sqMxSVxtp0HF/uRg/+0s3YgjbV5+VPqsR1RGvmXGAl/KFih5duN6knK/fbvgLP
	 Ac+HMHVUmqjnrscsYllWb7pM8Rmjd7bBOGbbN5/dhFBfLDduffjxAdzY5p4V+ZIqWs
	 4qWctlKNevaqde/Tw7DhQK/RxW0mwuMC9N6fWx6LvYoS0D6aAAvSOLIfNOSTvVq/8S
	 Rte2ZjACX6Ar3LIZBqb4r+AepIC5qfm0xc4g8yJvdoC9I0xWDD9uIxeoB8Ffhb15/y
	 UIGmDtNp5JaxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf unwind-libdw: Fix unwinding of multi-threaded
 processes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alessio Podda" <aleph.pi.gh@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260722102407.3755154-1-aleph.pi.gh@gmail.com>
References: <20260722102407.3755154-1-aleph.pi.gh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 10:35:10 +0000
Message-Id: <20260722103510.B7F241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Missing explicit POSIX standard header inclusion for `<assert.h>`, =
breaking compatibility with musl libc.

Pre-existing issues:
- [High] Missing NULL check on `zalloc` allocation for `dwfl_ui_ti` leads t=
o a NULL pointer dereference, and unchecked `dwfl_begin()` failure leads to=
 a memory leak.
- [High] The local pointer `ui` is declared as a static variable but is dyn=
amically allocated and freed within the function, creating a severe data ra=
ce.
--

--- Patch [1]: [PATCH] perf unwind-libdw: Fix unwinding of multi-threaded p=
rocesses ---
commit cd2051f3de0d807edd3e4fcc7ed115a6364be27d
Author: Alessio Podda <aleph.pi.gh@gmail.com>

perf unwind-libdw: Fix unwinding of multi-threaded processes

This commit fixes unwinding of multi-threaded processes in perf. It updates
next_thread() to return the current sample's TID and provides get_thread()
so libdw can find the thread directly.

> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index 7f35042be5677..3735ef83c8c48 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -173,14 +173,30 @@ static int entry(u64 ip, struct unwind_info *ui)
>  	return 0;
>  }
> =20
> -static pid_t next_thread(Dwfl *dwfl, void *arg, void **thread_argp)
> +static pid_t next_thread(Dwfl *dwfl __maybe_unused, void *arg, void **th=
read_argp)
>  {
> +	struct dwfl_ui_thread_info *dwfl_ui_ti =3D arg;
> +
>  	/* We want only single thread to be processed. */
>  	if (*thread_argp !=3D NULL)
>  		return 0;
> =20
> +	assert(dwfl_ui_ti->ui !=3D NULL);

[Severity: Low]
Does this file need an explicit include for <assert.h>? The perf subsystem
guidelines require direct POSIX header inclusions for compatibility with
musl libc, and it appears the assert macro is being introduced here without
it.

> +	*thread_argp =3D arg;
> -	return dwfl_pid(dwfl);
> +	return thread__tid(dwfl_ui_ti->ui->thread);
>  }

[ ... ]

> @@ -400,7 +417,7 @@ int libdw__get_entries(unwind_entry_cb_t cb, void *ar=
g,
>  	if (err)
>  		goto out;
> =20
> -	dwfl_attach_state(dwfl, /*elf=3D*/NULL, thread__tid(thread), &callbacks,
> +	dwfl_attach_state(dwfl, /*elf=3D*/NULL, thread__pid(thread), &callbacks,
>  			  /* Dwfl thread function argument*/dwfl_ui_ti);
>  	// Ignore thread already attached error.

[Severity: High]
This is a pre-existing issue, but can the allocation for dwfl_ui_ti fail
and lead to a NULL pointer dereference?

Looking at earlier code in libdw__get_entries():

	dwfl_ui_ti =3D zalloc(sizeof(*dwfl_ui_ti));
	dwfl =3D dwfl_begin(&offline_callbacks);
	if (!dwfl)
		goto out;

	dwfl_ui_ti->dwfl =3D dwfl;

If zalloc fails, it seems we would dereference the NULL dwfl_ui_ti right
away. Also, if dwfl_begin fails, we jump to out:

out:
...
	dwfl_ui_ti->ui =3D NULL;

which would also dereference NULL, or leak the allocated dwfl_ui_ti if
zalloc had succeeded. Does this error path need a NULL check and proper
cleanup?

[Severity: High]
This is a pre-existing issue, but does the static declaration of the ui
pointer cause data races?

In libdw__get_entries(), ui is declared as static but dynamically
allocated:

	static struct unwind_info *ui;
...
	ui =3D zalloc(sizeof(*ui) + sizeof(ui->entries[0]) * max_stack);

And then freed at the end of the same function:

	free(ui);

If multiple threads process events concurrently, could this static pointer
be overwritten, leading to memory leaks, use-after-free, or double-free
issues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722102407.3755=
154-1-aleph.pi.gh@gmail.com?part=3D1
