Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794807252;
	b=b9jHOra+IhdOz/l1G69asdV2jw+xrbSAlRsr7UcdHgJvDp1r4ZQZ0xhIpNl254awWOWD
	 Mj4lXYmV47xC7T6gARnkHF3Bk4MG+I8f7WrlnGeZ4X9GicaBDp00SgXSEI4R1SPCKi55I
	 /WCdhNVFQEF/1oOdVPtgfOr4H6Qwx0JG0IPDeNOEbkNqNxSoKyAwZ638rWjSbuiD5vQ5R
	 Qr/nRexSFSb3FBzh6eCQsjwbe5l8+XjOKTvw9LhK6bZn5PueKtDhYqTqvHPmT5ISXDvr6
	 A0pa0Yfl6Hf/bF/ofUySVLzSWRA3ts2Y+Loxpix3s9Wh6oWDxmL88zQMk5LAatrnfpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794807252;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9/2dStGNSNDz0l0zrXT9BiOLBtranOlb5JiRXY6cNc4=;
	b=09wrcnOa0Gfb7RXAYBHUOw2P4Mi1S0KOJc4lHspL0/oLDYFqUiveSdhulpBwAppKmKgE
	 RMTnCGW5W/6XRr3EFvyXnkfZJ6NyBJWfxHrD2aFgnTAw/TCpI4vkwCdev6GBwOxjEveii
	 sgzUcjCg01B15vBm95aVgfyIFJzpeTkK+3tFbyVt+G44Ivfk7lEWaGxnHqmJZznhyATx6
	 GMSic7wNBaQrjvuBBrg4gq5a6EsIRstr/TkQPUdEjMZ7h560gjoTADfJk+RoP1t1p7pVu
	 hWjhsF8XyF4U6Ce4d171pySUZkrNkLOpkbzQ8oEJMqibmLW1AwTHi6UyIx++kAgyucg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rbjcslp8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AD606A889
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 05:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rbjcslp8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7D71F000C9;
	Mon, 16 Nov 2026 05:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794807252;
	bh=9/2dStGNSNDz0l0zrXT9BiOLBtranOlb5JiRXY6cNc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rbjcslp8DMXbrvgAMa3A2Rdy03sbvErWXkFi1o8ioUFaag74ZOuvzjdg0EuJvdHhI
	 FM0PWOLN/Kpo/3Pyf1OcbNAkpYY1bw4e+jhL/XWf5HRkxkVMehslD1z8Nj1uWRqW/n
	 JpwlWLQaK7rX7eZZs/eqcJQwzPyU+0zZZW9Ev8lrG92Vzm4xnfhTpYMZJ6vdyzweiI
	 yp28P+Yn/w1kyXiFa0J/0rmQpRkg7fdR0Mv/H1zzXF1NL/naABUm18c3r49IClaBXt
	 2AkT13aZUoZ8G9IOl/f9woStSyoGYyqQD4zoqWAy2xZx6zXr0vs9wgJosHBfqlyn0y
	 0IDrbTkdisJCw==
Message-ID: <sashiko-outbox-216213@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 06/11] selftests: tracing: Add a basic testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <179480682179.38065.15797461233330303156.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
 <179480682179.38065.15797461233330303156.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 05:34:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add 'add_remove_wprobe.tc' testcase for testing wprobe event that
> tests adding and removing operations of the wprobe event.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179480675130.38065.=
3086970856119381693.stgit@devnote2?part=3D6

