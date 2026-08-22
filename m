Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAC8386C37
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Aug 2026 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435487; cv=none; b=HNOyAYl74qfljCqIjBg9FD2ZwA30CFsdU/nBLCCcV0LKx6STSR9jhW8LkWa4UpStcrj5xNJQGQPfX71k8hE/1+eAuLSJJxqd8CvaQefh03jKouPGzBMx/um9BYYb09qY6jDsBV3lnKR1PgCMjJQ7VAiG5wI7s7aQAPZBQq3fHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435487; c=relaxed/simple;
	bh=Rtlsi7ePl7LNE6o64lyKFfWCGrYlO8r8EpIP5mNYsHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K1xrl8W4nrNs8KGpWaid0D3JV2wJngoLD0CGvZrbeBLJse6iaQr0PKAQPLZRnJ4ftPHAPcFZXYSSfdkPO+G6ZQHqXUKgTEK487wT74Ziz5rVDz0BtjEM9J+tAE4s9GO6I1Fr+Zr77XIsnVyh8h1qLnoXW05MWvI4GEetbxc4Pus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvK8Xw+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvK8Xw+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353251F000E9;
	Sat, 22 Aug 2026 21:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787435484;
	bh=bu/8O7XzVNDtejD7vXNWg+mYSAXb9t7eEVCLewAx0/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jvK8Xw+vAwiOIolw+Bn6l2wjkGVuzELasnaxmPLgL5mKm4a4bFSlDIZ445BgbaKPt
	 W4EnXFz7Frl9SDfh55N3NEZsxD9BvbKPXe/E/rA3Fk8puISaParQb+qKvCEsNaof47
	 UnQVePtUOOk4t0FPvOujomZlZugwvBzkB6RIHFpczotTMY0i8z+YbskWW954LgFBEe
	 cTC51DTKcUP2aKxgrWBYUgLnFvvMVk+oQbF9ceEV30rNNs6GWT/GWA4fmknf8PyIk/
	 P1Ch7fTCvkXV57qdBS0REdH8NhByPVHZBNNO0KLJdslb7PwydwSZX69+JOMMNIynn6
	 Brlf+ItAygEKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v5 3/4] perf trace: Enhance BTF type
 formatting to symbolise kernel function pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260822213558.704018-4-atomlin@atomlin.com>
References: <20260822213558.704018-1-atomlin@atomlin.com>
 <20260822213558.704018-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 21:51:23 +0000
Message-Id: <20260822215124.353251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Pointers to function pointers (and deeper pointer indirections) =
will be incorrectly symbolized as kernel functions due to greedy unwrapping=
 in `btf_is_func_ptr()` and missing pointer checks in `trace__btf_scnprintf=
()`.

Pre-existing issues:
- [Medium] Incorrect error handling in `btf_struct_scnprintf` causes `arg->=
augmented.args` to be inappropriately advanced on failure, leading to an ou=
t-of-bounds read in fallback formatters.
--

--- Patch [3]: [PATCH perf-tools-next v5 3/4] perf trace: Enhance BTF type =
formatting to symbolise kernel function pointers ---
commit 544922c709767641e98cb8ac1eabf4bff305afea
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Enhance BTF type formatting to symbolise kernel function pointe=
rs

When BTF (BPF Type Format) metadata is loaded from vmlinux, 'perf trace'
can inspect the precise C types of tracepoint and system call parameters.
This patch introduces btf_is_func_ptr() to inspect BTF type hierarchies
to determine whether a parameter resolves to a function prototype.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 10fbea7ed4dbf..4f8b4f2cf677e 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c

[ ... ]

> @@ -979,21 +980,61 @@ static size_t syscall_arg__scnprintf_getrandom_flag=
s(char *bf, size_t size,
>  #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
> =20
>  #ifdef HAVE_LIBBPF_SUPPORT
> -static void syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_=
fmt, struct btf *btf, char *type)
> +static bool btf_is_func_ptr(const struct btf *btf, const struct btf_type=
 *type)
>  {
> +	while (type) {
> +		if (btf_is_ptr(type) || btf_is_typedef(type) || btf_is_mod(type))
> +			type =3D btf__type_by_id(btf, type->type);
> +		else
> +			break;
> +	}
> +	return type && btf_is_func_proto(type);
> +}

[Severity: Medium]
Will this loop eagerly unwrap all pointer modifiers, failing to enforce a
strict single-pointer limit for function pointers?

If perf trace encounters a tracepoint or syscall argument whose type
string contains an asterisk but resolves to a function pointer typedef
(e.g. bpf_callback_t *), wouldn't this greedily unwrap all pointer
indirections, causing pointers to function pointers to be incorrectly
symbolized as kernel functions?

[ ... ]

> @@ -1095,8 +1142,10 @@ static size_t btf_struct_scnprintf(const struct bt=
f_type *type, struct btf *btf,
>  		return 0;
> =20
>  	/* pretty print the struct data here */
> -	if (btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->va=
lue, type->size, &dump_data_opts) =3D=3D 0)
> +	if (btf_dump__dump_type_data(btf_dump, type_id, augmented_arg->value, t=
ype->size, &dump_data_opts) =3D=3D 0) {
> +		btf_dump__free(btf_dump);
>  		return 0;
> +	}
> =20
>  	consumed =3D sizeof(*augmented_arg) + augmented_arg->size;
>  	arg->augmented.args =3D ((void *)arg->augmented.args) + consumed;

[Severity: Medium]
This is a pre-existing issue, but does this error handling correctly check
for negative error codes from btf_dump__dump_type_data()?

If btf_dump__dump_type_data() returns a negative error code (e.g., -EINVAL),
the equality check against 0 evaluates to false. The function incorrectly
proceeds to advance the arg->augmented.args pointer by the consumed struct
size and returns 0.

Then, in syscall__scnprintf_args():

tools/perf/builtin-trace.c:syscall__scnprintf_args() {
    ...
			if (trace->force_btf || default_scnprintf =3D=3D NULL ||
			    default_scnprintf =3D=3D SCA_PTR || default_scnprintf =3D=3D SCA_KSY=
M) {
				btf_printed =3D trace__btf_scnprintf(trace, &arg, bf + printed,
								   size - printed, val, field->type);
				if (btf_printed) {
					printed +=3D btf_printed;
					continue;
				}
			}

			printed +=3D syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
								  bf + printed, size - printed, &arg, val);
    ...
}

Because btf_printed is 0, it falls back to the default formatter
(syscall_arg_fmt__scnprintf_val). Does this fallback formatter then read fr=
om
the erroneously advanced arg->augmented.args pointer (now pointing to the
next argument or past the buffer end), leading to an out-of-bounds memory
access?

[ ... ]

> @@ -1108,33 +1157,37 @@ static size_t btf_struct_scnprintf(const struct b=
tf_type *type, struct btf *btf,
>  }
> =20
>  static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_a=
rg *arg, char *bf,
> -				   size_t size, int val, char *type)
> +				   size_t size, unsigned long val, char *type)
>  {
>  	struct syscall_arg_fmt *arg_fmt =3D arg->fmt;
> =20
>  	if (trace->btf =3D=3D NULL)
>  		return 0;
> =20
> -	if (arg_fmt->type =3D=3D NULL) {
> -		// Check if this is an enum and if we have the BTF type for it.
> -		syscall_arg_fmt__cache_btf_enum(arg_fmt, trace->btf, type);
> -	}
> +	if (!arg_fmt->btf_type_cached)
> +		syscall_arg_fmt__cache_btf_type(arg_fmt, trace->btf, type);
> =20
>  	// Did we manage to find a BTF type for the syscall/tracepoint argument?
>  	if (arg_fmt->type =3D=3D NULL)
>  		return 0;
> =20
> -	if (btf_is_enum(arg_fmt->type))
> +	if (btf_is_enum(arg_fmt->type)) {
> +		if (type && strchr(type, '*'))
> +			return 0;
>  		return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
> -	else if (btf_is_struct(arg_fmt->type) || btf_is_union(arg_fmt->type))
> +	} else if (btf_is_struct(arg_fmt->type) || btf_is_union(arg_fmt->type))
>  		return btf_struct_scnprintf(arg_fmt->type, trace->btf, bf, size, arg);
> +	else if (btf_is_func_ptr(trace->btf, arg_fmt->type)) {
> +		arg->val =3D val;
> +		return syscall_arg__scnprintf_ksym(bf, size, arg);
> +	}
> =20
>  	return 0;
>  }

[Severity: Medium]
Does this branch lack a safeguard for function pointers similar to the enum
check above?

Unlike the strchr(type, '*') check for enums, there is no verification that
the original C type string lacks an extra pointer asterisk. Since
btf_is_func_ptr() greedily unwraps pointer indirections, could a pointer to=
 a
function pointer be mistakenly routed to syscall_arg__scnprintf_ksym(),
resulting in mis-symbolization of the memory address instead of the kernel
symbol?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213558.7040=
18-1-atomlin@atomlin.com?part=3D3
