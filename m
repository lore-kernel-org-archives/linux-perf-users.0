Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232595;
	b=w31rI8N6AdzP/EVlsyBBC5Fsz73P4g26zTsSadJte2eI9op00At/SpyKREj//b7xWcU4
	 I38k14nkqpcYVbO8TO/nGKuNlm7niojrabwySr3FPRlkhi5E9F6m3xlISfCBlw6urY/wI
	 3SlQQ+oXlTcdr1wD/ZnBeex43bXKNbTn0hgvw/DU8H7zi3pzifrYxbXy8aUAVtUNnU1ng
	 c5fW0bJi9ADccM/p57XyptzLp4ryn3oGnzUQN0Co8g+pH+wv142FFP+FYZv8TrprOwDcP
	 fcsQR8MtSxqJiaL7MNCc6xHOgdeDTAzstxy2Rqw/LpYgw9QXpQJ4XK++KF43cruuEqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232595;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VbnWRrnXdgWMnp2TuOuO/zxaq+YM5Xn4WmQaYrrGJwE=;
	b=MRadjpML/SMrzwfdo316oZgfjxQJnu1/ULcUjXa82NdpxorLbwyHQs+vvtNBXwsYcfVM
	 05xd6n01Rlcaq/WEQHiTKnh05jIxY/RRFKDPASIatI4CDi3cOdOcL/P0OAWldyyVJX1Pl
	 6k93n69AGIJ7YjDvyrxx1vAlQrq8+6Gv7vh2hV2/Vd/E+R8FrWm03kS/E6fIiTQEfh7+S
	 u4L7g5l3pYF6oC6cQpGxArR8RUTGpb9uP9VRhs9M7CurB99ip5QkrFTVKhVeF1n/s3hXc
	 MaGpTzciXJi/nUHiIndgZNEX3GRfzvnTjw4o6+oFgmmp5TjP0fkJgVXbDBO7ZG8iGvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKQ3PV4Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CDB606D802
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKQ3PV4Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD5A1F008A6;
	Mon,  9 Nov 2026 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794232594;
	bh=VbnWRrnXdgWMnp2TuOuO/zxaq+YM5Xn4WmQaYrrGJwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HKQ3PV4Z1sE0HzUGIA/mnFVKjDuWi93wNcMKGpq1V/7HLxqfa8lZYZX4brRGjuavh
	 2sCa/pTDyGchOmG/3dAKh6zCxcakPt7Wkf01Zn8XuIE4vaxLm/bmpeAtioazjDQKAz
	 XldtZdN9GP9265hrF/JG3q6BJ8YwikOn6O6fGGU9C2FF/YcF/KtLa4X6lBfLXtrj0U
	 XbiWW2rskRhPmeKVcIPNbvDBHUUozJy97wnBVfXQnW063ChgebID7dLZM63+tn8N23
	 cfagXHNKBdX0IlPIh+b5H6irSMlMyAa8kIHurmWDgQtAI0PWvw3bBpKMT7ibfBE3kr
	 wppQ01nkOy8tg==
Message-ID: <sashiko-outbox-205042@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] perf libdw: Find the CU by iterating all CUs
 when aranges are missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109-james-perf-test-fixes-v4-1-355ee6b81917@linaro.org>
References: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
 <20261109-james-perf-test-fixes-v4-1-355ee6b81917@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 13:56:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> libdw__addr2line() finds the CU with dwfl_module_getsrc() and
> dwfl_module_addrdie(), which use dwarf_getaranges(). In elfutils 0.190
> this only reads .debug_aranges, which can be partial. For example, when
> Perf is built with LLVM=3D1, clang doesn't emit .debug_aranges by default
> so the lookup then fails and no source lines are found for most of the
> Perf binary.
>=20
> This used to be hidden by falling back to the next addr2line style, but
> now missing information stops the fallback since commit (62d7cdc8d587
> "perf libdw: Optimize fallback logic for missing DWARF").
>=20
> find_cu_die() in annotate-data.c already handles partial aranges by
> iterating all CUs in .debug_info and checking them with dwarf_haspc().
> Move it to dwarf-aux.c, then look up the line in that CU with
> dwarf_getsrc_die() and use the same CU for unwinding inlines. While
> [ ... ]
>   ---- end(-1) ----
>    79: test addr2line inline unwinding : FAILED!
>=20
> Fixes: 88c51002d06f ("perf addr2line: Add a libdw implementation")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-james-perf=
-test-fixes-v4-0-355ee6b81917@linaro.org?part=3D1

