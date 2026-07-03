Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8536E3B47CD;
	Fri,  3 Jul 2026 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075725; cv=none; b=k77WDc5ChjahZx//lQHUceZggp/UF1Vgxc67p0Irm+V05Mxb9onCorViHPTd46yZQtam87GZaKQ80vdVs/zEKiJikP6juoP4UPFPSNhBPz8Lx8B8junibqfOUdSiPoQfsAtdqJpKmE1e26ZY5rtLz20eJX30icGvrvNuc4mTbI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075725; c=relaxed/simple;
	bh=4wpVi5B6cuEm0Yx8MPwGNQT7mk6f4DTeDdrRm/VBsI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i71WTD+WEtpPU9m/jYwNkzJ3vtWFS62NpJmM01zY4KpWHKHeUlN6sv3zGiUN4kgvYuT48be4LiPgCshRmfYxywbHb/TQntWERQYBs53zQo4l/27kJCLQDLyO7yv6d0K9PEZy6tvJxXJ40UahQO3rcfjc/0OIpJOk0HrBouMiQXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvatzzEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvatzzEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21C51F000E9;
	Fri,  3 Jul 2026 10:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783075724;
	bh=PCHPieaTdVPktVO1pf+IqahTfnxq7M8WpDNPUJJV0Bw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gvatzzEeGf7tAAFwCSusFnI+uJc1bxYr7d+Nz5jb+bdqIpb8GJazFvU5iLm0s7Oh8
	 pytYqB303papvdLM9Z5E0+Ya7/Juc+ZHUw69ihYeFZUbGYGZ91UgYJufTQQx+BYXSh
	 g81ArlMvFmnKKuGApviinScuG+Hx2fgQcAjyAbhZBspaGfK3Hi1AcHHW26JZUydMly
	 ja9evYvifX38Ch0X5zbjAXb2moA5t5uyHm1Fai0N4G5+WU1r08fHdaOJrr4iYjxQko
	 UA9sRKP051wfUolH8bCZfhtAM5XwqXD894opaDuobvAMCdc+yKkQGigxwDVbuEjgla
	 BX17IItOL3hJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf trace: Factor out BPF loop body
Reply-To: sashiko-reviews@lists.linux.dev
To: "Viktor Malik" <vmalik@redhat.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20fc67aa2550ca5aff52b3a9a207f2e07f8e0b1d.1783070132.git.vmalik@redhat.com>
References: <cover.1783070132.git.vmalik@redhat.com>
 <20fc67aa2550ca5aff52b3a9a207f2e07f8e0b1d.1783070132.git.vmalik@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 10:48:42 +0000
Message-Id: <20260703104843.E21C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Zero-extension of map values makes the condition `size < 0` alwa=
ys false, resulting in dead code that completely breaks tracepoint buffer a=
ugmentation.
--

commit d586728f909e7c096ce4ad924848b781a274c29f
Author: Viktor Malik <vmalik@redhat.com>

perf trace: Factor out BPF loop body

This commit factors out the loop body in augmented_raw_syscalls into a
separate function. This is intended to simplify the code and help address
problems with the BPF verifier.

> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c

[ ... ]

> +static inline int augment_arg(struct syscall_enter_args *args, int i,
> +			      unsigned int *beauty_map, void *payload_offset)
> +{
> +	int index, value_size =3D sizeof(struct augmented_arg) - offsetof(struc=
t augmented_arg, value);
> +	s64 aug_size, size;
> +	bool augmented;
> +	void *arg;
> +
> +	arg =3D (void *)args->args[i];
> +	augmented =3D false;
> +	size =3D beauty_map[i];

[ ... ]

> +	} else if (size > 0 && size <=3D value_size) { /* struct */
> +		if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->val=
ue, size, arg))
> +			augmented =3D true;
> +	} else if ((int)size < 0 && size >=3D -6) { /* buffer */

[Severity: Medium]
Will this condition evaluate correctly given that beauty_map contains
unsigned integers?

When the userspace perf trace tool populates beauty_map_enter with negative
values (e.g., -1) to indicate buffer arguments, they are stored as 32-bit
unsigned integers (e.g., 4294967295).

Since size is an s64, reading from the map via size =3D beauty_map[i]
zero-extends this unsigned value, making it strictly non-negative.

It appears a subsequent patch in this series removes the (int) cast to
address an out-of-bounds array access caused by the size >=3D -6 check
(which was a pre-existing issue).=20

However, removing that cast leaves the condition checking if size < 0,
which will always be false because of the zero-extension.

Could this inadvertently turn the entire buffer augmentation branch into
dead code, systematically failing to augment every buffer tracepoint
argument?

> +		index =3D -(size + 1);
> +		barrier_var(index); // Prevent clang (noticed with v18) from removing =
the &=3D 7 trick.
> +		index &=3D 7;	    // Satisfy the bounds checking with the verifier in =
some kernels.
> +		aug_size =3D args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF=
 : args->args[index];

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783070132.gi=
t.vmalik@redhat.com?part=3D1
