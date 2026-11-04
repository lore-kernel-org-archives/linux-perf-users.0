Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757206;
	b=fKSS8OCWMLndNdXyvvT3r5b2Me/afOPq7NR7jjoj1ulbn33G/4UUAAS5N9tTxHDV77rY
	 o2Qy9i2XaBRJXHlF9uv4SfNzUSl4dKonQ8RKBsD2+NBPw1G+bnhkpKsZGURXbgPrWfI37
	 p6ZLBYBCnhyh8H/3W4yWvryU5OnmourJAFe9+wNQr3roee1ncP67yFki58syVHuQhszhc
	 Lalw1Gn1NEVl8sRidWFgV+uj1615jKorkWUMKrHwBqS/FMM5aW6Cu9Tr0tqWTLuRfSCAr
	 i6g/ZqgPX1ue1tb0C8PT7bn8HCKcXXMQFqsx4ZPQodWEJQH0XpprCYObRdWR0nN6HvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757206;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bAQ7p6NMVhW91sSlLlSPyeie8VM5QXWyYcZEyZGa3Z8=;
	b=G+gvMKFDZzahKmOto1uqaNghWz22G8GDrXluhtgZ9v06U+lUPSXJRjuieA0EM/w5+oRr
	 8t2Xw22v83nSiqcKz0VFmGi22bwnSvK31eJnPC6ocGdKAh7rnek+njSX3byefpVR3xjHz
	 BuG3/6PQqI9XN33HwmuCaV7Yhw3pHZbDCj/wenAdQPDkkfEhNVPf8b6ZGCiAvwH1IOyil
	 tzWY9JcleOrcTi9Ccjt1xRpEP3H+G3a+ss7c7Sx94KrT2c1NWR8qE6d19xEbRIFZoqbI4
	 qbfC4RyAdUbKfj3YwvQuFwm0d1mXwD0VX3poDjgQMJHphGHKGc7pd4YA1FlnN0OkjNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bdVwteXl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D60606A326
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bdVwteXl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3701F00919;
	Wed,  4 Nov 2026 01:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793757206;
	bh=bAQ7p6NMVhW91sSlLlSPyeie8VM5QXWyYcZEyZGa3Z8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bdVwteXltMv1wlWpgdH7TkFfsmdkDwdBrKveu85fQLDJpa4+APihq/ItRqklfERAA
	 9AagnfRAO5AxFj/N3p3OZObFlZWZWtOllmBq0T292ABH0I4sNVPGS0TxX5nL2thSvg
	 QzQLMofQHZ1Ma0lo8Yn3oYXrGmSOT25MjRGp9pJrD/QmLzxMSBZt3IV4c1Ssps2JX0
	 kRL+uQm+y828oV8tD+yD6WLO9nbAJQcKYqx6FBitCnWDNBrmQ1gv6g4S+PX6EprMiH
	 dFSyb724MYCw7kRM6SsCAe7N7T53hWP4eL/8vr1IgUYxPExdZ+sN0tcAKNr8iIp7y8
	 TQyvSBlCMsCsA==
Message-ID: <sashiko-outbox-196397@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/20] perf: Always inline the empty perf_lopwr_cb()
 stub
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103015238.3780910-8-sashal@kernel.org>
References: <20261103015238.3780910-1-sashal@kernel.org>
 <20261103015238.3780910-8-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:53:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_lopwr_cb() is called from the noinstr acpi_idle_do_entry(). The
> x86 implementation is __always_inline, but the empty fallback is a
> plain static inline function, which the compiler won't inline into
> noinstr code when building with code coverage instrumentation:
>=20
>   vmlinux.o: warning: objtool: acpi_idle_do_entry+0x4: call to perf_lopwr=
_cb() leaves .noinstr.text section
>=20
> Make the stub __always_inline as well.
>=20
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103015238.3780=
910-1-sashal@kernel.org?part=3D7

