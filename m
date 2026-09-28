Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555E03115B8
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620641; cv=none; b=Mw5DEZ5xjcb3d+1jFgHWf75EwXRz1Bl03uni0HZQ/KC3ID9yLGF+u4ThQToZm3cgyUPlrk8P4cplDnNzKTlz7LevRMiJaX1Q+//tZcuqKvEX8wf1TcKiV868GMo/1gUCxPuU9B6No4JeK9SbgbM0zAL/eHlCkr0JbO9SKuUnlSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620641; c=relaxed/simple;
	bh=FFay3wKYKwnpidsiFJ5+mBSlMMz7DpxHgk9fbeIhnRw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sT7Pz0iX1mFnl0MQ5l1L2aSPS+sa6n4CCAtELUZ0s4bs8WklWKBZLMkX2Gd++LH34UHTrzYHJpyznsssgTkcUD1k1kGAi26fgRDS0x5ErJ4VHq9JrPbIHtOz3CWo+xDMwpSgWnkOKtJ6TPG675q0cVdOTB55iy6o6v7ZKnLAb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhfRf2WB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhfRf2WB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0FC1F000FF;
	Mon, 28 Sep 2026 18:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620640;
	bh=FFay3wKYKwnpidsiFJ5+mBSlMMz7DpxHgk9fbeIhnRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lhfRf2WBwjSaLfhLBEAblEd8yw6Zv9kIPFyRiuOe1wQdXjKypVWFsinNpwu46KE69
	 qWuQgMpA899hEDF7nvRkFG/kKIBTGi7t4sYlDkfQJEcD6UXZY9ckNVwktzfQ33lh/S
	 QTpEML7sKf64b2Vzt/XjiFEdGNAS7qwTryVGc/8lUAl6nq5mW1InvKvSY2P+t4fi19
	 kgLWFE+7d36SPUALzLiWmGy2Y3ivGRN1nXfBrdVsF96fVoPDUe7y5T1xvp/COny4cp
	 D/4KC6cg76BC5heUDO4hPP47Q3mo5MIXuep9m8GpiGFaG865bN5TMt9h/H2iPzocuv
	 3SbMzYXIlPMkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 20/26] perf test common: Only disable probes in
 clear_all_probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-21-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:37:19 +0000
Message-Id: <20260928183719.DA0FC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Writing 0 to events/enable disables every tracepoint, breaking perf
> sessions running in parallel. Disable just the kprobes and uprobes, an
> enabled one would make clearing kprobe_events or uprobe_events fail with
> EBUSY.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D20

