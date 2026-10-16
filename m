Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBE83C277C
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185901; cv=none; b=sTMfB91QDGYt0EnGuNOE7SpGhmCudGHzaHRx+3G0hYpXQhJjGm5TudnxIf6QevArCaugnnDR8HKWYIDrufjo1HPDxPwY/0m+hvc/uj9k0a2Lhjr4CaoPSkDbfMN263cV6OdhI703hNdc1Bfscyb/VNUyEIriLzNrZm5O2JN6xgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185901; c=relaxed/simple;
	bh=ekYkLHXnLGLyZo442hzUABxSjb4oE8+p8rckcobseK0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Sx15pzM4s96tQl4qyAMx8lT/k4/NiEwMnh9UFRcTOumlUg6uV41ULAuy7Y/Oy5jLGMOcjjd9BL+BowuAfot73KoKXQ2opbtGa6aYRgfvIjFvgKyGJxLpsnE0g1QtkO0UiJoJmADxF3DVKUU1xw6d3BNPeD6KSOGb2J6lYym9zGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOSma2P1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOSma2P1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5041F000C4;
	Fri, 16 Oct 2026 21:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185900;
	bh=OW+YVfWKuyHI3bf3r+acnRE3gCp9xy7nLbrfekCEpUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IOSma2P1e9BnWB7uBiVm31R832+ifTXZGVFtVVwQTV97r2spvgAFE5eWpVMan6UZi
	 0eajOhcPineppkLNN/h3qgC6s9l3zjKXqMRaBGDMoqjt6i6PwAcXy/FKdhp7iONAZI
	 nJnrRBuGm82bdPKoxA5xvNbcuy3scEDOhTxO0wd3ThcbsgNtNSh8DnRKEobe80+zVh
	 /9dK3v7egVxfhevq38thVONgbJSltJqvSDyJsYL3GHZ+R5IZ+zQ2VjnxaDuIZn+g6Q
	 NZKlaTgGMXfWbtdYGwzsDwY/b0rnAevoU/jOuYuwfD8vpF2jD84R8mDfGFAVCdHx1+
	 7BTp4NmyOPa/Q==
Message-ID: <sashiko-outbox-174962@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/21] perf test attr: Allow tests to require a core
 PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-4-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:24:59 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> On machines without a usable core PMU, like an aarch64 box with no DT
> node for the ARM PMU, the expectations that pin the legacy hardware
> encoding can't be checked: without a core PMU at all 'cycles' doesn't
> even resolve, and with one that can't be opened 'perf record' takes the
> software fallback and records attributes they can never match:
>=20
>   expected type=3D0, got 1
>   expected config=3D0, got 1
>   FAILED '.../attr/test-record-group-sampling1' - match failure
>=20
> And since attr.py stops at the first failure, every expectation that
> would come after that one ends up not being run at all.
>=20
> [ ... ]
> They are marked here, before the commit that has the group tests ask for
> the legacy encodings, so the requisite comes with that dependency.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D3

