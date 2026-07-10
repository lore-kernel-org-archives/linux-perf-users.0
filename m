Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1B341ADF
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673447; cv=none; b=l01DQ7ngzrJbL9+wGl2PUUkDjCXBWtT6LEBRAkcGBGoAwndW9XY0cqF6OdkeoR1C3uacakBLpsgViExFxYL24n8AeQmNtTNsFYcsOO7ExLyrWIUrEN7JnrDmjQhTjEcM1uAHlYGwhpf3B3lRnFllA5BkI8MdqMeqNzc83v4DHqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673447; c=relaxed/simple;
	bh=KvjWLghmsN2cOHqHD9HeVMBZ4QHn5dCdGMTRryIWysY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ox0AkRnjBzqlb++2WH17sM0W8h5fQnCSY3N1sLS18iVfPJ+IGEWrx9OQvxq9U049Zr29kSRVZA9OWPsTIyk8ydLaGbvVaHnleyl47HjhC+F8SXLqwyJJ0V4adXqVApWlsaqA38CjqcLUguPB7LRQLBHNv4sPrx15/6SdunT9/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCukejhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCukejhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF271F000E9;
	Fri, 10 Jul 2026 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783673446;
	bh=8zKSp8BGW4Cs3P/Doo3lKy7sNo1hosVtU7kEuJgV9Co=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oCukejhVuehLy78Tpo3I3Bt88bbzfVMBRJ/rPddwgCxkzJCztZmx9kJVyqL7iThJ5
	 CsZCYC9MzC32ySZ3VEOVGVZZPkaXNcKoD9yOggTPPHS3dALZWkcOC0IuVjfO8ThVDu
	 wmmk/NdzqvL9rH90WEG/xt7JBRhmFtz9ZWrcS8pjc5/hIfPNAE9n5gz6xE0jIwUY+z
	 pO03nGst/Ia0MxCSWZVqH7+kOIB2vJba1VNZ34VlkE09O/+PITBCMODq+mR8VhjlME
	 7fmuO7FVaVlA9YOSHZl8F4mVcUkhpJQVB6jKeH2qpCQ6MNhUoBetRr3BLyxrWlGRcD
	 Uhq0Ph4GGgBjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/14] perf c2c: add function view browser skeleton
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710084247.3576706-3-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260710084247.3576706-1-jiebin.sun@intel.com>
 <20260710084247.3576706-3-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:50:45 +0000
Message-Id: <20260710085046.5AF271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing header fallback stub for `perf_c2c__browse_function_view` w=
hen `HAVE_SLANG_SUPPORT` is not defined.
--

--- Patch [2]: [PATCH v2 02/14] perf c2c: add function view browser skeleto=
n ---
commit 9be68ac51631d03c2d6030c665e95226db59b140
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add function view browser skeleton

This commit adds c2c-function.c with a stub entry point and registers it
in the build system. It also declares the function prototype in c2c.h
to lay the groundwork for a future function-level cacheline browser.

> diff --git a/tools/perf/c2c.h b/tools/perf/c2c.h
> index 5c3f6ae633ea8..ffcd43d4c9038 100644
> --- a/tools/perf/c2c.h
> +++ b/tools/perf/c2c.h
> @@ -142,6 +142,7 @@ bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hp=
p_fmt *b);
> =20
>  #ifdef HAVE_SLANG_SUPPORT
>  int perf_c2c__browse_cacheline(struct hist_entry *he);
> +int perf_c2c__browse_function_view(struct hists *hists);
>  #endif

[Severity: Low]
Should there be an #else fallback stub provided for this new function?

When HAVE_SLANG_SUPPORT is not defined, perf_c2c__browse_function_view()
won't be declared. Providing a dummy inline stub that returns an error
like -ENOTSUPP would ensure compilation doesn't break if future code calls
this function unconditionally.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710084247.3576=
706-1-jiebin.sun@intel.com?part=3D2
