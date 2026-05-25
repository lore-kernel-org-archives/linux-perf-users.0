Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9162343890
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779674088; cv=none; b=N3dIzYxcnrQOLCM0dOYP/72VCj5KyvAbWgO3D7iR0v0Z4Dpana7e+4OXVat/ohsLbpZupcW0tOw7mJIEa3PUpYJ/H44miQ9CjqxR81mpww7zYU/TS63ah9HF3fY/xDSqL1zBH8UPzjR3s5f3fhb4JlpnlgG/gLC/ucn80/DAHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779674088; c=relaxed/simple;
	bh=g9PeDVl02lcQlFp3ZUdkkTT++wmw6GqlPorS0neEOxw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o5AmjirzHNkZq7IiFjl5fBOXN0Zxsrt/3Znx1Kxqp5WS5Di/0Ewh8vRg/nUzJf5BbJTcHI2OwkpIUrO8B2ioKpsMqZr4PBrHKzhWaokLSaskeRFV77GUjbua7b1nuorGHOtgP1NczTiiIuaByBEQQ1huZKs1j2qt1gWmW7L4NNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBEtpsDS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBEtpsDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763731F000E9;
	Mon, 25 May 2026 01:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779674086;
	bh=gFpQtCq0E49Sk7QSRxi63DnQkRftqIe5e9aIJPy5hhs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bBEtpsDSArV/2hxKzFhpzfuKtOGYXlmk2Bevsje8MXWy+HpCT5YcWz6gbLHvdEM3h
	 1ElPa3fL/Z9vgic+T21m/eWYO45GxAGQip2od3FWaSop39JtGknAkMyQ68ptToDoc6
	 dn4fF5I/03Kj+5lvtbClck9KXv8C+cBKqaITejOrJTaeqD/pmtklwCtDPiCZ9d2QnY
	 gBvlljpLxlTst+ZTZxTsZp4Xm5SnFs55rCCzRuQfJYPIfHlKCT9gNYhDSL8kYbxf5J
	 Wki0LDkfl2gWWwYmBCRVTxr3RRzXGvZkF2a1W4pwzG37Nv1dR6SpSwDu5J+MMDVjKK
	 NexxSgLorMWZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/29] perf session: Add byte-swap and bounds check for
 PERF_RECORD_BPF_METADATA events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525010550.1100375-16-acme@kernel.org>
References: <20260525010550.1100375-16-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 01:54:45 +0000
Message-Id: <20260525015446.763731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Flawed TOCTOU mitigations in `perf_session__process_user_event` =
introduce a new double-fetch vulnerability and fail to protect downstream c=
onsumers.
--

commit 30d93e0987b40b97105d2394d829563792873b62
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Add byte-swap and bounds check for PERF_RECORD_BPF_METADATA e=
vents

This commit adds byte-swapping and bounds validation for PERF_RECORD_BPF_ME=
TADATA
events to prevent out-of-bounds reads when processing cross-endian perf.dat=
a files.
It handles writable cross-endian mappings by clamping values in place and v=
alidates
read-only native-endian mappings to skip malicious records.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 092fccbea8f80..95eb793026de6 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> @@ -2203,9 +2246,53 @@ static s64 perf_session__process_user_event(struct=
 perf_session *session,
>  	case PERF_RECORD_FINISHED_INIT:
>  		err =3D tool->finished_init(tool, session, event);
>  		break;
> -	case PERF_RECORD_BPF_METADATA:
> +	case PERF_RECORD_BPF_METADATA: {
> +		u64 nr_entries, max_entries;
> +		u32 hdr_size =3D READ_ONCE(event->header.size);

[Severity: Medium]
Could the snapshotting of event->header.size introduce a double-fetch issue?

Since native-endian files are mapped as MAP_SHARED, it seems a concurrent
modification by a malicious file writer could inflate event->header.size in
the time window between the core bounds check and this READ_ONCE().

If hdr_size is inflated, the calculated max_entries would be larger than the
actual mmap region, which might cause the strnlen loop below to read out
of bounds.

> +
> +		if (hdr_size < sizeof(event->bpf_metadata)) {
> +			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: header.size (%u) too s=
mall, skipping\n",
> +				   hdr_size);
> +			err =3D 0;
> +			break;
> +		}
[ ... ]
> +		/* Snapshot =E2=80=94 event is mmap'd and could change between reads */
> +		nr_entries =3D READ_ONCE(event->bpf_metadata.nr_entries);
> +		max_entries =3D (hdr_size - sizeof(event->bpf_metadata)) /
> +			      sizeof(event->bpf_metadata.entries[0]);
> +		if (nr_entries > max_entries) {
> +			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: nr_entries %" PRIu64 "=
 exceeds max %" PRIu64 ", skipping\n",
> +				   nr_entries, max_entries);
> +			err =3D 0;
> +			break;
> +		}
> +
> +		for (u64 i =3D 0; i < nr_entries; i++) {
> +			if (strnlen(event->bpf_metadata.entries[i].key,
> +				    BPF_METADATA_KEY_LEN) =3D=3D BPF_METADATA_KEY_LEN ||
> +			    strnlen(event->bpf_metadata.entries[i].value,
> +				    BPF_METADATA_VALUE_LEN) =3D=3D BPF_METADATA_VALUE_LEN) {
> +				pr_warning("WARNING: PERF_RECORD_BPF_METADATA: entry %" PRIu64 " key=
/value not null-terminated, skipping\n", i);
> +				err =3D 0;
> +				goto out;
> +			}
> +		}
> +
>  		err =3D tool->bpf_metadata(tool, session, event);

[Severity: Medium]
Does passing the raw event pointer to downstream consumers bypass the
validation performed above?

Because the event is volatile, functions downstream might re-read
event->bpf_metadata.nr_entries directly from the memory mapping instead
of using the validated nr_entries snapshot.

Could this lead to an out-of-bounds read if the value changes after the che=
ck
but before the consumer uses it?

>  		break;
> +	}
>  	case PERF_RECORD_SCHEDSTAT_CPU:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525010550.1100=
375-1-acme@kernel.org?part=3D15
