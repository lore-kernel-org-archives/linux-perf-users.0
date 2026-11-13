Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604812;
	b=OfEcH6eYLRhM6NcCm0rsbJP4DB6ivQtFEt829tmVvCQlqFyutoV/LBEU29IPIEAxHV4l
	 lu/02d3hlzmpkIxWTpqg8+PIkC5rG0c3n3QycKljpgR4rc6EL+XtCWCapJ5QPQwuncfQ8
	 LBDapUF0hLSLzPPNeKuyrsnQmmAQs70llu05Z0eCEQF3Cd5QmI8vDwvY+F0li0eXJOq+K
	 FgaC+Zue7F0qZEYHDKKhHQQ7CFkTQ6XnESw37mvdCCRJY9xZd+8g8QB/bTo8fOKLoTzM7
	 PoaCITaYnY6et6n4/WcaBbTTttKlSm/jPEEFO86Fdwkj9bpM2j8JRsULPegd3AN6sow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604812;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cA5iqAch3P5s5XsO3UuaFq6XXma3ZCRymrCNRTEjSIk=;
	b=tnuVy+AMjKVjD20eDsShUubcGrkuZSEhZl1CZ5Gr15a6Zzp3jBN2IaEEeAm1WVX4Aiw8
	 AFQTj/spDessV1rtn5fvAxRUqGtOrQY3rWMwGb58udnJzTTZZfIcEoEPOMX8rkvP2chMZ
	 Ngjpk3CF6RmYO3DMO5BUxN/U+EWmzQezXH3+VLudlZ4qwCiV5HXuua4GZ0TIdyDc8yVYd
	 AzJUxUSK22xeW9ssfMgFEOwYPgNPeNjxyrOtYf799Mwzmep71sPvF7PIiOmcLod38z4HH
	 bheDyaQefEdhpd0ACpxLJWh6I/jG6ye5Rp8wj6PcgzjJpL3BGW8Q2gL5p9gGNsMRV4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEGbb1Sv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F2606A338
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEGbb1Sv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9611F000C4;
	Fri, 13 Nov 2026 21:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604812;
	bh=cA5iqAch3P5s5XsO3UuaFq6XXma3ZCRymrCNRTEjSIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UEGbb1SvFHU6fIEYXOLudgQeRnD4XehWhnqPf+EQZcXFeuQuNZeO39mRuajxO9nY1
	 18K1dpPLs12depGUObjcfRuvIr0c38sWWithEkDvwnyRoKzOLbv1RDTJA59BPT0VzQ
	 LRrh+kTC0YfxWY00BkfyQ0DyqAwLTE4djkG2VOIlHX7BRJHpAnfEHj0wPif0lsttSJ
	 tDwlEkmBzyLflZsNhELCZX19qh2Vb1jSnP9twucYuNL/bRjo3hoTs1RwwPZU5HQocZ
	 FLiO8p23SFrVg6iQ0+sKByVGtjj+ZG1SxE2WHCSM3Q2HJt/BUFLvZjQE5JxZF/Jaz8
	 G028xx3o/YRrA==
Message-ID: <sashiko-outbox-213710@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] perf tests pmu-events: Test metricgroup
 descriptions and concurrent lookups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113210822.3112700-10-irogers@google.com>
References: <20261113210822.3112700-1-irogers@google.com>
 <20261113210822.3112700-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:20:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add metricgroups.json to arch/test/test_soc/cpu/ with prefix-overlapping
> keys ("group1" and "group1A"), regenerate empty-pmu-events.c, and add a
> "metricgroups" subtest to "PMU JSON event tests".
>=20
> The new subtest verifies exact and prefix-overlapping metricgroup binary
> searches via describe_metricgroup(), validates metricgroup descriptions
> across all core and system metrics, and launches 8 concurrent worker
> threads scanning core/sys events and metrics to stress-test lock-free
> block decompression and shared dictionary initialization.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113210822.3112=
700-1-irogers@google.com?part=3D9

