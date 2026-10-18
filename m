Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E14CB8B9
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333897; cv=none; b=UM8zUvt1BGpEwqQ25p9WDURomHqw1XxkOd3ayoyzjRw9cDF5wTL5Mcuc6qs0epLx2K1AmQDqiF4J/fgPytMopU83U84WT5UNrMl84KN9+1jW+s1ENhD6G2+qYd7oJc66XVYhXRWuN6TCDbmlgWPv8ACr827Yee0RVd8ZRRDOHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333897; c=relaxed/simple;
	bh=iJbiF3CXs8QJmkANJOSRUIRpbk1bCfhs/VjmwCMmrYQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cYjJ5iWdArWQKf9v/uxaN+sk4oYJ2DfrAk7zsbMl1MKMiMk+2z1M5KCi+IdbQ6t0l1uwKWkr4V2ndzmc+XEe81zcow8Ba+ocD1b8izBxA4VbkQDdqR4BRPWOQfH4Vc800N4lJD0AaQIJ+CbR8T0WHq2TsS0FEVaSk0Q1ZJqJrOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hk/NKFBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk/NKFBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D0C1F000C4;
	Sun, 18 Oct 2026 14:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792333896;
	bh=iJbiF3CXs8QJmkANJOSRUIRpbk1bCfhs/VjmwCMmrYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hk/NKFBcW20ExK6wCGfDqg47XC+WjIQdlmStpD4uKobFIakATs7HPAFZ9D9c0YL/U
	 6cNz4YrqZp+xH83k1yiCyb+BRhyo+UDHEDZL5mF6NaaqDxv5e7GQ0axqnhzXLj3N3b
	 1Rdi28C24JD3BCXrrj1kB/RGEre0yRpPBWuJoMu6PGa3wFGWBBWl3xaF3p11oFqMt7
	 dSfSGI8ndtZ/2ZkzNgO5j+/WbGm3LkLcJungu0bkwXshEEzdILSYGnox6DrZsVKEN6
	 bQmtUCeS4g3P1ZBi9j0qn89COd2GMoGcTKyZp/u3XLnh5hFmnUBwfMTm6rA7RyihZ+
	 7OkRLytlBEdXg==
Message-ID: <sashiko-outbox-176199@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] alpha: fill in pc for software event samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018-alpha-perf-regs-v3-v3-5-52be85332c57@gmail.com>
References: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com>
 <20261018-alpha-perf-regs-v3-v3-5-52be85332c57@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 14:31:35 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Context switch and tracepoint events have no trap frame, so perf builds
> one with perf_fetch_caller_regs(). Alpha does not define
> perf_arch_fetch_caller_regs(), which leaves that pt_regs zeroed, and
> these samples report pc as 0.
>=20
> Record the caller's address as pc. The zero ps already marks the frame
> as kernel mode, and pt_regs has nowhere to keep sp, so pc is all that
> can be filled in.
>=20
> perf_fetch_caller_regs() gets that address from CALLER_ADDR0, which
> alpha defines as 0 when CONFIG_FRAME_POINTER is disabled. Finding the
> level zero return address does not need a frame pointer, so make
> alpha_ftrace_return_address0() available in both configurations. Only
> ftrace_return_address(n) still depends on frame pointers.
>=20
> Reported-by: Magnus Lindholm <linmag7@gmail.com>
> Suggested-by: Magnus Lindholm <linmag7@gmail.com>
> Closes: https://lore.kernel.org/all/CA%2B%3DFv5S8-Zk8-LUpZnWiBfTGSQXthepm=
Rc_-a9O%2BpEPmVW0mRA@mail.gmail.com/
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-alpha-perf=
-regs-v3-v3-0-52be85332c57@gmail.com?part=3D5

