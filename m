Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBEF34389F
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791762209; cv=none; b=bx0gVMPIx0Y+juO6/tiI9jOCmr/v2xGY8zBkN1WK6jeLp5pZnXOYL9vIrTukM6VoRx58GcG/FBdF4yC3E70bnSHYqI1HZU3XFAaxlcGrpdNzX5NnZxhcZl3WCX5511u61UYoqDvktHGrsunRTc1t/ETCpqaQvkbDKupRjIg/EgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791762209; c=relaxed/simple;
	bh=dvjbvEZCCptYGDRh+Ufg7HnIDzQZxfOCyNxAJvtggWI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jAQbC2ILFG54WqFANBQMk8xONu0Jk1G3sf9m6z9qWNMNbG6JKJ9Zx3pRW9xJSsPnojNN1W22bl/EZB/Tl8jsuxhQLQb1SW5uqmidEYIPFeb/ZmmZSTkujzTDDxVFx92W5uf0rGZ/suZeKkN/Vd7mY0mBwbTPjL8pqIoYTvYBIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktMrwC3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktMrwC3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505251F0089B;
	Sun, 11 Oct 2026 23:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791762208;
	bh=dvjbvEZCCptYGDRh+Ufg7HnIDzQZxfOCyNxAJvtggWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ktMrwC3SnyLw2A0pRzN+Xug/vIKyXH/Z5RpQJh2GruMGgvHL9ZW3nnWwnHdPoyex9
	 Cu/2Jq57Ffc3lehGEio+wSbcSGtA68jsRQ15PX3K8aj1LrPJqjjoHGtSrZjaONrxul
	 Juq8MU8s4lbbp5UIjlSJlNfym03seSVl5WDG3KDtX0C41oCdMuLdzPZp/sK0vSQJRS
	 6gf3u/WLqWFNmjARbFt9Iu7u5uf/HpkKzh4uyUcDZKgl0INd4yF6BFAgVhw2LSbmbY
	 NAudWoBjFnAp6USNeq2W3M7tK2qefXGG8flV7XmCFHyxwZVLsRf70ILVJALNcf1HD2
	 vv2TPoul0Sn3A==
Message-ID: <sashiko-outbox-167519@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/6] tools: build perf in tools_build
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261011233647.2454648-4-sashal@kernel.org>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-4-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 23:43:27 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add CONFIG_TOOLS_BUILD_PERF. perf is built as it is built standalone,
> with optional features enabled when their libraries are installed, and
> with -Werror following CONFIG_WERROR. The feature table is left out of
> the kernel build log.
>=20
> CONFIG_TOOLS_BUILD_PERF_MINIMAL turns every optional feature off
> instead, so the result does not depend on the build machine. allmodconfig
> and allyesconfig turn it on.
>=20
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011233647.2454=
648-1-sashal@kernel.org?part=3D3

