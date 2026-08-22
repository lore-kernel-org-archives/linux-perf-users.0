Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8403890E0
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Aug 2026 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435331; cv=none; b=kAcQn6cCf5drV0Mh+ETvSDqaZn5KM7vpK9zemhjmjzvBdK0zRzsKVbbF98cAh1F2+gvP3e6cr/p2pXt1uKTS2qny0pD+ZA2+rl6jR2VriMx/wBr91JFdDTMfd/zL2+UKh5tPXrO6g1TeuyLC6q6VhhkwDOW6G/t2inh/7dLBg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435331; c=relaxed/simple;
	bh=u9otZUzXL1oiI4nifaten9XtLc1RyZYBb0IFThkNO04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mg4yOVnOTm2gCx5h95BL5ubh6i5aXNBdWJI9lfC6HFU7sXTmCp0E0jEE+eGPL9QyexQSZ6D9iMplPXIJm+rFol+bwdQmFycCiI+gfAFQUG+kj3rz7piexWfM6zz/MkE0r1uUwHmE77JXo0hTUTrBTofPdUdj42vlReY/aMkMM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt/dVX5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt/dVX5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3291F000E9;
	Sat, 22 Aug 2026 21:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787435328;
	bh=eK8inxtVe5zCULNQnp4GWlbAbz1caSYHVYZ3IypPoZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nt/dVX5ljioYeLyXjl92QFeTDDRlekGwZPlKw/rQshTVt9d9/US1bzteGU020BfHo
	 P+teodByagzUFM4Qs7TIzJfboTOVQkHasfCPg3Ou0bsHnC7MBuQampSha+QxCVbWJy
	 a7JcZfBcKR6zceGJLSPkQbpBYZflrVaXxjY1XHBlT08lLG9rQvIki70KUppd248aa0
	 5Ve2WALutsMf9007DhhXWnz5u/CqmGPx2kycHN1WLw8Hx5Sk5KTQnV1MpFtuh2aQun
	 odbkow+6HqM8H4AnByltxvGqaVmFjt/wjU17P/XcN2EWOrE2c6nFC4bfED4z4xnf2B
	 8b/N/HSqbs15Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v5 2/4] perf trace: Auto-assign kernel
 symbol beautifier to function pointer fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260822213558.704018-3-atomlin@atomlin.com>
References: <20260822213558.704018-1-atomlin@atomlin.com>
 <20260822213558.704018-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 21:48:48 +0000
Message-Id: <20260822214848.5D3291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Name-based lookup precedence inversion and flawed pointer size h=
euristic incorrectly classify non-pointer integers and enums as kernel symb=
ols.
- [Medium] Removal of `trace__field_is_ip()` causes oversized IP fields to =
be formatted as signed base-10 integers.
--

--- Patch [2]: [PATCH perf-tools-next v5 2/4] perf trace: Auto-assign kerne=
l symbol beautifier to function pointer fields ---
commit 7d955fc9994a613ba6129e3ae693c4d493643489
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Auto-assign kernel symbol beautifier to function pointer fields

This commit enhances perf trace to automatically assign the SCA_KSYM
beautifier to tracepoint fields conveying function pointers and call sites.
It identifies these fields by their type signature and via a lookup table of
common generic field names.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
[ ... ]
> @@ -2198,38 +2210,52 @@ syscall_arg_fmt__init_array(struct syscall_arg_fm=
t *arg, struct tep_format_field
[ ... ]
>  		} else {
>  			const struct syscall_arg_fmt *fmt =3D
>  				syscall_arg_fmt__find_by_name(field->name);
> =20
>  			if (fmt) {
> -				arg->scnprintf =3D fmt->scnprintf;
> -				arg->strtoul   =3D fmt->strtoul;
> +				if (fmt->scnprintf =3D=3D SCA_KSYM) {
> +					int ptr_size =3D (field->event && field->event->tep) ?
> +						       tep_get_long_size(field->event->tep) :
> +						       (int)sizeof(void *);
> +
> +					if ((field->flags & TEP_FIELD_IS_POINTER) ||
> +					    (field->size =3D=3D ptr_size && !(field->flags & TEP_FIELD_IS_A=
RRAY))) {

[Severity: Medium]
Will this size heuristic mistakenly match non-pointer integer and enum fiel=
ds?

If a tracepoint has a generic-named field like action, location, or handler
that is actually an integer or enum (e.g. 4 bytes), and the architecture's
pointer size is also 4 bytes, this check passes and assigns SCA_KSYM.

If SCA_KSYM is assigned here, the enum BTF resolution logic located in the
subsequent fallback block is entirely skipped:

    if (arg->scnprintf =3D=3D NULL) {
        ...
        } else if (strstr(field->type, "enum") && use_btf !=3D NULL) {
            *use_btf =3D true;
            arg->strtoul =3D STUL_BTF_TYPE;
        }

Could this cause small integer or enum values to be printed as meaningless
hex kernel addresses or NULL instead of their proper symbolic enum names?

> +						arg->scnprintf =3D fmt->scnprintf;
> +						arg->strtoul   =3D fmt->strtoul;
> +					}
[ ... ]
> @@ -3404,14 +3424,11 @@ static size_t trace__fprintf_tp_fields(struct tra=
ce *trace, struct perf_sample *
>  		 * Suppress it by default to avoid cluttering the output.
>  		 * If verbose mode is enabled, ensure it is formatted as a
>  		 * hexadecimal memory address rather than a signed integer.
> -		 *
> -		 * caller_ip and call_site are also expected to be instruction
> -		 * pointers and should always be represented in hexadecimal.
>  		 */
>  		is_probe_ip =3D evsel__is_probe(evsel) && !strcmp(field->name, "__prob=
e_ip");
> =20
> -		if (is_probe_ip || trace__field_is_ip(field->name)) {
> -			if (is_probe_ip && !verbose)
> +		if (is_probe_ip) {
> +			if (!verbose)
>  				continue;

[Severity: Medium]
Does removing trace__field_is_ip() cause oversized IP fields to be formatte=
d as
signed base-10 integers?

By relying entirely on the SCA_KSYM assignment in syscall_arg_fmt__init_arr=
ay(),
we depend on the strict size check:

    if ((field->flags & TEP_FIELD_IS_POINTER) ||
        (field->size =3D=3D ptr_size && !(field->flags & TEP_FIELD_IS_ARRAY=
))) {

If a tracepoint defines an IP field like caller_ip or call_site as a fixed
64-bit integer, but the trace data is processed as 32-bit (where ptr_size
is 4), the size check fails. The field receives no beautifier since
arg->scnprintf will be NULL.

Without the trace__field_is_ip() fallback, won't the default formatter in
syscall_arg_fmt__scnprintf_val() print the raw kernel address as a signed
decimal integer instead of a hex pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213558.7040=
18-1-atomlin@atomlin.com?part=3D2
