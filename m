Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E9174059;
	Mon,  5 Aug 2024 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722886991; cv=none; b=tsNtUTxL4X3TfD6vHpHJQ3gOR7faAZUAqswWVJtK8waNzrvUWZCViQp3yV4gbHjmr8rhkNQVzric8hZBX9Axe4ufUa4A9D2MOUNO0CoOVp48DtrS9pcNWn/Cd6o3pIhJmIyaJN2MxP+Hvtl+tGxcEwDayvrdZnKxnyN315/4yME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722886991; c=relaxed/simple;
	bh=9kxu45W4NOMjXjizwz1ossXYabH0ZBPsANwum5jibNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8BnnjtMKYDhLmlE8kETNZzUFYQlXsqV3uBb6BSbQ5xLSz/tPttmrpcFZ9hHZMGxYKTc1lNUDo9DgCq6eUfqtjA/5kFOq6Tvo9fiv57sePdrCnFrdCzXyzEK40tKKA2SK2N4R1pp6pVujD3e+lqGog3km8G3Qfu3TPvgUmVKW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOj0Rhse; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOj0Rhse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F1DC32782;
	Mon,  5 Aug 2024 19:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722886990;
	bh=9kxu45W4NOMjXjizwz1ossXYabH0ZBPsANwum5jibNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOj0RhseAlJg879ekB1W8/q4mInH7Jw1lJfeyN4jIhw0dOK2z4TnN9of1BpixeWIZ
	 SSqR9IwxpXfBY4qOQJrxZvJmu0bzLbOUibyvbp5ETMz4SQhNxDocSTgSAQHlOWNjxn
	 +VttlLH0VmLYcKxtsAA86Mc7mucpEQtHglAaILgPujSqv1iHUWYUK48cvKivjPObUn
	 9n6b1ggthB9OQSB6Xi8qOMj3VOEIBw6ut4VQzUcyk3PLu/c7pCBgfH3v9RMRqEJ66f
	 G5ELlYTUogvgCwgQ5BfzQ+ibiouNRkUpEHFEg/ZBEyXrSJY10cgZP9wzuFyl49ngBG
	 bbyoiU3UlvJCg==
Date: Mon, 5 Aug 2024 16:43:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v18 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Message-ID: <ZrErSvqHMvzw3dm2@x1>
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <20240720062102.444578-4-weilin.wang@intel.com>
 <ZrEqr36sukDW66uV@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrEqr36sukDW66uV@x1>

On Mon, Aug 05, 2024 at 04:40:37PM -0300, Arnaldo Carvalho de Melo wrote:
> On Sat, Jul 20, 2024 at 02:20:56AM -0400, weilin.wang@intel.com wrote:
> > From: Weilin Wang <weilin.wang@intel.com>
> > 
> > When retire_latency value is used in a metric formula, evsel would fork a perf
> > record process with "-e" and "-W" options. Perf record will collect required
> > retire_latency values in parallel while perf stat is collecting counting values.
> > 
> > At the point of time that perf stat stops counting, evsel would stop perf record
> > by sending sigterm signal to perf record process. Sampled data will be process
> > to get retire latency value. Another thread is required to synchronize between
> > perf stat and perf record when we pass data through pipe.
> > 
> > Retire_latency evsel is not opened for perf stat so that there is no counter
> > wasted on it. This commit includes code suggested by Namhyung to adjust reading
> > size for groups that include retire_latency evsels.
> 
> Failing at this point:
> 
> ⬢[acme@toolbox perf-tools-next]$ git log --oneline -5
> 13430131acc4f88b (HEAD) perf stat: Fork and launch perf record when perf stat needs to get retire latency value for a metric.
> b7b9adefb5d57aaf perf data: Allow to use given fd in data->file.fd
> 3a442bf266d1f3c7 perf parse-events: Add a retirement latency modifier
> ce533c9bc6deb125 (perf-tools-next.korg/tmp.perf-tools-next, acme.korg/tmp.perf-tools-next) perf annotate: Add --skip-empty option
> bb588e38290fb723 perf annotate: Set al->data_nr using the notes->src->nr_events
> ⬢[acme@toolbox perf-tools-next]$
> 
> I'll see if when a followup patch gets applied this gets solved, if so
> will try to fixup things or ask for help, since this seems to be
> breaking 'git bisect' for this codebase.

Indeed, when the next patch gets applied it builds without problems.
I.e. patch  4/8 fixes problems in patch 3/8, maybe just combine them
into one single patch?

- Arnaldo
 
> ⬢[acme@toolbox perf-tools-next]$ m
> rm: cannot remove '/home/acme/libexec/perf-core/scripts/python/Perf-Trace-Util/lib/Perf/Trace/__pycache__/Core.cpython-312.pyc': Permission denied
> make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
>   BUILD:   Doing 'make -j2' parallel build
> Warning: Kernel ABI header differences:
>   diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
>   diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
>   diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
>   diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
>   diff -u tools/include/uapi/linux/stat.h include/uapi/linux/stat.h
>   diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
>   diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
>   diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
>   diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h
>   diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/uapi/asm/kvm.h
>   diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h
>   diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
>   diff -u tools/lib/list_sort.c lib/list_sort.c
>   diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
>   diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
>   diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
>   diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h
>   diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/linux/fs.h
>   diff -u tools/perf/trace/beauty/include/uapi/linux/mount.h include/uapi/linux/mount.h
>   diff -u tools/perf/trace/beauty/include/uapi/linux/stat.h include/uapi/linux/stat.h
>   diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/sound/asound.h
> git showMakefile.config:1223: libtracefs is missing. Please install libtracefs-dev/libtracefs-devel
> 
> Auto-detecting system features:
> ...                                   dwarf: [ on  ]
> ...                      dwarf_getlocations: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libbfd: [ on  ]
> ...                          libbfd-buildid: [ on  ]
> ...                                  libcap: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                                 libperl: [ on  ]
> ...                               libpython: [ on  ]
> ...                               libcrypto: [ on  ]
> ...                               libunwind: [ on  ]
> ...                      libdw-dwarf-unwind: [ on  ]
> ...                             libcapstone: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                               get_cpuid: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
> 
>   INSTALL libperf_headers
>   INSTALL libapi_headers
>   INSTALL libsubcmd_headers
>   INSTALL libsymbol_headers
>   PERF_VERSION = 6.11.rc1.g13430131acc4
>   CC      /tmp/build/perf-tools-next/perf-read-vdso32
>   INSTALL libbpf_headers
>   GEN     perf-archive
>   GEN     perf-iostat
>   CC      /tmp/build/perf-tools-next/util/evlist.o
>   CC      /tmp/build/perf-tools-next/builtin-stat.o
>   CC      /tmp/build/perf-tools-next/util/evsel.o
>   LD      /tmp/build/perf-tools-next/perf-in.o
>   LINK    /tmp/build/perf-tools-next/libperf-jvmti.so
>   CC      /tmp/build/perf-tools-next/util/header.o
> util/evsel.c: In function ‘evsel__group_has_tpebs’:
> util/evsel.c:1562:21: error: implicit declaration of function ‘evsel__is_retire_lat’ [-Werror=implicit-function-declaration]
>  1562 |                 if (evsel__is_retire_lat(evsel))
>       |                     ^~~~~~~~~~~~~~~~~~~~
> util/evsel.c: In function ‘evsel__open_cpu’:
> util/evsel.c:2258:24: error: implicit declaration of function ‘tpebs_start’ [-Werror=implicit-function-declaration]
>  2258 |                 return tpebs_start(evsel->evlist);
>       |                        ^~~~~~~~~~~
> util/evsel.c: In function ‘evsel__close’:
> util/evsel.c:2453:17: error: implicit declaration of function ‘tpebs_delete’; did you mean ‘timer_delete’? [-Werror=implicit-function-declaration]
>  2453 |                 tpebs_delete();
>       |                 ^~~~~~~~~~~~
>       |                 timer_delete
> cc1: all warnings being treated as errors
> make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: /tmp/build/perf-tools-next/util/evsel.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:158: util] Error 2
> make[2]: *** [Makefile.perf:787: /tmp/build/perf-tools-next/perf-util-in.o] Error 2
> make[1]: *** [Makefile.perf:290: sub-make] Error 2
> make: *** [Makefile:119: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> ⬢[acme@toolbox perf-tools-next]$
> 
