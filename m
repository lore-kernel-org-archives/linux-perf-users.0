Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3617583AD0
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906215; cv=none; b=CwV+7SxhXiwToS5x8XoSjR+gWLgZVkx1d3WytEfJPjeI6XbzLk2O0jjkJaLNW5vsHBY0ews+tenKH5F6j5o+c6H3kJRpjeRe5x6C6WmFkZ2e7Ap79O/kYzCreZgVSRNZPXCBHHw+ohoZp93oVdwXvHkEYX03COkhUlP0Dv0Rtf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906215; c=relaxed/simple;
	bh=Rl8OMoJb5V7kJbKIcjfGmhFJeGeXHCJXaAw6pU3yuaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dr+cYiN2RXCkqOq+fTDpZgVPOjRnasHkmxwYPJQST/ZMPBvQ5lvQh019Ieflsb3pV5yGV2kjoIf/yyx1YURYGferi9jJ5CnUVxpgc9RIxihCI2w8WZJ6/AW1Y+wkXCEcZzpLcBKW3hxsHdPM6rriNd6Dg23XJ/GHNqpKqetTIb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2hZlgTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2hZlgTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4B51F00A3A;
	Tue,  8 Sep 2026 22:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788906214;
	bh=7anlpBNE6c+I89c4HVpVZnVrQVxYN7ZXdMkCh0NCa8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R2hZlgTmICZFwYX3m4c+EvObr6FMc8vcxjIBh7uULru2nstuJR6utg3x6xy6h+ZNo
	 aRi8WTE6Y0q/GEwsZ+y7OUvgi6EcPxU6DwhK6OVwnCbjl/1sl6Z+hvtU6A2T+6wciq
	 3fT6r2b5PWYo5s0yotheTrgdgfTGMfMI/tXejIPWB2Q8iH7hVm2VeiZdqRo45frma6
	 ArgO5xLuMTwDCUa1gL7RND9ElC2BZYqtHsP1yzlHkeZQ9tdY2njjJtFjFKZEWRnHVG
	 lPZJQwx8A8xahiYfAZNXJhSTlEZwMGisDASncX9njX5tiuNBz9wQodLFjI4y2KfxAU
	 fxzKyI1nGUsMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf stat: Avoid uninitialized memory read on error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260908220720.564614-1-irogers@google.com>
References: <20260908220720.564614-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:23:33 +0000
Message-Id: <20260908222333.DC4B51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Atomic Conclusion: Unchecked ERR_PTR from hashmap__new() causes pr=
edictable application crashes. The return value is incorrectly checked agai=
nst NULL instead of IS_ERR().
--

commit 525c560536a62c39331ec585b1ce897decf7179c
Author: Ian Rogers <irogers@google.com>

perf stat: Avoid uninitialized memory read on error
   =20
If has_supported_counters fails then msg was passed to ui__error
regardless of whether an error was written into msg leading to reading
uninitialized memory. Avoid this by always terminating msg at
initialization.

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index c50cf230f16ed..37752d6bfef45 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I noticed that the return
value of hashmap__new() is incorrectly checked against NULL instead of
IS_ERR().

Since hashmap__new() returns an ERR_PTR on failure, this will
cause predictable crashes under memory pressure instead of graceful error
handling.

For example, in tools/perf/util/pmu.c:perf_pmu__init():

        pmu->aliases =3D hashmap__new(aliases__hash, aliases__equal, /*ctx=
=3D*/ NULL);
        if (!pmu->aliases)
                return -ENOMEM;

And similarly in tools/perf/util/pmu.c:perf_pmu__create_placeholder_core_pm=
u():

        pmu->aliases =3D hashmap__new(aliases__hash, aliases__equal, /*ctx=
=3D*/ NULL);
        INIT_LIST_HEAD(&pmu->caps);

Also in tools/perf/util/fncache.c:fncache__init():

        fncache =3D hashmap__new(fncache__hash, fncache__equal, /*ctx=3D*/N=
ULL);

Should these locations be updated to use IS_ERR() when validating the result
of hashmap__new()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908220720.5646=
14-1-irogers@google.com?part=3D1
