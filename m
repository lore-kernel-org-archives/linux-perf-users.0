Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E535959
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 02:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254448; cv=none; b=YX1gJkJsbUuRF4zPooKeZJ0DRjgoDfNHXu2j3D29IlWchP8+zbeC4iBQ/dinivtZDpdIjcqyYDiAUhddr/NFmx16UMsIbwqyrMAIzdEhrkkvCUsAA8xjqWfWYm0kMQ4PEKZBDnk/FfLBd+1Gn79PME+N9FTZhF4FgNXV0ase+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254448; c=relaxed/simple;
	bh=AE7Cj+eM90kGqk7D92YzHbUbLYPRoB0XZI2dYD/q0gQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LJC+LcIo3gaiGWzmOlaCH3uqbuYeDh7o6qIBMjSmcqd2fnoMPtEfxkpLNG8ELGgKe2DmcadLJJs522hBsLNZunDhrEuwa/LE1NbmbvpSaf0P13Z2cn9qkMvMXmU5ocvVN4VhtAImAS68navVFLNmNkmO9vQvtwdbWZPAthJg33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eW0qbHEX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eW0qbHEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E702B1F000E9;
	Fri, 17 Jul 2026 02:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784254447;
	bh=AE7Cj+eM90kGqk7D92YzHbUbLYPRoB0XZI2dYD/q0gQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eW0qbHEX010rV42yO293tS8A+vBlX5xQQdE9e0zZBN+B+agJ2Gq4mpKJet1P4RGAs
	 wCV83Sc5VF31x+GqPAcnYUJ/N2uBqFgMb4lwplmACx/4VJ936NpesAfSq0YNsDbYx+
	 crHccf2yFFtDc0dweCMq8gYxH/BNgQNR+sOMqyrU7yd31t06POPoYhIaq5MMizTafY
	 slZ3G/XJWQyVDhFTyY7zvgx7gYHJhuLqYpadnfwEXJiUJtNpANV5jMAvebW49zsnDU
	 ZskK02P1pHBQ3OHeLko0eiWA0jUjon40vbOTV7XbvILLcp+BzbsZc6MoA4QkYrFK9z
	 sUz0RnZrJ84DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/14] perf c2c: extract shared data structures into
 c2c.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717020530.1645123-2-jiebin.sun@intel.com>
References: <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260717020530.1645123-1-jiebin.sun@intel.com>
 <20260717020530.1645123-2-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 02:14:06 +0000
Message-Id: <20260717021406.E702B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The header file `c2c.h` conditionally declares `perf_c2c__browse=
_cacheline` under `#ifdef HAVE_SLANG_SUPPORT` but fails to provide a dummy =
fallback stub in an `#else` block.
--

--- Patch [1]: [PATCH v3 01/14] perf c2c: extract shared data structures in=
to c2c.h ---
commit 80edfe9d884de7c391eedef4197115fd44418382
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: extract shared data structures into c2c.h

This commit moves c2c data structures from builtin-c2c.c into a new shared=
=20
header c2c.h to allow reuse by the upcoming function view browser. It also=
=20
makes the global perf_c2c instance non-static and exports=20
perf_c2c__browse_cacheline().

> diff --git a/tools/perf/c2c.h b/tools/perf/c2c.h
> new file mode 100644
> index 0000000000000..79dbd35184eda
> --- /dev/null
> +++ b/tools/perf/c2c.h

[ ... ]

> +void *c2c_he_zalloc(size_t size);
> +void c2c_fmt_free(struct perf_hpp_fmt *fmt);
> +bool c2c_fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b);
> +
> +#ifdef HAVE_SLANG_SUPPORT
> +int perf_c2c__browse_cacheline(struct hist_entry *he);

[Severity: Medium]
Since perf_c2c__browse_cacheline() is conditionally declared under=20
HAVE_SLANG_SUPPORT, should there be a dummy inline fallback stub provided=20
in an #else block?

Without a fallback stub, any C code calling this function would either fail=
=20
to compile when slang support is absent, or require redundant #ifdef=20
HAVE_SLANG_SUPPORT guards at every call site.

> +#endif
> +
> +#endif /* _PERF_C2C_H_ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717020530.1645=
123-1-jiebin.sun@intel.com?part=3D1
