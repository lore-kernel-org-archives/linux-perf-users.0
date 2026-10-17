Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE35325771
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202344; cv=none; b=XciFZq6CZ2qVfygFhuI0XWWDNfafx9k7X9Wd1cy4+B1XTIA7c/MnLjhrM3yfKdZ9jd7qa26ta3I674mFwFYz7x7LVaWneVonYZhgfNEJPIve5Cl1/t82WR/q0/U8XuOMuFjFtr43iDTC6Xw32twRR2vtLRiGrLViauQnbJkUAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202344; c=relaxed/simple;
	bh=ztVgcdaYr1p1YE4pId1stB4ckbhMoE5VyPuWuODsh+A=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ls2NDCZfk76NQUgs2z2IjZorQpK7/4b4P2c1PSR81jTHxaxQPjZvppkhXTq9TjrYHg78421cMe2J5OY22BQpRH9gxpwrqaVdqncPbBClHTnE6vhipDYkcufyQxnM3WVH15ZTAwZKJiEpKOGJolErGU1lUoISMg9f/TAm3P6RO5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFE27OMw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFE27OMw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE2F1F000C4;
	Sat, 17 Oct 2026 01:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792202343;
	bh=ztVgcdaYr1p1YE4pId1stB4ckbhMoE5VyPuWuODsh+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dFE27OMw0EXgAeY8ZBn7XgwK3eXtuqynu0fV/p7HJXQV0NqnbWL8hMKXsUcqYdEW2
	 y3ArWDHNVrpWrIWpYmvd81AulUaFlGPJ02gI2T+mgHjbr635i8emMGI7QkP2OaTbQO
	 TExJ9xo/IjbKwurAkrH+U8/W2/BHGMaB/rOqdBkrSU0OUIgVeBZBBoYdJKeUmPqXcy
	 +bjCFQhlSkPlZtYcUzE0d4GDCaP3PxnVgDhUz8u1QgrZUgu1DJ0I6GmQty4Li5eAmI
	 QlOTPCsLjM3SY5Yy/HKqU8XJNZUJrBjsKWZIPplh6IAuKpgeJEAUriFosy4ho3k0+E
	 C4F7gaefE6OkA==
Message-ID: <sashiko-outbox-175169@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] alpha: fill in pc for software event samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016-alpha-perf-regs-v3-v2-5-17654742226a@gmail.com>
References: <20261016-alpha-perf-regs-v3-v2-0-17654742226a@gmail.com>
 <20261016-alpha-perf-regs-v3-v2-5-17654742226a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 01:59:02 +0000
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
> Reported-by: Magnus Lindholm <linmag7@gmail.com>
> Closes: https://lore.kernel.org/all/CA%2B%3DFv5S8-Zk8-LUpZnWiBfTGSQXthepm=
Rc_-a9O%2BpEPmVW0mRA@mail.gmail.com/
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-alpha-perf=
-regs-v3-v2-0-17654742226a@gmail.com?part=3D5

