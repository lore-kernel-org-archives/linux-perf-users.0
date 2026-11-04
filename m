Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828033;
	b=HpgdEdnsJxkWxLI2WkLA0It+hecpu/y42dvSSRHo5Mo6iVv1xjVJWANZVvWbBjXvv59q
	 LKe5k1kPh2QieGg0Mcb7BVGs2YdUbmFD9VLxm39jJXp2Rnncjlaq7XtRRLMUixj2f3YFb
	 9s6hTBqPNoC9dQsYhis6FBG8qFLk1k1z8xzCeVNeqrGyeaILarDMU/lB6HclLYoRV783s
	 gN4Gc85fhXCfosFuzZlRLXo1XE5tcXQ61/iHtPNjyIYdnn3oeKlQD6GTrKN4V8ABnXHcz
	 Gjc/ilGBsN37RPDMMFh3MleUt5o0aK66800N4WGOusADi/YqVtlANMYwQrF2+OhkNGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828033;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4df1eOc+YbpNNThOk28FAlrf0bvZqvZVtUzsrfOQO88=;
	b=MUN6aDqQfZwEDT3eKT9a+RaR7l98ecmy7rfAJ58k32diIzNeGC3cDVtgySqJBRAl6wSl
	 ttWNqTmZtZyX7n6Rkwwu9TlPnTRZLDC8SdeCoRsGE0zqPIeN2YN/1R2+41gQ27lSO6MxE
	 WBb6i5eC1M+XZgINEtp0Y9STYRcZMiBz4Om18+voha23Eyj9pppF40Eynu05OqyUEp7fN
	 /vEnKTo+liQeQR9a2UuXkPL9weUlMbfjBkHLDWhPRCvcclvsN37GLhJf8sxNHOGWsCyLO
	 iqi8plENnRETcc/ItXUT/03cGnPQCUeFMJH8LHDm6A9yBT9Mesyn43T6YctYtwWiCEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLVTfBE0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10C606BA35
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLVTfBE0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC1B1F00919;
	Wed,  4 Nov 2026 21:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793828033;
	bh=4df1eOc+YbpNNThOk28FAlrf0bvZqvZVtUzsrfOQO88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TLVTfBE037XJYdI7iMFwYjkr3oERAarwWTNSh9EcMNEbjdTgHiGgVNu2im+ZO7rbJ
	 FBCC93u6jdwJ4XfeYZVvPTFrW8g1jKaS6reihWED2eFgeuhK5SzDTArxnP+ERxQ0mG
	 Ksi4s7eTmhfLg/dKEL2TkiNXS/4Pol5eQXiejpb00JUqE2T2LNoTVGccLiunA6hbyH
	 UZRZMkSQWImvlcK6lzo+85MMn/oQtvvPz8M2JNOggdrxjpcmYOB/ictcLSt968fHBw
	 zTqoogtZWvn2Xp55Sag5siJbgnUGTzggqWVGKDBRhvfEJkRmfzqwFPkQAdHVRxM80Q
	 vqJnovIV6g2Jg==
Message-ID: <sashiko-outbox-198118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 17/19] perf config, intel-tpebs, env: Add
 __guarded_by and __must_hold annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-18-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:33:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __guarded_by() and __must_hold() annotations to static parser and
> config state in util/config.c, TPEBS state in util/intel-tpebs.c, and
> bpf_progs and cgroups trees in struct perf_env.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D17

