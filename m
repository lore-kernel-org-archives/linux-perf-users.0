Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731B035E1A8
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687774; cv=none; b=Q33tRK3e2TXHpbXb0wcAhw3JmlsppbWxti7y46OzpICMMrgZTyYXzo6FiuyI3fpZ7s5WjsuABoLpb2mw6aGgeJH2u7lN2yeLIpC0wxIX2Jqs4kJcq7SYhnx79bxe9XsOTKbT6oHdobKuAjor/I0Z19qc38kjKitRW9F6OVO0yvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687774; c=relaxed/simple;
	bh=bPO2cUyilnIoc22n2iGHxK+A6SGvL2n5Qk8GDNtDXuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A37p6+32ZhhGsbVbonAElB499XIpjWCxs06i/7eQIR//BnYd15i+dqCz/9UburMF93VfP1/KlcgE/Aafe5wAW+6ZAN7kU5K79gGe8cEhAMZ1GGZVf7Fu6PSBjfF2bo+wtGH4coB98ItBWakyXJJdlpbKDYx6UtFD6WhZ59gmdWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq8xD2IB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq8xD2IB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3512E1F00893;
	Fri,  5 Jun 2026 19:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780687773;
	bh=9xZJtR5QVqUE9mGxCZblAdmJ57g3gf3zRwHaxqHH8D8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tq8xD2IB86/MiUTr6t/mXXdu4CTqKI4Npo4F1TYCk7aogt2gs4Dq+JynhLVJF5eOi
	 e/gJBkDNHlaMoXdWu1/xV40wlBBII/wUIbGdixnl9Vmw9izAnPOjPiXMetiXydys39
	 phDImZeDj8XdC7u85LeKaYtMpIMtnZ/Ia8eqgY9EZFdSVXSEy1f1KXr9IykhDv2t9d
	 N+nPk6iTAvyWkdpPhw9OJEGMJYc40F7SpwtrbjeoJgqivYrxmCuGrKyo/13H5ekOAY
	 ZhvfCpSyWKkiyDQVeVwB0o6+stQpiwa+ws/4sYD7Lkm4BSnMUWDRCDpGHHNjvdRquQ
	 Iq1zXVQDHquiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 12/19] perf python: Add mmap2 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605191500.2477026-13-irogers@google.com>
References: <20260605191500.2477026-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:29:32 +0000
Message-Id: <20260605192933.3512E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Heap buffer overflow (out-of-bounds write) in pyrf_event__new.
--

commit 543923057ce17404acb2ef9bc546347f87be105e
Author: Ian Rogers <irogers@google.com>

perf python: Add mmap2 event

This commit adds support for mmap2 events as a distinct Python event type
in the perf tools, parsing the necessary major, minor, inode, and build ID
information alongside standard mmap properties.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index acd280794f66f..074dc1d9f2259 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -875,6 +1022,16 @@ static PyObject *pyrf_event__new(const union perf_e=
vent *event, struct evsel *ev
>  				 offsetof(struct perf_record_mmap, filename);
> =20
>  		pevent->event.mmap.filename[max_len - 1] =3D '\0';
> +	} else if (event->header.type =3D=3D PERF_RECORD_MMAP2) {
> +		/* Ensure '\0' string termination. */
> +		size_t max_len =3D pevent->event.header.size - offsetof(struct perf_re=
cord_mmap2, filename);
> +
> +		pevent->event.mmap2.filename[max_len - 1] =3D '\0';

[Severity: High]
Can this write out of bounds?

If a perf.data file contains an event->header.size larger than the actual
allocated size of pevent, wouldn't this calculation make max_len point past
the end of the heap allocation?

While the initial copy might limit the copy size to prevent overflowing the
buffer, this null-termination logic uses the unvalidated
pevent->event.header.size. If the header size is maliciously set to a large
value (e.g., up to 0xFFFF), could this result in writing a null byte past
the end of the structure and corrupting allocator metadata?

> +	} else if (event->header.type =3D=3D PERF_RECORD_COMM) {
> +		/* Ensure '\0' string termination. */
> +		size_t max_len =3D pevent->event.header.size - offsetof(struct perf_re=
cord_comm, comm);
> +
> +		pevent->event.comm.comm[max_len - 1] =3D '\0';

[Severity: High]
Does this have the same out-of-bounds write risk as the PERF_RECORD_MMAP2
case above?

Using the unvalidated pevent->event.header.size to calculate max_len could
similarly write past the end of the heap-allocated struct pyrf_event.

>  	}
> =20
>  	perf_sample__init(&pevent->sample, /*all=3D*/true);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605191500.2477=
026-1-irogers@google.com?part=3D12
