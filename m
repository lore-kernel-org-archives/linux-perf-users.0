Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818558;
	b=MUDJ3RITd6s3rjT3HDcmE7GSPDPSg1cEnGYATP7DtjVBEEiyGFGaIG5O4nfKjRMRUAcS
	 YNPPuPCmiq55cnaFm1mPZYV+4pVmH6+reaeq5mmTwLMk9Zgbi8ukE8TBeCjoUztMZxFHI
	 32OAt/7++PGeFupAvjPhl+rjgjwTO5n3nxFS2blffh72IpeYrE+8Njsir35yKTlC40BC9
	 41aMH8YmZ0Gi3AqltHpLwNouMaeOpjaOiNQc37GSiK8xPdZlZBYAHmAJOd7+nspGSKQfX
	 mOH3EX1+sYxr1LzEaqmlS7oCb6lKI7CUjGhFNkPNYnLOC4K0zG0UY0oCCBBj02TjVjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818558;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aa2RvVvL3G0/KZ59rL3HbRKQSOx4Emn2F92gfO8sMsk=;
	b=145P5+I+PjNVoEO/GyUbA/KS4Qf8S6TWETFBK6zUx5QUpyekAdNuoBXWm4WJGjXySuvz
	 0YsD0S+Eur+8gW8OT3IaSejYBrylyOTVFkEypY78+JqjrssqDG2g4elRLxb/leWHNpfsU
	 +GikiG0jc1OjBJVE7avY04/pLGA+UXvsiwvFMYEpj4ZoEFlxFEFIuEDo12zWSx5Vvd4yY
	 PeSFXzA5phOTqNYtZNtttxPlKAEKWfQeL+3BjkB4oZQN87RPm+icKpnUI8/0gXsdkB/eR
	 lH7RJQ7PwD01WSMvHnLbHrQnGdN+mXSo1yvd7Xqer1j6nRxh/LJWxWbTQxfwMyOH5EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATk42RM4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30796606A32C
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATk42RM4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D0C1F000C1;
	Wed,  4 Nov 2026 18:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818558;
	bh=aa2RvVvL3G0/KZ59rL3HbRKQSOx4Emn2F92gfO8sMsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ATk42RM4SxwEUZkjO7XXl/Er1d4YOLbOPyv2AiwosP2gNQSHnHXCZz+8OvLF7ldVl
	 WnQ0ouN0ua/BF0b33cAkorN6Bsav9v6dLfnHiCm8rn+GC5Use5+HSYME2uozH8GL2n
	 zrHyM+t6U08Rs6PLjt3KyMo0DhvAWhzYWnkPhMWLgm2w7/+4aZQsWMTN23DNzuE7nT
	 oW1iujRIfnZmlRuchtVovM5pIHi59pcI7vCs8TkEEDLp30hTR8mZjhNBK3fZHT5kFx
	 AOJIoJILJPqL/tEbJunGIoNXiHW9zm2FnG92weL9EqrvVj0dLnGRCo/NCXxVf2Zsrv
	 CQgWm0tkqlvPw==
Message-ID: <sashiko-outbox-197890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/13] alpha/perf: add ProfileMe sample filters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104-alpha-profileme-v6-11-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
 <20261104-alpha-profileme-v6-11-63362e9290a3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 18:55:57 +0000
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
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-alpha-prof=
ileme-v6-0-63362e9290a3@gmail.com?part=3D11

