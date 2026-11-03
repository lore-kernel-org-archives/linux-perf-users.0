Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722165;
	b=O2thbtKX1YfOCy5ZoeKXHE/oQkgUHcQr0yao8iILNUZ5n6hCNSnWjtCWyPUZZ+cpQjS8
	 ydMFiQQnfSnPu8RMBLvZsjV/0lU6Ji/uN1y87D/JYCyDBCTcuBeul/lO3jAPkV/nxGFFf
	 uY/aFF4aH35SGMNkEA+qbuScUpQ/SrnHpe1CZoaoLO3M34cnjrHwA5bOmOACqRJGP7lbp
	 AA8vw3gU0QOQA6mwg1kzzOGRL5W1KxXNT6kGYCJUtQhLaTyOFzvq1vHBG7Tw4GdkXgcjk
	 wxLlp/rVcaDYSa/BNg1T81c9lsYezxlMEFvmsANtLIb0ocV5vb5GOaJyQR6KjTzZ77g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722165;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B0NnXHfORAPsMBqu7/mwObmMEG42kUE4vdWho0el4Rg=;
	b=t4SJeHtQezDzlVFDNm+TONE6sEL2+EV32TpQtq5HYSBHK7P3Y+oWcnwDw4koO6vifPZC
	 yhTj+RfgX4hJPJUdr7WxDfHS6Xd8rmtrTjtEhDw5L9SpygOGsCJW0IekW2BFL/DqP3tW2
	 PBm1AwC1WjAY3U+T58Aoa4gVcZSyDPPKChKXbPvqDaRxShhNvRCbnDwreGvRUdgCXdIMq
	 9FqOVT63vlqwfmF1J0dARVrIGWxy8+GD7eSob28mlE/1bd2abIltY+sgabuJ7OxxM3Pu8
	 lEsIVwnkyOaIvK9MVRsstTkY4C0sm49Kw4oHbmFbSiL2QoyqTomfIEUd1Pbg2Nw4pSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpwSce2F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D9F606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpwSce2F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7461F000C1;
	Tue,  3 Nov 2026 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722164;
	bh=B0NnXHfORAPsMBqu7/mwObmMEG42kUE4vdWho0el4Rg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VpwSce2F0SL0sZzMWHw0y5FkhJMlATc68Fya69wpg6OpoF9Ww81ajOOVjF93Q4T90
	 Nk83ohPPmWuv9FGP8G1bYQFpGt76skYdxEfnUQu1KjhBKj9+F44piaIGdJR1Lr7Gv3
	 z/nYxBBgZPcHDtRS0WRrU4Phzi2AOei3CqEm7mrg4H9wDh4peZnh3b4cN8oFjUY/vs
	 CICT/aUFKdsUPXKz+P9X2HpxgAuygmmdYVXSLQECSHqh/0dSMvFfV3JC3TgmIVsRM2
	 cdlCtohgAkWoC1Bo85jqDWkWoIVB4BxsoN19M7gecU7WF8qul+O71dbozgMu0O9KCS
	 3ZT0a68tp3E5g==
Message-ID: <sashiko-outbox-195702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] perf dwarf-aux: Add die_is_compound_type() to
 handle C++ class types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yanbo Zhao" <yzhao62@ncsu.edu>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103155650.269973-2-yzhao62@ncsu.edu>
References: <20261103155650.269973-1-yzhao62@ncsu.edu>
 <20261103155650.269973-2-yzhao62@ncsu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:09:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Introduce the die_is_compound_type() helper which checks for
> DW_TAG_structure_type, DW_TAG_union_type, and DW_TAG_class_type, and
> convert the existing open-coded struct/union tag checks to use it:
> - die_get_member_type() in dwarf-aux.c.
> - is_compound_type() and set_stack_state() in annotate-data.c.
>=20
> The switch in __add_member_cb() also handles unions and the nesting
> limit, so DW_TAG_class_type is just added there as another case.
>=20
> Also accept DW_TAG_inheritance in the member lookup callbacks
> (__die_find_member_offset_cb() and __add_member_cb()) so that member
> lookup by offset descends into C++ base class subobjects.
>=20
> In DWARF, a base class subobject is described by a DW_TAG_inheritance
> child of the derived class DIE.  It sits next to the DW_TAG_member
> [ ... ]
> This extends the existing member type resolution and data type
> profiling state handling to C++ classes with inheritance without
> changing behavior for C struct/union types.
>=20
> Signed-off-by: Yanbo Zhao <yzhao62@ncsu.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155650.2699=
73-1-yzhao62@ncsu.edu?part=3D1

