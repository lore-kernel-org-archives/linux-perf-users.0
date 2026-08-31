Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1F367B70
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200106; cv=none; b=c1m5d5aH9XpuEJ7Qm2aDoCy0eDvmPfr5mob5c2/GtzB29uQsdMKnjeTkYS71eZ1v8v1VGoTRkFyvlQu1z0+mpyj4FakANJ2yG2nvr0PSjB1kjTZrm2OfCQXMEf7L9VNhwY9b6sfRNGpd8NOlgtikoSZN8/cGwP9VnxedcCH/zOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200106; c=relaxed/simple;
	bh=q7a72YvlIoNrK6aml0gGFXnnn4JvBP/Rhuy96ctb3+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oHxGrNhdiR0INkrk0N1M1485qUTZu62lZoAw7Y2eaZR6fz386wXDRPvJkiEK8DWV1WLHbK8B/KicgnCB+yPb23dN8XDLZv81/aCr0Fw1Yoqxv7noAOTQSdhSMx5HLl23mSm26R6l/fenHlDKtfsoqUDFT3PkVUw7L0ORrlQrXkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjHyR5Wp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjHyR5Wp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F7E1F000E9;
	Mon, 31 Aug 2026 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200104;
	bh=q7a72YvlIoNrK6aml0gGFXnnn4JvBP/Rhuy96ctb3+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CjHyR5WpacWq24q2KqUBmgRAEpL99mpSPyBWOAT/lQHMJUSf31Xt4BD3YhiapKlTN
	 HlNk7Ac1IsGx9x3q9kxjuD7ZjfDt94eQ+1LBnCm7XcR4vUANSjVlmwRtGT7tNteYgX
	 tV2EScVA4l+rmBfiigNaYH6uKffOTOyP30mYeZeIEEsR/iFV08HhbUVq6wrydO/0eD
	 Sa4oLCY9vFN1F5JO/6S2rBWrMRu49NpO0WQrYQpxjeS9+PMBLXxrDYshbHwT+5IaN6
	 tYIyDFTi/do/UhkqpPT3pFqPqK3i8DJmFDVWunt0K/mDmuwnoky0WtCoz+DaE4zCgk
	 Niban72jD67+A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 01/19] uprobes: guard trace cleanup against error
 pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-2-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-2-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:15:04 +0000
Message-Id: <20260831181504.B0F7E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko pointed out the some of the scope cleanups for free_uprobe
> could get an error pointer. Handle this case in free_uprobe
> to prevent a crash.
>=20
> On the other hand the macro doesn't need the guard because
> free_uprobe itself already does the check.
>=20
> Assisted-by: omp:gpt-5.6-luna sashiko
> Signed-off-by: Andi Kleen <ak@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D1

