Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE45379987
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561777; cv=none; b=jPZff+GddzeiEvmFY5BnDg4MrWwVGe9ATht1NwP/8cxk826IJr7BpMXcZeoOs+BRNq0Y1mMyJr2IxxsY0r4y41ZuRGVkN2cLrXQhVTdrGF+h2BszZd8UJcSowj+fj0sTZ58fFPepe8PVMD6m9vy2apkFqEN7CbIXR9ETBWRUjcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561777; c=relaxed/simple;
	bh=2lpZBThiMFiMKZpwvFo2XtPu8WFwEGal0k9TcqsGvZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JeMR5ORQWvko+bul+jUJj/m3qVc+2o1q19WLWeUa4evgVhdULXj0i7rqEaXOSvLjGmzDpWMne7/Ty/XGSd+ZxWIxNJn0nPEljKhyh7nbIZ4l7BZIiu+eCSzGleaz9DiEh4JYbUmT5ATUXQnlCDR2r/HKWdLVJpfv/R7vkSUqhUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8F+0HT2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8F+0HT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EDE1F000E9;
	Mon, 24 Aug 2026 08:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561776;
	bh=2lpZBThiMFiMKZpwvFo2XtPu8WFwEGal0k9TcqsGvZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A8F+0HT2rx+qcc595TShC/gb8NyIoCcSg2FJWQrPySwM3KrOCONQ4v10spsTbs6oK
	 jHZH2/LRsuucpmIiC5FpHiffrbZXwT7Wn5Kxu7x9my1xyFzXOK/+QtXMtG8cOtOuFj
	 1ojsm3J79xaCz0H+7nyS8yj9DwMaqV/iZmGnjGE/hQ/aL3/G6bFljEXi5gX8bbfifN
	 V/7/1pbdRiKnzr5bnyXjfyqhoMeBupuAXDXuXoGJKTr/MBlBD8KAxfMp60JXpAgHyB
	 p+1BTdIi49HoCeTGGevPkWNltcBXe8jmOAmusmKjoI3/IkhVbticMQPnTAV6M8ZNex
	 o6LqBBx2Pa1Rg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 17/23] perf: Enhance perf_reg_validate() with
 simd_enabled argument
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-18-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-18-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:56:15 +0000
Message-Id: <20260824085615.E9EDE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The upcoming patch will support x86 APX eGPRs sampling by using the
> reclaimed XMM register space to represent eGPRs in sample_regs_* fields.
>=20
> To differentiate between XMM and eGPRs in sample_regs_* fields, an
> additional argument, simd_enabled, is introduced to the
> perf_reg_validate() helper. If simd_enabled is set to 1, it indicates
> that eGPRs are represented in sample_regs_* fields for the x86 platform;
> otherwise, XMM registers are represented.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D17

