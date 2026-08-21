Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89B28505E
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787272114; cv=none; b=ehvNhYhRxnU/K1lo9y7j1LcWeTD9jNicK+TOBVTOvX2UrYWRuS0LH3z5Pe/cGfpmKqzovePZMtDMKTjiDEleJMXQypqUxOPAS6Mk931RDrLtl4NpKSBl2Fs8jBpvPoUc8WQnzKygey63TaAWaPEOSGRq2DeAF0kyev96fZYZ6nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787272114; c=relaxed/simple;
	bh=PVeHwDs3AG9JKDlKO7oXgXFh4F+t6EbVlKtFXuzFeks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZLSMVzEqwAxWQVqxGIbBdV0qbYSNFGHd1Mv1d0508q3D3FI8GskYWg3GGF9mk6QkTdTyZ34SH4A8/L+JyOe32jDhfmPumLuwwlbZfVKJEwxO/n8Yx7uPPKAhh9fXLnZ0MpVfmXqOkh2cUyLa4Y8HE59bcFkMO3pgsXTIUCF2YHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcKszcEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcKszcEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD55B1F000E9;
	Fri, 21 Aug 2026 00:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787272112;
	bh=06pskmQzPWa1lHv34ApiyZ/a4/4KQLzfA4K88SMRoAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TcKszcEUIM1GR1fnWjUCRSbR9HUcO9h8he6UgdmMVZ8u5U3ooqVACVvC5GJF7YtZ7
	 HRYPFRa7HwLZx3d0wkyvyJlSROsWxwbV9jIhGX6CDZNbaTqn10Inl0gqQQ7HilJim4
	 eXozfAE4n4H+nJvVqvOO58b0tTsDjIL5lBPKl/U6uzlrmIM7l1xELFjQqgkK9aAJNX
	 e4O9lMjwzRjYU7rQzHQj8zYJWBmsA+GG4JBWA6tufOuc5aszgmGDBl4rN+vngcjCqE
	 ceRj3c5hyyYJqRlhWBpodI9XkdbiRJXKyjpjw6yRzLVOCEXbCTQiPZjYgqxGSgzvIC
	 E8F5xI5XytrOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] perf c2c: print memory region data with stdio
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821001819.162277-7-thomas.falcon@intel.com>
References: <20260821001819.162277-1-thomas.falcon@intel.com>
 <20260821001819.162277-7-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 00:28:32 +0000
Message-Id: <20260821002832.BD55B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit inclusion of `<stdio.h>` for `FILE` and `fprintf` =
usage, violating strict musl libc compilation guide.
--

--- Patch [6]: [PATCH v5 6/6] perf c2c: print memory region data with stdio=
 output ---
commit f16f316fde0a57c797db59281b9604cd432a9c29
Author: Thomas Falcon <thomas.falcon@intel.com>

perf c2c: print memory region data with stdio output

This commit adds functionality to print memory range data in the perf-c2c
subcommand when running in stdio mode. If memory ranges are not present
or supported, it skips printing them.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 653b195f3c376..e774967052cca 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2636,6 +2636,34 @@ static void print_c2c_info(FILE *out, struct perf_=
session *session)
>  	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
>  }
> =20
> +
> +static void print_memory_ranges_info(FILE *out, struct perf_session *ses=
sion)
> +{
> +	struct perf_env *env =3D perf_session__env(session);
> +	int nr_ranges =3D 0;
> +
> +	if (!perf_header__has_feat(&session->header, HEADER_MEMORY_RANGES))
> +		return;
> +	nr_ranges =3D env->nr_memory_ranges;
> +	if (nr_ranges =3D=3D 0) {
> +		pr_debug("No memory ranges found, skipping\n");
> +		return;
> +	}
> +
> +	fprintf(out, "\n");

[Severity: Low]
Does this file need an explicit include for <stdio.h>?

The new print_memory_ranges_info() function uses FILE and fprintf(). The pe=
rf
subsystem guidelines note that files using libc types or functions should
directly include the POSIX headers declaring them to prevent build failures
on musl libc systems due to strict namespace separation.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821001819.1622=
77-1-thomas.falcon@intel.com?part=3D6
