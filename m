Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7704F27B35F
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 03:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779678083; cv=none; b=ufakK1d2N7iFCHFahrcHJSNmgebl6V5JClJPDFnxwMrVvBpgW8qYSqARms6VT+mlOTJCiob0mmgnUahfEadk+oooTN4/aUN9CVaZAQ+G7DG+2vIdhz1O1XCd9eyUoA9+uOHoBad8E6x55hhHm5bEtp9BTIANfAtubjmqC0V9wAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779678083; c=relaxed/simple;
	bh=2Tzli9vxMnNyLYX7VcYESewoHZ3/QVuycV8Q0tLFoZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TAJdPPU6aaFa+vl0brs7TvcrfvikGrXxeB/Bc3XMPOKlLvPXyVuWT8Q1d7LvL+JJI2TDOVs3OmZU5x3AYZGd6Xa+4LY7WvrGWTEqyuI6fLAOFdcBitHIjH2B89ubLirRZaKKAOkYUjwZzEfHJTNYOwbNFTcyHQ+8yZcaJq/jKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNjnK68j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNjnK68j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EDB1F000E9;
	Mon, 25 May 2026 03:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779678082;
	bh=aECRJc3xB1kJlGTJFX5OJ5sbT4ftMONXwF1wU85j+bk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lNjnK68jKI3QgPuOJYU2AHJ34cUMMgUnAPs3fvlIzB5GgDv3GCGq9MdPb52Gzdkxz
	 Ol1GbBLwhYkha6VE9iVcCmBUGiQ9RqSrAV51nzL91mTYO0hTXkqm8yQ+P6qhDh3VAO
	 slP20YLEQxOh1jDfftPqru3gJB63Z1MdMiIuqUyD2B3gZo/VqHsCTBywsdbhNYHnJY
	 Vl5YFrTSrOyQrf9KO+qWTRtEDyap28PYPQDxU0CLzckv+Gz06skSzjCN5z3Nk4Um5W
	 zRlBFPnNOoa26NpTLHGIUCTwPLLKRbsNcG6ynxGcc6aQ34fPHOnpQ6dSUw5SeVnRB+
	 voC2Fmy9mQZ9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/29] perf header: Propagate feature section processing
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525010550.1100375-19-acme@kernel.org>
References: <20260525010550.1100375-19-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 03:01:11 +0000
Message-Id: <20260525030121.E3EDB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Skipping tracepoint event preparation for truncated files causes=
 tools to parse trace data using the local system's tracefs format instead =
of the recorded format.
--

commit 6b472d4fefea1e2e6c372f8fb473b94680a6af08
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Propagate feature section processing errors

This commit updates perf_session__read_header() to propagate errors from
feature section processors, ensuring invalid perf.data files are rejected
rather than partially initialized. It also modifies the behavior for
truncated files to skip feature section processing and clear the feature
bitmap.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -4997,15 +5001,36 @@ int perf_session__read_header(struct perf_session=
 *session)
>  		lseek(fd, tmp, SEEK_SET);
>  	}
> =20
> +	/*
> +	 * Skip feature section processing for truncated files
> +	 * (data.size =3D=3D 0 means recording was interrupted).  The
> +	 * section table is unreliable in that case, and the event
> +	 * data can still be processed without the feature headers.
> +	 * Clear the bitmap so has_feat() returns false and tools
> +	 * use their "feature not present" fallbacks instead of
> +	 * accessing uninitialized env fields.
> +	 */
> +	if (f_header.data.size =3D=3D 0) {
> +		bitmap_zero(header->adds_features, HEADER_FEAT_BITS);
> +	} else {
>  #ifdef HAVE_LIBTRACEEVENT
> -	perf_header__process_sections(header, fd, &session->tevent,
> -				      perf_file_section__process);
> +		err =3D perf_header__process_sections(header, fd, &session->tevent,
> +						    perf_file_section__process);
> +		if (err < 0)
> +			goto out_delete_evlist;
> =20
> -	if (evlist__prepare_tracepoint_events(session->evlist, session->tevent.=
pevent))
> -		goto out_delete_evlist;
> +		if (evlist__prepare_tracepoint_events(session->evlist,
> +						      session->tevent.pevent)) {
> +			err =3D -ENOMEM;
> +			goto out_delete_evlist;
> +		}
>  #else

[Severity: Medium]
When f_header.data.size =3D=3D 0, the new logic skips calling
evlist__prepare_tracepoint_events(). Does this cause tools to parse trace
data using the local system's tracefs format instead of the recorded format?

If evlist__prepare_tracepoint_events() is bypassed, any tracepoint events
present in the file will lack their tp_format initialization. Later, when
processing these samples, evsel__tp_format() will find tp_format =3D=3D NULL
and fall back to reading the format from the local host's
/sys/kernel/tracing/events.

This could lead to out-of-bounds reads or garbage data extraction if the
binary payload from the perf.data file is interpreted using a local tracepo=
int
format that belongs to a different kernel version or architecture. Before t=
his
change, evlist__prepare_tracepoint_events() was called unconditionally.

> -	perf_header__process_sections(header, fd, NULL, perf_file_section__proc=
ess);
> +		err =3D perf_header__process_sections(header, fd, NULL,
> +						    perf_file_section__process);
> +		if (err < 0)
> +			goto out_delete_evlist;
>  #endif
> +	}
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525010550.1100=
375-1-acme@kernel.org?part=3D18
