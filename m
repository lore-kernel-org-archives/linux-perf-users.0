Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23330DECC
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404433; cv=none; b=rUVgBplFs5nIgdlS48Pd7thRQsNUojnHFPyBqlL/R1jp1ytBFIig6ruL94JaXbmdhVljnOQ3C/fMyxDDbtodK6XGyl2pN2Np7GDs92zKHcHc6ahLSWuyT8+6YSNqS/vmZPfDcXQi+Q2R0NEqvWeykAumX2x3uAuvgP96wOGOG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404433; c=relaxed/simple;
	bh=PyDVE/xQxFWEmcECK/Di0D2syUQcewVL7i/1lB2bHOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rIhL9IGfP0k/z10X2vV/M/vvKvT8ifMJoFhjlPXgLb7GRGoPedlEhfZkCOH36UpoziBzVd+BKaOBxdA4zxe8ydY+KeT/FVRyKuA1Gl1dzzvXbzknZMWdXyIlm4+ovvVtKf0fiqmCoSVkxFMWPL4f88tqQzyyjco2tR6/JnWvG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a08qYxyL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a08qYxyL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADA51F000FF;
	Sat, 26 Sep 2026 06:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404432;
	bh=PyDVE/xQxFWEmcECK/Di0D2syUQcewVL7i/1lB2bHOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a08qYxyLNPUMDnQpgLheTZMUnqk70xDNChH9AVXOglywBdwclIggfr5/O64ZF5Ih+
	 DXTGyG8G07W24X8TOtnHvNcEpUmxdcdGi1AOn+IoDg/4mMFMVywp4oDxeyLsiVvKox
	 Quy20p7kObOIh9ZlkAEUEAlIy7v7UYAHuAS+12IqgY0a6DMgXD/rWQroThj9S5F5/C
	 cK1Iy714ESfOMwe/Upc7ZxXExQ24HjmaXpKfMRyRzj3LDS43oCcOchNSoWj/yy1BMz
	 R7YybwDqUhapFzxeHH2E6t/UyDx4dXOS82EzzqYC5Ltwk15aZrWUznzhGkpSIM87o2
	 dFNqKVcb5eypA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/49] perf build: Make pylint build test opt-out
 (NO_PYLINT=1)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-15-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:33:51 +0000
Message-Id: <20260926063351.CADA51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Commit 8a54784e708b ("perf build: Add pylint build tests") added a
> compile-time pylint check for Python files in tools/perf, but left it
> opt-in via PYLINT=3D1.
>=20
> Now that pylint issues across tools/perf/python, tools/perf/pmu-events,
> and tools/perf/tests/shell/lib have been cleaned up, enable the pylint
> check by default when pylint is installed on the system, with an opt-out
> via NO_PYLINT=3D1 (matching NO_SHELLCHECK=3D1, NO_MYPY=3D1, and other perf
> build feature flags).
>=20
> Configure PYTHONPATH in Makefile.perf so pylint resolves perf.pyi type
> stubs and pmu-events modules, enable error and warning categories
> (--disable=3Dall --enable=3DE,W --disable=3DW0123,W0311,W0511,W0603,W0622=
,W0718
> --ignored-modules=3Dtextual,setproctitle) appropriate for perf's standalo=
ne
> CLI and test scripts, and require pylint >=3D 2.16.0 (skipping with a
> warning if an older version is installed).
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D14

