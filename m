Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60042D594F
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837659; cv=none; b=CFtk72KbyK/jGLEmt+GBqauXH4+gOpb7eoVXj8Ehwi9KDew4mEj31qWkD1vWbM2oQ4p3WXPhzf21l4OwUbSW+9Bccw9GsN3eszyGCSd7ddxG0bqINWrIvBInjsG8rILHq7rskWSfKrfK0zUfskr5zeL8FcFfxu7TCFjV2AJZ0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837659; c=relaxed/simple;
	bh=fJaY44DgKlJOqIYxUpGHt2jcY707NZplmWI42Gi6c7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C5slcJsCIfEcMyLW1CbpEiFOd/fZWqvVwLRPq6dxbNH8V3vA4GfsGnovWnBGXnbn1olFGUOpxPHnO5RwuqWIs4bKgmtaz+i9KI32GuaGGq8anciAUIejJsYeTAXURoBQVTvT6FFT3pDGInNngms77ImpIi7YVhRlB/B8HMZn7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDSpS4Jn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDSpS4Jn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393B21F000E9;
	Sat, 15 Aug 2026 23:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786837658;
	bh=LxS/yZo43a+ofwbxmsvHQIf2oxC/Ec8Ur8PyPAuBQ+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UDSpS4JnxHz85pXUeNag4qeP5KOUgHUL4eZRSs4Pfn54CAARQcGysFUs/IgVH0zHn
	 RlI8DK2yKcfku8Zowee71OexCwhOxZsVxcw+bdUN0dZu0KlsF0+Cid88IPGkRuCw21
	 XRfQKeaIs06kPl2N4Qn7YnW8R7Ec6YPwja56GRJlZEOl2mJ4+3asycfRL7E24YNu07
	 XeaNB8xaCW837V4nkwWLjo6Y+ngupBEUWmuJ6o1gkQGrGZK5T2ZAHHrlaJPogLW4zU
	 9YSgfQcd14mvp0tsJRBFx79anFvAneawACq2JTtAgADyYwnl0EPe+b42PT7MZ096jd
	 SYBrdGa+7WJVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next 2/3] perf trace: Auto-assign kernel
 symbol beautifier to function pointer fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260815233651.527936-3-atomlin@atomlin.com>
References: <20260815233651.527936-1-atomlin@atomlin.com>
 <20260815233651.527936-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 23:47:37 +0000
Message-Id: <20260815234738.393B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Overly broad name-matching heuristics in `syscall_arg_fmt__init_=
array()` unconditionally intercept non-function pointer fields, corrupting =
trace output.
- [Medium] Handling of the `work` field fails to symbolize pointers as inte=
nded while corrupting unrelated non-pointer integer fields.
- [Low] Redundant entries added to the `syscall_arg_fmts__by_name` lookup t=
able are completely unreachable dead code.
--

--- Patch [2]: [PATCH perf-tools-next 2/3] perf trace: Auto-assign kernel s=
ymbol beautifier to function pointer fields ---
commit e41ca802a20df2b74611c38302bea036b4cc9f1f
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Auto-assign kernel symbol beautifier to function pointer fields

This patch enhances syscall_arg_fmt__init_array() to detect kernel function
pointers and assign SCA_KSYM as their default beautifier. It also registers
common function pointer field names in the syscall_arg_fmts__by_name lookup
table to automatically symbolize them.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 102221b301a54..825b16581581b 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2091,8 +2091,13 @@ static int syscall__alloc_arg_fmts(struct syscall =
*sc, int nr_args)
>  }
> =20
>  static const struct syscall_arg_fmt syscall_arg_fmts__by_name[] =3D {
> +	{ .name =3D "action",	.scnprintf =3D SCA_KSYM, },
> +	{ .name =3D "callsite",	.scnprintf =3D SCA_KSYM, },
> +	{ .name =3D "fn",		.scnprintf =3D SCA_KSYM, },
> +	{ .name =3D "function",	.scnprintf =3D SCA_KSYM, },

[Severity: Low]
Are these lookup table entries reachable?=20

In syscall_arg_fmt__init_array(), there is an else-if block added by this
patch that explicitly intercepts these exact field names. It appears these
lookup table entries would never be evaluated for these strings.

>  	{ .name =3D "msr",	.scnprintf =3D SCA_X86_MSR,	  .strtoul =3D STUL_X86_=
MSR,	   },
>  	{ .name =3D "vector",	.scnprintf =3D SCA_X86_IRQ_VECTORS, .strtoul =3D =
STUL_X86_IRQ_VECTORS, },
> +	{ .name =3D "work",	.scnprintf =3D SCA_KSYM, },

[Severity: Medium]
Does this correctly symbolize work pointers, and could it inadvertently
corrupt unrelated non-pointer integer fields?

For workqueue tracepoints where the work field is a pointer, it appears it
will be intercepted earlier in syscall_arg_fmt__init_array() by the
(field->flags & TEP_FIELD_IS_POINTER) check. That check assigns SCA_PTR=20
instead of allowing the field to reach this lookup table.

Conversely, for tracepoints like napi_poll that have a non-pointer integer
field named "work", the pointer check is skipped, allowing it to hit this
lookup table. Wouldn't this assign SCA_KSYM to the integer, causing it to
erroneously print as a hex pointer or NULL instead of a decimal number?

[ ... ]

> @@ -2193,6 +2198,14 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt=
 *arg, struct tep_format_field
>  		    ((len >=3D 4 && strcmp(field->name + len - 4, "name") =3D=3D 0) ||
>  		     strstr(field->name, "path") !=3D NULL)) {
>  			arg->scnprintf =3D SCA_FILENAME;
> +		} else if (strcmp(field->name, "fn") =3D=3D 0 ||
> +			   strcmp(field->name, "function") =3D=3D 0 ||
> +			   strcmp(field->name, "callsite") =3D=3D 0 ||
> +			   strcmp(field->name, "action") =3D=3D 0 ||
> +			   (field->type && (strstr(field->type, "(*)") !=3D NULL ||
> +					    strstr(field->type, "_func_t") !=3D NULL ||
> +					    strstr(field->type, "_fn") !=3D NULL))) {
> +			arg->scnprintf =3D SCA_KSYM;

[Severity: Medium]
Does this unconditional name matching affect non-pointer integer fields
that happen to share these generic names?=20

If a tracepoint has an integer field named "action" or "function" (which
can occur in subsystems like btrfs, power, or xfs), wouldn't this assign
SCA_KSYM to it regardless of its actual type?=20

This might cause perf trace to treat simple integers as kernel addresses,
failing to resolve a symbol and formatting them incorrectly.

>  		} else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name=
, "addr") ||
>  			   field_has_hex_fmt(field, len))
>  			arg->scnprintf =3D SCA_PTR;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815233651.5279=
36-1-atomlin@atomlin.com?part=3D2
