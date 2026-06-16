Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4DA37BE7A
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574740; cv=none; b=SJYxiL8zREmV0Xr/9iEhfl8jvod9+sU6eFFBLnbpktg8lXlhMdHF7fVzTq3R5jqYT11qE7qLoKvdpK4L49JucfHAL14ZNfiYWKuI2s0gmaPIFhCB63DYgrI8nZUhSdk/emAcZoH537inMtvf6fVPKSmlmNsKXKKz2losWRwMqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574740; c=relaxed/simple;
	bh=l12lfRduoFj2VaX1l+MHlrX0Ziot0q2efvGrw7lta7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jbL/DeSUwvcKYr3rO3rRaJUGLPJErrZ75kxX0ovfi5gygcIWmNEPFDeMv7Bz/aQSZZjXAdFjLT2kjCEirEQBmCbn0sxxQZNo3uDnOhmdOgj+jCgz4yxTT9xaaI06wRgjBFHrJ97Rllve+hhoMLGq67j6vgD4kH6ZTDNjHRcRbIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrR9s928; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrR9s928"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7FF1F00A3A;
	Tue, 16 Jun 2026 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574739;
	bh=O7syKtFx20QGvkiwEQpvg/W7UghL9h5rmVo1UhOxKLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QrR9s928oPqk8BhnoOhaMFibWGP/HfadNPsoFYjBeNgGk7ouQRfOiSuSEd7EwLwtf
	 KM9DcPpPU5Mj/lE0mKmJL5UEg0n76LPyT9Uz92vN2UzeWVpualbq3dbbcTYiIjqYa8
	 BDX5QD/ZjMOjihXoa/VFhQGbMAUj+NqE44VGKEeXmiOtzZOvG20RPEMm88JzG+t35u
	 I0piiowy2UzHYLgvKyIGZBvEHqsf5RyKoDSm8W+RdOfkBp6Tzr0QF7vBYnQf1hO9Xj
	 tHLTjjTlsGwaXSs4I+SJQJok6MTlqGONLV6fXo0Q34p3QDaR1dIc68nR9cZf5wq0uC
	 YDupjaWWerjXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 11/21] perf python: Refactor and add accessors to
 sample event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616011543.4037138-12-irogers@google.com>
References: <20260616011543.4037138-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:52:19 +0000
Message-Id: <20260616015219.9B7FF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The code fails to realize the commit message's claim to 'Allocat=
e just enough memory for the copied event, don't make the maximum event siz=
e each time'.
--

commit 72cd19fc97123aafbff114427cd0ae63ceaea3bd
Author: Ian Rogers <irogers@google.com>

perf python: Refactor and add accessors to sample event

This commit refactors event sample specific fields to only be present
in sample events and adds accessors for them. It also ensures offsets
are bounds checked and attempts to optimize the memory allocated for
the copied event.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index dc71fe7e37877..72d297156ad05 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -842,33 +842,57 @@ static PyObject *pyrf_event__new(const union perf_e=
vent *event, struct evsel *ev
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
don't make the maximum event size each time." Does this PyObject_New call
actually reduce the allocation size?

Since PyObject_New relies on the statically defined tp_basicsize of the Pyt=
hon
type (which is sizeof(struct pyrf_event)), and struct pyrf_event embeds
union perf_event by value, the struct size remains constant. This means the
allocation always reserves the maximum event size regardless of copy_size.

Is there a missing dynamic variable-sized allocation step, or should the
commit message be updated to reflect that only the initialization footprint
was modified?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616011543.4037=
138-1-irogers@google.com?part=3D11
