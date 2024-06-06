Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5738DC7;
	Thu,  6 Jun 2024 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695646; cv=none; b=CxTBL615D+/H3Z8PLg25TkQaVC0kXdb2T/c+6yHvMRQWWyv+zqtzBFrZN/V8fHqhq+TDf4cLvWGAVBQu6FtMFNcUyJ7EeW7PKWFf2/f0TZak693kFIVntuZ3Ip8wvclpz+5gl7SJvD2wohIWAZIwwYNg59hf8dleazfaBObzimU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695646; c=relaxed/simple;
	bh=ennOQnPWn4O/h2UKcahZrRnfi5DrhPQG7mP3BEFvYoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw2lde7UwE1d/oFfXTVtj/tRhTmlaucP8z7sI1Gx6BxVsNltHI+k1MpGxmhYuguZXcnMuPihq/yFcIvS9WQ36oE+OQcA5XX1uQFWjWrKrVUVHyAuH+JviVGKkVE5f1DqnnU9DbrTCHe4jKM5+DCuUDYwFrbs4A3VJqvgjKDIFqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9w96H6a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9w96H6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DACC2BD10;
	Thu,  6 Jun 2024 17:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717695646;
	bh=ennOQnPWn4O/h2UKcahZrRnfi5DrhPQG7mP3BEFvYoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9w96H6amaJtFPZRtoMvWtv9V2P+7T+xz8vSeDYhcThG6iBvfKSnYKbx1FapfXbbx
	 L7WXP1V9Xqn4G/kRoEymgc644/3yDxp66jVKWu0tbC2a5z88iNGC2DQvaCVK+2H9w6
	 8bNJvC+xAZdTXLkGrH2g15zeNulWC9+Gvz3HasziskEOq/s7/jSkutyrFt9NsRRkMp
	 mdSxp9y9rWXQ72ni1Yv33PzHPqxz5o7dzIQpZfcvFqQqhpPM6IlimwG0Ntj2gUdwsF
	 2fq8xNhHpbgbUI9smSIonl3vjyUq8s7DnJNVOeTpq2XWwBIj61SU7ch9vXBOybYkST
	 sISiIsvxon+xg==
Date: Thu, 6 Jun 2024 10:40:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Fangrui Song <maskray@google.com>,
	Mateusz Kowalczyk <fuuzetsu@fuuzetsu.co.uk>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 4/6] perf: build: Only link libebl.a for old libdw
Message-ID: <ZmH0nCxLm5_Xl3Yo@google.com>
References: <20240604093223.1934236-1-leo.yan@arm.com>
 <20240604093223.1934236-5-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604093223.1934236-5-leo.yan@arm.com>

On Tue, Jun 04, 2024 at 10:32:21AM +0100, Leo Yan wrote:
> Since libdw version 0.177, elfutils has merged libebl.a into libdw (see
> the commit "libebl: Don't install libebl.a, libebl.h and remove backends
> from spec." in the elfutils repository).
> 
> As a result, libebl.a does not exist on Debian Bullseye and newer
> releases, causing static perf builds to fail on these distributions.
> 
> This commit checks the libdw version and only links libebl.a if it
> detects that the libdw version is older than 0.177.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/build/feature/Makefile | 12 +++++++++++-
>  tools/perf/Makefile.config   | 12 +++++++++++-
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 6f52f892f9a3..2f4cfb7b8c14 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -159,7 +159,17 @@ $(OUTPUT)test-libopencsd.bin:
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
> +  endif
>  endif

Is there a better way to collect required libraries using pkg-config?
I guess that's what we want to with the pkg-config in the first place.
Maybe `pkg-config --print-requires-private libdw` ?

Thanks,
Namhyung

>  
>  $(OUTPUT)test-dwarf.bin:
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 646e5af0ed51..e8d3713b081c 100644
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
