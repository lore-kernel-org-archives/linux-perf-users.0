Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF7368299
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402782; cv=none; b=B/4VDe6KJgE9WGlc1t5k9NjrA2OsgD45B8IkfPFCE4IDAznkmoun85dthMaCPUhzl5fccYdIay59uafPXtiV9gDMomMw2MH1NYjIVUkKH0XhmUS+FiJ5CUaXwdU3zIsqE/bc7oB7b1iqhfa2r7LMZYMA635cKCiaIoXalqq5E+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402782; c=relaxed/simple;
	bh=/29d0KGeE/q7edyatnEV+ks/ZIpfdleqYciNUkLz+4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AHR/9wRXPYJnq/tfZAQFqePKZC0zcQIWqsa5V1vheDsPFSHbcNEx1bZP81ICexu0brJIQYI4p8E5Ciwf/Lzw+A0YkLQ9sNFnEzuy3OMV/c/Vj/asnDO+uCEiwy9UjmBsXV6O7q5U/SyRiVWwMFxzanb5wBPNTggTo/FgFNfTCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5jkaKV4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5jkaKV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7A91F000E9;
	Thu, 30 Jul 2026 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785402780;
	bh=XRiV1oaCnMGjD5u97OKw2/paYgV3Qu/6/Qe+ZTa6InQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q5jkaKV4E4CbkYibuNajEJTm1kkakmXHTlL392/BLtcdB5JXDwh+ZBT1hms4lpDCF
	 Fh7Ppebl1LPkBM/5P9hp+uSblO96dpKftuEL7nYiFs/X92SI6UJ3UWGqsrqo1erHjf
	 PXnHiqVaT74+59KIQAP0o4JOT1rtm1fee2wtuuIIRtsrKjRw77gQa5ESqqdKUxM8H0
	 u95b22MepyxcJ5JBhSDNthOBA5Oumomel2s0XcI5tmhB4/H+lvXZR3NgTxOWJZM0LC
	 jvLTOuZMkOR2o6+X/oW4jHCDgCXpVeNMsogtlRpuO9DTajx+HKspSFkF4f/8iALqLX
	 dvov5WBCbbgGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 v5 1/9] perf c2c: extract shared data structures into
 c2c.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260730090521.2206375-2-jiebin.sun@intel.com>
References: <20260730090521.2206375-1-jiebin.sun@intel.com>
 <20260730090521.2206375-2-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 09:13:00 +0000
Message-Id: <20260730091300.BB7A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The header `c2c.h` omits the `#else` dummy inline stub for `perf_c2=
c__browse_cacheline` when `HAVE_SLANG_SUPPORT` is not defined.
--

--- Patch [1]: [PATCH v5 v5 1/9] perf c2c: extract shared data structures i=
nto c2c.h ---
commit 36546c8a38f921a241992fc1080e419739637db8
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: extract shared data structures into c2c.h
   =20
Move c2c_hists, compute_stats, c2c_hist_entry, perf_c2c, and the shared
column-formatting structures and macros from builtin-c2c.c into a new
shared header c2c.h. This allows the upcoming function view browser
(c2c-function.c) to reuse these types and formatting definitions.

> diff --git a/tools/perf/c2c.h b/tools/perf/c2c.h
> new file mode 100644
> index 0000000000000..ab7adb85d9c06
> --- /dev/null
> +++ b/tools/perf/c2c.h
[ ... ]
> +/*
> + * The TUI browsers are only built with SLANG support. Their sole callers
> + * live inside HAVE_SLANG_SUPPORT-guarded code in builtin-c2c.c (stdio m=
ode
> + * forces use_browser=3D0), so no #else stub is needed -- matching the r=
est of
> + * perf's TUI entry points.
> + */
> +#ifdef HAVE_SLANG_SUPPORT
> +int perf_c2c__browse_cacheline(struct hist_entry *he);
> +#endif

[Severity: Low]
Should there be an #else fallback stub provided for
perf_c2c__browse_cacheline() in c2c.h?

Even though the comment states current callers are guarded, the subsystem
guidelines require header files to provide compatible dummy inline stubs
when a feature define like HAVE_SLANG_SUPPORT is absent.

> +
> +#endif /* _PERF_C2C_H_ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730090521.2206=
375-1-jiebin.sun@intel.com?part=3D1
