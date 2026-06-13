Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355331E505
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781335772; cv=none; b=ZtWbrxjJVtCQef5tAN7muZwhBnw3AG2L3V1tiYLuJmLskKYs5CONl8XNSlvijpITTXvkBHKz7tFMTLB7hhgOm0VsMjh495vUxfxl/0nTVNmQV0IbHwrnjqjtFg+EJZr7ls/IGzhYv4I6Rot8+egUAX7zAQgdJjZWKouAXHUoJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781335772; c=relaxed/simple;
	bh=VK0EhFabC1SdcxsyKE7ObRdSfblWZ5hpydl15T8BVdY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q6shcy7fu0YcjOnj0uPkVG5+Y7PcSOdQ+tlWM5Gb0G1Nx39+G6D8NbTWp1mmvWCWDG4xWp3fdI7uRj8pIurfnTWH32AuqVjCgwer1l8QKE98RODQkhXUE660vGDoXN5legVopOF+S6O0vv6ncdQ/esCE1U2mPIylZ3pVj/PhzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqKoHvex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqKoHvex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD811F000E9;
	Sat, 13 Jun 2026 07:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781335771;
	bh=yiI3GXA66QwgTzT6uT56IoJb/lkgbex5q6f/+KOL9zs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dqKoHvex41f7OsCoRSVFc88U6mLpdV4My5LRR2dWVtuO4hhBqrGcbgYl6rdTYqf1c
	 SC5ZXeJ8f2GPv2hBTvuM+rU5v9nfW/DGY9tRHtqNxhB5QkPIl0fh636LHj2xjEwF2s
	 kAImonIWRUXDnWmLravh3vJZYRa9NnsBaYEyIyKpP/ALJ9cRlYgPvRgV/XdZtkjZQZ
	 jiLkJglhK6KjGqlpLZNMyzMrZKtx034sAN/j2+J5DxTuSYTaK8S3X6LnqPBTneVJi+
	 9Tbfurqz/NRjcs4LYH/spgkh2n/VTgsdFOwX6J+X/bwrK3d1SEHw98mnmAFtn4yZf5
	 1pNXpNWOkEgkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 10/20] perf python: Add python session abstraction
 wrapping perf's session
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613071100.1508192-11-irogers@google.com>
References: <20260613071100.1508192-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 07:29:30 +0000
Message-Id: <20260613072930.EFD811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Double byte-swapping of event payload in cross-endian analysis cor=
rupts sample data.
--

commit ab08decf391da11c08821b089b0280540ef65499
Author: Ian Rogers <irogers@google.com>

perf python: Add python session abstraction wrapping perf's session

This patch adds a Python wrapper for perf sessions, allowing tools to proce=
ss
perf.data files directly from Python scripts. It provides callbacks for sam=
ple
events and adds functionality to query threads and comm strings.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
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
> +
> +	if (pyevent =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	memcpy(&pevent->event, event, event->header.size);
> +	if (evsel__parse_sample(sample->evsel, &pevent->event, &pevent->sample)=
 < 0) {

[Severity: High]
When processing a perf.data file collected on a machine with a different
endianness, will this result in double byte-swapping the event payload?

The perf_session__deliver_event() function already calls evsel__parse_sampl=
e()
before delivering the event to the tool callback. For cross-endian files
where evsel->needs_swap is true, this performs an in-place byte-swap on the
event payload.

By copying the already-swapped event and passing it into evsel__parse_sampl=
e()
a second time here, the in-place swap will run again. Does this revert
native-endian fields back to the foreign endianness, exposing corrupted data
to the python scripts?

Could we avoid this second parse or rely on the already parsed sample
provided in the arguments?

> +		Py_DECREF(pyevent);
> +		return -1;
> +	}
> +
> +	ret =3D PyObject_CallFunction(psession->sample, "O", pyevent);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613071100.1508=
192-1-irogers@google.com?part=3D10
