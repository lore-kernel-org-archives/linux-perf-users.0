Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603040;
	b=nWwjTEsJIihBwB2UzEs7gzWjwWGEguZbxMoXV6XGSad4LJBDUNC6BAKRa/40rBXEZcKt
	 58rpgRlc/bcfHXCJ3l2XybezQqSZKoN/VPeRXWRAiI8c0UptkFBRQf6cEjmpiZZJnLTwQ
	 Y4JVdMorHWmbIWXJSAQPIpzlomspaMN2/6ylHMAulbFJHAff1NGifVQ3vsNyh9wnS+x92
	 F2qBVU+mxI78k+zESfX+JQKZiEDhp56GyPhDB0VMtsVsJLOqehwKzNvMbjp48DQI/gM62
	 tvUMiweoFSUbXMRPbEw31DMBy/2kj6P2Ev5UHwmjZUDprf1qu/X0fvoBzK3Z+/nVpBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603040;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2DGefEOymJEnZvnMzzUY7pan/QdOIvFr+i+yultLfm8=;
	b=Mm7vShGz9h+/7OFA3CKUpK5XrauNV8sPMa/ANVNwx8M+ww3bz0H/13L6wSoLAhZw3XHf
	 VP7v/ZC+iISCK2pmHqI63l0LOI+CRfSRG3kFB4mwXvJmJY+4EpNmOsj4cgB5cdxTTlhiG
	 rrHqzB8/+aEDCWNCqqf45vjqpRYRc9o4BtY/G0YO7PdDjKdTWe1bx/pltcjIwUjvs1JAy
	 y4C0w43zzb5Wp0lahbu1631E20aknRRQ9SLWj90UtDiQiTwgVyJikvkdCvpyaV8q8D5B1
	 kDR3fvwRIjScYz0B3BrQfHge0Vm3cyXP2rswU9Yve066JodCxsr4t7sQ6ybed4KfGZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oswV2I4E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F1E606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oswV2I4E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6F21F000C1;
	Wed, 21 Oct 2026 17:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603039;
	bh=2DGefEOymJEnZvnMzzUY7pan/QdOIvFr+i+yultLfm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oswV2I4EcwSjkY9SmeJVQaMJDLlrGtVyn+zTdJOmgzu5kXvJX6LTK7d3TBokT5x5C
	 Sh73cwnIyywe3M5AB9kBFozhwCNiYnb3byz4ykxBolzoN34PdNEn+QtiD7KxbIyGTZ
	 9/rsEo4tc7NqIW3uOrOtEGboHpge4+1JoOIrdeNKuhSw6M9QyUB5nPf4n62txSx7Jv
	 s9RmTSWP9pdHQ1Ze+Tn9x2zfDIPttsybx2iOif4sbxDZykll1h1Dwzm96iNm0//7Tz
	 culDfVlcUoJMcKE8K8R3aln1SdlZmAunYKILKoYlndvqz548NZHvNoyCcZvEgckabM
	 6qArW83+kEC3A==
Message-ID: <sashiko-outbox-180507@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/17] perf dso: Expand context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-12-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:17:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate struct dsos fields with __guarded_by(&lock), annotate dso__data_=
open and
> fd_limit in util/dso.c with __guarded_by(&dso__data_open_lock), and
> tighten __dsos__findnew_id() and __dsos__addnew_id() from shared to
> exclusive lock requirements.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D11

