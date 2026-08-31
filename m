Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323EC371899
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212130; cv=none; b=Elqm5fFUys1Gu4dyZL4Gbmo0N18pP9IqXHiOby65lzdoAeiieac3vlhqA4xZMTVOJtPNRdDpQTZ0p0FmAZ71oKbGEKMmd+qsuxoHBbYSc4M68PqUPnPXPxOI+Wg7K9l0W1lp/PGfkP8SsSdO1yE2zOWST1uq/9tg31hhZyGe06I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212130; c=relaxed/simple;
	bh=XMT6O/0uHqSXF0X1GZP4ItDvSrgNNBjiUsDm/RIY5J0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JoBXGkrGiUzyQBcMfaFFR2VZEkAl/hEd5EGW3Z+tjqM+h76NwTldG4WAWfYHxvawuKyLcgPxNY5BmRKm+pS62TgmtLELbAc7z70dAiMVc6GK90cv/Xp+rGW9UGUDEx9Im1/vmgwxihQPiX4qOut/xRyPeW0oFM0s6+3IJIrY1e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF/Gckxx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF/Gckxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D0F1F000E9;
	Mon, 31 Aug 2026 21:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788212128;
	bh=XMT6O/0uHqSXF0X1GZP4ItDvSrgNNBjiUsDm/RIY5J0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DF/GckxxkarxJC8xZ1yaKDWBT/IvdsOcM+j1woVIesdU6r2eYLDtKRhA2MPNMK8Xo
	 86B2paQvVA383OooBL1mm3eENMgVH3OTaWZuUmfw955kATW7QnUc7hjOSf8XGJ6xY+
	 oP8U8QcRdJArU2m94inmgir6JZgmXW8zHIMLhwxkbOK9juTXO3TJquFK7ho/O3ns7F
	 B9klzOwVP97gfr18xe40QaWmgA8pgB5Yp1Qq6j0RwN9LoYB1jYPap2/vOvALVDOyUc
	 4nvi5sXNGrUC3Z0tnmowvM/IwxJTkCB6IBiRHaQE24hM/WyDDG/Nk1r/6v6KJ+TB8I
	 ykMfiiXaUqVDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/14] perf/ring_buffer: stop using PG_private as AUX
 page high-order marker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zi Yan" <ziy@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831-remove-pg_private-v2-2-3668159cd9e8@nvidia.com>
References: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
 <20260831-remove-pg_private-v2-2-3668159cd9e8@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:35:28 +0000
Message-Id: <20260831213528.B1D0F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> A high-order AUX page sets PG_private on its first page and stores the
> order in first_page->private. Stop using PG_private and check
> first_page->private for AUX page order only in the ring buffer and its
> users. This is fine because page->private is 0 for order-0 AUX pages,
> matching the page order.
>=20
> It prepares for a future commit that remove PG_private.
>=20
> No functional change intended.
>=20
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Codex:gpt-5
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> [ ... ]
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-remove-pg_=
private-v2-0-3668159cd9e8@nvidia.com?part=3D2

