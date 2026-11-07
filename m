Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048970;
	b=iflxks4pHsvPM45n6+VcvF27R7jtLBhBTeNyEoxxXuJXWy1t6nh5u29x1d2V0dWzXzmg
	 eWgG0oT2Fx+gDoFwWGjj8VTtCw8jZ3sT4tFP9S+NynspP3uI+LRHavwPIigvvUAZdjQ0/
	 1p2E4dmeDIzULPWPqh+FipgfYveBKmShMXJCOz+5p3LSgNt2ey8APvnW07riaAO16hQ0W
	 tgXE6QRfh1nrjQUylFEvzq2FpNKxSQNri5o18k0yknBS5Y/qdu1y0RrruhqnQNw1TEaOM
	 42QORjp8K6WXxBBjFLa/oGGYOK8APF/j1/4R3GjDu0R8L6kCB2DPwNLE9vDYMXNtP0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048970;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Nij3lCIgKxO4xjiAOfx+TXV9ZZGKpwo6itROPDSB9gE=;
	b=SthFVFUy2ksG42LCO6es1OGJBbNrgFvk10r/EuOTKnJGrKAxQx2DdQjqBRc6WFVe9hWk
	 ZZnaC0QnI4WFLUdumL9sOPiri0Y9Op8svkr7lA+PvBFPgg4nhmIYFFno5RQbzENAAx6vl
	 lKKJ1sspnDXdRPC0BlilzgPt7eg5ro6MB1MXo/S42SEECKm9vQVLqkg2hUiO2amJOXIcF
	 nEApB9qVKqXl9iQmR4NbOUuMIFW3aujbVRguFfOoP0NtG4tRgZGwI8q7R4SpmisxDmrNm
	 Ub09bqv5XuLz+z8gQkZ5y3IH202AqZEnh9JaJLIb4UpcKCtNsL0DGvhv5KbdyQODpsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VjY98f+F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E583606A32C
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VjY98f+F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D911F008A1;
	Sat,  7 Nov 2026 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048969;
	bh=Nij3lCIgKxO4xjiAOfx+TXV9ZZGKpwo6itROPDSB9gE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VjY98f+FFxQ4X8e6RyKzMpu99lsXjCK9aDkPVLacM+j/x9/pu3vh9X7bc912GS+la
	 /qbyEKIdba094CeksAQeeAjosCsxvJWMdh5fKfa4w8gJl9p74WPR/4poAoB52lth//
	 Qov31kuB2yW3081GqCpx3sUmK8R9SiJAkbsGYgGqLSDn8D9fuZTVb6BYbCZ80xd8O0
	 n1l8fAvSSqCsZcrl6xJvx9FjoSCftOIKzgOoFhfDcgMRx50pUxULYV+HZArCogEWnL
	 g5bHCTZli1fXUBxA4lHIa9Yy4xiBrJn3/btmEBVLQGmVvywypPgnc9pSUk18G5ZveN
	 ApFTFobFP4pmg==
Message-ID: <sashiko-outbox-202836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/15] arm64: dts: apple: t8132: Add PMU Device Nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-14-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-14-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:56:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Myria Sarvay <myrialsarvay@gmail.com>
>=20
> Adds the PMU nodes to all t8132 devices.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D14

