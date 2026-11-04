Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819377;
	b=LQxWhQ5rx630SqOzNCRB3R94AOXCVdcRQOHKtLfUIYBR0vLC5QeZ4gwec0xAPNek20PC
	 5mTJrTotJvibZLuJX1FBRM8Y5KnM5yOVVgRIbnYlP6ViW4mGxp/hG+rwUivIcNaRBuX+a
	 +11et3MwhCat/utm8MZtP5/nlj/IdSZ2XTf2FMt/eWUE2JXomD8E6Kzegu9fJRrScKWvx
	 9n0DvTzQHiTIiBqhaSLcJpha9BzR5HkF/eeRBJmglhUAYaU5cq0nuUG1Ok4MdpEmPb1ux
	 XOJD7BqTIrXRk0NOnzVIfeoa3/R+bS82U6mL7uLg3FUBP25/CBPt2TxOoOjQYh+asbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819377;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RGWR+nky4XE9HgtXkKpoViQz4G6a6Zx8FxG3HZVpZ9I=;
	b=2J8kgXK/6nJBBLvfc1KXSAkkwJVD2XB+bWn4Fjdm6zl7ViJOMFk1At9FGIpZ8yJ+NiPV
	 kh0iYs/WL7NuLAcRclCqEM/TDRtUjn8DCSGu9BudK0N7HVLuo33Oyopw0OBeQgT/fCYFo
	 jQ4bPO/uJSpKd6IV6QFtsRKqqAPPGzz4MQ7d6fiARpvCSDHCaajNy19lu47V0sOT6dh0y
	 sQcnc1G48q0zado9bHjzBYxtqjdobXiTlfhWBCgomG8fnegRRBmDU9jgubcCY0I3CuzxF
	 4p5FURLd4hEPlE4qCRtrIuXTAA26FxSSgFOQ8ECxh6RVFmJAlFVK7vhuwJRzShIq28Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLv7p1pL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE57606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLv7p1pL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B720D1F00919;
	Wed,  4 Nov 2026 19:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819376;
	bh=RGWR+nky4XE9HgtXkKpoViQz4G6a6Zx8FxG3HZVpZ9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YLv7p1pLveH3Kfd66u+sko9a8FmhL0kBD5ThJPVC7HZSxVTa3SUSHxzo7hNlViffv
	 ykJlME5spa/DuvwYv6pDcQTYoJLlZ5mugyACIq7g1fF9m6ko2ufrd+uXwXriw7dYSu
	 pRmsmtt9aW2v3FbDqyvNncGPOZp0+TdZTCD3mHB5ocSlPomrqqYLfEGKn3T1/Zashe
	 xHKAdxYYY21+Ih0MjRmsQv4ghAA9Z3BaoFkZRC6ZaR5MK52tTBy2/rpjep1OULOGn4
	 czsEIFr3xkVODcSbSGb1AUWxOqDuGpvhW6D+Ra3Dton6UlWR5wj1+rL0C1q9MVVFFS
	 K1EeZIEfGfX9Q==
Message-ID: <sashiko-outbox-197923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/13] alpha/perf: ignore overflow interrupts the
 counter does not account for
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-alpha-profileme-v6-5-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
 <20261104-alpha-profileme-v6-5-63362e9290a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:09:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The interrupt handler adds a full counter period to the count of the
> event on the counter that interrupted, which goes wrong in two cases.
>=20
> Rewriting a counter does not cancel its pending interrupt: wrperfmon has
> no way to, and PALcode clears the request only when delivering it. An
> interrupt pending when an event is reloaded, or when perf moves another
> event onto the counter, is then taken as an overflow of a counter that
> has not overflowed. It adds a bogus period to the count and can emit a
> false sample.
>=20
> And alpha_perf_event_update() already adds the period when a read finds
> that the counter overflowed before its interrupt was taken. The
> interrupt then adds it again.
>=20
> An overflow leaves the counter just past zero, below the value it was
> written with, while a counter that has not overflowed is at or above it.
> Ignore an interrupt for a counter in the latter state, unless a read
> has already counted the overflow, in which case add nothing. For this to
> hold, write the counters at most half their range below overflow, as
> armpmu_event_set_period() does. Counting events then take an interrupt
> every 2^19 events rather than every 2^20.
>=20
> Fixes: 979f867191f8 ("alpha: implement HW performance events on the EV67 =
and later CPUs")
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-alpha-prof=
ileme-v6-0-63362e9290a3@gmail.com?part=3D5

