Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942544;
	b=lEI2wKMAn7zMmDGb84b+x1jqOhLQhb+nnSTk3PTRr+Y9ERBzOopjZgH07ewMsBUFIXK2
	 ikkdKv2nPoZebbFp3VN9/OwCGuYn5eekjoQin8O3uY4GGUAG+FDgQn1OOU+LcsKScLMvs
	 zYT8MYO6B8nUIK33XHLKqupbeKeNd7g3wxc4nOXvvvULUoOua08nCPlRR3qxr5nY/Q26c
	 F4y29wARV7D72mVpvwlYxorIh8If+RfrvnprNb6oiSbdFslJ0ndtyMERjtXYZFHDb34wD
	 UpRHrecSlzCHZxtw+Z16KSIiOUnpxqqHqkEyNRWWEo/Y0+6RzVUdb6iQ6uV9x5Afdlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942544;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l5TIpDn84CacImxzgXrChtCK+5FCWX1D2aMQRtofCaY=;
	b=JPCxMk9MyJmZYuDhzXeym4ZyHexhDhEWx0FHW/IsZEwEeAH6XVpng3Lma6j/eulvUI35
	 NCFdQF6mEA2d/q/oTJ4j+ORvrtNjBheSVhlfesaTLbmrI++A6K1i8+TPD9Odi+P5tWluV
	 Zyuo5J8va8yUGckzYw4tE2EbwjYUGlACrMemxAkigvJ5rHwNSUQLxln7Wo7D0EGFcIfPd
	 qvucHFFqs+aeEi1NfpT1y802/o9GgIhmSIcT7Lqhmlp/e8QXWqPCGYJ5+P5Q0JunCj/Ze
	 0Ox7XiLkDR3cA1UgBBMoiWAu/xlOnOa+9hTK6EErNl5VJK4t9TtSHTGPfYkM2yE0siw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADWNQslS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F461606A32A
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADWNQslS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126DC1F000C4;
	Tue, 17 Nov 2026 19:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942544;
	bh=l5TIpDn84CacImxzgXrChtCK+5FCWX1D2aMQRtofCaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ADWNQslS4iCHwsEt9BMhuEihq24zvySfIGp93D4CYVa1OC3obrraaEWr2+RibzbCU
	 6sGNmMECHj5TpkZYdBbxEhwIMq7vuE6jNwr+oKQ7tLgdE089enDUIDHv5/c8bkYI/U
	 5R1XPwSsy/bm4ybM95xZERzjp+M5MVuqu0qioTUGLMALx/L3ImiAZZftKgkf7SP2IO
	 P0BVmXpV3VfeWakeKJ4VaiTvZWAHf9glpyeUGTRhbH2KlCX6R7rdowNVO2WEwTMK2b
	 Xf/zPnR7szWaAQ7ZG4t0Fs22mIyPwleRPfdT8Q0phY2a0RfrhJmnm00+63qSu2ggud
	 1vZsrIA+yLCvA==
Message-ID: <sashiko-outbox-219444@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 09/23] perf dsos: Ensure DSOs in auxtrace, machine,
 and symbol are in dsos
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-10-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:09:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Place the DSOs created in addr_filter__resolve_syms(),
> machine__process_ksymbol_register(), and maps__split_kallsyms() into a
> dsos collection so that all DSOs that may have data fds opened or be
> referenced by maps belong to a dsos collection.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D9

