Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98D472F77
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656141; cv=none; b=f7gTunGaIiVE4QlE5koNir/wJHdzoxPwToBP9nU7AkV39K/lsgvoYeetutnaPM8YyR2SL0pF+p3+oGz0w6uHodfITtBZAwk1B9EZ9GoINvQIZ1t0heckIczmjpHw3Dky6pzAUujWsNjkFBszv1RuSxztKIEhX7dPHj2Aq1eJ06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656141; c=relaxed/simple;
	bh=b9QbzBgvu3fagoCGxsztOljhOMQUod5GuQKMjmWgrqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qBK+bl0q40iKmsYt31xlL1m+rcH69eB7/TBygUs0me8yRwp8wOxvxmjdBbhLbaSnOyGReMOlEjwbtfbGwp9GcMkw+Ck3Vt8c+pltTC1h2ze2+drTwlaW/GjeFbn00vHYvPASLRGI7kAPgqU41uYB5qTAApuJjwz/qNC4cXWn1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5e8/J+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5e8/J+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739451F00A3A;
	Tue, 21 Jul 2026 17:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784656138;
	bh=/zoEbDqkcRS4X8I/Y1uT7/+AUoR3nCR++9fDgx+rIBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C5e8/J+7Y5b+6m+Mop8cJFp/7AIDwugbB9/7rgdLmKAeJVdNgLi0C/8++ImJkHGgu
	 Al5ONnM6qGfkUyNqHvhyk5Ku8gR86bRqZgjV3HdjbOmc9fUaXCHG25cfpWv5eRo9LR
	 531+7M+AmlHbbvnrmg+glj76T6hDoRZw9l88WmldqyCynMTsGJejL3WBX2T04BQcY2
	 4WDCRwSokYvEOiYlGScWQ7LYP1qEZwU4fq0UDKq9G7jq0GlZ1hO6uzDuP9EeCr0Q52
	 FhcE7hov3u4IIhF5sahoDgTSjVzsBhHLeD4PZw91YUU1Ix6cQ5SCD9+yagbtCj2oFg
	 Uu2nuBJiXPEXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] perf synthetic-events: Fix line synchronization,
 bounds, and truncation bugs in proc maps reader
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260721173347.9163-3-irogers@google.com>
References: <20260720225200.3810501-1-irogers@google.com>
 <20260721173347.9163-1-irogers@google.com>
 <20260721173347.9163-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:48:56 +0000
Message-Id: <20260721174857.739451F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] io__drain_line() fails to drain the line when a parsing error oc=
curs, breaking map parsing synchronization and causing inefficient cascadin=
g failures.
--

--- Patch [2]: [PATCH v3 2/4] perf synthetic-events: Fix line synchronizati=
on, bounds, and truncation bugs in proc maps reader ---
commit ffbc393b4ac8d55ab5ee2db18d5f9a92e83c09d1
Author: Ian Rogers <irogers@google.com>

perf synthetic-events: Fix line synchronization, bounds, and truncation bug=
s in proc maps reader

This commit fixes logic and boundary bugs in read_proc_maps_line() and its
callers. It adds io__drain_line() to safely ignore already-consumed
newlines and preserve synchronization for subsequent map entries.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 5307d707711d8..059dd558a564c 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -291,6 +291,17 @@ static int perf_event__synthesize_fork(const struct =
perf_tool *tool,
>  	return 0;
>  }
> =20
> +static void io__drain_line(struct io *io, int ch)
> +{
> +	if (ch =3D=3D '\n')
> +		return;
> +	if (ch =3D=3D -2 && io->data > io->buf && io->data[-1] =3D=3D '\n')
> +		return;
> +
> +	while (ch >=3D 0 && ch !=3D '\n')
> +		ch =3D io__get_char(io);

[Severity: Medium]
Will this loop correctly drain the line when a parsing error occurs?

When io__get_hex() or io__get_dec() encounters an invalid first character,
they consume it and return -2. read_proc_maps_line() then calls
io__drain_line(io, -2).

Because the loop condition strictly requires ch >=3D 0, it will skip entire=
ly
when passed the -2 error code, returning without consuming any characters.

Instead of draining the rest of the line, the parser will re-evaluate every
remaining character as the potential start of a new map entry, leading to
parsing desynchronization and a tight loop of failures that could trigger
the timeout watchdog.

> +}
> +
>  static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
>  				u32 *prot, u32 *flags, __u64 *offset,
>  				u32 *maj, u32 *min,
> @@ -299,69 +310,127 @@ static bool read_proc_maps_line(struct io *io, __u=
64 *start, __u64 *end,
>  {
>  	__u64 temp;
>  	int ch;
> -	char *start_pathname =3D pathname;
> +	size_t written =3D 0;
> +	bool overflowed =3D false;
> =20
> -	if (io__get_hex(io, start) !=3D '-')
> +	ch =3D io__get_hex(io, start);
> +	if (ch !=3D '-') {
> +		if (!io->eof)
> +			io__drain_line(io, ch);
>  		return false;
> -	if (io__get_hex(io, end) !=3D ' ')
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721173347.9163=
-1-irogers@google.com?part=3D2
