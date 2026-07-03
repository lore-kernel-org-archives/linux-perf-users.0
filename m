Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637D83BA253;
	Fri,  3 Jul 2026 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075556; cv=none; b=fgUvh7aTOBEy4tO3AWqOjxkHJU2MZiBPYShXBNDzDKPDvtylZMhyOKooxI6IAPrxbPMwRcUjpWaL+J3uTSOHXCCoVfMBOkgtZvkrVsXjFLUx8aes3a9M/i1ZEQ115TcUIHq+mVdFBzz2/n1/fZkdvwaQ7NJeO546QyzF0seUWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075556; c=relaxed/simple;
	bh=868HwswZgp8w42/SnyrttQUqueU6BuQEvW0h6zHR8mQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ga21ZcmQkcE3zFdUq6XHbYpBiHePwV5cSAI+n52rCBmB1sp/GFvNm/EKBuIJt4+d7OFRlMTKFH+/cqWfvlbeHz3PRVU9PZdsJWS/BybGC6w7Fds+cGe4ezcDFu9qGssi9RkVPYhEuqJB7LNqd7ZALyp1RxTYuwG2ESayV+k8tr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+fcMjMS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+fcMjMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE821F000E9;
	Fri,  3 Jul 2026 10:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783075555;
	bh=fEWkrw8IfjCEGS058nTVH8CD/aFNH2jOYCFo6gZas4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g+fcMjMSBIHcLhFK7aDtDRyXXARs3Mkx+3uSScCefvpc/ars1uevx8PeFeK0xLfnB
	 wgW3i8ZdaGda4fIscSCbdwdCTrRBi3O0lBbt8IiEdeSqKdgKhmNpZXgDQILkxEFg+A
	 0gmik+glkdnj3bEKvNTgnBCx9eGfe8sK7VSQa294uEM5bCD82R+CU42w7B0Bq2RPuS
	 tAkRrI7O2Heh5IzciF3cJE6CxJbnxYG5xZy6ls34DOboDyAfwPrbfp4B+/jqJma+2Z
	 z+n57S/LavyWAsrcJFaCd7iLxRE63k4uMjOmwg1rfJ23XQ9qwv1JL7kc+uFFuCc1R/
	 TYELeTMRKiJ1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf trace: Refactor augmented_raw_syscalls
 using bpf_for
Reply-To: sashiko-reviews@lists.linux.dev
To: "Viktor Malik" <vmalik@redhat.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <8ceb8f3323d0742163c42c343eb9d26843fe9e9b.1783070132.git.vmalik@redhat.com>
References: <cover.1783070132.git.vmalik@redhat.com>
 <8ceb8f3323d0742163c42c343eb9d26843fe9e9b.1783070132.git.vmalik@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 10:45:53 +0000
Message-Id: <20260703104554.CAE821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Removing the `(int)` cast in the buffer augmentation condition mak=
es it unconditionally false, completely breaking buffer payload collection.
- [Medium] Huge buffer sizes (where the MSB is set) fail to be augmented, w=
hereas previously they were safely clamped to `TRACE_AUG_MAX_BUF`.
- [Low] Multi-line comment does not follow the required BPF subsystem style.
--

commit 0a122bc3ab16635b5165b20566e6e1890cba855b
Author: Viktor Malik <vmalik@redhat.com>

perf trace: Refactor augmented_raw_syscalls using bpf_for

This commit replaces the standard loop in augment_sys_enter with a bpf_for
loop to prevent BPF verifier -E2BIG errors. It also drops some workarounds
previously added to help the verifier.

> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index cbdd5ce19a2f6..60babc06f3812 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c

[ ... ]

> @@ -464,11 +473,13 @@ static inline int augment_arg(struct syscall_enter_=
args *args, int i,
>  	} else if (size > 0 && size <=3D value_size) { /* struct */
>  		if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->val=
ue, size, arg))
>  			augmented =3D true;
> -	} else if ((int)size < 0 && size >=3D -6) { /* buffer */
> +	} else if (size < 0 && size >=3D -6) { /* buffer */

[Severity: High]
Does removing the (int) cast make this condition unconditionally false?

Since size is an s64 assigned from an unsigned int beauty_map[i], a negative
marker (e.g. 0xFFFFFFFF) is zero-extended to a positive s64 value.
Without the (int) cast to truncate and sign-extend it back, size < 0 is
always false, breaking buffer payload collection.

>  		index =3D -(size + 1);
>  		barrier_var(index); // Prevent clang (noticed with v18) from removing =
the &=3D 7 trick.
>  		index &=3D 7;	    // Satisfy the bounds checking with the verifier in =
some kernels.
> -		aug_size =3D args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF=
 : args->args[index];
> +		aug_size =3D args->args[index];
> +		if (aug_size > TRACE_AUG_MAX_BUF)
> +			aug_size =3D TRACE_AUG_MAX_BUF;

[Severity: Medium]
Will huge buffer sizes (where the most significant bit is set) fail to be
augmented here?

args->args[index] is an unsigned long. If the most significant bit is set,
assigning it to the s64 aug_size makes it negative. The subsequent
if (aug_size > TRACE_AUG_MAX_BUF) is a signed comparison and will evaluate
to false. The length remains negative, causing the later if (aug_size > 0)
check to fail, skipping buffer processing entirely instead of clamping it.

> =20
>  		if (aug_size > 0) {
>  			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->va=
lue, aug_size, arg))

[ ... ]

> @@ -521,14 +530,29 @@ static int augment_sys_enter(void *ctx, struct sysc=
all_enter_args *args)
>  	/* copy the sys_enter header, which has the syscall_nr */
>  	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args=
));
> =20
> -	for (int i =3D 0; i < 6; i++) {
> -		written =3D augment_arg(args, i, beauty_map, payload_offset);
> -		if (written < 0)
> -			return 1;
> -		if (written > 0) {
> -			output +=3D written;
> -			payload_offset +=3D written;
> -			do_output =3D true;
> +	if (bpf_ksym_exists(bpf_iter_num_new)) {
> +		bpf_for(i, 0, 6) {
> +			written =3D augment_arg(args, i, beauty_map, payload, output);
> +			if (written < 0)
> +				return 1;
> +			if (written > 0) {
> +				output +=3D written;
> +				/* guide the verifier to forget range of `output`, which
> +				 * helps to prove convergence of the loop
> +				 */

[Severity: Low]
This isn't a bug, but this multi-line comment does not follow the preferred
BPF subsystem style where the opening /* is on its own line.

> +				output +=3D ZERO;
> +				do_output =3D true;
> +			}
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783070132.gi=
t.vmalik@redhat.com?part=3D2
