Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B97654CF76;
	Tue, 13 Oct 2026 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924063; cv=none; b=Uk9wr1VRVmxf5UD1nQI41bJBLLZ1426Sg/7kOV5c6IbhhImd1W0bOAQitqmWjSsvdqRahjqh1uEyywDng3MDq9+xiSEwX5psmTP61orolHgyRbD1Qae+oG3uUKVTbGwgYxIEYlClkzzEM9dZAynNSkCBEXSO6tOEupbjAer82E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924063; c=relaxed/simple;
	bh=uclqN8RJfyf8Rv9TDvNHTiHrO9mdVmgptS3BIIH+DWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGmMyJ8ZSUoTtp0Oy9bLItCQhhZdWHW0KjkhgE81muY1d7lvo2dyV+LYxUUEDXapxu2e3qYP1wX/nBcoSjLGd1uh3AJur9k/DxjdtF2SZaAeEyAJfJ5dMypNvoszYl1tFD8YuKV2Xt5oiev2f5VPSyy6muAPzR/4qWtHOiHVIBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=WTpxCQku; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="WTpxCQku"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1791924060; bh=uclqN8RJfyf8Rv9TDvNHTiHrO9mdVmgptS3BIIH+DWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTpxCQkuSUfT4AOK+1RAJ6+JYlpvb/k4yKU3iqZ1dbaW/6JaE0CciXJtlD0hqDXgk
	 PHalu4j1+CI1QtWxUfex2bJgKIxv8qn9bKqL1FdYehLM1pOrkRtnhhMy0U4QhoJcvv
	 hr8cw62xouS04vpQ0wJzOtV4iANQORFz2XTfIbQ0=
Date: Tue, 13 Oct 2026 22:41:00 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	linux-kbuild@vger.kernel.org, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/6] tools: build kernel selftests in tools_build
Message-ID: <8ee33f00-bd8f-4cf2-90c4-2961f443af60@t-8ch.de>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011233647.2454648-5-sashal@kernel.org>

On 2026-10-11 19:36:43-0400, Sasha Levin wrote:
> Add a "Kernel selftests" sub-menu with one entry per selftests directory
> that builds with only a C library and does not write into the source
> tree. Each is built as "make kselftest-all" builds it, with KHDR_INCLUDES
> pointing at the UAPI headers installed in the object tree, but by its own
> make, so the selected ones build in parallel. Selftests whose Makefile
> does not use KHDR_INCLUDES still build against the C library's copy of
> the UAPI headers.
> 
> The selftests do not track header dependencies, so a selftest is built
> again from scratch when its own directory, a header or makefile any
> selftest may share, or a kernel source it includes directly (the vDSO
> test includes the architecture's vDSO code) is newer than its last
> build.
> 
> Selftests that need libraries beyond the C library, a vmlinux with BTF,
> or a sanitizer runtime are left out for now.
> 
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/Kconfig         | 239 ++++++++++++++++++++++++++++++++++++++++++
>  tools/Makefile.kbuild | 100 ++++++++++++++++++
>  2 files changed, 339 insertions(+)

(...)

> diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
> index 62fd494253eca..c31347258d0a9 100644
> --- a/tools/Makefile.kbuild
> +++ b/tools/Makefile.kbuild
> @@ -92,6 +92,106 @@ PHONY += perf
>  perf: FORCE
>  	$(call build,$(outdir)/perf,-C $(toolsdir)/perf -f Makefile.perf O=$(outdir)/perf $(perf-flags) $(perf-flags-y),,TOOLS_BUILD_PERF)

(...)

> +# Unlike tools/build, the selftests do not track header dependencies. A
> +# selftest is built again from scratch when its own directory, a header or
> +# makefile any selftest may share, or a kernel source it includes directly
> +# is newer than its last build.
> +selftest-shared := $(outdir)/selftests/.shared
> +selftest-extra-vDSO := $(abs_srctree)/arch/$(SRCARCH)

Can we not fix the selftests to properly track header dependencies?
That has been an annoyance of mine for quite some time.
It would also get rid of a whole bunch of hackery here.

(...)
