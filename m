Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818969;
	b=3FijP7a7DnuspFNxsC1lywsJYl52OsMU2EHLcQg6Nd0cNyq745CeQ0kS+Q3WgpZiKzJ3
	 X1Xgx9TPt+xoXqwmYaNzquQJ56+W9/Z/X3ZyC1IYjYwvdDIFp0dNVjfg9lZ69CrpWRy4N
	 dT5Uy3piXFrjMVrQ6vT4yASYRFuuTDnkioye0aedv0la8G58BwBiMSuw49Rq5bi2TDKUg
	 +CU1t+z3DjJ6EIwE1ulj8X2sPUvlCI1dG6P8VNVgTRsNgtmL5LlooPS9wJSGq4/Wy4KRf
	 D7F6b8kzjvDs0vr0L93t59Zf2KccX7fF4730fIJOtHdP3oqdGZs2btoHtp3ZY3QqiKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818969;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hcAOY7sVFIUJcWfnTCSxtuSSQDV6EMJqHaXR62skwCc=;
	b=Q0FXei+nbcoj/GI7Z73keLJQDOda4jFaepcXTS3YMgvLDOagavvct5nFI1voq9v18xrQ
	 G2GPUBvfYxuu9vuU7yiXWUT1A8O6VVFW6FwkU2PPQMJ4mbEeHgp7ktcgF4DnbYJS/nC9R
	 4aGDuwBcvsQagr4qpxvK1/p3yqlxWRcQq5/Al5asHDUIUtJRUtQgtz6Ke6DISXua+XcRS
	 qLLRxlfx1XGh15ihqtaVpSbAHM9+ayJe2gafs8qHzLrGTAHmpAr13eY/mjJshNMMNPdNl
	 VKK8Xm4dTn1ehMeief/SMFFY62z9frjoDjFA3z9kPiBvLz4p9kj8Lscwlejy1GceUCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxBtlf3r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1FF606A330
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxBtlf3r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604491F00A02;
	Wed,  4 Nov 2026 19:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818968;
	bh=hcAOY7sVFIUJcWfnTCSxtuSSQDV6EMJqHaXR62skwCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RxBtlf3roNzBxazbeFY+9dkWyHLrNaEMTOcdSUDXtFbDaqCO3gwW/yRT5+Dgy5p/v
	 3p5l0xzJYHHUU6ZIiOs1BZha2Afkuh88SuQzW3/062zJWPH/u1LaboLud1EK54gEo+
	 rZTc6Y/GPkbwEcB2oyIBnBsMJKaEt9x6O5lsUZMOjjm3cI52EQcRQ6f+MrPTLh3Xe8
	 b4nZ82DmeKpO7soYJwQfYzI8O9sDcDPswBvbqYunkMMBh/fnS7Tt8d8Avxu0hZgfY3
	 TzEd/2wtuqyQGZLDaJnJlEzyjgjgW5fFK9fg8oUH/VUQf9Heva7+ZWTQofXcMRiTG6
	 Zwpl6LJhiUpow==
Message-ID: <sashiko-outbox-197908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/13] alpha/perf: honor exclude_user and
 exclude_kernel for ProfileMe events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-alpha-profileme-v6-13-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
 <20261104-alpha-profileme-v6-13-63362e9290a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:02:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The PMU sets PERF_PMU_CAP_NO_EXCLUDE, as the counters count in every
> mode. perf record then fails for unprivileged users: at the default
> perf_event_paranoid of 2, the tool sets exclude_kernel for them.
>=20
> A ProfileMe sample says which mode the profiled instruction ran in, so
> the excluded samples can be dropped, as AMD IBS does with swfilt. Do
> that for ProfileMe events, counting PALmode as kernel, and ignore
> exclude_hv, as there is no hypervisor. A sample that falls back to the
> interrupted PC is dropped if either its PC or the profiled instruction
> is in an excluded mode. Aggregate events cannot tell, so event_init
> now rejects their exclude bits itself, along with exclude_idle,
> exclude_guest and exclude_host for all events.
>=20
> The event count, and what PCTR1 counted during a window, still include
> the excluded modes, as they do for IBS.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-alpha-prof=
ileme-v6-0-63362e9290a3@gmail.com?part=3D13

