Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA893375F83;
	Wed, 20 May 2026 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310199; cv=none; b=GfBHkc7fCu/tEdaErjBf1ZA8e/967RhhnF2YH7tS8MJCuqTyedSYO+wb8hfsi8RD9irTa03qOgqr0QlCoMrm9lJSd+ri5d7tTlCYv0s8KQR97aERgeMkmPUoKuIL2Rv6KSDnNLD7BfoELPKX/ldwl6ml9OeTvRs1ZWPAugoiYzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310199; c=relaxed/simple;
	bh=ysf2sbG6kuLyHn6D7Jdgni2VNZd7y0sDfb1UTcEqcKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIegRsL1jT+JJoObB3gT5Dkme9RDJtTs3ciomHnhxEL2lvkB6B7mXT6WY+t552hDxG9sDnWyI7GLmKW1fe4D6FB6cs0vZwXMxJC2pBa56VnMz1RUEbD5d3qmjHXlS4i0wTdMt59u11Huqs+iWB427tNF5obB4QGZ/3nEks0Z9OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLON8fGb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLON8fGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967041F00A39;
	Wed, 20 May 2026 20:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779310197;
	bh=ktsWymOQWGFfWZAA+LGvhw59MEaxAq1jsu8aXc5FBGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FLON8fGbcxzQPKky0c8WjYmkT7sECrBh/ofdJZ+Dxcu2yL2vbjaGAe7IMGFtgxNg+
	 M494T7wPgwOemLta8t08ArbtyI2oyaEwlorNpI60pl4D4bk++1TNGyyGWN1jdK7H2J
	 Wls974DIUDf7xoXoINyRBeNwr/nFoYghU8aYg1JEneMMwu7QjWjjeWqZTbaA6E3ySi
	 llgUq0eYSMA7KAUkgVeKiE27JT54g0Wil7S6QhjzUEu0ivFMYWEYMRoHYikWGxhW8c
	 uiKEEt6u5HcT5APvtTHmeK0OWhm0PgcHkbmJtCKhBC65LPtqBZVlKEv/VTjq/7aPJO
	 tEDnGDJS/cJTg==
Date: Wed, 20 May 2026 17:49:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v14 00/32] perf tools: Add evsel to perf_sample
Message-ID: <ag4ecqF1PZg_u4Op@x1>
References: <20260512223001.2952848-1-irogers@google.com>
 <20260520190538.142018-1-irogers@google.com>
 <ag4IT7YfVyFjggK6@x1>
 <ag4PpWl-wV7SDpd5@x1>
 <CAP-5=fU3HG9Mh3g+9JUCgkcE-DhmW66JSBnU5K=33kpcwhN0Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU3HG9Mh3g+9JUCgkcE-DhmW66JSBnU5K=33kpcwhN0Ug@mail.gmail.com>

On Wed, May 20, 2026 at 01:40:48PM -0700, Ian Rogers wrote:
> On Wed, May 20, 2026 at 12:46 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, May 20, 2026 at 04:15:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, May 20, 2026 at 12:05:06PM -0700, Ian Rogers wrote:
> > > > Nearly all perf code ends up passing an evsel with the perf_sample,
> > > > which is problematic if you want to rewrite the evsel (such as with
> > > > off-CPU processing) because all uses of the evsel need to be fixed
> > > > up. Since the perf_sample now carries its own resolved evsel pointer,
> > > > passing evsel separately is redundant and error-prone (allowing
> > > > parameter divergence bugs).
> > > >
> > > > This series cleans up the redundant evsel parameter across all perf
> > > > tool subcommands and APIs, ensuring that tools uniformly retrieve
> > > > event attributes directly from the sample itself. This simplifies
> > > > function signatures and improves API consistency.
> > > >
> > > > Additionally, this series incorporates subsequent memory safety
> > > > improvements, robust bounds checking, and memory leak corrections
> > > > prompted by address sanitizers and Sashiko code reviews.
> > > >
> > > > The original combined RFC patch:
> > > > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
> > > > was split up per reviewer requests.
> > > >
> > > > v14:
> > > >  - Incorporate Acked-by tags from Namhyung Kim.
> > > >  - Re-polish and expand commit descriptions to provide thorough explanations
> > > >    of the changes and their rationale.
> > >
> > > Thanks, tentatively applying it to perf-tools-next, for v7.2.
> >
> > Had to apply a minor fixup for a conflict with anoter patch series from
> > you, the LBR one.
> 
> Sorry for that and thanks for dealing with the conflict! Any chance
> you could push to tmp.perf-tools-next? I have some other series that
> will conflict and it would be nice to rebase those changes there.

I just removed the last two patches, the ones for kwork, as:

+ make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= NO_LIBELF=1 -C tools/perf O=/tmp/build/perf
make: Entering directory '/git/perf-7.1.0-rc2/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
Makefile.config:647: Warning: Disabled BPF skeletons as libelf is required by bpftool
Makefile.config:745: Disabling post unwind, no support found.
Makefile.config:856: Missing python setuptools, the python binding won't be built, please install python3-setuptools or equivalent
Makefile.config:1045: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1110: libpfm4 not found, disables libpfm4 support. Please install libpfm-devel or libpfm4-dev
Makefile.config:1135: Rust is not found. Test workloads with rust are disabled.

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
...                                    rust: [ OFF ]

  CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
<SNIP>
  LINK    /tmp/build/perf/perf
/usr/bin/ld: /tmp/build/perf/perf-in.o: in function `work_pop_atom':
builtin-kwork.c:(.text+0x59c92): undefined reference to `work_exit'
/usr/bin/ld: /tmp/build/perf/perf-in.o: in function `work_push_atom.constprop.0':
builtin-kwork.c:(.text+0x5aba8): undefined reference to `work_exit'
/usr/bin/ld: /tmp/build/perf/perf-in.o: in function `cmd_kwork':
(.text+0x5bb4b): undefined reference to `work_exit'
/usr/bin/ld: (.text+0x5bbae): undefined reference to `work_exit'
/usr/bin/ld: (.text+0x5c3b2): undefined reference to `work_exit'
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile.perf:586: /tmp/build/perf/perf] Error 1
make[1]: *** [Makefile.perf:289: sub-make] Error 2
make: *** [Makefile:76: all] Error 2
make: Leaving directory '/git/perf-7.1.0-rc2/tools/perf'
+ exit 1
toolsbuilder@five:~$


I'm doing some more tests, just a moment and I'll push what I have to
tmp.perf-tools-next.

- Arnaldo
