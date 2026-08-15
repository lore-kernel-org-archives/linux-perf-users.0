Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203C39794E
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837822; cv=none; b=IRfMxfXMJjvJxb/vYlOu0ATWXeC9t+cq2tLuNAyATtey5wjZg8ZSmJnu3naFEc+hg4ZMEzytex2ScBsqXpGcT02FF+4CpUzV/+Lno+ZDU88rsPneA4gtfRZ2ek++9E/VyLyHlv0UH50OSdlj47ROCV1m50Te60Jf5vPZX4sk/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837822; c=relaxed/simple;
	bh=gb1q1gcNVhsivzCgqqkEyfknQVHoiBDn6XqXJ520RdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZS9TiFyGjELdAic03JkcgLE32JSP4V/sqR6Y9UHPOB1thMaqOQMVUfQR0070J0HeFE+49jKN+o56EuEWu338F9QsuP9ymdBuDLLXRh2j3EfMEj4mN4tpFq8SBrvCPJxqmwUx8vYGqYsiac/NiJTJR7MTMroVS9J2qy4prE7vMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6Uq/T6O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6Uq/T6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F34A1F000E9;
	Sat, 15 Aug 2026 23:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786837819;
	bh=xKsjflvIzL9NYGC9OcMZ2rRkwT8ToBc0i0l2cfjFWe4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M6Uq/T6OYNOE+395ZUeqLm8Gn54fvxAni5d7QBRKbHdyv3i1YFSWmfR9vosQanSC8
	 GUFE26C55EzG6vBIpvexzJyG2YWJaNvFpZPE9lrxLXFchml4p8OZ63W6L+IvC4/PjP
	 02tkohPmsXffpT9o85t+SMbYLSQckz52pqdUAA7b+VCAzE5m2T4V++taSibYLDCbLp
	 8EbGm9ffALRDjQHIKZGRtetZB3Du8yRtUXkknQJeiKBr404+GxjmvSzUpEX/XTIzcV
	 lC0fcI9Nt00ac/C2SnBPkw6QkYpjDnbw5OJ+fhj63d3X22UMfHDqe6gQ+xxldlEPCQ
	 +xHzzbpgIgD/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next 3/3] perf trace: Enhance BTF type
 formatting to symbolise kernel function pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260815233651.527936-4-atomlin@atomlin.com>
References: <20260815233651.527936-1-atomlin@atomlin.com>
 <20260815233651.527936-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 23:50:18 +0000
Message-Id: <20260815235019.5F34A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] `trace__btf_scnprintf()` calls `syscall_arg__scnprintf_ksym()` w=
ithout `arg->val` being updated, causing kernel function pointers to uncond=
itionally print as "NULL" or display incorrect symbols.
- [Medium] `syscall_arg_fmt__cache_btf_type()` attempts to look up BTF type=
s using raw string matching, which systematically fails for pointer declara=
tions (e.g., `struct task_struct *`).
- [Medium] Replacing `strstr()` with `strstarts()` in `syscall_arg_fmt__cac=
he_btf_type()` breaks BTF type resolution for type strings containing modif=
iers (e.g., `"const enum"`).
- [Medium] `btf_is_func_ptr()` improperly handles pointers targeting typede=
fs or modifiers.
--

--- Patch [3]: [PATCH perf-tools-next 3/3] perf trace: Enhance BTF type for=
matting to symbolise kernel function pointers ---
commit 53acf94abe39f745266994a52d3b39a3f7fa20c2
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Enhance BTF type formatting to symbolise kernel function pointe=
rs
   =20
When BTF metadata is loaded from vmlinux, this commit introduces
btf_is_func_ptr() to identify function prototypes. It generalizes BTF type
caching to handle structs, unions, enums, and function pointers. It also
adds routing to syscall_arg__scnprintf_ksym() to symbolize kernel function
pointers.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 825b16581581b..94dc720a2b3ac 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -974,21 +974,43 @@ static size_t syscall_arg__scnprintf_getrandom_flag=
s(char *bf, size_t size,
>  #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
> =20
>  #ifdef HAVE_LIBBPF_SUPPORT
> -static void syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_=
fmt, struct btf *btf, char *type)
> +static bool btf_is_func_ptr(const struct btf *btf, const struct btf_type=
 *type)
> +{
> +	while (type) {
> +		if (btf_is_ptr(type)) {
> +			type =3D btf__type_by_id(btf, type->type);
> +			return type && btf_is_func_proto(type);

[Severity: Medium]
Will this return prematurely without unwrapping typedefs or modifiers on the
pointer's target type?=20

If a function pointer is defined via a typedef (for example, typedef void
vq_callback_t(struct virtqueue *); vq_callback_t *cb;), does this unwrap
the pointer kind and immediately return false because it doesn't evaluate
subsequent modifiers on the function prototype?

> +		}
> +		if (btf_is_typedef(type) || btf_is_mod(type)) {
> +			type =3D btf__type_by_id(btf, type->type);
> +		} else {
> +			break;
> +		}
> +	}
> +	return false;
> +}
> +
> +static void syscall_arg_fmt__cache_btf_type(struct syscall_arg_fmt *arg_=
fmt,
> +					    struct btf *btf, char *type)
>  {
>  	int id;
> =20
> -	type =3D strstr(type, "enum ");
>  	if (type =3D=3D NULL)
>  		return;
> =20
> -	type +=3D 5; // skip "enum " to get the enumeration name
> +	if (strstarts(type, "enum "))
> +		type +=3D 5;

[Severity: Medium]
Does replacing strstr() with strstarts() break BTF type resolution for type
strings containing modifiers?=20

If a tracepoint argument is defined as const enum, strstarts() evaluates
from the beginning and returns false, leaving the full string intact and
causing the subsequent lookup to fail.

> +	else if (strstarts(type, "struct "))
> +		type +=3D 7;
> +	else if (strstarts(type, "union "))
> +		type +=3D 6;
> =20
>  	id =3D btf__find_by_name(btf, type);

[Severity: Medium]
Will this raw string matching systematically fail for pointer declarations
like struct task_struct *?=20

The code above strips the prefix but leaves the trailing asterisk intact.
Since pointers are anonymous in BTF and structs are named without asterisks,
does this guarantee btf__find_by_name() will fail to find the type?

>  	if (id < 0)
>  		return;
> =20
>  	arg_fmt->type =3D btf__type_by_id(btf, id);
> +	arg_fmt->type_id =3D id;
>  }

[ ... ]

> @@ -1123,6 +1143,8 @@ static size_t trace__btf_scnprintf(struct trace *tr=
ace, struct syscall_arg *arg,
>  		return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
>  	else if (btf_is_struct(arg_fmt->type) || btf_is_union(arg_fmt->type))
>  		return btf_struct_scnprintf(arg_fmt->type, trace->btf, bf, size, arg);
> +	else if (btf_is_func_ptr(trace->btf, arg_fmt->type))
> +		return syscall_arg__scnprintf_ksym(bf, size, arg);
> =20
>  	return 0;
>  }

[ ... ]

> @@ -2566,7 +2588,8 @@ static size_t syscall__scnprintf_args(struct syscal=
l *sc, char *bf, size_t size,
> =20
>  			default_scnprintf =3D sc->arg_fmt[arg.idx].scnprintf;
> =20
> -			if (trace->force_btf || default_scnprintf =3D=3D NULL || default_scnp=
rintf =3D=3D SCA_PTR) {
> +			if (trace->force_btf || default_scnprintf =3D=3D NULL ||
> +			    default_scnprintf =3D=3D SCA_PTR || default_scnprintf =3D=3D SCA_=
KSYM) {
>  				btf_printed =3D trace__btf_scnprintf(trace, &arg, bf + printed,
>  								   size - printed, val, field->type);

[Severity: Medium]
When calling trace__btf_scnprintf() here, the syscall argument val is passed
as a separate parameter, but arg.val is not updated to match val.

In trace__btf_scnprintf(), the code delegates to syscall_arg__scnprintf_ksy=
m()
which expects arg->val to contain the valid address. Will this result in an
uninitialized or stale value being used from arg->val, causing the kernel
function pointer to print as NULL or display incorrect symbols?

>  				if (btf_printed) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815233651.5279=
36-1-atomlin@atomlin.com?part=3D3
