Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC43B6366
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228566; cv=none; b=YqNiFn8zKg0cZp0hS0xhJS7sHM6xpHnm8wj2a4pvwelfV5QtelHZffaSWgqraTSdtVuW28XrBwxm4HiTTKDf5fZTMjJUA2L5cVDhFT0/CEZ0vxLoIZsNohaet7YgtvH6lTZCVwX2KzijjUwa8OmU8HR8lgbsx3UNVPNGJSjSMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228566; c=relaxed/simple;
	bh=0UogtK4OHqLcBUhhRoEYqNQ9J6997dhvDhtrripywzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lQsqn3yH+3BZ24XElGVmFHCiNqjb7990YL4fPzFZgXD76b1RDDwyzPGOvPuJmll+56xmncRbr/B34c1A/qzeVQPLML+B5ZR/X+HU3H9AGiZJT1sXCFN19Dg2jiYcBxkLWzLT14y3Bqu4jOZDh/naGklH9Bs0rfBYMiWKTfcq10c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/FOaleC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/FOaleC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4699F1F000FF;
	Thu, 24 Sep 2026 05:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228564;
	bh=T9NJhTcF9+vgYC40PPdgP6ynpu6tui8zxaR1wzqv2WM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q/FOaleCkP8uGZy49+zdvFxfuT6aVZAzZfyUDBQR/3HRdFSH11IuclSlkw4gYB3dT
	 7qBtJZHjlltxJvrov6h2QDGRGMu91FO+WG/2dVDZyNPDTwmSV1lRKkUCrCXvxIF4Ys
	 dJ+jRbCfYIjmZOOpm40j1AYgy8sXtWRNxNU7FkFc/Obuoi46d/6pdkYcanOBmQttTJ
	 7BgcLFXmUiHvyzkOn1cf6OAHOZccmab7iyV3SMn4146yfJfNA6FtdJ5K3F4Xf9Fu/X
	 kk8K1q/6sthTE15uQpl/T6L7bppEyVOLOyS+5ll8F7aGQ6BE0m5L6ReaBVZp2q2ZiY
	 3v+ETuCYqAoKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/21] perf vendor events intel: Update icelakex
 events to 1.31 and TMA metrics to 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-11-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:42:43 +0000
Message-Id: <20260924054244.4699F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/563ea935e283a7fc5bf49bbc082fab5=
be81af5b7
>=20
> The updated TMA 5.2 metrics were published in:
>=20
>   https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a8=
87ad46c45
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D10

