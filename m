Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793942035;
	b=h6nRV2cPee4IATP2hpKyP+JTXB0gk5xIEqR3KWPmXHzPJmtDYZ3uqBb8BA9Mm3AUyizr
	 Og7O4tjYJm4MrBJNWa0gbPMcIdALl8JUiqw1IM5A2nNMp4p2OLOhETOVoQCF5OaDiT3rA
	 1YS6UtPgyhvx4nLOjstvrpMR+znQb2GwZdENZKRy/M68CosdOXzCYJTdUKfcV6J1o8vzq
	 VnL8dYtihX2HQYa7pVAO3tzekmQmf1TDShHEJMWw5rzT749XC3dpRiZ0JM1Z2k78pA0l/
	 6GRkOvtxF1q94fyMS4bFNnc96QDPuA/n9HDCUA0xkVq9vVlzos6KiuhZNEhvt3fi/XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793942035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qiyggbsNzYyZMBQcAlAoEm0H0I5VnAm2JpJHMiVJqNI=;
	b=YmUQ902iJslDrhZW1b4HpExCHuQwqF94bAf4/u2HzQYpxKgjLEk2jGIQL504Cg1Nw52U
	 keG9UDxJY3qfp6DBxppnawIQNz1aHUYt7TgS8t0DDOKI/CuGvFvkx87lbK+Gywph1UM2d
	 11NndF6nHNJ7vCrtK5cQ4hwWtE9Mcj4Ig6lCKKdStFXAzbIcwGF9Ppdvhc+U9GbAv3Gzb
	 weyZ7MvUIRf1b8do/fs617tLwTquQ0TJun6MxZfSorDFbtlsIykMfV20cREAGRX+XcBT9
	 cENb8N1AQvhICUIV8OtQgeFkdAcr0aT7N4F+LlvRVC3kBGtTmfGfGtk2ihchURjucSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDgUyTl5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A80606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDgUyTl5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1A01F008A1;
	Fri,  6 Nov 2026 05:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793942035;
	bh=qiyggbsNzYyZMBQcAlAoEm0H0I5VnAm2JpJHMiVJqNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RDgUyTl5T3YH7lWPSd++uIVoOh3GkwdodEtdqlw1VWiYUPG1SBR7HM9xmVmgzxsX5
	 osqZkzsVLKMxAo9slsLSddDj0dXYyfk44U0mEwKaFOp/idWGYuH1WYRPZmD4DoU9xX
	 EAvJ0h2aznjoq7RYT8BPxN04u7LaRkgoQJ4iRZw/fJBByGWEsQCrkO+rX9tFAyDF6k
	 zu0sj5qmSKJNCVC1yqoAyHh/rpbWn/Veld9BR21qkVf1a08yeotO+0SCk+V5Jxc6Vv
	 UgjdlZwTdpFZFVw3TVa1KHVeewDe4hvDsh1Tieebxm1rMRexX/X4aoPBfGbMR5n247
	 xNmDWBMG3eAGw==
Message-ID: <sashiko-outbox-200805@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/14] alpha/perf: add ProfileMe sample filters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-alpha-profileme-v7-12-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
 <20261105-alpha-profileme-v7-12-c474e892abb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:13:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> ProfileMe samples any fetched instruction, including those killed on a
> wrong path, and what happened to it is only in the PERF_SAMPLE_RAW data.
>=20
> Add three config1 bits that keep only the samples of instructions that:
>=20
>   retired     retired. VAL says so for an instruction that did not trap,
>               and the trap type for one that did.
>   mispredict  were mispredicted conditional branches.
>   trapped     trapped, mispredicts included, or caused an ITB miss,
>               Istream access violation or interrupt redirect.
>=20
> A sample must match every bit that is set, as with Arm SPE's
> event_filter. The driver drops the samples that do not, and they still
> count as interrupts for throttling and frequency mode.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-alpha-prof=
ileme-v7-0-c474e892abb0@gmail.com?part=3D12

