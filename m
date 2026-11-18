Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794990027;
	b=lgKJxc9gb8P9KIeEC554+0k34wM4oPYDfHGNItGsdL8ZCDxX5alSxqYybD7Uh4ty8Xfg
	 GqeIletQDgDJ02g9JQLriFBBWQ/jjdWVcjqSkyDvT0yrAVuLJBWrDDsC/HUaFOvKPR2Yz
	 tx4SI4r0jMpkARXHIYN7uxeooUf0TTa6aOqCtJX/OHZdImrklbZ9Ub6zXy1EJ4O5M8uXn
	 mzdThSXoTcuRongnq+YhcRMFeLNwDNeJpGtKdjwBbfak+MRLF52Vcjqv9kWH20kIpUr6S
	 c6Bg/xHppEpcbzpuqLU09KhGbA2fkk3sy8zioGt532R4Iq8jUmbqvLRkf2xmKXXcF4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990027;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f3WSC8YV/wYkbItG1J9fV7g4fvhgI6esEHTeTKZj6zc=;
	b=Q9humw9MtcTeFJHsQdQKyru+K2om4SvpudgtbemX/N8MUBaN5b87fipoDskV9aby3L6I
	 nnQiI7tsEK7907Qn1Hib5Ptumyk6n43WjXhVNWvo0qvMdz+wQ0WoJp7oSGik9QjvWcvCw
	 gqevPwLlaFiLxkH0+HtZVUvOl0O6idk9YZuyNL5V1bIORuYUyHW1TE5AI/51eA10HtvHH
	 4adH9BqkS2BPSoGHsIw3F1GeeIaMuL+mabzCMWqID1oQv4mSJj2QwFGQTUKHwjNpv1OmQ
	 Qk0cUaai9/PUaqbHmztc00gPVQ2x9Qo68IrGvGHfD6DoqV+HtK6v8bmDoS9E0n3ONqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpVhbQYe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A6F606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpVhbQYe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DEC1F000C5;
	Wed, 18 Nov 2026 08:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794990026;
	bh=f3WSC8YV/wYkbItG1J9fV7g4fvhgI6esEHTeTKZj6zc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bpVhbQYej8hBsTehTJ+yiYllqomqCu+MGOvQegTAIXtgrEUS9rGdN/cOhirKDcyHL
	 BND2DiqnvJ3S4c0RDFG6qHpnz6MUdeZMvnjAwWpuncTWLyO0uhzS2cmw2kGxhETCdB
	 y8QaUMzoJIVu2c4HNvho7ZzyeGzmer3pd0jCl6v11+kuG3O9j62iYIBmaERxIQhgMn
	 s7e8wW9a0qvLaRySd2ffIjqaeHNC37yqQodvKTebuFfPuyZ+EXxTV+jOGCqbbg0OUW
	 lO88HwB7E5BGBZMMyTNyl0YAU9niHKwKyBcy5fJabWY8nvD5gkz2dXbtbA12UDcoWg
	 TbIyCF0mjiKQA==
Message-ID: <sashiko-outbox-220425@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 2/5] riscv: Detect Smpdis and Sspdis ISA
 extensions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261118081327.10684-9-zhangzhanpeng.jasper@bytedance.com>
References: <20261118081327.10684-7-zhangzhanpeng.jasper@bytedance.com>
 <20261118081327.10684-9-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:20:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Register separate machine and supervisor PDIS extension bits with the
> existing ISA parser. Reuse the DT extension-list and legacy/RHCT parsing
> paths without adding userspace hwprobe bits or inferring S-mode access
> from an M-mode declaration.
>=20
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118081327.1068=
4-7-zhangzhanpeng.jasper@bytedance.com?part=3D2

