Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949010;
	b=4t3rgwT3cLLH3dfx0Gv7IJipm62V8qp2KZ4byteL+cSeNf7+mlj0IIYDZrOSexXcFmFW
	 SFTv3sbMXrKodP6vPstrPVWz55AQanRAqTzvIHszv8XaUnhkDwvBotwhsxQF1O6jhB6S6
	 ZKG8kfuZc8AzJ+zndajKus7TrxQLrgNWdLZ32lyql2+81UysakYwn1FCG+GL2EZoihKKU
	 z2rnyDu8l+ry4yvSOEHiBHAEdPW8yC0SsxiCqRvv0Il4YHPjAMZPqPY5QpLCMB24Gmz71
	 dwd1qTQ1V43ag/s3qtSDQy2UwdODlzOtgkS7JvT4Ye0rcKR0grkyjGz+kQ4Ft/dWbEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949010;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SLrMIUw7k43q0S+0PwjGAx3ukC66CLolAoxMZ8bLCqQ=;
	b=5KI06tHy1YcNvU4Q/jE5U4WaDBdL+JDAoYjmBJIok/FH9ee2hHYigsNTjSMrr8dgJuu/
	 lxZwpxtTfTEyac/8me85Q51NYs88373WN4778DL5h1SM+ZGNkq/i+9Q9LCfcBENqKRumK
	 PDCgKWnQxROb5wqRxz9WoceEsSGqIltzp7A8a3YMFIAkHOjJUOtjTTxz0iLqTriTp4BTw
	 bVmNOBgbVArCHxiWetKp6oSdn6YuYD2hZTsoq1O6dQ/lG/1PhyDq2c/cYM2bQKPE4UPbr
	 4ew5g7kO/z3TTtafEUiQ43Bogt7wotaCwrihTfoDJGvyjO7DFk56PwRcZG3JfCv2dyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YWFQpZiz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CC8606A331
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YWFQpZiz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226151F0089F;
	Fri,  6 Nov 2026 07:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949006;
	bh=SLrMIUw7k43q0S+0PwjGAx3ukC66CLolAoxMZ8bLCqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YWFQpZiz9No78bYsEYNBz66nRzYoG1h/hfCUKR4ccf0yDHJfVn58wxFtt26yBC+JK
	 oXw05yb6Y/hyxs92z51gQaGyyi7W7/vN8z+8XH0kMMXx63L82GN6jUCwgv57UY682T
	 nyZte7X1hUwEcDlnRaSwwbr9FkwexbbSBIynCgzGzRaZ14Vyxoh1lAl+8gis86FvDd
	 AtEH6/PZbBE5n4/y6uwcbcRCVsN9VDyTqcS+tpC59mr60JIrjl9JqEDNxNi6kJQWm0
	 P8YnHYy++PbiMetiZ+7SYeSWiL4ufkHN/aYfWjqlulan8zwhI4gDxnjYkLIhLO8vYO
	 L3h63rbmmS9Dw==
Message-ID: <sashiko-outbox-200964@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/20] tools headers: Synchronize
 linux/compiler-context-analysis.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-4-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:10:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace the no-op stub tools/include/linux/compiler-context-analysis.h
> with the full kernel implementation from
> include/linux/compiler-context-analysis.h and add it to
> tools/perf/check-headers.sh so future changes are tracked.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D3

