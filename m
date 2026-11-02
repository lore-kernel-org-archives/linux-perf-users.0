Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622973;
	b=bigSXtT48DiqtqmIsK1hulfphH6H5RJ5OdYQckZHmh7l3pPz156MdJXYrZmtzxC8NEBF
	 wm8UqViAgCPWHbFiqyitsf3Avj2+klVuz1pL+JrLlFmYfqtazXOHbmu5INPZJDoeITcrz
	 TUNMbsA3lA8FJQ5ZqEf/jYo8RZDzEpetu9nMs5E923cdUcD17jBMMVzzgDMshU5JcU2nr
	 uKViVwDFGatDw77IeWPxzc+qF8bi4ad4ROqPrjzeMY281USBCSNtfspd5jMzJDCjKUCkM
	 CIudia6hKFhITbeh+3XiJDFgu4FYDqjcT+g+6JTBPLKzQ7SFFKpUBxlDPbZBTksbMXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622973;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hh/klgC5RX4cPXEIDGrkpiswtJS9Mb9CARSK6+zTuOI=;
	b=Ohnh6aFRl0PgUUm/uPaRA7D2tfsq6RxWtV8ZMvioi/QWLH2CQEtrsJWh/cRcv5h91jKy
	 /fuzXE42wQXEjWJZMGU9m1C+D142enflrX7cbNHs+7ZtE5lA3XlGUhCBhH0G/xzLl48s4
	 F7PqDyj40RZNuOj4UAXfFK542NgcCXhXZPOEXI2bbaoI8ubvKBSQ3CCLXEra2QyVFqofs
	 vqJaNS5B+ieI8Nst62eVm/1dKV3qIavo1nKd/4J0UsJZj53niLVbdthNpWH+0uE0QQ433
	 8VnXXNJmp3gFm7f+S7hGawSa3GFp2L1Sbqgn2nRjTcNbGUmBzUyCaioKAM49bU3fp8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJ61BAXH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BDD606A32C
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LJ61BAXH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794081F00A1B;
	Mon,  2 Nov 2026 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622972;
	bh=hh/klgC5RX4cPXEIDGrkpiswtJS9Mb9CARSK6+zTuOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LJ61BAXH/N2KKtCu8GzDLF1sATQnW0eoa6MxRcknx4kmIwe2AE0A2xHI01uNaxz6t
	 VyXoa89qjaq7scJpLp/nCgxm+CYZEm1axT0LbgM57XucjeWVRDOypLo7oRj2RCcuUj
	 QXEV5HaXcxUBWbQB+Ah9YlMm9bvBeNiSEbsOUUdECEQqnmO/8m+mA0REdtGHP/fEe6
	 WcOF8CBSAm4v6YxpZ5UBGHDHdjfvkOjB/5xNdBMKkeGXuVMZYm4XeXPYVVh7qwPugO
	 fBIJtes3EzQur+OXtODcROF3nB+8+gagBhRIO5YFTaqGdQ/EfKf+JP4dECMxENoEOt
	 YdMK12/8dPs5w==
Message-ID: <sashiko-outbox-193426@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/18] perf cs-etm: Fix nVHE per-thread decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-1-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-1-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:36:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> pid_fmt is unset in per-thread mode because we don't need PIDs, so we
> can't use it as a hint to determine which EL the host is running at.
> That results in falling though to the next part where EL1 is treated as
> guest, which is wrong for nVHE.
>=20
> Fix it by only returning a guest machine when run from perf kvm where a
> guest image would be provided, which matches existing behavior in other
> parts of Perf. The exception is when pid_fmt shows that the host is
> running at EL2 (VHE). Then EL1 is always a guest, so keep using the guest
> machine rather than decoding guest trace with the host kernel maps.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D1

