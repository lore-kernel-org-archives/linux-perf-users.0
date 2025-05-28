Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F3C7E9;
	Wed, 28 May 2025 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436467; cv=none; b=GXzDbCwy+eu5xJjYDMR2T/ubKxjYA7ilQGLHWnkj7gp2OFHhrWgk6ge+EAuxr3k2vKN+CmEnhoO7uOWbQUEbtbphT65xyN6wb0w6g1415FmQpUyCBlGBi9EOcFL7DBiXIW9CYUCb9Ri8hC4goeHnncZQuVdDi5wBMYTmZZDKY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436467; c=relaxed/simple;
	bh=5oEXoX22yAUoOjEnWSuham9SHeuLu8axVh5UAaxDY6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QovOesVhN7lmz+2biDe95t1atm25YmZPyodeF0qInGDnQ6k7AzKbcRM9zwNMyZVUietlIBRCtiAKRzU29Ym6CuTo7T8kcaDq2oK1xy4FSYYiAHZHhtoCwOGkVHRyKeUGXxBuTd6+eGrCRnQoGS1pT9mNJwmhdTkJ8K7e3pAo1us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnBd9OAr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnBd9OAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC2DC4CEE7;
	Wed, 28 May 2025 12:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748436466;
	bh=5oEXoX22yAUoOjEnWSuham9SHeuLu8axVh5UAaxDY6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MnBd9OArWVsMiwvVioDRZjfX1vjGGefk9ubxzWAbYwlc3ca97MP8cUdRgoASZuipd
	 sPPEB3XgzM2KbRr7cfT+lKKIXw4xOyJb+N5Ce9RC3LjGdMokyPOUzRnFEf1TIpyB9o
	 z9Ae/bbZSPZpCcmO14ddAp/Sdi60FWjG52Br6VhJweD2eFaXEEKl/RlhoDHQ+3DuNW
	 zV0nghLNOQXOEgJXc/kCEmv+szVhafPuC0+1w4qyV9PwPUSRvIbEUjbEQqN+mGZOk5
	 YJQYYGQaR3L2Tbusczn1fAYAg2RobXjb2nIetErWi2HVWh6oJ3kq5dQ0NDBdhrPmN+
	 PNUMJN3je8yqQ==
Date: Wed, 28 May 2025 09:47:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/6] perf symbol: Move demangling code out of
 symbol-elf.c
Message-ID: <aDcF7_pIU5M_XEAs@x1>
References: <20250527180703.129336-1-irogers@google.com>
 <20250527180703.129336-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250527180703.129336-4-irogers@google.com>

On Tue, May 27, 2025 at 11:07:00AM -0700, Ian Rogers wrote:
> symbol-elf.c is used when building with libelf, symbol-minimal is used
> otherwise. There is no reason the demangling code with no dependencies
> on libelf is part of symbol-elf.c so move to symbol.c. This allows
> demangling tests to pass with NO_LIBELF=1.

At this point:

⬢ [acme@toolbx perf-tools-next]$ alias m='rm -rf ~/libexec/perf-core/ ; make -k O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin && perf test python && cat /tmp/build/$(basename $PWD)/feature/test-all.make.output'
⬢ [acme@toolbx perf-tools-next]$ m
rm: cannot remove '/home/acme/libexec/perf-core/scripts/python/Perf-Trace-Util/lib/Perf/Trace/__pycache__/Core.cpython-313.pyc': Permission denied
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  INSTALL libsubcmd_headers
  INSTALL libperf_headers
  INSTALL libapi_headers
  INSTALL libsymbol_headers
  INSTALL libbpf_headers
  AR      /tmp/build/perf-tools-next/libpmu-events.a
  CC      /tmp/build/perf-tools-next/util/symbol-elf.o
util/symbol-elf.c: In function ‘get_plt_got_name’:
util/symbol-elf.c:563:21: error: implicit declaration of function ‘demangle_sym’; did you mean ‘dso__demangle_sym’? [-Wimplicit-function-declaration]
  563 |         demangled = demangle_sym(di->dso, 0, sym_name);
      |                     ^~~~~~~~~~~~
      |                     dso__demangle_sym
util/symbol-elf.c:563:19: error: assignment to ‘char *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  563 |         demangled = demangle_sym(di->dso, 0, sym_name);
      |                   ^
util/symbol-elf.c: In function ‘dso__synthesize_plt_symbols’:
util/symbol-elf.c:761:27: error: assignment to ‘char *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  761 |                 demangled = demangle_sym(dso, 0, elf_name);
      |                           ^
util/symbol-elf.c: In function ‘dso__load_sym_internal’:
util/symbol-elf.c:1778:27: error: assignment to ‘char *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
 1778 |                 demangled = demangle_sym(dso, kmodule, elf_name);
      |                           ^
make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:85: /tmp/build/perf-tools-next/util/symbol-elf.o] Error 1
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:142: util] Error 2
make[2]: *** [Makefile.perf:798: /tmp/build/perf-tools-next/perf-util-in.o] Error 2
make[1]: *** [Makefile.perf:290: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbx perf-tools-next]$

- Arnaldo
