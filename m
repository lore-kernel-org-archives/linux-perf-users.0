Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87837C904
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776055939; cv=none; b=UvC+h6BvDSBN1QLj/Nf226mOBcELGzPeaqWHQatMH/gNivkHChdKh487Dx0KxxGEBJ/yb6OeMqIDl3aejCAhOImc4B3tif3fMWUx+psJMJ5yt1C5T0bBziaESAdzRr9GAsuWB9/pLKDiCYtWeGhzR+MLx4dJqYS4fMlxDY95Al0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776055939; c=relaxed/simple;
	bh=XKbf9F4mc3QDX8jcvEbJ1w5D8tXi9CNMIbfKQbc32Tk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Of4Z4hicoUH32hlLF3paPSqe6y8dGl5DGuIMpKa5j+bkD+D3Mjl/UFu9kBfkvAG7hBOx+mLZTiV3tu2yCDKLhe9XGZtNyIIfybtqEUPh1EOHE+c1fF2xpgKG6e9xn7jGBR8hbgZ6fcWqEM1iECvQA437rfi5IewjF7Yrninqa6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Isy6n+5b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Isy6n+5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7075FC116C6;
	Mon, 13 Apr 2026 04:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776055939;
	bh=XKbf9F4mc3QDX8jcvEbJ1w5D8tXi9CNMIbfKQbc32Tk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Isy6n+5bJdZhf5fp6hlJKH5OgoIPqYEx57Yc4L9sTyk1CMQVJuLch+l4mo0tSJV6K
	 5LcQte/6E4Kny65hmidVZ82iyj2j9k4mHlAMAXEA61B4kBCWz83ZW9Pl3xG6HU/hhc
	 CjZWQcKfm3O9XV6mLB1/MWbWXVKFN0+/PmyvIFyCKNVSb07ALh8UcZbe5cBI06Sm1p
	 YGMteUAUy8SnoCFnTlg0vtVxn5gi5H9T1dB0hFmX16Z10U6GbPsTpDR2hi9i+n+RJW
	 fZIlbCJ/MiaZlKUWruAWGJW/L/aKHz/SpW3ELvuvgxjlNrKzwX+pz3f8KHl89pDVl+
	 e8mkd4naqItwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 24/33] perf lock: Avoid segv if event is missing a
 callchain
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413041143.1736055-25-irogers@google.com>
References: <20260413041143.1736055-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 04:52:18 +0000
Message-Id: <20260413045219.7075FC116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The commit overloads the `NULL` return value of `get_callstack()=
` to mean both 'missing callchain' and 'out of memory', causing the caller =
to silently suppress genuine memory allocation failures.
--

commit 2eb0a20f68e00ddc33ffe858af31a1ce762d66da
Author: Ian Rogers <irogers@google.com>
Subject: perf lock: Avoid segv if event is missing a callchain

This commit avoids a segmentation fault when a sample is missing a callchain
by checking for the missing callchain and returning NULL. The caller is
updated to skip the event instead of failing the entire process.

> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 89a40d385b27d..064b3aa4bad75 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -938,9 +938,16 @@ static u64 *get_callstack(struct perf_sample *sample=
, int max_stack)
>  	u64 i;
>  	int c;
> =20
> +	if (!sample->callchain) {
> +		pr_debug("Sample unexpectedly missing callchain\n");
> +		return NULL;
> +	}
> +
>  	callstack =3D calloc(max_stack, sizeof(*callstack));
> -	if (callstack =3D=3D NULL)
> +	if (callstack =3D=3D NULL) {
> +		pr_debug("Failed to allocate callstack\n");
>  		return NULL;
> +	}
> =20
>  	for (i =3D 0, c =3D 0; i < sample->callchain->nr && c < max_stack; i++)=
 {
>  		u64 ip =3D sample->callchain->ips[i];

[ ... ]

> @@ -1059,7 +1066,7 @@ static int report_lock_contention_begin_event(struc=
t perf_sample *sample)
>  	if (needs_callstack()) {
>  		u64 *callstack =3D get_callstack(sample, max_stack_depth);
>  		if (callstack =3D=3D NULL)
> -			return -ENOMEM;
> +			return 0;

Does this overload the NULL return value of get_callstack() to mean both
"missing callchain" and "out of memory"?

Since this now returns 0 when the callstack is NULL, genuine out-of-memory
errors from calloc() will be silently skipped instead of returning -ENOMEM
and safely aborting the process.=20

Under memory pressure, could this result in silently dropping events and
producing incomplete statistics without warning the user?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413041143.1736=
055-1-irogers@google.com?part=3D24
