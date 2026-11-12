Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523912;
	b=iC40TD009gtDBDa2FS05dEW65kEASNWJ1JL3Ay77UB8Jk3ws3kf896RfAbHUSagrgyqq
	 D4UYozAydr1+VDmA9cB+quwep7ZWjlYTwbTayYMWv4t1z3igtcwYguwdSm9loi04iPjLJ
	 XpguzNEAFEZG9z0+8qRXDCmqsz3vEjQuZKd/wO8Eua3Ca6AzzujVpW6eu6XRm9vgPNTlj
	 lOaDO/2Kmpm6iO9ziWBVZhLjSm5gGdn1vUauUS30d5OFuNbx9UqZGNh+TtNjnWJ3Q/q1J
	 XF4zkNPjq0UFqyeFHAhsDD82vKfx7SQYDi9lSRmOo9DhUt3zkJLfO6tzaCa5HdWNVQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523912;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mJ9TKrrZeP7DmT74WQ0Qi9X+bYmhW1WoKDNWqLGowxk=;
	b=X+AaClK20StemMVwcZxrpPirZdiCleZlnsuethoVwv76ETZKTWVwIvMA7HQOMdl1pRIp
	 WzHB9CoRsi7ouKwxaQG/xraHit+/roReYB2kfmHPJf6MSNQ9sUbw/DqhwuVF3JTGaQfLr
	 HIbTkvNbo+ozDv8o4Ja/J51JS7zAjdX/nxh+O5Q72eALVKfsDO1ml3uX7pxJVKBaCWmy3
	 Ldt3nl5R53fYLUxBI/2wNrA55AkvQ9fjhglXLmG+E0hCVSqJ+yWXa7FCX5MR3JKh8u5Yq
	 /hDAcyR8uf88+OH/6qnx4N09sOc1YTYaFpNd0Q7K76nrlL9xwpU4ls3l8N6JI3CvSXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RWvtO1a8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE05606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RWvtO1a8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692891F000C4;
	Thu, 12 Nov 2026 22:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794523911;
	bh=mJ9TKrrZeP7DmT74WQ0Qi9X+bYmhW1WoKDNWqLGowxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWvtO1a8hQKZB5Y+Vf7OcGItIXNA5BqvQwuTGp5/lwqv72EVVQfWPphaY4ApQby9m
	 vZckzXTJa3DxpJgUdC7MYoxnjzLphcgejoJmKF0qHY+bkCZnXm2BPxVrsyjw2xE2Ql
	 OgiqbGZ/Lmkw6YlNfrf4R/rQqwCzcZIL96Km/R+HekDBlaxsWXmDoqwqvhPo80lLpo
	 +R0XZstJiwotlnjPAIpUSbwDEVn4EQ2B4DiwwgzVrwcOee3GBxG3F+0BNNCEoTc0FA
	 GNfzNa9HcvONLQhLbjP6gbCrjtdi04Hhzk0JWUnhAyZUo7dhcHLiwBW7POCVF/pZkL
	 vWTwjIu0HubcA==
Message-ID: <sashiko-outbox-211923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] irqchip/ath79-misc: allow COMPILE_TEST builds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112224445.213324-5-rosenp@gmail.com>
References: <20261112224445.213324-1-rosenp@gmail.com>
 <20261112224445.213324-5-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 22:51:51 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The driver is only built with ATH79, so only ath79 kernels build it. As
> a platform driver, its only MIPS-specific parts are the performance
> counter hook and the call to spurious_interrupt().
>=20
> Add a Kconfig symbol that defaults to ATH79 and can be enabled with
> COMPILE_TEST. Build the performance counter hook only with ATH79, as
> other MIPS platforms provide their own. Drop the call to
> spurious_interrupt(), which only exists on MIPS: a cascaded interrupt
> with nothing pending only bumped the error count in /proc/interrupts,
> and the handler now just returns.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112224445.2133=
24-1-rosenp@gmail.com?part=3D4

