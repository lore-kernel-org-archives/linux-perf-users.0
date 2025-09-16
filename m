Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8B3016E7;
	Tue, 16 Sep 2025 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050108; cv=none; b=Bxl2wdFTLqn5aJZD0TgyZdTnARVhAC5wvlR60vfPyT+YJGNhVvjbIPq9hs/FSSQmNP99YQgD2j4Egw2/r6blCJSM2XsfEpD6rbM0OoSG3NN7aEG6gyRwRoToZr4FNxVfzKyihC9QCqxW80sHmBhTl8Ic3saI5SiRUhnmBgKhh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050108; c=relaxed/simple;
	bh=M/yZWrPfZpewGGEimNsWyMgo4jxRNbJ0o5evV2UPJXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOgPT37OJ0j2prMSucjgo71tVhKezwx4xD7o9B3tWXbdz2AnNd8v++LqkUFNbv06hEqYy1ymT9XcRxlVnp7aueupPFlk+OFLx/yOSPdqC0Ja1ITGF7jt5TN/t1m9rQcqyOKZ/pHlt57mFZQHntCnGxSRN1IJxEEtVjiyGmvIF+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4pN7l5F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4pN7l5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A073C4CEF0;
	Tue, 16 Sep 2025 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758050106;
	bh=M/yZWrPfZpewGGEimNsWyMgo4jxRNbJ0o5evV2UPJXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4pN7l5F3ObPMsSiH+6ToDPrkWwsn9/0478vLF60M9F3mLc9zYheSdv0tMQUE5UgN
	 rHGCglUsJRG/jgfEin80p4la0b7iFYe/lcJ2iTrl8JwdH+3Fc9peMSW2JxAiTme5Wc
	 r7gEHewXWJnpQRfvwWqQga8lAk9IZDwC5RCcpD202qotMqR8lnR9QVO971Zi5GL7LC
	 VN7l7MyGnJE7MBHsYAcZSp4UmEnAIKmal1R4Yd7OzEPbqGbZMFnK/1fy/Odq9I6aTf
	 RycCWO/yNDXGnbTmxf33aP1UHruSbedien291IDmPdfFMbES650ODAaR2aGy//8b13
	 Me9jjCaZJncQg==
Date: Tue, 16 Sep 2025 16:15:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Chun-Tse Shao <ctshao@google.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 4/4] perf test: Avoid uncore_imc/clockticks in
 uniquification test
Message-ID: <aMm3N0dfD_r46K6A@x1>
References: <20250821221834.1312002-1-irogers@google.com>
 <20250821221834.1312002-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821221834.1312002-5-irogers@google.com>

On Thu, Aug 21, 2025 at 03:18:34PM -0700, Ian Rogers wrote:
> The detection of uncore_imc may happen for free running PMUs and the
> clockticks event may be present on uncore_clock. Rewrite the test to
> detect duplicated/deduplicated events from perf list, not hardcoded to
> uncore_imc.

acme@x1:~/git/perf-tools-next$ perf test 96
 96: perf stat events uniquifying                                    : FAILED!
acme@x1:~/git/perf-tools-next$ perf test -vv 96
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
 96: perf stat events uniquifying:
--- start ---
test child forked, pid 86847
Uniquification of PMU sysfs events test
Testing event uncore_imc_free_running/data_read/ is uniquified to uncore_imc_free_running_0/data_read/
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_imc_free_running/data_read/u).
"dmesg | grep -i perf" may provide additional information.

Unexpected signal in test_event_uniquifying
---- end(-1) ----
 96: perf stat events uniquifying                                    : FAILED!


Works for root:

acme@x1:~/git/perf-tools-next$ sudo su -
[sudo] password for acme: 
root@x1:~# perf test 96
 96: perf stat events uniquifying                                    : Ok
root@x1:~#

acme@x1:~/git/perf-tools-next$ ls -la /sys/bus/event_source/devices/uncore_imc_free_running_*/events/
/sys/bus/event_source/devices/uncore_imc_free_running_0/events/:
total 0
drwxr-xr-x. 2 root root    0 Sep 16 16:09 .
drwxr-xr-x. 5 root root    0 Sep 16 16:09 ..
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_read
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_read.scale
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_read.unit
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_total
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_total.scale
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_total.unit
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_write
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_write.scale
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_write.unit

/sys/bus/event_source/devices/uncore_imc_free_running_1/events/:
total 0
drwxr-xr-x. 2 root root    0 Sep 16 16:09 .
drwxr-xr-x. 5 root root    0 Sep 16 16:09 ..
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_read
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_read.scale
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_read.unit
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_total
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_total.scale
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_total.unit
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_write
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_write.scale
-r--r--r--. 1 root root 4096 Sep 16 16:09 data_write.unit
acme@x1:~/git/perf-tools-next$


 
> Fixes: 070b315333ee ("perf test: Restrict uniquifying test to machines with 'uncore_imc'")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../tests/shell/stat+event_uniquifying.sh     | 105 ++++++++----------
>  1 file changed, 44 insertions(+), 61 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/perf/tests/shell/stat+event_uniquifying.sh
> index bf54bd6c3e2e..9bc7a1f520f9 100755
> --- a/tools/perf/tests/shell/stat+event_uniquifying.sh
> +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> @@ -4,74 +4,57 @@
>  
>  set -e
>  
> -stat_output=$(mktemp /tmp/__perf_test.stat_output.XXXXX)
> -perf_tool=perf
>  err=0
> +stat_output=$(mktemp /tmp/__perf_test.stat_output.XXXXX)
>  
> -test_event_uniquifying() {
> -  # We use `clockticks` in `uncore_imc` to verify the uniquify behavior.
> -  pmu="uncore_imc"
> -  event="clockticks"
> -
> -  # If the `-A` option is added, the event should be uniquified.
> -  #
> -  # $perf list -v clockticks
> -  #
> -  # List of pre-defined events (to be used in -e or -M):
> -  #
> -  #   uncore_imc_0/clockticks/                           [Kernel PMU event]
> -  #   uncore_imc_1/clockticks/                           [Kernel PMU event]
> -  #   uncore_imc_2/clockticks/                           [Kernel PMU event]
> -  #   uncore_imc_3/clockticks/                           [Kernel PMU event]
> -  #   uncore_imc_4/clockticks/                           [Kernel PMU event]
> -  #   uncore_imc_5/clockticks/                           [Kernel PMU event]
> -  #
> -  #   ...
> -  #
> -  # $perf stat -e clockticks -A -- true
> -  #
> -  #  Performance counter stats for 'system wide':
> -  #
> -  # CPU0            3,773,018      uncore_imc_0/clockticks/
> -  # CPU0            3,609,025      uncore_imc_1/clockticks/
> -  # CPU0                    0      uncore_imc_2/clockticks/
> -  # CPU0            3,230,009      uncore_imc_3/clockticks/
> -  # CPU0            3,049,897      uncore_imc_4/clockticks/
> -  # CPU0                    0      uncore_imc_5/clockticks/
> -  #
> -  #        0.002029828 seconds time elapsed
> -
> -  echo "stat event uniquifying test"
> -  uniquified_event_array=()
> -
> -  # Skip if the machine does not have `uncore_imc` device.
> -  if ! ${perf_tool} list pmu | grep -q ${pmu}; then
> -    echo "Target does not support PMU ${pmu} [Skipped]"
> -    err=2
> -    return
> -  fi
> +cleanup() {
> +  rm -f "${stat_output}"
>  
> -  # Check how many uniquified events.
> -  while IFS= read -r line; do
> -    uniquified_event=$(echo "$line" | awk '{print $1}')
> -    uniquified_event_array+=("${uniquified_event}")
> -  done < <(${perf_tool} list -v ${event} | grep ${pmu})
> +  trap - EXIT TERM INT
> +}
>  
> -  perf_command="${perf_tool} stat -e $event -A -o ${stat_output} -- true"
> -  $perf_command
> +trap_cleanup() {
> +  echo "Unexpected signal in ${FUNCNAME[1]}"
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
>  
> -  # Check the output contains all uniquified events.
> -  for uniquified_event in "${uniquified_event_array[@]}"; do
> -    if ! cat "${stat_output}" | grep -q "${uniquified_event}"; then
> -      echo "Event is not uniquified [Failed]"
> -      echo "${perf_command}"
> -      cat "${stat_output}"
> -      err=1
> -      break
> -    fi
> +test_event_uniquifying() {
> +  echo "Uniquification of PMU sysfs events test"
> +
> +  # Read events from perf list with and without -v. With -v the duplicate PMUs
> +  # aren't deduplicated. Note, json events are listed by perf list without a
> +  # PMU.
> +  read -ra pmu_events <<< "$(perf list --raw pmu)"
> +  read -ra pmu_v_events <<< "$(perf list -v --raw pmu)"
> +  # For all non-deduplicated events.
> +  for pmu_v_event in "${pmu_v_events[@]}"; do
> +    # If the event matches an event in the deduplicated events then it musn't
> +    # be an event with duplicate PMUs, continue the outer loop.
> +    for pmu_event in "${pmu_events[@]}"; do
> +      if [[ "$pmu_v_event" == "$pmu_event" ]]; then
> +        continue 2
> +      fi
> +    done
> +    # Strip the suffix from the non-deduplicated event's PMU.
> +    event=$(echo "$pmu_v_event" | sed -E 's/_[0-9]+//')
> +    for pmu_event in "${pmu_events[@]}"; do
> +      if [[ "$event" == "$pmu_event" ]]; then
> +        echo "Testing event ${event} is uniquified to ${pmu_v_event}"
> +        perf stat -e "$event" -A -o ${stat_output} -- true
> +        # Ensure the non-deduplicated event appears in the output.
> +        if ! grep -q "${pmu_v_event}" "${stat_output}"; then
> +          echo "Uniquification of PMU sysfs events test [Failed]"
> +          cat "${stat_output}"
> +          err=1
> +        fi
> +        break
> +      fi
> +    done
>    done
>  }
>  
>  test_event_uniquifying
> -rm -f "${stat_output}"
> +cleanup
>  exit $err
> -- 
> 2.51.0.rc2.233.g662b1ed5c5-goog
