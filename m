Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36A3126DF
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247532; cv=none; b=mttJchReDDt/g9SP+WiEhVcymgx6ZTAIsb0usQciQ6vtKAQ4gvs7SE7ME9dtAMRFE4/iK73MPh4IdffesrGlDddd1eC/MLIrbAs0H3vD7vwx/N/4ZU73moTKjCXwbAOg9fR40oiFsRmui+Lr8aiuDbmqjfQtoFzfpxF3lvSrgfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247532; c=relaxed/simple;
	bh=4Iif9XzzUlKzDsHUz8h6GoJAFToim7MG6ScV/8/hFys=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EHzWWylHoRjNtfFf3jUO8xIgHYx7lU8vMirZ8XsfYdE5orQmUqkvJVqKJajJ/LMkaHecT+WTOwYC2mxqfb8ZA2ubwmuQlZbYBa0zqK2l7CU4F+fvI0C0vx1Q2m0NVMi97fZR15ynzkdxYePrnQjoPdoF0YTEbmVWl1YjqNfMWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fizfh36W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fizfh36W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728041F000C4;
	Sat, 17 Oct 2026 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247531;
	bh=4Iif9XzzUlKzDsHUz8h6GoJAFToim7MG6ScV/8/hFys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fizfh36WUoK/taCFK0lT5jZxCTt7cRPFTg04qMCL/gWJNFFHa6G+Ihb1MUas35a6j
	 /vyYMDrwAdvuhv/nnOyvVO21YjY5q2IlB4xf6FGw8oGAWFXXCwkJv49PHcv0avYE7j
	 kB3h7IoQdzbad9eiFKRN2767afwpA7GcPZUFLXW+vLCpqUFUc7XX6HDirQnTIJG/+m
	 nHwtltEedB+CAAFZD2yjkCPyuIPTIJhdV9SlgINADOcT1atURJrKBhxnkSd2m/6dwV
	 yybyzbKjCEQC7M5wD913pHkzlcu5NjgXFig4O53/5MoDhG8fDtMulpO2gZN2fQL9BH
	 NrMBT4dTOqQQw==
Message-ID: <sashiko-outbox-175554@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/7] perf build: Add MINIMAL=1 to build without
 optional features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016143143.3613501-4-sashal@kernel.org>
References: <20261016143143.3613501-1-sashal@kernel.org>
 <20261016143143.3613501-4-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:32:11 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Turning off every optional feature takes a long list of NO_* variables,
> and the list has to follow features as they are added and renamed. The
> one in tests/make for make_minimal has fallen behind: it leaves
> libtraceevent, jevents, slang, AIO, LZMA, zlib, libLLVM and Rust to be
> detected, so a make_minimal build still needs libtraceevent and python.
>=20
> Add MINIMAL=3D1, which turns off every optional feature, the BPF skeletons
> and the shellcheck run. perf then builds, natively or cross, with no
> library beyond the C library and without python, pkg-config, clang or
> rustc, and the result does not depend on what is installed on the build
> machine.
>=20
> A MINIMAL=3D1 build also leaves out the notices that post unwind and
> python support are disabled, which it asked for, and the one about the
> pkg-config search path for cross builds, as pkg-config is not needed
> then.
>=20
> It is handled in Makefile.perf rather than Makefile.config, as
> Makefile.config is included after the pkg-config and shellcheck setup.
>=20
> Use it for make_minimal in tests/make.
>=20
> Suggested-by: Ian Rogers <irogers@google.com>
> Link: https://lore.kernel.org/r/CAP-5=3DfWFY-tpJz2vcBZvurwdZY5gwd8cuTemE9=
q1rtZ0Vi0dng@mail.gmail.com
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016143143.3613=
501-1-sashal@kernel.org?part=3D3

