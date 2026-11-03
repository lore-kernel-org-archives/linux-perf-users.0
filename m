Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703798;
	b=F6Hcy3AQkoMtjAXWcYa11600dH2zq127NILflcUpuDUwq6O3jWuWnrPtscY5m2WA0KtA
	 B3fMGLZkutNoXlKmDiH7OB9YqyX3CzMh7ri3P3Zj7YIaHkGym1doeiWM3ZkvTaHmIlg93
	 exvUwaFBDUgQIrLh6ds3fKXw/icxJ/OubV/2D2Wu2ETK8398pu76Sxt5FhIWsvzPywY3h
	 tKBhGD3TOZhIQCTu+8SHcW9fdIOsa4fLFcIYlpa/W9ePlgvoskSbn6P5rV7BbisvM5OFk
	 +R6jqUa8JiNYzh4hldQAs+ZVHLFBptI8r+IcoW9qXwt4P2zCrO7V4745foT7u3er9sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A71YoTidvQ/KhJJUd8aEfHvBqMES5d9wUVNgni4Zlxs=;
	b=s7s7FcsXwM8NjhVb29SRgl2ajEY98hJRcs1qq8JpZDgHYgZn9zhu4d7Fo6Nvwjf3YiYk
	 8joQOpqL0PK8GKvmLK7TRWnBNXR5OqtWGuePnxpgRme8+g7VTY+X+tf3tGZ7m5cCLXTbJ
	 OPN9DvtNDM9s/8wvc9YoSsAUYizaPq3K2nVfZDE5F/B9G9b51lNg1DU6ZgSFy3A1lsfM2
	 LaN2h2hgeWdYWmTLmakuQ8cy/chZOqSfJlC+cSsoB9OjoIvmhk+u0z0QOpb+ZAN+2Wma9
	 I0rcBDO2KpORfKcsZUqGD99R7XY3VbkfEtEpKfm8quY0SERI7r6u5qsbVkAyUimzpmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HV5dcFfr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9C9606A33A
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HV5dcFfr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A5D1F00A16;
	Tue,  3 Nov 2026 11:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703797;
	bh=A71YoTidvQ/KhJJUd8aEfHvBqMES5d9wUVNgni4Zlxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HV5dcFfrnUWXknmGDFD/P3dwdAbQJuJAaN2DMngTd/HJD9i5yc0DEe1zD3MSZh+lG
	 mKjnspqbA/EcoveJbyHCaov/I85dH64+DELk15Agz1CHNyOU0w5DgiI6EU8uUkywHy
	 v0YeT00LoDH7PjX4CBrFAChZ2cUQFFTL6+0Ps2blgaI19lVQi0+WMdt0Ju5xaD9WoL
	 757vvS/dEmOFsVI+hFmVtJEH5DU2LULIWsxu7bnDiYa+MfcIKxJZUTPnwv8XBRHiXv
	 WKEcVbfkA8IUW0lr0eWIfk/OyLmuUGv8qD/ezjXziOc5LCvW4gMjs/KTBvDYSh0gb0
	 jgTQ8QfwmnvEg==
Message-ID: <sashiko-outbox-195097@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] arm64: dts: apple: t8122: Add PMU Device Nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261103-m3-plus-pmu-events-v1-10-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
 <20261103-m3-plus-pmu-events-v1-10-a8eb6c1139fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:03:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Myria Sarvay <myrialsarvay@gmail.com>
>=20
> Adds the PMU nodes to all t8122 devices.
>=20
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-m3-plus-pm=
u-events-v1-0-a8eb6c1139fe@gmail.com?part=3D10

