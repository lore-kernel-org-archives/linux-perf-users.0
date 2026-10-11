Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A002D7DEA
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791762294; cv=none; b=LT5XzfF6XflbzJqpcX4yXXm5FuoJHN6itrG4Q7kq5DZdVoO38gyIm0zqxFWTD9Gkfmrf/UAEus4zaAlyals3twLwmFyGv0pp5covo2rHJHB+VxcvWHNqHY+Pwhf5KXQXtOxYavIXMlAp5dP16oKiQjbcH01TJGwjgnF1k7kLlVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791762294; c=relaxed/simple;
	bh=3zaWR2Q71kXIHjThv58Js5ZdJrPLECBdjI+j18vUp8I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pXfID9EdUD0veodHX3xsRloE4VCKh1qYWokrY0IZmT0hbrZhQHZ7rzQM1NuEPmwEiodN/1WoObFFCf5rRSm5kRXivaC2ziaZCZ0ICBCOSkM+/ZSH5Za7y18DN3mMoHR7UJmlVURCYzSJhaH5v0nckbg7sIcCHmvRyBpLfMFlSEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJaZF615; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJaZF615"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4311F0089B;
	Sun, 11 Oct 2026 23:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791762293;
	bh=3zaWR2Q71kXIHjThv58Js5ZdJrPLECBdjI+j18vUp8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hJaZF615WC4bDZMsKkM5Q2Ut0CUDfuY5w1E2McXO5gjnP6DC/y+Q2PWWZWHaI/Qoi
	 26cRBzxntO/lem390O/Z/FEqphbsiaqz7OthQvXRiUbaEfmNQJuINIx+Hi4IseghG4
	 MlloI6LfpGOp3jHGcEWg7JJ+ASKTAmxW28Z6Imskyu2pFnPqifEqfpz0yLzKIR0xIT
	 G/wW47IKW20RnVRv4QsreUnE/VwMrE/5K2FPYFD5vQKclt63tGq7kOs7Oapzuut6AP
	 mxGdkqQEm0N7OPU/WU0SxNOnIKYOp6QGcO5XFYbCzrCN7P0HudLBKZE3Ej1dhFgPuf
	 r12Lu+j0wxfVg==
Message-ID: <sashiko-outbox-167520@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/6] kbuild: build the tools selected in
 tools/Kconfig as part of "make all"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261011233647.2454648-6-sashal@kernel.org>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-6-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 23:44:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> With CONFIG_TOOLS_BUILD set, make "all" depend on tools_build, so the
> selected tools are built with every kernel build, and allmodconfig and
> allyesconfig builds catch changes that break them.
>=20
> "make vmlinux", "make modules", single target and external module
> builds are unaffected.
>=20
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011233647.2454=
648-1-sashal@kernel.org?part=3D5

