Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672005;
	b=xMItcebIlsElvbxav+5/9ARIV0W4gnjsk+GJtV7MPY0WE9q1LuQUuuNjKWibNRpmCXG1
	 DDp0dcqPo4EGvXTKLA+cz4RIgzVj59Qj04iyvnKpD7fqUeAq1hMWD2+miKcA04nCHTvqh
	 ZrFJlBD48Od+19g/8wdY1yL4/f6Mgi0/FONbeWJZPFF1TGeeuTOAO/GtsOQIP5pPlf/iH
	 P9awUyzcAdDUjBhUuXqrv2fq3CRPMyQIyof4PS2KwXgrDuBmlKMXkzflmmk4VYm9teIth
	 WOkk6sDve6BpAh8nsgftj97V5WCjHOr471IROpUE6UDkQlMW8vbZMcP4NSwKVJMpeFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672005;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YcQwvZxdXoX+Xr5YGaVeB53m4cBZj9fCibUP4xsc3MI=;
	b=b2POao6YBI/OjRLtQ4Y+VGPM/ATkrOgoF2SbfKK3UnUxW1hTkRLCxwreTiaJA3shMHmr
	 YYh+i7u6A3yEn7lh3EXq7jdvPsL1Q9sDVFtnGbmAiO5dDyshH6CQRIp2q9a7DAlsI+GAH
	 kOejRwHvjUSA6hmueOFW7qg5gcP/6tba8cAkN8f+0jzlwOPmLtptJn960bmeEhKN5NhJt
	 DQO0wDvlwiloeBggNRvkr17Qq5CxF1Z3nZQQbPpnB37VN0DiMcp6scjMYIUa97zf3LrDB
	 5gFricWi0YOyyhPPtDDS6jgB6yjVlW9t8wVdikkZ7POIzgPeeNAfQjTqe0ETXSqzmhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5cYxVY8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F49A606A326;
	Tue,  3 Nov 2026 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5cYxVY8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5631F00919;
	Tue,  3 Nov 2026 02:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793672005;
	bh=YcQwvZxdXoX+Xr5YGaVeB53m4cBZj9fCibUP4xsc3MI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5cYxVY8Xx31u8AdeyXTgc6n/ppqWZ5+bVXoeAXigP6mCBIPN03KLdWIB3SQ+9p3u
	 Dmq0h9FPU2JIn6MBhMELoOOSCaDMvKUc3gIZyA159OP8eJ9FBq787TqKB2f6uKsuUj
	 f4H3/FFrkIInpR7SzxVVw7YGWQuAMy08IMon/s+j9ofz3TnmZinyAjE7LWul2NqS9b
	 hLNgHK7nu2xC2Bi/3yaO2yWEUdgapkho3LSizI0sSHZ5Qa9coqCLoElxnPevh0Oi7V
	 aVqTNwxxgRsNtb/LW0YO2EcGnFq8Zg8ngS9ZR3G1g8jIL1mTRqFBOpPE5SKkcXYv8D
	 zWjcSwM8ssqJw==
Message-ID: <sashiko-outbox-194453@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] tools: build kernel selftests in tools_build
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
 Leemhuis" <linux@leemhuis.info>, "Shuah Khan" <skhan@linuxfoundation.org>
In-Reply-To: <20261102021253.2545235-6-sashal@kernel.org>
References: <20261102021253.2545235-1-sashal@kernel.org>
 <20261102021253.2545235-6-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 02:13:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tools: missing shared Makefile dependencies in selftest-shared r=
ule
--

commit 730c01fcefa10c1ac883951ece76358d414b16b5
Author: Sasha Levin <sashal@kernel.org>

tools: build kernel selftests in tools_build

This commit adds a Kconfig sub-menu and Makefile rules to build selected
kernel selftests in parallel as part of tools_build, tracking shared headers
and makefiles to trigger clean rebuilds when dependencies change.

> diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
> index 4b3ea73bc8ab9..590440121c8c9 100644
> --- a/tools/Makefile.kbuild
> +++ b/tools/Makefile.kbuild

[ ... ]

> @@ -89,6 +90,119 @@ PHONY +=3D perf

[ ... ]

> +$(selftest-shared): FORCE
> +	$(Q)mkdir -p $(@D); \
> +	newest=3D$$(find $(CURDIR)/usr/include $(toolsdir)/include $(toolsdir)/=
arch $(toolsdir)/testing/selftests \
> +		-type f \( -name '*.h' -o -name '*.mk' -o -name Makefile \) -printf '%=
T@\n' | \
> +		sort -n | tail -n 1); \
> +	touch -d "@$${newest:-0}" $@

[Severity: Medium]
As reported by Sashiko on RFC v2 [1], in tools/Makefile.kbuild, the
$(selftest-shared) rule searches $(CURDIR)/usr/include, $(toolsdir)/include,
$(toolsdir)/arch, and $(toolsdir)/testing/selftests for files matching *.h,
*.mk, or Makefile.

Several selftests enabled by this patch include shared makefile fragments
outside those paths and filename patterns:

- tools/testing/selftests/kexec/Makefile and
  tools/testing/selftests/vDSO/Makefile include
  ../../../scripts/Makefile.arch (i.e. $(toolsdir)/scripts/Makefile.arch).

- tools/testing/selftests/rseq/Makefile,
  tools/testing/selftests/thermal/intel/power_floor/Makefile, and
  tools/testing/selftests/thermal/intel/workload_hint/Makefile include
  $(top_srcdir)/scripts/subarch.include (i.e.
  $(abs_srctree)/scripts/subarch.include).

Since neither file is covered by the find command in $(selftest-shared) or
listed in $(selftest-extra-$*), and lib.mk does not list Makefiles as
prerequisites of built test binaries, won't modifying
tools/scripts/Makefile.arch or scripts/subarch.include fail to update
$(selftest-shared) and leave stale selftest build artifacts during incremen=
tal
builds?

[1] https://lore.kernel.org/r/sashiko-outbox-175556@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102021253.2545=
235-1-sashal@kernel.org?part=3D5
