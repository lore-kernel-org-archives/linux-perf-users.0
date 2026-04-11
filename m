Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B53EAC7
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775936871; cv=none; b=LuiFbaQgke6Us1OiDtK0edefjP66lfnywH/WvLhCQ4Iq6W97Vq114kosRGgh6nQCRqGGpBYiHqMp5HXVda1eYy0Y2PeHcq7u8pmL8jJVz8Iscwj5wNvw6KAv4+aKVGf4AIATMoXtTbGlJJgxxfdAQwLM+YDFcH/R1aLj8O9jH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775936871; c=relaxed/simple;
	bh=qm38EoPIuLGhnfSns7Bk2xFJsyAmcgEA2sIxYWsx4q8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ao9C2BieVG3iIGfEPsnjUNCwNXUG8/t751VFpUnhkasQFeCDQ7vgtQ5xKRHq7Ds8j06ncW6G1FiKzwD4UkobQo0bZMbdHX/7BfCHk3SXW3dQr9vVdNAignsYP/Zd6Oj8QV7l/7vqOr5y2I1P0ywzuUZHwYjKcHzqApiZ6LQ6GfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ5YHtPl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ5YHtPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836FCC2BCAF;
	Sat, 11 Apr 2026 19:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775936871;
	bh=qm38EoPIuLGhnfSns7Bk2xFJsyAmcgEA2sIxYWsx4q8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QZ5YHtPl4dZBP8NCVk2t4qDsT1i0kTgHzw8LZBHtv8uAU1XefPy5eBzvpgYj45QUA
	 9tZ8fjs7FvtK0MAsXdvzioyo88KwQ8YxHgBVTDIkdhVve9ctEFppjDQ4HVAFZumO02
	 euDoho0iNnAQf/Y4Tba5B0OsdLhVRaUkajQa809w+W0JYvpQxccWZk5zLJOCdpzhT/
	 WvFdKOFLq00e0qO64xDZ6TK4NlR91f2VMF3yV8ptRGoXpuplQ9uZAJSKHeEPhJ47XS
	 d1R/DXSSaGAjSEtJhB45Xht/fSu7FIqvs0VRe5XvITsuoiPIhOL1oIyBNp1FB3MZvL
	 tLzoJxRPm835Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/29] perf lock: Only pass sample to handlers
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411191710.524998-8-irogers@google.com>
References: <20260411191710.524998-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 19:47:51 +0000
Message-Id: <20260411194751.836FCC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] get_callstack() incorrectly caches an empty callstack if the fir=
st sample lacks a callchain, permanently hiding the lock's callstack.
--

commit 49c5d291bcdc6ef932bccd0415609f2f21a5cbc8
Author: Ian Rogers <irogers@google.com>

perf lock: Only pass sample to handlers

The evsel is within the sample, so only the sample needs to be passed
to the handlers. This commit removes the evsel parameter from handlers
and fixes call sites. It also adds an additional NULL check in
get_callstack().

> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index e2b585e528aca..2a6fc4c97dcdb 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
[ ... ]
> @@ -949,8 +939,8 @@ static u64 *get_callstack(struct perf_sample *sample,=
 int max_stack)
>  	int c;
> =20
>  	callstack =3D calloc(max_stack, sizeof(*callstack));
> -	if (callstack =3D=3D NULL)
> -		return NULL;
> +	if (callstack =3D=3D NULL || !sample->callchain)
> +		return callstack;
> =20
>  	for (i =3D 0, c =3D 0; i < sample->callchain->nr && c < max_stack; i++)=
 {
>  		u64 ip =3D sample->callchain->ips[i];

Will this cause get_callstack() to return an empty allocated array when
the sample lacks a callchain?

If the first sample for a lock doesn't have a callchain,
report_lock_contention_begin_event() will permanently assign this empty
array to ls->callstack:

	if (needs_callstack()) {
		u64 *callstack =3D get_callstack(sample, max_stack_depth);
		if (callstack =3D=3D NULL)
			return -ENOMEM;

		...

		if (ls->callstack =3D=3D NULL)
			ls->callstack =3D callstack;
		else
			free(callstack);

Would later samples with valid callchains then be freed instead of updating
the empty ls->callstack, permanently hiding the callstack for that lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411191710.5249=
98-1-irogers@google.com?part=3D7
