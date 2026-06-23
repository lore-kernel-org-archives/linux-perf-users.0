Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7033D3CFF;
	Tue, 23 Jun 2026 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214749; cv=none; b=qpezFyfwQIF3UsoEAbDxw/mkbQdvDPAe2QfcLaZDaoGbR902/AUY1yXmD+dh+xa+njkQF4R6YNUc2V8gpmIYw6wRUadoGii8VOJvAKErjCW1H2vDtc/XIoP/tyt9N7bY7NcMBjqoljXYJ6KueiRfniOGoAUUfa4VZkr43/E+DAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214749; c=relaxed/simple;
	bh=YfOGm4mePtSHlYGvRQsCo4SePdsUDk2J815DxdmWrak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i6fmLxnHPVsORiLVaq9g7BiwgwI7I4eOgUQWjvk8JU4zxM+WJ+6xLPp+TY67NU1wg1ka30lkb9vwbbx2JuhmnptNP78bvtvnfwSWWhOzbKdnwoUgwtHVRbTxS5ZrbI0oxuncY6YgvMS2JJMbAgBy4JSMNdUmX0zw/grzoNU2e48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0h4zLcH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0h4zLcH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75811F000E9;
	Tue, 23 Jun 2026 11:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782214748;
	bh=I5epRq7EE5p+8L8FlSyYRZumJwLbkHRC1x3t4VFlkOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e0h4zLcHKNaoWkotcWswA38FZkZcLXnP3ZsukmEUj2sKL2GYrojlCvsMaPumZMfiG
	 DMWEqq8y8zRuu/A3mnUVcGqqPh+C0wsPin9OrSc5/xCUP4vk8mGPigBHwbhFhH+bvG
	 4HnlMc3Oyz+5CktSrb6ZGOBHlr6icJ1QI5uJwkcWwSeClqx/KcBzZ371IYiBxJHAQK
	 SSDFG8bzkJ4pqfMA+Lyw5+/1zwwr6ytFbNZXE/SKi3onklSaYB2S2N/m0ga1T7XnMT
	 yLO1djQAlDjPFfzPko62AGUogZVXB87rVoXv89fzitshzkKkzVIipWv+4H5tSd957e
	 5LE3rmFCJFGdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf trace: Refactor augmented_raw_syscalls using
 bpf_loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Viktor Malik" <vmalik@redhat.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260623112533.1151502-1-vmalik@redhat.com>
References: <20260623112533.1151502-1-vmalik@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 11:39:07 +0000
Message-Id: <20260623113907.C75811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Removal of the `aug_size < 0` check causes negative BPF helper e=
rror codes to corrupt the perf event payload and abort tracing.
- [Medium] Truncation of 64-bit syscall buffer lengths to a 32-bit signed i=
nteger silently drops buffer augmentations or bypasses bounds checks.
--

commit 9622318b331a56255744b4baafdc95c2083ba210
Author: Viktor Malik <vmalik@redhat.com>
perf trace: Refactor augmented_raw_syscalls using bpf_loop

This patch refactors the loop body in augment_raw_syscalls into a
callback function to be used with the bpf_loop helper. This helps the
BPF verifier prove termination and avoids -E2BIG load failures.

> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
[ ... ]
> +static long process_arg_cb(u64 i, void *ctx)
> +{
[ ... ]
> +	struct augmented_arg *augmented_arg;
> +	struct args_loop_ctx *loop_ctx;
> +	int aug_size, size, index;
> +	bool augmented;
> +	void *arg;
[ ... ]
> +	if (size =3D=3D 1) { /* string */
> +		aug_size =3D bpf_probe_read_user_str(augmented_arg->value, loop_ctx->v=
alue_size, arg);

[Severity: Medium]
Since bpf_probe_read_user_str() can return a negative error code like
-EFAULT, does the removal of the previous clamping check cause an issue
here?

If a negative error code is assigned to aug_size, it might result in a
negative size being added to offsetof() later, which could abort the loop
prematurely or misalign payload offsets:

    int written =3D offsetof(struct augmented_arg, value) + aug_size;

    if (written < 0 || written > sizeof(struct augmented_arg))
        return 1; /* break */

> +		augmented =3D true;
> +	} else if (size > 0 && size <=3D loop_ctx->value_size) { /* struct */
> +		if (!bpf_probe_read_user(augmented_arg->value, size, arg))
> +			augmented =3D true;
> +	} else if (size < 0 && size >=3D -6) { /* buffer */
> +		index =3D -(size + 1);
> +		barrier_var(index); // Prevent clang (noticed with v18) from removing =
the &=3D 7 trick.
> +		index &=3D 7;	    // Satisfy the bounds checking with the verifier in =
some kernels.
> +		aug_size =3D loop_ctx->args->args[index];

[Severity: Medium]
Does assigning the 64-bit user-provided buffer length to a 32-bit signed
integer (aug_size) cause truncation before bounds checking is performed?

If a length over 2GB is provided, it might wrap to a negative number and
fail the subsequent aug_size > 0 check. Values over 4GB could wrap to small
positive numbers, bypass the max buffer size clamp, and result in capturing
fewer bytes than expected.

> +
> +		if (aug_size > TRACE_AUG_MAX_BUF)
> +			aug_size =3D TRACE_AUG_MAX_BUF;
> +
> +		if (aug_size > 0) {
> +			if (!bpf_probe_read_user(augmented_arg->value, aug_size, arg))
> +				augmented =3D true;
> +		}
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623112533.1151=
502-1-vmalik@redhat.com?part=3D1
