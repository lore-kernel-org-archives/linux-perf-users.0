Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910795;
	b=t7rOIxe1lgJDeCtQlNwuijTzHVyHaRl22SLQtJYOe+J+NUWfzDUKdKHF+BodiqhgIeoc
	 vRyOKpMT1zFv6dYWPoYz0OTInCju2HkjDYPNSb7U1X8Iq+7HpfiQRTE2VT1APXxYGIXwt
	 vP0Kjfu79V6Ejc2V04Jaf0NuZY/6qyIcPnFQfr1hsisG0J5CannlEyaJfkitLjx7ajRrW
	 LMxa5R1rnWstntlOfIZ3d9pyHZnGNuw8ExENV86zyyc13NT/OSl8VOny6Oq6Oq9dJIazj
	 gxO7lsMXEXJpdO7zxuV2ogAFDY7VVHCESK+rnCSCqyqafEAr44DzYlZVhQ6TZBpJBiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910795;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nlj2oxHd9cBRf2V5rw60a1Qi6sRNM7+0ypW11I8TScY=;
	b=qYb5ayc0H0bnmtJAy5q/7iva7V4aaMYrIHuKXrV9SdULnZVDyAgiHqlWt916nE9k3+Zo
	 iTdoOLUcOcX8Yna+tLi/DmPajZHLmN9WLxVNDoXuFoWneb69v1EYfk2wvix/vbrGJ4RmF
	 mJ0wIV0Bv7QqJoDx2XMb8HRRn5jSgGuy1/Hec4e3qkdOk72vrj7kp8hQ4cnw7QqTCJzqK
	 OCaNykzerwd9j73yf48yxVs4BJ54fwBGAm+FeE93vIJM63R6etG0DrsrnNSbZNZjr2oNd
	 LhWqecyQcNTYdIE+H5aOCtcf5iM3GsdcL8QGdX4LbQQN2FBcfXrNvwp5sT8nUiOUvvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qa88Hsjr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4CD606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qa88Hsjr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872861F01825;
	Sun, 25 Oct 2026 06:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792910794;
	bh=nlj2oxHd9cBRf2V5rw60a1Qi6sRNM7+0ypW11I8TScY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qa88HsjrHITTCAegS0cfeAt4S2NNedeGnW+v7sOEd4Ncqpi95VmIxKxNMZzAKng6L
	 OIXfBNxgYOIOShub2G8EpvqSIDUDNZMFeANvq82bXX76y5iJSdIxu0SSYC12MnrwcA
	 bz/+oYaiQxfZqkFU4KB33HXNRz3vq1KCzSGg3IK0gzrQFlynmZNi66ixnFa4y07isV
	 XlGiz1Ps2afqs+YazT6aGUdeE/RamW/0X5UKeDaVbO50vlUwJuyipLQnL54mSFt4+k
	 YxOTJSBKvJXygdLSXuwfa9V5MZ1J+nCWSxqjGaz80lcOZZ6wUa234cz+icKs5GErg3
	 4FDo3bfUCiy1w==
Message-ID: <sashiko-outbox-184101@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] coresight: etm4x: Report whether the PMU counts
 the external outputs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b9451758a11f18f9a566a4d4c08f4131dfcf2a0e.1792907333.git.aaupov@fb.com>
References: <20261012230527.750567-1-aaupov@fb.com>
 <cover.1792907332.git.aaupov@fb.com>
 <b9451758a11f18f9a566a4d4c08f4131dfcf2a0e.1792907333.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 06:46:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Some CPUs count the trace unit's external outputs as the PMU common
> events TRCEXTOUT0-3 (0x4010-0x4013), which lets a configuration drive a
> PMU event from trace unit events. Other CPUs, Neoverse N1 for example,
> have no such events, and a feature relying on them would silently do
> nothing there.
>=20
> Detect at probe, on the trace unit's CPU, whether the PMU counts every
> external output: the trace unit has an external output for each of its
> events (caps.nr_event), and pmuv3_event_implemented() reports whether
> the PMU implements TRCEXTOUTn. Only check ETE: per its specification, an
> implemented TRCEXTOUTn event counts external output n, while whether that
> output is also an external input is IMPLEMENTATION DEFINED.
>=20
> Add a CS_CFG_MATCH_CAP_TRCEXTOUT capability match flag, set it on those
> trace units, and show it in the feature's configfs 'matches' attribute.
> With capabilities matched separately from the device class, a feature
> that requires it only loads on those trace units.
>=20
> Assisted-by: Devmate:Opus-5.5
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792907332.gi=
t.aaupov@fb.com?part=3D6

