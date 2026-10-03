Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F3B39CD1B;
	Sat,  3 Oct 2026 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050182; cv=none; b=iyA2h4VoT3lVzwQ2ZBCDaXIdr4phrBLMD9IlEq9bZGUIgnc3V1qeTSBVxRYlY65a0Lla+AYbF0hTcZfVQuW5+ZFOQqla/JUDT0xilaVi48grqLQL7/QmbadOOBEPVubGNsbl1eLzznUEeGbN2RPFpn4g/aK1O+zHoP3AJIj9hO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050182; c=relaxed/simple;
	bh=PWunZLQrfUC0hOIxz3RkA5arq1lAQFLbO4M42cTiTyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iMIGEZogqZWkMICgVT5cPWjKm0I6sDePkfb7Qrji8k5bNQS1aydmeoQO72mYX8g4YYWnOSLVxQvpPyx9h4kNQXYmb6Idr5yp216YXd2Wv4HGbo+GOfNRpBepO76hx9Gb+JtJQMNPYMCOnsGkvQT6h75fmbTpbHJW3GVe/sImGTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agNxaDUa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agNxaDUa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE981F0089B;
	Sat,  3 Oct 2026 17:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050181;
	bh=PWunZLQrfUC0hOIxz3RkA5arq1lAQFLbO4M42cTiTyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=agNxaDUaT9/gDxM6aY32JIjmTBkmAj153o4Q1B+7XV8E4L3yRO2jhva7Y4FTr4XlG
	 qVg7iond1oODwS5mTVM7j6ytVAOdblqrYeFa70v4HR7vrC5bTAjPdPlBIC30LX0AR5
	 BE0BaDaD0EFNvwnTpo7RnsaYoNXtGSQEJ+tgpiusnulbfKuxU/dULSCCwBCC++GpNk
	 jtjVgrF4SWdq0Z3JLJtcJI4gRGm5NO4lwzgLQSVXIoJq11x+t+ay232uZ5+IqM7i7A
	 ZlSnWSkL2Rnzmyg4HAJstCJBAhxCXTdGmTNz5FvxGsQKioAZ6arK/+ydBAI6NbFCbM
	 M4rlcjRXbHCcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: track the perf mlock gift separately
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@kernel.org>
References: <20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:20 +0000
Message-Id: <20261003175620.CAE981F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The locked_vm field in struct user_struct was originally introduced by
> commit 789f90fcf6b0 ("perf_counter: per user mlock gift") to provide an
> mlock-like budget for perf measured against mm->pinned_vm (since 2011).
>=20
> perf grants each user a 'gift' of perf_event_mlock_kb * online CPUs of
> buffer pages which is charged to user->locked_vm without any RLIMIT_MEMLO=
CK
> check.
>=20
> Only pages beyond the gift are checked against RLIMIT_MEMLOCK, per-mm, via
> mm->pinned_vm, which makes it different from the standard mlock() check,
> which is per-mm and made against RLIMIT_MEMLOCK.
>=20
> However, since this was introduced, a number of other components have
> utilised this field where a shared resource needed to be limited against
> RLIMIT_MEMLOCK.
> [ ... ]
> Fixes: 97d34aa65c29 ("mm/secretmem: properly account locked pages")
> Reported-by: Ameer Hamza <ameer.hamza@truenas.com>
> Closes: https://lore.kernel.org/20261002175651.811343-1-ameer.hamza@truen=
as.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-perf-locke=
d-vm-fix-v1-1-d214dcaf0d76@kernel.org?part=3D1

