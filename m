Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5839FCDB
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881018; cv=none; b=knzr0lh9P7de+FelLi8/fQxlaRUM8B/F02XCUL5zMVAjLLNOauFgIHO8KiHqDXyzPdxYjSka0KY5ppEr664+jEr8Z41W3gR+RtHIxlz/9kJ39WZbYbaxjBh4s2BkrK5ZWj4tMa+Kvw9uzAMZ6+gAqHtd2GOfdj6fkWgnx3UvF64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881018; c=relaxed/simple;
	bh=ZxBQ8aq5UXAODWWoGR0kJ5Rj5bkEgHnRqapRuak5hvI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ecfhSTzstyilaPI1LCLr5DMCBgDJxWx0cQ/SxAaXnRyPrL1Leq4cE6kJVl0LvrmMz2H4o3LiTkH7fP34F3fO1PQdy6/c06XVANyELCrtDAw00/K7H1uKhdKyBHLxoxAB7henF20Km8mWV8JNDLlwacLYTjE80u54VmgLoNdidBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9GSNaEE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9GSNaEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79721F00898;
	Tue, 13 Oct 2026 08:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791881017;
	bh=ZxBQ8aq5UXAODWWoGR0kJ5Rj5bkEgHnRqapRuak5hvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h9GSNaEEIfcyTHfTYPcJqzeSerdtcHL2PZoRxE1rNzGqBoXLnOfGHjtKSKoISqviz
	 bFFf6BKCw6HupuOgIZBdvEbZIYBJ0oVwDzEuKnBB5Sc7qK1Tr9qCmh/YKAASoFIJU6
	 UYqjj48xgSAMMt17KDeXaj2NatWV/eRVauyeNwsgau3vOQE8BgHzjGgJVG8Od4pmeo
	 FZqxYWDZC88KSocV7NvGpW6v83LVClRDYTHJsOTIG3tHhJ4kTYVnSfWr4Jaerj7pQH
	 tks8DtAcVdXUaywzBs7uCBVWqH2DpnSzC6RhYfNR7/mb0vtpa4Ztx1apELC16k/hS1
	 3UgKXhK7E095g==
Message-ID: <sashiko-outbox-169270@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/renesas: Remove remaining RISCV_ALTERNATIVE
 references
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <fe117dd44728fe7c96f3e4b3ec88c6ca83c5da9b.1791880574.git.geert+renesas@glider.be>
References: <fe117dd44728fe7c96f3e4b3ec88c6ca83c5da9b.1791880574.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 08:43:36 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> As riscv always selects RISCV_ALTERNATIVE, the option was removed.
> However, a few references were left, making it impossible to enable
> RZ/Five support (ARCH_R9A07G043).
>=20
> Fix this by removing all remaining references.
>=20
> Fixes: b924210f542e13c7 ("riscv: remove RISCV_ALTERNATIVE Kconfig option")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/fe117dd44728fe7c96f=
3e4b3ec88c6ca83c5da9b.1791880574.git.geert+renesas@glider.be?part=3D1

