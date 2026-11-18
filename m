Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973511;
	b=lWwi47rskE8IAEPJwKEoco7sQxC6+TsfMPPnw/XaD96pMHi1f07fk/qI5NC7EILBmc3Z
	 rxwL31kezCqF+6FM4zbeOKSVCP5PHCXMPvFomShXJ8zJp2FIQ42Fe6L5d77QORc8+zT/s
	 p99JwufKnuT5Gi34DJ2zN+W1zvemGtuNsPn9UfSC0DvbEHC2zUWGZaX9sq0FaXwXruZ17
	 3TYYN7otIZRut9GM3F8J1iOKqxSL16IjMoZ4xe7d3ks3RjHf4bzsAoVV8ki3DV9drRGtU
	 jQ/AVq7m6VNYrmcZncJsmCuWZP0oeyqlC6OGveKEPCCys1ac3KYCCzPoJrNAma9Sfig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973511;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nGCDTDUdrOcXwCyfzDrBDB+0nyRFOaGwcJAZSWwxHdo=;
	b=xolwcb7YCr6TG+SwoEjtGRMBOtzBXdhTUotwcAJZIvMySsxZ3C24o90NCAVLHp33o7xW
	 Od9GEkPgOSDQUyOKxBTTztlA+5w431wgXso2GSG1NSaboy78Q/0zpR3pCQzJTbGzrC1qG
	 pyMWavwFZ2GxHuG+Z8miHYT8N2uLFpEnaemkqKbq9aCm0VHewvHojtS6TkVLkxjuublrt
	 JCIG/l2+JErZbA57GAzHjY3HBymZ/DE3OdrYGUQRTPvkf2g2rkzWi6dob9+Zdo57zbkAZ
	 /D/ux+6yjNWzrOlDaDmhBq7GPW4dTlekiY3W8SJaXK1lJf3dD7YMIlJgmDnoGnabNAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B93Q4S91;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC6606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B93Q4S91
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E871C1F000C4;
	Wed, 18 Nov 2026 03:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973511;
	bh=nGCDTDUdrOcXwCyfzDrBDB+0nyRFOaGwcJAZSWwxHdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B93Q4S918CHfv9YreUofho4nsgFqYjceReB0GIe6LSgPFErzDBhydlws7ZLL+MZu5
	 CB5WFJDMgkrW9RCOowQb4MxZm6DJJP3Sm34rAbZmcCVxGleoRHiNky+h1qE5/pie3f
	 pvl0bbq+oAqgvWkRld1HEoinRA6aGLGtVNZZrGpd/6nl6VhkIT9cN9fi+WkGTzHLDo
	 zwOhLidvjdDr6Fh553kAm2rJu6BfAwGT5H/l9k+Rfb44igtDeGi8oKuhNwpRydOjBl
	 D8pg6XmQh9I2S4ngyqLhoQOwknG5YFPpYuc44dnuDypGxDgnWH0zj5Ecy7NnjCV++1
	 6fxI1qg+8pVPw==
Message-ID: <sashiko-outbox-220039@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 21/24] perf/x86/intel: Refresh LBR stack for LBR
 counter events in PMI handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-22-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-22-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:45:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When handling an LBR counter event, the raw LBR counters in the reserved
> field of each LBR entry are cleared after the stack is processed and
> reported to userspace. This prevents raw counter data from leaking.
>=20
> However, if multiple events overflow in the same PMI, an LBR counter
> event may not be the first one processed. In that case, the raw LBR
> counters may already have been cleared by the previous LBR event, so the
> later LBR counter event cannot read the correct values.
>=20
> Refresh the LBR stack before processing an LBR counter event when
> multiple events are handled in a single PMI. This restores the correct
> raw LBR counter data for the event in this corner case.
>=20
> This situation is rare, so the extra refresh should have negligible
> performance impact.
>=20
> Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D21

