Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4D430301
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579401; cv=none; b=MdY+RMgzGj3JxYdWW6N/YGAY+WofgUqmPiQuQEN1uVQmya0cVHCxp3RCVSeAnuzzmrOBCV9ybvVRnKLhZlqnmAOiI61HU4namlbhg23ydmuYFnxJOcuAHzJp0sFUo3vgBVnU8ufk2eaVV4apDBi3DAaP9ZD3OENr65mrxIq+Rnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579401; c=relaxed/simple;
	bh=BljlE5Zfu5l50pxtibp2aKW/39DEuuWwhhq3NVtuAuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ePFg4NTgnGxkHCAvxBnilIumpDi/Jce7U907iPQ3QqE9jRSF/kQhxcyrtMqwtQ9k412b/iUcMntHnVkaeKlbUpJ5CZWC+NQN/X0oJOTL1GKP03j0Pn7XzMGaviXJE3CEhu7dLqkfgR+c5OQ2TaP8olKXjb/9uzMUKxMFUJ6N7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGgaPyat; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGgaPyat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CFC1F00A3A;
	Mon, 24 Aug 2026 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787579399;
	bh=vOGvsHZzuhUXaK5pcH3JLa2JhUtqSWB/yfyCV+oOtJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XGgaPyatTLXHkqSKrE4qt2KqhMWMVTKV1etdIzABc7iU7W6aNu5oUeJ2ujWirAnnY
	 LKRn9IWhH9jfoDY1XCMr2Ck/avVN13C6zJedgoMiuz/O9pU81JvHjyg0gsplQ31f0i
	 yAHlajwobwEf7ICCKDYezKbPXmwppgoDftHxguPiYQD1rFuXZwljW5j90Ky0/JOdmq
	 /AoazM+9t7gBh/xXPsmRdr72RCMWhCxWTf1m8Swrhje8JkY7ot0JcOOPORgPPu0KFW
	 rExBZHjlZMDflZOmRiJTqzF44Lf7wG72g7kCnaQ92JFHESULDJIt4P1bMOMEfPQxAY
	 iWtn1awI3Ot5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v6 4/5] perf trace: Enhance BTF type
 formatting to symbolise kernel function pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824133122.751733-5-atomlin@atomlin.com>
References: <20260824133122.751733-1-atomlin@atomlin.com>
 <20260824133122.751733-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:49:59 +0000
Message-Id: <20260824134959.98CFC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `btf_struct_scnprintf` function fails to properly validate `au=
gmented_arg->size` against buffer limits and is vulnerable to an integer ov=
erflow, leading to out-of-bounds memory access.
--

--- Patch [4]: [PATCH perf-tools-next v6 4/5] perf trace: Enhance BTF type =
formatting to symbolise kernel function pointers ---
commit c939026eded5d8aaf079b56970d0829b2a8ad559
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Enhance BTF type formatting to symbolise kernel function pointe=
rs

This commit introduces btf_is_func_ptr() to identify function pointers in B=
TF
types. It caches the BTF type in syscall_arg_fmt and routes function pointe=
rs
to syscall_arg__scnprintf_ksym() during BTF pretty-printing.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f6ab7dabfa4c3..d0089230dc5d4 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c

[ ... ]

> @@ -1077,14 +1126,19 @@ static size_t btf_struct_scnprintf(const struct b=
tf_type *type, struct btf *btf,
>  		.bf   =3D bf,
>  		.size =3D size,
>  	};
> -	struct augmented_arg *augmented_arg =3D arg->augmented.args;
> +	struct augmented_arg *augmented_arg;
>  	int type_id =3D arg->fmt->type_id, consumed;
>  	struct btf_dump *btf_dump;
> =20
>  	LIBBPF_OPTS(btf_dump_opts, dump_opts);
>  	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
> =20
> -	if (arg =3D=3D NULL || arg->augmented.args =3D=3D NULL)
> +	if (arg =3D=3D NULL || arg->augmented.args =3D=3D NULL || arg->augmente=
d.size <=3D 0 ||
> +	    arg->fmt =3D=3D NULL || !arg->fmt->from_user)
> +		return 0;
> +
> +	augmented_arg =3D arg->augmented.args;
> +	if (augmented_arg->size <=3D 0)
>  		return 0;
> =20
>  	dump_data_opts.compact	  =3D true;
> @@ -1097,8 +1151,10 @@ static size_t btf_struct_scnprintf(const struct bt=
f_type *type, struct btf *btf,
>  	/* pretty print the struct data here */
>  	if (btf_dump__dump_type_data(btf_dump, type_id,
>  				     arg->augmented.args->value,
> -				     type->size, &dump_data_opts) <=3D 0)
> +				     type->size, &dump_data_opts) <=3D 0) {
> +		btf_dump__free(btf_dump);
>  		return 0;
> +	}
> =20
>  	consumed =3D sizeof(*augmented_arg) + augmented_arg->size;
>  	arg->augmented.args =3D ((void *)arg->augmented.args) + consumed;
>  	arg->augmented.size -=3D consumed;

[Severity: High]
This is a pre-existing issue, but does btf_struct_scnprintf() need upper bo=
und
checks for augmented_arg->size and type->size?

When parsing ring buffer data from a potentially untrusted perf.data file,
augmented_arg->size is read directly from the buffer. While this patch adds
a check for augmented_arg->size <=3D 0, it doesn't enforce an upper bound
against the total available buffer (arg->augmented.size >=3D
sizeof(*augmented_arg) + augmented_arg->size).

Additionally, type->size from BTF is passed to btf_dump__dump_type_data()
without verifying that the available payload is large enough
(arg->augmented.size - sizeof(*augmented_arg) >=3D type->size). Could this =
lead
to out-of-bounds reads if the BTF struct is large but the captured payload
is truncated?

Finally, if a crafted file has an extremely large augmented_arg->size (e.g.,
INT_MAX), could the calculation for consumed overflow the signed int variab=
le
and corrupt the augmented parsing state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824133122.7517=
33-1-atomlin@atomlin.com?part=3D4
