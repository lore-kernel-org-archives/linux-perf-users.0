Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622264;
	b=Yv0U9YvnsemH9hXkNHQapbRc0dLtIDX3VgNf7X55+S/Wta6sJW6c3fUr6N37gfgJdrNk
	 aRsftReSq3W2/bLbmDEsAMIAFvmAsJEAbhYnHn0U12TM6OD9EhgEUtiD/Au01LnZEcGZv
	 tcVLGHUa+KLe4jRFKX2WeNa784HOTrlG0ytqldHKdPRdQh2FB9xBUWm2SkGU+ammqKwTw
	 YY2v+SbCdW8i6KuhbimNlv8R6/sNEmhcUrFCJLBkMd2NkpRyejTNyWZWjRLThR2dtZ2wz
	 1QcojBew1wjRqrkGCQXqgsZerrbr7uSox4knSZ2IWiCa2XYrVBQfxhQxqk3rT8PAGuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622264;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dSpmQoHDJdoIwn3MLm8xckrn/BtVyb3iwgv4fK7P60A=;
	b=TLULbz9xKXwd/I7hCFJ2oyiLKIfwMLpC3vBWB7mYW2yqnXungIKS8HYYoFlPAARjj4mp
	 lDx5gcJFXk7vmD+iJQUFnfxs2NAGJzlOANfnFpm3fvOQq73oO/OvDFEL93n4LTNM8WIyM
	 UShHWCX18gOH40Tk2dxajfumDeCeWZJE1fStJrQ/HLbz68z4cEyACk6GxfGN9uPBVJa/3
	 PZjy2AyrvGzKltvjGvnjXyDBo5Mmr621j+4fvJoA58zcyHjN3LZN1L1bPQzWEuwAJlxN0
	 MgVHM97F4ZtebTYZJPqenT/9n2N1np0t+TiebL6ist314/z1IGe41T4/tDfK/rd+/mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yk1p8N9+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BD8606AA2A
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yk1p8N9+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFD81F00A17;
	Mon,  2 Nov 2026 12:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622264;
	bh=dSpmQoHDJdoIwn3MLm8xckrn/BtVyb3iwgv4fK7P60A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yk1p8N9+njOYsRXaBh+kNZ+VkabktZO6FgXcA0ujXZUAgPvxkF2Q2KzFcwYVwgmCS
	 7N3Gs7no8CAw+SSjTyNH/ePXpxjbLK6NyeVQVvNgO0jsCIJdXeEX2z1mboiykuLc80
	 QuEj6PMxgtNm2My4m5Dte9JefUyuMBUuszkBDK6/MoI3vTD3ZV+ecyLPJxKW+Gj9aC
	 5sF90GUc2nAeci8EZ/srR0JErfg++9giHx1PG44exWAJWy78U83DBOg3YTLbmQgEpe
	 XRp8vGSHdkV1lNV8748ZKf8U5BoILustONQSdtSur79mOZJ4wLMVZbdHv844vuw910
	 0GEYp9+RJMeRg==
Message-ID: <sashiko-outbox-193397@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/18] perf cs-etm: Increase default timestamp
 generation period
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-9-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-9-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:24:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The original purpose of timestamps in per-CPU mode was to roughly emit
> samples in the order they occurred across multiple CPUs, rather than
> emit all the trace from CPU 1 followed by all from CPU 2 etc.
> Previously there was no way to change the interval from the minimum of 1
> cycle, but custom intervals are now supported by the driver.
>=20
> Drastically reduce the number of timestamps emitted by increasing the
> interval, which is more than enough to interleave sample generation.
> This reduces the size of the trace generated.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D9

