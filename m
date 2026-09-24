Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C793F484B
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228505; cv=none; b=HLWwb+xxge9tK4hB//TM1lVFIuDQoNbbKd8KxkkoDEvIg4jDrohOO/iI2hYe1KxYVdYvNWKRVZApJh7NOnoUUDxikCcBk/IOJ9owX4mvGbauqgjndOHNZM1PiOr4Vq6FUZXa1dMtvUOPH7qWMM+vrqGMYApfrcHClcOxb7WCpJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228505; c=relaxed/simple;
	bh=z8Wa2UXiEke3Ti4LAnAZ4MYmMjMC1B9+NtkgyWLOTYs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WKnGOHfZCcxnVvnd0Z7QOOoCYq6roShoieI35oTwTYziBuHaDSfu/zUz+VdX1U3D9VkVc34eEGcweahX5uNEfcVpFhALw/+rYpPk0AkgvU/ehBW6Le7N+e837GCE+dNW1hJbGmAGYS6e3uSDbRnQ3b/x6M8yEAn0SnHFlkI2aUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhT9bW1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhT9bW1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB2A1F000FF;
	Thu, 24 Sep 2026 05:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228503;
	bh=ETTLH2eUwfLf9wG8Q2KwapSkgKa7Rkf5cpnx0KvxVNU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HhT9bW1ggnySqln4VS/bfN8FioQVHgE9uBQWdNt9frm79rB3yFOGizxYVTlsSBvA8
	 I1wKo2JVx0Kz0nCDKw8vHloNhvBO/04eWLejg1J1srGj49Jy77vT/yf3r3Ah9mcVLh
	 QmkbzL3nQ4GvQrNL4+TIGKKo8ZC2p9dspFCMlO9aiWHQUb7e0QQPJF9EWrajIEZkPL
	 CsEjuKWjbjDSpNI4JqBAPTdBDRKsG1aXww+3KwkYb86X3X/bsNPr65gkPuOsKS1siI
	 YU6GL7A/UkSlQ/1VhXHh0Gu7A32eZrnWs2vA4W9Endhqw/sBOUKDXnDfSwRcGjKl2M
	 QKrVDsLLAaUMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 17/21] perf vendor events intel: Update rocketlake
 events from 1.04 to 1.06
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-18-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:41:43 +0000
Message-Id: <20260924054143.6FB2A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/fab8d8848e1191e4a2ee57221cf3f79=
294f030c2
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D17

