Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB81487D1;
	Thu, 31 Oct 2024 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730403601; cv=none; b=qUoCdbQEkqwjC3ZEobrhHuv6S4Wx1DFpahHloGz1Lq7AqQIcWdc4bq0/UmjAwCTvxT+t6xT1JuZ6iKwVN1mB91Rn069uhi3LGvHGQY7WYO+kZlJjxgL7SQXK6Olklsbg4oKTuwUjluQwNJTvkRgTwlU3s3wMukBuH6TjMZjlM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730403601; c=relaxed/simple;
	bh=io4qHfmMVBKytswsn/0wnXSiX/bDow++2q8sRHD+t1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg8kBYyKSL4EkKozU84JyURzud8BYuzLCZsm9EHwAdrYc0rDyXUHM5Wp3xvo+dpzzOTfxqFtXsHRSI40AwZxz830xNXDKvCgMOPniA7+1A3QLeXkDsW11rJNiOP6QYge+gty/P6nS9N+5FhQ+m8HfISffiTU0x+wsXFzakMiBv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCGM6EPB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCGM6EPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292CAC4CEC3;
	Thu, 31 Oct 2024 19:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730403600;
	bh=io4qHfmMVBKytswsn/0wnXSiX/bDow++2q8sRHD+t1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCGM6EPBTPRUhNMKoqpWoeA9kc4V2pt/LuuBmLzKd370RO7k80hhrMAL70Z+W2MlZ
	 80JHpDKE2cP3mDGZbTxIg0OugyD9POVJLkndcqngRbvCtThpIfI9m7O5kmbXijIueJ
	 32Bh8scrUtrP0vHAK86s8jETEEKkRv7xjmxluFz71hKXksf41jnnMIpj0uPYD3SHbZ
	 Qq5OenXomu3vxPkpIEIGl1cIs1D2cnDoVQiH8qeJ5Xu+Lw2lD7j1N8QlxiuB9IA4oM
	 1rXFmcGwg1OHAOSXM10AZWsoC8lBKm1eTUwXXP1QFtDN4Fr3yf/J5usFOufdcdyyeY
	 UTq0IBrFzfGYg==
Date: Thu, 31 Oct 2024 16:39:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 00/21] Python module cleanup
Message-ID: <ZyPdDaaqwy7PM57S@x1>
References: <20241031014252.753588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-1-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:31PM -0700, Ian Rogers wrote:
> This patch:
>  - removes workarounds for Python 2 module support due to long
>    deprecation and challenges in developing new code;
>  - constifies variables and parameters to functions;
>  - removes python.c stub code which existed due to missing functions
>    that are defined in the builtin-* files, in general the builtin-*
>    code is moved into util;
>  - remove bench and test perf C code from the python module;
>  - adds parse_events to the python perf module.
>  - improves upon some of the existing python perf module functins.
> 
> v5. Rebase. Fix NO_LIBBPF and NO_AUXTRACE related build failures
>     caught by Arnaldo and the build-test. Fix NO_AUXTRACE x86
>     arch_fetch_insn in the process, which was incorrectly using an
>     empty weak symbol stub.


I created a 'perf test' shell entry to test the python binding and ran
it after each relevant patch in this series, as well as doing 'perf
script -' to list available scripts, all seem to work.

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

I'll send the perf test entry now.

- Arnaldo


> v4. Rebase. Fix the parse events evsel to be embedded in a
>     pyrf_evsel. Add __str__/__repr__ functions to evlist and
>     evsel. Throw an exception for a bad evlist index.
> v3. Move is_directory_at to patch 6 rather than patch 7, respond to
>     review feedback on the list from Namhyung.
> v2. Add the bottom 4 bullet points - 13 more patches.
> 
> Ian Rogers (21):
>   perf python: Remove python 2 scripting support
>   perf python: Constify variables and parameters
>   perf python: Remove unused #include
>   perf script: Move scripting_max_stack out of builtin
>   perf kvm: Move functions used in util out of builtin
>   perf script: Move find_scripts to browser/scripts.c
>   perf stat: Move stat_config into config.c
>   perf script: Move script_spec code to trace-event-scripting.c
>   perf script: Move script_fetch_insn to trace-event-scripting.c
>   perf script: Move perf_sample__sprintf_flags to
>     trace-event-scripting.c
>   perf x86: Define arch_fetch_insn in NO_AUXTRACE builds
>   perf intel-pt: Remove stale build comment
>   perf env: Move arch errno function to only use in env
>   perf lock: Move common lock contention code to new file
>   perf bench: Remove reference to cmd_inject
>   perf kwork: Make perf_kwork_add_work a callback
>   perf build: Remove test library from python shared object
>   perf python: Add parse_events function
>   perf python: Add __str__ and __repr__ functions to evlist
>   perf python: Add __str__ and __repr__ functions to evsel
>   perf python: Correctly throw IndexError
> 
>  tools/perf/Makefile.perf                      |   7 +-
>  tools/perf/arch/x86/util/Build                |   2 +-
>  tools/perf/bench/inject-buildid.c             |  13 +-
>  tools/perf/builtin-kvm.c                      |  61 ----
>  tools/perf/builtin-kwork.c                    |   3 +-
>  tools/perf/builtin-lock.c                     | 137 +------
>  tools/perf/builtin-script.c                   | 304 +---------------
>  tools/perf/builtin-stat.c                     |  27 --
>  tools/perf/builtin-trace.c                    |   1 -
>  tools/perf/builtin.h                          |   6 -
>  .../scripts/python/Perf-Trace-Util/Context.c  |  20 +-
>  tools/perf/tests/stat.c                       |  16 +-
>  tools/perf/trace/beauty/arch_errno_names.sh   |   3 +-
>  tools/perf/ui/browsers/scripts.c              | 177 ++++++++-
>  tools/perf/util/Build                         |   4 +-
>  tools/perf/util/bpf_kwork.c                   |   2 +-
>  tools/perf/util/bpf_kwork_top.c               |   2 +-
>  tools/perf/util/bpf_lock_contention.c         |   2 +-
>  tools/perf/util/cgroup.c                      |   2 +-
>  tools/perf/util/config.c                      |  27 ++
>  tools/perf/util/dlfilter.c                    |   3 +-
>  tools/perf/util/env.c                         |   4 +
>  tools/perf/util/env.h                         |   2 -
>  tools/perf/util/evsel.c                       |  19 +-
>  tools/perf/util/evsel.h                       |   2 +-
>  tools/perf/util/intel-pt-decoder/Build        |  18 +-
>  .../intel-pt-decoder/intel-pt-insn-decoder.c  |   3 -
>  tools/perf/util/kvm-stat.c                    |  70 ++++
>  tools/perf/util/kvm-stat.h                    |   3 +
>  tools/perf/util/kwork.h                       |   6 +-
>  tools/perf/util/lock-contention.c             | 170 +++++++++
>  tools/perf/util/lock-contention.h             |  37 +-
>  tools/perf/util/path.c                        |  10 +
>  tools/perf/util/path.h                        |   1 +
>  tools/perf/util/python.c                      | 338 ++++++++----------
>  .../scripting-engines/trace-event-python.c    |  63 +---
>  tools/perf/util/stat.h                        |   3 +-
>  tools/perf/util/trace-event-scripting.c       | 177 +++++++++
>  tools/perf/util/trace-event.h                 |   5 +-
>  39 files changed, 872 insertions(+), 878 deletions(-)
>  create mode 100644 tools/perf/util/kvm-stat.c
>  create mode 100644 tools/perf/util/lock-contention.c
> 
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
