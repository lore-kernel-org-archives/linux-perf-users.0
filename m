Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346F1946BC
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 01:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777772079; cv=none; b=U85QHIKrauV9ARG+pnHKwlgw8dvCw2o8kjklnlvf/KP5ypLxzZWToGoTxqPk4a8W0vPpJJtMWIA9M+QdVoaLVoBnnunGZlRr7BG04+w8Aj/ifJLx88SRhzHQcfFbnivuDKzp/Jf/kFN8+DFT5toggW+CTvTtB8Xs6y1r7mKiJ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777772079; c=relaxed/simple;
	bh=b/EV9kqv6L1nMQZJML5weSrg3gCgOliskP+UTWKzvZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QAC1SJBbQv5+MGJxpwARXLX0hgRSTQ2up+01UrF7rLz6Xny9u2rnKoAD1Yo6GVz3tjQ5hG4Q/dlXl59piZew1LA+jG8/HPP6hbFknZY2irvtapiLF3wjX8WzkWT115t81+BdQRtFdXWSyK1XlHaCXMgHXcfGJdx7wdx/sS3qTnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRW4D9tm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRW4D9tm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1B3C19425;
	Sun,  3 May 2026 01:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777772079;
	bh=b/EV9kqv6L1nMQZJML5weSrg3gCgOliskP+UTWKzvZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KRW4D9tmx1Qv7rRIyYmmDMDR7kIJqm2ttqH4wlmjrV4gLjQBz7c9AxWPhCkM1kAw6
	 khBur+SxS3Sl2x5kz7BWC0RpXkMWJMWNLzo8uksWA+xiSBxTtatMeg49J4vgSigLKv
	 7hqwzvFqato4LQmcwtkOpMNF3IKL3OqssjqRswv3H0sFT0x0TwFFCgWgsp9E8eXMpW
	 RBjeRB6PdWgqNSwM+WMn2QJ6ERTKofVrwQhBJmDjDsksontiLrCGEBDdcreG8lNrW8
	 Z+ppyCc+RmlqaL94oFVrM4Y/zCdmfNxnzs/4RhV8vne/LGp94KIV9oHkh71bxujV7J
	 RlMscE/nAJ3vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] perf probe-finder: Fix libdw API contract
 violations
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503003552.1063540-5-irogers@google.com>
References: <20260503003552.1063540-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 01:34:38 +0000
Message-Id: <20260503013439.0E1B3C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Invalid type formatting for zero-sized structures due to incorrect=
 `dwarf_bytesize` validation.
- [High] Silent failure to resolve line ranges for functions missing the `D=
W_AT_decl_line` attribute.
- [High] NULL pointer dereference when processing array element access for =
variables located in registers.
--

commit c8b3942d25f27ba0aef6a22ab921e206c4971aca
Author: Ian Rogers <irogers@google.com>

perf probe-finder: Fix libdw API contract violations

This commit adds checks for return values from various libdw API calls
to prevent crashes and API contract violations. It also fixes some C90
mixed declarations.

> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finde=
r.c
> index 64328abeef8b..bdef340dfd55 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c

[ ... ]

> @@ -291,7 +296,7 @@ static int convert_variable_type(Dwarf_Die *vr_die,
>  			 probe_type_is_available(PROBE_TYPE_X) ? 'x' : 'u';
> =20
>  	ret =3D dwarf_bytesize(&type);
> -	if (ret <=3D 0)
> +	if (ret < 0)
>  		/* No size ... try to use default type */
>  		return 0;

When processing a zero-sized type (such as an empty struct), dwarf_bytesize
returns 0. With this change, a size of 0 falls through to BYTES_TO_BITS(0)
and formats the type as u0, s0, or x0.

Does the kprobe-events parser support 0-bit basic types, or will it reject
the probe injection?

[ ... ]

> @@ -357,7 +362,13 @@ static int convert_variable_fields(Dwarf_Die *vr_die=
, const char *varname,
>  			else
>  				*ref_ptr =3D ref;
>  		}
> -		ref->offset +=3D dwarf_bytesize(&type) * field->index;
> +		{
> +			int bsize =3D dwarf_bytesize(&type);
> +
> +			if (bsize < 0)
> +				return -EINVAL;
> +			ref->offset +=3D bsize * field->index;
> +		}

This wasn't introduced by this patch, but if an array variable is located in
a register (like DW_OP_reg0), convert_variable_location leaves tvar->ref as
NULL.

Because there is no check to see if ref is NULL before calculating the array
index access offset here, will this result in a NULL pointer dereference and
crash the perf tool?

[ ... ]

> @@ -1794,7 +1819,8 @@ static int line_range_search_cb(Dwarf_Die *sp_die, =
void *data)
> =20
>  	if (die_match_name(sp_die, lr->function) && die_is_func_def(sp_die)) {
>  		lf->fname =3D die_get_decl_file(sp_die);
> -		dwarf_decl_line(sp_die, &lr->offset);
> +		if (dwarf_decl_line(sp_die, &lr->offset) !=3D 0)
> +			return DWARF_CB_OK; // Skip if no line info

The DW_AT_decl_line attribute is not strictly mandatory and can be omitted
by compilers for generated functions.

By returning DWARF_CB_OK when dwarf_decl_line fails, will perf probe -L
silently skip these functions and display no lines, whereas previously it
left the offset at 0 and successfully mapped the line range relative to 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503003552.1063=
540-1-irogers@google.com?part=3D4
