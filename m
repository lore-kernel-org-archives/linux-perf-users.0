Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946708;
	b=U9XwnufEP8ui8eBsc2rXlvcXX5Zq6SBvHMYuU7o5BTRoMJ/GlWAoNqtJ2jHMMQfLhsB/
	 SKaXxUN6juplyREjqSb10xnZLn61AazuHHd2ow+dlGV12R9+DkB4FUhMD1959UaOmNPV+
	 Vypr5s8Fn1mYuhH8P/tWus0z3ovdcGlIQRl3glk+2cdD2kbWIi6zikwVnKU7QD9k4PXJ6
	 SdfN2F4r85npNiHJtXy9AlcWoxgwkB/To/FlwTnk+8rYZbVwhJSbv9KZNgbsLAulBzw1g
	 Lr0g70fOAgzB7UkNfhcSp5CCbHr6qc3BhmoJS/kSVQuOek4UbUwWTFaUYuz4YMQc7bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946708;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MdAetJAPWloaSb15D4ym1Bll994F2u5LGdDwlDGRnPU=;
	b=sk0IwDl6ZFNmV7+cAlz6rVViyOpMZ80fHYkq4CznXiQit9LaNerMZbPwgGddsK6zawb5
	 pThsT6Jg2aajjcB1V81WTrFblNOKdjc4uWYK7V2B2A4EfDCrx83GsMGQKNT5PbjsxdRxH
	 gAGJXZZocICh4kih6tkFCED0/RtSaWVbXbmr6Lm1y7sYvy8ELoyppSupHDpHhj31g0Mn3
	 oOoHl/rRDiMtSxtf1suFmYUxUVRJgp8jZidKWS5itUjJdzcYlYPLbQfccuE+5SLnfJimB
	 S4mbzpG0WeHuzYYhlYg8ajJcT9FbS2Nq1GTx3Kakyee/Q/n7kuT2WxEW1TumiKedM9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgJwUw26;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238C6606A32A
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgJwUw26
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83C51F000C4;
	Tue, 17 Nov 2026 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946708;
	bh=MdAetJAPWloaSb15D4ym1Bll994F2u5LGdDwlDGRnPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kgJwUw260SG7saQOVZGNkkOwDjOZSE4nPe7R4ssqOq7ReI0GW2La8oupcL21MxRQs
	 NXFFV/D69krld0lY/wkxKdWI8vJ8KFyVvU3UGWqGZrZ2h3w8Q20WyPvSV491v3duI7
	 xkLQefKeFXEFtyQz+uNDh+PhAHxEvKMChPdQAqtnRbmpI7DB0R+a3iGywaHtJJT2S2
	 sZ2ePlHkL4OOJAlm+P5L0od0GlAY0I70VAEk/RlL+3KX0RQcn3VUGZ46hxlABIRmHq
	 JGRasyOXoN28mMXuhjrPDBf4S+9hgE8tt0PKvwGuL8V8+bPnBgkBhMO8+TmtlvMC94
	 cBu9RdErGLO9Q==
Message-ID: <sashiko-outbox-219587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/13] perf tests: Fix the Intel PT virtual LBR check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117200433.45174-12-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:18:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> With one data page the virtual LBR record loses its AUX samples:
>=20
>   Warning: Processed 29 samples and lost 100.00%
>=20
> Use --per-thread with 4 data and 64 AUX pages. Its single 276 KiB
> buffer (including metadata on 4 KiB pages) fits the default 516 KiB
> mlock allowance, regardless of CPU count. Also require the Python perf
> module to export session: importing an unrelated perf module used
> to fail the check instead of skipping it.
>=20
> Fixes: 915d6b14dc0c ("perf test: Migrate Intel PT virtual LBR test to Pyt=
hon API")
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200433.4517=
4-1-acme@kernel.org?part=3D11

