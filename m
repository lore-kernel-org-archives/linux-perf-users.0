Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18AC3DA5B8
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261174; cv=none; b=P1GP8MRNppX6iD6MUMw1zbFIaqtL4wSJW0V8x09Q543NX05LgOpAYrT5tux09eES5btqnbD3crBBPSNRGv1k7bW0Ve4Vu4G0jqANISEFTTyJApBgctStpwh3bgr7Pff830GSXbGAMpwc8J8rm8kLB4AKoq4dNnBEeYvc4+iUzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261174; c=relaxed/simple;
	bh=HOlSdPiBWUa0QSXXH/ZpFHyVpTwTroqDdbDiJUilX7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YXwD8EaRe7iKavUIu03+g+iEdr1M91tP8hBYZp2DaS86F6RBfYUg5S/HKNi/DnQF60YNB84GIV7R+mSeuAhNZhB09rrfev15ayc38+ZkyU9W3FF/6gItUXzLp8cozyYJDyXlFgtVW5GSjFhqF3tMmx3ckozEdOfm3N6vGveVV2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjN0WyXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjN0WyXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504001F000E9;
	Thu, 20 Aug 2026 21:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787261173;
	bh=l2WJVoA6APBm0hIvtdUnXuq9Alx6cHCOnJlWh9NlLmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MjN0WyXDuHMMuc3Fi3b5eapDp0tKFFkvwC+cNY5IU67Y/ObQ5ZsPhp4OZD5ZUOfhQ
	 hw87E2VAVuySE9p7CmwhjgMh86SqYvvfPDVX2GnYrYGwha6rIfk4+hYIkD+gedMQxH
	 WtfOLQZiLA9C7oVvnoeJe1YSf0R3KnH9Wylh4Dt3EiWISGzD4GuoWm/TnAK+7JFO89
	 FyCXFZQbg7optTLjfMdH5xlad/JhTWqZYiLMrNDcsFiEltGUtarw8gcR0j/umRBmoZ
	 YDcs6t6RGQKzScqX2U0hul6FVme8LSytq6zNk4D3OrdnOaYLQqM2hbBzC8d2Af823H
	 YW+eedArBBN+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v3 2/4] perf trace: Auto-assign kernel
 symbol beautifier to function pointer fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260820211100.649142-3-atomlin@atomlin.com>
References: <20260820211100.649142-1-atomlin@atomlin.com>
 <20260820211100.649142-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 21:26:12 +0000
Message-Id: <20260820212613.504001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Mapping highly generic field names like 'action', 'cb', and 'calle=
r' globally to `SCA_KSYM` short-circuits type-based logic, leaking perf use=
rspace memory addresses instead of strings and breaking integers/enums.
- [Medium] Removal of `trace__field_is_ip()` and omission of `caller_ip` fr=
om the new lookup table causes kernel instruction pointers to be formatted =
as unreadable decimal integers.
--

--- Patch [2]: [PATCH perf-tools-next v3 2/4] perf trace: Auto-assign kerne=
l symbol beautifier to function pointer fields ---
commit d3017d506b83550526e2692582e2544d0b006d0f
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Auto-assign kernel symbol beautifier to function pointer fields

This patch enhances perf trace to automatically format kernel function
pointer fields using the SCA_KSYM beautifier. It detects these fields
by type signature or by matching common function pointer and callback
field names in a lookup table.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 0030489465032..bb8f4fd9ba244 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2096,6 +2096,17 @@ static int syscall__alloc_arg_fmts(struct syscall =
*sc, int nr_args)
>  }
> =20
>  static const struct syscall_arg_fmt syscall_arg_fmts__by_name[] =3D {
> +	{ .name =3D "action",	.scnprintf =3D SCA_KSYM, },
> +	{ .name =3D "call_site",	.scnprintf =3D SCA_KSYM, },
> +	{ .name =3D "callback",	.scnprintf =3D SCA_KSYM, },
> +	{ .name =3D "caller",	.scnprintf =3D SCA_KSYM, },
> +	{ .name =3D "callsite",	.scnprintf =3D SCA_KSYM, },
> +	{ .name =3D "cb",		.scnprintf =3D SCA_KSYM, },

[ ... ]

> @@ -2230,6 +2220,24 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt=
 *arg, struct tep_format_field
>  			if (fmt) {
>  				arg->scnprintf =3D fmt->scnprintf;
>  				arg->strtoul   =3D fmt->strtoul;
> +			} else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->nam=
e, "addr") ||
> +				   field_has_hex_fmt(field, len)) {
> +				arg->scnprintf =3D SCA_PTR;
> +			} else if (strcmp(field->type, "pid_t") =3D=3D 0) {
> +				arg->scnprintf =3D SCA_PID;
> +			} else if (strcmp(field->type, "umode_t") =3D=3D 0) {
> +				arg->scnprintf =3D SCA_MODE_T;
> +			} else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstr(field->type,=
 "char")) {
> +				arg->scnprintf =3D SCA_CHAR_ARRAY;
> +				arg->nr_entries =3D field->arraylen;

[Severity: High]
Does checking syscall_arg_fmt__find_by_name() earlier in this branch,
before the type-based checks like string arrays or BTF enums, short-circuit
those checks for generic field names?

If a field is named "caller", "action", or "cb" but is actually a dynamic
string or integer, it seems this early name match will blindly assign
SCA_KSYM.

Would this cause strings to be printed as raw kernel addresses by passing a
userspace perf pointer to SCA_KSYM, permanently obfuscating the trace data?

[ ... ]

> @@ -3297,12 +3305,6 @@ static unsigned char bitmap_byte(const unsigned lo=
ng *mask, int byte_idx)
>  	return b_val;
>  }
> =20
> -static bool trace__field_is_ip(const char *name)
> -{
> -	return !strcmp(name, "__probe_ip") ||
> -	       !strcmp(name, "caller_ip") ||
> -	       !strcmp(name, "call_site");
> -}

[Severity: Medium]
Since trace__field_is_ip() is removed here, should "caller_ip" have been
added to the new syscall_arg_fmts__by_name lookup table?

Because "caller_ip" is typed as unsigned long (not a pointer), lacks "addr"
in its name, and its TP_printk format strings do not match the strict
=3D0x/=3D%p checks in field_has_hex_fmt(), it evades all heuristics.

Will this cause kernel instruction pointers like "caller_ip" (used heavily
in XFS and OCFS2 tracepoints) to be formatted as unreadable base-10 decimal
integers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820211100.6491=
42-1-atomlin@atomlin.com?part=3D2
