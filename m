Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593653AA4E1
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 05:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389444; cv=none; b=YbXaLJEcUPf7c85QEF49gQfbOdEPhKI66hzxqO7rtBn24mI/jOq/e+3Z3NgbpDF1cPIPpP8MY+SEIVfDyYONy52iz2p9kCDeNsvxNNO9F19eD7es3wKvAdC8h8bFs1WhPY+lo1cLW9SbENunhQPfgswTUFG1GD97tKEhZFsazkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389444; c=relaxed/simple;
	bh=xO6xCN1lx7zqrphudGpYH7qhUjk70s9a5kroikc7E8I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GddtPpFZjU1+EVlbiroTZusjuHN+8gtcAph9zdPAcPVHm2K6AKqlKhPXM+8yd9QbCNDsjWSk/z0+c5xmpk6x4XrTCFa0m+8FoN+A3Q2Qwo8nlyuGaJ9edirtiQcAZOtC+4SxW1cidulExJ3VWDeqOiXthNKCkiN5wWcCuOb+pGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLlzpOI0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLlzpOI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C527A1F000C4;
	Mon, 19 Oct 2026 05:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389443;
	bh=xO6xCN1lx7zqrphudGpYH7qhUjk70s9a5kroikc7E8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XLlzpOI05ATlpnO2/wrxIGRPi83m/wza83CG5ij3f0cxPCzCSkRZ9aIVRsczZ04fe
	 VsRDrpm7a8/Ts5oKTKieNoG/UZN5zOrhtQxV9dVYySXm5gr8AtbN7nGG4lACyjgemS
	 ojjS4WDJBP0vP8FI5KY0OL20sI5o+Qnu3a1mlIA+8OalNtIV2cDgvJh7hjK0KEcuUm
	 a2RDCjFzh84R+FLa8mQDA0RfQ+HCgAOwl0h/rNlyKWy3guEhiy81OoZDYc8ups3RV0
	 AyC1yKPCql0u7KiPhW/AuxEwZwBIVnYBxnOZKLTuQJZKYh+PaRQ4qk/2fYzjXkJUg7
	 gqOlFDi0bqgRg==
Message-ID: <sashiko-outbox-176678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] perf symbol: Ensure dso__set_is_64_bit() for
 libbfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019055207.39325-6-namhyung@kernel.org>
References: <20261019055207.39325-1-namhyung@kernel.org>
 <20261019055207.39325-6-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 05:57:22 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Otherwise it can confuse cross-platform analysis.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-168776@kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019055207.3932=
5-1-namhyung@kernel.org?part=3D5

