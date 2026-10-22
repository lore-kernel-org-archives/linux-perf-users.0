Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637906;
	b=F0ReBQQcRmC4/CP0u5u1I7GtbjN7QYQY+GrgZoBTg4lE92Qz41Hp8Ef9NY80dXL+Mvwz
	 V7gMHvQ9xnnNrBOWSAjKH7R2OQtinMxVFrXTq8ulaRl/pieqZcxMxPp3XygtWVWH9qG4R
	 LVO71/wMvsJxXOyJfSHE7oZ1oCLoOaViCcl4LHOrV+4QJtcfFDLk7FYztcwXeDBGeFVfp
	 yzQEfrbvrboP+d29z6bMzMsBv0/vY0SIIrZuXtYc25knBYySpFL6qZtvnMW9UtU7UENHt
	 v9ZLFTpcumFRRwmo4gq/YEqGxPHlE6iQ0WTKa2+c3T0As/Zld4wAK0ilKXT7OaTqmgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637906;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qd+OrL9+TIsU9vj9ri/4+qZOXnh3xKnoqGMh1JLFu3Q=;
	b=MyADQyp6Tnxu1cHV40wyVA+iqSNAnpu5sDWV4DvNQIwSrRywzm/sO6Gd5cm+/tHJkmT3
	 ZmEkrcxBxa2tgf5OsRU5H7TTe+MoPfCARW3w3GuuJ8HcGrKzhNKt5wkNwMq/5OUvQU6T+
	 FG4N58nSrneymxO7M6quV9oenZuEejf9jj+v4juaD3goR9r/t/vYewHymoVyZ90Fr6SdC
	 5hVexTdnlB+j/DHeiLQ+xutJovPBbjTThJDDn8m2N+cnihMDDO490nUTOcErfmVfVs1kE
	 bVQgX3VHRjO1ZOVnhWVVX+PjUXjCSYWjTVaT+6xxOI8H+Fd6ogIuUTQpwA0fO1RGDuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHIsPkUy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A4606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 02:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHIsPkUy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140C71F000C1;
	Thu, 22 Oct 2026 02:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792637906;
	bh=qd+OrL9+TIsU9vj9ri/4+qZOXnh3xKnoqGMh1JLFu3Q=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=eHIsPkUyebg5RHKTEmB+Gh/DYr96HRMxHxy6+DWW1o/eJWEsaZLwDdcDwejGbErk2
	 nV6OyKVmWFD5Mq+e0qljIoNXXq9jv1wT7N+dLyVa5PsMyRm6OzJAktqygdPf8EEeve
	 +v2Yo7Tc4Bhebs7v7bkuW5MT4chcqYcEJIVUkTT/gIyUKqyJf23inRRianejyQiIN5
	 C+7eS8oDLbcTlSXhYnQIGlcHB5Lb2uLEiRUDdcf9jybfziBLWA0mZ4gdEWVC0AQEv0
	 eZHwz6JSlQqEH3iw0SIMOG87tKEoRH3X2fiNN5uFGJD5m89KumA5OPDrhUjV1xO8oT
	 WJxpqtqwRv3CA==
Message-ID: <sashiko-outbox-180891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test: Skip the extra metric line for
 stalled_cycles_per_instruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261022024950.264235-1-takano32@gmail.com>
References: <20261022024950.264235-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:58:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The STD output linter maps one metric to each default event and stops at
> the first line that shows a different one.  stalled_cycles_per_instruction
> is computed as max(stalled-cycles-frontend, stalled-cycles-backend) /
> instructions, so its event set differs from the one behind
> backend_cycles_idle and perf stat prints it on a line of its own: a
> second stalled-cycles-backend line carrying that metric.  The linter
> rejects it with "wrong event metric. expected backend_cycles_idle in
> ...".
>=20
> Metrics printed on their own line are already skipped
> (skip_metric=3D("tma_" "TopdownL1")); add this one to that list.
>=20
> Verified on an Ampere Altra (arm64, Neoverse-N1): `perf test "perf stat
> STD output linter"` fails before the change and passes after it.  Only
> the linter is changed; the perf stat output is untouched.
>=20
> Fixes: c7adeb0974f1 ("perf jevents: Add set of common metrics based on de=
fault ones")
> Assisted-by: LLM
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022024950.2642=
35-1-takano32@gmail.com?part=3D1

