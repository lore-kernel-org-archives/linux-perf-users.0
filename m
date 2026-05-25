Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A97E792
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779674353; cv=none; b=paZOxvPWVM2X23bO3JUreWJeA6qstWZrk+tH/+c8XS6d7bnGt3ELzQFOdS71g02Jp2JYgY9GB+p5YrjoAbOPx4pydsvETzAKv31YruVBz8hBvEj2pmm2Mlh6Cc2oCbM2Co5vCNo4M6Zc+zh6kWjM0ZpdO0IaHZYh2rtIDUShhK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779674353; c=relaxed/simple;
	bh=tfN3L5x5RpRMtcLNbxTYnfAiuFHoxIPK0/dqXLhz4Y8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g5TcgsHotvnmt+ddAzzOgdZUSK/L4AcrdrCxttINfGPU5yanBDA2HbysgllyLJg/RcpaFrgp+zrw6Nosk/5XaU1W8ySRWW6aEt4phq/t4hceCAjdD5Er3l/VfZdQ2kMP+QsaQszEO9oef5cWVU9BBLH26bQIlUyGos21dyCtx50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxU0CQUl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxU0CQUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326961F000E9;
	Mon, 25 May 2026 01:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779674352;
	bh=c9+pfKPfFN1tomhAFjt8NfSmgT/TpoUTJ7DdJg2+rmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jxU0CQUlwp7UmdKFKI280rQ3kCtDmxpMlS6vPvDTQBzSgWNV0utGmdri3LtmPpW6o
	 knaJg7je5VzZLl9jIuSMGdHjbZXBWxXR8C4fkmsPl3c1Ak5+kdB378VZxCJPmOYMSo
	 A2dQoSYmu/ei0PXTXYqE3No5jH60WGLiyRGSe9Wz6w1VAyJRqtIrfB5mjmkOs3OdEZ
	 clXlAddy7dhwVLf40X+3MdSU3mJ68Rt3NKJDYGXOA2VWqnhdKivS4VRIxiFe2Mz6sC
	 ifjv/4hS8Ft7zJ4uKYn8RV2d61RVbZ/wXWLuHc+fUe2G2lSF7ONrN0yVcWx320cDZY
	 RqZOw/lO278FA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/29] perf tools: Bounds check perf_event_attr fields
 against attr.size before printing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525010550.1100375-18-acme@kernel.org>
References: <20260525010550.1100375-18-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 01:59:11 +0000
Message-Id: <20260525015912.326961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added bounds-checking logic relies on the untrusted `att=
r->size` without validating it against the actual container buffer size, le=
ading to out-of-bounds memory accesses.
--

commit 367d8eeae300d18773dd9a06dc2cf5c691cad24e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Bounds check perf_event_attr fields against attr.size before pr=
inting

This commit adds size-guarded macros to prevent out-of-bounds reads
when printing perf_event_attr structures that may be smaller than the
current struct definition. It also updates the BPF trace path to populate
the size field if the tracee passes a size of 0.

> diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace=
/beauty/perf_event_open.c
> index c1c7445dcff99..6315b46bcdf02 100644
> --- a/tools/perf/trace/beauty/perf_event_open.c
> +++ b/tools/perf/trace/beauty/perf_event_open.c
> @@ -80,7 +81,27 @@ static size_t perf_event_attr___scnprintf(struct perf_=
event_attr *attr, char *bf
> =20
>  static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct sy=
scall_arg *arg, char *bf, size_t size)
>  {
> -	return perf_event_attr___scnprintf((void *)arg->augmented.args->value, =
bf, size,
> +	struct perf_event_attr *attr =3D (void *)arg->augmented.args->value;
> +	struct perf_event_attr local_attr;
> +
> +	/*
> +	 * augmented_raw_syscalls.bpf.c (shipped with perf) copies
> +	 * PERF_ATTR_SIZE_VER0 bytes when the tracee passes size=3D0,
> +	 * but leaves the size field as 0.  The payload size is
> +	 * guaranteed by perf's own BPF program, not externally
> +	 * controllable.  Copy to a local so we can fix up size
> +	 * without writing to the potentially read-only augmented
> +	 * args buffer.
> +	 */
> +	if (!attr->size) {

[Severity: High]
Is it possible for the augmented BPF payload to be smaller than 8 bytes her=
e?

If a tracee calls perf_event_open with a small size (e.g. 4 bytes), only
those 4 bytes might be copied into the argbuf buffer.

Reading attr->size (which is at offset 4) would then read stale data left
over in argbuf from previously intercepted syscalls.

If that stale data evaluates to a large value, the bounds checks in
perf_event_attr__fprintf() would trust it, potentially leaking up to
sizeof(*attr) bytes of stale argbuf data to the trace output.

Should this code verify that the augmented payload size contains at least
offsetof(struct perf_event_attr, size) + sizeof(attr->size) before attempti=
ng
to read attr->size?

> +		memcpy(&local_attr, attr, PERF_ATTR_SIZE_VER0);
> +		memset((void *)&local_attr + PERF_ATTR_SIZE_VER0, 0,
> +		       sizeof(local_attr) - PERF_ATTR_SIZE_VER0);
> +		local_attr.size =3D PERF_ATTR_SIZE_VER0;
> +		attr =3D &local_attr;
> +	}
> +
> +	return perf_event_attr___scnprintf(attr, bf, size,
>  					   trace__show_zeros(arg->trace));
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525010550.1100=
375-1-acme@kernel.org?part=3D17
