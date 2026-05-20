Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB2313E36
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306325; cv=none; b=EfXfJ8Ox/oYue3NrEMRjvHoibdjwK3i86AdXjNHX7tp+XChIT1Rm8F1cWCmrElyRrLtvPNTpU8idtZcCOgU+rJzKNfnsnJBjl67fOPjuK9tjXjFy/fsjqn7kPHsf5dzCPtcMWAXDq+otOf2ZAQ8NJoYjFRmAdzINCUL7Oa2Mf9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306325; c=relaxed/simple;
	bh=EoGoH+kQ0ipFze0gS9bE3kl+6fYXG/Vet3YPNmGC2b0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZivMCKAjyMY0qMa5Tb1ScWHfIxBr0Yi2NDtEzHCH/sNkiIB9qArR/gsuuZWPJkSB4OBM+71ug7xFb4PzgmIwLhPXm+CZKE3pD/QLS9YFx0gOdNUUk/sx2jGV0GxFoByXav4fOzs8w1lguDRrbKYbPiAMlmnda/LolPAuPBs0HTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY1oQ+Ef; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY1oQ+Ef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733A01F00893;
	Wed, 20 May 2026 19:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779306323;
	bh=CorxJypD7xUmYkTnHUBEpzf550bElUwnkqrXaaYjBcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SY1oQ+EfFFeUbvl5yaVqMZSB378F1eMUGGqxM/byTiD39Air4sXzbVov+HIINBZVj
	 dxtQS5xwlfTfCZLNn5YjT+KDHMIqxjd1mUst+miqszSCaBu8fwwX5wJpppcxSr58Hl
	 tVTV6BCnrAS7JSyh2pT6j/ke67qgHUAF3mPZzDpsEzaaOQr9I94v12DL99YRUan8Vn
	 zNwBW+Jmdo8rWxmxPxUTZHTfOmtll6BfuMCdBZakWuKmOJgSYV5C8dtAzrjdK9FAWs
	 LoF3YIZ67QnKPqr7yTlvKT/Xr/dsJiRSuQXAlpXDWkN9q3EBfY4ahSEeXvGJLijtWp
	 lnw7TOyOdM3Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 23/32] perf lock: Avoid segv if event is missing a
 callchain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520190538.142018-24-irogers@google.com>
References: <20260520190538.142018-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 19:45:23 +0000
Message-Id: <20260520194523.733A01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch conflates a missing callchain condition with a memory =
allocation failure, causing out-of-memory errors to be silently ignored.
--

commit a2151c29777424e46f4107c3691772f24c892171
Author: Ian Rogers <irogers@google.com>

perf lock: Avoid segv if event is missing a callchain

This commit avoids a potential segmentation fault by checking for a
missing callchain pointer in get_callstack(), returning NULL if it is
missing. It also updates the caller to return 0 instead of -ENOMEM when
a NULL callstack is returned.

> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 89a40d385b27d..064b3aa4bad75 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
[ ... ]
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
[ ... ]
> @@ -1059,7 +1066,7 @@ static int report_lock_contention_begin_event(struc=
t perf_sample *sample)
>  	if (needs_callstack()) {
>  		u64 *callstack =3D get_callstack(sample, max_stack_depth);
>  		if (callstack =3D=3D NULL)
> -			return -ENOMEM;
> +			return 0;

[Severity: Medium]
Will this change inadvertently swallow memory allocation failures?

Because get_callstack() returns NULL both when the callchain is missing and
when calloc() fails, returning 0 here means out-of-memory errors will now be
silently ignored and treated as gracefully skipped events.

Should get_callstack() perhaps return an error pointer or an explicit
status code so the caller can distinguish between a missing callchain
(returning 0) and an actual ENOMEM condition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520190538.1420=
18-1-irogers@google.com?part=3D23
