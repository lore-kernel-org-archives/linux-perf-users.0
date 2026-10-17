Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DAC35DA4C
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247535; cv=none; b=FwjpBl/TKgcthZZm0eUzf8I/7A28u12IpPnmAc4sqGkSubo+E8i4BP0tnbfx+jI3kkepajdxayLLCJrLdt0QBOMIAaR/R2RIsYrFVqKKSctvdWVQVTmEhLucSCK54kYLU5LQU9zj8VClyY3GkeH8DJuRRW3TAMGu26+zrGERyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247535; c=relaxed/simple;
	bh=xnkca4Rm730eLjCZu2gRmF6auz5l3/JbHIThfm/og/Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZIfu5wFEIa+ZRV3vXqsjtQpxGs7EFjMO7e8iJziiyXHB/7enYuZL5blq/bKM5shuDU7lMoQuHnE13frNfs71df7YTcSbQC/DkviYtSwzkg6XTkWlKU4wPAOa/cBK9FYVQvEnt2WnH3lNw6qw+wJAMsshYTbTx0C2KuiuwS3pDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGCWcsMU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGCWcsMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1251C1F000C4;
	Sat, 17 Oct 2026 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247534;
	bh=xnkca4Rm730eLjCZu2gRmF6auz5l3/JbHIThfm/og/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HGCWcsMUWV0oTHr4MpF3U43lcTpQiflY1uN5iSdcCRp0Hr9PyP7s09WELcNFBwLnp
	 PiEimEgDDPIeY81QjDetTI1gCP1LQmvzqQKcXBvthygpTCrvzZG+PzLhSv3icPqp7y
	 VXinT6hiW5oMafuC0Lvq2rAmCz29vOLOKWYbDh0vg7xGlr4ZTz9KxIC9NO69oxucgL
	 YBRZTzBPlkFa4FLteOBLuIujrFgv5/25iPO8udmeDwUvFbYBr2cYmIHwaL3KKgBSvJ
	 YY7yYwGEtpKy2RQhXH9pgeCoAo6tArelli+C8KB48iFIar/S7KC85QEjQyU+KUW5rY
	 RWXe/BMcjjiyQ==
Message-ID: <sashiko-outbox-175557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 6/7] kbuild: build the tools selected in
 tools/Kconfig as part of "make all"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016143143.3613501-7-sashal@kernel.org>
References: <20261016143143.3613501-1-sashal@kernel.org>
 <20261016143143.3613501-7-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:32:13 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> With CONFIG_TOOLS_BUILD set, make "all" depend on tools_build, so the
> selected tools are built with every kernel build, and allmodconfig and
> allyesconfig builds catch changes that break them.
>=20
> "make vmlinux", "make modules", single target and external module
> builds are unaffected.
>=20
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016143143.3613=
501-1-sashal@kernel.org?part=3D6

