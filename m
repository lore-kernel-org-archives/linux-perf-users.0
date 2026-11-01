Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793564227;
	b=BLGe2Qoi0Jvwsr7F93Sfhfr4JS2zN0Xn1LCSP2kFaTJNMF0TXmidNDQb2yIWy3ljotSV
	 rJodfw8S+7X0LRKRc6j35dY0nWBYMBYu3HntAcpNofd+Y0T4xcN+36uYWgu37/zN3eSsM
	 CYSwseX2dQfOlCpZ1e586+XCA05S3LA9hhnSyZhqfPjS7SWm5R/1hrk0DvCuHHlnMGdhn
	 6cvpmzldQM9EUyQ46z3wYn7FhpstP49zX2ut9MzCaxOvy5kVC7hoR+hAiQPD2hZQqXncj
	 fWhD9VwW8rmT0LZH0LIK7c6fYYle4bfa72gh0tepI/hqWy3rU3WRZML+aKFnalu1fbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793564227;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1ZCilPZOVJqcqoajAIkG/L/cOW0tv4Ddj9ZQx0ens5A=;
	b=hDWwKTYXSYOoESPLldtOtNSW4XwIRsbXQFnBG4TieMNvcmNKO1Ahu/XUb3rxqbyGTddR
	 h2vSnJnr6RZqP0wFDwHqxJjgOBSA1VIbZfmAV7Sh5jidfXoNeU4uqp8brfElC7Hr5PEu4
	 mK2yr7iQXas9bp0UNwKfuakXutz112n1VemI5DrpWRMkagOXEAkWLY7rI9iDXtarLBxtS
	 QqUWFNDcbe0cYjILCeZNr+B6D2K6B6SqXoJ+OFLyPujd8aXidPGYrfna6cuC40Vjlk6eO
	 S2UtBBQqiaiJ4jb5BavUvOJqFrx84PecnXiYxsvO3SBPnpWMhiGoLHrf+EUhbKhc/Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lp1071Tn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE431606A325
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lp1071Tn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C39E1F000C1;
	Sun,  1 Nov 2026 20:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793564226;
	bh=1ZCilPZOVJqcqoajAIkG/L/cOW0tv4Ddj9ZQx0ens5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lp1071TnY8OE7WgbmCl10IOosj9GbIEHtw+nRf1PcA+rzrUZw6ehmGnjtlhGHN7/m
	 FlWOeSmTOgfasifAv8ywDhrK7YucjnwNMUlGJGuoZWJ3TA6NR2rAYILABN01lGQkPM
	 qqV4VjcLNvqk816X8xOighOfx3YD+SqHO201QiXFLh1OY1y1vuoJM8DbSYbHzDAA4J
	 HnkdfkqcnGm+hV32IO3Wkmcuj83AoHQRAK88OJQnFBgJW98NktFrbkE11uzHLBy9JP
	 A06XcOKinyz1f8PAMVozytifgPLzE39RPG+XDtK00cC5GOe8YsEwBfNcga53B19ztf
	 fDIRuO7ZzYpnA==
Message-ID: <sashiko-outbox-192660@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] alpha/perf: attach ProfileMe status as
 PERF_SAMPLE_RAW data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261101-alpha-profileme-v3-6-92d511b5a044@gmail.com>
References: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
 <20261101-alpha-profileme-v3-6-92d511b5a044@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 20:17:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A ProfileMe sample's PC alone does not say what happened to the profiled
> instruction. I_STAT and PCTR_CTL do: whether it trapped and why, was
> mispredicted, stalled, or was killed on a wrong path, and what PCTR1
> counted during the window.
>=20
> With PERF_SAMPLE_RAW, attach PMPC, I_STAT and PCTR_CTL to each ProfileMe
> sample in a versioned struct alpha_profileme_sample. PMPC is included
> because a PALmode PMPC is not the sample's IP. Killed instructions can be
> told apart by PM_KILLED_BM and VAL. The 64-bit fields are packed after
> the 32-bit version, since the payload follows the 32-bit raw size in the
> sample record: they are then 8-byte aligned in the record, which needs
> no padding.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101-alpha-prof=
ileme-v3-0-92d511b5a044@gmail.com?part=3D6

