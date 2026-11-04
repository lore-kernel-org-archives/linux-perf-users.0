Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758667;
	b=bKqEoEeNGCoDRyYJXeLHtcdCXalR/QdNnAkW3/QjA5utfyCyZL7XGxuOfKECzVJFAEHt
	 vwCPPTiH2qYQuPT9iusoirv6N4kryshdrc/dRrnjlbOXUeA+h8ecjbuZEuLQsnOcreHFs
	 rrJmx4Ie8OMRapTvyCZBBdAebyCjyhQpUlxgUh7QPmgViAN4YJGZr1SnGKlKBTfPXPAOd
	 6zwelaKCn2PlqP1u3I8yGiV2W1BYVzDUBpa9wKvb/Ef3p6Hd+xdXBOiptdNsdAJ33wILo
	 Bpy6r/Z6UGbRc5o2yjJvepySzbroIEr71JzXfJK2k88M11PunPC7xAKrAuLVCvREhUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758667;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SKE4tg0HIehRLZe6TQbRsDuh/O8n8hoR9oN54KlBoeM=;
	b=d0GVL7DBqozMDI6nSy0fDem5sVPzUC4n43YkiswGhBN4MH+KG6LW09wLzxUqeO/R/7Sq
	 RgAtoKZ4JBHnu6fCodGN3w9EUs+hF2pNBsHVQE6xLjKm7QTeasdYP6XK2//SHnoLJF2QD
	 f0mW8PR+wrOUzOejvkeTklpIm1wzPnQhnUnRnAqHfsLVYMiYYM+HkY2fM1PS1rVKTiRP4
	 d8iam19IWfbkvzB06GZGUx2FA/3Q3jB3zznHNyD5cxi6XjgrcZngTuX32xTgVZMaxb7Bq
	 4uxXDY00o0WoS1POmUl6jrZYeXUILITlmk+XkIU1TyxBlFMfc9+7OcaW9WDzxm1GsDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSohxhG8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3301606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSohxhG8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DB81F000C1;
	Wed,  4 Nov 2026 02:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793758666;
	bh=SKE4tg0HIehRLZe6TQbRsDuh/O8n8hoR9oN54KlBoeM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lSohxhG8VyNMUVi9s6GU2E7uBxIr3jK5B+tEV0DyRwa/AxHgRcQ/Nf+gPu4moc7Ue
	 UHeDGI940cs+fHtScEnM5Y42Q9bQnectHC1EZSUq/n40VxYRfM2Z9EHSNkjpKqiO0n
	 GGWssudr5tjsPpb8wLKVIASMJ+ZvPTRQ7i4riunePy+S1YM/7hFqAPpAQSFf2akxNu
	 U7MNm+8MQ+nMMiAIvVZdgoQO/spyqeacBpfhsHBBLzMWOFpheUuK2DekWkjwuZuBi+
	 J5GKN2F1ighZrsCX8B8DasxfDw+EC97+vjLEBaLN2npQHHfmVFVhF5qgF3f2+5QMNI
	 ch+/GY0BqGU0g==
Message-ID: <sashiko-outbox-196438@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 14/41] perf metricgroup: Pass struct perf_pmus to
 metricgroup__for_each_metric()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261103234502.1008382-15-irogers@google.com>
References: <20261103234502.1008382-1-irogers@google.com>
 <20261103234502.1008382-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:17:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> metricgroup__sys_event_iter() matched system metrics against uncore
> PMUs using the live host's PMUs, so when processing a perf.data file
> from another machine system metrics were matched against the wrong PMU
> topology. Add a struct perf_pmus * argument to
> metricgroup__for_each_metric() and use it to match the metric's compat
> identifier. Callers pass the PMUs of the environment they are working
> on.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234502.1008=
382-1-irogers@google.com?part=3D14

