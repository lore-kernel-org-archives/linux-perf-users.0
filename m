Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA53B4E9D
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832548; cv=none; b=Rp9Mr0GVUYXS9tn77boFGgkr2T7RdBfsy277GhAI3D/WdDFHicrs7Uy9B+NSYlkBDUYoFZDmQPchAbiaco2o/4rPtLieO1PXE18RLM6ffNoAbZcrjnkw3sROOxzTehW0d9A9ZNRXmKhy58ttJptbdiMcBD+lDexMUBNTqtEqjVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832548; c=relaxed/simple;
	bh=PcvcUAdcDJ+LryHTx02YSJUOdB0VV5n02zByE7dFw34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q8cFWwjprdrd00NlIbJe1OUqT5BwVvdXvBJOKuMHsbUqrFrpP4cfAkMP20SLDxF1SeGd9U5mXnnRjN7xxVqqTmOlf5mGmaW8U4kawMEkDoeMrGu9VDSHx5WwyFUy6VKZePtiSSZNGM2itNQN4GHhXFf4alvDkgWHPN99hDr33Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVukfuzD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVukfuzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AA11F000E9;
	Tue, 26 May 2026 21:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832547;
	bh=2pLnQE7E6Eyzu3IhkGJoAyqmDZdCFO5UbNgPl5ZLEvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SVukfuzDQmdvy1JUX3ddsK3F0XBs4WZjMkoMEDc8TolNrX29U5BNJiB6k7emJHl/D
	 ngI24wYU4DWbtqEiUtY2XlZagebokAtNJuM1I335XUqUF2csfg8lWVtsqtIViKBgqa
	 29EGF5Pl7BCHCaX1Mg81OZEFIPcxGHwV43/IuiEiruxqjtz0jIwrs8F0HAFvMlW6zq
	 CkypdnGtFUNXTY1LemfJK4rtLSaKKm4GZHD2BpFrBKRN0wCLqUj4oUY82lkkLQGKT4
	 44hyitK9hH6buYEHWmVZNWdl7ePGhtQkJtrkycV+xrLc0hf+s+DInhMTLY68K+nc//
	 9u34dwIZjVpRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/29] perf session: Add validated swap infrastructure
 with null-termination checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526211806.1193848-9-acme@kernel.org>
References: <20260526211806.1193848-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 21:55:46 +0000
Message-Id: <20260526215546.C3AA11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `prot` and `flags` fields in `PERF_RECORD_MMAP2` are completel=
y ignored during endianness swap.
- [High] The `perf_event__event_update_swap` function fails to byte-swap th=
e variable union fields of `PERF_RECORD_EVENT_UPDATE`.
--

commit bc0a5c7da863b9ea5a7bf13cf8099e8bd03a1abc
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Add validated swap infrastructure with null-termination checks

This commit changes swap callbacks to return an int instead of void to allow
error propagation. It also adds a string null-termination check and includes
several security hardenings for cross-endian swap handlers.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 37544a3574185..d5864e380c1bd 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> -static void perf_event__mmap2_swap(union perf_event *event,
> +static int perf_event__mmap2_swap(union perf_event *event,
>  				  bool sample_id_all)
>  {
>  	event->mmap2.pid   =3D bswap_32(event->mmap2.pid);

[Severity: High]
This is a pre-existing issue, but I noticed the prot and flags fields of
PERF_RECORD_MMAP2 are skipped during the endianness swap.=20

When processing cross-endian perf.data files, these 32-bit values will be=20
interpreted with the wrong endianness. Could this result in garbage values=
=20
when the flags field is read directly during processing (such as in=20
machine__process_mmap2_event to check for MAP_SHARED), leading to incorrect=
=20
memory permissions or misattribution of samples in memory maps?

[ ... ]
> -static void perf_event__event_update_swap(union perf_event *event,
> -					  bool sample_id_all __maybe_unused)
> +static int perf_event__event_update_swap(union perf_event *event,
> +					 bool sample_id_all __maybe_unused)
>  {
>  	event->event_update.type =3D bswap_64(event->event_update.type);
>  	event->event_update.id   =3D bswap_64(event->event_update.id);
> +	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but it looks like the variable union fields
in struct perf_record_event_update are never byte-swapped.

The struct contains a union payload (like cpus, scale, or name) based on
event->event_update.type. For cross-endian captures, multi-byte fields
inside the union remain unswapped. Could this lead to data corruption in
downstream stats processing, or potential memory exhaustion and
out-of-bounds reads when allocating CPU maps using unswapped nr values in
cpu_map__new_data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526211806.1193=
848-1-acme@kernel.org?part=3D8
