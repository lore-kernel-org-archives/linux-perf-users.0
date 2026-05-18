Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8DF37CD4F
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073701; cv=none; b=YuGOlPj5CVFbMF4NP0vrPKIlPvSqBoucK2A93n4waMGrheOks6SojhL0SwoRV42/BdlBdxofJBC7na3rEhdGges2PtuMu9+xAsrGbNBoGVGs/EeOK8PS3UIZPZqvvzBdMNCmQG3udsNj0qeHuywVKcb7mKNKTtOEH58Ii+Qv2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073701; c=relaxed/simple;
	bh=1/+71BddValSdQeVF+PAu9cgApS/Jweo4Ikfvh4pOKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d66/MLRz2LSaaOEbBH7k1bQKaJmcTRp/fkWJ//mqh0cwgTR3lBDcmOHdMC/Kdb8G+4GKRrhzAEqPn7lbp+BX6P9i6H5UiMmQRKzp6ub3743w7uyms7plJNnG+yjm+t4ni9Q8rgLIc05W2VDp8mM4mdEVzYY46QPoe7CQwvp2n8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkOFtM12; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkOFtM12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9F9C2BCB0;
	Mon, 18 May 2026 03:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779073701;
	bh=1/+71BddValSdQeVF+PAu9cgApS/Jweo4Ikfvh4pOKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BkOFtM12NLuK6IZIXPK91wiXZbXPy0tMdwEjt1/5q22eORaHWRn7tCCfpXWk7S76x
	 OX0cxjDMI5pOP2SFgjpJ+F6zbuDrUaiuL6IJfMmCdA1PFxNzwNtChIVXJVw7MuRlUI
	 OF5A8048rU29+dbRwhVM9ayMOO97GqY7TOHOTkTg/M+GBTX167uLGWBe9Z9ordeEAb
	 Hb1zssJe4nAzzvRlv9qytkZTPV3i2GcjjceSgzRr/ahhIchaw4r7DsXEtcYA0qxFEq
	 GOC0GmXxV6v+0L/jqK5JPqxBGfIPi80EdtKlbPmTbD5M1GJtx8/Qwu/BJbCVJ8fhbJ
	 YHDrpcSFRmnCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] perf arch x86 tests: Add test for topdown event
 sorting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518023225.2472122-3-irogers@google.com>
References: <20260518023225.2472122-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 03:08:20 +0000
Message-Id: <20260518030821.5E9F9C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The logic for handling 'expected_instructions_group_size =3D=3D 2' =
in test_sort() is unreachable dead code.
--

commit 593335141c0ab35f13d4085b28aa7eaa6387b85d
Author: Ian Rogers <irogers@google.com>
Subject: perf arch x86 tests: Add test for topdown event sorting

This commit adds tests to ensure that slots, topdown-retiring, and
instructions events are appropriately sorted and grouped when specified
together.

> diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/te=
sts/topdown.c
> index 3ee4e5e71be3b..dbee32bf973e3 100644
> --- a/tools/perf/arch/x86/tests/topdown.c
> +++ b/tools/perf/arch/x86/tests/topdown.c

[ ... ]

> +	evlist__for_each_entry(evlist, evsel) {
> +		if (!evsel__is_group_leader(evsel))
> +			continue;

[ ... ]

> +		} else if (strstr(evsel__name(evsel), "instructions")) {
> +			CHECK_EQUAL(evsel->core.nr_members, expected_instructions_group_size,
> +				    "instructions group size");
> +			if (expected_instructions_group_size =3D=3D 2) {
> +				/*
> +				 * The instructions event leads a group with a
> +				 * topdown-retiring event, neither of which need
> +				 * reordering for perf metric event support.
> +				 */
> +				struct evsel *next =3D evsel__next(evsel);
> +
> +				CHECK_COND(strstr(evsel__name(next), "topdown-retiring") !=3D NULL,
> +					   "instructions second event is topdown-retiring");
> +			}

Is this expected_instructions_group_size =3D=3D 2 block reachable?

Looking at test_sort(), the loop iterates over evsels and skips any that are
not group leaders.

The only test cases invoking test_sort() with expected_instructions_group_s=
ize
set to 2 are those that also expect a slots group size of 3, such as:

test_sort("{instructions,topdown-retiring,slots}", 3, 2);

When slots groups all 3 events together, it becomes the group leader.
Consequently, instructions acts as a group member (not a leader) and is
skipped by the loop's continue statement.

Additionally, the test enforces that slots must be a leader by requiring
slots_seen =3D true to pass.

Does this mean there are no scenarios in the tests where instructions can a=
ct
as a leader of size 2, rendering this validation block dead code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518023225.2472=
122-1-irogers@google.com?part=3D2
