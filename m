Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793428786;
	b=4g/4iFNXwXSS/SmNnz0ig/xa7pTNVOflba72Z0phv8xCNB68PN1X3+OvgCw7AbaROayS
	 8+h0XflpsoF0Mfu5kSa4QFa8C1+jLV+8SB7LF5L4dCz8pGOj40u9zg2fzEA2mcmXk+7oT
	 XZWMbIMvX9y0XnOG9aA+QMn3SUJBxzDS0xBiH6Bk9tk3zm6bifVVIhR3OqoMNhxzslBQn
	 7ed8Stp0ADKJlN/JmKI8zC+oK1VlsfbAnRrR22MXSBKQVFohld3nOeZp8XzG3Hfc8ipHj
	 /xUXXqMvL9Ts3oXNJ6Sj5Z53T0C9VS4Dv9I0QgHDw7odLvOMzEnOJTtx9VX082sDmlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793428786;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FE2Ng23b13p2UwZNwM67njLd/pDQ8OMR788QIAkXUA8=;
	b=IquiM+oI6tDjkTUt1AHcq646B7nW1ji4jQES2yod8rkd9bMJt4STF+jlwwhWMuRPngoz
	 wNqT3uVyVXGcOt+9W+mto/lxgJX9tu4KbNtqetCk5Q1loEeo5NiZHI2L7op+Kz+fV8Tet
	 6bMXd/+uLx/sEng2ro2sl4OHgDsZQFbO757hqudOPvGiMgit+w3bgiTYL93Bg7DRzup7/
	 q/vmzjxjJl4hK57ISv4WGFo/ZNx5ZdEMd+BqpIVMQy/BcCdCNcz9F9cyf6aELgKTJ4/c0
	 szHkH6rVxRReB7E2p2CgWHuQDCn/aIJ1MslDn6tCfblvzyq/U3wN1Ef3vbNYBR2xzaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTBu17hT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1140606A31C
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTBu17hT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7741F000C1;
	Sat, 31 Oct 2026 06:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793428785;
	bh=FE2Ng23b13p2UwZNwM67njLd/pDQ8OMR788QIAkXUA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WTBu17hT/vt4zaurpWxb2YCHsU1abzokG3dolyywfa3drX2SyESDVxH2oZ4NypQKU
	 qlbVK7QdxkGKsvk34MECO0Fh019NwpgY9pHPUaDDjRE6jC8juK/KW5SNisB/UVfTrj
	 zBPmkv4WYRCnX+tEq92XV0+FI5utJHiEHZK+Bp7kAp9v3azYXyT/Fh+zqbgPNttWt9
	 6oZT2sKm0WWt0Z2MDk8c8HUx4EYdKTy4y6bcUZxe97+J0OzfL/sU7cnxFKBvEMISfb
	 mFf9XU4v47ylgmiNlWPQEPzJh1ab2KGbN1b2tbZJ7SdTmYujCUQIG2xyIPrkAnPGW2
	 L9VP7EBgnlALQ==
Message-ID: <sashiko-outbox-191784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf callchain: Fix loss of symbol in
 merge_chain_branch()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261031063549.1281324-2-irogers@google.com>
References: <20261031063549.1281324-1-irogers@google.com>
 <20261031063549.1281324-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 06:39:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Commit bffb5b0c0976 ("perf map/maps/thread: Changes to reference
> counting") replaced passing &list->ms to callchain_cursor_append() in
> merge_chain_branch() with a temporary struct map_symbol initialized with
> .thread and .map, but omitted .sym =3D list->ms.sym.
>=20
> As a result, callchains merged during histogram collapse lose their
> resolved struct symbol pointer, causing 'perf report --children' to
> print raw hexadecimal addresses instead of function names and inlined
> frames on merged callchain branches.
>=20
> Initialize .sym =3D list->ms.sym in the temporary struct map_symbol in
> merge_chain_branch().
>=20
> Fixes: bffb5b0c0976 ("perf map/maps/thread: Changes to reference counting=
")
> Suggested-by: Alireza Haghdoost <haghdoost@uber.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031063549.1281=
324-1-irogers@google.com?part=3D1

