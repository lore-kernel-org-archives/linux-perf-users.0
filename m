Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3F40DFCD
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645917; cv=none; b=LREEQcRaan5G5j44Xz794dFoJqsFMZWNlXsbrJyO1Zp6CMpX6juIwPnJohfm8nPwJAZgV56awodlqAVLcJNPdKeJGzs00HM3xPoqdMYWlsT29Vnm0BNMRmy/Yk9S27vm2ZuVYo1NFlPxUdEjlE+rgUZl7pU6ZSq2odJ3dIN6hfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645917; c=relaxed/simple;
	bh=V6knbEqxi6H11WmWMePiFWylJk2Q60q9jxZYdzS45ZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pYm1BYh/5Xhq0NYs71volsNTTMPb+p9tjmXKNoVHjgIe7TrE9MWjmrbE/8mhfKskWHkF1nsmXZA6b/6VODQESmY5KLVgvuyXqL//hjQfLjmk9nzQasxUN26RFqB4avmbZ2nyIgJI+PIv2dlEAoW21tPGobrF2098+xzWt0c5lpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq9V4Ywo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq9V4Ywo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E640C2BCAF;
	Mon, 20 Apr 2026 00:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645917;
	bh=V6knbEqxi6H11WmWMePiFWylJk2Q60q9jxZYdzS45ZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lq9V4YwojxjH4/9e8GgqE0VOhmwxNVQFyRvPoXEw3bC+eL/dDf/ErbFzxJP/oo3Yh
	 iZ3SC6y5/SOlomE4MCMIV2/OM8rcZlMnuKocs/s1Lzktx9Ac4Q7ckU50TjEEwZXgnq
	 swDvlOC69+zax4hoVPxDJ0JNT6L1FMCvQoCiBdyssWoS5lNfZcVzuekK7vQ5717HkN
	 oNgtqTcft7XXzR38jWDVXEoLG1WjbgAs/BPyOdLA3cLB8cLzmG0oquZZ3O0WIMiO1r
	 joJ7MxF9vF5PwJzH8zRvYf/56884DjRpgzI7e9MHAF0/gXXi83c5ulTukJbhNkkF0k
	 iZZDZ1OuRvqIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 47/58] perf failed-syscalls: Port failed-syscalls to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-48-irogers@google.com>
References: <20260419235911.2186050-48-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:45:16 +0000
Message-Id: <20260420004517.5E640C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The script uses PEP 585 type hints (`dict[str, int]`) which will=
 crash on Python versions older than 3.9.
--

commit 2142165e39350a16f1abfb88618c9b7b004b54db
Author: Ian Rogers <irogers@google.com>

perf failed-syscalls: Port failed-syscalls to use python module

This commit ports the legacy failed-syscalls.pl Perl script to a Python
script using the perf module. The new script is designed for file-based
processing of perf.data files using a class-based architecture to aggregate
failed syscalls by command name.

> diff --git a/tools/perf/python/failed-syscalls.py b/tools/perf/python/fai=
led-syscalls.py
> new file mode 100755
> index 0000000000000..fe2a3fab0b7ad
> --- /dev/null
> +++ b/tools/perf/python/failed-syscalls.py

[ ... ]

> +class FailedSyscalls:
> +    """Tracks and displays failed system call totals."""
> +    def __init__(self, comm: Optional[str] =3D None) -> None:
> +        self.failed_syscalls: dict[str, int] =3D defaultdict(int)

Will this type hint crash on Python versions older than 3.9?

The kernel's perf tools support Python 3.6 and newer, but built-in generics
like dict[str, int] were introduced in Python 3.9. On earlier Python versio=
ns,
evaluating this annotation raises a TypeError because the type object is not
subscriptable.

Could this be updated to use typing.Dict instead to maintain compatibility =
with
older supported Python versions?

> +        self.for_comm =3D comm
> +        self.session: Optional[perf.session] =3D None

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D47
