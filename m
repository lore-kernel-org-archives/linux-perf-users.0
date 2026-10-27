Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071528;
	b=izMbuVEeUbIIvjGGrujsSgmpqYBWspkGdnQT9L6p1BccDxryEUHjzg25cCjNgq9vplOT
	 Dx5D+BWqJDLQb2xFyyIOaLcG2P8MDr9tdkMFR2TkkudDH+6pzJStBo3EhSUtPz0Fc+CqW
	 KigtsqR0G9Gyo4krxj8You+53+fdcU+f4JEjutkPcln+OIpQqRP8ETKHYVynH1eqMFyL/
	 EYkPbEdwtu4T2tT+ZIU2FqH8ZBOaymgogeM16XWAjpW3U2xbya/TH2/VSGNuveJCwwkXW
	 DQRjP1tydl6Nbv8tWbwq+58pwuOJ7eXoN66YNnxVBlNRZv6AtthjaNaYbjCaiz0LyWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071528;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KTM/gMm5cDEmcPPLMid4PpRepQVNZovhbrcmJzXuzeM=;
	b=10FgkDcjoNp8HfO5CH36IaZN8itVE5EjxduJWvKYRw+m+/Kxy6eqmPJ2Dl7sUsJDfekk
	 tyzJ56GWUIdrP3Vai4kvmrdds5ugjeYUSGpx+3GbXh2zVj/ybb6LvEdrMr4b93zSr9v4L
	 RBZnvxnSo75RaTrjzOTpvR/uweJMYQgv3GKs8LbbREU42c8CZQqzjavBCjEZaGsYJAy1S
	 EN7hoD8GMrs1RdVucYCk09cntkfVPT8+qGYc3xf7VsebNqLoEMHBFlqWUzPYZgMglM5Tl
	 XxwqK2xROcrs5wrlsyrYVWoJg5vFGOR6eqmfM+6h7aQUGpMXUn+H+VM7fzyORSmxBBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OoYu7/w3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67819606A31A
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 03:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoYu7/w3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D160F1F01825;
	Tue, 27 Oct 2026 03:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793071528;
	bh=KTM/gMm5cDEmcPPLMid4PpRepQVNZovhbrcmJzXuzeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OoYu7/w3TSgRFvlrnydIimoKRetq1g+aEs3rjoL0NZp5G7j2ihLyLlfYE0nsMIDto
	 626XCist2KjDV+RYaZymOcPg7sJfBe+/DDnS3RcIGgbXxMS1RrA1zI2sG+v5VokXY7
	 +3itzqup2zUD9roPBXRiSfr9wB/2Y+MNIgP5h/D3LAViaZv3yN/QJlW4z9w8vkyn4e
	 Ek4f65ZVHyk4xV8LH4amp7psA7aQ20+4v7Lenb6jO2tUjzFUJgcowbT01SumM0bW/g
	 CPnZVBEyeWBPxSRrgWVd40FEfwhgCKNJrunU4rjCyHBUKnJ2AXHn7jidjgMZAaELNo
	 9B24iA5oE5OBw==
Message-ID: <sashiko-outbox-186052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: marvell: Fix DDR PMU polling period unit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yingjie Wang" <1075151112@qq.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <tencent_592E3D2D89322E934E28FE593E67826AAC09@qq.com>
References: <tencent_592E3D2D89322E934E28FE593E67826AAC09@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 03:25:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The poll_period_sec parameter specifies the overflow polling interval in
> seconds, but cn10k_ddr_pmu_timer_period() multiplies it by USEC_PER_SEC
> before passing it to ms_to_ktime(). This makes the interval 1000 times
> longer than requested: the default of 100 seconds becomes 100,000 seconds.
>=20
> The driver relies on polling to handle counter overflows. Delaying those
> checks can leave programmable counters frozen at their maximum value and
> lose events until they are restarted.
>=20
> Use MSEC_PER_SEC to convert the parameter to milliseconds for
> ms_to_ktime(). This corrects both the initial timer expiry and subsequent
> polling intervals.
>=20
> Fixes: 35a43326a9e3 ("perf/marvell: cn10k DDR perfmon event overflow hand=
ling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <1075151112@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_592E3D2D893=
22E934E28FE593E67826AAC09@qq.com?part=3D1

