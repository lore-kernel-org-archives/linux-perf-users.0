Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600DC339388
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389438; cv=none; b=K937ucqeYT64xnjpXoKFSFGG06iVMi5Nscfe4gsihzvmW2L/4Y8EYnZFRjibVytwkw25KdGXl5UmvD3TCNpvG8P/P6NTOQQwg8CTIZgV0xHFbucuF4ge17beeU2hfQ1msbiyyVFlvSIH1THVeGaNZoEMxw4l5pIiPe9p1yRTztM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389438; c=relaxed/simple;
	bh=FvXLdB6G0GN6kc6gadDMFdxk6HPc/i/YhmIJ61Xx0CM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=t6OiqjiQG+Z/Um5sZlbZf0rP5W45UP3ynUzs6QefdB9D6DVptL2SC9u9jEQc0Bt4Uoi+VKyfLV14PcLrig7QUYdDLgqRbLO841PfV2pd5q8H1Tpq2GKN26sXqbYqr0ArxsawM7IxEdqB3cmF48H/KsmBlJjw4k5foi6Tr0yZEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LH4cS8TX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LH4cS8TX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B95D1F000C4;
	Mon, 19 Oct 2026 05:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389437;
	bh=FvXLdB6G0GN6kc6gadDMFdxk6HPc/i/YhmIJ61Xx0CM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LH4cS8TXUTCDlaCUJH1/jMo3Aa5x/IPTqxdlSv+kn2G3tt0JQayecr7Nq10nTBlxd
	 Ab6fSuMofckl9AGTnVaEBKJ/I7xyl7SVDJQnZ3QcNtRsQS/K43O9WyArex68OXwgGs
	 r03XcHw3zwxGNUmUEnPt04OGfx0JwRARCO3uHQPZrD+lrtMhQS4scAQPm5U+LaxDPE
	 MImsNf6B5Nr/goxCswMY3wsP1Wzdo82Y1KOgqnnu8bW9GX/mxXrZIvGO7iaOAgO0o0
	 hIWQ4zD56d95v7CoJsO23lsAG1VBqt9UsmQhJhR5+CAOr4RKE13UirHMzJgg8++Fz0
	 Q5BzMorya8mVA==
Message-ID: <sashiko-outbox-176677@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] perf symbol: Check result when reading section
 headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019055207.39325-5-namhyung@kernel.org>
References: <20261019055207.39325-1-namhyung@kernel.org>
 <20261019055207.39325-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 05:57:16 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Otherwise it may access uninitialized section header struct.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-170233@kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019055207.3932=
5-1-namhyung@kernel.org?part=3D4

