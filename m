Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47F3F9270
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270046; cv=none; b=X+OU7xJWpAKJetl7wtF9gH9UuT4hnfQhgUGBgFLGT6adGQJp6hCeNxYoUFmGdk4opEpCvr0vH6+7rvLpahzkOmyvbA0xttHkhOnhBK373oqTbwV7z/u6S/gcM6ing4nBzUZoCtLW1B0aQhw9L4phS/XbAp/sKH4kH1Fqgk75n+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270046; c=relaxed/simple;
	bh=EW9Qlqk56m1dHBcmemOtNllChT5ek4se6Soj4hxJbSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hxjbfkj9ZyTYw5gLS4nNU/HyuoRigK83ScQF3tnLhNvgRR+CgNX/PGiOZXh9VYW5uuiKiGWhgqij9X+iYmkNwD3oGXNWMe5S1mM90hyuxWrG+IdjTo+h51DSIBqR+CGG+DSjJWXLWCBM8HqHw1IMF3EKCg5Fqj/KhMexeNgAk2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7MH4t+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7MH4t+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B1A1F000FF;
	Thu, 24 Sep 2026 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270044;
	bh=EW9Qlqk56m1dHBcmemOtNllChT5ek4se6Soj4hxJbSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c7MH4t+4PC6jKEWeNHfO10k1wnKb1LdX8099zS/yY4laJMYg242MD3DeCnZQwhBMk
	 EfFHYCNy2DwlfZnzRAR0ntXdHo+jyiGXet79J/GXCSDTgytHLx22shxo6TPZNbuTKU
	 Iut8xtjFs52nD8KmlaafIIP24Ds6omd6TJMGsvsGe994QadR6fP+bzvHc4VhB/X4Ak
	 vBNv4214Itt3Xmj6BAVRV6nNxYFFbqLVZCfg9lxPaS13+EExctEzbSn87V5tFZ6Exl
	 QBN1w1gc3QOAvPNNameoaXJlEzh5fl5BotSnAe37/8Xgio4bq+GE7G0h5EmNEzk9MC
	 1BP9O8gf4fJRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 25/26] perf vendor events intel: Fix skylakex umask
 encoding.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-26-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-26-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:14:04 +0000
Message-Id: <20260924171404.A6B1A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Fix UMaskExt that was wrongly encoded when the UMask was 0.
>=20
> Fixes: 748d5cf71948 ("perf vendor events intel: Fix uncore topics for sky=
lakex")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D25

