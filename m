Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349482;
	b=ljjxzL/1a/1SV2G+60sRAfl1h+93nuPxiKtCriPyWVmYGRTyP06mIHpXa7AphM9Bunrc
	 rVMPgvYEdAm5z99jQhenvAQEJxoxZQ4ziy8BdXOX4G4X4e1VIfTlTISGvS7aiHqeTdDu3
	 sZ+zKt5v0xXrTCIzRuX9Weae8ydCwkuk2m4psR+UZO8X6GUFthCcVeVTLgpvyKklPc4Q/
	 NfWFzBYCaeqA4LNRukTfta6IrVar7qNv4FAtYddxn51atFwR/DSegCplZoDpN08898vl4
	 eRxoEmD2NM+UeT4evNY+14yth7GC+Mw2Fzey35crim621x/l3PcXKyGJT5dQyyHhehA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349482;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fZK4LOWCMmVgMiNhSy5kFXEhDOLIk9gTpFrNp7biNBk=;
	b=hd4FNOAADzHPnQMklr7tnE7QHhJOkBj1pEeYt3+NVClLT0wQrtfLog0qfU9HZC5BSXZM
	 26JVs7lem0PkfVUXBraLSAG9GNbJb7A7MMs6oKApj5ucYhKLbQNjaMYQkzmtZw3Nosn/p
	 eB9fbHOJz5OMDAGXmTKA6MLH4VqD6Gk6ImAwZxRDCSiVNXOLa2N5AIb6JR/PJSttP5qjI
	 vkmHA2AAFTx75a59K+vwa7nURG/iNWs/SoE9J3H9KKMatVSkFsoQikl2BPG/orlGI5VMD
	 dyTyF0oizOMCPCiMZOhRxjpst15+bXDMqCi/MM9Fnab4Dt/Kgd/6vfrE+aVVT6yCYlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdnzP3J8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4114606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdnzP3J8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8240E1F008A3;
	Tue, 10 Nov 2026 22:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349481;
	bh=fZK4LOWCMmVgMiNhSy5kFXEhDOLIk9gTpFrNp7biNBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YdnzP3J88Dq7fNH+XsF5QeF55jiURA025ln63qW16UYzztHtv0Ri+rdLQEBMiCUQX
	 +qkqZ4EEXO3N5Q8zVQXHGay9ww683iVtdtaAHX/sC7G13OZCm+XUQNOwgw0K35Ggeg
	 i6DmE9GI7jRxHUEH0p0wasuRER+sdAOMHPV4A/FFVhYvkCKC+aURsc3WIEOt3v2N95
	 tzsjwEhTwiTXJyCYH/Il2/Y60BQyrf2FzzpDMx6bi94S59fxJ0u6Rm+CNuMRwoiHp3
	 LHOnei/aGAtC8n5aAMomeweo9kJTdqZyxUSF9PcoQ5nHFseFBrhiNjELfO8ggYI7FD
	 ZbvyugrTvkSfA==
Message-ID: <sashiko-outbox-207824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/20] perf map_symbol: Add struct dso_symbol and use
 for parent symbols
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-6-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:24:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A struct symbol's lifetime is owned by the struct dso containing its
> symbol table rather than by an individual struct map. When retaining a
> symbol pointer beyond the scope of a temporary addr_location or map
> reference without holding the map itself, the owning struct dso must be
> refcounted alongside the symbol pointer.
>=20
> Introduce struct dso_symbol pairing a refcounted struct dso * with a
> struct symbol *, along with dso_symbol__copy(), dso_symbol__exit(), and
> dso_symbol__from_al() lifecycle helpers in map_symbol.[ch].
>=20
> Convert parent symbol tracking across callchain resolution,
> hist_entry_iter, and hist_entry from bare struct symbol * pointers to
> struct dso_symbol so that parent symbols pin their owning DSOs until the
> iterator or histogram entry is destroyed. Also drop the unused
> perf_session__resolve_callchain() prototype from session.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D5

