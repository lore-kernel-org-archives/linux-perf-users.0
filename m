Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AB5545D93
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923296; cv=none; b=UmmOwZaFrv3FQ4pSjJX7KQzPl0uRutxtF4sAeChD/PecDxcxdqeifiKUu/i+yv197W2U7B/DlDTK3gkPYmnKj5QGjqiqxJB4H9fac7+LzBTfqtD5BBHoXrxanmnhpdpmNWe5LH5SGEN26IVQTLrecLI80xL1U3GTIp87fT5Zeu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923296; c=relaxed/simple;
	bh=3f/f4sYmnVzwWvI+x/qNY5CLacTo2ilt6BkyZwpoz/w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rQQkzjJUcAdRhQulkw/SxUjlCgzrqYYY42aS8KdJYBLBO5onzc9eAMYTDsSNwj0ebtQZ519dykz9TckUjV/R5ax8w6UNZ9zFDorv6VNuqK6YxrlEOGwIlvRKpl2h54CRq+cCUFr7lV5oQVx05n5OpcJV5noxuI8mDu/6bZbx9ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXbig3hl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXbig3hl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1641F000FF;
	Tue, 13 Oct 2026 20:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791923294;
	bh=ooW3aMQS+jrKjz/51IjhQRqjZ9bgXIa98Nk6sAJJFj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jXbig3hlo5kVf/z2MCNZijPgCSw3o3Knu1DD85a98JOj17gSC9za0OtclHG6/KyTF
	 3LTuU6P33/PlUoO3X0IZTDAk3Mt84a+ykwQwUPIsuCzp9xhIMGKbAbgZBgXkmIFU9w
	 SN6G1Kww6pj7Ick+ZLGemb/xZ7LYolfrOp0ExepOvKyqnf2yqgVppHFWcrgWyt+QFU
	 N4YdIRsqIV7VoFtkuBj/KL4R2TIJW0QYppz3yjlRLHppqZkW+AmtgAyK4mLLJgiowV
	 gjcFzhGXO8bZMo6QneIxQZP/XxuDsNIXRrgLqpej9KiET35tXaPDVJQBB4xTnfzpI+
	 CS+M6XEV8DQuQ==
Message-ID: <sashiko-outbox-170463@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/19] perf test attr: Allow tests to require a core
 PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-3-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:28:14 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf python: memory leak of parse_events_error in pyrf__parse_ev=
ents()
--

commit f47ff7c9fc4b5bf17c150eab6410f6c98f01cb7c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf test attr: Allow tests to require a core PMU

On machines without a usable core PMU, like an aarch64 box with no DT
node for the ARM PMU, the expectations that pin the legacy hardware
encoding can't be checked: without a core PMU at all 'cycles' doesn't
even resolve, and with one that can't be opened 'perf record' takes the
software fallback and records attributes they can never match.

> diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/=
lib/attr.py
> index 68f06df9565a0..b55c9b881e598 100644
> --- a/tools/perf/tests/shell/lib/attr.py
> +++ b/tools/perf/tests/shell/lib/attr.py

[ ... ]

> @@ -28,6 +29,34 @@ def data_equal(a, b):
> =20
>      return False
> =20
> +def core_pmu_available():
> +    """
> +    Is there a core PMU on this machine? Without one hardware events are=
n't
> +    supported and get replaced by the software fallback, so there's no w=
ay to
> +    check the expectations that pin their legacy encodings.
> +    """
> +    try:
> +        import perf
> +        parse_events =3D perf.parse_events
> +    except (ImportError, AttributeError):
> +        # Nothing to ask about it, let the expectations speak.
> +        return True
> +
> +    try:
> +        evlist =3D parse_events('cycles')
> +    except OSError:
> +        # No PMU that can count it, the same as the ENOENT below.
> +        return False
> +

[Severity: Medium]
Does this expected failure trigger a memory leak of the parse_events_error
structure in the underlying C extension?

When parse_events() fails or generates warnings, it dynamically allocates
memory for error strings. However, looking at the python bindings in
tools/perf/util/python.c:

tools/perf/util/python.c:pyrf__parse_events() {
	...
	parse_events_error__init(&err);
	perf_evlist__set_maps(evlist__core(evlist), cpus, threads);
	if (parse_events(evlist, input, &err)) {
		parse_events_error__print(&err, input);
		PyErr_SetFromErrno(PyExc_OSError);
		evlist__put(evlist);
		return NULL;
	}
	result =3D pyrf_evlist__from_evlist(evlist);
	evlist__put(evlist);
	return result;
}

The err structure is dynamically populated but parse_events_error__exit(&er=
r)
is never called on either the success or error paths, leaking memory whenev=
er
errors or warnings are generated.

Could pyrf__parse_events() be updated to clean up the error structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D2
