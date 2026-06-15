Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887226E710
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781505282; cv=none; b=E6cDkU5iuLdEQDjy6o8yPoiwVeCsuhWVRekheTkqHxxbhsJwKDmpKMShGfQHJ+2fYG29bzacnmhS/3pw1ppi8Rnqs1l4FbeYS0TxpQ0mQQoJixZumUrh3LcdDsfonXix8UiVXWzit69Sa+Y2Cz+M/BjZGp1a4ve+jGjsSN0tNu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781505282; c=relaxed/simple;
	bh=HPlqwuBsEFyNVo7yBVuQDKKkr9p6v/5IdHBbR4i5MzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f4Xcv7wuc8m3jBKEzKZafACgFAybTBJkyj0R26EzdaxR757EHFC/ZRyumkWkCxTSZzfXZx7LvqJdw3tGccvz2ReGWlKd7GPSZZLdHY7DVRuIub2zMSuSy4oxUNTCF0CFurIZOSdy3kxLllV1JCjObX5Pp0EF6GEMqTQRtSV3M34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwvbxEf6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwvbxEf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C12D1F000E9;
	Mon, 15 Jun 2026 06:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781505280;
	bh=GOMZs2vShT3j0nIIy6NmeTY2XkRrfoqztWWlrq9FAYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NwvbxEf6srBV/uZTgMkjMtJl92ukMP9qn/K93lvzSEcX+4P4imM27EfSV4mQGDs/1
	 I+GuqZc2x9NOTiWeTENCGlwWQXtsa5jys90CAz4UjEvXq0sLl/lmfBCXi7KuuHQQvq
	 vV0xl5gTvf8dnmiYxzHN9Hnd4iLcdwaIUwhM9iSYTYFRxYqam3Zeex3nvPySSClLDW
	 v8eAc0XgjsDKBLcJ4fhESF+EEF93CK+9JVfKocJNDa7nBUhNkNahlafeWq4wNsIpse
	 E5pVPP7K2AajsuWp5lhwXw/xICQAVFuS4ONEMVJDtARhkXzAprDfRHjfFNAvven5i0
	 /+iBbBMKs5apw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 12/20] perf python: Add mmap2 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615061631.2382079-13-irogers@google.com>
References: <20260615061631.2382079-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 06:34:40 +0000
Message-Id: <20260615063440.7C12D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NUL termination for `PERF_RECORD_COMM` and `PERF_RECORD_MM=
AP` events allows out-of-bounds heap reads if `event->header.size` is malic=
iously crafted.
--

commit aa149d023f31a497bc34e157fcbc350f77516ffd
Author: Ian Rogers <irogers@google.com>

perf python: Add mmap2 event

This patch adds support for mmap2 events to the perf python module. It
implements the event type, getters for its fields, and registers the new
python event object.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 3f4aff7ddc766..8da39587a39c9 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -874,6 +1019,9 @@ static PyObject *pyrf_event__new(const union perf_ev=
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
This isn't a bug introduced by this patch, but since you are explicitly
NUL-terminating the mmap2 filename here, should we also do the same for
PERF_RECORD_COMM and PERF_RECORD_MMAP?

If an attacker crafts an event with a size exactly equal to
sizeof(union perf_event), the condition:

    if (copy_size < sizeof(pevent->event))
        memset(...)

evaluates to false, bypassing the zero-padding logic. This can leave the
comm.comm and mmap.filename fields completely unterminated.

When Python's repr functions print these fields using %s:

tools/perf/util/python.c:pyrf_comm_event__repr() {
    ...
	return PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
				   pevent->event.comm.pid,
				   pevent->event.comm.tid,
				   pevent->event.comm.comm);
}

the string reader will scan past the field bounds and continue reading
out-of-bounds into adjacent heap memory.

Could we add explicit NUL-termination for the existing mmap and comm events
as well to prevent this?

>  	perf_sample__init(&pevent->sample, /*all=3D*/true);
>  	pevent->al_resolved =3D false;
>  	addr_location__init(&pevent->al);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615061631.2382=
079-1-irogers@google.com?part=3D12
