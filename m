Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26F38654F
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403974; cv=none; b=W1x8aXiCHl0CSCtlEHeV+bSzTzYEcT14oqLA9wqIu3aZVuL4QzAaEIFi9A7uqnQ3YrvveqMqZ1G3hmE0r1ntVXuLNiFvfxTS+Mju7TcHk+laEPhAvscBgX6fYlkv2vCWPhuQsLx1W1kT2684Ha4S/bFhTtq0J31Wbi5qYjSNAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403974; c=relaxed/simple;
	bh=ct5tcaVdy2m+M8WQj19MlofrQpKEl9q4TTs6tDHbDdM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mFQAhLhGFfJ2A+qVH8m+o4DYd8ilC5bf74dfk0PuJe7/IFC13x0wkp3lzz1YjcpFujETePViPOs2LTWQC4RbAjLNdH5OyjvGL57s0ZBjmQtL3A35tSprgH6khh6wXlGGouWrdMqZfjC01txgLUGRjCw8TIx/5JAmLtpa9Zze+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWh3/ItF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWh3/ItF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69111F000FF;
	Sat, 26 Sep 2026 06:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790403972;
	bh=6+NnePV9YsvZu0XAmEvm9+bRH1XCgEUWc3mi3vUr3XU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QWh3/ItFk5I0J13gwNw5ZMi7zYhDreX+u9bxRfM9oqduizrq/e8LcmQnGZc6RQMnU
	 2vkkuPOHU7rEV4rbH91SWJOCPPh8Sh3D6jokQIcwoHPD0lLC4TZlWxxqdY+vhcnEUL
	 JnT8BP/SaZJQNN2rNGSczrlciq2FABgi85ZKSta/tHSuJKGRPXhwBvClJ+kZYLuX+9
	 e1L+ThgZ65wgJmMhEboCVscNikMmBhmfxPuVex8Koqiegottfud1sh5sycQKLNOOTq
	 pGAEUNjdnZvIZXe1zjGqe6MkFLMa6VMEhesfLL8GNBIuUFYFEv5mXcwkDdlqza4nkT
	 C300B0EqlyLWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/49] perf python: Clean up pylint warnings in
 twatch.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-7-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:26:12 +0000
Message-Id: <20260926062612.B69111F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D6

