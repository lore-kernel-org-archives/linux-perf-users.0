Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794809504;
	b=HmAIotP8I1LgWt8BaK21NrZkaBd3BQLrmwpFWLsj5k1qyo3vuweZen5YwX/R/+rUP8sK
	 xlMASgPqC2UMHUylnPmJtj46ctFllwKCmYMU313i/87UiMCq2a7lsEznAi+eHo2XpTVJr
	 i3IbidweEVwF1+euuzL9l4ALAH9SE+yTr5U9br5gLS3tbdhxDjls0W5fYh1DjXuBkwNmg
	 GdmQJ/zEsLPlcQkSBhRmM4oCwcfozex5AAbBEBoITZ5GD/d5fyEya/ODbuKjRYjfh63Bo
	 8aZ4FH1ONOIBah8PZBwjHeuq5EcrXpdfB8Ol5HA/XROsuhY+j+HQkaL8t1WWwF9QASw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809504;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OiQxS9JUg3bUoXbWMzoYUCtDg9ZzIMmsom1yiKz01lI=;
	b=IFFwPYIDy4Y3xsTn4u2vo3jiwcfAvc8qrtgqkr+45U8gRA4eC0Lz8iW2V0L1Pfzaxge2
	 lVHUapP+b6bIsQp3mqMhq/av9hDSn2CYdkTo9tar5zySwLnYkOg+5EvzY5TOhCW3WGxLj
	 CADmBm1bEpA7d0t9E7zj0wb5nVU3CJz55HisEccdU3wIMngSfNadAsUpE5FXXBhkYd82S
	 VZKmTFHlyRQP89cLKckEIb0vE8TRKKY/HM5kAT0zXow/eC/pSW+DyVikdiLK+Aaqy7GhK
	 MfF69NsA1Wa8H3HOEd8cwIqjsPyNSsypVUxjihRXyTEMglUoG2pOyusez8JxoFZV1rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osuIi0w5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2E606A32A
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osuIi0w5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60921F000C4;
	Mon, 16 Nov 2026 06:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794809503;
	bh=OiQxS9JUg3bUoXbWMzoYUCtDg9ZzIMmsom1yiKz01lI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=osuIi0w5h+7aF4jXA0lDmszFjHodKdcyXiUtvjOy/8pujklvTtDXIPOfjmU+FcI7/
	 AeA7+EAg3Fd/L1fbkLmr5mgx7IBa9QiiUu7ft5UzhjBaImLhSM0FzZN/5yrruda/d0
	 9hvQkbO17KTSCiT/1hqyNY4NzO9yhQUHqv9jj20aXOpYXFLtcWyJBLyNB1eDZybXUa
	 78XYYS4X2GCap7ZQYv1o4ukXIViLl5KGS0S+X4ejUxh4hLRVqzLEnyz2/1ufyiHGXu
	 5LYO0RsWpsB9EpWYcrID3uiJ59G3jTiye5WyPIp24vayY6vORb//DhZrnBeHDuVtlS
	 uYsL4gXI9F1sQ==
Message-ID: <sashiko-outbox-216245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/11] perf tools: Defer /proc lookup until nsinfo is
 used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116055731.707164-6-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
 <20261116055731.707164-6-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:11:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Do not read /proc/<pid>/task/<tid>/ eagerly in nsinfo__new_thread().
> Instead, initialize struct nsinfo on demand via
> nsinfo__ensure_init_locked() when namespace information is queried or
> entered, protected by nsinfo->lock.
>=20
> Replace thread__nsinfo() with thread__get_nsinfo() and add
> thread__reset_nsinfo() to replace thread->nsinfo safely under
> thread->namespaces_lock on exec and PERF_RECORD_NAMESPACES events so
> namespace changes are picked up without racing existing readers.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055731.7071=
64-1-namhyung@kernel.org?part=3D5

