Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A731199931
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 04:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779595715; cv=none; b=JNu7swJ4/Ui62YIctrnoFAq1zbYT4HERjCdKgHobpZIZhAukAecoWddypdRWWj8bsRgRZSvnnw6hJXfxBeb39iB8BPf18uq4jul6O0Z0ZkZNlYLA7tTYbRNR5ad/gr66zg5juuMhgAvb1NuDT1/J3HanJEuFOklvzqSxO/q17yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779595715; c=relaxed/simple;
	bh=QA9HfFHlTSVTPt934TM3cLkIzyM6CMbNn4QZcBFXFWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qb8zoQNImE65W/hMnLzu+lVKuWKJprWH1M2kbgNxodRiI4L8uG0YcwzfQud4Zmf6fxmUv7LcWBv/9aziVrPLJ93qjdTMhYxIETxgu04CZVjO2xSg72sa2pMzZX+KIM6jqru1ix+BSRe31Pl7Jyhf/6LtMm9hmYY4KAZ0uomh1mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQEDOne2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQEDOne2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8971F000E9;
	Sun, 24 May 2026 04:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779595713;
	bh=K7t9bcp+nvH5dywkAZrxTf+9vokiLFElaaZTK/wfWFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HQEDOne2WwuONN/ggq8M60/YdgiMFPPq3sH9bgVZxUiDFntMCWuH6XHXnj3ImfFWB
	 7oqwHkMuzqF8e4VyJPiMI+saAHaF0gC2h0GpF+ox50expMfJjAmxwXIy4XbUkw0ufc
	 s8xjU22bfUr9JkyL+7v4aKymmTxskuojPr4sSUQOS8KfLRpdkIUMLa5skJ/8BkRN5t
	 5IcTvAzBYQ3crmm5z8N1ehFlRF0oke6gehGgo4S7l5VTGMznYfMGQgg7+ztK+9ikk8
	 uPVJQ3C360CHiSqNkHGCusDp3D4sOnjiXIGyik2q4s+BXgGnGjxIedt4QbyDtTjYQO
	 UbNo/4zz+QriA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/29] perf session: Validate HEADER_ATTR attr.size
 before swapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524032709.1080771-11-acme@kernel.org>
References: <20260524032709.1080771-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 04:08:32 +0000
Message-Id: <20260524040833.9B8971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Double-fetch of `event->header.size` from a shared memory mapping =
allows an attacker to bypass bounds validation and trigger an out-of-bounds=
 read.

Pre-existing issues:
- [High] The patch fails to apply the ABI0 (attr.size =3D 0) fix to `perf_e=
vent__repipe_attr()` in `tools/perf/builtin-inject.c`, causing `perf inject=
` to synthesize corrupted events.
--

commit 3c40045df7139a78501fe156fe285fc86c33951e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Validate HEADER_ATTR attr.size before swapping

This commit hardens PERF_RECORD_HEADER_ATTR handling against crafted perf.d=
ata
by validating attr.size. It copies only bounded sizes into a local attr and
handles ABI0 pipe/inject events where attr.size is 0.

>     Handle ABI0 pipe/inject events where attr.size is 0: use a local
>     attr_size variable set to PERF_ATTR_SIZE_VER0 for both the bounded
>     copy and ID array position, instead of writing back to the event.

[Severity: High]
This is a pre-existing issue, but does the patch miss applying the ABI0 fix
to perf_event__repipe_attr() in tools/perf/builtin-inject.c?

In tools/perf/builtin-inject.c, perf_event__repipe_attr() still directly
reads event->attr.attr.size. For native-endian ABI0 events, this size remai=
ns
0, causing memcpy to copy 0 bytes (zeroing the local attr) and n_ids to be
heavily overcalculated.

perf_record_header_attr_id(event) then incorrectly points the ID array to
the start of the attribute payload. This causes perf inject to synthesize
a corrupted event, breaking functionality for legacy perf.data files.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f30e48eb3fc32..967c3d8ff12c8 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -5094,11 +5110,42 @@ int perf_event__process_attr(const struct perf_to=
ol *tool __maybe_unused,
[ ... ]
> +	raw_attr_size =3D event->attr.attr.size;
> +	if (event->header.size < sizeof(event->header) + PERF_ATTR_SIZE_VER0 ||
> +	    (raw_attr_size && (raw_attr_size < PERF_ATTR_SIZE_VER0 ||
> +			      raw_attr_size % sizeof(u64) ||
> +			      raw_attr_size > event->header.size - sizeof(event->header)))) {
> +		pr_err("PERF_RECORD_HEADER_ATTR: invalid attr.size %u (event size %u, =
min %d)\n",
> +		       raw_attr_size, event->header.size, PERF_ATTR_SIZE_VER0);
> +		return -EINVAL;
> +	}
[ ... ]
> -	n_ids =3D event->header.size - sizeof(event->header) - event->attr.attr=
.size;
> +	n_ids =3D event->header.size - sizeof(event->header) - attr_size;

[Severity: High]
Does this code introduce a double-fetch of event->header.size from a shared
memory mapping?

For native-endian files mapped via MAP_SHARED, could a concurrent change
provide a valid event->header.size to pass the bounds check in the if
condition, and then overwrite it with a large value before it is fetched
again for the n_ids calculation?

This might inflate n_ids, causing the subsequent ID array loop to perform
out-of-bounds reads past the event, which could lead to a segmentation fault
or leak adjacent memory contents. Could we cache event->header.size to
prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524032709.1080=
771-1-acme@kernel.org?part=3D10
