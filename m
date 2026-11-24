Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546852;
	b=UMAAjPp4YHhKACIlR0QpK2O83GfcBZnmM6CQMzul1MvipVihQwqLPLwkHwvba5+cEW78
	 l4NXHlJ+twZoxLO+4eUU2rrZy/hMfBszqM/Bbe2Of/97+bmQAwf7iVP5STDzWSwZurh4S
	 GdO4Z1r/vRHxaubhin56UixWkxh9Wyo0oYm1rbvt9mokHJNWTiwaHIfDmPDnRL/YKx9rZ
	 WILzrpe34jeER9nFbg9SX7ZyVudT60tuPo0ZqswQ1mSCur3vdjUO6eGrGrjhl1ETQjkbo
	 VuKIxplggYUxFj1/kkxZxJTPAFgbaZXwe+vtS3e91BBtnlQ9kgqnuR4hOZzMWmv9/wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546852;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Dm5IbXTer71PPoRQHXkP5oQuiogyIHvgVKi9iRDkxoI=;
	b=MRBOGBXUr/R+6UZ1a8pCZaGPRxUoZBZRboUFOr5T38j/k7eu4NhRsBjVUnsy7z1MpAnI
	 jH7juPXt1HJdWGIC4vziFQ8cG9s5djoCfKe7eaTYCnIz0U+pbaR1dsHHX9rkyMyL6kIEX
	 Ja26m6i+KRFxD3HLhbXVY8hi5k5NrsdX398F/OVv8ent54aSA81hnmu1KAHbpZZB6J4+G
	 G6rMHFo0wS9YAduDEwQNzRWG2aFeZzhM8NYuFLnaLkBYfLrz+sO68c4DfrhOJM8Pp7Veh
	 q/UYYidtF3eavI+HK2GYolivZeMvQ2v0waEG5HLZ+nM/QaAOaUzpG8mIuaPP6zgRnmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kh5sAZQi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2187606A333
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kh5sAZQi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BCC1F000C0;
	Tue, 24 Nov 2026 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795546851;
	bh=Dm5IbXTer71PPoRQHXkP5oQuiogyIHvgVKi9iRDkxoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kh5sAZQiYdcdw0+kkUFgWAqlxHLinFV2YJm+YePrlZLi40BhtsOI38cZxezP2heYM
	 C4jwrqZl4XDPzF4vmjLAeCg334czrAb+S7dhriJtP0p1aumVaBB6B2B0CNt9wisHJZ
	 Qj/0/OrKVLq2meFLPZv6KvYA4kjthagP8MkshgeEFeeNTG6UShr1QTT7l+mryH9Lnr
	 +HoEZc/ZXUPMcwHmF267Y/6BSRh93/cmE/j3r2SO9h6osHQ9Oa2zIFSUOQ9Zk2O2/z
	 dCnyVn9q2EDo4mFa2fX74e/QpQW/jhjsbLZ5xffbkko6tL5HciUulq3kRZQY8u6CRc
	 SZUC8i3XERIXA==
Message-ID: <sashiko-outbox-231869@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 16/17] perf tests probe: Exercise the variable and
 line listing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124184604.24983-17-acme@kernel.org>
References: <20261124184604.24983-1-acme@kernel.org>
 <20261124184604.24983-17-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 19:00:50 +0000
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
- [Low] perf tests probe: -L/--line tests fail when kernel source files
  are missing
--

commit de96d208624e6809de0b6f80a8a08a4c06516441
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tests probe: Exercise the variable and line listing

This commit adds a shell test for perf probe that exercises variable
listing (-V/--vars), source line listing (-L/--line), function listing
(--funcs), and missing argument error handling.

> diff --git a/tools/perf/tests/shell/probe_vars.sh b/tools/perf/tests/shel=
l/probe_vars.sh
> new file mode 100755
> index 0000000000000..1e9476635b1eb
> --- /dev/null
> +++ b/tools/perf/tests/shell/probe_vars.sh

[ ... ]

> +# The variable and line listings need debug info, skip when the kernel
> +# was built without it.
> +if ! perf probe -V schedule > "${out}" 2>&1; then
> +	echo "Probe variable listing [Skipped: no debug info for schedule]"
> +	cleanup
> +	exit 2
> +fi
> +
> +run_probe "vars" "Available variables at schedule" -V schedule
> +run_probe "vars long option" "Available variables at schedule" --vars sc=
hedule
> +run_probe "vars offset" "Available variables at schedule" -V schedule+0
> +run_probe "line" "schedule" -L schedule
> +run_probe "line long option" "schedule" --line schedule

[Severity: Low]
Will the -L and --line subtests fail when vmlinux debug info is installed
without the corresponding kernel source tree on disk?

show_available_vars() (-V) only reads DWARF from vmlinux, whereas
__show_line_range() (-L/--line) also calls find_source_path() and fopen()
to read the C source file.  On systems with debuginfo packages installed
but no source files at the build path, perf probe -V schedule succeeds and
the -L/--line subtests fail instead of being skipped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124184604.2498=
3-1-acme@kernel.org?part=3D16
