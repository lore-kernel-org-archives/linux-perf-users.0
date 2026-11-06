Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940203;
	b=uocgyA9zhuTrm3syPx9JWmLveWIC/CLhJzhRKqz1GH0BUnvmNUedKx0oPXRF5xEfDwKb
	 XnQeiKniBnNvEeP0YlO6OgTWR0EmbqRk3sKjNZXU+k6di/qDpwQRy4xAN7TVRFc/6W5OH
	 H4ms7Lh29UDKKnY9zSkhTfpyESgwrrDLZkAYQ4CLTRa2SoN2rq0Sx02gaR02I02/t2T5e
	 yB43N6ran45wuf4SCAuQiz8LD7goWZswobwiaEi4LARS3DIP3mtU+d0JeEAXSfD7bNoef
	 jClLA/lSTHJr72x+8M5yKhd60S4TGP3CBVG71PJaHItC1eDyfj9YgWPvWdNi7cufKjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940203;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=o8OjnhRtQoLaSgCW0SZHC3nLjw+vz1fIGGzzH6VfheE=;
	b=MXYvAmaG7UwgVZyWC54aGjnXjEgmVO5RbpObKnhwLGpiE3P1D398gB+5wKk771T7yXNz
	 RfJQtQ5QxW7E7uiotMMs97tLpDvIT63uKTNBSYCqVyQ85JcMtsWoVIqVpfz9ih0+OEUYR
	 InNJDercth9pvhe+30mY/3rlw38dML8z+OEpGt1x1yVHS9vmPIkbTtkIO26ofXdzvxR/x
	 1rHWiHfMcnVI03rg31nivD4DZsQQYKzKdGNJ0iPu6m371LZ8sC3xtRvHTeeyEbUMflA9l
	 NQDUOe1Kjgnk373doax6DToRD7Rutyat9OQMhxaE31DENuskWio6rF8PU1X88uvQjpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Iux7/Sy/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C5F606A31B;
	Fri,  6 Nov 2026 04:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iux7/Sy/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C441F0089F;
	Fri,  6 Nov 2026 04:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793940202;
	bh=o8OjnhRtQoLaSgCW0SZHC3nLjw+vz1fIGGzzH6VfheE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Iux7/Sy/HKuNOajziTSwVE2l6C6V5ReTMjk5SN3myXNe8pwjhFVIg+3TyWecFk+1m
	 qGnjMiiR/lQCF3EOmXx1/oyC81avlOroz6kCCx/grib44IjysDMMzB5fe2dCfpXU8N
	 iqc7X9CL9C0Z4CoMSVICDH5q44Y8nhPY+VgwMsoMjPLK1BS6BgGcgWiIM7bQobrskz
	 cG1IcBewJeL7wZgZKIkEPG4lHsmI5JZosDQt7WD4j06MpcNpuP7hUcwFBijJXJG3tj
	 JEEEeT4cBkva6WVSXoCgPUljVDqQOHfNCClap3tWOf5akc48qzhJR7kcrlygwoRegR
	 wHsskf17jwIfw==
Date: Thu, 5 Nov 2026 20:43:18 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jakub Brnak <jbrnak@redhat.com>, Leo Yan <leo.yan@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] perf test: Don't starve per-process tests with
 system-wide events
Message-ID: <au1a5v8WozQm2RKU@google.com>
References: <20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org>
 <20261105-james-perf-test-fixes-v1-4-0b279bee5830@linaro.org>
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
In-Reply-To: <20261105-james-perf-test-fixes-v1-4-0b279bee5830@linaro.org>

On Thu, Nov 05, 2026 at 03:49:06PM +0000, James Clark wrote:
> Some tests intermittently fail when run in parallel, for example "Check
> branch stack sampling" fails with no branches recorded at all.
> 
> The default event is cycles:P which there may only be 1 or 2 HW counters
> for on Intel because it's precise. System wide or per-core precise
> events hog the HW counter leaving other per-process tests with no
> samples. Rather than make all the tests that use default record commands
> run serially, just make the system wide ones use a non-precise event.
> They don't need precise sampling anyway, so use plain cycles which can
> go on any counter. The per-process tests can be left alone as their
> events/processes never run concurrently on any one core.

One side effect of using default event is that it can fallback when it's
not available like on a VM or non-root.  Maybe better to use a software
event like cpu-clock instead.

Thanks,
Namhyung

> 
> The LBR filter is another resource shared by all events on a CPU, and
> the system-wide LBR test uses different filters to the per-process
> branch stack test, so mark the LBR test as exclusive.
> 
> This fixes the "Check branch stack sampling" test and other flakes when
> a system-wide record from another test runs at the same time, for
> example:
> 
>   $ sudo perf record -a -o /dev/null -- sleep 30 &
>   $ sudo perf test -vvv "Check branch stack sampling"
>   ...
>   Testing user branch stack sampling
>   ERROR: Branches missing ^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$
>   ...
>   Testing user branch stack sampling [Failed]
>   ...
>   Testing branch stack filtering permutation (call,CALL|SYSCALL)
>   Testing branch stack filtering [Failed empty script output]
>   ...
>   ---- end(-1) ----
>   138: Check branch stack sampling : FAILED!
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/tests/shell/record.sh          | 6 +++---
>  tools/perf/tests/shell/record_lbr.sh      | 2 +-
>  tools/perf/tests/shell/record_sideband.sh | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 01dc3e22fa73..5292eff78a70 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -388,7 +388,7 @@ test_system_wide() {
>    echo "Basic --system-wide mode test"
>    local ret=0
>    perf_record_with_retry "${perfdata}" "check_system_wide" "perf test -w thloop" \
> -    -aB --synth=no || ret=$?
> +    -aB --synth=no -e cycles || ret=$?
>    if [ $ret -eq 2 ]; then
>      echo "System-wide record [Skipped not supported]"
>      return
> @@ -471,7 +471,7 @@ test_cgroup() {
>    echo "Cgroup sampling test"
>    local ret=0
>    perf_record_with_retry "${perfdata}" "check_cgroup" "perf test -w thloop" \
> -    -aB --synth=cgroup --all-cgroups || ret=$?
> +    -aB --synth=cgroup --all-cgroups -e cycles || ret=$?
>    if [ $ret -eq 2 ]; then
>      echo "Cgroup sampling [Skipped not supported]"
>      return
> @@ -491,7 +491,7 @@ test_uid() {
>    echo "Uid sampling test"
>    local ret=0
>    perf_record_with_retry "${perfdata}" "check_uid" "perf test -w thloop" \
> -    -aB --synth=no --uid "$(id -u)" || ret=$?
> +    -aB --synth=no --uid "$(id -u)" -e cycles || ret=$?
>    if [ $ret -eq 2 ]; then
>      local logfile="${PERF_RECORD_LOGS[${#PERF_RECORD_LOGS[@]}-1]}"
>      if grep -q -E "libbpf.*EPERM|Access to performance monitoring" "$logfile" || \
> diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
> index 8d51afeb437b..6b6af59db871 100755
> --- a/tools/perf/tests/shell/record_lbr.sh
> +++ b/tools/perf/tests/shell/record_lbr.sh
> @@ -1,6 +1,6 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
> -# perf record LBR tests
> +# perf record LBR tests (exclusive)
>  
>  set -e
>  
> diff --git a/tools/perf/tests/shell/record_sideband.sh b/tools/perf/tests/shell/record_sideband.sh
> index 2182551873be..31ec2f5cde69 100755
> --- a/tools/perf/tests/shell/record_sideband.sh
> +++ b/tools/perf/tests/shell/record_sideband.sh
> @@ -22,7 +22,7 @@ trap trap_cleanup EXIT TERM INT
>  
>  can_cpu_wide()
>  {
> -    if ! perf record -o ${perfdata} -BN --no-bpf-event -C $1 true > /dev/null 2>&1
> +    if ! perf record -o ${perfdata} -BN --no-bpf-event -e cycles -C $1 true > /dev/null 2>&1
>      then
>          echo "record sideband test [Skipped cannot record cpu$1]"
>          err=2
> @@ -39,7 +39,7 @@ test_system_wide_tracking()
>      can_cpu_wide 1 || return 0
>  
>      # Record on CPU 0 a task running on CPU 1
> -    perf record -BN --no-bpf-event -o ${perfdata} -C 0 -- taskset --cpu-list 1 true
> +    perf record -BN --no-bpf-event -e cycles -o ${perfdata} -C 0 -- taskset --cpu-list 1 true
>  
>      # Should get MMAP events from CPU 1
>      mmap_cnt=`perf script -i ${perfdata} --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l`
> 
> -- 
> 2.43.0
> 
