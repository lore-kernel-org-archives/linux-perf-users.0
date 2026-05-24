Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A70C156C6A
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 04:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779595316; cv=none; b=bMYLbibwnRapFmvNecxQIlHOGyWtFDEv0H4jqUVMeoVBFBZyxg0VM+q0uQ4u9TRFtm+EelIi4LTqGKKPc7cyBkDQXxEh5Y3AA194wMaMvQsJGwu1D/GosU2fzmsBuFE0rc/itF5Cme+OXgVkNq/7UuR6UbYTKoPPz9/gV5jM7Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779595316; c=relaxed/simple;
	bh=nBku2pcpDMzk5iXpimoM3CmcuMd0NEI9Um5JYKhdN4I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bw9a7zPVOVYGc8lXamF7jDV7kr1jqSTN4bby30m7PRmehltYf523h8+VKhTn3h56SNu/pyPjev4vWrcaZWNaaysVkHQfrFbNt/hhDiFIfMqPTWVmvn7TlI85QcUugJ4ZPlQE/8xipjyUACL6UCd9IOA+ySq5QpHFCPhCK/T9kC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J77/Ar1q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J77/Ar1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68C91F000E9;
	Sun, 24 May 2026 04:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779595315;
	bh=1azCBfh4hrnz7TISEeiUQp3oOO7ay2FmE8E+A2AccdI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J77/Ar1qQvxRPoJkyPqoXbMSgnUUDKERmtYkCymQb9ilJQNBc7Aose6P4vYH5JzBw
	 F5L8j+4jbpoYO6rIqJgXkWVvjc90V0YZKRL9UWKjIfepIYo2ayYFIcehNV/L5+o9tS
	 P8Hw03fCeHoAY07KHSlSv2eKaiFKEuIM5QgMeY+7/YhIVQALkXTXbX8RzXx4t1AtKe
	 934ryxNegOBsKZACM8St3RlFGoj75MKDIxbWQUzwq6umznAZAvJjz7NaeTRCBLmRm+
	 KdRzZcsvHo1UN4M7kwetaHb3noi9RtKwJ6kJYxHG9H4xxgVbE7rP7aSgb61zd23vQG
	 nfPrw9WL93FCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/29] perf tools: Bounds check perf_event_attr fields
 against attr.size before printing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524032709.1080771-18-acme@kernel.org>
References: <20260524032709.1080771-18-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 04:01:54 +0000
Message-Id: <20260524040154.D68C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The newly added fallback logic in `syscall_arg__scnprintf_augmente=
d_perf_event_attr` blindly copies 64 bytes from the payload, causing an out=
-of-bounds read if the actual payload is smaller.

Pre-existing issues:
- [High] `perf_event_attr__fprintf()` trusts the user-controlled `attr->siz=
e` field for bounds checking without validating it against the actual buffe=
r limits in the `perf trace` path.
--

commit 45122ffcfc4c42d20283944fff0ce0ea20c80919
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Bounds check perf_event_attr fields against attr.size before pr=
inting

perf_event_attr__fprintf() accessed all struct fields unconditionally,
but attrs from older perf.data files or BPF-captured syscall payloads
may have a smaller size than the current struct.  Fields beyond the
recorded size contain uninitialized or zero-filled data.

> diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace=
/beauty/perf_event_open.c
> index c1c7445dcff99..6315b46bcdf02 100644
> --- a/tools/perf/trace/beauty/perf_event_open.c
> +++ b/tools/perf/trace/beauty/perf_event_open.c
[ ... ]
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
> +		memcpy(&local_attr, attr, PERF_ATTR_SIZE_VER0);

[Severity: High]
Can this memcpy() read out of bounds if the actual payload is smaller than
PERF_ATTR_SIZE_VER0?

If a tracee uses a TOCTOU race to pass a small payload size (like 8 bytes)
to the first read, but modifies attr->size to 0 before the second read, the
user-space payload might only be 8 bytes long.

Since the BPF program sys_enter_perf_event_open dynamically sizes its output
based on the tracee's attr->size using bpf_perf_event_output(), could blind=
ly
copying 64 bytes here read past the end of the perf ring buffer and cause a
crash?

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
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/=
perf_event_attr_fprintf.c
> index 741c3d657a8b6..3933639d76c54 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
[ ... ]
> @@ -275,24 +275,56 @@ static void __p_config_id(struct perf_pmu *pmu, cha=
r *buf, size_t size, u32 type
[ ... ]
>  int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  			     attr__fprintf_f attr__fprintf, void *priv)
>  {
>  	struct perf_pmu *pmu =3D perf_pmus__find_by_type(attr->type);
> +	/*
> +	 * size =3D=3D 0 means ABI0 =E2=80=94 the producer didn't set attr.size.
> +	 * perf_event__fprintf_attr() may pass the raw mmap'd event
> +	 * before the local copy, so default to PERF_ATTR_SIZE_VER0
> +	 * (the ABI0 footprint) to avoid reading past the attr into
> +	 * the ID array that follows it in HEADER_ATTR events.
> +	 */
> +	u32 attr_size =3D attr->size ?: PERF_ATTR_SIZE_VER0;
>  	char buf[BUF_SIZE];
>  	int ret =3D 0;
> =20
> -	if (!pmu && (attr->type =3D=3D PERF_TYPE_HARDWARE || attr->type =3D=3D =
PERF_TYPE_HW_CACHE)) {
> +	/*
> +	 * Cap to what we understand: all callers store the attr in a
> +	 * buffer of sizeof(*attr) bytes (perf.data read path copies
> +	 * min(attr.size, sizeof), BPF augmented path copies into a
> +	 * fixed-size value[] array).  A spoofed attr->size larger
> +	 * than sizeof would cause PRINT_ATTRn to read past the
> +	 * actual buffer.
> +	 */
> +	if (attr_size > sizeof(*attr))
> +		attr_size =3D sizeof(*attr);

[Severity: High]
This is a pre-existing issue, but does capping attr_size to sizeof(*attr)
fully prevent out-of-bounds reads in the perf trace path?

The comment mentions the BPF augmented path copies into a fixed-size value[]
array, but augmented__output actually trims the emitted ring buffer event to
exactly the copied size (len + size).

If a tracee uses a TOCTOU race to supply a small payload while spoofing
attr->size to 136, this function will use 136 as the size. Will the PRINT_A=
TTRn
macros then read up to 136 bytes from a much smaller payload, resulting in
an out-of-bounds read?

> +
> +	if (!pmu && attr_size >=3D offsetof(struct perf_event_attr, config) + s=
izeof(attr->config) &&
> +	    (attr->type =3D=3D PERF_TYPE_HARDWARE || attr->type =3D=3D PERF_TYP=
E_HW_CACHE)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524032709.1080=
771-1-acme@kernel.org?part=3D17
