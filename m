Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15EC4A484E
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364624; cv=none; b=SPrFT41WJICfoGSWQPe/Y3OXS9qA1l80zvov5HDDsDl/k3a/zWUMQTZvO79RDx2P2qsUsnHTORhQJ5VdS08LVNMstyKePb7oiSPJiQDVAkfyWJLvKhfCnDcV4Ifh7jCRUfKm2DF8HaG1/v4Hz6yhT0Uloe30CJ335vA4Xs3+ics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364624; c=relaxed/simple;
	bh=jQj2irJcXweY8xGFJMyiCj6oljXyj7usmY1JA0ZV1j4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a+/SGfTpc1pu445aFihlev8dENgALhCoOiFrfSRID/IzJOgrG5iXZASTvBbUvT3uZ1wwOpjDwTfEIm6wIhQHhT33Rlr5N4VrxjMMghtE4I5+e8cmN02z1ZW4ntnihbi6C0AJKw/8p0Pn2KhbXAMpUcdHabAhoPMYfp0LHApmsOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgytD3Tg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgytD3Tg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9150D1F000E9;
	Wed,  2 Sep 2026 15:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364622;
	bh=jQj2irJcXweY8xGFJMyiCj6oljXyj7usmY1JA0ZV1j4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FgytD3Tgrszr2fnqdfE/rv+ZjcutE7ZuUX0v4oNqpTCxSL0nE5Gww9TVD4OwKriRs
	 1vALUDNJv5B/uc2p4KrfG4eBTbWDJVD/OqiqOAYYrizFT1uT9Moq+BDHpC8sq2WANi
	 K7WIuyycAVklaGGJ+WT5BvNH/n4X6vvVHxFuXj944rsISIe44IT6OMjRdZtHANJO6E
	 6TkAbwdeu1V0g0kXJCLEWI8swzzkOMB98HWG+DvAOgip6soLYCK/zCHTtom03zrLIA
	 yxvR0WLONt052ywEUVX6plLSBghAMDI3/BvCVvsZfVQQsHsXnIpEz0ZDYMNVm5aXbW
	 gYLwM58mC5Zaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] perf tool: Remove unused includes in perf.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260902154858.2078885-4-irogers@google.com>
References: <20260902154858.2078885-1-irogers@google.com>
 <20260902154858.2078885-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:57:02 +0000
Message-Id: <20260902155702.9150D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Remove perf-sys.h, internal/lib.h (page_size), signal.h, and perf.h
> since their exports are not used directly in perf.c.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902154858.2078=
885-1-irogers@google.com?part=3D3

