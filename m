Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249503;
	b=UiCSOKyHC0sDY8RoFI6i3p7lRVG0phjDBjIS5vGePINp3HhDJxK6BEXThU5V8jXOYFs0
	 /wplpW30pTVYAfOdpBLwAPFXE3XcIx5NPc+dxAYlanHDv3zS6tdmjLYMcL1sIUpTk12eT
	 vZjRZEa8W8OlW1KKoDSae69LcT2LSFWJbeoQMK7hLte4Uvux1d0JRNtQJSlVHhmZ+Tj8x
	 T2O3u/khxaxwGGRH6KJSZbnJVx3f7JrguAZBWr3EZbbu5ZM2HvZ1SgloT89/R2vIjNYz8
	 fm8mJChj1rQitlcPzuMekDfYMII5vY8edEC5asU2ouBowVSL8NRT04ZdJx9evPzx7qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249503;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SeM2kIi23Lol+fONckS7Yfvm4ZIrD7w89Mhqm+5RgH8=;
	b=A5HMLqDypLZ+fHPGzcE/ZcwJh4Hfx9vVK5e5QmvthsHBbhKL3GcPoDwuH1HFRNGFn1NB
	 2ZfPHr4380Na3u9sBr78ROKvHvrThvi8njn92ztHUJbVcF/upJfgR62/wct+R31wbjuK4
	 xO3WUNx3Rc/YikWE9L7VVjmMqaRn2Ww7hOzkzjzQL/ptgClhoXUOyecTG2oBmTNeR1VmM
	 9QLYc4fhSo4RJyAiY2gyxSHnK+3lruTjQXOtkna11jH71hm0ddgeBqMQdToclfTgr3vsD
	 W7xnjoTSNrH+aVJAHPboI8h5wRowtDbklYrNYDttwoN46AJfkqBEdgsZd3q8R7frwvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ns6S4BM0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1DC606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 04:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ns6S4BM0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640671F01825;
	Thu, 29 Oct 2026 04:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793249502;
	bh=SeM2kIi23Lol+fONckS7Yfvm4ZIrD7w89Mhqm+5RgH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ns6S4BM0+R48hd29+dQ4AtGsTHek2b+6pX29tzQLBp3RBjMdMmtSIHbYWORXgbJoj
	 qSEmb6Z2UuDRgNdrtCwvw+SrB8H+9lKw/NSjXOYOWUUemi+D6+fNx7wPT2upjFH4Am
	 N57+Nbi4jAiyW3yCys8kIEhxYzlH03aVLqEz7oZ+VCjV5r5NJC4m0yVPJ4yQ72Fwj6
	 KsLwMCI9REtSWuq/B4twgqB4Kc8519XNDzXg2ogEdqQOGlUtjcj/hdLwqUnrmmO204
	 UQ3xRvLqKnCRrK7AQ3D77cbzsoFH98JLJ+xu0rOA6Nqo2PxxkHzGVPmQPKWZdmbXM3
	 qLLTppYs5TShg==
Message-ID: <sashiko-outbox-188711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 07/18] perf/x86/intel: Add helper to enable PMU
 without LBR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029043914.1395147-8-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-8-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 04:51:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Currently, __intel_pmu_enable_all() also re-enables LBR in addition to
> the PMU. Split out the PMU-only path into a new helper,
> ___intel_pmu_enable_all(), so the PMU can be enabled independently. This
> helper will be used by a subsequent patch.
>=20
> Also remove the unused added argument from __intel_pmu_enable_all().
>=20
> No functional change intended.
>=20
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D7

