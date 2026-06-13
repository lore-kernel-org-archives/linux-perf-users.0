Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1E2EA731
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781329683; cv=none; b=WKEAD7KCpVgdLI73ICVGXUf10ERbS1gtmXzIha4/4La5bd5YtG12robm2zwdMARr0U4ke7sXmDuz2PcEjxMrLQ98F4Q/IRvvVmuzUISbV3q/wwRDqqpffyWK8MDAHwPcHowRnE9NLLeh2a6o9LNeF+TZnv6cyB7KNKk1njIF7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781329683; c=relaxed/simple;
	bh=c5sFqXdpXxbSFkxY3pvSnUwqhc35TdGSvNbQhG6Hkn8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=erObcYo4iLiOKcYHbpofOpsbM6ZtQasdWtjoQCSS50CYhlsE7suSs+AQgZARRWEJyGJlHIycRQ4HQ1GhW7fDG3ykdzzpzZ8D0qv+oVUZ+/Q8wRhVntJuZAjx6fyLhwTSYOVIxfSc/3ekv+ZS66+aBh12aewYgCis2TNZZkBSeVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2QdTXgv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2QdTXgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11761F000E9;
	Sat, 13 Jun 2026 05:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781329681;
	bh=JYNo49msyunQSIZkdWQqATv2urHCpeK1v2B4D1Mto6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T2QdTXgvqjo24h4HJKjX2mIfJYgsAuw3jnrxd0DT1/TDH/Yxz0TMTaE1o5Uhqoxbu
	 RUka9bs9HkDfBVvAF2zYKEjuM2L1jRN99Belkgn6UFQdxXVGDwIo6y12609u+lEeS5
	 t1Y1hjJQ22pdVJDsmc50/Gfpo1pPK/tFSE/CKiB3+2pfODhoRGO9Vpx4HTyJv2hR5O
	 erQ2kuaWo299ArD8GWo8mc7IujruTjONTo5Vm+IloHRrD0DF4usDurkLapAsWnIc6l
	 zC/d+AieFc+09PfxONC1bRMG8qr1W6hv7U+iJRa3NWlolX88+eSr+FHVmX364SK47o
	 IRyXSghYZG7yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 12/20] perf python: Add mmap2 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613052722.1424093-13-irogers@google.com>
References: <20260613052722.1424093-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 05:48:01 +0000
Message-Id: <20260613054801.A11761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing explicit NUL-termination for `PERF_RECORD_COMM` and `PERF_=
RECORD_MMAP` events allows an out-of-bounds heap read on malformed `perf.da=
ta` streams.
--

commit 424aa9d550ab571f0deb9bd53989e4b478af2b15
Author: Ian Rogers <irogers@google.com>

perf python: Add mmap2 event

This commit adds support for mmap2 events as a distinct python event type
in the perf python bindings. It extends the existing python module to parse
and expose mmap2 specific fields like inode, major, minor, and build ID.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index e4731c94debaa..b3dca4b638441 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -873,6 +1020,9 @@ static PyObject *pyrf_event__new(const union perf_ev=
ent *event, struct evsel *ev
>  	if (copy_size < sizeof(pevent->event))
>  		memset((char *)&pevent->event + copy_size, 0, sizeof(pevent->event) - =
copy_size);
> =20
> +	if (event->header.type =3D=3D PERF_RECORD_MMAP2)
> +		pevent->event.mmap2.filename[sizeof(pevent->event.mmap2.filename) - 1]=
 =3D '\0';
> +

[Severity: High]
This is a pre-existing issue, but while you are explicitly NUL-terminating
the new PERF_RECORD_MMAP2 filename, should we also add explicit
NUL-termination for PERF_RECORD_COMM and PERF_RECORD_MMAP events here?

If a malformed perf.data stream has event->header.size exactly equal to
sizeof(union perf_event), the memset() used to zero-fill the remainder of t=
he
struct is bypassed. If the source data lacks NULs, comm.comm and mmap.filen=
ame
will remain unterminated.

When Python accesses these fields via the T_STRING_INPLACE parser or C-stri=
ng
formatting in pyrf_comm_event__repr() and pyrf_mmap_event__repr(), strlen()
can read past the array boundary into adjacent heap memory, for example:

pyrf_comm_event__repr() {
	return PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
				   pevent->event.comm.pid,
				   pevent->event.comm.tid,
				   pevent->event.comm.comm);
}

Does it make sense to protect the existing string fields from out-of-bounds
reads in the same way mmap2 is protected?

>  	perf_sample__init(&pevent->sample, /*all=3D*/true);
>  	pevent->al_resolved =3D false;
>  	addr_location__init(&pevent->al);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613052722.1424=
093-1-irogers@google.com?part=3D12
