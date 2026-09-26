Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E135A387
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404373; cv=none; b=O46X4cWxGtvLQIN0zB1tf7oxGPhZO3bGfYiaiGYJ6i2/uCzIZo0KHH0qr4NZ2pz0KqFRQTB50zRzdlRLTfuSanSsC46Nu3P2wh7cFh6KNbex3is6Vyd/iOn6HzZeX8zLxccSKiyHgJxeSPoSHr8tq7GG+VLYar5lLXxrukYhitA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404373; c=relaxed/simple;
	bh=WkGg/wZc+12VExKoKg2a4F+aqNud7r99WselSvIhbxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R78ZcpqHQeKdcwDtxzSBS/lmqTy6hguD/D3WZAv/aKpOECKxbUqdvNpzIt4orw37d+8aKPn57cy40eL3PmCNWv1Qmudckl0PkXM90H1wQvE7pvAE5klPuNmMUzHh4vuMqnIX+vaxR+S8NDBY/o7ShLvdWYI6t3VmQ4+Uw7vGCNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj6k/NkS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj6k/NkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB071F00893;
	Sat, 26 Sep 2026 06:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404371;
	bh=WkGg/wZc+12VExKoKg2a4F+aqNud7r99WselSvIhbxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fj6k/NkSmAGtrjYsOGcGWh1hsLTTMZzRkerDwUr3RvqcV1DB09UQz88DAI0/u+H3F
	 e2HN/jRYhheDvQ1OjVh5/b1pJoiqkBD1GuvcCU/IvhDRV/Xe6wpgLT14Gm4QQeIaSW
	 uqKWih0GPB1OibPMOZaVOmjxtoFPArprFQg2gw0WXMqwVsp1D83rjMkarqwM5+0ySY
	 1c57+LRf0Tv8brwJ7BfJilCdJqUrdJ3dq/XodzICZy6Dj0U7pWiOj6M2V9efQyInsn
	 8edXMXRVgdMGx9BokgwxTdOcPneao3cw6VqlJSRzqOj58Z+Fh8GAXHWV6eTJHWZ1dR
	 dejheQ37lO9nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/49] perf python: Allow KeyboardInterrupt to
 propagate in LiveSession
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-11-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:32:51 +0000
Message-Id: <20260926063251.ABB071F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> LiveSession.run() synchronously blocks while polling evlist for events.
> When running interactive tools or scripts from the terminal,
> KeyboardInterrupt exceptions raised via Ctrl-C must propagate so the
> caller can break out of the polling loop.
>=20
> Previously, LiveSession caught KeyboardInterrupt with an empty pass
> statement, swallowing the exception and preventing calling scripts from
> detecting the interrupt cleanly. Remove the empty handler so calling
> scripts receive KeyboardInterrupt and can perform clean teardown.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D10

