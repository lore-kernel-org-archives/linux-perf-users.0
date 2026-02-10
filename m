Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C433271FD;
	Tue, 10 Feb 2026 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724531; cv=none; b=Ub+hZImz8UXa9m4I4eMcgG4THMfBZKqcBaqTRvgMwb/w9/FwKZn20AEm+9Ar7vpUTYTesamPdDcDCybgqKR9YuJyWf8At4RdifNEghA8GRr5hPdgGg+HTES5iRnAFkZtHAFK4HH39K6GXTWpuN3buEMnVbaQvR1wVdRq6/VLo6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724531; c=relaxed/simple;
	bh=sCNhZ1dVC3nQSCcJt37v/00zO7lqzjzgVq2K+cWsBAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uvwci4X3TwORse1ZKAzEXmVm3byBnn9i8CKaOyNaavuUU/27XVUiTYpx2E8kai6LvvWmN86ngpcH22jiVpqlMiD3NDfz0I2vKUDJpnrOcKyRA9tXvVkatXGhQFiZHpeLpR6bVqph3Mk9aMGOQIvaB1elkgiL38bPhoE5gQ4TC8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RntJWksc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RntJWksc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACA9C116C6;
	Tue, 10 Feb 2026 11:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770724530;
	bh=sCNhZ1dVC3nQSCcJt37v/00zO7lqzjzgVq2K+cWsBAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RntJWksc5Sdeqdmo+qazwatKob0NVZlWqCv2k1ld/yHC1jeUj7k+QoW1W0X2OgJbS
	 Z8fFOu/YJK3mAfYzy7WfHwN5qsi+wF9rgiI0vreO/RhPSjTiclUORk9bkQ/dNO8jBn
	 rnBEJpscT/vVFlsEKigAl1lCk2Do8NQc35YEmvaZYUD51hU4DbJp7p9g594ZnSqMUQ
	 cvUvPJmkd7JNWUpf3dEQDEy654aJYXJeskKzTliGHDi2cMyTKziKxHnRKtDY6vYnbo
	 3VxFnfaA+dE7o5bH41oL0llvg55KlEaTxAJ+DRxBOwv3ty/BwoFY807LWXJrgaWF5V
	 Xk+BVvbHn/t/w==
Date: Tue, 10 Feb 2026 08:55:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools build: Fix rust feature detection
Message-ID: <aYscrw4D4W27zw-k@x1>
References: <aYoZD1onJLsnlrV3@x1>
 <sc2w3tcjcle4zhz72b2jdnyfnhzl6atiecium2dwcmrlvn6syb@n573cdtyldne>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sc2w3tcjcle4zhz72b2jdnyfnhzl6atiecium2dwcmrlvn6syb@n573cdtyldne>

On Tue, Feb 10, 2026 at 11:02:56AM +0100, Dmitry Dolgov wrote:
> > On Mon, Feb 09, 2026 at 02:27:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > Features in FEATURE_TESTS_BASIC will be set as being available if
> > test-all.c builds, so since the rust test isn't included in test-all.c,
> > we can't have 'rust' in there, remove it from FEATURE_TESTS_BASIC and
> > use feature-check so that it tries to build test-rust.bin, doing the
> > actual feature detection.
> 
> My bad, thanks for fixing it.
> 
> > And after installing it:
> > 
> >   ...                                    rust: [ on  ]
> > 
> >   $ cat /tmp/build/perf-tools-next/feature/test-rust.make.output
> >   $ file /tmp/build/perf-tools-next/feature/test-rust.bin
> > /tmp/build/perf-tools-next/feature/test-rust.bin: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=9c416edf673ee3705b97bae893a99a6fcf1ee258, for GNU/Linux 3.2.0, with debug_info, not stripped
> >   $
> >   $ perf -vv | grep RUST
> >                   rust: [ on  ]  # HAVE_RUST_SUPPORT
> 
> I've noticed few more problem, maybe worth fixing it here as well:
> 
> * test-rust.bin is missing from the list of FILES, and thus is not removed by
> the clean target. This could lead to a false feature detection, since the
> binary stays there.
> 
> * Target to build test-rust.bin does not emit a dependencies file.
> 
> I've tested the following diff after first having rust installed, then removing
> it and building again.


I'll add it with your Signed-off-by, etc, please submit as a complete
patch next time :-)

- Arnaldo
 
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 9ae69d85716..28d4ff0841a 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -73,7 +73,8 @@ FILES=                                          \
>           test-clang-bpf-co-re.bin              \
>           test-file-handle.bin                  \
>           test-libpfm4.bin                      \
> -         test-libopenssl.bin
> +         test-libopenssl.bin                   \
> +         test-rust.bin
> 
>  FILES := $(addprefix $(OUTPUT),$(FILES))
> 
> @@ -112,7 +113,7 @@ __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(
>  __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
>    BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
> 
> -__BUILDRS = $(RUSTC) $(RUSTC_FLAGS) -o $@ $(patsubst %.bin,%.rs,$(@F))
> +__BUILDRS = $(RUSTC) $(RUSTC_FLAGS) --emit=dep-info=$(patsubst %.bin,%.d,$(@F)),link -o $@ $(patsubst %.bin,%.rs,$(@F))
>    BUILDRS = $(__BUILDRS) > $(@:.bin=.make.output) 2>&1
> 
> Reviewed-by: Dmitrii Dolgov <9erthalion6@gmail.com>
