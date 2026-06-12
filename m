Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF978F4A
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225240; cv=none; b=Kc+02v+Rlbz9SPsZYbLGPs+CWtE0O2nLdrzSXaStPD6jSZY+pfuc/klh+1Y5qSAASPMVq80Mc5kfWjcRlItLuU03d265ct0sYFNl040UjwmffSPexwAQyOHcw8pJiFBIUmv9p/xbHuuXWrWKS51FTO61W3OqskekEowb1nnAUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225240; c=relaxed/simple;
	bh=Vh2eGfNVI2055qyQieuVVf4jmNy0yk+HRycC5P9nlL4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IWpMJV9Ou3+EDeDWzNgGn6FunHNvj5ekhLs5GhdNS7RFkzvYSjRysLkcyGb9ArM8J8WQlqy64+fqeaCUHRKX2E9y4dH46aB4X9+xUTumx21tK/hHUPT66wqIh+UqD0A82cxMTq6UX8RHfhCiNzPaA4xWPUistaVlnJRil2yQm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEgi7iBY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEgi7iBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19861F000E9;
	Fri, 12 Jun 2026 00:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781225238;
	bh=QAGO/Bgvm/TB2EDV2nxgvbhp5K/zy9GB88dObO54cZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HEgi7iBYCbPD/8ilpv7iubRw8ZvSLrWG3IpFRjjrMj1nsYh34tW4jlCyTagxW0Pp3
	 i8uZJEN+djVMOR6x8JXNgJ9dwxMG+TeVoQpt8RWYBk7Y+FCyZM+b07abjdOFmmHNGK
	 De4oyOLdLUBC7PBTEZNhy9WbKE7Vc3MBWQapK4OXrBGZ/ygqQaswqHQ1BKywIJ9ygP
	 62OLw2uyDGIkRM0ZXtiOttK3DNmQt+PHQAwHiftLim5MBVOZZQu6l+wxU152Pl28Db
	 kLtQQ15xJEOH4Z8LfHXGNqWCdtPX4CjJcOpX83JGMdXrM0oOoDDj5Q7qyPFia1b7hp
	 uukeGYMPG5QKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/15] perf symbols: Use fixed buffer in
 sysfs__read_build_id() for no-libelf build
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612003444.50723-4-acme@kernel.org>
References: <20260612003444.50723-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 00:47:18 +0000
Message-Id: <20260612004718.B19861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Type punning via pointer casting from a declared character array to=
 a struct pointer violates strict aliasing rules required for `tools/` code.
--

commit 712f0fc91e35c55d2c2445bb412251f7934f7642
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf symbols: Use fixed buffer in sysfs__read_build_id() for no-libelf build

This commit replaces an fstat() and malloc() approach with a fixed stack
buffer and a single read() in sysfs__read_build_id(). This ensures proper
handling of sysfs pseudo-files that report a size of 0 or 4096 regardless
of actual content.

> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-mi=
nimal.c
> index 0a71d14639527..ea2de3d50d33c 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -220,29 +220,36 @@ int sysfs__read_build_id(const char *filename, stru=
ct build_id *bid)
>  {

[ ... ]

> +	/*
> +	 * read_build_id() casts this buffer to a u32 note header pointer,
> +	 * so it must be aligned for u32 access.
> +	 *
> +	 * Accessing a char[] through a u32* is technically type-punning
> +	 * under C strict aliasing rules, but perf unconditionally builds
> +	 * with -fno-strict-aliasing (Makefile.config), so this is safe.
> +	 *
> +	 * This file is only compiled when libelf is not available =E2=80=94 the
> +	 * common case uses the libelf-based path in symbol-elf.c instead.
> +	 */
> +	char buf[BUFSIZ] __aligned(4);

[Severity: Low]
While the comment notes that perf currently builds with -fno-strict-aliasin=
g,
the tools directory guidelines require assuming standard -fstrict-aliasing
for all tools code.

Does casting this character array to an incompatible u32 struct pointer
inside read_build_id() violate the strict aliasing rules expected for this
subsystem?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612003444.5072=
3-1-acme@kernel.org?part=3D3
