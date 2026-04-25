Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C036371046
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141162; cv=none; b=Ic58GXOfKOGBQkt4oA372U6SonXKDCaq0KVkrqxXh188fWqE1RZ/QcKBgaemuQxay3kD31d8VbV+HoPnXakDf90DRkRQeUAYY3YKeuznI28WMAcSA+UklCAEQGtck9rF6qUl2QKOiXt72P5hOYv3jfDlhIMmLVHNdhP7sMbLTOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141162; c=relaxed/simple;
	bh=ziTs1p47kLdke9byJKOISLUazDnJ1iUKCnBDPWvC+Hs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JBZ2dub2wAbrii/WKAXC0wTPTNQjKJA39gjmDDxCCvGYORAElFqGP9undaEDxM3DdwTh6mgmFAnZXv0hapr2NtStnDF4p6P7/w24l6oMQCkbOlK1HNlkU64WhyxtBMapoAAuwVcGiY8C1X3I7Dk74WD4TsDu2z0lflQOaMMUXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osFMqBng; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osFMqBng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEA7C2BCB0;
	Sat, 25 Apr 2026 18:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777141162;
	bh=ziTs1p47kLdke9byJKOISLUazDnJ1iUKCnBDPWvC+Hs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=osFMqBngMrAiY5ml/2O2CdjbRxL2Ws1pywicFXUN7OZJCRRIelKkYR/A2sWp1yXrE
	 VVcM8Iy63CdRA+UJoLYv6p4P/ehjlEVfqlFQp91M2uM2RL1b5VH7JeNadZGD7TCFER
	 w9OY69ahd3ncVijiOZxDt9m+7gZB/L4G39m3QmKghPPwo2w8IeSTfLB2ll3vdNbtpM
	 LyasaCzmWSwOHO3nA2FwcGLiv43v3D+ksctR1BvT6wM0ZnCVbDurcE1Oy8VxVHUTu3
	 bGMEKO52f9tWYGh1+kZot132XLFFx5QKQbhEepJWw3imAqf3g6xoucxPlcTJPJeFFt
	 47Hn6PI3E9kdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 53/59] perf: Remove libperl support, legacy Perl
 scripts and tests
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-54-irogers@google.com>
References: <20260425174858.3922152-54-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:19:21 +0000
Message-Id: <20260425181921.DDEA7C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Event matching logic is broken by an incorrect snprintf length a=
rgument in check_ev_match().
--

commit 358c8fb5b2850826fc33a7ec1709b3b089c45e16
Author: Ian Rogers <irogers@google.com>

perf: Remove libperl support, legacy Perl scripts and tests

This commit removes libperl support from perf, along with the legacy Perl
scripts and their corresponding tests.

> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/sc=
ripts.c
> index 1e8c2c2f952d..db5559311a1f 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
[ ... ]
> @@ -126,8 +126,10 @@ static int check_ev_match(int dir_fd, const char *sc=
riptname, struct perf_sessio
>  			len =3D strcspn(p, " \t");
>  			if (!len)
>  				break;
> +			if ((size_t)len >=3D sizeof(evname))
> +				len =3D sizeof(evname) - 1;
> =20
> -			snprintf(evname, len + 1, "%s", p);
> +			snprintf(evname, sizeof(evname), "%s", p);

Does this snprintf call ignore the calculated len and copy the rest of the
line instead?

Since p contains the remainder of the line, using sizeof(evname) instead of
len + 1 will capture trailing spaces and subsequent arguments into evname.
This will cause the evsel__name_is() match to fail.

Should this still use len + 1, or perhaps use %.*s with len to properly cap
the parsed token?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D53
