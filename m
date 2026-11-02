Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622739;
	b=HYL9V5PKzZA7mwOgqfTYV75KlNxH58IaAn2gJbIBcKUbhAISGXRxpqRYYF0zzLOGUFzd
	 ziMFzP05zZjmT6V5vLL083LQtM/7rj3UHb4wkmwAwJd2x7Yk/KaM65ID3Zz6/nHV6AHj1
	 4q5kCsGkADZDi2YB3I+/RId3ywNHONFuwJTyw1uPrunYcRO3JZN09j9wsV91X2NFOS9Ys
	 n1NQPhfUycv6THeITvSQiGgvJtMyHWmt8DIwxPMRWHoaDjoQDYaaQfh++ZBSrrEpa7Rv0
	 hHm4fqELRdQRAj10oUuQN52ANgF+aZdkSehpMy+x82CNZhxDqBoUFBd7CALFqS2lDkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622739;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GdauqRNbSJ+Vv0kjwW6mH0wj6D1saz+Lr96tHt3Q65I=;
	b=FMhsPdbKKffHSZR0gHI743ZeJSUY3C6EmxYD6bpG6oTeXtqSuE8+OmUKUn/AVcOVB2u1
	 g6uAZNF4Wk/w0ZDV9Rwr9qN4p+SL7zj9uMIfxpf4zBdLHf7qnWVlvZhZuefdlGHhaCAay
	 UpBHTZCF3F2kzw7qTw1BNcpbaCoWgV568NZo8j5NS+d6Uma03YbW0k+otDe9w/ZsE1gcZ
	 6qSejaUTpiF7/Whejz+1Sid5cxEqMjEYJPTP3xY+fijdPX3+FuhgbPkRDIz7TsEchtuHk
	 e1Hx9/1G4F0oT5VaXfGWk7qTv/8nTvNWQeaVhP5rLgG0USkhiAQn8USJdK5Zh6Nguuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gb9s0pZ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE052606A329
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gb9s0pZ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A20C1F00A1D;
	Mon,  2 Nov 2026 12:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622738;
	bh=GdauqRNbSJ+Vv0kjwW6mH0wj6D1saz+Lr96tHt3Q65I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gb9s0pZ1lmLnKdW9o8EuAIOSXc4r9265tqR8sagTBxS9a5zcvprp8WIOZZDBB38xr
	 itRvi5P9bIbtx6y+hiBkn77uwSBQN2iGZzRTs5EnsOeu/g0PRELytMvBL40lfcatFg
	 nDDH0YvMHF4wNv77O0OlLCfDaF8M9HxQ69tX+2AEfI1LyePaSIf636/uje2IuVhdFB
	 keXKeg7HEnNQB4WuPwxQNenQl4xD64CkmGsnLCnCzw37Dzf5+QyM/t9XSx1921cRWd
	 E2QPH7UZweOzH/lQTHeoA9dJtzKEiRb+i9+dsLLV9RiX5nvIIOSHu5YS1thdKVtup8
	 PHAQaROyZtJkg==
Message-ID: <sashiko-outbox-193416@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/18] perf cs-etm: Turn on context packet timestamps
 in per-thread mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-3-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-3-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:32:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Practically this costs nothing and preempts future changes that will be
> made to support decoding trace in order with Perf MMAP and JIT events.
> It also helps keep samples in order when we add support for multiple
> per-thread mode threads in the next commit.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D3

