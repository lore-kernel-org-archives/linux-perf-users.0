Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622723;
	b=ii1VkoXrldTurt9x66jww1vyKw2i8RXgr251ITctBaPRSJ6gYEQtSqnEo1FWD4L4XBWb
	 GJM8vl9AzNFXDNd3HwDdkLZZSwaqGaSXP3UyWw6+up5HTylp5RyAhEOOAQEkAHjZl6C3I
	 9285mgqss08VVWUFIDn0LPVeYtY9f9quN0HtgsOzIMBs5MOKXp41y/oQ3rYdzW69XLFBr
	 jtFOY7TykVN4KAmMS5mz51/55IVVC8ccm47AN+aMjOa21fO7uSQhZDqvzUdXWl7HEnw9N
	 Gq6ubklO45hB08CKNuE/NHbOWO+DExcq9dBmDqZ0LS8ylgZk3wXj9Yhdf58N6EeDOoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622723;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i5t98OjuTg4WGYa4sircxq8cmkTdAu3Y4PHnBn4LdYA=;
	b=5hILc1+GzjGpOqwgngvIvPCJLGr33vzm4d/QApjL8X1xEw8QuGna7L1OE3+AiLtgjOQ8
	 Zdtu6QRw/RhavoHybDUV3nSUCud9Wt+4HXJUW6+npmqQ94pIprUIX6Gj5R+ZIOPsXSud+
	 1UnxZpg8g66Cn4Wgh5GgOo4yOCQPShMvUm3Q3cFXccsDpyNhsUgy+DJWy8l2gt1FJcDLu
	 A98WDykmZ0lEONx2x3vyfCtkznnUw1P4ozN9J0D0DnwLt5zMu6cwh1LAE+QeKbkrhPwyq
	 q28icljaPQ8X3Rrne6vWgjWauAoppTuk3e6RCiJV1Rb8y4L6hwdVMfTLMKDF1zCg6PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e07MDvfR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E0606A324
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e07MDvfR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7961F00A16;
	Mon,  2 Nov 2026 12:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622722;
	bh=i5t98OjuTg4WGYa4sircxq8cmkTdAu3Y4PHnBn4LdYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e07MDvfRjtvKVPYF104jmU7ZOMuK1McaFiLmcWsDA4Hi7FTrlIfhFhT/Rb0Xz9SXg
	 gEblCD9qDsqyH1sKYo/X4MQiVK8Huj3kgzR9ePc+DxX4fGJqSo41L/vkZBMjNISYb3
	 p2IJiuLeRfBdcUcZn5KfCMRxOMaVVcVjsM/dzHhtESSQUNdRcAB3FI9zU+cy8KHCDx
	 0VMxobYai/CuaXjPqf5fX/clyWh8PL2/5ztssNSCOggWWWk/RTkjF8DpBUXJA7q7al
	 VBHT1UFwUmnDP2HhgQevTNzy3KYZSB5t+N39FfCfoq0pOVK58k1ISwmxuUwrghAYVc
	 oxAkYDP8eGFvw==
Message-ID: <sashiko-outbox-193415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/18] perf cs-etm: Queue partial AUX records
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-13-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-13-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:32:02 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In snapshot mode AUX records may straddle the boundary of multiple trace
> buffers. Currently we only queue AUX records whose range is contained
> wholly within a single buffer.
>=20
> Fix it by queuing any partial AUX range that overlaps any buffer.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D13

