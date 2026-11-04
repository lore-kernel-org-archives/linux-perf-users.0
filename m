Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772245;
	b=DT/ex8cHxHl5qSM+VZRmmUAh2jJh/l4cXcSFVF5xcpAhiXDzWLZ03olBqH7oQHbq5zsf
	 UuT5Ump5o4z95kAAmMMWoxCiDp1xrfK24LNGA3el/vclaf2wVfXmSdZgLg5s4J6ImtCfU
	 pQ0FzudxPwfSVv2KwCez1J98IdnE2t7WMtWpvvSxjJEBFlLuXnPpmTHUFu1CP3bSfGJeW
	 bUmOSjRgKI1VhRrhGjRPAcSqf/QpXEcV0N3sau8hZTay9vqwlnq+70bbTklXnHAIoJTZY
	 S/guGkmlomDSBjBo82A+oNrHPi7bYp3g4VW5EIlLvNew8kSQVYLM2JadWMkiKrKzmpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772245;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yBqMptpBMW8kx1xcvim4rjjHUDYoWK0DVQECGqbpeFk=;
	b=EM7FWn6jU+aa6Zzd5G7+6f4f6DqYjmpuZbb46QenmB1tAi0Wv8K7vKhnenf86DpiAERu
	 YtsPO0ZADiWGlUTT9xnLwWC18FlpfqDDXa3Ki7Yn+lNNMDvFIhdxho514yTTa2GTH7uyx
	 ul+ilm9JYw/CHg1uIM9K1SUdbhqrBOuQfhfshDADz+T/VHUyxWL5eZ+JEEsPUP48hrwgv
	 Gtsiu+CjH6/k9FD8gJJZk1xYZd+ny22YAebT83hpmzTSltkGanpjWPAXB3L5/zGnFmAwv
	 tkav9jtE0oo4R5DwBj3f0TdW/8/HjhRLa9orv01u62ExfEGms8xRWm4Nabm0AE5YUXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EFPDB5/E";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD976606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFPDB5/E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906FF1F000C1;
	Wed,  4 Nov 2026 06:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793772244;
	bh=yBqMptpBMW8kx1xcvim4rjjHUDYoWK0DVQECGqbpeFk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EFPDB5/EQpsoJleUp9/HbBfPBBVJ3MZWU5/ZAx5K6FxSL2gqGjzVhY8WOApw55r6i
	 BCAFMNGqY4q5vYrMFRai6Ius3OR9s+17ggTiPlySla5NE4qQgILoaOdXCrXnekgGFg
	 KGKo0HX4BihRwpLHsslBX3KzS0R2L74z746z3tnfMwfdBnxV5ijCcGkeVYNbZSo9vi
	 61FQh3NBw7k4HVLM5AWadsYDQz43GP+UXOpy73lwiq95ovIjrvGnPSfNva4fBj5ZgE
	 /huGzAB8KOGBevri8MYwX6HjkzbBaxGuhWGkoMstBAyGEfe8QRgnF4sFeBAQ9tqVsQ
	 j8EjL+SbduTWA==
Message-ID: <sashiko-outbox-196721@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 31/41] perf pmu: Probe privilege exclusion modifiers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-32-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-32-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 06:04:04 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend perf_pmu__probe() with test_exclude_flag() to probe whether
> exclude_user, exclude_kernel, exclude_hv, exclude_idle, exclude_host,
> and exclude_guest are accepted by perf_event_open() on the PMU, storing
> the results in struct perf_pmu::probed.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D31

