Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091643CE66
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904463; cv=none; b=SQGyZuINyXHdJtRV13uXgqEegC0OEe/8NrTy7YFrhKM5cy52ORwC39yGcBKd57wgy7F9JEap3ope++rlHpznk8m8KkvVrWV7IEQlMM3J39SQinqMUL80FOegZTdnb90HONdOm3y+NB8t4D072ZTHgW0AI3mhRxNQ2ePK0wNLw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904463; c=relaxed/simple;
	bh=oaZYlF4WjsLRSJUtRY713RXzf94Irbv1Ut6+Oawbeso=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ReqlgYJ4CxbUyUUX9sHcdRLv3KOJCVF7ooMnblq62c9ghQcR2kTCWa/XMf7NBT6goDMQ/gE1hzzqRWcqe6+TxEUmOOAmnjRhB5LBI1wM+L7d9q5Hd67/xqUZz5OdjSAggG8IPFNrs5JxJG8nMR86YXiDM8+1vtljl8KmucwQczY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUcW64xi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUcW64xi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8FE1F000E9;
	Fri, 24 Jul 2026 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784904461;
	bh=NOiUnNj3QNNSZg78wVtOwbIU/PPD2eatQEST+jLUIPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CUcW64xi6uBdqplLN7ZfJvOFGuCO1QAPVDM4IiV/taunaWm4cbSnDH4Zf3IB6PQj5
	 kpL8gNXCtwA+SoX18GJFafXWiETsF8GF/r8ApxDvSMvhSQu2w2Pamb6k4EviUteykS
	 4E5J1Rx6IZIaZDKmZdDr6FcgrAyFGnuGVp6RPpQkWh8gDutHkqf3fVe/Tg1ZWx1tqh
	 H+AGFoCUYdWQpLmr6znvQeT24DXsbQwcnYcED7+Rb75nIro+mEvShBYfCz4c1XrfWY
	 0xMJVVELl8PuFLGcXxx9dkRTVZbj5LV8VDcFCN1WHuRL5dhPbg4i0T7EizFjxteCKD
	 HGfIByGawXEqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] perf trace-event: Fix integer truncation in
 do_read() and skip()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tanushree Shah" <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260724141316.99507-3-tshah@linux.ibm.com>
References: <20260724141316.99507-1-tshah@linux.ibm.com>
 <20260724141316.99507-3-tshah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:47:40 +0000
Message-Id: <20260724144741.5D8FE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer overflow in read_saved_cmdline() leads to massive heap=
 buffer overflow
--

--- Patch [2]: [PATCH v3 2/5] perf trace-event: Fix integer truncation in d=
o_read() and skip() ---
commit 907c8b1b7591be61f25cc72141dbcdba5822dfa4
Author: Tanushree Shah <tshah@linux.ibm.com>

perf trace-event: Fix integer truncation in do_read() and skip()

The do_read() and skip() functions use 'int' for size parameters,
truncating 64-bit sizes from callers. This causes two issues:

1. Uninitialized memory dump: do_read() reads fewer bytes than
   allocated, leaving uninitialized heap memory that gets written
   to output files.

2. Out-of-bounds read: Parsing functions process the full 64-bit
   size while only partial data was read into the buffer.

Change do_read(), __do_read(), and skip() to use size_t for size
parameters and ssize_t for return values (where applicable), matching
read()/write() system calls.
Update callers to use ssize_t for storing return values.

> diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-e=
vent-read.c
> index afd458cf1387d..52ed496d92c3b 100644
> --- a/tools/perf/util/trace-event-read.c
> +++ b/tools/perf/util/trace-event-read.c

[ ... ]

> @@ -350,7 +350,7 @@ static int read_saved_cmdline(struct tep_handle *peve=
nt)
>  {
>  	unsigned long long size;
>  	char *buf;
> -	int ret;
> +	ssize_t ret;
> =20
>  	/* it can have 0 size */
>  	size =3D read8(pevent);

[Severity: Critical]
This is a pre-existing issue, but can this lead to a massive heap buffer
overflow?

In read_saved_cmdline(), size is an 8-byte value read directly from the
untrusted file:

	size =3D read8(pevent);
	if (!size)
		return 0;

	buf =3D malloc(size + 1);
	if (buf =3D=3D NULL)
		return -1;

	ret =3D do_read(buf, size);

If the size read from the file is ULLONG_MAX (or UINT_MAX on 32-bit systems=
),
the size + 1 expression will wrap to 0.

The malloc(0) call will then succeed and return a small heap chunk, but the
original unwrapped massive size is passed to do_read(), which will loop and
read an enormous amount of data directly into the tiny buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724141316.9950=
7-1-tshah@linux.ibm.com?part=3D2
