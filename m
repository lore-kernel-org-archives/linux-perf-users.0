Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910704;
	b=pEFuNtxePQCh8/62RGP4YmRof8BWBdjofO4XBfdRsh07xSrNjfJSLmNmpzvEm3vAPz2D
	 nuOdbhhFTprxiUbikNY6cwc7hL6Zjg8/wVMLac6GDyszbxnF119wfX67HIEaf6R/pk75l
	 ji6r90Kt5o+1rV3t8e0FI9RVqnj9Ynl8HYMloaz1UI9rCqtDGxgNLw+/6owkBPd9wt//m
	 nrrF5Gb4ptboJ9/GuWyPpIYFrFOo4Z6gONCTH49zp0KKD+1tGn00IoquYLvWpQhBC6eU9
	 6hhTFpUO4iu5yUZ6Z3ZNvfQbn1CX5L+o7uc29Gf4L4zyk/yQfMfE7/PIbDBnA6jo2Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910704;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fIaqEC56bO2bDv40ydu1kXGMM4arDlayRbU088Pok0k=;
	b=w6n1VI2o2yLlQrABgmF5Xs7obVwdXn63dx64lHYR3sxb3TMNVJgaXLV7AN4WmZ+kNA3J
	 Zjl/YyojFPM7stNVlb207GWUBzRE8bHP4MBgi7pooRiF5Il4lTA+MmGw238GxDR2vE+pO
	 QNtE2EYyVqzsb7hpzxVIQlxVFHfQa3BKh5JrfU9jzjZJ0mdkJGgbUp9kjC2bSsc0Hh3YD
	 Y5dGP0dvHzqNhSnBqEVt1h9k8ZkDtccCX5Hl3rakmw4HoE3XF4lrwE9Fx3EjGlN7vRqnt
	 l9Cngo0RIXaEE0WmIayvgmNmtDQ8Kd1v/dbRspZgPV9ob2ZVsiiCYgdsvmElCyHsbUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhB0GCUf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264EE606A31B
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhB0GCUf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC4A1F01825;
	Sun, 25 Oct 2026 06:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792910703;
	bh=fIaqEC56bO2bDv40ydu1kXGMM4arDlayRbU088Pok0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UhB0GCUftRJ5BBDJv32/2PDp/W85ri5F4Md1/ZsQc+IARXmxcjTX46cIoW+I0QWaj
	 MfKM8iQiOYijQlfEYy2GCRL/LlZ/NL72Y+A/ZjdT8sgIY/1CcsASkZOOADO1ZsyQ5p
	 PKzB5aDMnVc7iHoW62tY6oOONRwPuQQ6P0eB88zxOUodqzQxNxPVEeYNauDN8rUstP
	 zTuCNsU5oT7veYv9WadH9TZoEoKXQVE5b2zZW4Du2Xa4i8eWdqHatFMJifiYy2XPC1
	 9yki11Dio/y1QmOHUC0HVQQHAhS1xKqNLPz1aoiueM0qLFZWq8oYE4WKZynJIHCvN/
	 qmuvDeqcEKlFA==
Message-ID: <sashiko-outbox-184099@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] coresight: etm4x: Fix event count decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4d45171946cf41751215e8c1cd9a8b14d38d3159.1792907332.git.aaupov@fb.com>
References: <20261012230527.750567-1-aaupov@fb.com>
 <cover.1792907332.git.aaupov@fb.com>
 <4d45171946cf41751215e8c1cd9a8b14d38d3159.1792907332.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 06:45:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Leo Yan <leo.yan@arm.com>
>=20
> TRCIDR0.NUMEVENT normally encodes the number of events minus one.
> From ETMv4.3 onwards, including ETE, a zero TRCIDR4.NUMRSPAIR instead
> means that no events are implemented and NUMEVENT is zero. The sysfs
> event controls currently interpret this combination as one event and
> allow writes to unsupported event fields.
>=20
> Decode NUMEVENT after NUMRSPAIR and store the actual number of events
> in nr_event. Use the decoded resource count so that older ETM versions,
> where a zero NUMRSPAIR represents one resource pair, still report at
> least one event. Update both sysfs event controls to use the actual
> count and clear their event fields when no events are implemented.
>=20
> Also correct the instruction event enable mask for the single-event
> case to use INSTEN[0]. The existing mask uses INSTEN[1], preventing
> event 0 from being enabled.
>=20
> This change depends on the recent driver refactoring. With no reported
> failures, it is not intended for stable backporting.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792907332.gi=
t.aaupov@fb.com?part=3D1

