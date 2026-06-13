Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1049D290DBB
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781329486; cv=none; b=PRYW7WzaHHZtmEW8aNWtdQkOL6ZB4hry4qtIByM6o/I7pSXCkR8HFOha7Uav5CrO4YvHbJ6cs9M9T5lzrWO9e+cQFohzQylO0+azXNimpd8DkooqerJedrUljcRwKSGox/Tm+54AIVJe6mdqhXIFjH5DFIWzCH5UaZiajtOyYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781329486; c=relaxed/simple;
	bh=HGRpdapcEHPfxy8iATh2/ua2NWLr9gRYtnNldBx3mPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PsJ0y87XuwT5YmcUUE1RZ3dvdS25mrhG44kluJHurznWvHa3dgL9K8uSNb/PiFqmiaY8QShQ/A188IQTF7Bj7zdzZlmb4wj41IDt1wwMufPLKW2l16yp56IwfiyVRywUpt7rM7Y3KyyIvJhElukkqhDZVL415UW3K0b19Z4rEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC55XY/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC55XY/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A241F000E9;
	Sat, 13 Jun 2026 05:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781329484;
	bh=TUMqkR0wD0MErX9HUR2R7fVf1qbYQM9MHoYwtJJUQGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LC55XY/6iMUWgJQAolL0vtGyCbsrI6Lc2jFWfO10ZDUowiORux+FvCSVkKPv3xiUv
	 lP+2reG9NQmBVprHbEtHllzxwm+EpZjkWPHDTn0Mg6+TD3GRB7mjqvvy98j3r6kfSJ
	 I7FgfSnAGQo/y8rtd/IDsE2SPVqP57Lk3TYTHUNQRcF9Sp9TfcpVSvc8Ez/nOeu/ec
	 McGFxWcDuU4uy/djCLV4LI4nsbT01VL1X9rAfQ3WPMqEoMiLhetEGPeI+gFR2Wdhaq
	 qSCddXwY7kQrHKTMDleoh1nhte8jMdyzkWIJoC02JVc8udc4Q1VwpymTJA/nyvXgBX
	 G2kU7GnoCkOiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 11/20] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613052722.1424093-12-irogers@google.com>
References: <20260613052722.1424093-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 05:44:44 +0000
Message-Id: <20260613054444.95A241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mismatch between commit message claim of dynamic allocation and =
actual implementation.
--

commit dc847886b855295b5046ff8798be857f7ab99ae1
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event

This commit adds common evsel fields for events and refactors sample specif=
ic
fields. It also adds accessors for sample events, ensures bounds checking f=
or
offsets, and attempts to optimize memory allocation for copied events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 322ec14243af9..e4731c94debaa 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -511,33 +840,52 @@ static PyTypeObject *pyrf_event__type[] =3D {
>  	[PERF_RECORD_SWITCH_CPU_WIDE]  =3D &pyrf_context_switch_event__type,
>  };
> =20
> -static PyObject *pyrf_event__new(const union perf_event *event)
> +static PyObject *pyrf_event__new(const union perf_event *event, struct e=
vsel *evsel)
>  {

[ ... ]

> +	pevent =3D PyObject_New(struct pyrf_event, pyrf_event__type[event->head=
er.type]);
> +	if (pevent =3D=3D NULL)
> +		return PyErr_NoMemory();
> +
> +	/* Copy the event for memory safety and initialize variables. */
> +	memcpy(&pevent->event, event, copy_size);
> +	if (copy_size < sizeof(pevent->event))
> +		memset((char *)&pevent->event + copy_size, 0, sizeof(pevent->event) - =
copy_size);

[Severity: Medium]
The commit message states "Allocate just enough memory for the copied event,
don't make the maximum event size each time". Does the code implementation
actually achieve this?

Looking at pyrf_event__new(), it uses PyObject_New() with types that all ha=
ve
tp_basicsize set uniformly to sizeof(struct pyrf_event). Because struct
pyrf_event directly embeds the full union perf_event structure instead of
using a flexible array member, it appears this still unconditionally alloca=
tes
the maximum possible event size for every parsed event.

Additionally, the code explicitly zeroes out the unused portion of this
maximum size via the memset() call above. Should the commit message be
updated to match the implementation, or is a flexible array member meant to
be used here for true dynamic sizing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613052722.1424=
093-1-irogers@google.com?part=3D11
