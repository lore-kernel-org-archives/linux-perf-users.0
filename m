Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037353;
	b=SsIyhyn9uVlK1/hgpl9ApKdLjLmGOyGEAfJ7iLfx+UhVpvPCiNyuMfvhh5qz/MmYzArZ
	 /fSIUs8LIWxZMRGeX11E7ZGMBcyoEs8fnJbSPbB4N4LMPLwMn27K8NT178qWIq3G9pHOw
	 ym7T6t0xqPabhLUaDaqIi9Wza3NvN3cfFd+EXoZyqqLA5LFovWRSf76PSy4jkgr55VjRS
	 4is3FD4G33QSIpURhgy7C8bpNResu+5Q2zKG61nixiYiVyQn3Rq1r093LNn2d+e1RpxHf
	 TVdYEnHXLyLbg8IaX0BLFWNp1FWL/UZRM6Njz48OFJzeZ2cF+fhvvnnTKGYSIX7dClw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037353;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=WX5YhiznwPCEi3OzGHYcwCMVEruX12KVOIdIYTpegOs=;
	b=SZMKbrmh4JASCsM2vWz4N/L6AIewFlf9ufSxQYjz31l07qxbFpjX/7RIgzdAsvqCAV8Z
	 hiv71vwMxVCvgqFZyVB0Hc/4e+vIBvtQwS2ZO0lKRx3QHQkITJzIbVUkFG4KAUnG+xvFs
	 1MfsCURIlM0yhsgKzUfjDUWlMeDEsH4EzL84l1NVHDv8FW1e+d6kxtsHVwByJ/TY2I9Q0
	 yClzasIjhADLkTYlB03bgkqkz0+VMCLwSOjyrbpc6KFFOSrz94VJuyU4DIGR/GM3obaxs
	 0T06Z5N8cuEjYLlrmdH2vpzWH9GjJUqbEhNppqFzxzEgQgieNgHBTo9p3IsbEJYBMUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3itXSiV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140E60A2630;
	Wed, 18 Nov 2026 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3itXSiV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9DC1F000C4;
	Wed, 18 Nov 2026 21:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795037352;
	bh=WX5YhiznwPCEi3OzGHYcwCMVEruX12KVOIdIYTpegOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y3itXSiV8b95hxb1EybQ8YHSWager1mQyUSaXq/dAE3jrS+PRqkxPJYjJ+2tCohm2
	 c/m4eLf5+KQ8ukFmRPxLiOanrtIZiMawZQBli1pDuNs5i+lYy5KSZNv9E8oWRYk0yF
	 FFOBzj4vhFTeY7y3UhAnJwAxXQS4DmixwOxXinO9y9kTloU+mO/Oq6YAxs/jqgFYuo
	 8uNKuzJp8Ol1lp2rTzQUJjBwzeXSNS4P79j3MEIEEiQJGZ4hi3uKxy9EZLVaHOAwNr
	 YqnexFqOajU9zZr/rIOYFIViABh3LMIfZW4tmF8+txjT/C1ftMOIqq93MWgaOJaIm1
	 jRrLSP1g9zvrg==
Date: Wed, 18 Nov 2026 18:29:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v6 02/13] perf scripts: Add a coverage harness for perf
Message-ID: <av4YpP2qyUGN5KJM@phoenix2>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-3-acme@kernel.org>
 <av1MO74yqgr2OJt7@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <av1MO74yqgr2OJt7@google.com>

On Tue, Nov 17, 2026 at 10:56:59PM -0800, Namhyung Kim wrote:
> On Tue, Nov 17, 2026 at 05:04:20PM -0300, Arnaldo Carvalho de Melo wrote:
> > Build perf with clang source based coverage, run the complete perf test
> > suite, merge the raw profiles and report line and function coverage,
> > optionally against a baseline.  This is pahole's coverage/coverage.sh +
> > coverage-diff.sh merged into one script, wired as
> > 'make -C tools/perf coverage' and listed in 'make help'.

> > Without -f the report lists the files with the most uncovered lines,
> > which is where new tests should try to get more coverage; -t narrows
> > the tests, -f focuses on specific files, --html writes a browsable
> > report and --table/-T, also available as 'make -C tools/perf
> > coverage-table', prints the last run as an ASCII table with the
> > per-file line and function coverage, like pahole's coverage_table.py.
 
> It'd be nice if you could list all options.
 
> > The build can be split from the test run: 'make -C tools/perf
> > coverage-prep' builds the instrumented perf and records the build
> > directory, and a later run as root, which needs no make, checks that
 
> Ok, so IIUC it's optional and just running 'make coverage' would all
> necessary jobs one stop, right?
 
> > build, runs the tests and renders the report, or prints the table with
> > --table.  This is for running the tests that need root on the bare
> > metal host while the instrumented perf is built in the development
> > container.
> 
> What is the table?

In v7, as I changed the default:

⬢ [acme@toolbx perf-tools-next]$ make -C tools/perf coverage-table
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
tools/perf (no tests/ or bench/), 100+ executable lines:
the 20 biggest uncovered gaps, start here when adding coverage tests.
--all for every file: make -C tools/perf coverage-table COVERAGE_ARGS="--all"

┌──────────────────────────────────────────┬────────┬────────┬────────┬─────────────────────────────┬─────────────┬──────────┐
│ File                                     │  Lines │    Hit │   Miss │        Line Coverage        │       Funcs │  FuncCov │
├──────────────────────────────────────────┼────────┼────────┼────────┼─────────────────────────────┼─────────────┼──────────┤
│ ui/browsers/hists.c                      │   2730 │      0 │   2730 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/124   │    0.00% │
│ builtin-sched.c                          │   3737 │   1542 │   2195 │ ████████░░░░░░░░░░░░  41.3% │    62/141   │   43.97% │
│ builtin-script.c                         │   3212 │   1118 │   2094 │ ██████░░░░░░░░░░░░░░  34.8% │    51/124   │   41.13% │
│ util/intel-pt-decoder/intel-pt-decoder.c │   3208 │   1201 │   2007 │ ███████░░░░░░░░░░░░░  37.4% │    70/119   │   58.82% │
│ util/intel-pt.c                          │   3237 │   1426 │   1811 │ ████████░░░░░░░░░░░░  44.0% │    79/142   │   55.63% │
│ util/python.c                            │   2984 │   1301 │   1683 │ ████████░░░░░░░░░░░░  43.6% │   128/224   │   57.14% │
│ util/sort.c                              │   2421 │    861 │   1560 │ ███████░░░░░░░░░░░░░  35.6% │    83/246   │   33.74% │
│ util/session.c                           │   2686 │   1204 │   1482 │ ████████░░░░░░░░░░░░  44.8% │    65/125   │   52.00% │
│ util/annotate.c                          │   2245 │    866 │   1379 │ ███████░░░░░░░░░░░░░  38.6% │    60/118   │   50.85% │
│ builtin-kmem.c                           │   1337 │      0 │   1337 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/70    │    0.00% │
│ util/arm-spe.c                           │   1330 │      0 │   1330 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/50    │    0.00% │
│ builtin-kvm.c                            │   1316 │      0 │   1316 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/90    │    0.00% │
│ util/header.c                            │   3941 │   2662 │   1279 │ █████████████░░░░░░░  67.6% │   159/180   │   88.33% │
│ util/evsel.c                             │   3326 │   2067 │   1259 │ ████████████░░░░░░░░  62.2% │   128/155   │   82.58% │
│ builtin-record.c                         │   2737 │   1501 │   1236 │ ██████████░░░░░░░░░░  54.8% │    84/120   │   70.00% │
│ util/probe-event.c                       │   2765 │   1554 │   1211 │ ███████████░░░░░░░░░  56.2% │    81/103   │   78.64% │
│ builtin-trace.c                          │   3657 │   2451 │   1206 │ █████████████░░░░░░░  67.0% │   154/198   │   77.78% │
│ builtin-inject.c                         │   2023 │    890 │   1133 │ ████████░░░░░░░░░░░░  44.0% │    37/94    │   39.36% │
│ builtin-c2c.c                            │   2027 │   1018 │   1009 │ ██████████░░░░░░░░░░  50.2% │    58/156   │   37.18% │
│ util/auxtrace.c                          │   2013 │   1009 │   1004 │ ██████████░░░░░░░░░░  50.1% │    81/126   │   64.29% │
├──────────────────────────────────────────┼────────┼────────┼────────┼─────────────────────────────┼─────────────┼──────────┤
│ TOTAL (perf)                             │ 173244 │  91059 │  82185 │ ██████████░░░░░░░░░░  52.6% │  5868/9306  │   63.06% │
└──────────────────────────────────────────┴────────┴────────┴────────┴─────────────────────────────┴─────────────┴──────────┘
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbx perf-tools-next]$

The idea with the default is to point to where to work on writing tests
to make sure that we test as much as possible of the codebase.

Instead of doing it unconditionally and showing _all_ of perf, as below.

In my still unpublished local test setup this is run in a lot of distro
containers and in several architectures that then gets combined to have
a more comprehensive view of what is being tested in perf.

- Arnaldo

⬢ [acme@toolbx perf-tools-next]$ make -C tools/perf coverage-table COVERAGE_ARGS="--all"
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
every tools/perf file, tests and benches included, most covered first.

┌───────────────────────────────────────────────┬────────┬────────┬────────┬─────────────────────────────┬─────────────┬──────────┐
│ File                                          │  Lines │    Hit │   Miss │        Line Coverage        │       Funcs │  FuncCov │
├───────────────────────────────────────────────┼────────┼────────┼────────┼─────────────────────────────┼─────────────┼──────────┤
│ arch/x86/util/cpuid.h                         │      9 │      9 │      0 │ ████████████████████ 100.0% │     1/1     │  100.00% │
│ builtin-version.c                             │     12 │     12 │      0 │ ████████████████████ 100.0% │     2/2     │  100.00% │
│ tests/bitmap.c                                │     33 │     33 │      0 │ ████████████████████ 100.0% │     3/3     │  100.00% │
│ tests/event_update.c                          │     63 │     63 │      0 │ ████████████████████ 100.0% │     5/5     │  100.00% │
│ tests/kmod-path.c                             │    112 │    112 │      0 │ ████████████████████ 100.0% │     3/3     │  100.00% │
│ tests/mem.c                                   │     34 │     34 │      0 │ ████████████████████ 100.0% │     2/2     │  100.00% │
│ tests/pe-file-parsing.c                       │      4 │      4 │      0 │ ████████████████████ 100.0% │     1/1     │  100.00% │
│ tests/subcmd-help.c                           │     79 │     79 │      0 │ ████████████████████ 100.0% │     4/4     │  100.00% │
│ tests/thread-map.c                            │     86 │     86 │      0 │ ████████████████████ 100.0% │     4/4     │  100.00% │
│ tests/thread-maps-share.c                     │     47 │     47 │      0 │ ████████████████████ 100.0% │     1/1     │  100.00% │
│ tests/util.c                                  │     49 │     49 │      0 │ ████████████████████ 100.0% │     4/4     │  100.00% │
│ tests/workloads/datasym.c                     │     19 │     19 │      0 │ ████████████████████ 100.0% │     2/2     │  100.00% │
│ tests/workloads/global_data.c                 │     21 │     21 │      0 │ ████████████████████ 100.0% │     2/2     │  100.00% │
│ tests/workloads/inlineloop.c                  │     26 │     26 │      0 │ ████████████████████ 100.0% │     5/5     │  100.00% │
│ tests/workloads/landlock.c                    │     16 │     16 │      0 │ ████████████████████ 100.0% │     1/1     │  100.00% │
│ tests/workloads/regptr.c                      │     24 │     24 │      0 │ ████████████████████ 100.0% │     3/3     │  100.00% │
│ trace/beauty/arch_prctl.c                     │      7 │      7 │      0 │ ████████████████████ 100.0% │     2/2     │  100.00% │
│ trace/beauty/renameat.c                       │      9 │      9 │      0 │ ████████████████████ 100.0% │     2/2     │  100.00% │
│ util/blake2s.c                                │    102 │    102 │      0 │ ████████████████████ 100.0% │     8/8     │  100.00% │
│ util/build-id.h                               │      3 │      3 │      0 │ ████████████████████ 100.0% │     1/1     │  100.00% │
│ util/c2c.c                                    │      9 │      9 │      0 │ ████████████████████ 100.0% │     2/2     │  100.00% │
│ util/cacheline.c                              │      6 │      6 │      0 │ ████████████████████ 100.0% │     1/1     │  100.00% │
│ util/counts.h                                 │      9 │      9 │      0 │ ████████████████████ 100.0% │     3/3     │  100.00% │
│ util/cpumap.h                                 │      3 │      3 │      0 │ ████████████████████ 100.0% │     1/1     │  100.00% │
│ util/data.h                                   │     21 │     21 │      0 │ ████████████████████ 100.0% │     7/7     │  100.00% │
│ util/dlfilter.h                               │     10 │     10 │      0 │ ████████████████████ 100.0% │     2/2     │  100.00% │
│ util/dwarf-aux.h                              │      3 │      3 │      0 │ ████████████████████ 100.0% │     1/1     │  100.00% │
│ util/event.h                                  │     16 │     16 │      0 │ ████████████████████ 100.0% │     5/5     │  100.00% │
│ util/fncache.c                                │     34 │     34 │      0 │ ████████████████████ 100.0% │     7/7     │  100.00% │
│ util/perf-hooks.h                             │      4 │      4 │      0 │ ████████████████████ 100.0% │     1/1     │  100.00% │
│ util/rblist.h                                 │      6 │      6 │      0 │ ████████████████████ 100.0% │     2/2     │  100.00% │
│ util/record.h                                 │      3 │      3 │      0 │ ████████████████████ 100.0% │     1/1     │  100.00% │
│ util/rwsem.c                                  │     23 │     23 │      0 │ ████████████████████ 100.0% │     6/6     │  100.00% │
│ util/session.h                                │      9 │      9 │      0 │ ████████████████████ 100.0% │     3/3     │  100.00% │
│ util/stat.h                                   │      7 │      7 │      0 │ ████████████████████ 100.0% │     1/1     │  100.00% │
│ util/trace-event.h                            │      3 │      3 │      0 │ ████████████████████ 100.0% │     1/1     │  100.00% │
│ util/vdso.h                                   │      3 │      3 │      0 │ ████████████████████ 100.0% │     1/1     │  100.00% │
│ tests/pfm.c                                   │    142 │    140 │      2 │ ███████████████████░  98.6% │     3/3     │  100.00% │
│ tests/stat.c                                  │     69 │     68 │      1 │ ███████████████████░  98.6% │     7/7     │  100.00% │
│ trace/beauty/mode_t.c                         │     42 │     41 │      1 │ ███████████████████░  97.6% │     1/1     │  100.00% │
│ util/print_binary.c                           │     39 │     38 │      1 │ ███████████████████░  97.4% │     2/2     │  100.00% │
│ arch/x86/util/topdown.c                       │     38 │     37 │      1 │ ███████████████████░  97.4% │     4/4     │  100.00% │
│ util/demangle-ocaml.c                         │     33 │     32 │      1 │ ███████████████████░  97.0% │     2/2     │  100.00% │
│ util/mem2node.c                               │     87 │     84 │      3 │ ███████████████████░  96.6% │     5/5     │  100.00% │
│ tests/parse-metric.c                          │    193 │    186 │      7 │ ███████████████████░  96.4% │    14/14    │  100.00% │
│ tests/hybrid-merge.c                          │    120 │    115 │      5 │ ███████████████████░  95.8% │     8/8     │  100.00% │
│ tests/unit_number__scnprintf.c                │     24 │     23 │      1 │ ███████████████████░  95.8% │     1/1     │  100.00% │
│ tests/workloads/brstack.c                     │     23 │     22 │      1 │ ███████████████████░  95.7% │     4/4     │  100.00% │
│ tests/workloads/flex_array.c                  │     23 │     22 │      1 │ ███████████████████░  95.7% │     2/2     │  100.00% │
│ tests/dso-data.c                              │    202 │    193 │      9 │ ███████████████████░  95.5% │    10/10    │  100.00% │
│ tests/mem2node.c                              │     44 │     42 │      2 │ ███████████████████░  95.4% │     2/2     │  100.00% │
│ trace/beauty/clone.c                          │     22 │     21 │      1 │ ███████████████████░  95.4% │     2/2     │  100.00% │
│ tests/expr.c                                  │    218 │    208 │     10 │ ███████████████████░  95.4% │     3/3     │  100.00% │
│ arch/x86/util/header.c                        │     42 │     40 │      2 │ ███████████████████░  95.2% │     3/3     │  100.00% │
│ util/map.h                                    │    123 │    117 │      6 │ ███████████████████░  95.1% │    33/34    │   97.06% │
│ util/machine.h                                │     40 │     38 │      2 │ ███████████████████░  95.0% │    10/10    │  100.00% │
│ util/mem-info.h                               │     19 │     18 │      1 │ ██████████████████░░  94.7% │     6/6     │  100.00% │
│ util/call-path.c                              │     71 │     67 │      4 │ ██████████████████░░  94.4% │     5/5     │  100.00% │
│ trace/beauty/waitid_options.c                 │     17 │     16 │      1 │ ██████████████████░░  94.1% │     1/1     │  100.00% │
│ util/strbuf.h                                 │     17 │     16 │      1 │ ██████████████████░░  94.1% │     3/3     │  100.00% │
│ tests/hists_cumulate.c                        │    387 │    364 │     23 │ ██████████████████░░  94.1% │     9/9     │  100.00% │
│ util/print-events.c                           │    218 │    205 │     13 │ ██████████████████░░  94.0% │     9/9     │  100.00% │
│ tests/cpumap.c                                │    183 │    172 │     11 │ ██████████████████░░  94.0% │    11/11    │  100.00% │
│ trace/beauty/open_flags.c                     │     49 │     46 │      3 │ ██████████████████░░  93.9% │     2/2     │  100.00% │
│ tests/event_groups.c                          │     80 │     75 │      5 │ ██████████████████░░  93.8% │     4/4     │  100.00% │
│ util/comm.c                                   │    151 │    141 │     10 │ ██████████████████░░  93.4% │    15/15    │  100.00% │
│ util/color.c                                  │     91 │     84 │      7 │ ██████████████████░░  92.3% │    11/11    │  100.00% │
│ util/perf-hooks.c                             │     38 │     35 │      3 │ ██████████████████░░  92.1% │     4/4     │  100.00% │
│ tests/parse-events.c                          │   1733 │   1596 │    137 │ ██████████████████░░  92.1% │    93/97    │   95.88% │
│ tests/hists_output.c                          │    399 │    367 │     32 │ ██████████████████░░  92.0% │     9/9     │  100.00% │
│ util/dsos.c                                   │    306 │    281 │     25 │ ██████████████████░░  91.8% │    28/30    │   93.33% │
│ tests/topology.c                              │    142 │    130 │     12 │ ██████████████████░░  91.6% │     4/4     │  100.00% │
│ util/parse-events.h                           │     11 │     10 │      1 │ ██████████████████░░  90.9% │     2/2     │  100.00% │
│ util/namespaces.c                             │    237 │    214 │     23 │ ██████████████████░░  90.3% │    24/25    │   96.00% │
│ util/tsc.c                                    │     91 │     82 │      9 │ ██████████████████░░  90.1% │     6/6     │  100.00% │
│ util/stat-shadow.c                            │    223 │    200 │     23 │ █████████████████░░░  89.7% │     8/8     │  100.00% │
│ util/pfm.c                                    │    221 │    198 │     23 │ █████████████████░░░  89.6% │     6/6     │  100.00% │
│ tests/thread-stack.c                          │     67 │     60 │      7 │ █████████████████░░░  89.6% │     3/3     │  100.00% │
│ util/intel-pt-decoder/intel-pt-pkt-decoder.c  │    583 │    522 │     61 │ █████████████████░░░  89.5% │    37/37    │  100.00% │
│ tests/workloads/code_with_type.c              │     19 │     17 │      2 │ █████████████████░░░  89.5% │     2/2     │  100.00% │
│ tests/maps.c                                  │    181 │    161 │     20 │ █████████████████░░░  88.9% │     4/5     │   80.00% │
│ tests/is_printable_array.c                    │     27 │     24 │      3 │ █████████████████░░░  88.9% │     1/1     │  100.00% │
│ util/ordered-events.c                         │    267 │    237 │     30 │ █████████████████░░░  88.8% │    18/18    │  100.00% │
│ util/evlist.h                                 │    151 │    134 │     17 │ █████████████████░░░  88.7% │    45/49    │   91.84% │
│ trace/beauty/syscalltbl.c                     │     71 │     63 │      8 │ █████████████████░░░  88.7% │     8/8     │  100.00% │
│ util/threads.c                                │    149 │    132 │     17 │ █████████████████░░░  88.6% │    13/14    │   92.86% │
│ util/affinity.c                               │     52 │     46 │      6 │ █████████████████░░░  88.5% │     6/6     │  100.00% │
│ tests/keep-tracking.c                         │     86 │     76 │     10 │ █████████████████░░░  88.4% │     2/2     │  100.00% │
│ tests/mmap-thread-lookup.c                    │    119 │    105 │     14 │ █████████████████░░░  88.2% │     9/9     │  100.00% │
│ util/pmus.c                                   │    604 │    532 │     72 │ █████████████████░░░  88.1% │    31/34    │   91.18% │
│ util/tp_pmu.c                                 │    149 │    131 │     18 │ █████████████████░░░  87.9% │    11/11    │  100.00% │
│ util/callchain.h                              │     41 │     36 │      5 │ █████████████████░░░  87.8% │     8/8     │  100.00% │
│ arch/x86/tests/hybrid.c                       │    180 │    158 │     22 │ █████████████████░░░  87.8% │    16/17    │   94.12% │
│ util/bpf-trace-summary.c                      │    290 │    254 │     36 │ █████████████████░░░  87.6% │    19/19    │  100.00% │
│ util/expr.c                                   │    314 │    275 │     39 │ █████████████████░░░  87.6% │    27/27    │  100.00% │
│ tests/parse-no-sample-id-all.c                │     70 │     61 │      9 │ █████████████████░░░  87.1% │     3/3     │  100.00% │
│ tests/workloads/noploop.c                     │     23 │     20 │      3 │ █████████████████░░░  87.0% │     2/2     │  100.00% │
│ util/rblist.c                                 │     92 │     80 │     12 │ █████████████████░░░  87.0% │     8/9     │   88.89% │
│ trace/beauty/pid.c                            │     15 │     13 │      2 │ █████████████████░░░  86.7% │     1/1     │  100.00% │
│ tests/genelf.c                                │     22 │     19 │      3 │ █████████████████░░░  86.4% │     1/1     │  100.00% │
│ trace/beauty/signum.c                         │     43 │     37 │      6 │ █████████████████░░░  86.1% │     1/1     │  100.00% │
│ builtin-kallsyms.c                            │     50 │     43 │      7 │ █████████████████░░░  86.0% │     2/2     │  100.00% │
│ util/bpf-event.c                              │    681 │    584 │     97 │ █████████████████░░░  85.8% │    25/25    │  100.00% │
│ util/strlist.c                                │    132 │    113 │     19 │ █████████████████░░░  85.6% │    12/13    │   92.31% │
│ util/unwind-libdw.c                           │    309 │    264 │     45 │ █████████████████░░░  85.4% │    12/13    │   92.31% │
│ tests/demangle-rust-v0-test.c                 │     61 │     52 │      9 │ █████████████████░░░  85.2% │     1/1     │  100.00% │
│ util/metricgroup.c                            │   1033 │    873 │    160 │ ████████████████░░░░  84.5% │    40/44    │   90.91% │
│ util/maps.c                                   │    926 │    782 │    144 │ ████████████████░░░░  84.4% │    55/60    │   91.67% │
│ tests/hists_filter.c                          │    205 │    173 │     32 │ ████████████████░░░░  84.4% │     3/3     │  100.00% │
│ tests/workloads/false_sharing.c               │    132 │    111 │     21 │ ████████████████░░░░  84.1% │     4/4     │  100.00% │
│ tests/perf-time-to-tsc.c                      │    119 │    100 │     19 │ ████████████████░░░░  84.0% │     2/2     │  100.00% │
│ tests/bp_account.c                            │    123 │    103 │     20 │ ████████████████░░░░  83.7% │     8/9     │   88.89% │
│ tests/api-io.c                                │    236 │    197 │     39 │ ████████████████░░░░  83.5% │    11/11    │  100.00% │
│ tests/demangle-ocaml-test.c                   │     30 │     25 │      5 │ ████████████████░░░░  83.3% │     1/1     │  100.00% │
│ util/find-map.c                               │     24 │     20 │      4 │ ████████████████░░░░  83.3% │     1/1     │  100.00% │
│ util/kwork.h                                  │      6 │      5 │      1 │ ████████████████░░░░  83.3% │     1/1     │  100.00% │
│ util/namespaces.h                             │      6 │      5 │      1 │ ████████████████░░░░  83.3% │     1/1     │  100.00% │
│ util/units.c                                  │     48 │     40 │      8 │ ████████████████░░░░  83.3% │     4/4     │  100.00% │
│ arch/x86/tests/topdown.c                      │    166 │    138 │     28 │ ████████████████░░░░  83.1% │     6/6     │  100.00% │
│ util/c2c-function.c                           │    907 │    754 │    153 │ ████████████████░░░░  83.1% │    47/52    │   90.38% │
│ tests/perf-hooks.c                            │     23 │     19 │      4 │ ████████████████░░░░  82.6% │     3/3     │  100.00% │
│ util/copyfile.c                               │    103 │     85 │     18 │ ████████████████░░░░  82.5% │     5/6     │   83.33% │
│ util/bpf-utils.c                              │    165 │    136 │     29 │ ████████████████░░░░  82.4% │     7/7     │  100.00% │
│ tests/sample-parsing.c                        │    449 │    369 │     80 │ ████████████████░░░░  82.2% │     5/5     │  100.00% │
│ util/branch.h                                 │     11 │      9 │      2 │ ████████████████░░░░  81.8% │     1/1     │  100.00% │
│ util/map_symbol.c                             │     33 │     27 │      6 │ ████████████████░░░░  81.8% │     6/7     │   85.71% │
│ util/bpf_trace_augment.c                      │    137 │    112 │     25 │ ████████████████░░░░  81.8% │    12/12    │  100.00% │
│ ui/progress.c                                 │     27 │     22 │      5 │ ████████████████░░░░  81.5% │     4/5     │   80.00% │
│ builtin-list.c                                │    609 │    496 │    113 │ ████████████████░░░░  81.4% │    14/15    │   93.33% │
│ tests/dlfilter-test.c                         │    284 │    231 │     53 │ ████████████████░░░░  81.3% │    19/20    │   95.00% │
│ util/evsel_fprintf.c                          │    182 │    148 │     34 │ ████████████████░░░░  81.3% │     5/5     │  100.00% │
│ util/thread.c                                 │    422 │    343 │     79 │ ████████████████░░░░  81.3% │    29/32    │   90.62% │
│ util/bpf_counter_cgroup.c                     │    200 │    162 │     38 │ ████████████████░░░░  81.0% │    10/10    │  100.00% │
│ tests/uncore-event-sorting.c                  │    110 │     89 │     21 │ ████████████████░░░░  80.9% │     3/3     │  100.00% │
│ util/hwmon_pmu.c                              │    572 │    462 │    110 │ ████████████████░░░░  80.8% │    20/20    │  100.00% │
│ util/parse-branch-options.c                   │     52 │     42 │     10 │ ████████████████░░░░  80.8% │     2/2     │  100.00% │
│ util/mem-info.c                               │     31 │     25 │      6 │ ████████████████░░░░  80.7% │     3/4     │   75.00% │
│ tests/time-utils-test.c                       │    191 │    154 │     37 │ ████████████████░░░░  80.6% │     4/4     │  100.00% │
│ util/stat-display.c                           │   1073 │    864 │    209 │ ████████████████░░░░  80.5% │    60/67    │   89.55% │
│ util/dso.h                                    │    332 │    267 │     65 │ ████████████████░░░░  80.4% │    84/96    │   87.50% │
│ util/cpumap.c                                 │    550 │    442 │    108 │ ████████████████░░░░  80.4% │    38/39    │   97.44% │
│ bench/futex-hash.c                            │    137 │    110 │     27 │ ████████████████░░░░  80.3% │     4/4     │  100.00% │
│ util/pmu.c                                    │   1837 │   1470 │    367 │ ████████████████░░░░  80.0% │    98/104   │   94.23% │
│ util/env.h                                    │      5 │      4 │      1 │ ████████████████░░░░  80.0% │     1/1     │  100.00% │
│ util/sample-raw.c                             │     10 │      8 │      2 │ ████████████████░░░░  80.0% │     1/1     │  100.00% │
│ util/strlist.h                                │     20 │     16 │      4 │ ████████████████░░░░  80.0% │     4/5     │   80.00% │
│ tests/dwarf-unwind.c                          │    119 │     95 │     24 │ ███████████████░░░░░  79.8% │     7/7     │  100.00% │
│ tests/wp.c                                    │    104 │     83 │     21 │ ███████████████░░░░░  79.8% │     7/7     │  100.00% │
│ util/evsel.h                                  │     89 │     71 │     18 │ ███████████████░░░░░  79.8% │    23/24    │   95.83% │
│ util/unwind.c                                 │     68 │     54 │     14 │ ███████████████░░░░░  79.4% │     3/3     │  100.00% │
│ util/annotate-arch/annotate-x86.c             │    654 │    518 │    136 │ ███████████████░░░░░  79.2% │     7/9     │   77.78% │
│ builtin-evlist.c                              │     62 │     49 │     13 │ ███████████████░░░░░  79.0% │     2/3     │   66.67% │
│ util/dso.c                                    │   1431 │   1127 │    304 │ ███████████████░░░░░  78.8% │    91/97    │   93.81% │
│ tests/event_refresh.c                         │     88 │     69 │     19 │ ███████████████░░░░░  78.4% │     6/6     │  100.00% │
│ builtin-check.c                               │     69 │     54 │     15 │ ███████████████░░░░░  78.3% │     5/5     │  100.00% │
│ util/symbol.h                                 │     46 │     36 │     10 │ ███████████████░░░░░  78.3% │     9/11    │   81.82% │
│ util/intlist.c                                │     91 │     71 │     20 │ ███████████████░░░░░  78.0% │    10/13    │   76.92% │
│ util/synthetic-events.c                       │   2009 │   1560 │    449 │ ███████████████░░░░░  77.7% │    61/65    │   93.85% │
│ util/thread.h                                 │    160 │    124 │     36 │ ███████████████░░░░░  77.5% │    40/48    │   83.33% │
│ util/drm_pmu.c                                │    479 │    371 │    108 │ ███████████████░░░░░  77.4% │    21/23    │   91.30% │
│ util/annotate-data.c                          │   1494 │   1155 │    339 │ ███████████████░░░░░  77.3% │    58/61    │   95.08% │
│ tests/bp_signal.c                             │    114 │     88 │     26 │ ███████████████░░░░░  77.2% │     8/8     │  100.00% │
│ bench/sched-messaging.c                       │    197 │    152 │     45 │ ███████████████░░░░░  77.2% │     9/11    │   81.82% │
│ util/demangle-java.c                          │    130 │    100 │     30 │ ███████████████░░░░░  76.9% │     2/2     │  100.00% │
│ tests/workloads/thloop.c                      │     56 │     43 │     13 │ ███████████████░░░░░  76.8% │     4/4     │  100.00% │
│ util/counts.c                                 │     43 │     33 │     10 │ ███████████████░░░░░  76.7% │     5/6     │   83.33% │
│ tests/hists_link.c                            │    219 │    168 │     51 │ ███████████████░░░░░  76.7% │     8/8     │  100.00% │
│ util/perf_api_probe.c                         │    132 │    101 │     31 │ ███████████████░░░░░  76.5% │    16/16    │  100.00% │
│ util/record.c                                 │    187 │    143 │     44 │ ███████████████░░░░░  76.5% │     9/9     │  100.00% │
│ arch/x86/util/auxtrace.c                      │     25 │     19 │      6 │ ███████████████░░░░░  76.0% │     1/1     │  100.00% │
│ tests/hwmon_pmu.c                             │    257 │    195 │     62 │ ███████████████░░░░░  75.9% │     7/7     │  100.00% │
│ util/trace-event-parse.c                      │    135 │    102 │     33 │ ███████████████░░░░░  75.6% │    10/13    │   76.92% │
│ builtin-timechart.c                           │   1518 │   1140 │    378 │ ███████████████░░░░░  75.1% │    43/62    │   69.35% │
│ perf-sys.h                                    │      4 │      3 │      1 │ ███████████████░░░░░  75.0% │     1/1     │  100.00% │
│ tests/fdarray.c                               │    140 │    105 │     35 │ ███████████████░░░░░  75.0% │     4/4     │  100.00% │
│ util/intlist.h                                │     20 │     15 │      5 │ ███████████████░░░░░  75.0% │     4/5     │   80.00% │
│ util/maps.h                                   │      4 │      3 │      1 │ ███████████████░░░░░  75.0% │     1/1     │  100.00% │
│ util/probe-finder.h                           │      4 │      3 │      1 │ ███████████████░░░░░  75.0% │     1/1     │  100.00% │
│ util/srccode.h                                │      4 │      3 │      1 │ ███████████████░░░░░  75.0% │     1/1     │  100.00% │
│ util/trace-event.c                            │     88 │     66 │     22 │ ███████████████░░░░░  75.0% │     7/8     │   87.50% │
│ util/build-id.c                               │    664 │    497 │    167 │ ██████████████░░░░░░  74.8% │    39/42    │   92.86% │
│ util/annotate.h                               │     75 │     56 │     19 │ ██████████████░░░░░░  74.7% │    12/15    │   80.00% │
│ util/parse-events.c                           │   2027 │   1510 │    517 │ ██████████████░░░░░░  74.5% │    76/85    │   89.41% │
│ tests/demangle-java-test.c                    │     35 │     26 │      9 │ ██████████████░░░░░░  74.3% │     1/1     │  100.00% │
│ arch/x86/tests/dwarf-unwind.c                 │     38 │     28 │     10 │ ██████████████░░░░░░  73.7% │     2/2     │  100.00% │
│ util/target.h                                 │     34 │     25 │      9 │ ██████████████░░░░░░  73.5% │     6/6     │  100.00% │
│ tests/tests-scripts.c                         │    256 │    188 │     68 │ ██████████████░░░░░░  73.4% │    10/10    │  100.00% │
│ tests/event-times.c                           │    154 │    113 │     41 │ ██████████████░░░░░░  73.4% │     9/9     │  100.00% │
│ util/stat.c                                   │    448 │    328 │    120 │ ██████████████░░░░░░  73.2% │    36/42    │   85.71% │
│ util/data-convert-json.c                      │    313 │    229 │     84 │ ██████████████░░░░░░  73.2% │     9/9     │  100.00% │
│ util/sideband_evlist.c                        │     93 │     68 │     25 │ ██████████████░░░░░░  73.1% │     4/5     │   80.00% │
│ tests/bp_signal_overflow.c                    │     74 │     54 │     20 │ ██████████████░░░░░░  73.0% │     4/4     │  100.00% │
│ util/tool.c                                   │    291 │    212 │     79 │ ██████████████░░░░░░  72.8% │    25/65    │   38.46% │
│ tests/backward-ring-buffer.c                  │    114 │     83 │     31 │ ██████████████░░░░░░  72.8% │     4/4     │  100.00% │
│ tests/pmu.c                                   │    425 │    309 │    116 │ ██████████████░░░░░░  72.7% │    10/10    │  100.00% │
│ tests/workloads/jitdump.c                     │    106 │     77 │     29 │ ██████████████░░░░░░  72.6% │     5/5     │  100.00% │
│ util/cputopo.c                                │    356 │    258 │     98 │ ██████████████░░░░░░  72.5% │    11/13    │   84.62% │
│ util/parse-sublevel-options.c                 │     47 │     34 │     13 │ ██████████████░░░░░░  72.3% │     2/2     │  100.00% │
│ util/util.c                                   │    315 │    227 │     88 │ ██████████████░░░░░░  72.1% │    23/26    │   88.46% │
│ util/libdw.c                                  │    161 │    116 │     45 │ ██████████████░░░░░░  72.1% │     4/4     │  100.00% │
│ util/map.c                                    │    404 │    291 │    113 │ ██████████████░░░░░░  72.0% │    34/37    │   91.89% │
│ util/debuginfo.c                              │    121 │     87 │     34 │ ██████████████░░░░░░  71.9% │     7/7     │  100.00% │
│ util/symbol.c                                 │   1775 │   1275 │    500 │ ██████████████░░░░░░  71.8% │    82/94    │   87.23% │
│ tests/expand-cgroup.c                         │    159 │    114 │     45 │ ██████████████░░░░░░  71.7% │     6/6     │  100.00% │
│ trace/beauty/beauty.h                         │     14 │     10 │      4 │ ██████████████░░░░░░  71.4% │     1/1     │  100.00% │
│ util/rlimit.c                                 │     35 │     25 │     10 │ ██████████████░░░░░░  71.4% │     2/2     │  100.00% │
│ builtin-daemon.c                              │   1011 │    721 │    290 │ ██████████████░░░░░░  71.3% │    45/47    │   95.74% │
│ util/dwarf-aux.c                              │   1454 │   1037 │    417 │ ██████████████░░░░░░  71.3% │    76/90    │   84.44% │
│ util/hist.c                                   │   2089 │   1486 │    603 │ ██████████████░░░░░░  71.1% │   112/132   │   84.85% │
│ util/dwarf-regs-arch/dwarf-regs-x86.c         │    151 │    107 │     44 │ ██████████████░░░░░░  70.9% │     3/5     │   60.00% │
│ tests/sdt.c                                   │     65 │     46 │     19 │ ██████████████░░░░░░  70.8% │     5/5     │  100.00% │
│ ui/stdio/hist.c                               │    626 │    442 │    184 │ ██████████████░░░░░░  70.6% │    19/25    │   76.00% │
│ util/genelf.c                                 │    281 │    198 │     83 │ ██████████████░░░░░░  70.5% │     3/3     │  100.00% │
│ util/blake2s.h                                │     27 │     19 │      8 │ ██████████████░░░░░░  70.4% │     2/3     │   66.67% │
│ ui/hist.c                                     │    906 │    635 │    271 │ ██████████████░░░░░░  70.1% │    49/61    │   80.33% │
│ builtin-probe.c                               │    524 │    366 │    158 │ █████████████░░░░░░░  69.8% │    16/19    │   84.21% │
│ util/addr_location.c                          │     23 │     16 │      7 │ █████████████░░░░░░░  69.6% │     2/3     │   66.67% │
│ util/sample.h                                 │     13 │      9 │      4 │ █████████████░░░░░░░  69.2% │     2/3     │   66.67% │
│ util/zstd.c                                   │    103 │     71 │     32 │ █████████████░░░░░░░  68.9% │     4/4     │  100.00% │
│ arch/x86/tests/intel-pt-test.c                │    196 │    135 │     61 │ █████████████░░░░░░░  68.9% │     9/11    │   81.82% │
│ util/intel-tpebs.c                            │    492 │    338 │    154 │ █████████████░░░░░░░  68.7% │    17/17    │  100.00% │
│ tests/symbols.c                               │    304 │    208 │     96 │ █████████████░░░░░░░  68.4% │    11/15    │   73.33% │
│ tests/task-exit.c                             │     95 │     65 │     30 │ █████████████░░░░░░░  68.4% │     2/3     │   66.67% │
│ util/smt.c                                    │     19 │     13 │      6 │ █████████████░░░░░░░  68.4% │     2/2     │  100.00% │
│ util/svghelper.c                              │    557 │    381 │    176 │ █████████████░░░░░░░  68.4% │    27/33    │   81.82% │
│ tests/sw-clock.c                              │     98 │     67 │     31 │ █████████████░░░░░░░  68.4% │     2/2     │  100.00% │
│ util/bpf_lock_contention.c                    │    610 │    415 │    195 │ █████████████░░░░░░░  68.0% │    15/16    │   93.75% │
│ util/cap.c                                    │     25 │     17 │      8 │ █████████████░░░░░░░  68.0% │     1/1     │  100.00% │
│ builtin-kwork.c                               │   1749 │   1188 │    561 │ █████████████░░░░░░░  67.9% │    78/101   │   77.23% │
│ tests/pmu-events.c                            │    621 │    421 │    200 │ █████████████░░░░░░░  67.8% │    25/25    │  100.00% │
│ tests/switch-tracking.c                       │    431 │    292 │    139 │ █████████████░░░░░░░  67.8% │    10/10    │  100.00% │
│ util/header.c                                 │   3941 │   2662 │   1279 │ █████████████░░░░░░░  67.6% │   159/180   │   88.33% │
│ util/sample.c                                 │     89 │     60 │     29 │ █████████████░░░░░░░  67.4% │     6/6     │  100.00% │
│ builtin-trace.c                               │   3657 │   2451 │   1206 │ █████████████░░░░░░░  67.0% │   154/198   │   77.78% │
│ util/time-utils.c                             │    347 │    232 │    115 │ █████████████░░░░░░░  66.9% │    16/20    │   80.00% │
│ util/evlist.c                                 │   1933 │   1292 │    641 │ █████████████░░░░░░░  66.8% │   102/131   │   77.86% │
│ util/print_binary.h                           │      3 │      2 │      1 │ █████████████░░░░░░░  66.7% │     1/1     │  100.00% │
│ util/time-utils.h                             │      6 │      4 │      2 │ █████████████░░░░░░░  66.7% │     1/1     │  100.00% │
│ util/dlfilter.c                               │    449 │    298 │    151 │ █████████████░░░░░░░  66.4% │    24/28    │   85.71% │
│ tests/evsel-roundtrip-name.c                  │     77 │     51 │     26 │ █████████████░░░░░░░  66.2% │     3/3     │  100.00% │
│ trace/beauty/fcntl.c                          │     65 │     43 │     22 │ █████████████░░░░░░░  66.2% │     4/6     │   66.67% │
│ util/llvm.c                                   │    195 │    129 │     66 │ █████████████░░░░░░░  66.2% │     4/5     │   80.00% │
│ util/tool_pmu.c                               │    510 │    336 │    174 │ █████████████░░░░░░░  65.9% │    20/24    │   83.33% │
│ util/symbol_fprintf.c                         │     41 │     27 │     14 │ █████████████░░░░░░░  65.8% │     4/6     │   66.67% │
│ util/lzma.c                                   │     89 │     58 │     31 │ █████████████░░░░░░░  65.2% │     3/4     │   75.00% │
│ tests/kallsyms-split.c                        │     86 │     56 │     30 │ █████████████░░░░░░░  65.1% │     3/3     │  100.00% │
│ ui/util.c                                     │     40 │     26 │     14 │ █████████████░░░░░░░  65.0% │     4/6     │   66.67% │
│ util/trace-event-read.c                       │    350 │    226 │    124 │ ████████████░░░░░░░░  64.6% │    14/15    │   93.33% │
│ util/top.c                                    │     84 │     54 │     30 │ ████████████░░░░░░░░  64.3% │     2/2     │  100.00% │
│ builtin-ftrace.c                              │   1430 │    912 │    518 │ ████████████░░░░░░░░  63.8% │    60/66    │   90.91% │
│ util/hist.h                                   │     88 │     56 │     32 │ ████████████░░░░░░░░  63.6% │    13/18    │   72.22% │
│ util/perf_event_attr_fprintf.c                │    291 │    185 │    106 │ ████████████░░░░░░░░  63.6% │    13/19    │   68.42% │
│ builtin-stat.c                                │   2002 │   1272 │    730 │ ████████████░░░░░░░░  63.5% │    70/98    │   71.43% │
│ util/event.c                                  │    571 │    362 │    209 │ ████████████░░░░░░░░  63.4% │    41/54    │   75.93% │
│ tests/tool_pmu.c                              │    128 │     81 │     47 │ ████████████░░░░░░░░  63.3% │     4/4     │  100.00% │
│ util/strbuf.c                                 │    117 │     74 │     43 │ ████████████░░░░░░░░  63.2% │     8/9     │   88.89% │
│ builtin-buildid-list.c                        │    111 │     70 │     41 │ ████████████░░░░░░░░  63.1% │     4/7     │   57.14% │
│ util/term.c                                   │     27 │     17 │     10 │ ████████████░░░░░░░░  63.0% │     2/2     │  100.00% │
│ util/data.c                                   │    394 │    248 │    146 │ ████████████░░░░░░░░  62.9% │    24/28    │   85.71% │
│ trace/beauty/prctl.c                          │     48 │     30 │     18 │ ████████████░░░░░░░░  62.5% │     2/5     │   40.00% │
│ tests/builtin-test.c                          │   1627 │   1012 │    615 │ ████████████░░░░░░░░  62.2% │    50/63    │   79.37% │
│ trace/beauty/futex_op.c                       │     37 │     23 │     14 │ ████████████░░░░░░░░  62.2% │     1/1     │  100.00% │
│ util/evsel.c                                  │   3326 │   2067 │   1259 │ ████████████░░░░░░░░  62.2% │   128/155   │   82.58% │
│ tests/openat-syscall-tp-fields.c              │     98 │     60 │     38 │ ████████████░░░░░░░░  61.2% │     1/1     │  100.00% │
│ util/perf-regs-arch/perf_regs_x86.c           │    462 │    282 │    180 │ ████████████░░░░░░░░  61.0% │    15/19    │   78.95% │
│ tests/mmap-basic.c                            │    312 │    190 │    122 │ ████████████░░░░░░░░  60.9% │     8/8     │  100.00% │
│ util/machine.c                                │   2246 │   1367 │    879 │ ████████████░░░░░░░░  60.9% │   103/131   │   78.63% │
│ builtin-annotate.c                            │    630 │    383 │    247 │ ████████████░░░░░░░░  60.8% │    10/15    │   66.67% │
│ util/srcline.c                                │    370 │    224 │    146 │ ████████████░░░░░░░░  60.5% │    16/21    │   76.19% │
│ util/strfilter.c                              │    225 │    136 │     89 │ ████████████░░░░░░░░  60.4% │    12/14    │   85.71% │
│ util/trace-event-info.c                       │    498 │    301 │    197 │ ████████████░░░░░░░░  60.4% │    18/20    │   90.00% │
│ tests/sigtrap.c                               │    141 │     85 │     56 │ ████████████░░░░░░░░  60.3% │     7/10    │   70.00% │
│ util/probe-file.c                             │    839 │    505 │    334 │ ████████████░░░░░░░░  60.2% │    36/48    │   75.00% │
│ builtin-report.c                              │   1352 │    812 │    540 │ ████████████░░░░░░░░  60.1% │    28/38    │   73.68% │
│ util/cgroup.c                                 │    420 │    251 │    169 │ ███████████░░░░░░░░░  59.8% │    20/27    │   74.07% │
│ builtin-data.c                                │     42 │     25 │     17 │ ███████████░░░░░░░░░  59.5% │     2/2     │  100.00% │
│ util/auxtrace.h                               │     37 │     22 │     15 │ ███████████░░░░░░░░░  59.5% │     5/5     │  100.00% │
│ util/config.c                                 │    739 │    438 │    301 │ ███████████░░░░░░░░░  59.3% │    44/60    │   73.33% │
│ tests/code-reading.c                          │    608 │    360 │    248 │ ███████████░░░░░░░░░  59.2% │    18/20    │   90.00% │
│ util/env.c                                    │    721 │    426 │    295 │ ███████████░░░░░░░░░  59.1% │    32/43    │   74.42% │
│ tests/perf-record.c                           │    259 │    153 │    106 │ ███████████░░░░░░░░░  59.1% │     2/2     │  100.00% │
│ tests/openat-syscall-all-cpus.c               │     83 │     49 │     34 │ ███████████░░░░░░░░░  59.0% │     1/1     │  100.00% │
│ util/aslr.c                                   │   1026 │    603 │    423 │ ███████████░░░░░░░░░  58.8% │    25/32    │   78.12% │
│ util/mutex.c                                  │    116 │     68 │     48 │ ███████████░░░░░░░░░  58.6% │    13/18    │   72.22% │
│ util/thread_map.c                             │    281 │    164 │    117 │ ███████████░░░░░░░░░  58.4% │    15/17    │   88.24% │
│ ui/setup.c                                    │     55 │     32 │     23 │ ███████████░░░░░░░░░  58.2% │     4/7     │   57.14% │
│ util/vdso.c                                   │    227 │    132 │     95 │ ███████████░░░░░░░░░  58.2% │    10/15    │   66.67% │
│ util/bpf_off_cpu.c                            │    293 │    170 │    123 │ ███████████░░░░░░░░░  58.0% │     6/6     │  100.00% │
│ util/cloexec.c                                │     57 │     33 │     24 │ ███████████░░░░░░░░░  57.9% │     2/2     │  100.00% │
│ util/tracepoint.c                             │     26 │     15 │     11 │ ███████████░░░░░░░░░  57.7% │     1/2     │   50.00% │
│ util/jitdump.c                                │    655 │    374 │    281 │ ███████████░░░░░░░░░  57.1% │    17/19    │   89.47% │
│ util/disasm.c                                 │    993 │    564 │    429 │ ███████████░░░░░░░░░  56.8% │    37/57    │   64.91% │
│ util/probe-finder.c                           │   1404 │    797 │    607 │ ███████████░░░░░░░░░  56.8% │    36/45    │   80.00% │
│ util/probe-event.c                            │   2765 │   1554 │   1211 │ ███████████░░░░░░░░░  56.2% │    81/103   │   78.64% │
│ util/thread-stack.c                           │    742 │    417 │    325 │ ███████████░░░░░░░░░  56.2% │    26/39    │   66.67% │
│ util/demangle-rust-v0.c                       │   1613 │    906 │    707 │ ███████████░░░░░░░░░  56.2% │    52/68    │   76.47% │
│ util/debug.c                                  │    212 │    119 │     93 │ ███████████░░░░░░░░░  56.1% │    12/20    │   60.00% │
│ util/cacheline.h                              │     18 │     10 │      8 │ ███████████░░░░░░░░░  55.6% │     2/2     │  100.00% │
│ util/unwind.h                                 │      9 │      5 │      4 │ ███████████░░░░░░░░░  55.6% │     3/4     │   75.00% │
│ tests/openat-syscall.c                        │     47 │     26 │     21 │ ███████████░░░░░░░░░  55.3% │     1/1     │  100.00% │
│ arch/x86/tests/bp-modify.c                    │    123 │     68 │     55 │ ███████████░░░░░░░░░  55.3% │     5/6     │   83.33% │
│ builtin-record.c                              │   2737 │   1501 │   1236 │ ██████████░░░░░░░░░░  54.8% │    84/120   │   70.00% │
│ util/symbol-elf.c                             │   1930 │   1041 │    889 │ ██████████░░░░░░░░░░  53.9% │    55/93    │   59.14% │
│ trace/beauty/pkey_alloc.c                     │     30 │     16 │     14 │ ██████████░░░░░░░░░░  53.3% │     1/3     │   33.33% │
│ arch/x86/util/intel-pt.c                      │    820 │    431 │    389 │ ██████████░░░░░░░░░░  52.6% │    23/38    │   60.53% │
│ tests/evsel-tp-sched.c                        │     59 │     31 │     28 │ ██████████░░░░░░░░░░  52.5% │     2/2     │  100.00% │
│ bench/mem-functions.c                         │    300 │    154 │    146 │ ██████████░░░░░░░░░░  51.3% │    12/21    │   57.14% │
│ builtin-lock.c                                │   1950 │    983 │    967 │ ██████████░░░░░░░░░░  50.4% │    55/80    │   68.75% │
│ builtin-c2c.c                                 │   2027 │   1018 │   1009 │ ██████████░░░░░░░░░░  50.2% │    58/156   │   37.18% │
│ util/auxtrace.c                               │   2013 │   1009 │   1004 │ ██████████░░░░░░░░░░  50.1% │    81/126   │   64.29% │
│ util/intel-pt-decoder/intel-pt-log.h          │      6 │      3 │      3 │ ██████████░░░░░░░░░░  50.0% │     1/2     │   50.00% │
│ util/callchain.c                              │   1302 │    639 │    663 │ █████████░░░░░░░░░░░  49.1% │    38/69    │   55.07% │
│ util/path.c                                   │     45 │     22 │     23 │ █████████░░░░░░░░░░░  48.9% │     4/7     │   57.14% │
│ util/intel-pt-decoder/intel-pt-insn-decoder.c │    229 │    110 │    119 │ █████████░░░░░░░░░░░  48.0% │     3/7     │   42.86% │
│ util/parse-regs-options.c                     │    199 │     95 │    104 │ █████████░░░░░░░░░░░  47.7% │     6/8     │   75.00% │
│ bench/futex.c                                 │     42 │     20 │     22 │ █████████░░░░░░░░░░░  47.6% │     2/2     │  100.00% │
│ tests/vmlinux-kallsyms.c                      │    208 │     99 │    109 │ █████████░░░░░░░░░░░  47.6% │     4/5     │   80.00% │
│ builtin-top.c                                 │   1353 │    629 │    724 │ █████████░░░░░░░░░░░  46.5% │    23/44    │   52.27% │
│ trace/beauty/ioctl.c                          │    121 │     56 │     65 │ █████████░░░░░░░░░░░  46.3% │     3/10    │   30.00% │
│ util/string.c                                 │    294 │    136 │    158 │ █████████░░░░░░░░░░░  46.3% │    11/15    │   73.33% │
│ util/lock-contention.c                        │     78 │     36 │     42 │ █████████░░░░░░░░░░░  46.2% │     4/5     │   80.00% │
│ trace/beauty/mmap.c                           │     37 │     17 │     20 │ █████████░░░░░░░░░░░  46.0% │     4/8     │   50.00% │
│ builtin-mem.c                                 │    371 │    169 │    202 │ █████████░░░░░░░░░░░  45.5% │     5/9     │   55.56% │
│ tests/hists_common.c                          │    104 │     47 │     57 │ █████████░░░░░░░░░░░  45.2% │     1/3     │   33.33% │
│ util/session.c                                │   2686 │   1204 │   1482 │ ████████░░░░░░░░░░░░  44.8% │    65/125   │   52.00% │
│ trace/beauty/timespec.c                       │      9 │      4 │      5 │ ████████░░░░░░░░░░░░  44.4% │     1/2     │   50.00% │
│ util/intel-pt.c                               │   3237 │   1426 │   1811 │ ████████░░░░░░░░░░░░  44.0% │    79/142   │   55.63% │
│ builtin-inject.c                              │   2023 │    890 │   1133 │ ████████░░░░░░░░░░░░  44.0% │    37/94    │   39.36% │
│ util/bpf_counter.c                            │    573 │    250 │    323 │ ████████░░░░░░░░░░░░  43.6% │    23/34    │   67.65% │
│ util/python.c                                 │   2984 │   1301 │   1683 │ ████████░░░░░░░░░░░░  43.6% │   128/224   │   57.14% │
│ util/data-convert-bt.c                        │   1128 │    483 │    645 │ ████████░░░░░░░░░░░░  42.8% │    27/49    │   55.10% │
│ perf.c                                        │    320 │    135 │    185 │ ████████░░░░░░░░░░░░  42.2% │    10/15    │   66.67% │
│ builtin-sched.c                               │   3737 │   1542 │   2195 │ ████████░░░░░░░░░░░░  41.3% │    62/141   │   43.97% │
│ util/libbfd.h                                 │     20 │      8 │     12 │ ████████░░░░░░░░░░░░  40.0% │     3/7     │   42.86% │
│ util/mem-events.c                             │    760 │    302 │    458 │ ███████░░░░░░░░░░░░░  39.7% │    15/24    │   62.50% │
│ bench/syscall.c                               │    115 │     45 │     70 │ ███████░░░░░░░░░░░░░  39.1% │     2/7     │   28.57% │
│ builtin-buildid-cache.c                       │    414 │    162 │    252 │ ███████░░░░░░░░░░░░░  39.1% │     5/15    │   33.33% │
│ builtin-config.c                              │    149 │     58 │     91 │ ███████░░░░░░░░░░░░░  38.9% │     3/5     │   60.00% │
│ util/annotate.c                               │   2245 │    866 │   1379 │ ███████░░░░░░░░░░░░░  38.6% │    60/118   │   50.85% │
│ builtin-bench.c                               │    121 │     46 │     75 │ ███████░░░░░░░░░░░░░  38.0% │     3/7     │   42.86% │
│ util/clockid.c                                │     45 │     17 │     28 │ ███████░░░░░░░░░░░░░  37.8% │     2/3     │   66.67% │
│ util/intel-pt-decoder/intel-pt-decoder.c      │   3208 │   1201 │   2007 │ ███████░░░░░░░░░░░░░  37.4% │    70/119   │   58.82% │
│ builtin-diff.c                                │   1214 │    434 │    780 │ ███████░░░░░░░░░░░░░  35.8% │    34/79    │   43.04% │
│ util/sort.c                                   │   2421 │    861 │   1560 │ ███████░░░░░░░░░░░░░  35.6% │    83/246   │   33.74% │
│ util/pmu.h                                    │     17 │      6 │     11 │ ███████░░░░░░░░░░░░░  35.3% │     1/1     │  100.00% │
│ util/trigger.h                                │     34 │     12 │     22 │ ███████░░░░░░░░░░░░░  35.3% │     4/9     │   44.44% │
│ builtin-script.c                              │   3212 │   1118 │   2094 │ ██████░░░░░░░░░░░░░░  34.8% │    51/124   │   41.13% │
│ util/hashmap.h                                │     23 │      8 │     15 │ ██████░░░░░░░░░░░░░░  34.8% │     1/2     │   50.00% │
│ util/target.c                                 │     75 │     26 │     49 │ ██████░░░░░░░░░░░░░░  34.7% │     2/3     │   66.67% │
│ util/mmap.c                                   │    212 │     71 │    141 │ ██████░░░░░░░░░░░░░░  33.5% │     7/17    │   41.18% │
│ util/ordered-events.h                         │      9 │      3 │      6 │ ██████░░░░░░░░░░░░░░  33.3% │     1/3     │   33.33% │
│ util/string2.h                                │      9 │      3 │      6 │ ██████░░░░░░░░░░░░░░  33.3% │     1/3     │   33.33% │
│ arch/x86/util/tsc.c                           │     51 │     16 │     35 │ ██████░░░░░░░░░░░░░░  31.4% │     1/2     │   50.00% │
│ util/branch.c                                 │    158 │     49 │    109 │ ██████░░░░░░░░░░░░░░  31.0% │     4/9     │   44.44% │
│ util/util.h                                   │     17 │      5 │     12 │ █████░░░░░░░░░░░░░░░  29.4% │     1/1     │  100.00% │
│ util/perf_regs.c                              │    276 │     78 │    198 │ █████░░░░░░░░░░░░░░░  28.3% │     9/12    │   75.00% │
│ util/bpf-filter.c                             │    496 │    140 │    356 │ █████░░░░░░░░░░░░░░░  28.2% │     9/16    │   56.25% │
│ util/kvm-stat.h                               │     22 │      6 │     16 │ █████░░░░░░░░░░░░░░░  27.3% │     2/4     │   50.00% │
│ arch/x86/util/event.c                         │     27 │      7 │     20 │ █████░░░░░░░░░░░░░░░  25.9% │     1/1     │  100.00% │
│ util/dwarf-regs.c                             │    184 │     47 │    137 │ █████░░░░░░░░░░░░░░░  25.5% │     4/5     │   80.00% │
│ util/evswitch.c                               │     40 │     10 │     30 │ █████░░░░░░░░░░░░░░░  25.0% │     2/3     │   66.67% │
│ arch/x86/tests/amd-ibs-via-core-pmu.c         │     35 │      8 │     27 │ ████░░░░░░░░░░░░░░░░  22.9% │     1/2     │   50.00% │
│ arch/x86/util/machine.c                       │     31 │      7 │     24 │ ████░░░░░░░░░░░░░░░░  22.6% │     1/2     │   50.00% │
│ arch/common.c                                 │    137 │     25 │    112 │ ███░░░░░░░░░░░░░░░░░  18.2% │     4/6     │   66.67% │
│ bench/futex.h                                 │     30 │      5 │     25 │ ███░░░░░░░░░░░░░░░░░  16.7% │     2/9     │   22.22% │
│ arch/x86/util/evsel.c                         │     61 │      6 │     55 │ █░░░░░░░░░░░░░░░░░░░   9.8% │     1/4     │   25.00% │
│ util/addr2line.c                              │    317 │     28 │    289 │ █░░░░░░░░░░░░░░░░░░░   8.8% │     2/8     │   25.00% │
│ arch/x86/util/pmu.c                           │    198 │     17 │    181 │ █░░░░░░░░░░░░░░░░░░░   8.6% │     2/12    │   16.67% │
│ util/block-range.c                            │    225 │     19 │    206 │ █░░░░░░░░░░░░░░░░░░░   8.4% │     3/7     │   42.86% │
│ util/capstone.c                               │    453 │     21 │    432 │ ░░░░░░░░░░░░░░░░░░░░   4.6% │     1/19    │    5.26% │
│ util/intel-pt-decoder/intel-pt-log.c          │    160 │      7 │    153 │ ░░░░░░░░░░░░░░░░░░░░   4.4% │     2/18    │   11.11% │
│ arch/x86/tests/amd-ibs-period.c               │    497 │     21 │    476 │ ░░░░░░░░░░░░░░░░░░░░   4.2% │     2/24    │    8.33% │
│ util/block-info.c                             │    333 │      4 │    329 │ ░░░░░░░░░░░░░░░░░░░░   1.2% │     1/27    │    3.70% │
│ arch/x86/util/intel-bts.c                     │    288 │      0 │    288 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/13    │    0.00% │
│ arch/x86/util/iostat.c                        │    219 │      0 │    219 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/13    │    0.00% │
│ bench/atomic.c                                │    144 │      0 │    144 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/8     │    0.00% │
│ bench/breakpoint.c                            │    165 │      0 │    165 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/6     │    0.00% │
│ bench/epoll-ctl.c                             │    251 │      0 │    251 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/9     │    0.00% │
│ bench/epoll-wait.c                            │    292 │      0 │    292 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/9     │    0.00% │
│ bench/evlist-open-close.c                     │    182 │      0 │    182 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/7     │    0.00% │
│ bench/find-bit-bench.c                        │     83 │      0 │     83 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ bench/futex-lock-pi.c                         │    144 │      0 │    144 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/5     │    0.00% │
│ bench/futex-requeue.c                         │    182 │      0 │    182 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/5     │    0.00% │
│ bench/futex-wake-parallel.c                   │    188 │      0 │    188 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/9     │    0.00% │
│ bench/futex-wake.c                            │    127 │      0 │    127 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/5     │    0.00% │
│ bench/inject-buildid.c                        │    285 │      0 │    285 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/15    │    0.00% │
│ bench/kallsyms-parse.c                        │     36 │      0 │     36 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/3     │    0.00% │
│ bench/maps.c                                  │    128 │      0 │    128 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ bench/numa.c                                  │   1101 │      0 │   1101 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/43    │    0.00% │
│ bench/pmu-scan.c                              │    114 │      0 │    114 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/5     │    0.00% │
│ bench/sched-pipe.c                            │    261 │      0 │    261 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/9     │    0.00% │
│ bench/sched-seccomp-notify.c                  │    102 │      0 │    102 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ bench/symbols.c                               │    175 │      0 │    175 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ bench/synthesize.c                            │    174 │      0 │    174 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/6     │    0.00% │
│ bench/uprobe.c                                │    102 │      0 │    102 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/9     │    0.00% │
│ builtin-help.c                                │    366 │      0 │    366 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/26    │    0.00% │
│ builtin-kmem.c                                │   1337 │      0 │   1337 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/70    │    0.00% │
│ builtin-kvm.c                                 │   1316 │      0 │   1316 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/90    │    0.00% │
│ jvmti/jvmti_agent.c                           │    280 │      0 │    280 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/12    │    0.00% │
│ jvmti/libjvmti.c                              │    280 │      0 │    280 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/10    │    0.00% │
│ tests/workloads/branch_not_taken_loop.c       │      5 │      0 │      5 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ tests/workloads/callchain.c                   │      9 │      0 │      9 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/3     │    0.00% │
│ tests/workloads/context_switch_loop.c         │     61 │      0 │     61 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/3     │    0.00% │
│ tests/workloads/deterministic.c               │     21 │      0 │     21 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/3     │    0.00% │
│ tests/workloads/leafloop.c                    │     20 │      0 │     20 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ tests/workloads/named_threads.c               │     29 │      0 │     29 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ tests/workloads/page_fault_loop.c             │     24 │      0 │     24 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ tests/workloads/sqrtloop.c                    │     24 │      0 │     24 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/3     │    0.00% │
│ tests/workloads/traploop.c                    │      9 │      0 │      9 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ trace/beauty/eventfd.c                        │     19 │      0 │     19 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ trace/beauty/flock.c                          │     24 │      0 │     24 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ trace/beauty/fs_at_flags.c                    │     22 │      0 │     22 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ trace/beauty/fsmount.c                        │     25 │      0 │     25 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ trace/beauty/fspick.c                         │      9 │      0 │      9 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ trace/beauty/futex_val3.c                     │      7 │      0 │      7 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ trace/beauty/kcmp.c                           │     19 │      0 │     19 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/3     │    0.00% │
│ trace/beauty/mount_flags.c                    │     14 │      0 │     14 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/3     │    0.00% │
│ trace/beauty/move_mount.c                     │      9 │      0 │      9 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ trace/beauty/msg_flags.c                      │     39 │      0 │     39 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ trace/beauty/perf_event_open.c                │     53 │      0 │     53 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/5     │    0.00% │
│ trace/beauty/sched_policy.c                   │     25 │      0 │     25 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ trace/beauty/seccomp.c                        │     29 │      0 │     29 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ trace/beauty/sockaddr.c                       │     51 │      0 │     51 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/5     │    0.00% │
│ trace/beauty/socket.c                         │     20 │      0 │     20 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ trace/beauty/socket_type.c                    │     32 │      0 │     32 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ trace/beauty/statx.c                          │     10 │      0 │     10 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ trace/beauty/sync_file_range.c                │     14 │      0 │     14 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ trace/beauty/tracepoints/x86_irq_vectors.c    │     10 │      0 │     10 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/3     │    0.00% │
│ trace/beauty/tracepoints/x86_msr.c            │     10 │      0 │     10 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/3     │    0.00% │
│ ui/browser.c                                  │    559 │      0 │    559 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/41    │    0.00% │
│ ui/browsers/annotate-data.c                   │    428 │      0 │    428 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/23    │    0.00% │
│ ui/browsers/annotate.c                        │    896 │      0 │    896 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/48    │    0.00% │
│ ui/browsers/c2c-function.c                    │    118 │      0 │    118 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/8     │    0.00% │
│ ui/browsers/header.c                          │     93 │      0 │     93 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ ui/browsers/hists.c                           │   2730 │      0 │   2730 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/124   │    0.00% │
│ ui/browsers/map.c                             │     87 │      0 │     87 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ ui/browsers/res_sample.c                      │     64 │      0 │     64 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/3     │    0.00% │
│ ui/browsers/scripts.c                         │    179 │      0 │    179 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/7     │    0.00% │
│ ui/helpline.c                                 │     40 │      0 │     40 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/10    │    0.00% │
│ ui/keysyms.c                                  │     34 │      0 │     34 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ ui/stdio/progress.c                           │     79 │      0 │     79 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/5     │    0.00% │
│ ui/tui/helpline.c                             │     30 │      0 │     30 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ ui/tui/progress.c                             │     52 │      0 │     52 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/5     │    0.00% │
│ ui/tui/setup.c                                │    125 │      0 │    125 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/9     │    0.00% │
│ ui/tui/util.c                                 │    201 │      0 │    201 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/12    │    0.00% │
│ util/amd-sample-raw.c                         │    322 │      0 │    322 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/16    │    0.00% │
│ util/annotate-arch/annotate-alpha.c           │     81 │      0 │     81 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ util/annotate-arch/annotate-arc.c             │      9 │      0 │      9 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/annotate-arch/annotate-arm.c             │     40 │      0 │     40 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ util/annotate-arch/annotate-arm64.c           │    778 │      0 │    778 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/30    │    0.00% │
│ util/annotate-arch/annotate-csky.c            │     35 │      0 │     35 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ util/annotate-arch/annotate-loongarch.c       │     94 │      0 │     94 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ util/annotate-arch/annotate-mips.c            │     37 │      0 │     37 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ util/annotate-arch/annotate-powerpc.c         │    144 │      0 │    144 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/10    │    0.00% │
│ util/annotate-arch/annotate-riscv64.c         │     25 │      0 │     25 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ util/annotate-arch/annotate-s390.c            │    119 │      0 │    119 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/5     │    0.00% │
│ util/annotate-arch/annotate-sparc.c           │    136 │      0 │    136 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/5     │    0.00% │
│ util/arm-spe-decoder/arm-spe-decoder.c        │    214 │      0 │    214 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/7     │    0.00% │
│ util/arm-spe-decoder/arm-spe-pkt-decoder.c    │    364 │      0 │    364 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/22    │    0.00% │
│ util/arm-spe.c                                │   1330 │      0 │   1330 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/50    │    0.00% │
│ util/arm64-frame-pointer-unwind-support.c     │     37 │      0 │     37 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ util/block-range.h                            │     21 │      0 │     21 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ util/bpf_ftrace.c                             │    150 │      0 │    150 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/5     │    0.00% │
│ util/bpf_kwork.c                              │    213 │      0 │    213 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/12    │    0.00% │
│ util/bpf_kwork_top.c                          │    169 │      0 │    169 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/12    │    0.00% │
│ util/btf.c                                    │     11 │      0 │     11 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/color_config.c                           │     21 │      0 │     21 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/cs-etm-base.c                            │     94 │      0 │     94 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ util/cs-etm.h                                 │      4 │      0 │      4 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/db-export.c                              │    432 │      0 │    432 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/24    │    0.00% │
│ util/dwarf-regs-arch/dwarf-regs-arm.c         │      5 │      0 │      5 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/dwarf-regs-arch/dwarf-regs-arm64.c       │     22 │      0 │     22 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ util/dwarf-regs-arch/dwarf-regs-csky.c        │     61 │      0 │     61 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ util/dwarf-regs-arch/dwarf-regs-loongarch.c   │      5 │      0 │      5 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/dwarf-regs-arch/dwarf-regs-mips.c        │      7 │      0 │      7 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/dwarf-regs-arch/dwarf-regs-powerpc.c     │     69 │      0 │     69 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/5     │    0.00% │
│ util/dwarf-regs-arch/dwarf-regs-riscv.c       │      5 │      0 │      5 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/dwarf-regs-arch/dwarf-regs-s390.c        │     44 │      0 │     44 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/genelf_debug.c                           │    318 │      0 │    318 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/27    │    0.00% │
│ util/help-unknown-cmd.c                       │     87 │      0 │     87 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c  │     67 │      0 │     67 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/5     │    0.00% │
│ util/hisi-ptt.c                               │    107 │      0 │    107 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/11    │    0.00% │
│ util/intel-bts.c                              │    623 │      0 │    623 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/29    │    0.00% │
│ util/intel-pt-decoder/intel-pt-decoder.h      │     15 │      0 │     15 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/iostat.c                                 │     19 │      0 │     19 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/8     │    0.00% │
│ util/jitdump.h                                │      9 │      0 │      9 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ util/kvm-stat-arch/kvm-stat-arm64.c           │     31 │      0 │     31 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/7     │    0.00% │
│ util/kvm-stat-arch/kvm-stat-loongarch.c       │     44 │      0 │     44 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/7     │    0.00% │
│ util/kvm-stat-arch/kvm-stat-powerpc.c         │     91 │      0 │     91 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/14    │    0.00% │
│ util/kvm-stat-arch/kvm-stat-riscv.c           │     28 │      0 │     28 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/7     │    0.00% │
│ util/kvm-stat-arch/kvm-stat-s390.c            │     35 │      0 │     35 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/8     │    0.00% │
│ util/kvm-stat-arch/kvm-stat-x86.c             │     94 │      0 │     94 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/17    │    0.00% │
│ util/kvm-stat.c                               │    241 │      0 │    241 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/18    │    0.00% │
│ util/levenshtein.c                            │     33 │      0 │     33 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/memswap.c                                │     14 │      0 │     14 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ util/perf-regs-arch/perf_regs_aarch64.c       │    161 │      0 │    161 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/6     │    0.00% │
│ util/perf-regs-arch/perf_regs_arm.c           │     48 │      0 │     48 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ util/perf-regs-arch/perf_regs_csky.c          │     86 │      0 │     86 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ util/perf-regs-arch/perf_regs_loongarch.c     │     80 │      0 │     80 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ util/perf-regs-arch/perf_regs_mips.c          │     76 │      0 │     76 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ util/perf-regs-arch/perf_regs_powerpc.c       │    189 │      0 │    189 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/6     │    0.00% │
│ util/perf-regs-arch/perf_regs_riscv.c         │    137 │      0 │    137 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/6     │    0.00% │
│ util/perf-regs-arch/perf_regs_s390.c          │    127 │      0 │    127 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/6     │    0.00% │
│ util/perf_regs.h                              │      3 │      0 │      3 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/powerpc-vpadtl.c                         │    418 │      0 │    418 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/23    │    0.00% │
│ util/print_insn.c                             │     31 │      0 │     31 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/4     │    0.00% │
│ util/pstack.c                                 │     39 │      0 │     39 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/6     │    0.00% │
│ util/s390-cpumsf.c                            │    673 │      0 │    673 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/31    │    0.00% │
│ util/s390-sample-raw.c                        │    227 │      0 │    227 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/13    │    0.00% │
│ util/sharded_mutex.c                          │     20 │      0 │     20 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
│ util/sharded_mutex.h                          │      3 │      0 │      3 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/spark.c                                  │     21 │      0 │     21 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/srccode.c                                │    110 │      0 │    110 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/5     │    0.00% │
│ util/stream.c                                 │    222 │      0 │    222 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/17    │    0.00% │
│ util/topdown.c                                │      2 │      0 │      2 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/1     │    0.00% │
│ util/values.c                                 │    216 │      0 │    216 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/10    │    0.00% │
│ util/zlib.c                                   │     65 │      0 │     65 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/2     │    0.00% │
├───────────────────────────────────────────────┼────────┼────────┼────────┼─────────────────────────────┼─────────────┼──────────┤
│ TOTAL (perf)                                  │ 173244 │  91059 │  82185 │ ██████████░░░░░░░░░░  52.6% │  5868/9306  │   63.06% │
└───────────────────────────────────────────────┴────────┴────────┴────────┴─────────────────────────────┴─────────────┴──────────┘
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbx perf-tools-next]$
