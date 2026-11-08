Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794105704;
	b=f0cWa5606oqlWZ6bOgwpZ6EKMM8GbyMkL0WpNKOcd9bIJG3pYJNOVOk86ooyQpiOvqCH
	 8C6mfb227eQupMAXcCkUgPrYzL3rADSPwVxiSln8ynFMYg2mlAhtmCMS82sNUnZgh25k3
	 scEjVP0c8sgHNZoF9r0+KJX6qWwbBn5Dqjp+ogTbz6eRZJAgUmhOj5GkKGE//aHx2hMRb
	 74VP+EN34lX+U+DblotRbbfVXECgJfzEERNGIcePzHRO5nL3tuot+peRWIpC0Sf/H4l3P
	 cXUre3bpwmWFLvSGkIqq7CJTCnPEuoyqtgrt9E7HmOv9CcsOuJt3N2co08nHbQxyMaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794105704;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MSMgP4ZasqPf3Ar1MZUF9hA1HNCgzwPlZjFdsTAOmc4=;
	b=1A/MLsrtIzFBzNX8gQoS97CBPnxRi5yQj2VwpQkkNMYziW2QxmmI3VTVlqr6ckIVO5p6
	 y5o7+79aEPlsnkJoPgRrWT05jU4gLs/MveDFD9pBMlGj5OIBGejr60mePESir7z9yFBYz
	 4sfR7kL8CAPiS8YPO9dWpy9IwxCyYPW1djtHifA3gBlxeDxOqLptegL/IFOOsddiWANen
	 Sa29JPu2KBbkeBGT2SQUW+tqjruJr5h26/FScqnGafU8y+AfsWqnPxxbIub9JwIYHCwrL
	 wB437aWPhH5HcjcAsKso5VZivCrb9KdVeVv9F3FBNur3cyVmMRwUo62wCI/jVbYtiBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFz9e51+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF1606A321
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 02:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFz9e51+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59031F008AB;
	Sun,  8 Nov 2026 02:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794105704;
	bh=MSMgP4ZasqPf3Ar1MZUF9hA1HNCgzwPlZjFdsTAOmc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SFz9e51+c2gSsQI9Iz7Iydtqu32GRLiDdASYAvwyRZHYk9ROXgOJJg82zcy1kgnk3
	 Fk3HBc52hC/cRnhdvvIfGCHBaloImjHv7rjo7QeA8wMO5LF1zv+pGx8FBTwGJ1Qz/D
	 D3mDBb4rUzfHA1dmsTk0445nof25AYngs4VsqeuhhPBpN66laD8PAfp9XKBLZm/ziH
	 sNAGXBi6cY8v5QUwf9ljnf9JWfUvGCURf6prz9ygsdwwFMgtHR66I5rdulgUDtxSRB
	 SI/704m1QiabPuBnT8OmwHqEy+rFwoh5sZGi2Sjk7PzoL2rBO3FVvRe6Bc7ALYEmjC
	 WyKpqUdUX0KAQ==
Message-ID: <sashiko-outbox-203529@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 8/8] perf tests: keep bp_signal memory accesses
 visible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Chauhan" <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107023917.40606-9-himanshu.chauhan@oss.qualcomm.com>
References: <20261107023917.40606-1-himanshu.chauhan@oss.qualcomm.com>
 <20261107023917.40606-9-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 02:41:43 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In the breakpoint signal handler test, a breakpoint is set on
> __test_function. Keep that helper as a real call target so the breakpoint
> has a stable address.
>=20
> The test also relies on the watched variable being accessed as distinct
> memory operations. Use READ_ONCE() and WRITE_ONCE() for those accesses
> instead of making the object volatile, so the source marks the exact
> operations that must be preserved.
>=20
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107023917.4060=
6-1-himanshu.chauhan@oss.qualcomm.com?part=3D8

