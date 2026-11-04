Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819454;
	b=SYkvfHY2h7s7IybXbuFTt8Tr2pDPe2yn3GCRt2VSImUjBUbDL6otgFQouN2MoxDwr0DJ
	 eoo9bkjh7s+yUpyDgeRpQUISNfYsPhKfstygwMwS8DzoSlfrdV38WpJIYhYzY9wAwa1Oc
	 IHAit7xq5uq5KQaV9FPixduX0sipQaxu6Q9zHlXAWJPTWSnph7bSploZza8MMntv+BF3l
	 goELdy8aThrKgnPoMFeNk4pa/GuAqNZmBYM5x+pjhQPiCFMHlzjz1Tq+fAjV7c2IE2DOO
	 s7EhQZIhTifu4JW3JHKlGzgJxSSuCprqya8QE4HzXrugLra0T0xXIqdKYeFFU+9wkVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819454;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=quXPJLGKIchgKPiIO3f8isxxl665gX28P2sTOConoZk=;
	b=mWFJ+XIfhRZ2skSz74oF+tsHdDcpKwkj3D7iWjLC9I4U7UsRgRumbIeqb6wJmszxFKM3
	 tHgfNsKTfCVuguFuhnLGxUB5FAYRcQiP8GK3qzCZG/YC61H9/N7aYlpQdIRzOAOB9/Rk1
	 jtWYs0V2ysF04YVjjZvJGQGykd021mWlWHIFHunwtlsNFYb+5l8IQi3S7wcmqd8lS6yY3
	 jBXNy0EmQlAeBpOAqtkC3SDGAghWiwR0iXCf0Q0PQQcsrllkfJNzobwXzg7h7Rj5CxVrc
	 nNLojNUkhEDYljK71mhgMX9i9d18+x0PgVSAKgjpPZo4nmO5a8nXTr5NHbjE5jcfvMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoBKGu4l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355C606A329
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoBKGu4l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4981F0093A;
	Wed,  4 Nov 2026 19:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819454;
	bh=quXPJLGKIchgKPiIO3f8isxxl665gX28P2sTOConoZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZoBKGu4lsUqRszr8kHtlaJ5kBTB64LklPrV8pe0sOZ+xmT1Ga/tdWX/OY1fkzbVNf
	 KjH2OkJ4OoEtAy05CUq1TSKsDCY5MpCgAAxjJNAUP6SeI6hGtdiCVbE8FhDsHdPHRD
	 4XuRpmCVudqkH81KWV4qIepNGStx9JNHwheQud0kGmeQxEqhlrvGhuQ/Ze1PnmsLRJ
	 dbk22CRgmLaLAVIztY39J2EuckUy0S9tJEvECosVdqDItYtmFs9s6BjQBj8oRABGcv
	 IzoId235kRsKs44dA1S0FyVGLJr58mi1AesyHEFPClQPLJKJUYmhB2HCS+znlLHO0Q
	 u8Irado1qnIAQ==
Message-ID: <sashiko-outbox-197925@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/13] alpha/perf: sample only retired instructions
 for precise events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-alpha-profileme-v6-12-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
 <20261104-alpha-profileme-v6-12-63362e9290a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:10:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> ProfileMe samples include instructions killed on a wrong path, which
> show up as hot spots in perf report although they did no work. On an
> EV7 loop with a randomly mispredicted branch, 19% of the samples were
> killed before being mapped and another 48% later.
>=20
> PEBS and AMD IBS op samples are of retired instructions only, so make
> precise_ip imply the retired filter, unless filters are given. The
> profileme bit still selects every sample. With cycles:p, both kinds of
> killed sample went to 0%.
>=20
> DTB miss samples, whose instruction is aborted, are then dropped too:
> cycles:p reports DTB hits only, and the misses need cpu/cycles,trapped/p.
>=20
> The kept samples carry the full period, as do those AMD IBS keeps when
> its swfilt discards others. So in frequency mode the sample rate, and
> the event count perf report estimates from the periods, fall by the
> share of killed instructions: to about a third on that loop.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-alpha-prof=
ileme-v6-0-63362e9290a3@gmail.com?part=3D12

