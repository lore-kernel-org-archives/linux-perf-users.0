Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02342BE639
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781505505; cv=none; b=ZqGhcoiRwUPAavcDo9hs9spzMgdAcZ/qY/Eln9tGEzNtDQo0LpA6oVq0BNm5iE54OqxFRfXVnJhjRm6whqdQmw7xHP3U5UJwqweQ5/8qEEU02Id8O1GAoZCnq15TbbzdIjtfYNs6z74JG7ikVmwyxN9l9qJd/wEV1EpZn9I3hVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781505505; c=relaxed/simple;
	bh=SGI/pBMZnXDMkWMZJaArSv9ep52so46eT23Vvc+gcBo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a3GHVj83AI2lBhRRsnmN2SS1yDQhY0ZA9hlhewx7rhT3OL55z12QcOD9g1YgsAeAGf5mGa29yUHpuEkjFkgOLYYg3ytr4O3mx2poh6mn3OPOPI7k+ABBHGln6sYKzBQMCQinQ+H5Z9gKemrKHk/61PRb2BHmLeJ/wHncl031ZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z87Rl5kp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z87Rl5kp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775131F00A3A;
	Mon, 15 Jun 2026 06:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781505504;
	bh=9ckaXcd6jItucB+3QnRi8Pj+iVv2lxsCtXVTTNdMgVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z87Rl5kpYA0kb6x2FJDfqsPqWOiKZpjEABD7NAdnb5GJKSvpXg04B7OQIYsb6/bbl
	 3VQM+T0c7Y0i/VDc70tO8NuQ9kIsRVYrrAmrW9gK465sJVNlw3uDfggz6eTF7SN4kq
	 7ep6fR1sz4U1iSTH4XAGK+l1dJUov2E4+CfR3TYmwQ/3U4zkBDVTnzhmcF0+EnTCFy
	 HhVHQd5b8LUzCjm8Z6j2heCf25cA5cVgkk5ptiHYKrhoOJ/NmbbBNe1Ynu9zWuXUTz
	 4Cj433mkaDPcs9o348Th1fQwVRSAvp1H838NwoI6VI6byq8zDp3tVCXAJnfxZ/xno6
	 MKpbsiLjzWEzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 11/20] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615061631.2382079-12-irogers@google.com>
References: <20260615061631.2382079-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 06:38:24 +0000
Message-Id: <20260615063824.775131F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The structural memory footprint optimization claimed by the patc=
h is technically absent.
--

commit 289f61e1dea23b3af626349fcb1e607ab8f8a6e6
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event

Add common evsel field for events and move sample specific fields to only
be present in sample events. Add accessors for sample events. Ensure
offsets are within the bounds of the event. Allocate just enough memory
for the copied event, don't make the maximum event size each time.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -511,33 +840,57 @@ static PyTypeObject *pyrf_event__type[] =3D {
>  	[PERF_RECORD_SWITCH_CPU_WIDE]  =3D &pyrf_context_switch_event__type,
>  };
> =20
> -static PyObject *pyrf_event__new(const union perf_event *event)
> +static PyObject *pyrf_event__new(const union perf_event *event, struct e=
vsel *evsel)
>  {
>  	struct pyrf_event *pevent;
[ ... ]
> +	size_t copy_size =3D event->header.size;
> +
> +	if (copy_size > sizeof(pevent->event)) {
> +		return PyErr_Format(PyExc_TypeError, "Unexpected event size: %zd < %zu=
",
> +				    sizeof(pevent->event), copy_size);
> +	}
> +
> +	pevent =3D PyObject_New(struct pyrf_event, pyrf_event__type[event->head=
er.type]);
                 ^^^^^^^^^^^^

[Severity: Medium]
The commit message claims to allocate just enough memory for the copied eve=
nt
and avoid making the maximum event size each time. Does this code actually
accomplish that?

Looking at PyObject_New() in pyrf_event__new(), it unconditionally allocates
the static maximum size defined by the type's tp_basicsize, which is
sizeof(struct pyrf_event).

Because struct pyrf_event includes union perf_event by value, wouldn't this
allocate the maximum event size every time regardless of the actual
event->header.size?

> +	if (pevent =3D=3D NULL)
> +		return PyErr_NoMemory();
> +
> +	/* Copy the event for memory safety and initialize variables. */
> +	memcpy(&pevent->event, event, copy_size);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615061631.2382=
079-1-irogers@google.com?part=3D11
