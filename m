Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701266;
	b=bnXnwthzfbV7XlFwVL5e7eHypbAoqF4gM6wIyV4ZuC2JcLhL2XbsLmrv6S1qh7dRlFFb
	 TdO6nctRgYsPZLatz11NT61EDIse4Ie0J8ZuC7jRbzaXLC/n56XkYf0Kzx32dU19iB9ei
	 WY0Or5tmGyIDOzqIVOPyJ3JYnRHo/cKEYTK6vkf10dAEl0YxTMK+WeEPwB8c55kToDbiU
	 mSyDw0sTtztVThU7s4AHnC74MMGPtVLchs1ImpqTbuDn6O/6tdxSo8JCqJeAehMiylPB/
	 mdbNE/+5G+Bwf1fn4zBVDTQY7YdKFIzuTabSaHg0U7naUC1NW4QhPa2ksrwvRzk/4VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701266;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NwLkpNbzonK4JbwFqce/1ltq+yBAHSP+dZROevnfzHc=;
	b=g5GhrmZ5D+tHjQnW26FN2bjvtuLqU7M8Ap0APQU4ldngfY4mIOdJDbRT31wtig68DztP
	 +LtVWyCpwa+W21CNYood8WsgMjzuFL9Bs6EGy7L6UGQ0YJLCAIWmsgZKG1CQzrAkb9CuH
	 d0OxqAkdwezeGCFPM7O52N3N2MUKBNfaPEejA4JFp3519FNEeT/NdAWT3jtcltlwC3H3G
	 2pVjct2iSWh6WR59MlDDgiTNRxaMcW/R5ix478x5JSXhvjxA1H0IMu9PQ1sIRk8PutpW4
	 zZSuy7NsMNwlUB0Ij6GTD0JJiSrz9uK4lt4la4a1sdzLZDVjaSS1aY2UCRmOpcbT3rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUr9KbCb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403B606A814
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUr9KbCb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25A81F00919;
	Tue,  3 Nov 2026 10:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701266;
	bh=NwLkpNbzonK4JbwFqce/1ltq+yBAHSP+dZROevnfzHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XUr9KbCbZiEapXLg0gfZQJH8MKkQQvdKThMNwy03SkTzTqDSmai/J2AAEfz/kD6CA
	 HLwQBvseyHNr/5URVQFaAhkl9MAhfUreHROxbu4qQc6/EiebCFW7Zs/UpNYrt+uVNC
	 F44aAsn5zKGImvHt9SuMN3DBXfIW1+rmj0cOfAGPO7yUkqeiMJSaVB2zW1+l+iMaTR
	 4OqlOApx5/WDnWKYmKcMRmAU6nU1kzqj5jcYNZs+mFrsZaTDkPsBwisj8iWEQW6CcH
	 GnIY9Dg1CZPnU8NbdgN0uwzXZaEhHPombqXRSjeNjQqBPf+uwMYI5w1r945R73HCk5
	 jUxazKMz2d/IQ==
Message-ID: <sashiko-outbox-195033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] drivers/perf: apple_m1: Remove unused variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-m3-plus-pmu-events-v1-2-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
 <20261103-m3-plus-pmu-events-v1-2-a8eb6c1139fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:21:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Myria Sarvay <myrialsarvay@gmail.com>
>=20
> These variables are calculated elsewhere as well, remove the extra dead
> code.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-m3-plus-pm=
u-events-v1-0-a8eb6c1139fe@gmail.com?part=3D2

