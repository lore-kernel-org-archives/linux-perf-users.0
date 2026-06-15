Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20363BB116
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781564127; cv=none; b=gndC2yXGuNehYL8cQFCislb/ptDGebCrNdZwI/rlgC5SPs7AYEn7Ylo7O/QoWmEaSld5vc/BJiR6BlgPGnmJR8MIcxOYT1F4pfI/V9Rm9+GD7C2qyz6kvUw9ZuROxNTkPIcZTYmXhBzb3AvevX8aEfQwC0G/dgomYo24I7sZkn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781564127; c=relaxed/simple;
	bh=7TGLEpU+0LrR6xMVHchd4/WSs8BIeTwQX5jGmtD9x44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ng4yp5d0gCTWoMIcDLPHTwghdqLj4r4+iqWTPKvlzS56hQR41fZ8C8Dtbgc/dbskUBRJ2HML7+NfYn4DtbzBz/7rQ6jkfpAAv+GZl4e1zIG/chp5os0CV0zjIQFSakg73uM7AQrWdgZ5aq1UYSVa0NyPguJ/96vpq75adShjiyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAnRLWyV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAnRLWyV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82A71F00A3A;
	Mon, 15 Jun 2026 22:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781564126;
	bh=Fm1RENPQcTTjWHqpKBD6mKpXgvhtdK4yrJV7DyV+LEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fAnRLWyVVoKBYMnhpIbSeA09SlOhcuq+kjRXPu6LF84xiIoDQznenci6BuBNQkoIl
	 o6eZTrCyJT3jpMH24Dy6tXOs76RJKxobBKAGyCVSCjjj3gWM9GE0Myoiw5mI1eQMry
	 sY1M1IW5U2S/U5Z3BC9mg/9teaGcawTvRYHu3wiQiO6xZZ/sf2+NrcTJ3CC0jS611W
	 4KcmIH1HYDF/+qr4Sy2rdL3EMG2YTDgqGnUNv+nhCglJ/EcA8wDdT2KIfbc23d5gsS
	 sLIqQ95LtbPA4vds45TuHlHuXQaUOvp5AfuJtakIRYo1F6T9LUh4GaAU2yVBM90KJE
	 KV2RMigZ3UbWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 10/21] perf python: Add python session abstraction
 wrapping perf's session
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615223011.3873955-11-irogers@google.com>
References: <20260615223011.3873955-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 22:55:25 +0000
Message-Id: <20260615225525.E82A71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Disabling `needs_swap` in `pyrf_session_tool__sample` breaks parsi=
ng of 32-bit fields (like `pid`, `tid`, `cpu`) for cross-endian `perf.data`=
 files.
--

commit bcc392a3d23443fffd50461d98d652ca9e98f59b
Author: Ian Rogers <irogers@google.com>

perf python: Add python session abstraction wrapping perf's session

This commit adds a wrapper Python type for perf sessions, allowing the use
of perf.data files within Python tools. It allows a sample callback to be
passed when creating a session and includes support for retrieving thread
associations for filtering.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 31da1283fc15e..dc71fe7e37877 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -2579,6 +2587,332 @@ static int pyrf_data__setup_types(void)
>  	return PyType_Ready(&pyrf_data__type);
>  }
> =20
[ ... ]
> +static int pyrf_session_tool__sample(const struct perf_tool *tool,
> +				     union perf_event *event,
> +				     struct perf_sample *sample,
> +				     struct machine *machine __maybe_unused)
> +{
> +	struct pyrf_session *psession =3D container_of(tool, struct pyrf_sessio=
n, tool);
> +	PyObject *pyevent =3D pyrf_event__new(event);
> +	struct pyrf_event *pevent =3D (struct pyrf_event *)pyevent;
> +	PyObject *ret;
> +	bool needs_swap;
> +
> +	if (pyevent =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	needs_swap =3D sample->evsel->needs_swap;
> +
> +	memcpy(&pevent->event, event, event->header.size);
> +	/* The event is already swapped, disable swapping temporarily */
> +	sample->evsel->needs_swap =3D false;
> +	if (evsel__parse_sample(sample->evsel, &pevent->event, &pevent->sample)=
 < 0) {

[Severity: High]
Does disabling the needs_swap flag here break the parsing of 32-bit fields
like pid, tid, and cpu for cross-endian perf.data files?

When perf_session__process_events() processes a cross-endian file, it first
swaps the event payload in 64-bit chunks. The evsel__parse_sample() function
relies on the needs_swap flag to correctly undo this 64-bit swap and apply
32-bit swaps for fields like pid and tid.

By temporarily forcing sample->evsel->needs_swap =3D false before calling
evsel__parse_sample() on a copy of the event, won't the 32-bit fixup logic
be skipped?

This could cause pevent->sample.pid and pevent->sample.tid to receive
byte-swapped values, and break raw_size extraction, which might misalign
subsequent parsed fields resulting in data corruption.

Although this logic is moved to pyrf_event__new() later in the series, the
needs_swap override appears to persist. Could this be adjusted to ensure
cross-endian data is handled correctly?

> +		sample->evsel->needs_swap =3D needs_swap;
> +		Py_DECREF(pyevent);
> +		return -1;
> +	}
> +	sample->evsel->needs_swap =3D needs_swap;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615223011.3873=
955-1-irogers@google.com?part=3D10
