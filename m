Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF8225403
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345896; cv=none; b=crBa5FKgoLZcbaLkinEiegg4Wk9uAqrcbLcpZx5B73S9t2x9qI+Pkhp14nLcGWpqVLc6E/9fZdJhEUpIjIrzI9g3Pa5gU4Dg9i+R6qMjddN6kO/h0IkDq7VlS0z+51lJpJfuSdqotdhkxWYEKdG6FCCMiMT+o2tJqMdpykxxs6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345896; c=relaxed/simple;
	bh=RkQ5uYDiieY+k36NAaLVDmvAb+oq1VMQiCoQ5mUCu9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r5Q8qpMo1jIV/CHslbJluxi3gIxpuOMSGSpXxJWsDHZA/SerTrrPTGsDhF6Sk7MluSahqWdeWNtAtGM8x6bGDTruelnqr24bTkuRpvCqDy2HXWRZ/NpOHdnpRJ+GzGvQo8Nf5BcZGTpWH7vKVomnTO10UGydPuu4ps6Euo3q21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1VgyGKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1VgyGKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DD61F000E9;
	Fri, 21 Aug 2026 20:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787345894;
	bh=ZpPTLwFmWnogI6wmJVrnNwECA4LBie45EmT+pkhmdPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P1VgyGKLXe7VtR1j2uv0ubhe2IPxyuaSZsgUkiBm1zRMtxee2TE7HWTSl45x7IdSp
	 L57qBoICNI5W78EHx0BnotyMs4w7E6pILxFLKaacqWukmf+36C92BbigWg7mYzYfX5
	 dvQvqveaJ5JM3inGxVtpJL93ULfND3iMea7cXr58TT5zctjNP4CEgsg0IhW3actHcA
	 iF5s9eh2lZuD0VGhxNVZ8fmbQcE+q0lOkcEBCgPptgM4SLer0m0fYiQIZCDERmThTb
	 LgsxFChh4YgCqkuH1Yo1E0v3TxjUqmf+B4zWXRi+a1WxLCfRzLqe7An1m8n2d45tC+
	 3dvwzSCmm/3Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v4 2/4] perf trace: Auto-assign kernel
 symbol beautifier to function pointer fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821204930.679027-3-atomlin@atomlin.com>
References: <20260821204930.679027-1-atomlin@atomlin.com>
 <20260821204930.679027-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:58:14 +0000
Message-Id: <20260821205814.60DD61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Using the host's `sizeof(void *)` to validate tracepoint field s=
izes breaks cross-architecture analysis.
- [Medium] The type-based heuristic for function pointers assigns `SCA_KSYM=
` without array safety guards, which can lead to misinterpretation of data =
and leaking of perf's internal heap addresses.
--

--- Patch [2]: [PATCH perf-tools-next v4 2/4] perf trace: Auto-assign kerne=
l symbol beautifier to function pointer fields ---
commit 5464cb16d3d8a0ba80bef02f5451353ddbb24637
Author: Aaron Tomlin <atomlin@atomlin.com>

perf trace: Auto-assign kernel symbol beautifier to function pointer fields

This commit enhances perf trace to automatically assign the SCA_KSYM
beautifier to tracepoint fields conveying function pointers. It uses
heuristics based on both type signatures and field names to detect these
pointers.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 0030489465032..0a12d7b37d8d4 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
[ ... ]
> @@ -2198,38 +2210,47 @@ syscall_arg_fmt__init_array(struct syscall_arg_fm=
t *arg, struct tep_format_field
>  		    ((len >=3D 4 && strcmp(field->name + len - 4, "name") =3D=3D 0) ||
>  		     strstr(field->name, "path") !=3D NULL)) {
>  			arg->scnprintf =3D SCA_FILENAME;
[ ... ]
> +		} else if (field->type && (strstr(field->type, "(*)") !=3D NULL ||
> +					   strstr(field->type, "_func_t") !=3D NULL ||
> +					   strstr(field->type, "_fn") !=3D NULL)) {
> +			arg->scnprintf =3D SCA_KSYM;

[Severity: Medium]
Will this unconditionally assign SCA_KSYM for matching types without checki=
ng
if the field is an array?

If this encounters a tracepoint with an array field whose type matches
the heuristic (like an array of function pointer typedefs),
trace__fprintf_tp_fields() will assign a pointer to the tool's raw heap buf=
fer
to the value.

Since SCA_KSYM is applied without an array guard, it might attempt to resol=
ve
this user-space heap pointer as a kernel symbol, leaking the tool's memory
address in hex instead of printing the trace data.

Could we add a check for !(field->flags & TEP_FIELD_IS_ARRAY) here as well?

>  		} else {
>  			const struct syscall_arg_fmt *fmt =3D
>  				syscall_arg_fmt__find_by_name(field->name);
> =20
>  			if (fmt) {
> -				arg->scnprintf =3D fmt->scnprintf;
> -				arg->strtoul   =3D fmt->strtoul;
> +				if (fmt->scnprintf =3D=3D SCA_KSYM) {
> +					if ((field->flags & TEP_FIELD_IS_POINTER) ||
> +					    (field->size =3D=3D sizeof(void *) && !(field->flags & TEP_FIEL=
D_IS_ARRAY))) {

[Severity: Medium]
Does using sizeof(void *) here break cross-architecture analysis?

When using perf trace on a 64-bit host to process a 32-bit perf.data file f=
or
events that use unsigned long for instruction pointer fields (like caller_i=
p in
XFS tracepoints), field->size in the trace will be 4.

This fails the sizeof(void *) check, which evaluates to 8 on the 64-bit hos=
t,
preventing the expected symbol resolution.=20

Can we rely on the trace data's pointer size instead of the host's, or use a
different heuristic?

> +						arg->scnprintf =3D fmt->scnprintf;
> +						arg->strtoul   =3D fmt->strtoul;
> +					}
> +				} else {
> +					arg->scnprintf =3D fmt->scnprintf;
> +					arg->strtoul   =3D fmt->strtoul;
> +				}
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821204930.6790=
27-1-atomlin@atomlin.com?part=3D2
