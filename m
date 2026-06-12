Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449034405B
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289341; cv=none; b=c1DZ+jDyp42a/TAHS0SInHUPa5WJtkWdtfgalFTV5e+pyqeHmcFbFida2qg7c+FjJBoCPV8v788HS2g1Ug+phziozhJtuaV4ADypCXrtv0yKy0q+p4xGTdkhib4P+RcKqqJ9xl/iJwSLaYpOi+ETf+NbXpls3BNVeT64p6NGpvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289341; c=relaxed/simple;
	bh=fXg49C/sPC1J40k1GUrAyh7KGq4HDUj2jaQTpdGJ/j8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gwGQVetOjyjnQXMVZCRAqCnRtEsRaep5x26TxsYivRkjzU7Gj/8RJW5BHoMZIIFzegw5lIbelKWETV1xLzvZPmsCg/TjI55VikymknPkdyyzt6akJmF1hlzSVt7k+8V8tUQQQi0GNuAkp8qUtVdVrPDSbVZFc7GacWSZXwE8hVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMPLW7UP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMPLW7UP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8643B1F000E9;
	Fri, 12 Jun 2026 18:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781289339;
	bh=E9M6pAPfjS0heNsbUtEqWj7PUYluKlpHTfyD5SH7wkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AMPLW7UPdTMMW+H5oDP7WzNeoQoLJ+1+v2VA9dGs3iNZOFFWCJwSm0Edb/BC5jVOX
	 35DbzTppw1s45PAmBpzKgfqZp8YefNuFufdCktenIlUKHPtLCRV7S2KfRuyeRegZp+
	 0I+mKn9JXjHquLxvaoCrNpWtVqp0fkS5ZOIzJKkBn94UsfUruvDiivjQ1b/SrwpBE/
	 uu4mGIJ/IzN31EzwZ6dMLvmGnRl/FHH4Z4d9B+YYcJJsW5J1ux24zHPrAOGWN1mzVu
	 S9PC9YaYvZ/b9carBJOvpT0WuVZ1JB6uaaYwYEtfhaLZzNOYaP0qtJcvt0eEF/ZiJe
	 6uo22SN1wusQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 11/19] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612180956.1105352-12-irogers@google.com>
References: <20260612180956.1105352-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:35:39 +0000
Message-Id: <20260612183539.8643B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Data corruption when forcibly null-terminating MMAP, MMAP2, and CO=
MM events.
--

commit 997b9e752ea78b14ab40dbb997753ef37ba7cc71
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event

This commit adds a common evsel field for events and moves sample specific
fields to only be present in sample events. It adds accessors for sample
events, ensures offsets are within the bounds of the event, and allocates
just enough memory for the copied event.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 66b2effd4a955..87aaa687a8d50 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -511,33 +840,63 @@ static PyTypeObject *pyrf_event__type[] =3D {
[ ... ]
> +	size_t copy_size =3D event->header.size;
> +
> +	pevent =3D PyObject_New(struct pyrf_event, pyrf_event__type[event->head=
er.type]);
> +	if (pevent =3D=3D NULL)
> +		return PyErr_NoMemory();
> +
> +	if (copy_size > sizeof(pevent->event))
> +		copy_size =3D sizeof(pevent->event);
> +
> +	/* Copy the event for memory safety and initilaize variables. */
> +	memcpy(&pevent->event, event, copy_size);
> +	pevent->event.header.size =3D copy_size;
> +
> +	if (event->header.type =3D=3D PERF_RECORD_MMAP) {
> +		/* Ensure '\0' string termination. */
> +		size_t max_len =3D copy_size -
> +				 offsetof(struct perf_record_mmap, filename);
> +
> +		pevent->event.mmap.filename[max_len - 1] =3D '\0';
> +	} else if (event->header.type =3D=3D PERF_RECORD_COMM) {
> +		/* Ensure '\0' string termination. */
> +		size_t max_len =3D copy_size -
> +				 offsetof(struct perf_record_comm, comm);
> +
> +		pevent->event.comm.comm[max_len - 1] =3D '\0';
>  	}

[Severity: High]
If sample_id_all is enabled, the kernel appends a sample_id trailer (like C=
PU,
TID, or timestamps) at the end of non-sample events such as PERF_RECORD_MMAP
and PERF_RECORD_COMM.

Since copy_size is derived from event->header.size, doesn't max_len include
the trailer length as well?

Could writing a null byte at max_len - 1 overwrite the final byte of the
sample_id trailer data, silently corrupting it before it gets parsed by
evsel__parse_sample()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612180956.1105=
352-1-irogers@google.com?part=3D11
