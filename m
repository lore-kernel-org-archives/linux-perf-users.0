Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9228F393DE2
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622841; cv=none; b=jmWHGOPhe/lpYX6KS/fblbm0dmQgt9xP1w6nWJaU8NPuCi96SUGwQUQe9BjM0TkxiqmtGz+obyKueZ5Of78wSrKxKI5+lAIiaokQqFDeR0y0jAb7tmsh/aDtD9TN+JaJsMQb7P+JEPUtPvuG4+L3w/oV7FXRkAE1uzafDeP3aTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622841; c=relaxed/simple;
	bh=/54cm+7VYGnHTdykjijK6zFBj/UMz29YepTyK/xZQVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PBHWZbpNu5JGBFfPRan0yRC486EgLBWpPS9LHg9kAjV+bX/pchLuQKZK99cam8hy4l643JWp9b44LKV+rOcmIU0fX/amH5+xtEsC4FPpPHuLbzCzrpgmPfLKSw9jS2Zt5r7pUlODK8gY+P6B4op5SRCrhkbbBrsj//m0pgtvziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPynOWtc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPynOWtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562E9C2BCF6;
	Tue, 12 May 2026 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778622841;
	bh=/54cm+7VYGnHTdykjijK6zFBj/UMz29YepTyK/xZQVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rPynOWtcb01+d/eFkfpnmffPvDsPlr84AwBRbIBgNufWgQiU1jgl8ejBeQqya2eNC
	 XGcSz9B3rAedjLzSmfJOXWB6nYGMizdQ9EWp5Zu4/N97ICSRbgN2/DeWnAQ1Pb2RH5
	 2f8EaBVnLVMHtDF2SZR6JDFiuHP70ZHbtl4NKyG+DQIRgxKjeXCRKKUBUkNTpHdbeI
	 kYKOLs1kNKmS/EBONSSWKuo2EEJnTGVGPTW7N2/w2dahzuM/ssLCxRGK6Xq2TN83RV
	 E+V65XPuN6OpV6ZGuTNhDTcK9YlA/uLnda37KxVAo4wHB3yCM/QriwZF2z8nIfZckE
	 sA8/9t0u5ZebQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] perf build: Add make check-headers target
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510202346.49853-6-namhyung@kernel.org>
References: <20260510202346.49853-6-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 21:54:00 +0000
Message-Id: <20260512215401.562E9C2BCF6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Stale documentation in tools/include/uapi/README regarding the chec=
k-headers.sh mechanism.
--

commit a1e286351cec4f0692528127c5b9fe5ec64aafc6
Author: Namhyung Kim <namhyung@kernel.org>

perf build: Add make check-headers target

This commit removes the check-headers.sh script from the default perf
build process to reduce noise. It instead introduces a separate manual
check-headers make target that can be run occasionally.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index cee19c923c060..585637fc934fe 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -285,7 +285,6 @@ goals :=3D $(filter-out all sub-make, $(MAKECMDGOALS))
>  $(goals) all: sub-make
> =20
>  sub-make: fixdep
> -	@./check-headers.sh

This isn't a bug, but does this change leave the documentation in
tools/include/uapi/README out of date?

The README currently states that check-headers.sh is "part of the tools/
build process" and describes a "software-enforced copy-on-write
mechanism... driven by non-fatal warnings on the tooling side build".

Since the script is now a manual make target rather than running
automatically during the default build, should the documentation be updated
to reflect this change?

>  	$(Q)$(MAKE) FIXDEP_BUILT=3D1 -f Makefile.perf $(goals)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510202346.4985=
3-1-namhyung@kernel.org?part=3D5
