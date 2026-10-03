Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A03749F5
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991204; cv=none; b=ZxHHH647IjK4b7QAYFlkTi8QF1/DXfA3eU1jvANbt+qLQn4zTsf5kb2XJz4xLFeK6xTgw/VYLIM2JyTZHbmpjasRXNZ6Zj7aVvtBlvgzu0hLDL+jfZ0teu5hCQGaZLfMskcgeA4az3zWzyxOfgG2QQ4wtBlt3PAmLnPf2CHNjHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991204; c=relaxed/simple;
	bh=+EqwlY6v2pj2FcP8/kht9YFoO59GBGfArzqj84X1TNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f4+KG0gRP0oeHuFmSDOpaI1YLa+tjJIxil1L7DeG5rW4irG8CzrA8uyyTktgtaGcNHeVnHuq/qxiL9S5m6/sgVDfmojELSD3FnWRYxIH3Z1L7Hu64mApFBAC5etyUZntiYL/bvFWeUZ/3LFyMhWj7CTVOMjsFC4BIBk9eeTyQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIZKmcc0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIZKmcc0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75951F00893;
	Sat,  3 Oct 2026 01:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991202;
	bh=+EqwlY6v2pj2FcP8/kht9YFoO59GBGfArzqj84X1TNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jIZKmcc0IItkKx+BKfQwokWPKvPp/tK7lUulFvE65/1bgPLfr6MaVdeh6nMleJLZY
	 OK0uYnje/Kg2VtKNtp3Zgz04QtE3NoeOt6RDHNvS019mUwebOzWsRc/uGuk4bVRIIK
	 2iBhgNKeJdeeiPn+A2CjlHUJtyHvGzVF0IOYmcqKzf1RngThq+pvKOwPAtaeUod8An
	 3PTValvTcxYrFrf2VKJ6v29wyyqXFaJcoP4A1NyB6oD+d1CJYUwtQufXnBiP8R8yH2
	 D9ZfS3EB4x6smkhUoZZpTGs1Us9BgFoHv1lqwmFGWUDtXAbBaeuUrtxy3NR2wtGF6C
	 9XfI4ijw5zX4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] perf tools: Internal support for BUILD_ID_OFFSET
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002173848.3228217-6-irogers@google.com>
References: <20250424061943.1321025-1-irogers@google.com>
 <20261002173848.3228217-1-irogers@google.com>
 <20261002173848.3228217-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:22 +0000
Message-Id: <20261003013322.A75951F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Implement user-space parsing for the new sample types in evsel,
> update perf_event_attr_fprintf to display the new bits
> in 'perf report -D', and update synthetic event parameter names.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002173848.3228=
217-1-irogers@google.com?part=3D5

