Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528079;
	b=QRAXRJfBVyyaJfNn830f9MVHocXwEi7fnIVyrOAulcAissMn8FkTzY1K/vHT/jRgC15m
	 zclQ1P3porMzHIGhvAjnZLo6OTmb7Jyd29imybE3SvtiEo8YYlrttEdwL1TgYuWpMe59I
	 YHx3xQw6N8e+FrY5082Gb+8D7uPXLV3SNwCJUZevSkPp0V4HKUTLpgpD9tnuzSsS8ftGQ
	 rN8lWNsQQnlWtZSN0WG/I3lYLxj4wVEY/NzSqmd0Gwb1jw+iBnzp1kDCwy1loCU0mBmRB
	 WkRdwK7myGsz69ianaRA7JzQjPSWE5G+WJWMGmxDp6j8t+x3XS9To4J7ghAPhBtAm2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528079;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LvthKK+8oXY6hlRLzCM3q3H7Y0KV0L7gF4EcxB2PEdg=;
	b=JMNrm7wlCz6rYeqQd4PGZNdqA+2dmPF1ydBlt9RabVSQfDjPGeHQI2G8SFSQn+lbTKwD
	 hvSBN4VIjUunLH0pvSbayR1xiB389Z50m/zBTOPIjpWaDdlEyDI9eKTga+4bkYRJQ6dBG
	 Nmf3o/wESCshDS6eestFKIZIeBfCkUR9ioFQg2Yc1hTYSXukZqod4elqQEvox/SJG+zuq
	 t4qyXZQ6f+TmFkNuKKGKOkr/x7NnKK4azPn6XBKn+asPEDCk4B7MS/+o+leHQQp4DNySF
	 Q+esI0TyXEOZrtEHZ7M5kVpAHdqBjYRZOH5qNF2Z3ibjG7/wAxzRr45Pk9zmj9EjuXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFibUzxc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F68606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 00:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFibUzxc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981A91F000C4;
	Fri, 13 Nov 2026 00:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794528078;
	bh=LvthKK+8oXY6hlRLzCM3q3H7Y0KV0L7gF4EcxB2PEdg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kFibUzxczUUJDvUJCOBjsgKrCW1LRaGte8qfLzfzPAuQFqVKAjjqn2dZVx3uTaFXr
	 dvNmmrgGOHasRW13t7FxtykwWXFKR1NgCIQac8vpeSTllx2Scdq0j0FecUdEyemMg2
	 doHZumiN3646elzQQNCF3+3N7Ga7It6Ad/ickrvngtVZbJ3txXCDOBE97jo8z+npWl
	 /6smS/si2YMBeKoOjFczYMlG4ENjlsBHy64vPyUVCuS9k6XC5IF3ogkVf046w68dU4
	 33POalRXSQu0mYv+IczIZBU7oRuUEyr9aK604LpT6uJ5+lGVInmUNJVjBJs62ksdkB
	 XDfCZUxrQ8N+Q==
Message-ID: <sashiko-outbox-211972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf/x86/amd/ibs: Fix missing CPU hotplug cleanup
 and unchecked init return
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ayush Yaduvanshi" <ayush37735@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112235003.18608-3-ayush37735@gmail.com>
References: <20261112235003.18608-1-ayush37735@gmail.com>
 <20261112235003.18608-3-ayush37735@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 00:01:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Check the return value of cpuhp_setup_state() and remove the hotplug state
> if perf_event_ibs_init() fails. Unregister syscore operations and reset
> ibs_caps on initialization failure.
>=20
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112235003.1860=
8-1-ayush37735@gmail.com?part=3D2

