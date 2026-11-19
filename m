Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795111005;
	b=e77Jb/zDx0Yhfe3bpC/5F3r6EsU5K/Dk7KC/xfvN79FqW4rZh+Cp0DIK2vZYXHkkmy3g
	 ASwjAcwkIkUNSdeJiLvnokjA7yEwjWCsKw7AMZKBfxbrQhTPZgrvDWHB2dmAe5cS9ipwD
	 LmV16lA110UqGFBRippDonEkqh0xSxcaZKGsUdXWys13ZrTqlyh+9mIMTF5ETDSac58Ow
	 1Zz5Zz0k9bPzPLTOgFeR5tHmkW7G0M+8dlt8jqBWDGn67xnabjOVkKsYIpNWSdeDghjoU
	 D7BHLXfvxA23TkxF45NKWX+fPgqYuWKaIofrHsFce0DeTCsIcY7p9q3hJyWYhbKV7tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111005;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KNej9KIeQA9wKNZJTfxvL9kUCLJB0zFxmECL/GCRSZs=;
	b=f5RmEyUW/81UEqDnPmHWT6gxRcD6OrgJwZeGKagomSYphVxjrknfG8FVQbMqol7R/Bg6
	 MZdZvCtUXuqHH88lxbgxXE5X04yQuRh8lIOEnAPPYIlyb0hLGCOU5714Ne+1saNox4cbf
	 fGRRaTs4R6njUv8j6kr2M+/WZvpll6iInqZojQLTnQRSjUUghMn6hTy2iGQgcLq4y1llw
	 o6xc8RjR4g/Pv3jQBqxposTkA1QoKuUFIHnz0x9g4j1fB0zlmg2q3fH1KyQGm9hbtdYBt
	 Vz6asSjqpBPPRgpQtWjwjEY8Gl5HdT/+hNLNtt0EBgSuPqXSRmvydUWkSDxVVc8p88A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIqMMbli;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAC606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iIqMMbli
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD881F000C4;
	Thu, 19 Nov 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795111005;
	bh=KNej9KIeQA9wKNZJTfxvL9kUCLJB0zFxmECL/GCRSZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iIqMMbliMIiM+HpTjeoCBklgmByaZvWzQh5g1w4laUYHFyfZe+/sn8m2hV7Gq340F
	 WSYF5YbY2q8owd1AVhKb7ii9KYJKHiEm5KFDCx+UFMBF2COrtrfpUuAcOC4nCx1sCh
	 fQERUtAAle/ukYiDU/TIPLABeplnnZh6z9T2pEfLpp70syqxGxAj286eaKsg85q67I
	 Rj9EfCu5oHvO9BU4bq8NgOTPhe5yb+qMWvHcbr3MWyxJxlLxcgKL1sDBpvDrdcmXrd
	 NlxZkq3iZ5PKYMKO5qp4WKqpoHT0rGNPm/vas9To/KlBpoTpXKgzjjphQ8v4zvxc2W
	 ovCqtw7vn/LGQ==
Message-ID: <sashiko-outbox-223735@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] MIPS: eyeq6_defconfig: enable the CM3 PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119-i6500-cm3-pmu-v3-6-c86410934b51@mobileye.com>
References: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
 <20261119-i6500-cm3-pmu-v3-6-c86410934b51@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 17:56:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Enable perf events and build the Coherence Manager 3 PMU driver as a
> module.
>=20
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-i6500-cm3-=
pmu-v3-0-c86410934b51@mobileye.com?part=3D6

