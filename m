Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43A37A84F
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991217; cv=none; b=GhVeTBBcA2ZifTlMNoBm9WB6611FwVezOl9ldztDmXKQYSciakLN1etB4nXJsjNZ0MjZRR+t4yD2d+BcC+bB1qxuBSMxnZ2QE/2b+ggGkp/UQ0sqsTBq9yLg9TeDUGqmls+p8VnlisphTUxwuMKaZy6sE/oFD6UbtLrwG0xISdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991217; c=relaxed/simple;
	bh=6GutSizLFnFfNRRPxGZm3CDJlivCJeE85l4L3fES/Hw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WaX8b2qOwtV3vhSeeZpO6TYl3yMtikLM5eCovDI37JKelZaW63tDnKYR3HTbOu+2Pkai6FUdRrMpWEYZTcCg19RQAtbbjxghxGeSKG9pGtICix8wd3MTkEhlVki54kmrcD1ROs+yFua5zCcv9gg0iUGt0Mnsgmyh14xmDGDs7hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev2gA2Cz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev2gA2Cz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152CA1F00893;
	Sat,  3 Oct 2026 01:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991216;
	bh=6GutSizLFnFfNRRPxGZm3CDJlivCJeE85l4L3fES/Hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ev2gA2CzQmzMjgiyZhmHt/nyV8Wul92aY4/mIJPeTktdcDP4mhMVjQuW7nfVloT0r
	 dbPPbWilk5Yiq7Rrxqd6ppcT44Du8tF4ne5QJQ7rFj9clYgpQv/HALzJM1Zvy1JgiQ
	 46oUpTit6N6Jblx7NZt0O3feBTmegMf4Iouo/XUibM9z32Y5j8Ljedc8amCFR7stN3
	 ewGwg/BwlNHquHmkl6GvhVbXs33N/sT22dAbrf2VEXEN/M7DhY3zEnMuk14nD6nL4X
	 tCrApDIlZ/uZ/+MJginL6PtJd9urXbUiSFluPgV/QGWodqIT9LDziqu4dp8LMF2LeN
	 wFXOHLCzaNK4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/13] perf timechart: Add an interactive --tui mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002182624.3259797-11-irogers@google.com>
References: <20261002182624.3259797-1-irogers@google.com>
 <20261002182624.3259797-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:35 +0000
Message-Id: <20261003013336.152CA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alice Rogers <alice.mei.rogers@gmail.com>
>=20
> Add ttimechart.py, a textual based interactive timechart, and a --tui
> option to perf timechart that launches it through perf script. Rather
> than writing an SVG file, per-CPU (busy, frequency and idle state),
> per-task (running, runnable and blocked) and I/O timelines are shown in
> the terminal along with a summary table. The timelines can be zoomed,
> panned and the state of the selected row at the cursor is described,
> including the task that woke it. The -i, -P, -T and -p options are
> passed to the script.
>=20
> The data is loaded in a background thread and the timelines are shown
> and updated as it loads. A --dump option prints a text summary without
> the UI.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002182624.3259=
797-1-irogers@google.com?part=3D10

