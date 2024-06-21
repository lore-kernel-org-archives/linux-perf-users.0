Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876615D5DA;
	Fri, 21 Jun 2024 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719013245; cv=none; b=hsb26HgxI2GmGO85OObUeb4jf0oSouI3dENBiaQs575sOxAVnG6Fej80npZnhxSCaIG89bDjg1K6xkSesQ2h7J50nts2E8ZmpXGg6HsOA3JW8BKQqg7qM/ptHhpVdyv7//rh8F07z51b7mif6rFlIZhUAIPCWf2OUKV7eqNB5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719013245; c=relaxed/simple;
	bh=Ew5SkIda0d0g+mAtmvU0jtooyCcYbSewxtUS9ItsRIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDDgbbEFvcuZ+4WtXDt1MeyLCybYZb512nPkcnduyXmUD1L1cybs/cuY7xSrM0iFL1TuIQDyq3uLIYOcOVlzXeh9y/yRoUQx7jWZmd8Vax+JFMWV2UV0DXaiUnJuk3AKEcdZ9yZnYfPRDWO7IUL0oBlpnbxhbZTeb2QkeB7ttDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmOLfkmk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmOLfkmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68EFC2BBFC;
	Fri, 21 Jun 2024 23:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719013244;
	bh=Ew5SkIda0d0g+mAtmvU0jtooyCcYbSewxtUS9ItsRIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FmOLfkmkYHOsdRMvZbJ1WgR2MKX+/uJThqwAkwtYI2JIIvezLSFgOPLTkooCzQuHY
	 hBRLgnr2QPcBcPtFTVfBR4mdk1t7WOerGxoZ/XRKkkYLewGrQRZsrsUn10ZRQp2g7+
	 brQzFw+Dh/DVajisH6Mw0vq16wJ0WtiKpUbrdd4Sz5fVdP/Ff9UONAMI56FrRMYbBI
	 qttBLzcub9PN5mpJYiYXwHfYursJ3tqVmF9do4+AENGdx5UV5N0QvrYvHkbzvoNUgb
	 4LJuS3Iq8NF3Ut2mt8HUZJngYchvgXEk7Yr5dyCKbcdRGJPWr16i17SoQDPbAYLKD9
	 4Q+/JRjFYqgPA==
Date: Fri, 21 Jun 2024 16:40:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Fangrui Song <maskray@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>
Subject: Re: [PATCH v2 3/6] perf: build: Only link libebl.a for old libdw
Message-ID: <ZnYPev8QPeNOFAR7@google.com>
References: <20240610095433.336295-1-leo.yan@arm.com>
 <20240610095433.336295-4-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240610095433.336295-4-leo.yan@arm.com>

On Mon, Jun 10, 2024 at 10:54:30AM +0100, Leo Yan wrote:
> Since libdw version 0.177, elfutils has merged libebl.a into libdw (see
> the commit "libebl: Don't install libebl.a, libebl.h and remove backends
> from spec." in the elfutils repository).
> 
> As a result, libebl.a does not exist on Debian Bullseye and newer
> releases, causing static perf builds to fail on these distributions.

What about libebl.so?  I'm curious why it's ok with dynamic build and
causing a problem with static builds.

> 
> This commit checks the libdw version and only links libebl.a if it
> detects that the libdw version is older than 0.177.

Have you tested on the older versions too?

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/build/feature/Makefile | 12 +++++++++++-
>  tools/perf/Makefile.config   | 12 +++++++++++-
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 084f803093c3..b23b3e8ad5e4 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -171,7 +171,17 @@ $(OUTPUT)test-libopencsd.bin:
>  
>  DWARFLIBS := -ldw
>  ifeq ($(findstring -static,${LDFLAGS}),-static)
> -DWARFLIBS += -lelf -lebl -lz -llzma -lbz2
> +  DWARFLIBS += -lelf -lz -llzma -lbz2
> +
> +  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
> +  LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
> +  LIBDW_VERSION_2 := $(word 2, $(subst ., ,$(LIBDW_VERSION)))
> +
> +  # Elfutils merged libebl.a into libdw.a starting from version 0.177,
> +  # Link libebl.a only if libdw is older than this version.
> +  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
> +    DWARFLIBS += -lebl

I'm not sure if it's ok to change the order as libebl might depend on
later libraries like libz.

Thanks,
Namhyung


> +  endif
>  endif
>  
>  $(OUTPUT)test-dwarf.bin:
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 755fb78be76a..db3bc460d4c2 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -152,7 +152,17 @@ ifdef LIBDW_DIR
>  endif
>  DWARFLIBS := -ldw
>  ifeq ($(findstring -static,${LDFLAGS}),-static)
> -  DWARFLIBS += -lelf -lebl -ldl -lz -llzma -lbz2
> +  DWARFLIBS += -lelf -ldl -lz -llzma -lbz2
> +
> +  LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
> +  LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
> +  LIBDW_VERSION_2 := $(word 2, $(subst ., ,$(LIBDW_VERSION)))
> +
> +  # Elfutils merged libebl.a into libdw.a starting from version 0.177,
> +  # Link libebl.a only if libdw is older than this version.
> +  ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
> +    DWARFLIBS += -lebl
> +  endif
>  endif
>  FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
>  FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
> -- 
> 2.34.1
> 
