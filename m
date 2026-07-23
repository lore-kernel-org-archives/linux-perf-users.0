Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB423EA84
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801455; cv=none; b=lmok1pJLzqEWb3v6GXaYiHc631cXHgQXsACO64qxlBNfVGm9u4Cq/0tofKt2Zh6qfwk/X+wOiPKHOe0pPdWdMTH8ku4xdMw2+NnFA9lVouvjeRxvglu9HmRluAJM9Ny+ATNvCY616fnndJllnEEi3x6MFhzFd5KmGYvwLNJqps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801455; c=relaxed/simple;
	bh=Np2VfH1Pwm7u1ZXZ0FJ0m9Qjl/QfgG9Zsv10gFadfQ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CD/cmpfMz6uDggZxsWQoEgdgrxxLt6yHHxt9Hat+0Cf3E8woWub7IGKBf+cXcUB/7XDmLSD/1K2BmjmcNhesifXGynxLm6hCYItI3kF5M4W6rhjD8yustbbZuhkZzhQqMnN07BPh5VZAjaRS5zlfWLZTPpUhCrKTeQbW1QLY9F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRMkoNbD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRMkoNbD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ABE1F000E9;
	Thu, 23 Jul 2026 10:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784801454;
	bh=ae0OWHctOJiozJRD9/TXID3MSYk4xmoJH6N1jL922dU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gRMkoNbDn2sakhQiowl00ctKzweH3bwpP1mP26hJSE72PRnAhW6LNs42JM1TeEzS4
	 5r/EHfX9rFwBMMIVTrI9jzlZfc93zl4gyII06FCEmQj/QI+AEh1jkSSEmtAyX5sTNW
	 MKC2aBIojxO6zoRHBqhlvc7SbwGzWiuZrVi0ZiKD+OFid7zKtteDBj9pKau62nJZKZ
	 IhqCDiTJZD4kN8xJ9ET/64umGZrUuCIfu8NDqtCuSeeRVxTzvcZn25sVe5UaGwsFcn
	 5lWxRBjrlwW6LLVBSr/wHMFq0hBzlBn6aPWw+duu8UikEvjQj8HEVu8QcRxwMw7XRn
	 kDn79kU/80Kog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf trace-event: Fix integer truncation in
 do_read() and skip()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260723093958.416650-6-tshah@linux.ibm.com>
References: <20260723093958.416650-3-tshah@linux.ibm.com>
 <20260723093958.416650-6-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:10:52 +0000
Message-Id: <20260723101054.09ABE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Heap buffer overflow in `read_ftrace_printk` unmasked by `size=
_t` conversion.
- [High] Infinite loop in `skip()` leading to Denial of Service.
--

--- Patch [2]: [PATCH v2 2/2] perf trace-event: Fix integer truncation in d=
o_read() and skip() ---
commit b30cf605f4d2ba7957c47c5106a821726355dd7e
Author: Tanushree Shah <tshah@linux.ibm.com>

perf trace-event: Fix integer truncation in do_read() and skip()

This commit modifies do_read(), __do_read(), and skip() to use size_t and
ssize_t instead of int for sizes and return values. This addresses integer
truncation of 64-bit sizes, fixing uninitialized memory dumps and out-of-bo=
unds
reads in the perf tools.

> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-e=
vent-read.c
> index afd458cf1387d..52ed496d92c3b 100644
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c
> @@ -51,13 +51,13 @@ static int __do_read(int fd, void *buf, int size)
>  	return rsize;
>  }
> =20
> -static int do_read(void *data, int size)
> +static ssize_t do_read(void *data, size_t size)

[Severity: Critical]
Does changing the size parameter to size_t unmask a heap buffer overflow in
read_ftrace_printk()?

If a crafted file supplies 0xFFFFFFFF, it triggers an overflow in
read_ftrace_printk():

read_ftrace_printk() {
        size =3D read4(pevent);
        ...
        buf =3D malloc(size + 1);
        if (buf =3D=3D NULL)
                return -1;

        if (do_read(buf, size) < 0) {
        ...
}

Because size + 1 overflows to 0, malloc(0) returns a minimal heap chunk.

Previously, passing 0xFFFFFFFF to do_read() truncated the size parameter
to -1. When this -1 was passed to the read() syscall on 64-bit systems,
it became ULLONG_MAX. This failed boundary checks against TASK_SIZE_MAX,
causing the kernel to immediately return -EFAULT and preventing the read.

With size now being size_t, 0xFFFFFFFF is passed directly to the read()
syscall as 4294967295ULL. Because this is below the 64-bit TASK_SIZE_MAX
limit, the kernel will read up to MAX_RW_COUNT of file data into the tiny
allocated buffer.

Could this be prevented by adding a bounds check before the allocation?

>  {
> -	int r;
> +	ssize_t r;
> =20
>  	r =3D __do_read(input_fd, data, size);

[ ... ]

>  /* If it fails, the next read will report it */
> -static void skip(int size)
> +static void skip(size_t size)
>  {
>  	char buf[BUFSIZ];
> -	int r;
> +	size_t r;
> =20
>  	while (size) {
>  		r =3D size > BUFSIZ ? BUFSIZ : size;
>  		do_read(buf, r);
>  		size -=3D r;
>  	}
>  }

[Severity: High]
Does this change introduce an infinite loop when a maliciously crafted
perf.data file provides a massive 64-bit size?

Before the patch, passing ULLONG_MAX was implicitly truncated to -1.
In the first loop iteration, r =3D size > BUFSIZ ? BUFSIZ : size evaluated
-1 > 8192 as false, setting r =3D -1. Then size -=3D r set size to 0,
terminating the loop immediately.

Now that size is widened to size_t, skip() will continuously subtract
BUFSIZ from ULLONG_MAX. Because skip() ignores the return value of
do_read(), does this cause the perf process to spin endlessly even
after reaching EOF?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723093958.4166=
50-3-tshah@linux.ibm.com?part=3D2
