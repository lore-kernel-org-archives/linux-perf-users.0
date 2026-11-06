Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948675;
	b=4No7DphOIIo8JOi/mtc/rAE+u4eoF4SQX5c9fHRxLrzMhyBW4pqk1B4ILN/qOX2MVD7v
	 JDSsMEPz9pAiev8T2FQpnDcr+dZw8MwqBx5y+bVyo9T8fCM3ZRouA6URk4lpJX5KHttXh
	 ylFZDhKgJ1gEYqwOYpbIJ7oq58MLyniNSfxSftNJ3vhmJnf+IBJTUQP+/lcqpCDFiH8fV
	 0k72xlHOpj588dPHImj9k0KfSUPTDaPXlmqFq98zewlxsBrqdm5Id7oG/O72vtQp3UldG
	 mzHbnrcMkTBo0GK0gLAxtK/5Msbl5ExDVGdvI9wEZ/gbP30zG//tVLRhuxC/06Se3GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948675;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xQimsWMweTVt7aA1nxhPWFC6IqDq+APLqir/fJvyBQg=;
	b=qt3FUmsToQSzEqApSfosbmVecnuXzxka9vgrmUu1nPqwl5cIkjnh/LZ7utxDvzsM3yfp
	 9bWdOp/5vhwuzeieScK0H+xpvLUEwNYtHgWv5DimPHF9RjlWWwPw+Fdid/XnMgCmwUknh
	 zBS3VwUdMBGrNdJjB956kU5Uv2/jn7dn/7GSDopE+HN8cqQR6CeUPGu8umy4GeOfRhoU1
	 WWGl9s9yaD1wIsq+/mr1bLvPbgL5hQ4pniHw95/+2ivUuT8OAM42Bo09uceBe8hQ4FOJi
	 /K/xFA0OdTD1Ii90GBairtwQxKW3ykKKHiviVsgzNwL0vJPOqSZVPqg5z6sLP++9BJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ULnrK42b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915FE606D809;
	Fri,  6 Nov 2026 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ULnrK42b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC7B1F008A6;
	Fri,  6 Nov 2026 07:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793948675;
	bh=xQimsWMweTVt7aA1nxhPWFC6IqDq+APLqir/fJvyBQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ULnrK42bPE01fMWEWfXVKoIma+mQPNtmIPqGhB3EsCECgsG/PEjd4m8f5RUtLAF73
	 hOGC8b1sMx1BG5sIv3CYGaeZ/PUjWuk4wu6Hi854Xr3HiI/9fzTx23c2DF0vCouEFu
	 Bx0C2NWNGiThOEW4m30T98q6Afzyyq67Ue7nF9PgRbLHximjY7I1PWusk0dk8WrPZM
	 6/Ik0K63vzw4ptjPhhWA7/8o8fyblvYF4CfysqF6wuUoKlgC5FNj2BfBmZMh/Hkek4
	 u8qMIcxHL20lKMMeWkkZVTMuUltGsMeesVBSQNdu+nla6+VZ00v6N4t/80qnFyIYtN
	 dCGIxh/9ZJISw==
Date: Thu, 5 Nov 2026 23:04:32 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 0/2] perf unwind: Don't load symbols when the caller
 doesn't need them
Message-ID: <au18AJ94dUsE5PaQ@google.com>
References: <20261030193237.1440673-1-thepacketgeek@gmail.com>
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
In-Reply-To: <20261030193237.1440673-1-thepacketgeek@gmail.com>

Hello,

On Fri, Oct 30, 2026 at 12:32:32PM -0700, Matthew Wood wrote:
> When perf only needs to know which DSOs a callchain passes through (as
> build-id marking does at the end of 'perf record' and in 'perf inject
> -b') it resolves the callchain without symbols. The DWARF unwinders
> ignore that and look up the symbol of every frame anyway, which loads
> and demangles the whole symbol table of each DSO they visit.
> 
> On arm64 every frame pointer sample also gets a short DWARF
> unwind to find the leaf function's caller; since v6.17 (commit
> 29be60c93d2d, "perf build-id: Mark DSO in sample callchains") the end of
> 'perf record -a --call-graph fp' loads the symbols of every user binary
> it sampled. On a 128-CPU arm64 host,
> 
>   perf record -a -e cycles:u --call-graph fp -- sleep 2
> 
> never finishes writing perf.data, with over 1GB of heap growth in 5
> seconds.
> 
> Skipping the symbol lookup isn't enough because loading the
> symbols also finds two things the unwinders depend on: the DSO's
> build-id, which libdw needs to fall back to the build-id cache, and any
> separate debuginfo file, through dso__symsrc_filename(), which is how
> both unwinders find a .debug_frame there.
> 
>   1: add dso__load_symsrc(), which does the same search for debuginfo
>      and the build-id as symbol loading, but doesn't read any symbols
>   2: pass the symbols flag down to the unwinders and honour it, using
>      dso__load_symsrc() when symbols aren't wanted, which also makes
>      the arm64 leaf frame caller unwind skip symbols

Please don't.  I've added dso__dbginfo_type() to handle debug files and
that's the correct way to get the file.  Probably dso__debuginfo() would
work for you.

I was working on cleaning up this area, but sidetracked by other things.
I hope to find time for it soon but you can go with the above helpers.

Thanks,
Namhyung

> 
> Testing compared v7.3-rc7 with this series, on x86 and natively on a
> CentOS Stream 10 arm64 host:
> 
>  - The 'perf test' dwarf unwind and 'perf inject' DWARF callchain
>    conversion tests pass on both, also in a REFCNT_CHECKING build on
>    x86. The libdw multi-threaded unwind and addr2line inline unwinding
>    tests pass on x86; on the arm64 host the former is skipped and the
>    latter fails both with and without this series.
> 
>  - 'perf inject -b' on an x86 'perf record --call-graph dwarf' profile
>    of a Python workload goes from 0.19s and 69MB max RSS to 0.10s and
>    33MB, with the same build-ids injected.
> 
>  - A test library built with -fno-asynchronous-unwind-tables, so that
>    its CFI is only in .debug_frame, then split with 'objcopy
>    --only-keep-debug', sits between two other DSOs in the sampled
>    stacks. On both architectures, with the debuginfo found either
>    through .gnu_debuglink or only in perf's build-id cache, 'perf
>    script' output for a --call-graph dwarf profile, and on arm64 for an
>    fp profile, is unchanged with both libdw and libunwind, and 'perf
>    inject -b' unwinds the same frames and marks the same DSOs. v1,
>    which only passed the flag down, lost every frame past the library
>    in all but 5 of 4045 samples in 'perf script'.
> 
> libunwind's .debug_frame support couldn't be exercised: EL9's x86
> libunwind is built without it, and on arm64 perf's libunwind support
> has been compiled out since v7.2, as libunwind-arm64.c checks
> HAVE_LIBUNWIND_ARM64_SUPPORT while Makefile.config defines
> HAVE_LIBUNWIND_AARCH64_SUPPORT. With that macro defined by hand, and a
> cast for the build error it then hits, arm64 libunwind results are also
> the same with and without this series. That breakage is independent of
> this series.
> 
> Not tested: the build-id cache fallback for DSOs in another mount
> namespace when the MMAP2 events don't carry build-ids.
> 
> Changes since v2:
>   - Instead of a separate debuginfo lookup, reuse dso__load()'s search
>     and stop before reading symbols (dso__load_symsrc()) so candidate
>     files are checked against the build-id, --symfs, mount namespaces
>     and chroots are honoured, and the search is done once per DSO
>   - Drop moving dso__read_build_id() out of 'perf inject'
>   - Extend the dwarf unwind test to unwind without symbols, check that
>     no symbols get loaded, and compare with unwinding with symbols
>   - Link:
>     https://lore.kernel.org/all/20261017000158.1178269-1-thepacketgeek@gmail.com/
> 
> Changes since v1:
>   - Complete re-work on approach based on feedback
>   - Link: https://lore.kernel.org/linux-perf-users/20261014151326.4142140-1-thepacketgeek@gmail.com/
> 
> Matthew Wood (2):
>   perf symbol: Add dso__load_symsrc()
>   perf unwind: Don't look up symbols when the caller doesn't want them
> 
>  tools/perf/tests/dwarf-unwind.c               | 71 ++++++++++++++++---
>  .../util/arm64-frame-pointer-unwind-support.c |  7 +-
>  tools/perf/util/dso.h                         | 11 +++
>  tools/perf/util/machine.c                     |  7 +-
>  tools/perf/util/symbol.c                      | 40 +++++++++--
>  tools/perf/util/symbol.h                      |  1 +
>  tools/perf/util/unwind-libdw.c                | 17 ++++-
>  tools/perf/util/unwind-libdw.h                |  1 +
>  tools/perf/util/unwind-libunwind.c            | 22 ++++--
>  tools/perf/util/unwind.c                      |  7 +-
>  tools/perf/util/unwind.h                      | 11 ++-
>  11 files changed, 164 insertions(+), 31 deletions(-)
> 
> 
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> -- 
> 2.53.0-Meta
> 
