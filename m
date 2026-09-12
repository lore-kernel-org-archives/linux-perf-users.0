Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8918537A498
	for <linux-perf-users@vger.kernel.org>; Sat, 12 Sep 2026 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789200483; cv=none; b=RFVhWQUqRmaPutJn1MrvOy2xuxdgowlVbPpUl83HSJEnu+IZQ8I/1dYiGRfFhZvseq3pOMp0HTOsA6reSXdIACbUjyD2bYx/Jhd+pL0hpBh6iMS++ngYBhTkz/NqS82ce4B8E2bTWJ2RYY2USpZBim2kMc7C88cK3+wMTCRxhbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789200483; c=relaxed/simple;
	bh=IthVDUVL2jSE2xPsfdGKoPpGQrNoGBu0dYMY8T0IA1M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hkIR4spEe7KOOH/u2638xERqbf+MzHJ0VrGVxTUYZaK/Y8OhKa4WQImCeq1a9mI3y/VWA/MkoIcxtb0lX1ibMbno9moTtmDGpOCZBknFAOjxqOFn8e970vBSOs99EguL2XVXFe8XWHRHGHAuePuvCPRhvOyOeuNRJk391YU4dwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMRf75uF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMRf75uF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2985D1F000FF;
	Sat, 12 Sep 2026 08:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789200482;
	bh=IthVDUVL2jSE2xPsfdGKoPpGQrNoGBu0dYMY8T0IA1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PMRf75uFQbaYqczQtOVFX7djLa6mtLh4JxD9dNRb0rP5Sqd9b6qCCo5HVPMkcpfOI
	 hjAdCusfYj3B0EBlFwNUmkWhLxbKW3gbz5GTjaqvFDC5Lk967AlIx9JX5osg/P1WW/
	 ffEYbygKPrN1lru5wo+c88pwmAloIJxN30VCb/EvcL19ow2XyJHa22Q4/cmMjdOUbd
	 d7EjWdu0O0LfBQfGbkw/X5GiEdhblSsRByQIylDMaUQFhfgp55+s2lmFfPv8qdXmn+
	 6ETK9VfdtOkrJxeC/moyYlmx6nEK81+ihV0fVtzfltkVhXr0OhLw87YsiRV/VISRoV
	 su+55anh+EHIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drivers/perf: apple_m1: Add macOS 27 M2 Event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260912-m2-9f-pmu-name-v1-1-da682557453c@gmail.com>
References: <20260912-m2-9f-pmu-name-v1-1-da682557453c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:08:01 +0000
Message-Id: <20260912080802.2985D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Myria Sarvay <myrialsarvay@gmail.com>
>=20
> This patch adds another known PMU event that can be found under
> /usr/share/kpep on macOS 27 for M2 macs. INST_SIMD_ALU_VEC purports to
> count "Retired non-load/store vector Advanced SIMD instructions", and as
> we already noted, can only be registered on counter 7. Though this event
> only shows up on the M2 kpep records, it can be set on M1 CPUs, and
> records something.
>=20
> Link: https://github.com/0ax1/apmc/blob/9cff99a9df2ae055f1e3065c64f633e38=
bb6beec/counters/m2.md
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-m2-9f-pmu-=
name-v1-1-da682557453c@gmail.com?part=3D1

