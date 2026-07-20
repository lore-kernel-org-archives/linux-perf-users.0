Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4245A44C663
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570911; cv=none; b=kIRQxVnHLdC/7u2MLbeoxOCfMXyROqoPJXRZpqF7lBh31NrElYQZ7z2J+vV5nf1fNmsNKpN6XYHVm87IJJHm9dHUBYKA6XXQKtPFR8i2NJmBX8z3FXL7ItOaFftNuTDtZGvUzFKcLbe4WT0TG9ZRA8tkHKOWXCPZjtw/x4ryHJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570911; c=relaxed/simple;
	bh=oqgiXl9ZpKJWQeo2XM651rpvnpQ56Tg+Y5w/7x6PqzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EQ+KB52qs8LR0m4UAKzqTN5GHCrU96UORGYeIZsv4WYBylO8kykp5Tr7sTjvsIsl9Jfou2VSzgLaT+eFwxrhNNhdNCerl21HI/cjLCTsgphB2EIlxEUaePsSI6a5mmQdtrnzn779uxr3b1yTTy2dorsgwTQBtMnDpiI09eRH1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYQosmwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYQosmwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAB71F000E9;
	Mon, 20 Jul 2026 18:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784570909;
	bh=iBYU0nr8BsIZvNdgMxLMdfsAk2GU1hf31ShVflYBYec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hYQosmwGVfzhU6WUksD9G3EIg4siPF/Pcna1fDVJICGb88hYD0uu7HnfuXAXbncnL
	 AxoFUJRHHXdNw3opylKpHd2VPXXDbO6peADDc7gi7bTI+/iPKLJIjwxgzLWmh4XIZJ
	 /v9G6kYB5TxAJK75CXyiJ2WrLj7qYALP1yk/TNAqbeWzfbiPQFiqGqBckyrU+LszJz
	 M2Mu5o/2RxsfG7cAnrtecuSiAruj0JGRwTBGyD1o3M8a0zaBFjIG294IbW+Ak05fjR
	 CGaOURav4OngjF+iwqBC0uE6OkTDwTB/6Jw0KT+AW9ZxNfs9YFill+VqsBYfNFrjPU
	 who9Km/c+tz5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/4] perf synthetic-events: Fix line synchronization,
 bounds, and truncation bugs in proc maps reader
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720175455.3645946-3-irogers@google.com>
References: <20260720175455.3645946-1-irogers@google.com>
 <20260720175455.3645946-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:08:28 +0000
Message-Id: <20260720180829.7AAB71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Error recovery via `io__drain_line()` incorrectly consumes and dis=
cards the next valid map entry if a parsing failure occurs due to a prematu=
re newline character.
- [Medium] The PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT flag is silently dro=
pped if the truncation timeout triggers on a map entry that fails the PROT_=
EXEC/mmap_data filters.
--

--- Patch [2]: [PATCH v1 2/4] perf synthetic-events: Fix line synchronizati=
on, bounds, and truncation bugs in proc maps reader ---
commit 21e332ccbb14a1f50a59ea36a8f2a24a05ff7df8
Author: Ian Rogers <irogers@google.com>

perf synthetic-events: Fix line synchronization, bounds, and truncation bug=
s in proc maps reader

This commit addresses logic and boundary bugs in read_proc_maps_line() and =
its
caller. It ensures that mid-line parsing failures invoke io__drain_line() to
preserve synchronization and replaces truncation bugs with a standard fallb=
ack
literal.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 5307d707711d8..723b7323c06d9 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -291,6 +291,15 @@ static int perf_event__synthesize_fork(const struct =
perf_tool *tool,
>  	return 0;
>  }
> =20
> +static void io__drain_line(struct io *io)
> +{
> +	int ch;
> +
> +	do {
> +		ch =3D io__get_char(io);
> +	} while (ch >=3D 0 && ch !=3D '\n');
> +}
> +
>  static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
>  				u32 *prot, u32 *flags, __u64 *offset,
>  				u32 *maj, u32 *min,
> @@ -299,69 +308,121 @@ static bool read_proc_maps_line(struct io *io, __u=
64 *start, __u64 *end,
>  {
>  	__u64 temp;
>  	int ch;
> -	char *start_pathname =3D pathname;
> +	size_t written =3D 0;
> +	bool overflowed =3D false;
> =20
> -	if (io__get_hex(io, start) !=3D '-')
> +	if (io__get_hex(io, start) !=3D '-') {
> +		if (!io->eof)
> +			io__drain_line(io);

[Severity: High]
If a parser like io__get_hex() or io__get_char() fails because it encounter=
s a
premature newline character, does calling io__drain_line() here unintention=
ally
consume and discard the next valid map entry?

Since the newline character for the malformed line would have already been
consumed by the parser, it appears io__drain_line() might read until the end
of the subsequent line, causing it to be skipped.

> +		return false;
> +	}

[ ... ]

> @@ -487,50 +544,64 @@ int perf_event__synthesize_mmap_events(const struct=
 perf_tool *tool,

[ ... ]

> -		if ((event->mmap2.prot & PROT_EXEC) =3D=3D 0) {
> -			if (!mmap_data || (event->mmap2.prot & PROT_READ) =3D=3D 0)
> +		if ((prot & PROT_EXEC) =3D=3D 0) {
> +			if (!mmap_data || (prot & PROT_READ) =3D=3D 0) {
> +				if (truncation)
> +					break;

[Severity: Medium]
When the truncation timeout triggers on a map entry that fails the PROT_EXEC
or mmap_data filters, does this break prevent the timeout flag
(PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT) from being set and emitted?

By breaking out of the loop early here, it seems the code bypasses both the
PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT assignment and the call to
perf_tool__process_synth_event(), which might leave analysis tools unaware
that the data stream was truncated.

>  				continue;
> +			}
> =20
>  			event->header.misc |=3D PERF_RECORD_MISC_MMAP_DATA;
>  		}
> =20
> -out:
>  		if (truncation)
>  			event->header.misc |=3D PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720175455.3645=
946-1-irogers@google.com?part=3D2
