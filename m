Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037357;
	b=3xa7d2a1djMVPmE6wrZISUWFD0sFwPpdnx6aNI68MqtUt54Vf7CyO8RknuylsZ2DlAFU
	 wrSyTTvEuftT0taGEt9dXyEMBdhby/ZWwliDEPM3JBLkIYmvyem5Vi1r9A7besO6dxJvs
	 CU2QSUuwgRS57yB8WhhzFsPqXC8X/OCQnthn4qAPy8XVTD90bsJZ5/w4v3d46I6Mbiqqf
	 +LItAgs8craoyNwdc9q9CJyWPNP97jaupAn5n6jQH87apelcO+14cBbjOrLEdSpeIPt8L
	 nCLOEoch6i7vH/+jGcyf4Otokhee3Cj7/s7p2nyTQtNDJhxvSVFCXCKxF4vyvFmjAzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037357;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ao8Mu7sdnBeHHd89BQpxFqtlakre5Lyr1GP8BwucmNQ=;
	b=yxyWWzWNJqXQ3b4qz7W/XLtU2CHA7/VQ71YGBnvelfTjdNsiZEKHejmoU+/rYVxXb0is
	 2wrHc/YhevPRRFZrReakJNc4fnVpxKdBQN2k4w1ehL7umDWXejcxKp1NgPvk7qazMjOGx
	 wXUaASW2Qnf57r9vRmIiKPcY5SKWuimMJ5qYa8PBEnigYa2nSMg7a1MAqt/2B9eC7w23P
	 uGXXnQZu44DSJdFV/9IJXpFYv5aL/EHiBTKagS6gA5GO6uv18dT/12uRhMmjN2q+JciYm
	 ukmv6WBpdnm6Xnp5MYLYjYKv+gJYeCfQraY5MPxkcE2gPMF6SsubWNldH/hpCdnJb2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=InVIJGQA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FB360A3803
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=InVIJGQA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0351F000C6;
	Wed, 18 Nov 2026 21:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795037357;
	bh=ao8Mu7sdnBeHHd89BQpxFqtlakre5Lyr1GP8BwucmNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=InVIJGQAgNeiMZQ26v1AhBu6+lxv1J0lHRn1ovXegU8cHGsHpwjjJ8h2f7dB9xknX
	 jTUA06BWy7ghkDfVamN3Vji0VjjO5q9LkXqDfX6w2CEo74l24kt9um34wC5iiVVpmZ
	 VNgDVIivxh1gGvyAMRCy/oWe7I5MbLo6Y/S3m6lu/aP5ZYJ961T8941E7RZmX+so4L
	 E1dlLO89EzKu0PtLBjw6yscYmZ/a4J1qWdResnxRRXCPTsyP/VxyUdJCj4IqJ6iiSU
	 W9ek50PQ25mAPXgBn4fRVLqZ5FMo0sM/hYv+V4jBgm/t0c9ppftll68ODqqa40Ze9j
	 9CnYwieCvlnvw==
Message-ID: <sashiko-outbox-221995@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] perf vendor events intel: Update lunarlake
 events from 1.26 to 1.27
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118212655.2262601-3-ctshao@google.com>
References: <20261118212655.2262601-1-ctshao@google.com>
 <20261118212655.2262601-3-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:29:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The updated events were published in:
> https://github.com/intel/perfmon/commit/99819cdd185adc5eb117eb78296bc29f1=
5e9c5e7
>=20
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118212655.2262=
601-1-ctshao@google.com?part=3D2

