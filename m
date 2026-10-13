Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8B135CB9C
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896963; cv=none; b=meV8s40T1iYAnqbvvO2+M0VjwhJt9bum2AbSjJ0dCq7/tRjAseEBzseG6+3CB+nob0UDBEtEoeH3dix3YwmjvgPbA5G+cWnTkqdSxoKwgz3t3XafrTqLiLxSlKKgIy2so8YMI4TrFESbuaScCNrSMivM6Y9/tW/l/WQHy4TJSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896963; c=relaxed/simple;
	bh=Zdc8gSjpfDa17AUP+0hcV94VmRzeY0F8lJnkdtggkTE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OiK1gyq0mcx95rLszlgazo2yhjn5j23/f42nsqkwSbcqu4MD0PDyAXdBFuYZb/FTHwoIqfixK0hcb+cLNPmwgJwEuj7voSroxDdWRe4BjDMu0j0G5DiSJ4lA2iAUJMMMT6kD3GxeKOXu6uVt13gVSIy8QGQtRsXiiMdyYufVMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBU9bk1H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBU9bk1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D9B1F000FF;
	Tue, 13 Oct 2026 13:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791896962;
	bh=Zdc8gSjpfDa17AUP+0hcV94VmRzeY0F8lJnkdtggkTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nBU9bk1HAEufRbuDJBQHuc8OstFCKWzlE9R2myzPa4gQBUmJU10yoa8eylUVZl7lq
	 IOjKWVXEPEOrhsmd9+HJEsAMUPGTYNCTT9fo0Y2YVenTfWIDJAPNxf8pIRnmq4hYgl
	 y85b8Hc3NSwAN3cFBLWtMwBzF8TVb/ShP8GYORv3RJEpvyVlFP0pdDRltjkC5WB5p+
	 Cf+QduZAoJ7RFDmowg44V8SrQAK31FpYdJLUgzttNE5JVEdQcWKVUsYnO4RxZ+4Ib1
	 4SSGQTm6qR55qHpbD5QArfOZ+SqAnD7jxrhyhMCjFM/qWz9aLKqtGjY5Ul2dYbvw9h
	 swMdwWrf/85+g==
Message-ID: <sashiko-outbox-169775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] arm64: sysreg: Fix the names of two misspelt fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuad Tabba" <fuad.tabba@linux.dev>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013130247.4135515-3-fuad.tabba@linux.dev>
References: <20261013130247.4135515-1-fuad.tabba@linux.dev>
 <20261013130247.4135515-3-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:09:21 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Two fields in the sysreg file have the wrong name. In DDI0601 2026-09,
> bit 10 of HFGRTR2_EL2 and HFGWTR2_EL2, which traps SCTLR2ALIAS_EL1, is
> nSCTLR2ALIAS_EL1, not nSCTLRALIAS2_EL1, and bits [39:36] of SMPRIMAP_EL2
> are P9, between P8 and P10, not F9.
>=20
> Rename both, along with the three KVM users of the first. The second
> has no users.
>=20
> No functional change intended.
>=20
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013130247.4135=
515-1-fuad.tabba@linux.dev?part=3D2

