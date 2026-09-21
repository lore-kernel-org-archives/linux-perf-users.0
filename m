Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F11848E0E7
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989829; cv=none; b=So303ad2PAZ2yHl/LiOadFhP20dzTj/a/xfJAPleetTsCuebhpXidUCl/gVfw0vVG9ZbgmMJcQKUzoNNjmN5orw2CM+OdkNI0gQthvbj0vBuo0HUwivJApM/Yx7X2O1nWvmvt/wCA9iwc0HvylES4Du3VhzAuK/SPjQQhBf4/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989829; c=relaxed/simple;
	bh=yxuFX10RnLvSuKU6H2ZQPpiFQZ3/n93vOyQ2JaihOyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UC5+KSLB3+VpreipWAJ1P3Z2QxDTaF4N6/WbAGDng5sNb2BM4dm/9T2bJhG1o1euSGrcZrflyqpwwKThfWv0fGj6Gx26DOdodWvhQuQGDTu+pEMYfu3A6HmDs6nPxhffyQeiJjEujw5IsmBNu2FHFNrQz+p1+7lShtOiOSN3DFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrx8MW3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrx8MW3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E86B1F000FF;
	Mon, 21 Sep 2026 11:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789989826;
	bh=yxuFX10RnLvSuKU6H2ZQPpiFQZ3/n93vOyQ2JaihOyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nrx8MW3okKH8z835zgd6nWULFBie60+OKrbT3lD+a98UeUNwxqmCZn0lQ3U1OVgKd
	 orJ2xV81o1Crb5vyKXMdBsJkPkMvWGU+zXAn39xYs1Xl4LiKzSychcXu/IaBC3yfBZ
	 r2zrO/dbIGl1YHxeQFCDul9Z0C99nCbJNx3x1tVfrKaePZWKIUmSU4d4M2Sx8xEhNi
	 CkmnKrKbMA9r9E9XV9wb4uVJFMBK14CSVC0WOswLLl2tP4ZcjcEVWIO0KerSDCpA1H
	 T6SsubdcTomQrZMzH4JFtGdMbMoxnHh+cPdzPQ2wfGe1AcndUcEKJ/FM2NgcCUix7U
	 jouqW+zSGNYDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 RESEND 1/9] riscv: add SBI SSE extension definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <990ca6db19bc476f7533f97d48e2030b509633aa.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
References: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
 <990ca6db19bc476f7533f97d48e2030b509633aa.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:23:45 +0000
Message-Id: <20260921112346.3E86B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>=20
> Add definitions for the SBI Supervisor Software Events extension [1].
> This extension enables the SBI to inject events into supervisor software
> much like ARM SDEI.
>=20
> [1] https://lists.riscv.org/g/tech-prs/message/515
>=20
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> Co-developed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789974241.gi=
t.zhangzhanpeng.jasper@bytedance.com?part=3D1

