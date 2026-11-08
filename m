Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144249;
	b=KIQWM3irLLi3EB6TCGC5/YUZp7yy8UjvySUx1LojQnd5j0VvdQ+x8AAbfSYQfnNpVNM2
	 grSx8/icAbzx1cgp2+UiAR8X+sIizcx+QPOdqk6Kqx2VRsTPXs2tow0QIhDvuPZ+BIeCy
	 gft74gec6ce8CeB21QmU8RlcHdtEypfFA2QK1AZHW2R99RvXefTudecr5zqMQv21G+NIR
	 SOEJrzdkSFB2z2cfBBBggO+FN+Q1ZZK+vOAZDk9syehc371+d3s5yHDrdRUCEgt5T3NwL
	 uIqNtm6fG3qxRuX9XxHnoEcn1e3tGQDYGj+gIS6+sMR02q7fiyPmM8WnB+NzZHY7jMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144249;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3BysjCKnOpBT1KBOqoLe9qdCTtc0iLzf3KltMHW3CWI=;
	b=BlFnXTQP/SWllKsx25pG34VnkZeSTfFhsCrkbzIF1w912dweuDw6/HRKRDgdC1wkihu+
	 RVe5LJ9afwN0diM7Ki+japLi6TGnRfuuVrlN52h7XkiKW6Kz3sL5rIUOkI82hG9DzUFpj
	 qnkZQQnTC/vQmF1vItiE28e2htLuUa8q+1sMxY2j8pUPlnzZkSmIyp1Tl1Oz4C5VsnMOJ
	 eylv4CMC2uWSrDQIi/anS1wwP8cwcpdqWzmt+eZIfxKr4/WD+Tzefo8+baz1ymktUjJDQ
	 L6RxuQ+5WTbKzYVI2hrltMjwSPjA9o2rRlHAh7lZ6puoQnFOE8HDqjF6Hqw2Ru0tvDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhV9Qq8V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26470606A322
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhV9Qq8V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE38A1F008A1;
	Sun,  8 Nov 2026 13:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794144248;
	bh=3BysjCKnOpBT1KBOqoLe9qdCTtc0iLzf3KltMHW3CWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fhV9Qq8V8OjKu6j0ulEuggHw1SSiReU1a1HSRD7r4cnngXRDQSvQnYM/09WZ/ppzA
	 Gj0qYKEUTTmLxgAlFGCMldQbWnr9xMPv+g8/6NTJPPuTyFoEh8bJvcyU0ujX6abBNb
	 pEzpphGLr1gbF6fNoDfPhYM7Yvs1I6csQvPdi1iH+L7I+EIuwGOWe8ItabJnJjHrmH
	 we+lg+beZrHrYX+80jwey/uLvw9RMS15oR3rck1bv7RTOupV5RqB9ezVuX67mmXQwL
	 K7o2dnqLkqIVZA1HDct0stBAqhugnL+K84ToxnY9ybafOCKpygInFPYnEaMgYCJZIl
	 1C2kHnmkVB/Jw==
Message-ID: <sashiko-outbox-203777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] MIPS: CM: add CM3 performance counter GCR
 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261108-i6500-cm3-pmu-v1-1-bd119584891a@mobileye.com>
References: <20261108-i6500-cm3-pmu-v1-0-bd119584891a@mobileye.com>
 <20261108-i6500-cm3-pmu-v1-1-bd119584891a@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:24:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The CM3 implements two programmable 32-bit performance counters and a
> 32-bit cycle counter, controlled through registers in the GCR global
> debug block (GCR_DB_PC_*, offset 0x6100..0x61a8 from GCR_BASE).
>=20
> Add GCR_DB_ACCESSOR_{RO,RW} helpers for the debug block and define the
> control, overflow status, event select, cycle counter, qualifier and
> counter registers along with their fields, as described in the I6500
> register reference (MD01189).
>=20
> Each accessor comes in two flavours, as the CPC ones do: db_<reg> for
> the local cluster and redir_db_<reg> for the debug block of another
> cluster through the redirect block. GCR_Cx_OTHER.BLOCK value 2 selects
> the debug block in the GCR, where the existing _BLOCK_USER name only
> describes its GIC meaning; add CM_GCR_Cx_OTHER_BLOCK_DEBUG for it.
>=20
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-i6500-cm3-=
pmu-v1-0-bd119584891a@mobileye.com?part=3D1

