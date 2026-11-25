Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589321;
	b=klTKpdwg+csvtzvy0wcsNH0SNuCimP9trC96na8PSubvl6LR+mPKJIfwjJFWkQmby93h
	 zCSgly5vwgv0TTsr5182JU47SgzVkcl1ITRbjF11ztGrEkDtiURiQyHUYf3wd1wC95dLQ
	 dJCWYqfiP36st/LXiCSxtkzGPnUfVfzMMpozxjyb60HGlOidR+jzfWkLtV0OxyEZ1eggt
	 cxFPo3vqLydOkLPMv2gFHX8ZnVLeHfoFB596DN01IWRNSu0IbHYEqFp/0MytBi5MAZ80S
	 TKDhDPkwjq0PXgTsFmyMNPrGMNvZzB2Xi79i6MA5cEIwe8RN3zRXLgR48jLqfxMv88A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589321;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+CjD+3bMGN2cI1DrhGE4xaZ/9qml8EprDs+UFXnXnYc=;
	b=HMRM2PUclsgTz/KztK9tiqjqj+gbTHVMVaX21OWS/WoG76OFYa5tDUvXkVfLfAzb+UQB
	 Ocjz3k4lSqMA7a+0qRtGWKcSwMykvLFiVf+CvqwcKTm2NlhiKVc3gsxDhe+JMxVZw61QR
	 Ur5qRDYThZk7w7z9v3E+HeQVND4ime8PEHqwDGuhwWEy0deFCxlXN8eLookQUtAS5rD5T
	 gdkOD/PPAhzrkBMofDr0n6Yd8c22BqHdGQatBcJncm1sTNtdvuaXiubANFtVIzhaffspN
	 5UZwyE2RiLIQp9hYycGOPaY/akbwNqU2H3tKR6EL0zWoOc4OJY+qIZRKaO8pFtPttjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGS+WsQ7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD7F606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGS+WsQ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB11F1F000C0;
	Wed, 25 Nov 2026 06:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795589320;
	bh=+CjD+3bMGN2cI1DrhGE4xaZ/9qml8EprDs+UFXnXnYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dGS+WsQ7u7mmY9rW6abeQn/gOeo3Jdigp3fZW1W1zpk658I9GVP1CJ8pn82hXuXs0
	 kfxouo+U719cx/Gfasu14v+P5NM2APixZzHIiBKboZFXH37OVGeeNM/cwfGAYYj3YR
	 1kUf4PuesaT/883OHQvdpOgId9slKVgjkFUqmjfq+K5u1LQ/dL4GooRL+SzOPkEMj4
	 ld0e5VE+F/B0ebGD8KMxRyl98iqT49fyYx9HHkfByI5E24L3yNxPyE9sdgRuuXiHum
	 0N0ZlfA+WfKdtAlSO3UOvhCZU5ajxbAzHbGdiMl6Kh12JjwO/Pvj8HzUAI3qz8IObL
	 Ru0bzp47jXg/A==
Message-ID: <sashiko-outbox-232737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 00/30] unwind: Minimal DWARF CFI unwinding for
 user and kernel space
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
References: <20261125061523.1540234-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 06:48:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 30-patch series:

- Patches 2-5, 7-18, 20-25, and 28: no issues found.
- Patch 1 ("unwind: Add Minimal DWARF CFI bytecode interpreter"): 1
  potential issue (1 Medium)
- Patch 6 ("kbuild: Wire up CONFIG_UNWINDER_DWARF_CFI_MINIFY obj..."): 1
  potential issue (1 Low)
- Patch 19 ("riscv/unwind: Add Minimal DWARF CFI kernel unwinder"): 1
  potential issue (1 Medium)
- Patch 26 ("tools/unwind: Add standalone libLLVM Minimal DWARF C..."):
  2 potential issues (1 Medium, 1 Low)
- Patch 27 ("tools/unwind: Add multi-arch symbolic instruction li..."):
  1 potential issue (1 Medium)
- Patch 29 ("tools/unwind: Add x86-64 ORC cross-check oracle to v..."):
  1 potential issue (1 Low)
- Patch 30: skipped (not reviewed).

Detailed reviews have been sent as separate replies to patches 1, 6, 19,
26, 27, and 29.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125061523.1540=
234-1-irogers@google.com
