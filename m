Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908E46AA9F
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144999; cv=none; b=chGPSv5HbzwjGDPUbd3ygEP5tYAytEVqU1pe1vnnDmAGDr0xfqVLxUi/mZ3xXvlwl7Gud+QA7VgVzWU5G/RysREKpT4X2yuOQvP6rUQHw6eKDYtfpk/L1Inq6UtCAmd01vWVEHM7zR5nyFM9Rfw3sDDpYRrJqUYe6lgiVgOiq3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144999; c=relaxed/simple;
	bh=f3nPrypFj/eQwXvEdhm81pnT5o84SvjplVE9J81TB1U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fG9T9XGFcjTsMBYx18EF9LilnwbK+O+HTG870kfMVNLPo475ykGDw0QQVmK8PMdKE4rpBS4N0icAb2LJPSe2G/2K7oAYp4V4mbWjv/XV4ORm9uWu0AoPT0fSe7W0btcQ50LIMAbSZLiw7+LevMpcMqVtkScZ7fGUCS2A9cyp3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtBqL2hM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtBqL2hM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DD21F000C5;
	Fri, 16 Oct 2026 10:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792144995;
	bh=f3nPrypFj/eQwXvEdhm81pnT5o84SvjplVE9J81TB1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jtBqL2hMnOfeIEHs7ITqU1fU2BbbHU2/BDUhwiIuBhudnRx+jdht0F0CGmRQkDV8N
	 YMc26gE2/cTuIIjnW49njL8p7eSJL/MuLKtXq1d7SIM3YYheTs6kWAuuMzCx7On9tR
	 zMEBQTjLMdzMhX2GDDreJFodVyUV2FFNQbSduIgOe73nSNAVG4nW9jCX4yZAjTJ0BB
	 yUIMPziHdZxico6cwO3G09lbT78ebFACEGy++hJX+3tR+hNmfFTVjTa/1U1mZr74wm
	 bcrFk0ohho3cz6deT/7CTmRkklCSDnhb+vhO25CfGUW+RCKLD1lzvkcbyL8eWKklYz
	 p01tIoPBOpN8A==
Message-ID: <sashiko-outbox-174119@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] arm64: cputype: Add FUJITSU MONAKA definition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomohiro Misono" <misono.tomohiro@fujitsu.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016-monaka-fix-for-upstream-v2-1-fc7ede7f9f48@fujitsu.com>
References: <20261016-monaka-fix-for-upstream-v2-0-fc7ede7f9f48@fujitsu.com>
 <20261016-monaka-fix-for-upstream-v2-1-fc7ede7f9f48@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:03:14 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add cpu part definition for FUJITSU-MONAKA.
>=20
> Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-monaka-fix=
-for-upstream-v2-0-fc7ede7f9f48@fujitsu.com?part=3D1

