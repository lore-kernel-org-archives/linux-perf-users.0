Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C52FBDFA;
	Wed,  1 Oct 2025 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326343; cv=none; b=siq/8CKcWQ8uRpp9KNSHWLt0JaKfwTdSve9QfkgRRo2p1O219XT9els25/sfdRdYfTyYFk3kwoquxCicsr1gL1rSd6nTYBQpyRdrBCP8MsysMdgVqv6QDJh+moTYwBAihFUifyz5/DnANNBa9GtOH8jFbTBTsfcmk089ZMZy4dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326343; c=relaxed/simple;
	bh=X3hm9ss/SXCZSvIwShr72ovUiAR+OHYiSbSTP2qjzCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6A7zrA9+bDp9GBA8ts4gUJhTPQxOYa2kZe64BeOxrrye2jHViMsPDT2L9rzDx0l9ggTo0JAn8coXZdRE48e6X9fPSNgoCEajsMlJc88hYC8T8WwiGik2tB1tGSCqjRTIwsYnK2QaRlAdz2m54dbpFL2FTFGBBkm+u4AM/w4Dz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMswArJp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMswArJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BADC116C6;
	Wed,  1 Oct 2025 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759326341;
	bh=X3hm9ss/SXCZSvIwShr72ovUiAR+OHYiSbSTP2qjzCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lMswArJpZ2ezk3pXV7PL2vbdMCSZMqRybljaqOG5JHPfyZd0qfWvhvegFlyZup6cO
	 RccnvOha1DIgjRim0XBcJV+5HNTTG3C+kuLeHP2/rnbp2peUKJPQbRBMmnKHAx/NCz
	 Xox8GEzVSc8ddGmcKGCUXTA2qQAd8eC+AR7/Aif4qAFnS3Qp+jo+5RDYo6NpQWHeLs
	 3HQoPzQEh2og89gDXmaMRAZJuYh/7osk6e4C9AcrHvLmOGf/qTyIO6yflNIW3x0tsZ
	 aB7rIr08HxhUlCOVw+Bubn2g+M6Q+OlXciHnG12nevCDoovY/OndAqPXz4Qfy15qpl
	 Ofkn+K1jFYlOg==
Date: Wed, 1 Oct 2025 10:45:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/8] perf build: Support building with Clang
Message-ID: <aN0wgvAsKh0n4sL4@x1>
References: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
 <CAP-5=fUdk-EEDz2p__UJAcmkO=bA143dOUpGRcnW7_5FhZT71Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUdk-EEDz2p__UJAcmkO=bA143dOUpGRcnW7_5FhZT71Q@mail.gmail.com>

On Tue, Sep 30, 2025 at 11:14:30AM -0700, Ian Rogers wrote:
> On Tue, Sep 30, 2025 at 9:55 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > This series adds support for building perf with Clang, following the
> > discussion in [1]. Because the Android NDK uses Clang by default,
> > enabling Clang builds naturally covers Android as well.
> >
> > The series is organized as follows:
> >
> >   - Patches 1–2: Fix two bugs found with Clang.
> >   - Patches 3–6: Correct CROSS_ARCH and dismiss Clang build warnings.
> >   - Patches 7–8: Enable Clang in the Makefile and update the
> >     documentation.
> >
> > Testing:
> >
> >   - Clang 15.0.7 on Ubuntu 22.04.5: native and cross-compiling (aarch64)
> >   - Clang 18.1.3 on Ubuntu 24.04.2: native and cross-compiling (aarch64)
> >   - Android NDK r27d (latest LTS): cross-compiling (aarch64)
> >
> > [1] https://lore.kernel.org/linux-perf-users/20240715143342.52236-1-leo.yan@arm.com/
> >
> > ---
> > Changes in v2:
> > - Dropped the patch for dismissing warning in bpftool.
> > - Refined the document. (Ian)
> > - Link to v1: https://lore.kernel.org/r/20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
