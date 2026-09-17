Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC5B340283
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622267; cv=none; b=Z5yhTMo57TTvxsbRWfj7IVflveQWS+C2BruHSC5lC0cHGGdbdjU+BWQpoGhMgEDuKIGPHU52nYIpQorbZQAabaMaBx/pjldkz1yw2ViYTyWCWAeItzQrjGSl1LPPa3ZJRHFe+S1nmbYCT/60Icqap55OOZCGmpKqCwQ5vwOe5pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622267; c=relaxed/simple;
	bh=rZ0XHU7GuPXxP9+JuBQuudbofDDPgYCkQvdSHSJM5sg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ye/PXLCN/IUVJej5MV7wHMsF+J9mSfbTOu9OFRPNhrQMK6GdRnbeFWzaJoTa8Tu8V+avZ20UW4H6V5FV+Gt8rvmy9+7BzLZCWKcBr6R3n4yaY1H6BEbYgSKqxq2ISfyp4uuDo+prNK9qygd4IkxiRB0uSxfGCHpOZrm7rhcHkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJoeGkFk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJoeGkFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62921F000FF;
	Thu, 17 Sep 2026 05:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789622266;
	bh=rZ0XHU7GuPXxP9+JuBQuudbofDDPgYCkQvdSHSJM5sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bJoeGkFkS5ltZUCq76BMdhfpAdoZJTe5iOm/UnsXuhzNvIVMlc40B6EGzIei3ZTrq
	 5BTt66erWsgE/f0cvmmviN72/YLIlyOyLOMo3ApZLVS3XOVJEKrvjmVv0UctfA1pA6
	 AN3Lwe+l40TJkBi2G13MpdzQm+Ug4F+gTT0MN0dXOl1Otb0A+ECyU3lbVjRsHTwMAw
	 a55gOAXcgqRIIPRuNdLjIxmLJqmlZG1UryvTFqBd1kOYQ54CcRAr7rFlRxLnv9m/Tr
	 KmVaH3kh8YCIe1YwiM01li70x65ESkECd+k0NlsFuucQVfzbMCXIg9C+ar3PLcll0R
	 D1GuSVPBgQ1qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] perf test: Isolate test suite from user
 .perfconfig natively
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917050708.704702-10-irogers@google.com>
References: <20260916234652.439778-1-irogers@google.com>
 <20260917050708.704702-1-irogers@google.com>
 <20260917050708.704702-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:17:46 +0000
Message-Id: <20260917051746.A62921F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Running 'perf test' should not inherit the user's ~/.perfconfig
> environment as customizing core properties (like core.hybrid-merge)
> will trivially break stdout matching checks across the shell suite.
>=20
> Explicitly set PERF_CONFIG to /dev/null inside cmd_test to globally
> sandbox the environment for the entire test workflow. Test specific
> config, like annotate.objdump, is read before the sandboxing so that
> 'perf test' still honors it.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917050708.7047=
02-1-irogers@google.com?part=3D9

