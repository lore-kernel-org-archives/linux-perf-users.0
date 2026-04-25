Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66E35D615
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158991; cv=none; b=jKkJNQkZKtLCQd1YsteKgdLceI515oYKChVleahfjGo2ay4wXnqhDEEyvjVxF++2nm63oztXRCAHNy81ZB0FOOzeNLswhzeNIax2RUkC8GCUtLQIPGN+fV/5sBs53c7OerXPRIjo8wtgqm+G/HX1dRbPIVA81J0H3JsvXjfaTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158991; c=relaxed/simple;
	bh=OE7rDug7vf+9SAiufBFkO/i5OAdwmG1mZ3+Y3cqIT3E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GWvYRuTq0l03eNbelM6uraiWbJ/XNuKfBpu1edx1eC25krGaVqDmBmQxL2CTnLZJQeUnTLJD8rHxvGf7uxuKLSp2Cf+zK0nG2qQKKG9DTfpCrRGxKyEwj9BN4p8y8GGcCv0K4ZwEUNFmA810AqTOl0XMPI8aoF20C77s8TjC29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1ydG9q7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1ydG9q7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D737C2BCB0;
	Sat, 25 Apr 2026 23:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158991;
	bh=OE7rDug7vf+9SAiufBFkO/i5OAdwmG1mZ3+Y3cqIT3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=X1ydG9q7zKsG1uWShl+hhPn5T13V8mPXZAQ9K33oTWiG/pQCBEh/Z7NCqa1peK4WI
	 8n4sG+TXEhI8JYiMTMJcxU4VCISP9H6gIcaFtvE6CBsaDOt6+fgtnMNulOPxauJFpN
	 LT2qy/dRoUtXOf48GANaxnKe6jhFFYk9p3XrnNAlYtWr11nToXmrt3wvBdhBNb2WZH
	 mnLIC3qd3etzKUeAx2xR3xgdtrV7+MvDhRFkkwnxlh6webPiynto1g5mPdk2e/eUo5
	 kLcpb1+O9CTNWXjhBFJZncdtxqFxJ9p/63ETbdqqfiKx/Aw0F4GSuqOJKVpDjqneJt
	 T7KXV2bMCFT9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 53/59] perf: Remove libperl support, legacy Perl
 scripts and tests
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-54-irogers@google.com>
References: <20260425224951.174663-54-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:16:30 +0000
Message-Id: <20260425231631.6D737C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The bounds check modification in `check_ev_match()` breaks event=
 name parsing.
--

commit 50fd9d1826ce58398fcaac6c5b041e7dba41465e
Author: Ian Rogers <irogers@google.com>

perf: Remove libperl support, legacy Perl scripts and tests

Remove libperl support from perf, along with legacy Perl scripts
and their corresponding tests.

> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/sc=
ripts.c
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

Does this change break the event name extraction?

Previously, passing len + 1 as the size restricted snprintf to only copy
the characters up to the first whitespace. By changing the size limit to
sizeof(evname), it looks like snprintf will now copy the remainder of
the string, including any trailing spaces and subsequent script arguments.

If evname captures the rest of the line instead of just the isolated
event name, it appears the subsequent evsel__name_is(pos, evname) check
will always fail.

> =20
>  			match =3D 0;
>  			evlist__for_each_entry(session->evlist, pos) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D53
