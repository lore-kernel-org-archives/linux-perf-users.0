Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163771;
	b=CnqVl6q12Yc/YLyMaHuI83t2ZaKsCVhle9EgODF4NOrYDVo7CGsYqO72hSfe56+66R9f
	 3Ybhp+O4cFKYdmNw+DIwT9UqZt/4ENSRjHMxxk+IhF8d5HTxQVg7RUzZCgjE1XSas5DpP
	 I3qsUS8QkaGM3qWLvOL2Xtao4gRX3Odj17sOen7op3phV45Tr4q7V7qLWA5FO+iF8JdBQ
	 MGpOs65fklXVY0lkrNGErFSfzQ+zIPVnVXRp5QfyMmRdxFaqNBJd1XdtryOczQYKlierK
	 oMeVdDLQZORP7NB5jdPilX+kBGYMIakSyQta+PakC/qrrh3UPSVOYaxEAiG6GHapLsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vKFOAwKKRxX6KT89GEQArTofVGGsL0ndJcg9QO4UQgo=;
	b=FJZ14DWs/4aKK/P7Lbc92ZdEjjvRDvJS19MOOuzDrsZ0G2VFmqafi3GR566Cc0X+JT8V
	 bo81S/5FzsHz0tpxIBxsLhRLLr42pQRT7BW6Ky3HO50lyf0OjAvh7yNVtHAkRZoUJRAOI
	 PF3UxOv9EBZcZfXc0y7Nr5jo48/YXkgCCvFEF6wOQ6h/u/JH7o34zTFjupa2vF3luUukS
	 FTGQwIrbpgPf7t6nxWpTRNQ2TWkPzKmROhmzayF7jyTaiq1ZjihjKvyVHj0rqXu1l7FJo
	 Y6vyYTjZy0+klKBVlXkvAnKVtOgmuqqy2GuvCf2bj1zzoqUAz50Em/VQtQpVbrxoG0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c42evJMD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F38606A31C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c42evJMD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094B11F0089F;
	Sun,  8 Nov 2026 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794163771;
	bh=vKFOAwKKRxX6KT89GEQArTofVGGsL0ndJcg9QO4UQgo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=c42evJMDhC5AoO6FrI8uGDx5o8ASqr1lJvgXv2STAcjOplI8epaHWLSyewMIwGsw4
	 y0XudM69NkNa6p4PLIC1AhyLUjSRqbNLfUEXTLhsqpjd6dpWU/cRVW9uQmhswgr/TF
	 AZ1SOMyisqJ9X2ZQAy0QsZcwhdPh1K3z081P7A4D25+zNlage2MhodRyZw1ISNUblT
	 pe6YCaioQisXwSkhjioqFyOhmiVHyGnPNMiMPVLDF77DfihnHJVgoNKDmqOub3fedR
	 3mkEkeVTddL+fNlfcIphd9pv+/DzFk59obLQ3M7knL6weP075ozLyGxAI8lerQuKGe
	 WmlJQYaI3wKgQ==
Message-ID: <sashiko-outbox-203914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf vendor events arm64: Fix typos in event
 descriptions
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261108184654.3811267-1-takano32@gmail.com>
References: <20261108184654.3811267-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 18:49:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Six entries in common-and-microarch.json spell Statistical as "Statisical"
> (the SAMPLE_FEED_* events), and one entry in the Fujitsu a64fx table, the
> L2HWPF_STREAM_PF event, spells prefetcher as "prefecher" in both its
> BriefDescription and its PublicDescription.
>=20
> The SAMPLE_FEED_* events are inherited through ArchStdEvent by the
> neoverse-n3, neoverse-v3 and t410 tables, so the misspelling reaches those
> three generated tables.  The a64fx pair appears once, because the long
> description is dropped when it equals the brief one.
>=20
> Spell the words correctly.  Event names, codes and expressions are
> unchanged.
>=20
> Written with Hermes Agent, an LLM assistant.  Running jevents.py for arm64
> before and after this change removes 12 occurrences of "Statisical" and t=
he
> one "prefecher" from the generated string table; perf was not rebuilt.
>=20
> Fixes: 994256a79867 ("perf vendor events arm64: Add N3 events/metrics")
> Fixes: 5497b23e870c ("perf vendor events arm64: Add Fujitsu A64FX pmu eve=
nt")
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108184654.3811=
267-1-takano32@gmail.com?part=3D1

