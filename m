Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF21917D0;
	Fri,  4 Apr 2025 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743798617; cv=none; b=KEc4mUCq8g9+1hqSDanstcBbfyXwP68calr6ubkOXQJXva0+OYe9kVf52ubIYtAWsZzAPOQ+fztiTjsZtcEzSysU1KteIUNLa3T1/x+ULfbgRQoeidFGpsiHe8G9R51hyFqiRemuGG0PWgjqM6rtC6Fh2XrSbaEXkdeKhwZqIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743798617; c=relaxed/simple;
	bh=kYwC0sMPhRfUgeVTelJ0ONIbL1zcdBd3+FA/XQA+Oqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfH9QD5VXKPDDik0fpmQR8ZpDaTYRA1CFfpekshWLw1xL9avca7kOEaMNU2uwOVZl3pZMabO9J1d4HZWQ5fYpp25B64rYor9n/s6Hp+cDMYyt2dkgAkCL8lMwmLdISS6PQrdZQQSGRzc6i5v0056wK2JTEZXwxR6wc1vFWXFhJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEgcGN40; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEgcGN40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605CBC4CEDD;
	Fri,  4 Apr 2025 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743798616;
	bh=kYwC0sMPhRfUgeVTelJ0ONIbL1zcdBd3+FA/XQA+Oqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEgcGN40Ia3PmMHmFVRXuggscU1dtop8KNBEGbEjNnkVHykH8+v2o7aRlqPfRmSfO
	 MnOJIm5Dk5iTyKLXFgttz0T6gGVyEbE6rwttS8LjmU9ceElJ178S9Sg+tDQyuJrAue
	 ic1uyqOIhilU6Cl2kX/nheqzq6ExMgr5yqeDVBpNkdtGulE42Mbh8He52GYz4svmFN
	 rLQG66PF+T8EWo97Fgxk1c8ZItFC5i3+HTX0kvL3dLzVycK0NGi+R/1adP5ivBfy8s
	 Ed+9W9n+DeP1lzYKbEayWwc4/ys9xESpbmnN97lcCUYH8dHE/m/jvVLar0Ax8TohFq
	 noZ/hmndOP0tQ==
Date: Fri, 4 Apr 2025 13:30:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Dmitry Vyukov <dvyukov@google.com>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools build: Don't set libunwind as available if
 test-all.c build succeeds
Message-ID: <Z_BBVgJ1nZB_0klZ@z2>
References: <Z_ArFrHU7hMNUOv3@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z_ArFrHU7hMNUOv3@x1>

On Fri, Apr 04, 2025 at 03:55:18PM -0300, Arnaldo Carvalho de Melo wrote:
> The tools/build/feature/test-all.c file tries to detect the expected,
> most common set of libraries/features we expect to have available to
> build perf with.
> 
> At some point libunwind was deemed not to be part of that set of
> libraries, but the patches making it to be opt-in ended up forgetting
> some details, fix one more.
> 
> Testing it:
> 
>   $ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
>   $ rpm -q libunwind-devel
>   libunwind-devel-1.8.0-3.fc40.x86_64
>   $ make -k LIBUNWIND=1 CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin |& grep unwind && ldd ~/bin/perf | grep unwind
>   ...                               libunwind: [ on  ]
>     CC      /tmp/build/perf-tools-next/arch/x86/tests/dwarf-unwind.o
>     CC      /tmp/build/perf-tools-next/arch/x86/util/unwind-libunwind.o
>     CC      /tmp/build/perf-tools-next/util/arm64-frame-pointer-unwind-support.o
>     CC      /tmp/build/perf-tools-next/tests/dwarf-unwind.o
>     CC      /tmp/build/perf-tools-next/util/unwind-libunwind-local.o
>     CC      /tmp/build/perf-tools-next/util/unwind-libunwind.o
> 	  libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007f615a549000)
> 	  libunwind.so.8 => /lib64/libunwind.so.8 (0x00007f615a52f000)
>   $ sudo rpm -e libunwind-devel
>   $ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
>   $ make -k LIBUNWIND=1 CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin |& grep unwind && ldd ~/bin/perf | grep unwind
>   Makefile.config:653: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
>   ...                               libunwind: [ OFF ]
>     CC      /tmp/build/perf-tools-next/arch/x86/tests/dwarf-unwind.o
>     CC      /tmp/build/perf-tools-next/arch/x86/util/unwind-libdw.o
>     CC      /tmp/build/perf-tools-next/util/arm64-frame-pointer-unwind-support.o
>     CC      /tmp/build/perf-tools-next/tests/dwarf-unwind.o
>     CC      /tmp/build/perf-tools-next/util/unwind-libdw.o
>   $
> 
> Should be in a separate patch, but tired now, so also adding a message
> about the need to use LIBUNWIND=1 in the output when its not available,
> so done here as well.
> 
> So, now when the devel files are not available we get:
> 
>   $ make -k LIBUNWIND=1 CORESIGHT=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin |& grep unwind && ldd ~/bin/perf | grep unwind
>   Makefile.config:653: No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR and set LIBUNWIND=1 in the make command line as it is opt-in now
>   ...                               libunwind: [ OFF ]
>   $
> 
> Fixes: 13e17c9ff49119aa ("perf build: Make libunwind opt-in rather than opt-out")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/lkml/Z_AnsW9oJzFbhIFC@x1
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/build/Makefile.feature | 1 -
>  tools/perf/Makefile.config   | 4 +++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 1931b6321314684c..54c8adfb94662c03 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -87,7 +87,6 @@ FEATURE_TESTS_BASIC :=                  \
>          libtracefs                      \
>          libcpupower                     \
>          libcrypto                       \
> -        libunwind                       \
>          pthread-attr-setaffinity-np     \
>          pthread-barrier     		\
>          reallocarray                    \
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index eea95c6c0c71f76e..8ff1d8ade73fc061 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -624,6 +624,8 @@ endif
>  ifndef NO_LIBUNWIND
>    have_libunwind :=
>  
> +  $(call feature_check,libunwind)
> +
>    $(call feature_check,libunwind-x86)
>    ifeq ($(feature-libunwind-x86), 1)
>      $(call detected,CONFIG_LIBUNWIND_X86)
> @@ -648,7 +650,7 @@ ifndef NO_LIBUNWIND
>    endif
>  
>    ifneq ($(feature-libunwind), 1)
> -    $(warning No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR)
> +    $(warning No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR and set LIBUNWIND=1 in the make command line as it is opt-in now)

I think this message is only visible if users already give LIBUNWIND=1.

Thanks,
Namhyung


>      NO_LOCAL_LIBUNWIND := 1
>    else
>      have_libunwind := 1
> -- 
> 2.48.1
> 
