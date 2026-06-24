Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C830BB8D
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278915; cv=none; b=g7GQvsIDAB36F1S8EzIkH/rKKBTtYxLQ7YYhl49G+tvDSpc2okzld1TjAtSDcWW1xNBBdwM+VXrYv6pTAdtXp/jlQ0bFLMgPSquOShV0dh+aU0hbpSsrLXkoZKgR1HVHB0U2FeTKTMFt17z6ib1gAnHgS4c+xKwr8Du7/StbSDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278915; c=relaxed/simple;
	bh=N4gjFz3glzEnxVIZ5TuD60/f4hZCfze9Rkk0kkIAuMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=czzk3w0SEIFUrkgYc9kAuAHWZnfRIN7mo8aMTCCvQb3SgOsBcWVgs2OOJeHERG1rftca+qSrtB+nDzS8WuvRQ03DLUtB/7vSbqTatONilPBomruIbHcodDMsuwVoJ3qe06zy1m1SZIwMDM/X+kXujkjLB/MP3A593TUkQ9KljOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZUmsTMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZUmsTMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D5C1F000E9;
	Wed, 24 Jun 2026 05:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782278913;
	bh=N4gjFz3glzEnxVIZ5TuD60/f4hZCfze9Rkk0kkIAuMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NZUmsTMpjMhdga2qwNRwYOotW/KMM45nbETJggvxpRNBGL5RjpV+pbsXWDZlld0Qo
	 NDSABrPRUHCWV4QK8W/10kkPFurDbCbRjvh+LE7M6qHL78ln7otGTYZWz8knLjOERu
	 WBzX31veuY1ttixLl/MjEvNuoJ7Wst+YMfpAITUu88diDmFpnTTWK0e5H8Sar3AeLK
	 Q5+pA3CVE3B+hijl1gm067zaHV1dDKvJSWYpRUBYCxDr4MSYbrbuzF+tXHPEQLGPsz
	 /TcrAx/X+4b/Ve4DVToBG3RmNvgCn6ItO6Q6Obn1l0BfKuwzl9C9Uzte8QsHUtZunV
	 bwm3YgxtlQYPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/16] perf python: Fix memory leak in
 pyrf_evlist__get_pollfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260624051535.3584977-6-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260624051535.3584977-1-irogers@google.com>
 <20260624051535.3584977-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 05:28:33 +0000
Message-Id: <20260624052833.C2D5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Low] Missing explicit POSIX libc header inclusions for `<stdlib.h>` and =
`<stdio.h>`.
--

commit b37f20df0f07ef7454731749a918a55a91b0c7db
Author: Ian Rogers <irogers@google.com>

perf python: Fix memory leak in pyrf_evlist__get_pollfd

This commit fixes a Python list object leak in pyrf_evlist__get_pollfd() by
adding a missing Py_DECREF on the error exit path.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 11e1f39c1bea9..550f1e7d14499 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[Severity: Low]
This isn't a bug introduced by this patch, but there is a pre-existing issue
where the top-level includes section is missing explicit POSIX libc headers:

#include <inttypes.h>
#include <string.h>

#include <linux/err.h>

The file relies on POSIX standard functions like calloc() and free() which
require <stdlib.h>, as well as asprintf() which requires <stdio.h>. Could
these be explicitly added to ensure musl compilation compatibility?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624051535.3584=
977-1-irogers@google.com?part=3D4
