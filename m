Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7B33B97F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917501; cv=none; b=bZvgOpAcIOv6eP+SkKe2UvQFMrCnwf/UM41ivLCI/rIN55mzbY464sTuMKuOaWj3TUEh7k6FgdhcynXNyfrAhSoMYNlrkc7MnXeXhIWjuZY6R+6e1pgud10rCWrafKTtDvQ1oSlozI/7blsomW3ReQOdtGZ2h/iZFwyxqeHPNSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917501; c=relaxed/simple;
	bh=yvxOw2kpjHbKLuC1f4xBgznfqxoB8lxJQqxyUZWP4XQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oE756k5quW9Mw6TailZkcGegwibHlcAcGzPqxUjAQsybkLnfdP+dm6zcm0XLkvgXOC5OQkccmg4FDvvmUXtOuRLXJ3MBwHKVYdBabndPJqyn6Gt2zPAR1oBj6nk/JLVkV5M90pjjuzLmkAdj2n92HDwbazLeaD/JlqZM+RWi5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuHeWoPQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuHeWoPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA52DC2BCB2;
	Thu, 23 Apr 2026 04:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917500;
	bh=yvxOw2kpjHbKLuC1f4xBgznfqxoB8lxJQqxyUZWP4XQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DuHeWoPQ/f73uEsIy/Zx2GyIsn+fztDxgCabUnnkSSu0dZ/wgHptkoaltgSpoXDKE
	 PGxn2hkgAsQqoJ61Dp8JYYEoPdSGMMkBVQYKlA7FJ9tjaLKzJmnD/6vosAOH6aSkvH
	 +o4U98ggX+aooOguRfWsN6OVwXCYqqEe2rQYxQQDiWGaWpdOgui8AbKWEn08FpoSD0
	 pn8iPb8IRdNrBZQyuA5law54EwZHwlUPTfpHFAPodYn9Wp9Hbas2Lixc08uy6/+Vbf
	 gkb0NcZdjUVPM/CUI2TR+1nQ2fwhcIFwlGfUXg1BPaIr7hn72Vp4d4WKdBG1MdKlce
	 mnJB46BC3iPWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 24/58] perf python: Move exported-sql-viewer.py and
 parallel-perf.py to tools/perf/python/
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-25-irogers@google.com>
References: <20260423035526.1537178-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:11:40 +0000
Message-Id: <20260423041140.CA52DC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Missing installation rules for moved standalone python scripts c=
auses `perf test` regression in installed environments.
--

commit fab2c9b2405a9f1a7e14b977ac6e28f3c18d3bbd
Author: Ian Rogers <irogers@google.com>

perf python: Move exported-sql-viewer.py and parallel-perf.py to tools/perf=
/python/

This commit moves exported-sql-viewer.py and parallel-perf.py from the
tools/perf/scripts/python/ directory to tools/perf/python/. It also updates
the test scripts to look for parallel-perf.py in its new location.

> diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/sc=
ript.sh
> index 7007f1cdf761b..2051c6e055695 100755
> --- a/tools/perf/tests/shell/script.sh
> +++ b/tools/perf/tests/shell/script.sh
[ ... ]
> @@ -76,7 +76,7 @@ test_parallel_perf()
>  		err=3D2
>  		return
>  	fi
> -	pp=3D$(dirname "$0")/../../scripts/python/parallel-perf.py
> +	pp=3D$(dirname "$0")/../../python/parallel-perf.py
>  	if [ ! -f "${pp}" ] ; then
>  		echo "SKIP: parallel-perf.py script not found "
>  		err=3D2

Does this cause the test to skip unconditionally in installed environments?

Since this commit moves the scripts to tools/perf/python/ but does not upda=
te
the installation rules in tools/perf/Makefile.perf, parallel-perf.py is no
longer installed into perfexec_instdir during make install.

When tests are run from an installed perf environment, the file at this new
relative path does not exist, triggering the skip check above.

I see this regression is resolved later in the series by commit 2d6f42d8d1d=
d7
and commit 615391f35d543, but could the Makefile update be squashed into th=
is
commit to preserve bisectability?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D24
