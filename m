Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA336224B15;
	Wed, 10 Jun 2026 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122483; cv=none; b=B194U+9SvZEYUc6jFXEinLXoeLNItHW4S4qBYs+bi3INATy1EuPnkZXaDM8BhpDqmWRJd/jlgmwC+aqtujsK3xaD58kq5BjusaVlwR3Xf09PBwhoieRCw/+Gd04MBbNuQAoEGiKchjHid4+0xxgvYmB1jTsREfzyNl8zKWsGW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122483; c=relaxed/simple;
	bh=3RxX2FyRQQa8heoLj42OYaT9uLCGSZnUpQe4qmTNQqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InxugSxYkfQrvsc8mbTZ1Kc+isNgnEN2QiOq3diAUhbOoleoNH8l0aaoUSHw/3rwDeDXc79X2kSDnQmL55yVrf0AMJniZZjjFcMFRv8T4p+958q5rlcbnHtchEUdjY/0KvgL6mpzwteutFn2Qq0u4X1p/zjvsJBr809rpupxhKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLVJ6puA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLVJ6puA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78E51F00893;
	Wed, 10 Jun 2026 20:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781122479;
	bh=QBHhgJ5rPR8+Lum7+XyXvPm6/Ckn6DZvX5YcfbbqSOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GLVJ6puA8GbUE50OTKt6onOc5YYaFlPgTEbtkhKO1Y0tZ37RMU5lA83A9fqG7zA8f
	 R1M0N/1QVuVKHmwzmKS7AXlOIUKylSvRR3UJZuyJU+xQomBXC+tQS9WyBX6wZOheE6
	 bPydwUQ1k9PmGPWcMtfU0m5ARO+cGTgTJ022HVrj2bKTErfAoVSspUY1uQTfuVT8Px
	 iIsvxV9whlCHfGa7VUOYEAC6Q5JTcGy48v2ZeMesc0nxpnyBAj0LxArXczuoP5c2Zg
	 5JFI8FJc1CitXdtdrrjFNQ47GUY4pwCKbn0k3xO1aPotn7fyxiLpYVMNnsuxjHvlD4
	 RgRDlhDQEc00w==
Date: Wed, 10 Jun 2026 17:14:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paschalis Mpeis <Paschalis.Mpeis@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 00/19] perf cs-etm: Queue context packets for frontend
Message-ID: <ainFqtxdLwhbRqrI@x1>
References: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>

On Tue, Jun 09, 2026 at 03:40:05PM +0100, James Clark wrote:
> Fix thread tracking when decoding Coresight trace and add a new test for
> it.

The issues found by sashiko seem mild and you can address them in follow
up patches, I think.

So for the benefit of having perf-tools-next available for linux-next
testing and the window is closing soon, so I've merged this, ok?

- Arnaldo
 
> The new test is added as a Perf test workload instead of a custom binary
> with its own build system, but this requires a new feature in Perf test
> to pass in control pipes which can enable and disable events. This
> scopes the recording to just the workload and helps to reduce the amount
> of data recorded in tracing tests.
> 
> With this new feature we can re-write all of the Coresight tests to make
> use of it and remove the remaining binaries which fixes the following
> issues:
> 
>  * They didn't work in out of source builds
>  * A lot of the tests unnecessarily required root and didn't skip
>    without it
>  * They were mainly qualitative tests which didn't look for specific
>    behavior
> 
> Most importantly, the long build and runtime has been reduced. On a
> Radxa Orion O6, unroll_loop_thread.c took 37s to compile which is longer
> than the entire Perf build. Now the build time is negligible and the
> before and after test runtimes for all the Coresight tests are:
> 
>           |   N1SDP   |   Orion O6
>   -----------------------------------
>   Before  |   4m  0s  |    14m 49s
>   After   |      26s  |        56s
>   -----------------------------------
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> Changes in v5:
> - Forgot to include this change:
>   - Test for actual length of expected raw dump (Leo)
> - Link to v4: https://lore.kernel.org/r/20260609-james-cs-context-tracking-fix-v4-0-44f9fb9e5c42@linaro.org
> 
> Changes in v4:
> - Rename workload-ctl to record-ctl and improve docs (Leo)
> - Use new packet argument everywhere in
>   cs_etm__synth_instruction_sample() (Sashiko)
> - Test for actual length of expected raw dump (Leo)
> - Use -fno-inline instead of keyword (Leo)
> - Don't test any brace or call lines in deterministic test
> - Make sure context switch loop test does cleanup on failure (Sashiko)
> - Remove undef int overflows in workloads (Sashiko)
> - Link to v3: https://lore.kernel.org/r/20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org
> 
> Changes in v3:
> - Minor sashiko comments
>   - Close some more pipes
>   - Fix warning messages
>   - Error handling improvements
> - Pass packet into cs_etm__synth_instruction_sample()
> - Fixup stale comment (Leo)
> - Link to v2: https://lore.kernel.org/r/20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org
> 
> Changes in v2:
> - Add --workload-ctl option to Perf test
> - Re-write all the Coresight tests and speed them up
> - Pass packet to memory access function so frontend can use either the
>   previous or current packet's EL
> - Link to v1: https://lore.kernel.org/r/20260526-james-cs-context-tracking-fix-v1-0-ebd602e18287@linaro.org
> 
> ---
> James Clark (19):
>       perf cs-etm: Queue context packets for frontend
>       perf test: Add workload-ctl option
>       perf test: Add a workload that forces context switches
>       perf test cs-etm: Test process attribution
>       perf test: Add deterministic workload
>       perf test cs-etm: Replace unroll loop thread with deterministic decode test
>       perf test cs-etm: Remove asm_pure_loop test
>       perf test cs-etm: Replace memcpy test with raw dump stress test
>       perf test: Add named_threads workload
>       perf test cs-etm: Test decoding for concurrent threads test
>       perf test cs-etm: Remove duplicate branch tests
>       perf test cs-etm: Skip if not root
>       perf test cs-etm: Reduce snapshot size
>       perf test cs-etm: Speed up basic test
>       perf test cs-etm: Remove unused Coresight workloads
>       perf test cs-etm: Make disassembly test use kcore
>       perf test cs-etm: Add all branch instructions to test
>       perf test cs-etm: Speed up disassembly test
>       perf test cs-etm: Move existing tests to coresight folder
> 
>  Documentation/trace/coresight/coresight-perf.rst   |  78 +------
>  MAINTAINERS                                        |   2 -
>  tools/perf/Documentation/perf-test.txt             |  24 ++-
>  tools/perf/Makefile.perf                           |  14 +-
>  tools/perf/scripts/python/arm-cs-trace-disasm.py   |  20 +-
>  tools/perf/tests/builtin-test.c                    | 187 +++++++++++++++-
>  tools/perf/tests/shell/coresight/Makefile          |  29 ---
>  .../perf/tests/shell/coresight/Makefile.miniconfig |  14 --
>  tools/perf/tests/shell/coresight/asm_pure_loop.sh  |  22 --
>  .../tests/shell/coresight/asm_pure_loop/.gitignore |   1 -
>  .../tests/shell/coresight/asm_pure_loop/Makefile   |  34 ---
>  .../shell/coresight/asm_pure_loop/asm_pure_loop.S  |  30 ---
>  .../tests/shell/coresight/concurrent_threads.sh    |  45 ++++
>  .../tests/shell/coresight/context_switch_thread.sh |  69 ++++++
>  tools/perf/tests/shell/coresight/deterministic.sh  |  72 +++++++
>  .../tests/shell/coresight/memcpy_thread/.gitignore |   1 -
>  .../tests/shell/coresight/memcpy_thread/Makefile   |  33 ---
>  .../shell/coresight/memcpy_thread/memcpy_thread.c  |  80 -------
>  .../tests/shell/coresight/memcpy_thread_16k_10.sh  |  22 --
>  .../perf/tests/shell/coresight/raw_dump_stress.sh  |  65 ++++++
>  .../shell/{ => coresight}/test_arm_coresight.sh    |  43 ++--
>  .../{ => coresight}/test_arm_coresight_disasm.sh   |  23 +-
>  .../tests/shell/coresight/thread_loop/.gitignore   |   1 -
>  .../tests/shell/coresight/thread_loop/Makefile     |  33 ---
>  .../shell/coresight/thread_loop/thread_loop.c      |  85 --------
>  .../shell/coresight/thread_loop_check_tid_10.sh    |  23 --
>  .../shell/coresight/thread_loop_check_tid_2.sh     |  23 --
>  .../shell/coresight/unroll_loop_thread/.gitignore  |   1 -
>  .../shell/coresight/unroll_loop_thread/Makefile    |  33 ---
>  .../unroll_loop_thread/unroll_loop_thread.c        |  75 -------
>  .../tests/shell/coresight/unroll_loop_thread_10.sh |  22 --
>  tools/perf/tests/shell/lib/coresight.sh            | 134 ------------
>  tools/perf/tests/tests.h                           |   3 +
>  tools/perf/tests/workloads/Build                   |   4 +
>  tools/perf/tests/workloads/context_switch_loop.c   | 110 ++++++++++
>  tools/perf/tests/workloads/deterministic.c         |  39 ++++
>  tools/perf/tests/workloads/named_threads.c         | 109 ++++++++++
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  21 +-
>  tools/perf/util/cs-etm.c                           | 236 ++++++++++++---------
>  tools/perf/util/cs-etm.h                           |   8 +-
>  40 files changed, 926 insertions(+), 942 deletions(-)
> ---
> base-commit: 351a37f2fda4db668cff8ba12f2992d73dccdaea
> change-id: 20260515-james-cs-context-tracking-fix-754998bae7ed
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
