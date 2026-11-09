Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258487;
	b=3YH7t46zQ44v3hidTbNjhAZT8fEQA5xa4LSzsbwFueXjJehqyQPMgWdJrRnjA8BGcqHk
	 VzkHwSF03QuXaW6EXJjfmO4a4CibAKO4oK2TXh7AFQYBJpsHTH9M6+gmwJrHZiH3h7jHs
	 7gNE11jULnta1ipl6uXtBB2qLKrFSKPrBjTevqEEVpn0fBZip06Z+afJmnId2ypmqXyPR
	 rcmCo0Mw7P/pDSd5IAXP3yG6ScBeeTaT2co1n2ZPNi/QcAAjaz/g0j5AIyCpe5/d5IUhV
	 c9ph/SPs5ax4leHiCWFKvLZuLSrlIrTKiHRRAcwXSiH9zo6o08eTrC+CwNsEcCozo1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gzxi804KRISpE/3KTSpr4WFGyZmIbHr1S1v5fgx2Cro=;
	b=gk5Td10uFT3cO9rjGBb55WLJlH6Q5DOG0SiK9pg/NrEsR8cV42TZA0i/kwYNNkd3xNAV
	 cAPLmHTtIgIzopY5YwLvWK14xooZFgBbpgxrSjiGdwu0jsvaYAM4gXZZmpN8KXbHrSx0K
	 86GtKmfhi5xyEC3Hc7ZthiRN8LqFJEK5phhxJZH9mceo10gMs+u/M4E1zaBTZtcXs5iEk
	 8bgY9g7I21YJxUP8xa0rsOTQMDmvU4qXNJbEx3EdICQpxG8NO7dlepdUuPXI3P6eh41hM
	 0o9fN18Li0MJZ58iol2z6ZyNJZInzfn2Bo0d7vT38TsULJ0OsiAsIhK7pKOdw9OIAbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGzHhr+i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC8E606A32A
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGzHhr+i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994191F008A5;
	Mon,  9 Nov 2026 21:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794258486;
	bh=gzxi804KRISpE/3KTSpr4WFGyZmIbHr1S1v5fgx2Cro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JGzHhr+i5WFQ5bPjcrHeWhmHc10Af2+iHPEfS1kY4Q1QoPZxeA3a6+JOMFLWUduiZ
	 brO9l7DYyeCOIxNZCtj941bVtvZaOKNxKlSXcy7fVnWHIsqfuJ3fUG8goqUKTVqAzw
	 g5mXZyM4yXkgxsvIETJmgr2r6BpCaKtSpXuiG3eYWjIUc+HVpMuI+BrwTxErClRDTA
	 JOcB8W55T3ZCjTrW2HZXqtW5075VrqPLFTrDTedGEUZYuUaTu9pV45U8IaqB+i6YG6
	 euwlSgQBCRjPYYANwNZT1ZZH8joQ3DL2AQfGo5TmIZNcEmJWxpAHyY+g6FAdFeACYM
	 Gjbnyxdbj6tWg==
Message-ID: <sashiko-outbox-205630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 09/20] perf dsos: Ensure DSOs in auxtrace, machine,
 and symbol are in dsos
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-10-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:08:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Place the DSOs created in addr_filter__resolve_syms(),
> machine__process_ksymbol_register(), and maps__split_kallsyms() into a
> dsos collection so that all DSOs that may have data fds opened or be
> referenced by maps belong to a dsos collection.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D9

