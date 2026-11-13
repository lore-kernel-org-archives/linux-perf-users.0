Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590793;
	b=XXFoJjoTeFEaSBdrgw/oBGGAi0doPTIw2GC9o3qROsJFBHWvKUvgLVhCCo4zv3H+6z8G
	 DYks3cvL0pLu2kISIuW4NFZEZ7Ja3SGs8zMyyJMJhOY1qH5AxRV7RPFt6PQahO6OCCX3w
	 Bde2OjjyVSLFBfirQxOsgbImc02KYuvUCEcGru87pnR2jRxox5Vuxtr5C3N1ACUVsV1km
	 czQzKHnBTWzJiliwMhuqHCztgOX6sl+0IcBVlD/Lub8hR9ybtOtMftHsurBkzAhJJKKlo
	 3tBA6vHpNWkE3VBjj/WhWJ1P8MKFx0S0kfpMn9pMQhE2qF8sJA0TS6a5CqACVkC3qyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590793;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=64ghAsAp0vL8cMJyPPXEQ/Fm5lErL9hF7FdFPtcdgUQ=;
	b=F9oyvlgSvB+Ao0K02z2pkS/3TjiYLGGYcxR0dXzYNPt1bbe9irPLIzurQYHSqTN4aA0f
	 mMYoLiIfhP/81725Nczu5S3Y9Erh0dGa7AHYm7RP07LX/Wq2wIjg8bHNyJQP5co+JpdMT
	 bzmJzkwbNKQ4F5GOGA3e0WzRX61ThEw5X8bx+QAgJGol0ynEK2KwY2r44slw/iE1IbSMI
	 udjl+QhFSSq5SXnJtXenNUgcMVdRs+ejwcsVhKsEquLgHxnllvEVktFOlJ9/UCVOHQHGQ
	 YMizBGjzBmddTqHZfSLB2mb86hJ6ssoBe68MQk/tbJ8Ll2qEkOMZZrze/awYlgY36Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGZbKjgw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE1607D2C3
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGZbKjgw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9261F000C7;
	Fri, 13 Nov 2026 17:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590793;
	bh=64ghAsAp0vL8cMJyPPXEQ/Fm5lErL9hF7FdFPtcdgUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jGZbKjgwXuSKM8xwGIX7APB9xzFFAKu5y8FzoXMe1hgMDhvsphdhBM+NsXqZNmtmQ
	 WYkXTLGpkUhZRCL3yRrar1WR9DO5J46B5eH/Iv09kJmswUUsdqLClS7UUWL0/qiZD5
	 ZMStDCAKyM+L9SC0krLsK65NZ1raO7rVmCysRqXmpIws2Mp9kSVdhRBFEMJLgxuS1L
	 NWkxpFP2V0ZYFVVREkFvPm0Fe4aKTB0DTRfj0HCTQ6maVaWdezSs3afvbwPiMQHibX
	 6/EDNxpuViyTgfdqlB72Dmfw18odQsH2d1sCMmpckyIwVzoXhficoiKUViSrktY1xi
	 dD8dmaK8/JYOg==
Message-ID: <sashiko-outbox-213304@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/23] perf vdso: Constify dso parameter in
 dso__is_vdso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113171734.2188066-7-irogers@google.com>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:26:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> dso__can_shrink_symbols(const struct dso *dso) needs to query
> dso__is_vdso(dso) on a const struct dso pointer to exclude vDSO images
> from symbol shrinking.
>=20
> Change the parameter of dso__is_vdso() from 'struct dso *' to
> 'const struct dso *'.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113171734.2188=
066-1-irogers@google.com?part=3D6

