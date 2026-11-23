Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795399460;
	b=JhVcXtV32Raf1p+HZRnB13WJf7DS4GgpwVtNRPBhaw8350F/bmU1wjHGaCBuc45KHwDY
	 yRe6bxbS5VazfqO82PFZ9KzGAtO6qYYur/OdtIAbABhz4n9Rg1QCwFut/ws4E5V/D/5xR
	 i+DLCXAhITfIS/JLL2w0Q7nXezO9DJ0kA6xh6eFTrFg99swJ4FEBlz48njbbIkP431T0q
	 yNvQY2gUTpMWb4vOhcxqGQN52oo7mTqqwEg4b7QbHG4/EEu+nZIYrMrtC0fVPbsvlbcfX
	 CVq4kL0mi10KjxAMqIgSN5o7u4g4gR74iYcq8d01ZuW4d6a3bgluXWraPBhRU22oTLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795399460;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PG7NbfVZS95X4OeWZBdwOuqcV1WLko1jrGjZoh7koWc=;
	b=efvLDEvLIvOIqkikDB+z0dKppOqC+w+StErjFAW6K4fqXLjH5u1OD/5oGlQ2tPYhfT9o
	 sbEkqYS6joC3A8Iu/WT5RWhp9gQaIIj2iBfnEUA2WnCoSqCXW6xSawZbRR6yt6hpFkMyg
	 cBG2XwwQrz/SLRawjJtJluDAh+wIzeq3qksIkFRG4Sd2rQrz38RNzCSHLblXfYhzL8wvh
	 BonZkCrFDFJLE6dqYkXbNOQjDi9oKuf/8wVliyUT8PqgUZiMPGnxqs8+VaZADGgUDVksG
	 eV6YyOWDUmc1WZEvchSLXS1rjzoL/H+zU5dQndDnK+TWhNL/A7a/hC+4Ww0joWZsWlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lldiyV6s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B89606A31A;
	Mon, 23 Nov 2026 02:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lldiyV6s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA4C1F000C0;
	Mon, 23 Nov 2026 02:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795399460;
	bh=PG7NbfVZS95X4OeWZBdwOuqcV1WLko1jrGjZoh7koWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lldiyV6sFlKm5Vn0TclvkXCY+LbOaZqfv9QS0PHA/2jE95tU/+G30wZ5EZtqP1ruK
	 3rGIxw1NsNZbcG9/6qfj13c/mJmGG2VoMOIig0xwzNinwdxUsm1Cfi/C0UgiU8oPsO
	 40qdqIJ4Gjx7E8Xr3w2PvpMRPARDoQigWZNE3KWT+RV8GcB3xwVdDbbeZO/qo9NgVz
	 N93wFS/zSNwif4ewDCEfCW3Ut4JJT/BSWeiEbDKSLje/CSpmV7QKe3YtKhBZjz7H/u
	 7uLtIJmIhavhaL63RWI33DGkd7PQXcJCKuhwPgtDgi8h0Dp5Jc2AwHzsnumtqf+egI
	 E7v3+TPoRJtJg==
Date: Sun, 22 Nov 2026 18:04:18 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/7] perf script: Lazy symbol loading
Message-ID: <awOfIqFfrbwmnwRP@google.com>
References: <20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com>
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
In-Reply-To: <20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com>

On Sat, Nov 21, 2026 at 08:41:00AM -0800, Alireza Haghdoost via B4 Relay wrote:
> perf script loads the entire ELF symbol table of every DSO that appears
> in a sample, and keeps each symbol, with its demangled name, until
> process exit. Most of those symbols are never sampled. On a large
> profile this turns symbol loading into the main memory cost of perf
> script, and in a memory-constrained cgroup into an OOM kill.
> 
> With this series, perf script --lazy-load-symbols reads a symbol name
> only when a sample needs it. On a perf script run over a 45,073-sample
> callchain profile of a large C++ service (about 1M symbols), the output
> is identical in all three cases (medians of eleven runs):
> 
>                                       time    max RSS
>   perf-tools-next                     3.70 s  319 MiB
>   v8                                  3.75 s  327 MiB
>   v8 --lazy-load-symbols              3.56 s  174 MiB
> 
> Eager loading remains the default, and costs 8 more bytes per symbol for
> the name pointer. Lazy loading covers userspace ELF .symtab and .dynsym.
> The kernel, modules, PPC64 .opd and .gnu_debugdata still load names
> eagerly.
> 
> The patches:
> 
>   [1/7] Split the size, type and binding checks out of
>         choose_best_symbol(), so that the loader can tell which aliases
>         need their names. No functional change. Unchanged from v7,
>         reviewed by Ian.
> 
>   [2/7] Make the symbol name a pointer instead of a flexible array, so
>         that a name can be set after the symbol is in the rb-tree.
>         Unchanged from v7, reviewed by Ian.
> 
>   [3/7] Add lazy symbol names to the symbol code: the DSO lookups read
>         the name of the symbol they return. Nothing creates such
>         symbols yet.
> 
>   [4/7] Check that the symbol table file is still the one perf loaded
>         before reading names from it. Nothing records a file yet.
> 
>   [5/7] Add --lazy-load-symbols, which makes the ELF loader create
>         symbols with lazy names and record the file for the check.
> 
>   [6/7] Unit tests for lazy names and for the file check.
> 
>   [7/7] Shell tests, including parity with eager loading.
> 
> perf-tools-next now has the first three patches of Ian's series [1].
> Its later patches replace the symbol rb-tree with an array, which would
> shrink each symbol further. They conflict with this series, since the
> name loading in 3/7 and the alias name loading in 5/7 walk that
> rb-tree. This series does not depend on them, and I'll rebase on them
> if they land first.

I'm about to merge Ian's series first.  Please rebase accordingly after
it's landed.  I hope it'll make your change a bit easier.

Also please add the option to the perf report and perf top too.

Thanks,
Namhyung

> 
> [1] https://lore.kernel.org/all/20261117185305.108003-1-irogers@google.com/
> 
> Changes in v8:
> 
> - Rebase onto current perf-tools-next, which has Ian's annotation and
>   ELF loader changes.
> - Split v7 3/4 for review (Namhyung): 3/7 adds lazy names to the symbol
>   code, 4/7 adds the check of the symbol table file, and 5/7 adds the
>   option and makes the ELF loader create lazy names. The tests are in
>   6/7 (unit) and 7/7 (shell).
> - 4/7: Also accept a file whose device, inode, size, mtime or ctime
>   changed if it has the build ID of the DSO and its .strtab and .dynstr
>   did not move, such as a copy of the same build (Namhyung). The
>   identity is still checked first, since reading the build ID at each
>   reopen more than doubles the time of the worst case.
> - 4/7: Compare the ctime too, so a file copied over in place with its
>   size and mtime kept (cp -p) is not taken for the same file. Treat a
>   string table section that no longer exists or is compressed as
>   another file.
> - 4/7: Warn once when the file cannot be opened or checked, rather than
>   only in debug output, and try again for later names, since the
>   failure can be temporary.
> - 5/7: Do not skip the .dynsym copies of lazy .symtab symbols. Skipping
>   them changed the shape of the rb-tree, which broke lookups past a
>   nested entry point and the PLT name of an exported IFUNC. This
>   replaces the v7 fix for a zero-size symbol before a copy (Sashiko).
>   Duplicate selection now reads the names of each copy, so on the
>   profile above, where one binary exports most of its symbols, lazy
>   loading keeps its memory saving but loses most of the run time it
>   saved in v7. Most of that time goes to reading each name with its own
>   pread(). As discussed with Namhyung, a later series will let the DSO
>   data cache read the symbol table file, and names will be read through
>   it. A prototype with a small read cache gets back about two thirds of
>   the v7 speedup for about 1.5 MiB more RSS.
> - 6/7: Add tests for a file overwritten in place, for a copy with the
>   same build, with moved or missing string tables, and of another build,
>   for a failed open, and for a copy whose build ID cannot be read.
> - 7/7: Add parity cases for a zero-size symbol before a copy, nested
>   entry points, and an exported IFUNC with aliases.
> 
> Previous versions:
> 
> v7: https://lore.kernel.org/all/20261113-perf-symbol-memory-send-v7-0-d992eced9f9c@uber.com/
> v6: https://lore.kernel.org/all/20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com/
> v5: https://lore.kernel.org/all/20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com/
> v4: https://lore.kernel.org/all/20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com/
> v3: https://lore.kernel.org/all/20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com/
> v2: https://lore.kernel.org/all/20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com/
> v1: https://lore.kernel.org/all/20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com/
> 
> ---
> Alireza Haghdoost (7):
>       perf symbols: Split out name-independent duplicate symbol selection
>       perf symbols: Point to the symbol name instead of embedding it
>       perf symbols: Add lazy symbol names
>       perf symbols: Check the file before reading lazy symbol names
>       perf script: Add --lazy-load-symbols to load symbol names lazily
>       perf test: Add lazy symbol loading unit tests
>       perf test: Add lazy symbol loading shell tests
> 
>  tools/perf/Documentation/perf-script.txt           |  11 +
>  tools/perf/builtin-script.c                        |   2 +
>  tools/perf/tests/Build                             |   1 +
>  tools/perf/tests/builtin-test.c                    |   1 +
>  tools/perf/tests/shell/lazy_load_symbols_parity.sh | 447 ++++++++++
>  tools/perf/tests/shell/lib/lazy_names.sh           |  20 +
>  tools/perf/tests/shell/script_lazy_load_symbols.sh | 190 ++++
>  tools/perf/tests/symbol-lazy.c                     | 963 +++++++++++++++++++++
>  tools/perf/tests/tests.h                           |   1 +
>  tools/perf/ui/browsers/map.c                       |   2 +-
>  tools/perf/ui/stdio/hist.c                         |   1 +
>  tools/perf/util/dso.c                              |   2 +-
>  tools/perf/util/dso.h                              |  36 +-
>  tools/perf/util/symbol-elf.c                       | 355 +++++++-
>  tools/perf/util/symbol-minimal.c                   |   6 +
>  tools/perf/util/symbol.c                           | 141 ++-
>  tools/perf/util/symbol.h                           |  31 +-
>  tools/perf/util/symbol_conf.h                      |   1 +
>  18 files changed, 2183 insertions(+), 28 deletions(-)
> ---
> base-commit: bb27ddbaee56536fb8df0a24f07b526766dfe131
> change-id: 20260915-perf-symbol-memory-send-e7cfca1ac3d9
> 
> Best regards,
> --  
> Alireza Haghdoost <haghdoost@uber.com>
> 
> 
