Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5B3672AE
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330241; cv=none; b=fqDmGSXfAIxPTVim3IsLodJHSHy8EN3d9m+MrmcU+VduQZwOVZoUTAzLoKdb3sT/n2ujSjvqrMjm3avx4KQfszuzM6jV4fw1nGslZcMD8PWQgc0yXmWj24xnKgSgCXIpuEzoc6yrbtWnmqb5baPuGKuf4vSKj6Vc4POSupchE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330241; c=relaxed/simple;
	bh=X6EhypjJgSDYVl4m29Qj94AH5O3Ykxxzn+HCqVXs3sE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eVD8sQuAh0XWDLqGQf4Tqqmo1D7X2J3+S6ri/sgjj3qh8GThKG592kE4DWVXIeza2hJjo56ZpRH+4vW6bxyefflfgqQbussJbtEEIcfU0YjxAdlW+GwzTydq8eDnfVCcewwqBuDwELdT84vfdHMaNjjphqFCPNtbOGpCvYmBp2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9FhYpKW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9FhYpKW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE1E1F000E9;
	Thu, 21 May 2026 02:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779330232;
	bh=11XR+aGn0U+lnUqY/GSxIJ2KwwULYOT89MMq0EIpBoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9FhYpKW6LnQpQlrJYU16mB480N5H2WvjVesz+L+US3Cr+pEJfXx0MwiC8EPcvJ2B
	 UTalHsU2+eIDanyy6UDzo2dzFKpBHz8mdAoG7376ydCr1Z9IwOaanXb7YWKAJ0+NRO
	 9uAZ+J9NZxaLJSGEgogzQ2MxvuyGr8as4QCQQ7uoEKzXYt3OFGYrpghKfHwbZqlGH5
	 RLf2CKFueuhLLrsyITf4esLYMbLD2HqVdThHwv78CO1X6H1BopuETKn5c2WWrvbVTS
	 M8kmIhCJxruSIdFj2x+dzQZNMA4JhbyyfiYnIPlXSi5QJs/DVmFlKMObYxtYbu1xYM
	 ZWcAnNS7oQTfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/27] perf session: Add byte-swap and bounds check for
 PERF_RECORD_BPF_METADATA events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260521011027.622268-15-acme@kernel.org>
References: <20260521011027.622268-15-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 02:23:51 +0000
Message-Id: <20260521022351.DEE1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Double-fetch of event->header.size from shared memory allows an =
integer underflow when calculating max_entries, bypassing bounds checks.
--

commit 2878626b28bb4e1f50c0867609d42bbf097edbc3
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Add byte-swap and bounds check for PERF_RECORD_BPF_METADATA e=
vents

This commit adds a swap handler and bounds checks for PERF_RECORD_BPF_METAD=
ATA
events to prevent out-of-bounds reads during cross-endian processing. It
validates header size and entry counts, and ensures string NUL-termination.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 5b089da224545..928775f727c49 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -933,6 +933,45 @@ static int perf_event__time_conv_swap(union perf_eve=
nt *event,
>  	return 0;
>  }
> =20
> +static int perf_event__bpf_metadata_swap(union perf_event *event,
> +					 bool sample_id_all __maybe_unused)
> +{
> +	u64 i, nr, max_nr;
> +
> +	/* Fixed header must fit before accessing nr_entries or prog_name */
> +	if (event->header.size < sizeof(event->bpf_metadata))
> +		return -1;

[ ... ]

> +	nr =3D event->bpf_metadata.nr_entries;
> +	max_nr =3D (event->header.size - sizeof(event->bpf_metadata)) /
> +		 sizeof(event->bpf_metadata.entries[0]);

[Severity: Medium]
Since the event can reside in shared memory and be modified concurrently, c=
ould
event->header.size be changed between the initial size check and this
calculation?

If event->header.size is reduced after the first check, could the unsigned
subtraction underflow and result in a very large max_nr, thereby bypassing =
the
bounds check and allowing out-of-bounds writes?

> +	if (nr > max_nr)
> +		nr =3D max_nr;

[ ... ]

> @@ -2172,9 +2212,52 @@ static s64 perf_session__process_user_event(struct=
 perf_session *session,
>  	case PERF_RECORD_FINISHED_INIT:
>  		err =3D tool->finished_init(tool, session, event);
>  		break;
> -	case PERF_RECORD_BPF_METADATA:
> +	case PERF_RECORD_BPF_METADATA: {
> +		u64 nr_entries, max_entries;
> +
> +		if (event->header.size < sizeof(event->bpf_metadata)) {
> +			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: header.size (%u) too s=
mall, skipping\n",
> +				   event->header.size);
> +			err =3D 0;
> +			break;
> +		}

[ ... ]

> +		/* Snapshot =E2=80=94 event is mmap'd and could change between reads */
> +		nr_entries =3D READ_ONCE(event->bpf_metadata.nr_entries);
> +		max_entries =3D (event->header.size - sizeof(event->bpf_metadata)) /
> +			      sizeof(event->bpf_metadata.entries[0]);

[Severity: Medium]
Similarly here, while READ_ONCE() is used for nr_entries, event->header.siz=
e is
read again directly from the event. Should event->header.size also be captu=
red
early into a local variable and reused for the max_entries calculation to
prevent a similar underflow issue?

> +		if (nr_entries > max_entries) {
> +			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: nr_entries %" PRIu64 "=
 exceeds max %" PRIu64 ", skipping\n",
> +				   nr_entries, max_entries);
> +			err =3D 0;
> +			break;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521011027.6222=
68-1-acme@kernel.org?part=3D14
