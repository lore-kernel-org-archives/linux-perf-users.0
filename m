Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E63955C8
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832611; cv=none; b=USqPu7VDD1DSQiCsZQNTY68XB/CFYL7nU/Y/Ml1pjB14TGPg4gGHFWusyuOPPOM9O0noa6DL764ONjiV8mR3hvJpm0LLyrQqvOZFeb5Jd37wCotpmBo9KSAQco4hlNqlFS/mFdaFigwIIkB1ZFtg62Cli5aazHU9jppLrbrosyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832611; c=relaxed/simple;
	bh=5RfjHSx4DtDD8Vl9P341VR5Ul8S2NS9EUNLawJWxOt4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sae2xZ5cCg0+LT5n+tJZ1t/tlWxTHhLwx4cZCAL4aI+2+PmPptUb770LkTxxfF8mXYDghtVyJuhGQMYE/+ar8pIGDWocEMTsLF1r2jke6DwhVLg+huy6UyXCvF0ld6G+UNqBiFJn+RgnVwpeE93ICtb5Ar3bGIzRMD2Ph655dtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+T2+kzO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+T2+kzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0831F000E9;
	Tue, 26 May 2026 21:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832610;
	bh=jQ6cLiB+dQIVlX/aQtyfCk6czQSDYLScaeMAN1+j8S4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g+T2+kzOUestxkYjVOP3apsQhy+NNvi7zmfoGfnJrxnRH9nWNcXMe++d95r9jcIUW
	 Jk4FA0zeh9o/2Z3ABZumDuTe8CVLB6XqzeairT7fmbqDX/tKqtVgvCzeOuugGxcb+g
	 LxsL0DV1HqS7RVx+aSQQEeNysokCNbTS+ZoUianNmM4VDEGtPLR7Iq8CcLVOhDmFPD
	 QwN50oeYI0Ws4N7WqIahJWwM4pTtPbyQRCe4RUQF/cavMFvkIzd8eb3ThcOLn5R+Zh
	 FTgSIwvyecEVcCxs9KC2yA1r3VigfFN1STFW0NCheFzRwR/hVouNlmvICXGMwxPwsA
	 GuqqdZ+bv6uVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/29] perf session: Add byte-swap and bounds check for
 PERF_RECORD_BPF_METADATA events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526211806.1193848-16-acme@kernel.org>
References: <20260526211806.1193848-16-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 21:56:49 +0000
Message-Id: <20260526215650.1C0831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] A double-fetch of `event->header.size` in `perf_event__bpf_metadat=
a_swap()` allows an attacker to underflow `max_nr`, bypassing clamping logi=
c and causing massive out-of-bounds writes.

Pre-existing issues:
- [High] The bounds checking and string validation introduced for PERF_RECO=
RD_BPF_METADATA are bypassed by downstream consumers due to a Time-Of-Check=
 to Time-Of-Use (TOCTOU) vulnerability.
- [High] In `perf_session__process_user_event()`, fetching `event->header.s=
ize` via `READ_ONCE()` can retrieve a size larger than what the caller vali=
dated, leading to out-of-bounds reads past the memory mapping.
--

commit be863429ae5d472c5216e543fecba1e6eae818cc
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Add byte-swap and bounds check for PERF_RECORD_BPF_METADATA e=
vents

PERF_RECORD_BPF_METADATA has no entry in perf_event__swap_ops[], so its
nr_entries field is never byte-swapped when reading a cross-endian
perf.data file. Downstream processing in perf_event__fprintf_bpf_metadata()
loops over nr_entries, so a foreign-endian value causes out-of-bounds reads.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 092fccbea8f80..95eb793026de6 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -961,6 +961,48 @@ static int perf_event__time_conv_swap(union perf_eve=
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

[ ... ]

> +	nr =3D event->bpf_metadata.nr_entries;
> +	max_nr =3D (event->header.size - sizeof(event->bpf_metadata)) /
> +		 sizeof(event->bpf_metadata.entries[0]);

[Severity: High]
Can this double-fetch of event->header.size allow an attacker to bypass the
clamping logic?

Because event points to a memory-mapped file, the file can be modified
concurrently. If event->header.size is modified to a value smaller than
sizeof(event->bpf_metadata) after the initial size check above, but before =
this
calculation, wouldn't the subtraction underflow and yield a massive unsigned
value for max_nr?

This would bypass the nr > max_nr check below, allowing the loop to write N=
UL
bytes out-of-bounds. The commit message mentions fixing a double-fetch via
READ_ONCE(), but it appears it was only applied to process_user_event(),
leaving the swap path vulnerable.

> +	if (nr > max_nr) {
> +		/* Persist clamped value so the native path processes entries, not ski=
ps */
> +		nr =3D max_nr;
> +		event->bpf_metadata.nr_entries =3D nr;
> +	}
> +
> +	for (i =3D 0; i < nr; i++) {
> +		event->bpf_metadata.entries[i].key[BPF_METADATA_KEY_LEN - 1] =3D '\0';
> +		event->bpf_metadata.entries[i].value[BPF_METADATA_VALUE_LEN - 1] =3D '=
\0';
> +	}
> +	return 0;
> +}

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

[Severity: High]
This is a pre-existing issue, but by re-fetching event->header.size via
READ_ONCE() here, could we retrieve a size larger than what the caller
originally validated?

If a malicious writer enlarges the size between the caller's check against =
the
memory mapping bounds and this READ_ONCE(), max_entries would be calculated
based on the enlarged size. This would cause the strnlen validations below
to read memory past the end of the memory-mapped file.

> +
> +		if (hdr_size < sizeof(event->bpf_metadata)) {
> +			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: header.size (%u) too s=
mall, skipping\n",
> +				   hdr_size);
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

[ ... ]

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

[Severity: High]
This is a pre-existing issue, but is the validation mitigation bypassed her=
e?

After verifying the string lengths and entry bounds locally, the raw
memory-mapped event pointer is passed directly to the downstream callback.
If downstream handlers read event->bpf_metadata.nr_entries and the payload
strings from the shared memory again, an attacker could concurrently modify
the mmap'd file after these checks, leading to out-of-bounds reads.

>  		break;
> +	}
>  	case PERF_RECORD_SCHEDSTAT_CPU:
>  		err =3D tool->schedstat_cpu(tool, session, event);
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526211806.1193=
848-1-acme@kernel.org?part=3D15
