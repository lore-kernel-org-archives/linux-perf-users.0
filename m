Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D5E3BB9ED;
	Wed,  9 Sep 2026 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984184; cv=none; b=GgbRQLuB+m0TPEtmIsktnQR/frmfOVxAJ+boZCpSqwNV70mqvct4cGhX2H92z9NwyRQvcI9tZAQeGvvwc3sCPX88H/6+NAR3u5Wv98jMwRYw0RRipDo7tEZAvsI7vB4Yfih1o7SSBauiLCpk2yhXZmA2Qt7ElUfMjvgEPQgofTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984184; c=relaxed/simple;
	bh=gUzyQMmrz8MX1axytfdlZw5lmeTUBYH++VJHD63tCFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUTy1D0pVBbsU3d1a87HhRhhfjxefmuLSc8FMyZC+cYLeLbo+QMt7nj/5tt4GuMTTa2ijSgpq69ywZLKnw2pT2h6Y9Pfy2weSsr+7ciQFkErn7zjXbOIpljv+sZ7dpRyPPbnjjVqfx/BfSKyqnHf8qL3bJeYo0pJbM28KH2jS/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czurnMUr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czurnMUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0488D1F000FF;
	Wed,  9 Sep 2026 20:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788984182;
	bh=VVudfO1LfG/tIUM8pjA+57c3uLYPzlgjVl4h9kE11Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=czurnMUrvfPxRjg729VF+A9M6BQhgi6pMUfvrQrc2cHaDtwYu4lBdulJteczSWQE1
	 BLHftNTVvtN51bj/GubheNF5oUtp1ns6rcCntBWFp1+c43cuCEHGhrWXe4V//OYc4Y
	 ohF7hqwFs1YQKirqhF/0MmC639X6nV3ftG5R3uzIz+lHh7ciTRbYzJysa9DGfwdkPV
	 1pBZOYj+Sq87B6GUWkn6d8K+B0IoFC6k+8bBToDCXNt2OzO/cKBhsXhIwgJ+mTbdIa
	 afkBAcQSn6QLEiSp+kf1XGv0R5A72fpUvfQ5YYmA77KmFE7amG/v9f5jW4ObFosnvJ
	 rklLPjAUHy+4Q==
Date: Wed, 9 Sep 2026 17:02:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8 0/3] perf tools: port UI from GTK2 to GTK4
Message-ID: <aqG7c7RkOoaxMo1w@x2>
References: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
 <aqE_QOp-x1aOQsCX@x2>
 <aqFCMfb94Cdumemm@x2>
 <aqFDLQ5Yu7yg6Y2Z@x2>
 <aqFEdSZ40HkvipUr@x2>
 <aqFGVejYb-kZ8o_I@x2>
 <aqFIkFzVvCQqnzpy@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqFIkFzVvCQqnzpy@x2>

On Wed, Sep 09, 2026 at 08:52:48AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Sep 09, 2026 at 08:43:20AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Sep 09, 2026 at 08:35:20AM -0300, Arnaldo Carvalho de Melo wrote:
> > Now, with GTK4=1 and trying to build the first patch after installing
> > gtk4-devel on fedora 43 it fails to detect gtk4 support:
> > 
> > ⬢ [acme@toolbx perf-tools-next]$ m
> > make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> >   BUILD:   Doing 'make -j32' parallel build
> > 
> > Auto-detecting system features:
> > ...                                   libdw: [ on  ]
> > ...                                   glibc: [ on  ]
> > ...                                    gtk4: [ OFF ]


I removed gtk4 from FEATURES_DISPLAY, as it is opt-in, no point in
telling most of the time it is OFF, when developing one can use 'make
VF=1' to see if it was detected:

⬢ [acme@toolbx perf-tools-next]$ alias m='rm -rf ~/libexec/perf-core/ ; make VF=1 CORESIGHT=1 -k O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin && perf test import && cat /tmp/build/$(basename $PWD)/feature/test-all.make.output' ; export PYTHONPATH=/tmp/build/$(basename $PWD)/python
⬢ [acme@toolbx perf-tools-next]$ m
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j32' parallel build

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
...                               backtrace: [ on  ]
...                                 eventfd: [ on  ]
...                          fortify-source: [ on  ]
...                                  gettid: [ on  ]
...                                  libbfd: [ on  ]
...                       libbfd-threadsafe: [ on  ]
...                       libelf-getphdrnum: [ on  ]
...                     libelf-gelf_getnote: [ on  ]
...                    libelf-getshdrstrndx: [ on  ]
...                             libelf-zstd: [ on  ]
...                                libslang: [ on  ]
...                           libtraceevent: [ on  ]
...                             libcpupower: [ on  ]
...             pthread-attr-setaffinity-np: [ on  ]
...                         pthread-barrier: [ on  ]
...                            reallocarray: [ on  ]
...                      stackprotector-all: [ on  ]
...                                 timerfd: [ on  ]
...                               scandirat: [ on  ]
...                            sched_getcpu: [ on  ]
...                                     sdt: [ on  ]
...                                   setns: [ on  ]
...                  disassembler-four-args: [ on  ]
...                disassembler-init-styled: [ on  ]
...                             file-handle: [ on  ]
...                                  bionic: [ OFF ]
...                              compile-32: [ OFF ]
...                             compile-x32: [ OFF ]
...                          cplus-demangle: [ OFF ]
...                            cxa-demangle: [ on  ]
...                                    gtk4: [ OFF ]
...                                   hello: [ OFF ]
...                  babeltrace2-ctf-writer: [ on  ]
...                             libcapstone: [ on  ]
...                                libcheck: [ OFF ]
...                          libbfd-liberty: [ OFF ]
...                        libbfd-liberty-z: [ OFF ]
...                              libopencsd: [ on  ]
...                                 libperl: [ OFF ]
...                                    llvm: [ OFF ]
...                                  libbpf: [ OFF ]
...                                 libpfm4: [ on  ]
...                           libdebuginfod: [ on  ]
...                         clang-bpf-co-re: [ on  ]
...                       bpftool-skeletons: [ OFF ]
...                               libunwind: [ OFF ]
...                   libunwind-debug-frame: [ OFF ]
...                       libunwind-aarch64: [ OFF ]
...           libunwind-debug-frame-aarch64: [ OFF ]
...                           libunwind-arm: [ OFF ]
...               libunwind-debug-frame-arm: [ OFF ]
...                   libunwind-loongarch64: [ OFF ]
...       libunwind-debug-frame-loongarch64: [ OFF ]
...                          libunwind-mips: [ OFF ]
...              libunwind-debug-frame-mips: [ OFF ]
...                         libunwind-ppc32: [ OFF ]
...             libunwind-debug-frame-ppc32: [ OFF ]
...                         libunwind-ppc64: [ OFF ]
...             libunwind-debug-frame-ppc64: [ OFF ]
...                         libunwind-riscv: [ OFF ]
...             libunwind-debug-frame-riscv: [ OFF ]
...                         libunwind-s390x: [ OFF ]
...             libunwind-debug-frame-s390x: [ OFF ]
...                           libunwind-x86: [ OFF ]
...               libunwind-debug-frame-x86: [ OFF ]
...                        libunwind-x86_64: [ OFF ]
...            libunwind-debug-frame-x86_64: [ OFF ]
...                                  prefix: /home/acme
...                                  bindir: /home/acme/bin
...                                  libdir: /home/acme/lib64
...                              sysconfdir: /home/acme/etc
...                           LIBUNWIND_DIR:
...                               LIBDW_DIR:
...                                    JDIR: /usr/lib/jvm/java-latest-openjdk
...               DWARF post unwind library: libdw


- Arnaldo
