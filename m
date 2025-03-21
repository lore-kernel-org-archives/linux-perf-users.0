Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8171E3DDE;
	Fri, 21 Mar 2025 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537698; cv=none; b=osXkjpOHQey6yXhvJkUkaMiD/6BJKhtX2fpPskj87dGsm8tI7ZGXquQ2noNUfe03FDLeFpdpORlf7+OjQYnV8nRvZ32PYwq0GLTxfwle4nHbm7NFbtpXCTd2QtORmgT+uKv2TRmZ3huPtVU6Y6z/gtLoEedzkyKBiZawcD1uaoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537698; c=relaxed/simple;
	bh=GeHxnMpO/kJTQB/m559nonG3wanc6brHcCgWWhiY8v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHP6BjCTaJHFkaqFNfgC/+5jAUx1HAIr3I0cDtTMYJLgfAYL18+Nfjdvzx8rB2GXmhealADGZvqM+70g5qAh+HWX4IeZIZ0APo8J2z0zZpiVlQrWCdRFw8Z9xbeOEQOAA0476jcFPISxVByOR63TZZds/taCFTfWB62K/lC7q5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iU5s7Bk6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU5s7Bk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF530C4CEE8;
	Fri, 21 Mar 2025 06:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742537698;
	bh=GeHxnMpO/kJTQB/m559nonG3wanc6brHcCgWWhiY8v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iU5s7Bk6bTvi84fGqNPSpQ1cXhxhWm0sBWVz8CuB1HKRkxQXZzSbKah77wpw0R2GZ
	 3b2COcFmo/VsoqbcbELAg6fRTGfPA+nDb47ZMBJjR7Pv2F80i9lS0+v8Kyo4YZpfBR
	 NCtMs6bSz9OimHV8tFrURBZUkh50PSg0+gu+IbpImaKJxvny04041Y6D5bHmHWcXcj
	 wfYBecXhXEzm3q9H++hgDcwW9RlFYc9SMCK5Buzk9jPlmES8vh6lu2TYkqRHzWH5Fr
	 cGIonwFentL21UBvuuuze6LCut2OaJlbf/gEilKQs4CbN+xLSBDubfNoWZoVe9s/pD
	 E+N4uGhd1F5Xg==
Date: Thu, 20 Mar 2025 23:14:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Holger =?utf-8?Q?Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Guilherme Amadio <amadio@gentoo.org>
Subject: Re: [PATCH RESEND] perf build: filter all combinations of -flto for
 libperl
Message-ID: <Z90D4DaG93BfHi8g@google.com>
References: <fa1c3b38-6a23-af22-0e5e-280fa523d06a@applied-asynchrony.com>
 <c5640c73-944d-5de1-a0bf-7e6769c1542f@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5640c73-944d-5de1-a0bf-7e6769c1542f@applied-asynchrony.com>

Hello,

On Wed, Mar 19, 2025 at 12:10:59AM +0100, Holger Hoffstätte wrote:
> [Not a peep of feedback - if I'm doing something wrong here please let me know;
>  the patch fixes a real bug someone reported in Gentoo.]
> 
> When enabling the libperl feature the build uses perl's build flags
> (ccopts) but filters out various flags, e.g. for LTO.
> While this is conceptually correct, it is insufficient in practice,
> since only "-flto=auto" is filtered out. When perl itself is built with
> "-flto" this can cause parts of perf being built with LTO and others
> without, giving exciting build errors like e.g.:
> 
>   ../tools/perf/pmu-events/pmu-events.c:72851:(.text+0xb79): undefined
>   reference to `strcmp_cpuid_str' collect2: error: ld returned 1 exit status
> 
> Fix this by filtering all matching flag values of -flto{=n,auto,..}.
> 
> Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>

Thanks for the fix but the patch is not applying.  Can you please check
and resend?

Thanks,
Namhyung

> ---
>  tools/perf/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a148ca9ef..4f5a40ab8 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -820,7 +820,7 @@ else
>    PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
>    PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
>    PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
> -  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> +  PERL_EMBED_CCOPTS := $(filter-out -flto% -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
>    PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
>    FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> -- 
> 2.48.1
> 
