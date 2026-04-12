Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9A1156F45
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775960739; cv=none; b=bnps0AhRI3X6zHL9zKwlDjF3s1yS+HLhsWi0izgRsfrLJ90g9VU4ZwX28KE0ScGBJTlZu9iEQxUGiiTkDtUR0V558PM7msouNHjweX6xMvt524EYVX9wamazT/AS+Jxvt5jmcb1JCZIfTY8c31HTTiDohdGZHOfdY4h7gJ5+S5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775960739; c=relaxed/simple;
	bh=dOAFe1ZYuR8vRsXMxGENIEaUoSjel817fwekn4nHYvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pBE+lFGr/cayj4pW/D6MCoZj7m9vVbwqDGJtKBva/Q3NCHk7HZ3KaJc4qTZIhq2UQlsi2RRGBmmgZMYkRHhllc6EPgi5a2GFNy/3flyb5UVq5nYMlrU/RewGD4IgFImrPDD6cP9pzQGnhrsyRL/bh91JSC8qyIu9T3bGZ/l3txE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt05ILjV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt05ILjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830B4C116C6;
	Sun, 12 Apr 2026 02:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775960738;
	bh=dOAFe1ZYuR8vRsXMxGENIEaUoSjel817fwekn4nHYvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Zt05ILjV8PY9+t0nRgm2uJ7rmnjHpZzhCC6aLPqO06ggYHKdjyGRjPsPBS+1hTVOK
	 Ru+v6Fz2yEUMthFgKbPBmpyI5uFNgHfeQK9k5UruK0bGgx+dg+WlIdeFJduZThd8eV
	 h9Bt55/cMboJPyJFIkZE2nI1y9RFHuWBwDJp3rMzyoQ9CZmTn4kL1kvThGNERQ1eV6
	 bw+FjErnxxumbrhicyBQ5TYWHzlwWleqmvMC8m6tHx9mjj2h7ERmtqQxaa9xklIXVa
	 nadpi6z2QBs0YZLghb5+FiXoHz1KCaROwTFC4RJTLN2DD0FydI52v7D9bmAHm8HxZd
	 sOuUBYtqIS8HQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/29] perf lock: Only pass sample to handlers
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260412020833.641177-8-irogers@google.com>
References: <20260412020833.641177-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Apr 2026 02:25:37 +0000
Message-Id: <20260412022538.830B4C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Out-of-memory errors from get_callstack() are silently swallowed.
--

commit 4d8eb4c521b8cbbd581b94a51ae57655ebd7ab69
Author: Ian Rogers <irogers@google.com>
perf lock: Only pass sample to handlers

This commit removes the unused evsel parameter from lock event handlers and
adds a NULL check for sample->callchain in get_callstack().

> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index e2b585e528aca..fcc33089b9455 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
[ ... ]
> @@ -948,9 +938,16 @@ static u64 *get_callstack(struct perf_sample *sample=
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
> @@ -1070,7 +1066,7 @@ static int report_lock_contention_begin_event(struc=
t evsel *evsel __maybe_unused
>  	if (needs_callstack()) {
>  		u64 *callstack =3D get_callstack(sample, max_stack_depth);
>  		if (callstack =3D=3D NULL)
> -			return -ENOMEM;
> +			return 0;

Does this inadvertently swallow the memory allocation failure from
get_callstack()?

Since get_callstack() returns NULL both when the callchain is missing and
when calloc() fails, changing this return from -ENOMEM to 0 means the tool
will now silently drop events when memory is exhausted instead of propagati=
ng
the error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260412020833.6411=
77-1-irogers@google.com?part=3D7
