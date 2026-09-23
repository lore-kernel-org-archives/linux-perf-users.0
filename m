Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADAD4E77EF
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187592; cv=none; b=nfnTVZJ6hT7OR1rty89Twg508zZKRpJcqKj78fjy/BVCtHNCgzr0Xga9A99dVgsBroYxs8iuP6TBnmUjoKx0l3NTVmpH5ISpCrqYpg0FD/jOvDf2jYycugEcR//YMVqyRanJL3ndreaPMpiiaL5KdZ0q0rh9ui4i0YNeJOH19qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187592; c=relaxed/simple;
	bh=oerMSyQS1iX1RnGkytabYWbQWVSqLa6ifr4lbl/7qzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SwHhxAvVY8VOx7/i6wVjqbzBnxBOAAYb1P5PeIv0krxYeDF8LYirB+2EY9sToHUJYwPDZM5007oN0LHsouAeYuf3RxPk+0Z6DqTyHDvyojCDVrGoB1Tpkf6qygkinC1IxzrNJw8oWnKKuesurYj1blo9XMior3Sk52fJIo+W1Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm9Gx40b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm9Gx40b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB811F000FF;
	Wed, 23 Sep 2026 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790187590;
	bh=TEOOYvYxHAzCO7aR4lEDB6d4u5lUIIaLFW7m7w6j6No=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cm9Gx40bBRaeFd9bpzdmoGmzeqxRT6rAV2G86HR3xATFMdxIK7N6xiDHK0QgYAi0H
	 5qLgZt4VLqoLw7iyyiLWMWfVNi8kz4jXs3mbkh7l9p8twLNJDXPIzgk+WlY1MOE6Uq
	 g7OrOIAzeUGTA1PSXf7htrKDaCGg7XjRVU+IoUmLayGoH9+fJOOrR8eX0N4Js76CuQ
	 dJ24V05VF18GTHJv73sG7FlrckJK54wevj8uu3O4FknjqvLsD1AFctgE/FEpXrmIoB
	 jkqX2B0aG5ThfeFMVnbBRLyt0NV9UCDkEPB0h07p0ttaVE8IT5l1UtuYiZbDs4tSlX
	 KgZ7TmyAp0qDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/49] perf python: Clean up pylint warnings in
 twatch.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-7-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:19:50 +0000
Message-Id: <20260923181950.5DB811F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up pylint warnings in twatch.py so that it passes pylint without
> warning suppression comments:
> - Convert tab indentation to 4 spaces (W0311: bad-indentation).
> - Remove unnecessary trailing semicolon (W0301: unnecessary-semicolon)
>   after evsel.open().
> - Convert floating multi-line string comments to '#' comments (W0105:
>   pointless-string-statement).
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D6

