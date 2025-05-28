Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF9F21322F;
	Wed, 28 May 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436967; cv=none; b=Ms4fyhZFCH1+qlp0Hf7HOwHltBU5Bm12a/ug8pTE+kMZzgdn6nfzB52YwFckPZECMpgjf6OsTcGeK+J46GxAxyfz+EKB34DlmhrH2cm8dhiOAT9CB8j4iG2DbVERqd5RdDyGng/vybtbot0AzRKLooZyXZz/CJRzdAAf08V0lfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436967; c=relaxed/simple;
	bh=ZZ5PY3sUoQIO0CS2xr1nvj/M4VraGiH0oMZykVxMChc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SV+kecochVGJ6rL7pWs9+vNDsYxMtfGBpd/9J46XOWyQxdj9zRgho5gVf1vfqjg9EkdQpWhyyH+EawaWk50eXFzBBOSlQ6GlqPWEPEsKrKRDKbGh9BaHtYTHC1Q3/qDpbadew5kR4vMEGSU+FvbkOISHgvb67pXys+8cGm/8vOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgYYVKsy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgYYVKsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB204C4CEF1;
	Wed, 28 May 2025 12:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748436966;
	bh=ZZ5PY3sUoQIO0CS2xr1nvj/M4VraGiH0oMZykVxMChc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgYYVKsyNZvHVIcSC7TXODCukpomzDTeEa9qjbVoVFINev5ukW+0p44PEfIfeV9aU
	 aI+E4ZuO2djI+JCYHpfsJzhxKc0FxMEjFSQHW6+fc2UIhKQeJzwkdyCdaE20xO8iqE
	 qqgeZxHL3UVaSRP+zcxTOzVAXVOciQYGL0f0BbTRB8C1KYowXCFPFVxnr3xoKCAbsu
	 Uzx4OPLzAhY8qqtzFr88WC8At0pQ2CnUmsaaUw1VX1SgNiTFSxINa/n4w2zVi8q4La
	 nCTiTjeAesKkYswlBIoG6igD5YZWu90Y7SJcS+8tUb7Sjuc2A4BWyLC93kORGAngI7
	 eITH0kuA0V2Lw==
Date: Wed, 28 May 2025 09:56:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
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
	Weilin Wang <weilin.wang@intel.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] perf test trace_summary: Skip --bpf-summary tests
 if no libbpf
Message-ID: <aDcH40nLHuEXELjT@x1>
References: <20250528032637.198960-1-irogers@google.com>
 <20250528032637.198960-7-irogers@google.com>
 <CAH0uvoiEY0kkz09TavHG-KHqtk7UNHyRLfYC382D_yhvrstBGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvoiEY0kkz09TavHG-KHqtk7UNHyRLfYC382D_yhvrstBGw@mail.gmail.com>

On Tue, May 27, 2025 at 09:17:25PM -0700, Howard Chu wrote:
> Hello Ian,
> 
> On Tue, May 27, 2025 at 8:26 PM Ian Rogers <irogers@google.com> wrote:
> >
> > If perf is built without libbpf (e.g. NO_LIBBPF=1) then the
> > --bpf-summary perf trace tests will fail. Skip the tests as this is
> > expected behavior.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks, applied to perf-tools-next,

BTW, my answers were for v1 but b4 gets v2, for instance, the one that
is failing:

⬢ [acme@toolbx perf-tools-next]$ b4 am -P3 -ctsl --cc-trailers 20250527180703.129336-5-irogers@google.com
Grabbing thread from lore.kernel.org/all/20250527180703.129336-5-irogers@google.com/t.mbox.gz
Breaking thread to remove parents of 20250527180703.129336-1-irogers@google.com
Checking for newer revisions
Grabbing search results from lore.kernel.org
  Added from v2: 8 patches
Analyzing 21 messages in the thread
Analyzing 0 code-review messages
Will use the latest revision: v2
You can pick other revisions using the -vN flag
Unknown range value specified: 3
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v2 3/7] perf symbol: Move demangling code out of symbol-elf.c
    + Link: https://lore.kernel.org/r/20250528032637.198960-4-irogers@google.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ---
  ✓ Signed: DKIM/google.com
---
Total patches: 1 (cherrypicked: 3)
---
Cover: ./v2_20250527_irogers_various_asan_and_test_fixes.cover
 Link: https://lore.kernel.org/r/20250528032637.198960-1-irogers@google.com
 Base: not specified
       git am ./v2_20250527_irogers_various_asan_and_test_fixes.mbx
⬢ [acme@toolbx perf-tools-next]$ 

⬢ [acme@toolbx perf-tools-next]$        git am ./v2_20250527_irogers_various_asan_and_test_fixes.mbx
Applying: perf symbol: Move demangling code out of symbol-elf.c
⬢ [acme@toolbx perf-tools-next]$

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
  PERF_VERSION = 6.15.rc7.g50ec05a72bc1
  LINK    /tmp/build/perf-tools-next/libperf-jvmti.so
  INSTALL libbpf_headers
  GEN     perf-archive
  GEN     perf-iostat
  CC      /tmp/build/perf-tools-next/util/symbol.o
  CC      /tmp/build/perf-tools-next/util/header.o
  CC      /tmp/build/perf-tools-next/util/symbol-elf.o
  CXX     /tmp/build/perf-tools-next/util/demangle-cxx.o
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
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:142: util] Error 2
make[2]: *** [Makefile.perf:798: /tmp/build/perf-tools-next/perf-util-in.o] Error 2
make[1]: *** [Makefile.perf:290: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbx perf-tools-next]$

I can try fixing those up, but I'm concentrated now in getting as much
low hanging fruits as possible for this merge, and the patches in this
series were mostly super small and fixed things.

- Arnaldo
