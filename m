Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123874;
	b=02EhElTA6378cKpta3V7935W8vI6lD3NmOoxstz3jY0lDtBIDwI7jht7UwsQiyvB7QeA
	 TWhbC0LRw6WpeFmbtyQ0oHScrshGFLSPg8ivk+GdEOruTpgPo3C1X0P1s9NPWIvD8FSJH
	 YLsZNHeAmDdz92dYXGoA4v7N0e8CsEL5DDokk/gFCGFDAUOhVz2oMRyQ06I60jcbRzDLa
	 xwVDp5JfgHWqdM20/rmov9CUuHvY0E4Ulaa/7TX+aIX2JIyGc4Dc09cv+j6iUF/617x1q
	 090nirjzsPtAd7J2oxZzJ1+zcbD/BjNDFJnfL2oH0MLBmPVzmtZngauBvFnq9f+hrCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123874;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AAWJltaKkU2TyGy+d7+t7RLhO8N7PWC0EbmJ2ZY2Zew=;
	b=nrGRzFPMinxBLFQAq9VmIoyIsjQtCjwW0lOcZeulzXrmBPj+G8OErxbIwOgC8ncPQtVa
	 zRGsMCn5Gzs0OjiAhwVMOV33sU/MaioY7qWVsn7QjFPCqYRXxoabjTRXi97TILIBwQEoA
	 x7vcMxZNNmN0HzAZMz2GYUwwnKCbaKf2OlkDUeISYS7PQ+/yhJdMotD9d/lWpZfyguT1C
	 9Q9r/oVLj0a32qLxFctbE7slL7YuzxPfmXP8xZ3KkVKaYFiwtgibNi7ypKabMgtrWM8pO
	 UHnUSHidf6JM/ZxlAe7Tr4asRiP3hApvf2KCsoaXZJfe/Oz1v/s8eYW3Cp2l1fGMeyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cE09eeBO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA8606A31A
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cE09eeBO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8541F01825;
	Tue, 27 Oct 2026 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793123874;
	bh=AAWJltaKkU2TyGy+d7+t7RLhO8N7PWC0EbmJ2ZY2Zew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cE09eeBOTRLgMeUiwngoEA0lPbH5b454NUuxsjH0xBy8DLwFBQdhOYa+goOucwikn
	 h0peXLO2wBHfHW8g25UMAvkvWlQWGCL+A8G1A2WQUrEVrj2t6kpIwXyRXbL7Zg+Lzt
	 NLH20K1PcU5MBcVvGOWHnxq094/5U37YpMxQmjpvcQcJPSyaGLhNyH/zvgaJeP10wB
	 +RpRFTE3bTj/m1lTC726Q83asSKvo3SOn+cN0vUwQaz3qKj1sUDvJ0IyuOOLtXtCx0
	 WBzAuTPWnBFOkrbmv9LOw+z0U7DKMyX36vfGufUqAs1aeN1PvzxxYB8WkgUPrckkFL
	 pGOFRCX0Yat1g==
Message-ID: <sashiko-outbox-187000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] ARM: dts: BCM5301X: Enable AXI PMUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OkFSTSBQTVUgUFJPRklMSU5HIEFORCBERUJVR0dJTkc=?= <linux-perf-users@vger.kernel.org>
In-Reply-To: <20261027175124.3518239-4-florian.fainelli@broadcom.com>
References: <20261027175124.3518239-1-florian.fainelli@broadcom.com>
 <20261027175124.3518239-4-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 17:57:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Describe the three BCM5301X AXI Trace Modules and enable them on the
> BCM5301X base DTS file.
>=20
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027175124.3518=
239-1-florian.fainelli@broadcom.com?part=3D3

