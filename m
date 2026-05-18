Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10E3845DC
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 04:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079698; cv=none; b=pj/ynVYqQRY/fuOAaZ8oEK6PNgnRqhz9+2od0gXkoQn+7DZcajPfyrKzFhSdEqfvMM9r4aQrddEVmKl+teXOIJRcVjL4weIWQclVT8Aw+ILCIXEVJcc8fHToE1pemZVj6UGF83pvTAymZhwYKjPksMj0SjFejrOHZiyqCDODvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079698; c=relaxed/simple;
	bh=VU9jh2wr26f8EvpDYTAdjzj4PPQHgXEishvsKXfN8FI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WvoxKWCEzo6+XLlwd1+Q/a5jnEkp4pHV6XnnkbJo4kLKvfIamBx9cE281Pyz/6qXX5bXIy9pzZnA/4srdMNABvrGGJdOLDEzuDWAZTNcjxlVt2OEZnPskijWxHylvxJUgRXcHPmUYykjR7qRpg6j5deECXkGPmEtV+TetCj72Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBhg8H74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBhg8H74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F50EC4AF1C;
	Mon, 18 May 2026 04:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779079695;
	bh=VU9jh2wr26f8EvpDYTAdjzj4PPQHgXEishvsKXfN8FI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fBhg8H74TPvxgnFPTB9Ba0ueKesJFuOyvetDx+Fy03PWYnM/9ytSmIYkYSFU4DrR4
	 T3WEPZSVRctiKvic2CRETEw0dyypM71cihIGlQ5U2d37N4kBvmN0mt2zdbU5HqpfLy
	 z8l/GSgeE8f7817yfgacbFlV5DOVIEWeVlDoVKT2ZF9ka9VtRQ28tyaPQe25BXUu6X
	 faKuAbuwcVhSA0TOgRQSFJBoAUb99fxonLYJ0sy+UdU3LFnGqWjdETVx+i+j2RUbYo
	 sa8iqVOi3a4weQr+282TxmVWtcIiRLVP8WXMpfsxEwWlYdhfqpMmLfcyAKu1g73zCD
	 sByB3dF0I3koQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] perf tests: Add test for uncore event sorting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518043140.2522141-2-irogers@google.com>
References: <20260518043140.2522141-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 04:48:14 +0000
Message-Id: <20260518044815.7F50EC4AF1C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unreachable else block in event_cb().
--

commit 73f78d43a9da9383b1db8bb57a775b964c9f8810
Author: Ian Rogers <irogers@google.com>

perf tests: Add test for uncore event sorting

Add a test for uncore event sorting matching multiple PMUs. Uncore PMUs
may have a common prefix, and parsing an event group for those PMUs
should result in correctly sorted evsels.

> diff --git a/tools/perf/tests/uncore-event-sorting.c b/tools/perf/tests/u=
ncore-event-sorting.c
> new file mode 100644
> index 0000000000000..594fe7ff7bf6a
> --- /dev/null
> +++ b/tools/perf/tests/uncore-event-sorting.c

[ ... ]

> +static int event_cb(void *state, struct pmu_event_info *info)
> +{
> +	struct match_state *m =3D state;
> +	char *clean_name;
> +
> +	if (m->event1 && m->event2)
> +		return 1;
> +
> +	clean_name =3D clean_event_name(info);
> +	if (!clean_name)
> +		return 0;
> +
> +	if (!m->event1) {
> +		m->event1 =3D clean_name;
> +	} else if (!m->event2) {
> +		if (strcmp(m->event1, clean_name)) {
> +			m->event2 =3D clean_name;
> +			return 1;
> +		}
> +		free(clean_name);
> +	} else {
> +		free(clean_name);
> +	}

Is this else block unreachable?

Since there is an early return at the start of the function when both
m->event1 and m->event2 are non-NULL, we can only reach this point if at
least one of them is NULL.

If the first branch (!m->event1) is not taken, m->event1 is non-NULL.
If the second branch (!m->event2) is not taken, m->event2 is non-NULL.

This implies both are non-NULL, which would have triggered the early return
at the top of the function, leaving this block as dead code.

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518043140.2522=
141-1-irogers@google.com?part=3D1
