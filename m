Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFAF346FA6
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778626733; cv=none; b=kFq+hzjlFlA1gYiAO+GQrQNZI7aIF4vc9pQp3CZFg+agUB87XN+gDmtAIRBrIme2KXnwRUFIExFAZuWQrapo/qveogLOaRkuYN5y+I+MW5FexH5lWO5UKpr8KtQAo6/m6p4yWtlkIXQ2Zy4kpI4XW2stg1z30MQqrtto1xuxPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778626733; c=relaxed/simple;
	bh=vZsxZx2y9IfpWVEBPU+cDYe+g6zFNlGwcbgpRSmdrhQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VaULgywmjUWrfg/sBlKiuY6s4VJjfHPAvtLWE0IBLN6D+fNS0BCYe9yOp7Uw45o5aYBoO8uHMK09s8glHIBOit0SStM8fnqPf6056b61SFo856nlw6o9tRQAaRrcwahBb8vm+uUL3JGkVhFUzBBoIZfPTGNiH5hbTvBEKFpevXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lzq87I1u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lzq87I1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81E6C2BCB0;
	Tue, 12 May 2026 22:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778626732;
	bh=vZsxZx2y9IfpWVEBPU+cDYe+g6zFNlGwcbgpRSmdrhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Lzq87I1uxMBgINnv9II5/jVdc/Gdtc6YaZjPG5hMmxcaica6Zh0txHOf/ZVwKMzha
	 lKLVmmkCyBo7sLyEMqNdedTCY/yg/SqHi4ZwLmG+4/hai3QmF2eEXDCgZDvVxvgjVH
	 R1xuDzb/RP33No0p7dPYuqf5XCC4Qu2C3W8DtSWdKSIZDPis4HKzMNHxoWJtLzXqxU
	 UJrzRVc2PsLmhBznOgEHo58y6oHpMRIKNPy5iKcU5Vr5VZWApOq4WCP96N9SGUJrnP
	 yApMfAUoRGyBU7Fl9cb4oC8TpHHV9/6d6mWiV8PdbGkGCdhXX6MfEnQGh7IB35nA9q
	 jiKDB3G6WiskQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/28] perf session: Add byte-swap and bounds check for
 PERF_RECORD_BPF_METADATA events
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510033424.255812-15-acme@kernel.org>
References: <20260510033424.255812-15-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 22:58:51 +0000
Message-Id: <20260512225852.B81E6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Time-of-Check to Time-of-Use (TOCTOU) and double-fetch vulnerabili=
ties in PERF_RECORD_BPF_METADATA parsing allow bounds check bypasses leadin=
g to out-of-bounds memory writes.
--

commit a0df5fd6c7ae94e18c39e39cde4b14a49db594f3
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Add byte-swap and bounds check for PERF_RECORD_BPF_METADATA e=
vents

This commit adds byte-swapping and bounds checking for PERF_RECORD_BPF_META=
DATA
events when processing cross-endian perf.data files. It validates the header
size, number of entries, and string NUL-termination to prevent out-of-bounds
reads.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index a2dba77c6a2b9..876e20c4ba8a7 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> @@ -942,6 +942,45 @@ static int perf_event__time_conv_swap(union perf_eve=
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
> +
> +	event->bpf_metadata.nr_entries =3D bswap_64(event->bpf_metadata.nr_entr=
ies);

Could this sequence lead to a Time-of-Check to Time-of-Use (TOCTOU)
vulnerability?

The perf.data file is mapped into memory using MAP_PRIVATE for cross-endian
files. MAP_PRIVATE pages share the underlying file's page cache until a
Copy-On-Write (COW) fault occurs.

If the file is modified concurrently after the size check but before the
write to event->bpf_metadata.nr_entries, the COW would freeze the new,
potentially malicious event->header.size into the process's private page.

> +
> +	/*
> +	 * Ensure NUL-termination on the cross-endian path where the
> +	 * mapping is writable (MAP_PRIVATE + PROT_WRITE).  Fixing
> +	 * the string in place is preferred over rejecting because it
> +	 * preserves the event for downstream processing =E2=80=94 only the
> +	 * last byte is lost.
> +	 *
> +	 * The native-endian path (MAP_SHARED + PROT_READ) cannot
> +	 * write, so it validates and skips unterminated events in
> +	 * perf_session__process_user_event() instead.  The two
> +	 * strategies produce different outcomes for the same
> +	 * malformed input (fix vs skip), which is inherent in the
> +	 * writable-vs-read-only mapping model.
> +	 */
> +	event->bpf_metadata.prog_name[BPF_PROG_NAME_LEN - 1] =3D '\0';
> +
> +	nr =3D event->bpf_metadata.nr_entries;
> +	max_nr =3D (event->header.size - sizeof(event->bpf_metadata)) /
> +		 sizeof(event->bpf_metadata.entries[0]);

Since event->header.size is read again from the mapped memory, could a
concurrently modified, smaller size cause this calculation to underflow,
producing a massive max_nr?

> +	if (nr > max_nr)
> +		nr =3D max_nr;
> +
> +	for (i =3D 0; i < nr; i++) {
> +		event->bpf_metadata.entries[i].key[BPF_METADATA_KEY_LEN - 1] =3D '\0';
> +		event->bpf_metadata.entries[i].value[BPF_METADATA_VALUE_LEN - 1] =3D '=
\0';
> +	}

Would this massive max_nr then bypass the bounds check and allow the loop
to write NUL bytes out-of-bounds across the process's memory?

> +	return 0;
> +}
[ ... ]
> @@ -2181,9 +2221,50 @@ static s64 perf_session__process_user_event(struct=
 perf_session *session,
>  	case PERF_RECORD_FINISHED_INIT:
>  		err =3D tool->finished_init(tool, session, event);
>  		break;
> -	case PERF_RECORD_BPF_METADATA:
> +	case PERF_RECORD_BPF_METADATA: {
> +		u64 max_entries;
> +
> +		if (event->header.size < sizeof(event->bpf_metadata)) {
> +			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: header.size (%u) too s=
mall, skipping\n",
> +				   event->header.size);
> +			err =3D 0;
> +			break;
> +		}
> +
> +		/*
> +		 * Native-endian files are mmap'd read-only =E2=80=94 validate
> +		 * NUL-termination instead of writing.
> +		 */
> +		if (strnlen(event->bpf_metadata.prog_name,
> +			    BPF_PROG_NAME_LEN) =3D=3D BPF_PROG_NAME_LEN) {
> +			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: prog_name not null-ter=
minated, skipping\n");
> +			err =3D 0;
> +			break;
> +		}
> +
> +		max_entries =3D (event->header.size - sizeof(event->bpf_metadata)) /
> +			      sizeof(event->bpf_metadata.entries[0]);

Similarly on the native-endian path (using MAP_SHARED), could reading
event->header.size multiple times allow an attacker to underflow max_entries
by modifying the file concurrently?

> +		if (event->bpf_metadata.nr_entries > max_entries) {
> +			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: nr_entries %" PRIu64 "=
 exceeds max %" PRIu64 ", skipping\n",
> +				   (u64)event->bpf_metadata.nr_entries, max_entries);
> +			err =3D 0;
> +			break;
> +		}
> +
> +		for (u64 i =3D 0; i < event->bpf_metadata.nr_entries; i++) {

Could event->bpf_metadata.nr_entries also change between the check and this
loop, leading to out-of-bounds reads?

To prevent this, should event->header.size and event->bpf_metadata.nr_entri=
es
be read into local variables once and validated before further use?

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510033424.2558=
12-1-acme@kernel.org?part=3D14
