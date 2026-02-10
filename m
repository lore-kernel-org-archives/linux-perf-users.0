Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A6C8F0;
	Tue, 10 Feb 2026 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726385; cv=none; b=L6H55dj8QDpKT08dE4Jz8cmzyEuEITdhhI1AJgFc/pDykuug8CYmT3ErCgDH068uhc4kOszFI1Wpi7dv0vD9TTDab3PPeBU+sCbEM6jk38xi877+AeEoM4DWdyUnd0b3CD+iVxGQtLcNFJRr4qD6ajX5S9mrgSae3CBzf3iI8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726385; c=relaxed/simple;
	bh=qhy3Ar9EHccDU0BuXQTVX+3MAOrWrFnb6sVxWbUYi4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvD7ZxZP5Es4gfxBXXYMTDW64N9a2CCyHVL7xtvxyiPUU0ynVv8ZEVNW6sK8ZOSNzx1KcmVN8yAUW99NVrWa/GRWFUfaTaIvwnloAu+MEcuPryMEKgeHyl4iELFyRRTA2ZzAttVJWFFMYh9fw4CuN7I4Q2pd7C5FSikesjw4+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHE1MgYm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHE1MgYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DE6C116C6;
	Tue, 10 Feb 2026 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770726385;
	bh=qhy3Ar9EHccDU0BuXQTVX+3MAOrWrFnb6sVxWbUYi4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHE1MgYmn9qUGLb2II9M836I8vrN1108hPD5DUdM9QfPmt4pUONl7Gw9fn53P4Tkv
	 frRoBZZtdvykRsbbuXzwSYAcWvUVYefFVSmBDVwp3AlUj1wm5j8LP04qUXKZsLOqLI
	 jKgHrVY00wn3bjQVCwEFxAADbROjHzB8KHi4cHJkdD98FWT5AOzU7y2C2WebooMHmk
	 3yrsCqirBwoiZqiyk1AepmLAkfwKJ3g/5pFdZeLodiWHm2SiMRsFnaJJN6pyNKAZOU
	 tF1SnNBprkTTBAODvyneEuyDGhdxJt2FhFQ/AzxyBKNB9IcJ3jdNM2pXYw8boF4LND
	 BtBQgXobP+1bA==
Date: Tue, 10 Feb 2026 09:26:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools build: Fix rust feature detection
Message-ID: <aYsj7vV2Lh8wV-ZR@x1>
References: <aYoZD1onJLsnlrV3@x1>
 <sc2w3tcjcle4zhz72b2jdnyfnhzl6atiecium2dwcmrlvn6syb@n573cdtyldne>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

I tried here building it with rust installed, it detected, ok, then I
removed and tried to rebuild, it still thinks rust is there:

⬢ [acme@toolbx perf-tools-next]$ rpm -qa | grep rust
p11-kit-trust-0.25.8-1.fc43.x86_64
rust-srpm-macros-28.4-1.fc43.noarch
⬢ [acme@toolbx perf-tools-next]$ m
make: Entering directory '/home/acme/git/linux/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                               libpython: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]
...                              libopenssl: [ on  ]
...                                    rust: [ on  ]

  INSTALL libsubcmd_headers
  INSTALL libapi_headers
  INSTALL libperf_headers
  INSTALL libsymbol_headers
  INSTALL libbpf_headers
  INSTALL binaries
  INSTALL tests
  INSTALL libperf-jvmti.so
  INSTALL libexec
  INSTALL perf-archive
  INSTALL perf-iostat
  INSTALL python-scripts
install: omitting directory 'scripts/python/Perf-Trace-Util/lib/Perf/Trace/__pycache__'
  INSTALL dlfilters
  INSTALL perf_completion-script
  INSTALL perf-tip
make: Leaving directory '/home/acme/git/linux/tools/perf'
⬢ [acme@toolbx perf-tools-next]$

⬢ [acme@toolbx perf-tools-next]$ perf -vv | grep rust
                  rust: [ on  ]  # HAVE_RUST_SUPPORT
⬢ [acme@toolbx perf-tools-next]$


I.e. it doesn't rebuild perf and thus doesn't notice that it doesn't
have what is needed, if I touch some other file and thus it triggers a
rebuild, it still manages to build it...

⬢ [acme@toolbx perf-tools-next]$ perf -vv | grep rust
                  rust: [ on  ]  # HAVE_RUST_SUPPORT
⬢ [acme@toolbx perf-tools-next]$

Trying:

⬢ [acme@toolbx perf-tools-next]$ readelf -wi /tmp/build/perf-tools-next/tests/workloads/code_with_type.a | grep -m1 producer
    <c>   DW_AT_producer    : (indirect string, offset: 0): clang LLVM (rustc version 1.93.0 (254b59607 2026-01-19) (Fedora 1.93.0-1.fc43))
⬢ [acme@toolbx perf-tools-next]$ rm -f /tmp/build/perf-tools-next/tests/workloads/code_with_type.a
⬢ [acme@toolbx perf-tools-next]$
  rustc  /tmp/build/perf-tools-next/tests/workloads/code_with_type.a
/bin/sh: line 1: rustc: command not found
make[5]: *** [/home/acme/git/linux/tools/build/Makefile.build:120: /tmp/build/perf-tools-next/tests/workloads/code_with_type.a] Error 127
make[4]: *** [/home/acme/git/linux/tools/build/Makefile.build:156: workloads] Error 2
make[3]: *** [/home/acme/git/linux/tools/build/Makefile.build:156: tests] Error 2
make[2]: *** [Makefile.perf:782: /tmp/build/perf-tools-next/perf-test-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:286: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/linux/tools/perf'
⬢ [acme@toolbx perf-tools-next]$

So there is still some dep missing...

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
