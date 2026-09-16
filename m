Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860483AD531
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523018; cv=none; b=VXaFHf2apZI6Xlu78WoOOx66VnWUbI90ndeDrGuXhSjAh2gvCMmSIOqI/LxAo3pxxmfyat7UIZxFGlTpDv7MVXax8LaHfcgkE6Q71NAUH+RSlw7qjtqzZ4LAZjHNlIgoLdgHUjgmg0UIoe46CnEpxZ1HzGAr0Hy4O2+wIqRBfeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523018; c=relaxed/simple;
	bh=KGRa2NzzHUf0kZJzL2gZ020jUqkZaNtr7QjHP77L06A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KM6queSHu6gQF+es0KdhqsEYjkTskxwsIuMTmY4s90SCJ/kxq5NlzYo/+OYVv+gE/EvxHi0vif0Lq7o1iCWcyto2CSxaCMrU31fQdNQEQIBrSFRE1CGWTr7+tWGWiKyl5kvxPJXKR1bRRPPD1yJa0HlABDkWHn3lrEo5YZ8m7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLlq7f/0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLlq7f/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349131F000FF;
	Wed, 16 Sep 2026 01:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523010;
	bh=KGRa2NzzHUf0kZJzL2gZ020jUqkZaNtr7QjHP77L06A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JLlq7f/0fh3F6vsZgudzcWr7XwMHl+nEZ1wZtbPKfIunBUMIO+xXHooFHYP468XbJ
	 BJIzc+McvEtgEgHfbMbJITlGAwTqyPFd2utcBlu0x79NFLENgfj7DHUAysS3olKt8J
	 g4QP2gODTItYBBowvpNZUOSg4Li5sWIfJzWqIBaL61iBGMTacHqqjfoNj2sIdciYWQ
	 LpUZtBZeNwN7nB9W2hY1Vknq+JRIlezeiYeRcvsTQejoQbsolmRBn0fBk3nJMHURQq
	 h2hajU+m8oibSzTNXESwAU3prpXih/yYp7Jsr5yL1ZISwTUiFxot0fp3qjsCr4x8jI
	 57vZBi+gulNdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/26] perf annotate-arm64: Handle load and store
 instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4f8af3313ac79cfe91132089ce1da8b8a69bd9f5.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <4f8af3313ac79cfe91132089ce1da8b8a69bd9f5.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:43:29 +0000
Message-Id: <20260916014330.349131F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add ldst_ops to handle load and store instructions in order to parse
> the data types and offsets associated with PMU events for memory access
> instructions. There are many variants of load and store instructions in
> arm64, making it difficult to match all of these instruction names
> completely. Therefore, only the instruction prefixes are matched. The
> prefix 'ld|st' covers most of the memory access instructions, 'cas|swp'
> matches atomic instructions, and 'prf' matches memory prefetch
> instructions.
>=20
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D4

