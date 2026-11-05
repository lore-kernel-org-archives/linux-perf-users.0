Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883780;
	b=h88HHQ9qz06lXwG8KZc3XlbhyU5TfgiR6u+8iyl8f+B2bi3Sg9T546Cx3+62JLXSrv4m
	 PtpC9vf2VwNwGaG9FxsZ0OHjO0wA/cROMQkvKH7oKA1bV4aSKJV9CSQNFPCwALFoGNnkE
	 DlQMoZIRpeZB4p3ZHluyCT3DifvQWy7rWk+79Pz645zKUU4d6NA5Q8wa9F9m453bKO9ta
	 oP+7vbc67GC83bOWk8Ph5uKLQocgSv5CN4H2p/nXFiNw8ZEN0JEaNW5snFGCdDonbhPH5
	 ebtkniLrctArtotlgmmqSuMND7q54ZztldoZ/AUkP+T2l9nJlM0lcJ2j21rOLSnjBZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ECTa9SdiXSRk8ftl8QHuZ8UqKqeWI0FonmdCjj/PQ5A=;
	b=OYgLdtW/+465wpbSd4whtMX379wtviO7ORs1WDoSPT7qyD4GCHonODby5U56vAgyjrGG
	 MiniQR6p/wSl6QDkvPiElbMZV6+5djpaj3e6F6wdxxoY+SEJOGzB6vkrwf17v2iElORTk
	 E8sTq0usbHpiclO/gD7R3/UoiWcCiS9D4Em0Ub0ER/lbM+4hTgWlS3tFklk3AevHKFZtN
	 1499LYR/sqImZQWkLxrsvR8Kvy5uT4jhBmm1a1UhlvBZ4mo62qBBdjsiIXipf7QW/MxkC
	 DXSEkRPZqBPALrm+dTV6BH+Bv+w59T+jvAlyzYaTQxoUg+vh063hJVWog81ErQiXR6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGnA4sQ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413A606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGnA4sQ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C57D1F00919;
	Thu,  5 Nov 2026 13:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883779;
	bh=ECTa9SdiXSRk8ftl8QHuZ8UqKqeWI0FonmdCjj/PQ5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aGnA4sQ133T+P7vbsrn6Dt7hZh3WSIuWcuTWAQC7SrJ8pDnFJOchGfYHQrN6eYtHo
	 8fQvtAbMnbl84PGTet+XN0tn3cK4QoWkBeaJuSeQFcqAd0YLFj6/fXgDeYakk5HFKP
	 LCjS07i0ebvc+4w/bzrzrk4+EGIy9fALGw1B+GQwqju0IFNpLKC2oMJL45oF8cgv2H
	 y3sgYzrD8/j7kH288sB1/6Yor/AZ8IlbPBnlnTfZ6FUuDg0kJswNWDDjK+hlxzHs9Y
	 luuJUeMRRdYBxnFNtcLRC/IHG8qKPGBoIKuFWRAmRuemdtouCwKzlUeSr7MRO9jEkw
	 aAvqCMyFjxO8w==
Message-ID: <sashiko-outbox-199093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/19] perf cs-etm: Increase default timestamp
 generation period
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-9-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-9-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:02:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The original purpose of timestamps in per-CPU mode was to roughly emit
> samples in the order they occurred across multiple CPUs, rather than
> emit all the trace from CPU 1 followed by all from CPU 2 etc.
> Previously there was no way to change the interval from the minimum of 1
> cycle, but custom intervals are now supported by the driver.
>=20
> Drastically reduce the number of timestamps emitted by increasing the
> interval, which is more than enough to interleave sample generation.
> This reduces the size of the trace generated.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D9

