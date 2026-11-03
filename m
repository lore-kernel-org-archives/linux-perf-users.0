Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701380;
	b=f4lBbI/ANc2h88CnJ1Dfc8pBKp8M/QCcpJZLwkNr6b/bnzxG1ftEJ+1tUlcIpocrZ/HC
	 j8jvVeOowDmJK5EFcR4mImbgGxVeMVlOizzNS3XSFHCXEx0ILF1LCfjiDBXdypaxYX1JJ
	 fslD2Q4mjm/SIK1EloRy2lszRZ7h6xPkKnDgw7kQlkpvHgD7A/vw2JgoIC4rQVXzFqyTz
	 q895Bt0iUBYmt+p+tPxoC5cnY/idoxSGt6Zy2ED2DVG8ti4Eq5SHvFuWquxtbLwzAX6K+
	 NZwJlrJTbAmLkz4oSjnSAulfmJ8vb1kYCR12YpcGrMAHR/Pv8lpFmAQ8DUXHaFxymCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701380;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mzGQSKGQnbOV66NNIX9oGMolpD9TZ8UkoeQ3WkLIYn8=;
	b=OI1Ybjhzyt2yyViSbS147xh004sGCSgu59w4wpYZUzBpyu3HlOuDPjfDZH3aymmjS/Sk
	 DtJ6S+MT9Y2FTt20uYQved8jAMeBEFslnyBxAyQ9myo98gDBEedNaNfqK27jN9pU6eLVh
	 Lb268VHM60OokdF+uaA609C2bNsyKuV9EIW7ab+0z5rZe2ki7yv3sIrwdOJB1VHvKX13L
	 r3EK6fcHl+MkXDOjP65qGqiiGPAnov77jLNcYdFu/FG9L6GJBCwWIXUapn2adcOYXNeVz
	 jAqQ72XuHj5ka3emxO/vJWGZS1Q0wh09yXJfUEBTJUnarczrtbzyCFr64e2IpD3D6tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odhlFyDP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF0D606A839
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odhlFyDP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9901F000C1;
	Tue,  3 Nov 2026 10:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701379;
	bh=mzGQSKGQnbOV66NNIX9oGMolpD9TZ8UkoeQ3WkLIYn8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=odhlFyDPD+Kzwyxjj4WWOv5GaqdenFms2717+e8plJ+lpXCXXfIivu9v6dhcVpUi4
	 aUcOC7ZQTHZXscmN/8Iwwq92c92/i36cJu+FdgsIHFGIGPdt2uPba9RUcT6rognyYv
	 BCWsbVG1TTMppcC3+SpxDZjYwpQ0XP4DOfIq2UCoE9mbuf+FapUo97XQzGrBlKNgVM
	 T3Ygi7/uNopLRJcN5RTf9hv/N587BDbHhbsQ8Ym13mfWGuSbEl0SBlqc5w4cyyYInC
	 dHWmZykdMi+QF7JZy4XWFqXNcowxC6F6xCq9ObTaWkagJ9BXermybwMMXW0m7fLtSw
	 znGP7ejPqp6Kg==
Message-ID: <sashiko-outbox-195036@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] drivers/perf: apple_m1: Support
 per-implementation event tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-m3-plus-pmu-events-v1-3-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
 <20261103-m3-plus-pmu-events-v1-3-a8eb6c1139fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:22:57 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Nick Chan <towinchenmi@gmail.com>
>=20
> Use per-implementation event tables to allow supporting implementations
> with a different list of events and event affinities.
>=20
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> Co-developed-by: Myria Sarvay <myrialsarvay@gmail.com>
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-m3-plus-pm=
u-events-v1-0-a8eb6c1139fe@gmail.com?part=3D3

