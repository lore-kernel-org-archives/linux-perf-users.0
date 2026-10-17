Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFEC47FAFE;
	Sat, 17 Oct 2026 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247532; cv=none; b=p0Z7osV6uFou0us11ViBHOnKky/DVKRJKGH9B+GqNMWKLml0+tkZDEfZgOOjGGPOr0P/3gkZozZGVAqAAuKtAwy9RtyEEF8mhKg3KDVGIEK+tHhK3QEExqBZFbJMJZ3VO//ZIbVGCUcTmf+fth5czoJSLeXZ2hvzThV2SiDd1D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247532; c=relaxed/simple;
	bh=kxXercG/rVlXOsA85BC8oG8l7RIloeYT/J+aIezxsxw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QNPAjKwmqkXlFpfoQX+t1l9zVpHGf4iqRSabyv/MHSY9Y0E6Lk2Y+slaB/MVoagBVLwgy5aWP8by2DPcbLLZ7D5y2eiHtNiaD9yUnIzix3AeUKUzYUNpleBuRCNB1zNNPtlGYCUdBKAfo35KUOpCDigTg51XlrtO4jt6IAN6QxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCNXnna6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCNXnna6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0721F000C5;
	Sat, 17 Oct 2026 14:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247530;
	bh=PyQa/dyAL/NbyJ/JYtXuC/BhYzBqZwzWTuJaR9Pk3f0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OCNXnna6RS4WvlCf57+sOFXMms24gaqZzzr5q6Fya5es+DIuF2Bz6HpR+xoGBHhjA
	 hLYvBwhBtD2i7i1IhaZReoOgrZNJ9sJCwx/ObyPiaQgVf3Qn6Sh1gUV2KMkFX9fJ9k
	 RxvkQWv/3nchnF0SJzyGCcudxFzIYVrLu9bxselcnqegBKwMQbX35TpCkVWIr4YUdC
	 2Ur/ttbZhyBcj/kL1RGp0kmeTYzswtfuaKfQYAgx/UYZ9f54/xB4+k2TFAZsjXEIUq
	 pWcgDhCY4dXcKJtOOizN8NwCkrM84E3Giz0DJ9PjKzP+k5u7+Yp81w0K68kuc8jAzG
	 oOjZkgAlXmtHQ==
Message-ID: <sashiko-outbox-175553@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/7] kbuild: add "make tools_build" to build
 userspace tools from tools/
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, linux-kbuild@vger.kernel.org
Cc: "Shuah Khan" <shuah@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Andrew Morton" <akpm@linux-foundation.org>
In-Reply-To: <20261016143143.3613501-3-sashal@kernel.org>
References: <20261016143143.3613501-1-sashal@kernel.org>
 <20261016143143.3613501-3-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:32:09 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kbuild: flawed dry-run detection breaks incremental rebuilds
--

commit af4d0e2311f445e8ceb17d3fd81b05fa2c242614
Author: Sasha Levin <sashal@kernel.org>

kbuild: add "make tools_build" to build userspace tools from tools/

This commit adds a new target to build userspace tools from the tools/
directory as part of the kernel build process. It introduces a Kconfig
menu and a Makefile for building the selected programs independently.

> diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
> new file mode 100644
> index 0000000000000..8cfa7f80039cd
> --- /dev/null
> +++ b/tools/Makefile.kbuild

[ ... ]

> +# $(call build,<output directory>,<make arguments>,<files to check>,<CON=
FIG_ symbol>)
> +# Builds in an empty directory when the make arguments or LDFLAGS change=
d, or
> +# when one of the files is newer than the last build. "make -n" only sho=
ws
> +# the build.
> +build-key =3D $(call escsq,$(2) LDFLAGS=3D$(USERLDFLAGS))
> +dry-run :=3D $(findstring n,$(firstword -$(MAKEFLAGS)))

[Severity: Medium]
Could this dry-run detection logic produce a false positive for common make
arguments?

If MAKEFLAGS starts with a long option containing 'n' (such as Kbuild's
frequent default --no-print-directory), -$(MAKEFLAGS) evaluates to something
like ---no-print-directory, and findstring erroneously matches the letter '=
n'.

When evaluated as a dry run, the Makefile silently skips creating the
.tools_build tracking file and refuses to clear out stale objects, which br=
eaks
incremental rebuilds.

Is it possible to use the standard Kbuild idiom here, like
$(findstring n,$(filter-out --%,$(MAKEFLAGS))), to properly check the flags?

> +
> +define build
> +	+$(Q)$(if $(dry-run),,if [ "$$(cat $(1)/.tools_build 2>/dev/null)" !=3D=
 '$(build-key)' ] $(if $(3),|| \
> +	   [ -n "$$(find $(3) -newer $(1)/.tools_build -print -quit 2>/dev/null=
)" ]); then \
> +		rm -rf $(1); \
> +	fi;) \
> +	mkdir -p $(1) && $(MAKE) $(2) && \
> +	$(if $(dry-run),:,printf '%s' '$(build-key)' > $(1)/.tools_build) || \
> +	{ echo >&2 "tools_build: $(patsubst $(outdir)/%,%,$(1)) failed to build=
; set CONFIG_$(4)=3Dn to skip it"; false; }
> +endef

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016143143.3613=
501-1-sashal@kernel.org?part=3D2
