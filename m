Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972897;
	b=JPAbCsG/MnxZ7VptaFSWCSc28Is/o8Pt5CeatPeTnjSGenBXUWykPYmisqgiVs1RhkiA
	 Q68i8PKbxyF1HL3rxy5SsXUf9c4FI44BRIGQ6+lwcZdq9MTEvEdcFRBkQHkNOasyDetdP
	 C5tHYXdgAmsaAkXGMYnmH8LZlXtsdrMbegYXvhhuk4pWZoXKd/oJ+8/xfEW2yV/mdMBL3
	 rejyNCICvMdcCIFtemMpKULtUfAqjx4S53hvuWB5Wp22zy1BHFjRamE7TLc/6rLOcypnd
	 2LyGBtpAme3elEEaOwNw3cCRn9S/aueKJivYhXuaKdvm04VBKLDCRG0CAtfRtS1HTWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972897;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gyi3JCirPP3kZXnR7rN9w+RBdJdVerZDwAu/JsZ9BQ0=;
	b=HfMTspQLx1E63lMlyxyAPULFVDKmN/uzOAOXTVIlZ4Npxq2NsAIa04x8qKG2fF5hdJjr
	 Xk9OL2VRgnQjcYftO18iRLkDbX5422+lI6vYukjN/cGIcqU6PGYhtuhbwQ7qqkSUi3EXW
	 wOKCjribdWWojif3p4nz0KcZxNB5c09i+CLwqVV8/9P3uj9bT3HolZRTb3y3L7uyC1Z7z
	 BRW7tIB0vvft+B14MPEzI4MqdT8Ph05FytmVxmS6Vk5PNIvtfF7IH33lKQruMOYZjUPAn
	 5kXVVIBmb578355/uBxM4CfPo2b/zsXB/QBHwmdZ0MKr4RAbg9Bb1Vvbb74K5V/kEGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+2L9Y6n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E201606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+2L9Y6n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4051F000C4;
	Wed, 18 Nov 2026 03:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794972897;
	bh=gyi3JCirPP3kZXnR7rN9w+RBdJdVerZDwAu/JsZ9BQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X+2L9Y6nNuxmaK9wQh3rNCQ1fDh6vFTA2Kw6JuwgVjUA6htOMPl5zI1CbC1OfCj9y
	 JVcFu/rw94f+jzxzCqsUTfpLtPLd4VUK8tVrRJpN0yXPE+eLtamzf+DvsLh8mfz98T
	 fd5E+25A2/ad/CPMjFggQVsDgGyCTHvZpr1x6YEOYwf7F/tj6dnnW8Pbo47oFL5UbT
	 rhyS+OTiBz2suhRW+6zu50Hk0dSDfIk83LA3YLw7cLwmEEwgSovEoCNjo4iLbOsygK
	 HVDw21tPeQilUYlvfuZE6mFP022ZhoFD071uyFUq5Gs9hvWNtcb9mKVuaZgziNrp7v
	 58W9B5GZBc+fA==
Message-ID: <sashiko-outbox-220021@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 14/24] perf/x86/intel: Account lbr_pebs_users for
 arch-PEBS events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-15-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-15-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:34:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> lbr_pebs_users tracks how many PEBS events are currently using LBR.
> It is updated for legacy PEBS events, but arch-PEBS events were missing
> from that accounting.
>=20
> Add the missing lbr_pebs_users accounting for arch-PEBS as well.
>=20
> Fixes: d243d0bb64af ("perf/x86/intel: Initialize architectural PEBS")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D14

