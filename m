Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA923E33D
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777772653; cv=none; b=rzhWhCj32Bp32XZpyae9D3gatgZE6ECtwgCIK/CoPYVbub1X4fYXLLSxRIuhhnaRqMkF74plRRHBzxFwmwGwzGYiVnz3utRphP8ESKweMGU0LKoKEt4Bi9jH7GYE5U4sJWpGn0hakAyXHOC0oh6uEYasElVtQ52TzMJSwre0kxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777772653; c=relaxed/simple;
	bh=BM+TJMOPhP8y3ieKKLFyaytbKPfAZRagChO1nTjT35o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JXH0dLLR3d8EeK3+Xt2A29AJf6q872QWJQhXf6c5xSJoDUYF49xfkFtA8q7nN4kMsAG7f5nbnNl9MtRn+QZmEwRS9IDsBXiwR2FUs/vuKj8cOUbDCOaBjgaOY14QScgQSruZD053Dq3/ASor990ejxc1VciyWh0u38Oci9FtrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qL8ZHsRs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qL8ZHsRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29481C19425;
	Sun,  3 May 2026 01:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777772653;
	bh=BM+TJMOPhP8y3ieKKLFyaytbKPfAZRagChO1nTjT35o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qL8ZHsRs3O4TA4BwRvyH2m7M+YZKy3M26IbwReDSLH2c/6CEAox8xdhH6WDhYgBG4
	 0OfrzrhxjSeUCJmacTP9nU3MVQ6oH0wNDGYA6nzWP9jLFHdnWMSyOrQFNfaNxIUPFF
	 PLJ6N7TZjBfhdLKfpz93wJjl9oGA2JmkqIz8WGTN7uM2QDhRCHTokZrfaqX626gqHd
	 6CmjR1CMUNej0XiIn/aKsQm0RC9HgBtTy+zyf2u2T5uNrFdCcAf5Y88+7sW/3HPqFQ
	 860z1ZDbc4emcV2juc5Lb0+bcQkfYb0iFVcJ1/oujrSDSEDHC/Wa5F6iItRengFxDe
	 PVisQcy4hk77Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] perf annotate-data: Fix libdw API contract
 violations
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503003552.1063540-6-irogers@google.com>
References: <20260503003552.1063540-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 01:44:12 +0000
Message-Id: <20260503014413.29481C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Setting `loc =3D 0` upon `dwarf_formudata` failure silently corrup=
ts struct member offsets for DWARF location expressions.
- [Medium] Redundant validation of `dwarf_diename` introduces dead code and=
 fails to provide the safety claimed in the commit message.
--

commit c23bc4d691e2495e7ddd491d7f1b7b532eb95f50
Author: Ian Rogers <irogers@google.com>

perf annotate-data: Fix libdw API contract violations

This commit adds return value checks for dwarf_aggregate_size and
dwarf_formudata. It also attempts to validate dwarf_diename before calling
strdup to prevent potential crashes.

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index 1eff0a27237d..e881a40a4885 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c

[ ... ]

> @@ -250,9 +251,10 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  	if (dwarf_aggregate_size(&die_mem, &size) < 0)
>  		size =3D 0;
> =20
> -	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr))
> -		dwarf_formudata(&attr, &loc);
> -	else {
> +	if (dwarf_attr_integrate(die, DW_AT_data_member_location, &attr)) {
> +		if (dwarf_formudata(&attr, &loc) !=3D 0)
> +			loc =3D 0;

Since DW_AT_data_member_location can be encoded as a location expression bl=
ock
(such as DW_OP_plus_uconst) rather than just a constant form, dwarf_formuda=
ta
will return an error for those blocks.

Will setting loc to 0 here deterministically corrupt the struct member offs=
ets
for these location expressions?

Should this code perhaps evaluate the location expression block using a hel=
per
like die_get_data_member_location() instead of unconditionally setting it to
0?

> +	} else {
>  		/* bitfield member */
>  		if (dwarf_attr_integrate(die, DW_AT_data_bit_offset, &attr) &&
>  		    dwarf_formudata(&attr, &loc) =3D=3D 0)

[ ... ]

> @@ -273,7 +275,9 @@ static int __add_member_cb(Dwarf_Die *die, void *arg)
>  				     dwarf_diename(die), (long)bit_size) < 0)
>  				member->var_name =3D NULL;
>  		} else {
> -			member->var_name =3D strdup(dwarf_diename(die));
> +			const char *name =3D dwarf_diename(die);
> +
> +			member->var_name =3D strdup(name ?: "unknown");

The commit message states: "Validate dwarf_diename before strdup to prevent
potential crashes."

Looking at the larger context of __add_member_cb(), this block is already
guarded by an outer if statement checking the same value:

    if (dwarf_diename(die)) {
        if (bit_size) {
            ...
        } else {
            const char *name =3D dwarf_diename(die);
            member->var_name =3D strdup(name ?: "unknown");
        }
    }

Does this make the fallback to "unknown" dead code since name is guaranteed
to be non-NULL here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503003552.1063=
540-1-irogers@google.com?part=3D5
