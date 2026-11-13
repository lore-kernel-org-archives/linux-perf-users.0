Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599708;
	b=uqIlPfai4t4f9pbUby+2GC4PxeQiO6LPf7WMY704S/JnMC6Ajs5qYF1q5Xm9qjW+1nkk
	 Vs+TJP/JETiWk8L6RTzlS0wXJXAxKiTSgsKXL0jC6rgGu1Ve8byT4PC6yas6CW7fI693J
	 E7O27L2GTPPKA8gMBtae/Ki8M8hdSDl+V9/3WF/ra72uh8EzFiTLu0m3/UVC5x628HOWX
	 OQAytm3s7Vx+t1bbvgeqSdPvVZhvOaH0HnKqHpZA4wFl4wq/04PahP93ExdynKYSPXRA6
	 LEbfUHO69wvHMLRbzCNwUUndAdsXHhsJu39Wp0vfIBUPIU5UneouBTPdw+50MdshpYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599708;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2Q+U0OS3YmZLdLoRNWVXiEYLBkuiGg1W/u8Nx2XwsgY=;
	b=e7dMOKN+0NKQrfV7Z1DLC0+Wv00w2NUBM2Rhsin8DbNGxlFsA/zWSQsLaktu1Nt5Oa+5
	 kgJOp99aknrW8qgpMizvxCtul7vaHzfMNoPZi1JOMyYcPHPxaxe9xUflcmqXB8Y7nXSGv
	 prL/izOX+9Cw9jUtbS0G44HXCMeSZpKnpDBtESY3WxvO+dZGmampw+AG7ZlXuXgYplx2W
	 q7cApTGPEjG8e3GVRps5HKjKmvWU1XdNb2JssHdbTmfZV7nBPFY5+M3dS8vA3WOaQnpcF
	 leTIPfTS3Wu/I1rtL/iUuxMBsVTPFsvTZ0lmEObYc9XN35gYFPlnI7C6jhZx/x7wDbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mbDXCJJ7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A8D606BCF6;
	Fri, 13 Nov 2026 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mbDXCJJ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E591F000CE;
	Fri, 13 Nov 2026 19:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599708;
	bh=2Q+U0OS3YmZLdLoRNWVXiEYLBkuiGg1W/u8Nx2XwsgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mbDXCJJ7vtsGUGeUXnwLwotkqd+/VQCnQY11hTC06Er0l2SUn+L99gaO1zNbVjBUa
	 16BQr5hwQhXTnxa6HQvx5uo1JHsIZzZyl2AAcLc9s4uun1ZA0kx+hedkG26nOiKKhV
	 e4b4AGdSzNVrtJ3ih0fBBHJJYT4H5EiSrozm+8r3BdIESbySce2fltWnuGz8/uVzxv
	 a/ytAlD3mxl7sAxhS7QnqKgalvJaChMvia4kvXKfi8MaABuEE88WSGUAYpDEcGqrpR
	 iK5rhCs6Sgeahnke5GKyOGeUR+vsPIEG9nDGddHnED80x5PuvyNl5fTijMVbdelLeQ
	 GFskOyKDUK77g==
Message-ID: <sashiko-outbox-213588@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] kbuild: build the tools selected in
 tools/Kconfig as part of "make all"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, linux-kbuild@vger.kernel.org
Cc: "Shuah Khan" <shuah@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Andrew Morton" <akpm@linux-foundation.org>, "Thorsten
 Leemhuis" <linux@leemhuis.info>
In-Reply-To: <20261112195427.3411746-7-sashal@kernel.org>
References: <20261112195427.3411746-1-sashal@kernel.org>
 <20261112195427.3411746-7-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:55:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] kbuild: make -n all fails in tools_build when
  CONFIG_TOOLS_BUILD_PERF=3Dy
--

commit 0273f2e0753bd56565e4e6fbd57c3d5604e7d261
Author: Sasha Levin <sashal@kernel.org>

kbuild: build the tools selected in tools/Kconfig as part of "make all"

This commit makes the "all" target depend on "tools_build" when
CONFIG_TOOLS_BUILD is enabled so that selected tools are built during
standard kernel builds.

> diff --git a/Makefile b/Makefile
> index 7919263484f0a..2a69f4c73a641 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1650,6 +1650,10 @@ PHONY +=3D tools_build
>  tools_build: headers
>  	$(Q)$(MAKE) -f $(srctree)/tools/Makefile.kbuild
> =20
> +ifdef CONFIG_TOOLS_BUILD
> +all: tools_build
> +endif
> +
>  # ----------------------------------------------------------------------=
-----
>  # Kernel selftest
> =20

[Severity: Medium]
Does this break "make -n all" on a clean tree when CONFIG_TOOLS_BUILD_PERF
is enabled?

Because tools_build and the "build" macro in tools/Makefile.kbuild invoke
$(MAKE), GNU Make executes them during a dry run, creating directories
under tools-build/ and descending into tools/perf/Makefile.perf:

tools/perf/Makefile.perf:
$(LIBAPI): FORCE | $(LIBAPI_OUTPUT)
	$(Q)$(MAKE) -C $(LIBAPI_DIR) O=3D$(LIBAPI_OUTPUT) \
		DESTDIR=3D$(LIBAPI_DESTDIR) prefix=3D subdir=3D \
		$@ install_headers

Under "make -n", the $(Q)$(MKDIR) -p $@ recipe for the $(LIBAPI_OUTPUT)
order-only prerequisite is skipped, while the $(LIBAPI) sub-make still
runs and aborts in tools/scripts/Makefile.include with "O=3D.../libapi does
not exist".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112195427.3411=
746-1-sashal@kernel.org?part=3D6
