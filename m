Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1870F40855
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960129; cv=none; b=FOqDYUlTPEBSofdt0NHTqFiuJl2jLMY4YO4OCwejsQnF4h1f13kLl6podkiyQPu/DcY+swppA2qLniLBP0xa2DJ7zJuQYPEuNsXSFPdmBVNj7d7TtsF2qKKoplweXYkk7APnO/9n0daj3sUryt2lda/grGhnktkL3n0OMeBF4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960129; c=relaxed/simple;
	bh=DxcC2d7YHolcSdfx68XC5pF3/fwqp7xeNxDjXwbfD74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZJe9y8Ylad3K2VyO9YiT0U1sYeLw6MJ6rDYI0befj4LedTOOT9WIviK4k/xApQcIdbedXAD0gYIZKT893H11VWtt2LEtbKxc2hiEgvqHIgN1u24pKgfDfcqRNA1Q9RRexnEAo0KMWksLkfcKXU/LtInTl61W3uF7ew2fKRaO9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4nnm4F4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4nnm4F4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D3B1F000E9;
	Mon, 17 Aug 2026 09:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786960127;
	bh=UQkc/KZcHIL0fxqgUM+Pg6f0GYAqC+mKM3j8zF9IsK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4nnm4F4OgkNEYG2/4OyJq1q21f8zwhSh+WMAJRKFVHIrKAKa5VpdLb6OxznlmkmN
	 CIzTh+14vmUtqUnKptEyo1odZ+CwHnr3p9f2EKbAQPHwyXCrAFG0McAyM0YOfFwOZv
	 iv/WHhK91ImKe6VTeYCTcjWFewXmDCKqK1+7MqEOPNkRIYzyBB9VCMQyTI2NdODOG1
	 +RV3m/F7q48rHTVpRkd2f9ST+vw+nee6MHlhgTJrCNPXz/XUmR7/stqYyUHjJzreIa
	 K/iqEoIQOm3vE0U+ap0ZyH/1aNb8ag61bo4gsNy8D9l0nCn7XwXgegUONEpVcxJe7R
	 0d5aD2BsKtuIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/9] perf c2c: add function view model skeleton
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260817094623.3288456-3-jiebin.sun@intel.com>
References: <20260817094623.3288456-1-jiebin.sun@intel.com>
 <20260817094623.3288456-3-jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 09:48:47 +0000
Message-Id: <20260817094847.73D3B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] symbol_name_equal() uses host-architecture logic for cross-platf=
orm analysis.
--

--- Patch [2]: [PATCH v9 2/9] perf c2c: add function view model skeleton ---
commit 4a0efb41e4b472e806fe1942f44d90ab0a7857c6
Author: Jiebin Sun <jiebin.sun@intel.com>
   =20
perf c2c: add function view model skeleton

This commit adds the initial common model for the c2c function view. It
introduces model state and small helpers shared by hierarchy construction
and formatting, building the model independently from util/.

> diff --git a/tools/perf/util/c2c-function.c b/tools/perf/util/c2c-functio=
n.c
> new file mode 100644
> index 0000000000000..ca82425a28dc3
> --- /dev/null
> +++ b/tools/perf/util/c2c-function.c

[ ... ]

> +static inline __maybe_unused bool symbol_name_equal(struct symbol *a, st=
ruct symbol *b)
> +{
> +	/* Two unknown symbols compare equal, matching cmp_null() in util/sort.=
c. */
> +	if (!a || !b)
> +		return a =3D=3D b;
> +	return arch__compare_symbol_names(a->name, b->name) =3D=3D 0;

[Severity: Medium]
Does this break cross-platform analysis?

Calling arch__compare_symbol_names() delegates symbol comparison to a
host-specific weak function rather than checking the target architecture.

If someone analyzes a perf.data file recorded on a different architecture
(like PowerPC) on an x86 host using perf c2c, could this lead to incorrect
symbol matching and inaccurate profiling reports because functions fail to
coalesce properly?

Would it be safer to query the e_machine constant dynamically via the
perf_env or session to handle architectural variations here?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817094623.3288=
456-1-jiebin.sun@intel.com?part=3D2
