Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562A3B993B
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228696; cv=none; b=gxujOiaSLrExnRmw7WgR9eenQ48MubXTABQhFoGmporI1RzHt4IMgm3YZILuZ7BoysFtHxcMBRsl9X6jCihAiofsHd1PbGKr9kG3gstGNgzfBUj4j9n2qIHnQVepNDqAweJKbmFQ95H9tNczy9XSZY4GxP3Z9WpZz0Hi3J+svGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228696; c=relaxed/simple;
	bh=+LlKc1n51+UCMOssO6999N1PfPaLkhjWLDGCSyS9ISg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IIsBDQ7cB8vAhJmWkYhlpSRoQuN3Me8HWlVWGARKi5hWK2iFqpC2laMr7NME6/M2fzehrambuj80EuYrFGwbiw9sFg/OAsOeNkeyrgLMXO3jXiI28Qgu5qy4VUvLogb3X7Ou0Hbf+jMbqM9VB0PuI71YCa4lLJ8t+O5rX0EJAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W93DAOgt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W93DAOgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A331F000FF;
	Thu, 24 Sep 2026 05:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228694;
	bh=+opxwJWSveW9okQODDqKqtL+vgWV0TDWMU0MDC848b0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W93DAOgtrj4bh6aKXwo2i4DRBIsCibWSCtTAeTCVmWnFzqXGVwR3CU6E6lmjMaYf9
	 KAL+52rj/9f+PPRtIigsDsYi9RgbiJgOZyRsYCa7mGzuRQ/D8PgUreMmf7Jr12PvWs
	 +DrbMHpwkEiHvphfAHGu977e6SUpy77zb1Re97ielVpSK1EpXH8iEF38lJC9C3Oj1e
	 OMvtDbnuLp9/LRq5km7XOG8MchgeQEw/kSemYLlbe9Xyt6fdxznvemisBtY6UNa7gL
	 Qm0JYeOuL5g7It5wdAilRuyCgidHAvJ3zuhx4JPtqYzNYvA/ZFec/eTfIfo0Zj2VYG
	 gPClwOAhNJRWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 19/21] perf vendor events intel: Update
 sapphirerapids events from 1.39 to 1.40
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-20-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:44:54 +0000
Message-Id: <20260924054454.98A331F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/2ba60f607169b97dcfa0d28f7e3a613=
28627cf0c
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D19

