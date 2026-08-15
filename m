Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB31B4223
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786815497; cv=none; b=jj98g1EF/C62y7pw7fd9pHeTIZ5A9xjz4o+NNXEwwc32+xZOfi6CqIAcBHrrmEqQsD3Xr7pAN+3tzWFB9s13ydQJR9+sPsZP5IBZ0ARzURrIJwBEmOFgz/Vdfi6Eapfc//mZ0LvBOjtugRuHoyqoSU6g9dkVjdpkEFsgNfjFTOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786815497; c=relaxed/simple;
	bh=enMk2ECq/Y4k8wH24jhdb8JrwjngTF60Ra1umBKp1KU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dy7rEpZFzg+jSEi65ais4gKP0WqulquyKlKwVxb2+EC0wTOlpjNZOQ5NXmiKo1Z4gAkjvVBXLd8PCxMp5KeAZL8ksB0mjwYy9lGJWUcxLQeCydCIAs5ti3GTkfwZuNk2I8li+4zZy7ZrkTyHfNt7WzKljxb8oYdxRQBieyeeRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0aw1Cd5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0aw1Cd5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC73E1F000E9;
	Sat, 15 Aug 2026 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786815496;
	bh=enMk2ECq/Y4k8wH24jhdb8JrwjngTF60Ra1umBKp1KU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M0aw1Cd5KqCP3ASK2QUPrw5ZxHJotXjXfCI+RMrriyROWehdlL+OKXECfLaY1QHHD
	 Yo5yMPLficYBrcb/4mimx62+DImsJGfMBnmDJwOdt988t4JDpqA3WKfjSKoC5bbbKE
	 wutaGrVIfDg6fVTBqPsDhABTIRatol4EGF5Xok+yINmsGLNQ3Ka0Tp1uw3VszaKcSG
	 SptK8lTgIUWwS9OEWdqrVVeiOWh9hB4tCFo/apYig+dHz4Yo+h6L6ttWw1BaC718D0
	 ZIi0dCIISiztWDv44iT2ZN8yyqYX9keVz3AZNSn6zdrIMvUleUxZLLcMi2fF+8FhTq
	 G2sDyzSYFl3cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 3/3] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260815172712.50119-4-irogers@google.com>
References: <20260815082048.4043217-1-irogers@google.com>
 <20260815172712.50119-1-irogers@google.com>
 <20260815172712.50119-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 17:38:15 +0000
Message-Id: <20260815173815.DC73E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Initialize MMIO-based AXI Performance Counters natively for the BCM2712
> architecture, dynamically bypassing the legacy VideoCore VPU Mailbox IPC
> layer entirely for newer generation hardware loops.
>=20
> Sysfs topology definitions natively expand into dynamically evaluated
> legacy and modern mapping arrays, perfectly partitioning Pi 4 endpoints
> from Pi 5 natively during PMU registration without relying on internal
> legacy string visibility filters.
>=20
> Assisted-by: Antigravity:gemini-3.6-flash
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815172712.5011=
9-1-irogers@google.com?part=3D3

