Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABDA1DB356
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 00:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786668383; cv=none; b=Nn4eE25Vw0cojJntKpqKNIUsthhz4caI45UM6m+wAH4IIGi+CNfT33+BcShvriU4qGufAieAagZ1qDNQ0NuwV28GFOTIre2v1WheQmYZ7mbWA+ZZZB6vjaFLAM7LOc+0D7OzCEoCzKGJ5yy+KsqOID88zmi1C9/ND4UJuW4irFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786668383; c=relaxed/simple;
	bh=6mGnSKezVdiu0mwCzHZAuSGNTjhjs8m8u7iLpZSTEX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UHh6Rwgl43C5cDX4tvsfVJxnylCtUaPv8H2uyG8rjpIZBAVrbfBo67YmFq7eMA4uKAAHf1oV8W7QcB0zVl/fT9vCKQFr5yBAYPG0SvsoLRuIan6UzUcyYzKU2GCRELxDZE7WGwUfp4vOv4qeeisaKs1Usz4UY+v2zdRtm9+uLFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arhaNjKO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arhaNjKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A101F000E9;
	Fri, 14 Aug 2026 00:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786668382;
	bh=6mGnSKezVdiu0mwCzHZAuSGNTjhjs8m8u7iLpZSTEX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=arhaNjKOeanuS3x2BWLPoNVZa67T+GGNOP6BNJ4MXoz3A88aifSNDYtp56nyzkWKw
	 oRibIDl0w2Pz2RM1Zn0LpVMONAEnG0le+iviWfA0WQeATaQ4T/HUrfmbKPiYjpruDt
	 yJAeNvmsIA9lV40mISge4GndtycNCm97iE9VC7cTK757mryPWBuPaMih4zDqDOf6Cn
	 j6jPn338UZ3kLMj4SeChB1zs4rJoVs1s/9aihZG0ROjM8/tAZJI8Q+sIhkKwIf99qn
	 G8t7rdbnW0T9o7M1qSOIp5D2zMWytk0fHGF/vIjeUXdl4i4hHdQoeBBVFWUrsicykn
	 EQFRZT+8nn7qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 11/33] perf report: Directly use sample->evsel to
 avoid computing from sample->id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413041143.1736055-12-irogers@google.com>
References: <20260413041143.1736055-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:46:15 +0000
Message-Id: <20260814004622.51A101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In count_lost_samples_events try to avoid searching for the evsel for
> the sample, just use the variable within the sample.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413041143.1736=
055-1-irogers@google.com?part=3D11

