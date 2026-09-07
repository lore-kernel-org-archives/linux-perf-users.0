Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA322A4E1
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746796; cv=none; b=iOJVrAeD6zEDj7wNYM9RxnIocBTZ7d78Ix49d2t3YPX/MOuwPm78fAl5bY8vcpGe9z7lSIo7HQImYvP7jyp0eoEjw5+3eFPu41h0cgyZAShQit+JCbQBW2POcIPbVKpLmXXhcxnoJtfOOOx27F9BFyRrxaHHRAKycxc5T7BUfcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746796; c=relaxed/simple;
	bh=R2D7db0NTuYhY5lqYgoy9OnXgvBWRqz3EOf1cqZmOnE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L9xLSoYyZgBMBEm5qew0j1NoAos7g+nUkLWtbRFEjicUhH+nEZaLhfVvNd+pz8ws9czsGRzLpM/k+FOtGTjlbTV7qaqejDeI5p2E4gjWTGgKiFdoI0MjzJlyup/oCWIEXXGvlLKe1hsbRte2nKRaTqKpdISktmpMEYAUwDZUN9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er+V019m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er+V019m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7D11F00A3A;
	Mon,  7 Sep 2026 02:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746792;
	bh=Ajk/2/Z2vCu2mqmBsdJrtbkMzfqyfQ5+/JAaYgWsc54=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Er+V019mMaGR+3DCYzHKYGFMSw8PadGaQVSoqoORHd8Wy9d+dc8ReWthQLOY8p6D9
	 q3O4MIeCtwYHmtWdk7KHvrmic3nhzynV4clFj93a+s1rrPmPao8WshkhdFNjdv1H7I
	 AB4fgVjqqweFBvFwZSYdwYtUVmdosUhYKUvidy0/c6BmKvNQLeL1aFubfa/KbeP4xm
	 RiiSdN2l0RvG+NGKIKnU1s6SYKppfCNrOWqU2LDe4H10of9lG3RWaAHzEZ4zFQZn/U
	 1JMTFU8WLo6N61IqBj0SRRAEN7nTSBovlnRS1cQyFwy/pTXjzElEZgGq/HgLDer5GO
	 KL9sd8TAwzDqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 perf-tools-next 6/6] perf trace beauty: Validate
 payload size in augmented perf_event_open beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260907015140.363076-7-atomlin@atomlin.com>
References: <20260907015140.363076-1-atomlin@atomlin.com>
 <20260907015140.363076-7-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 02:06:32 +0000
Message-Id: <20260907020632.9F7D11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The newly added bounds check relies on the `augmented_arg->size` f=
ield, but the BPF program for `sys_enter_perf_event_open` leaves this field=
 uninitialized, randomly breaking `perf trace` augmentation.

Pre-existing issues:
- [High] The patch fails to validate that the embedded `attr->size` does no=
t exceed the actual augmented payload size, allowing out-of-bounds reads if=
 the tracee mutates the field (TOCTOU) or if a malformed `perf.data` file i=
s parsed.
--

commit f9180137a1c578e9c897496a107baa521c327ae0
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace beauty: Validate payload size in augmented perf_event_open beaut=
ifier

This commit adds bounds checking to the augmented payload of perf_event_open
in perf trace. It attempts to verify that the augmented argument size is la=
rge
enough to contain at least PERF_ATTR_SIZE_VER0 bytes before accessing the
perf_event_attr payload.

> diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace=
/beauty/perf_event_open.c
> index 6315b46bcdf02..846738225abd7 100644
> --- a/tools/perf/trace/beauty/perf_event_open.c
> +++ b/tools/perf/trace/beauty/perf_event_open.c
> @@ -81,9 +81,18 @@ static size_t perf_event_attr___scnprintf(struct perf_=
event_attr *attr, char *bf
> =20
>  static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct sy=
scall_arg *arg, char *bf, size_t size)
>  {
> -	struct perf_event_attr *attr =3D (void *)arg->augmented.args->value;
> +	struct augmented_arg *augmented_arg =3D arg->augmented.args;
> +	struct perf_event_attr *attr;
>  	struct perf_event_attr local_attr;
> =20
> +	if (arg->augmented.size < (int)sizeof(*augmented_arg))
> +		return 0;
> +
> +	if (augmented_arg->size < (int)PERF_ATTR_SIZE_VER0 ||
> +	    augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_=
arg))
> +		return 0;

[Severity: High]
Does this newly added bounds check read an uninitialized field?

Looking at sys_enter_perf_event_open() in
tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c, the BPF program reads
the payload and outputs it:

    if (bpf_probe_read_user(&augmented_args->arg.value, size, attr) < 0)
        goto failure;

    return augmented__output(args, augmented_args, len + size);

However, it does not appear to populate augmented_args->arg.size. Since
augmented_args is allocated from a reused per-CPU map, will size contain
junk data from previous syscalls (like an openat length), causing this
check to randomly fail and break the trace augmentation?

> +
> +	attr =3D (void *)augmented_arg->value;

[Severity: High]
This is a pre-existing issue, but does the newly added bounds check complet=
ely
prevent out-of-bounds reads if the tracee mutates the embedded attr->size
field?

While this patch validates that augmented_arg->size fits within the buffer,
attr is eventually passed down to perf_event_attr__fprintf() which trusts
attr->size directly:

    u32 attr_size =3D attr->size ?: PERF_ATTR_SIZE_VER0;
    ...
    if (attr_size > sizeof(*attr))
        attr_size =3D sizeof(*attr);

If a malformed perf.data record or a TOCTOU mutation provides an attr->size
that is larger than the actual augmented payload (e.g., 136 bytes while the
buffer only contains PERF_ATTR_SIZE_VER0 bytes), won't the formatter read
past the end of the available buffer and leak adjacent memory into the
trace?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907015140.3630=
76-1-atomlin@atomlin.com?part=3D6
