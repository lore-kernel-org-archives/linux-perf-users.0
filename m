Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4F33C4557
	for <linux-perf-users@vger.kernel.org>; Sun, 16 Aug 2026 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786914709; cv=none; b=l+f1YgxpCk9kYrnwc4NSuxld5jO5KtmmhuDIYZAL8om5nDsZZYP1J7cWBpfcHtl/6rMTmnnU26+5GglBDNuSF+6aFqEcFI8G3AdsnBUpTVC6ASSASKSvkVHGYMQOSx0LElrttrnEkIQj3FKy3Ui3WJZ8ufCo5lVytOQHWCV+pj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786914709; c=relaxed/simple;
	bh=TGR+HV1G+w+JdZ7c2WZUqkvX+AZ3Df+oj3EQmXQYE5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q3lCnmfWYKOdSuH/G1soOQuXN2s6NMdWaXkwmZSvOjAFiYRGz11AlnK6PI6wuR7oFxVYTlBknKgR6R8M3QHnot/GdIGWz6MKSht0c7dZoHQiSsLWlUBgpulWYcvhYpch2y58fBS9NtMAEdRCUy9tOul4QPhWWUhnNjisZqP8M10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc8CoHUh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc8CoHUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E5F1F000E9;
	Sun, 16 Aug 2026 21:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786914707;
	bh=bVgZP5m2DShW9J+3ifUFFq/DzBRrbkMbJCEYtSXPfu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nc8CoHUhdVo7fYlJxaRegCOq8AP21fs0mUlgP8dHNGR37xjkXY6EqzEdcCAq5q9xx
	 h976fbC3hyqMu1iQVjDHhIpJFPpGU1mivkSz+7u+2WFOrhY0hllYO1UqcMB0W+ajZx
	 wIjGKpS/rv8r/xoBknSzKODCNIl9sSt11A0iHEZ1aWjkl/mYtd6mHDqERjvAhoTcP6
	 DPz3OkbMmr+MWYa70IHcdf5+qWSnB8+ofzsh+iEdQ1J9HBDnnngylCBy4sjIaN8Qrr
	 g6pFvBt/Gxcpq2UxQS1E/ZB+4zyynHIGK/FtDPOxgFPiNSFfyl8gagA8Da5vqtu9d7
	 1FjVODpQ2fZQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v2 3/4] perf trace: Enhance BTF type
 formatting to symbolise kernel function pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260816205921.576365-4-atomlin@atomlin.com>
References: <20260816205921.576365-1-atomlin@atomlin.com>
 <20260816205921.576365-4-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 21:11:46 +0000
Message-Id: <20260816211147.26E5F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] `syscall_arg_fmt__cache_btf_type()` causes severe performance degr=
adation due to un-cached O(N) BTF lookups for standard C types.
- [Medium] Pointers to enums are incorrectly evaluated as enum values, lead=
ing to silent truncation and invalid enum string formatting.
- [Medium] Function pointer symbolization silently fails for inline functio=
n pointers and pointers to function prototype typedefs.
--

--- Patch [3]: [PATCH perf-tools-next v2 3/4] perf trace: Enhance BTF type =
formatting to symbolise kernel function pointers ---
commit 78dc038d874ecff66ce4494a6bee179567d6b15e
Author: Aaron Tomlin <atomlin@atomlin.com>
perf trace: Enhance BTF type formatting to symbolise kernel function pointe=
rs

This commit introduces btf_is_func_ptr() to inspect BTF type hierarchies
to determine if a parameter is a function prototype. It generalizes BTF
type caching to handle various types via syscall_arg_fmt__cache_btf_type(),
allowing for automatic symbolization of kernel function pointers in
perf trace.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 85abae09d328b..cb3cb877a22e9 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -979,21 +979,61 @@ static size_t syscall_arg__scnprintf_getrandom_flag=
s(char *bf, size_t size,
>  #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
> =20
>  #ifdef HAVE_LIBBPF_SUPPORT
> -static void syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_=
fmt, struct btf *btf, char *type)
> +static bool btf_is_func_ptr(const struct btf *btf, const struct btf_type=
 *type)
>  {
> +	bool has_ptr =3D false;
> +
> +	while (type) {
> +		if (btf_is_ptr(type)) {
> +			has_ptr =3D true;
> +			type =3D btf__type_by_id(btf, type->type);
> +		} else if (btf_is_typedef(type) || btf_is_mod(type)) {
> +			type =3D btf__type_by_id(btf, type->type);
> +		} else {
> +			break;
> +		}
> +	}
> +	return has_ptr && type && btf_is_func_proto(type);
> +}

[Severity: Medium]
Will this reliably detect function pointers if the pointer modifier was
stripped during parsing?

If a parameter is an inline function pointer (e.g., void (*cb)(int)) or a
pointer to a function prototype typedef (e.g., foo_t *cb), the string
extraction in syscall_arg_fmt__cache_btf_type() strips the pointer and
punctuation.

For foo_t, it resolves to a typedef of a prototype, so btf_is_func_ptr()
evaluates has_ptr =3D false since the pointer aspect was stripped. Symboliz=
ation
only seems to work for typedefs that intrinsically encapsulate the pointer.

> +
> +static void syscall_arg_fmt__cache_btf_type(struct syscall_arg_fmt *arg_=
fmt,
> +					    struct btf *btf, const char *type)
> +{
> +	char name[128];
> +	const char *pos;
> +	size_t len =3D 0;
>  	int id;
> =20
> -	type =3D strstr(type, "enum ");
>  	if (type =3D=3D NULL)
>  		return;
> =20
> -	type +=3D 5; // skip "enum " to get the enumeration name
> +	if ((pos =3D strstr(type, "enum ")) !=3D NULL)
> +		pos +=3D 5;
> +	else if ((pos =3D strstr(type, "struct ")) !=3D NULL)
> +		pos +=3D 7;
> +	else if ((pos =3D strstr(type, "union ")) !=3D NULL)
> +		pos +=3D 6;
> +	else
> +		pos =3D type;
> +
> +	while (isspace(*pos))
> +		pos++;
> +
> +	while ((isalnum(pos[len]) || pos[len] =3D=3D '_') && len < sizeof(name)=
 - 1) {
> +		name[len] =3D pos[len];
> +		len++;
> +	}

[Severity: Medium]
Does extracting only alphanumeric characters incorrectly strip pointer
modifiers and function pointer structures?

If a traced syscall takes an argument of type enum foo *, this logic extrac=
ts
only the alphanumeric words, stripping the pointer modifier. This causes the
parameter to resolve to the base BTF_KIND_ENUM type rather than a pointer.

> +	name[len] =3D '\0';
> =20
> -	id =3D btf__find_by_name(btf, type);
> +	if (len =3D=3D 0)
> +		return;
> +
> +	id =3D btf__find_by_name(btf, name);
>  	if (id < 0)
>  		return;
> =20
>  	arg_fmt->type =3D btf__type_by_id(btf, id);
> +	arg_fmt->type_id =3D id;
>  }

[Severity: High]
Does this logic lead to repeated, expensive searches if a type is not found?

If btf__find_by_name() fails to find a type (which it does for standard C t=
ypes
like unsigned long or void *), arg_fmt->type remains NULL.

trace__btf_scnprintf() checks if arg_fmt->type is NULL and repeatedly calls
syscall_arg_fmt__cache_btf_type():

trace__btf_scnprintf() {
    ...
    if (arg_fmt->type =3D=3D NULL) {
        syscall_arg_fmt__cache_btf_type(arg_fmt, trace->btf, type);
    }
    ...
}

This results in an un-cached linear search over all kernel BTF types for ev=
ery
single trace event when a type is not found, potentially causing a severe
performance regression.

[ ... ]

> @@ -1108,7 +1147,7 @@ static size_t btf_struct_scnprintf(const struct btf=
_type *type, struct btf *btf,
>  }
> =20
>  static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_a=
rg *arg, char *bf,
> -				   size_t size, int val, char *type)
> +				   size_t size, unsigned long val, char *type)
>  {
>  	struct syscall_arg_fmt *arg_fmt =3D arg->fmt;
> =20
> @@ -1116,8 +1155,7 @@ static size_t trace__btf_scnprintf(struct trace *tr=
ace, struct syscall_arg *arg,
>  		return 0;
> =20
>  	if (arg_fmt->type =3D=3D NULL) {
> -		// Check if this is an enum and if we have the BTF type for it.
> -		syscall_arg_fmt__cache_btf_enum(arg_fmt, trace->btf, type);
> +		syscall_arg_fmt__cache_btf_type(arg_fmt, trace->btf, type);
>  	}
> =20
>  	// Did we manage to find a BTF type for the syscall/tracepoint argument?
> @@ -1128,13 +1166,17 @@ static size_t trace__btf_scnprintf(struct trace *=
trace, struct syscall_arg *arg,
>  		return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);

[Severity: Medium]
Can this truncate a pointer address to 32 bits?

Since val is an unsigned long (64 bits), passing it to btf_enum_scnprintf()
which takes an int truncates the value.

If an argument of type enum foo * had its pointer modifier stripped by
syscall_arg_fmt__cache_btf_type(), this will silently truncate the pointer
address to 32 bits. If the truncated value happens to match an enum member,=
 it
incorrectly displays the enum string instead of the pointer address.

>  	else if (btf_is_struct(arg_fmt->type) || btf_is_union(arg_fmt->type))
>  		return btf_struct_scnprintf(arg_fmt->type, trace->btf, bf, size, arg);
> +	else if (btf_is_func_ptr(trace->btf, arg_fmt->type)) {
> +		arg->val =3D val;
> +		return syscall_arg__scnprintf_ksym(bf, size, arg);
> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816205921.5763=
65-1-atomlin@atomlin.com?part=3D3
