Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C227B50F
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457917; cv=none; b=UxFhWyYTBMd7ZAyG2b2QhbcBGtok9DyW6lH/TQ1NOAXssmOhBTMabsB3OSTKzdURolPhUeltv60odrnhDqJNfArw8/LXLkEf05fqxjdxqLM1Y9ygpnaJwp6Ge7viJxKM0XcY+Y63r2oDQ1J3R/fmrxl3xlnlwiE1drYrZrgUU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457917; c=relaxed/simple;
	bh=fko4ouKAkAyehR/cXaiZYHct+anxYVsgP/QtE9PGKvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=koTD6Kf8oBvlTcAh0qB5ySwgoLh8gVjYv8yL3nb09iqEuRbSdZpmkaLG35efDbZERjszMndqd9kXBb3KCP21fv+WslNHbkFJ/P2KLlYxpphpiwjZD3WZZRttggr4eSdWPP79zVA0A9o3zf40nJd9XB5izX0dYFnu67oM1Q9Bmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZT+TjOS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZT+TjOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627FE1F000E9;
	Fri, 26 Jun 2026 07:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782457914;
	bh=UzBrszwdfUj7xZdVOaAfnzK2hl0rCubMB3YkSJ8FpBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MZT+TjOSAdcDjwurSCUB4SpSTNfpgbt6uTzNgyGwx0fzxlUGey7464ZKphuVF2KGb
	 XlIteC68D11rZ/RyBkskjO7p4pgb5zjJXRYPKRn4IOw/j3wfVDPSa16obdj2/scYzr
	 5jwikhBENUYQ9rbFfNEfBGHV3UP/fc6NhHilkcCCo4wEt7wZ2QR/J98gNLZm6CdXNe
	 gyYjMDeypPGLdt2A+6Ye0NWODP/bpADUuuJs7gzI7qzKoRDFUuSDYH3Njr7q1xewdO
	 AkxbV5KmhTtmgkv8UqkA+A9LogHp4sSPl5hKXbi1U8HSa5Bj9KzTfC+MxgAqv0g57Y
	 xoxlhW5ElL7TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/14] perf c2c: add function view browser skeleton
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260626070355.1556721-3-jiebin.sun@intel.com>
References: <20260626070355.1556721-1-jiebin.sun@intel.com>
 <20260626070355.1556721-3-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 07:11:53 +0000
Message-Id: <20260626071154.627FE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added `perf_c2c__browse_function_view` prototype is guard=
ed by `HAVE_SLANG_SUPPORT` but lacks a dummy inline fallback stub in an `#e=
lse` block.
--

commit b142a11979c1d1a680751e23d2fc5169f9d5fc53
Author: Jiebin Sun <jiebin.sun@intel.com>

perf c2c: add function view browser skeleton

This commit adds c2c-function.c with a stub perf_c2c__browse_function_view()
entry point and registers it in the build system. It declares the function
prototype in c2c.h to prepare for function-level cacheline sharing analysis.

> diff --git a/tools/perf/c2c.h b/tools/perf/c2c.h
> index 3e974dd1d7ee6..385709536a1ae 100644
> --- a/tools/perf/c2c.h
> +++ b/tools/perf/c2c.h
> @@ -134,6 +134,7 @@ bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hp=
p_fmt *b);
> =20
>  #ifdef HAVE_SLANG_SUPPORT
>  int perf_c2c__browse_cacheline(struct hist_entry *he);
> +int perf_c2c__browse_function_view(struct hists *hists);

[Severity: Low]
Should this prototype have a dummy inline fallback stub in an #else block?
Without a dummy fallback stub, any unguarded call to
perf_c2c__browse_function_view() on a system lacking slang support might re=
sult
in a build failure.

>  #endif
> =20
>  #endif /* _PERF_C2C_H_ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626070355.1556=
721-1-jiebin.sun@intel.com?part=3D2
