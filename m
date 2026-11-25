Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795583884;
	b=RRVQydToAXS3a14qajQgmd9J9OfPpEWdKPO2eGaR4D9RxlSXody/J2k35REQSIEztxXP
	 xAHQfVSiu968JoZLdm3Ac7wwfUv9uKWm8Mw1KqjK6DJxslyc9fG7T/5KE7vVK6mESumA+
	 Ofj6ptDAYWrEXCYZRMnJ2JOtKP7NHebJEFvkdUA5mu5lLQHtxkBlHX2y8Ix60TTQ0yyEd
	 NkQZ8yQ/X3p4ilWOrpJfMWvVuCWcY3YPws6SgNLETqlaSYE39d3xmU7UsvbxrVTQxc9iw
	 j7PFZLny7SgTNgN+e6PM9GsGvhZeSay2XwKab5BuqCJe94LIXQNQ4iBzlC2KSzY3scw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795583884;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Bmx/RUVvP4t9+30WMb/Z/Ug2WX8y0mZJIWPsIaNP5sw=;
	b=LqB7OupqLpxf/lD9WzdjPepHS1HWlzG4LJKezRrgQ+UPnR10rp00MIfohy3483LczC1w
	 A/U3vUVTutFh6UAFDxRVDIjqFkd89/rin+hfU/DI0ci5PQoonzLKBDOVylxLu4wnwnRI+
	 NJC+ngGDsTX7dtWA7yY1zHW1tNjxlqM1sLhK/gPaD0kPEi0Vq56IVYA74mEnHKr85jnd9
	 G6oTSz7FR3vWMvLYKVMcsX1lWh0RCQrlEv4Q5/tuQZrkAXvKtS3MtbyKKUd8K81dfEvL2
	 l4uS6t+Ah7DZ7hwbQuX5qdRRIetPyZc33DQRIYeEYYzRdpT3vE5HkTYFSIRgAXLvN1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ey1lRd6n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11575606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 05:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ey1lRd6n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78F51F000C0;
	Wed, 25 Nov 2026 05:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795583883;
	bh=Bmx/RUVvP4t9+30WMb/Z/Ug2WX8y0mZJIWPsIaNP5sw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ey1lRd6nkGZtozIG9BY8ggXsfpeahsxyTwc205aL7U2qOR16IMv7thTLbdNkFnAfF
	 jtUwxHMgTPtS9samZ8RSQnq1sAbIq0vBO6tbYDPLqSmLDwqhbty5kMt2eQJJgI1M11
	 V60rJkkqn8Ym3ZTamZCrm8IuBrbkGoCBoNvz/B6brKbC5DxAzFDT5XeWUDP4QnhFns
	 /M4LQ7cYXWoze9V+n2raj5mubhb9rVWkf/R/21d9xv9vMPmOTWSr36FrKQP2XwePqn
	 7iNEEt1kQKSRTS0rqIPiyBFk15qirsB0P8yqoMi4pE7lh2tbJ1YT03BIsc5fvG2bYI
	 CbpSFTCSkIoug==
Message-ID: <sashiko-outbox-232606@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf/core: Add PERF_EVENT_STATE_ON to fix
 filtered event enabled time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <80d983c5713537f5743b69e9b35ced1177e4732e.1795582691.git.irogers@google.com>
References: <80d983c5713537f5743b69e9b35ced1177e4732e.1795582691.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 05:18:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 2-patch series:

- Patch 1: no issues found.
- Patch 2 ("perf test: Add filtered event enabled time tests to..."): 1
  potential issue (1 Low)

A detailed review has been sent as a separate reply to patch 2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/80d983c5713537f5743=
b69e9b35ced1177e4732e.1795582691.git.irogers@google.com
