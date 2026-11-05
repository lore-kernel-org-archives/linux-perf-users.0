Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880327;
	b=fLfBar99suub5zNVWPvv1EYWH7m2LGpRadTqVRF+6SsArgs0WIiDH2alc3U7sBE0ZQ2U
	 kKQuaIHoNEt7eov/j79oVyBR1ivXvPjOPlRPDWZOY6OCBEhMPQD+KsOd5b52kUJ5a/rwR
	 pXsU6RM7eFFZjl8yXm2TPhW1944VMcpgeylDrTWXw1lvhjcqdUnDfenenOIxZ0/Jjplmp
	 5I3o/BIQyZ9UjragEMWZzyr1mmrqvUFfGvPnj7spGpRqU7srpfIxohHkVhdrzZDL0zC4L
	 v0k/LNqejEmfqvkC46J1xZ2WPVWpxkOPmqzh8uPlcS+vwYgFwg/7dt7Luqkpabc8TxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880327;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ks9e04/lp1seZkucDVDge5jN114FRBwRhY65tfBPHmg=;
	b=W5cFHvq8JYPBlsYJ2CeOfrFysNQglIiNqkoAGVdAN5kV0K9fmDWOhsqhOkn4FtYLY8Z5
	 IfGSR83X8OICiAOlH/3PCMpS5ST9tZSnxCmaxjcm1KPWDr4TtGy8dQ3sCHpxrEWp+42Or
	 tggHVtbvq8DBc1t1VziHWtQizmIseg4006tMljPVsWTvUKcNIrKbDwXLoiouYXaU0Qfh/
	 mzrMbKpNDnVaxd90P/u/iU612uh/eVVdFR+EzNQQW8Bn0fcegIaPctdopVKKIujFy+BvL
	 COdAkd4ON5M/ujbJn0XfoOUn5qUwl0x4rxaLXou7TVv8cDMOnHd+JSVv3HmLm0agJoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWq55Ovy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8B4606A326
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWq55Ovy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42831F000C1;
	Thu,  5 Nov 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793880326;
	bh=ks9e04/lp1seZkucDVDge5jN114FRBwRhY65tfBPHmg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mWq55OvyvAFIaXICK25sqSOZW98LnemDekSQANYy1mVxjAspPY+7hjBN5xNt5BFvR
	 aQ24iAvCK7vUxigFDr/afrSQpFjs4xrE/eTkD8XEmjZxE4KYlWgGy1ZKeHaBNvAkzf
	 2cR2sNeIgNppkoVl8x91HiFMK6aeYfrbrxDhg/6yJWYkqX95TbyDiviL/e/dOXeBpN
	 v7JxNXhCXiI1SY8urwZza8A+YS5mWNZa+zHlvPnb/zlCvpRgWSY1dKAfE8HLfbR2/Y
	 XpP1utDufM9BiI39QxveT4uAvF2v18E3BC4kEx4iEkC2tnzFMSYlUWWCc/HFZyltq+
	 +jb67FTBDErKw==
Message-ID: <sashiko-outbox-198989@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/19] perf cs-etm: Warn for invalid timestamp option
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-2-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-2-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 12:05:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Instead of silently returning an error, print a useful warning.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D2

