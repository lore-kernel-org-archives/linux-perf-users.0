Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254132;
	b=tX4eOHjONECu7kiXT7ekxvNObaw+BgzHZ1lX+UUOWfHfu84ULLqk3vPjmaUYuX7DqBGU
	 lWKMq31OeBhVHkf3XvTnC8QHGQU4SCgBNrM6pSw2hBE/QDI42SZKlAjTMFx0AEusGBLFa
	 y0CBwMlhBWpMK7FCfkqX3ofJD3sYgcCLS6WGRymPqSmL+SVl6RU0rk4Wuypkkw0ZR3Xfh
	 C1S2eXGqvTsTXnaLr3VDQFNCRxEHgdyYiUofk3Z40Vxd20x6qX4I7foxOdTwJMR6EmaQW
	 3YzCWqf83gVAHeYXHUg6an9AWg80+3djGFQhHPaRqnFFdo8unaScrBlGULGZusBLqKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254132;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=utiywKfAr0aONqh+OqkkoOSGNTYcC0bDGdCTbAh06GU=;
	b=3tOJVERjbDkTP8BH68j8VmZrykiOL3Z//+7+Fo+o7vlfaEeEVvgFHkQjHdEkUCw52RmU
	 Unj3UJZ50M6EkIGkzr8l5IfJNpJ8ShoLLO+IBpKrOm+daN0eiAtEIiJ32AcuN+VpC2xyY
	 IY9fJIzggUnJ1oL2LzTexQI69sFFTvSaaJpzTFZ8Ugo2voswG4uWecdTZtuT2HuDbbEPf
	 b50U+2IylVp2gsOk0SdICHSA3o3eJ2hplXAbwMI7jy17lbnwztwmrQjGBZXQE89Xlzjkh
	 vmeCfGvdEQoeCNPmpich3aFkO0NgiHAAmCqdPZ4iLBQZo20M8owyuU0GOxq8/2jxbPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECUUnoSd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8A606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECUUnoSd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD7A1F0089F;
	Mon,  9 Nov 2026 19:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254131;
	bh=utiywKfAr0aONqh+OqkkoOSGNTYcC0bDGdCTbAh06GU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ECUUnoSdsqwUgeGvOfld1OAZsByPGBNY4GtfUEvcyLqfcsoMJGKwf7sCVMMwfOKBb
	 pPekVqXxF3YljY67NGjis5xb2Kv5HLlN2zJo5zeE1ZdZSydSqMq0RFFYyYZxUumOYF
	 h8susea70clpLQDsTAArf3O1OwTzIS8QuBQyq+fhosZkwalDld2dR/wSoMxFsG/8qT
	 CDfv61fbmG10AMtqdUv1RqcXVcU3lY9RzxzncceKRtiRMPl4b8ZETrT3mm0x05bGMU
	 ICcjaH0YtuaB0fgV1ySjtZkLK3jkB8E8A4Km/wTaZvyPeOJMb+MYCaQyjF9QUX93yO
	 ZV0wBqM1cTC2w==
Message-ID: <sashiko-outbox-205509@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/20] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-2-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 19:55:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> _context_unsafe_alias() does not use its parameter 'p', which triggers
> -Wunused-parameter when building code that enables -Wextra (such as
> tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
> Explicitly cast 'p' to void to silence the warning, matching
> __assume_ctx_lock() and __assume_shared_ctx_lock().
>=20
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D1

