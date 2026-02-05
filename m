Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79EC3321DC;
	Thu,  5 Feb 2026 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770327767; cv=none; b=hCNyFHW5wKkAcjmSnkIGqKxX41iNCkWl7tlw8v1fNb9L90+FYoXw8yL+13AZd/CusYZZPpATOrjRvXsJ99GSrWQGCZOE59Qul5hw6LZUoG0V0Jc/B8IFQrFI/JLA0owg+/taWYPsm4aiqtsmOt7t7pp/DPi7aIs9SWj7ddce9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770327767; c=relaxed/simple;
	bh=BMFAxiUl3hsVS47Jdoj5He7rs/XKS3pmlPu6kE2cc+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kcb5tiECRTr6TXfsSyz2smUXK9DSmAcdZlwR1f3zv7yLDsSdLZD0kfGUCe4jOy2pi2YCpnxsW8iW5xyonUGyhwOuLbcpG7ipQk8OSP+kBex+ScAJsh/hDMGBZU7hb2IdA4QsNkG4YDHyThEgwnTDN3yOGodVvQYa2mMQQu6zZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JniQVqs+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JniQVqs+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9ADC2BCFA;
	Thu,  5 Feb 2026 21:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770327767;
	bh=BMFAxiUl3hsVS47Jdoj5He7rs/XKS3pmlPu6kE2cc+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JniQVqs+xMwUYFeH2vwUCQJs+PGAp1wPYTnmfmVVeqWMADEBT1ohOMHXYIkZ7R+0z
	 tjgdRmh+LW12lWlO+XW/YzxjlN//EJO31ZzDy1VzO2i7UAK920P9JmuIXWF7W1FtEp
	 47xhI4S80g2NluaOCL4oflnQZLuAPzFKBGRfkl1yRhe+yGsjnjKTGGty+dbqIy2VtS
	 3ruVOVNU8u0GE4L9XfZzT6L6l0VJLs+xCVAgw2TDlsoUDVlGvpm5nkMT07rI0Hu77a
	 VBENMFbjFtUCDeVGIwvYp/zhjozoqzE6Or4mnPFAdkc9PTb9EGytwmiu9cSbtlcNwk
	 jM55sXqxdLB+A==
Date: Thu, 5 Feb 2026 18:42:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andres Freund <andres@anarazel.de>
Subject: Re: [PATCH v1] perf tests: Additional perf stat tests
Message-ID: <aYUO0_ccQG2AnZ3V@x1>
References: <20260204042629.1376-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204042629.1376-1-irogers@google.com>

On Tue, Feb 03, 2026 at 08:26:29PM -0800, Ian Rogers wrote:
> Recently perf stat regressed in per CPU mode [1]. Let's expand test
> coverage to catch the same breakage again as well as to test the
> repeat, pid, detailed and no aggregation options.
> 
> [1] https://lore.kernel.org/linux-perf-users/cgja46br2smmznxs7kbeabs6zgv3b4olfqgh2fdp5mxk2yom4v@w6jjgov6hdi6/

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat.sh | 242 +++++++++++++++++++++++++++++++++
>  1 file changed, 242 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> index 792a0b79f6b8..4edb04039036 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -5,6 +5,21 @@
>  set -e
>  
>  err=0
> +stat_output=$(mktemp /tmp/perf-stat-test-output.XXXXX)
> +
> +cleanup() {
> +  rm -f "${stat_output}"
> +  trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +  echo "Unexpected signal in ${FUNCNAME[1]}"
> +  cleanup
> +  exit 1
> +}
> +
> +trap trap_cleanup EXIT TERM INT
> +
>  test_default_stat() {
>    echo "Basic stat command test"
>    if ! perf stat true 2>&1 | grep -E -q "Performance counter stats for 'true':"
> @@ -248,6 +263,226 @@ test_hybrid() {
>    echo "hybrid test [Success]"
>  }
>  
> +test_stat_cpu() {
> +  echo "stat -C <cpu> test"
> +  # Test the full online CPU list (ranges and lists)
> +  online_cpus=$(cat /sys/devices/system/cpu/online)
> +  if ! perf stat -C "$online_cpus" -a true > "${stat_output}" 2>&1
> +  then
> +    echo "stat -C <cpu> test [Failed - command failed for cpus $online_cpus]"
> +    cat "${stat_output}"
> +    err=1
> +    return
> +  fi
> +
> +  if ! grep -E -q "Performance counter stats for" "${stat_output}"
> +  then
> +    echo "stat -C <cpu> test [Failed - missing output for cpus $online_cpus]"
> +    cat "${stat_output}"
> +    err=1
> +    return
> +  fi
> +
> +  # Test each individual online CPU
> +  for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*; do
> +    cpu=${cpu_dir##*/cpu}
> +    # Check if online
> +    if [ -f "$cpu_dir/online" ] && [ "$(cat "$cpu_dir/online")" -eq 0 ]
> +    then
> +      continue
> +    fi
> +
> +    if ! perf stat -C "$cpu" -a true > "${stat_output}" 2>&1
> +    then
> +      echo "stat -C <cpu> test [Failed - command failed for cpu $cpu]"
> +      cat "${stat_output}"
> +      err=1
> +      return
> +    fi
> +    if ! grep -E -q "Performance counter stats for" "${stat_output}"
> +    then
> +      echo "stat -C <cpu> test [Failed - missing output for cpu $cpu]"
> +      cat "${stat_output}"
> +      err=1
> +      return
> +    fi
> +  done
> +
> +  # Test synthetic list and range if cpu0 and cpu1 are online
> +  c0_online=0
> +  c1_online=0
> +  if [ -d "/sys/devices/system/cpu/cpu0" ]
> +  then
> +    if [ ! -f "/sys/devices/system/cpu/cpu0/online" ] || [ "$(cat /sys/devices/system/cpu/cpu0/online)" -eq 1 ]
> +    then
> +      c0_online=1
> +    fi
> +  fi
> +  if [ -d "/sys/devices/system/cpu/cpu1" ]
> +  then
> +    if [ ! -f "/sys/devices/system/cpu/cpu1/online" ] || [ "$(cat /sys/devices/system/cpu/cpu1/online)" -eq 1 ]
> +    then
> +      c1_online=1
> +    fi
> +  fi
> +
> +  if [ $c0_online -eq 1 ] && [ $c1_online -eq 1 ]
> +  then
> +    # Test list "0,1"
> +    if ! perf stat -C "0,1" -a true > "${stat_output}" 2>&1
> +    then
> +      echo "stat -C <cpu> test [Failed - command failed for cpus 0,1]"
> +      cat "${stat_output}"
> +      err=1
> +      return
> +    fi
> +    if ! grep -E -q "Performance counter stats for" "${stat_output}"
> +    then
> +      echo "stat -C <cpu> test [Failed - missing output for cpus 0,1]"
> +      cat "${stat_output}"
> +      err=1
> +      return
> +    fi
> +
> +    # Test range "0-1"
> +    if ! perf stat -C "0-1" -a true > "${stat_output}" 2>&1
> +    then
> +      echo "stat -C <cpu> test [Failed - command failed for cpus 0-1]"
> +      cat "${stat_output}"
> +      err=1
> +      return
> +    fi
> +    if ! grep -E -q "Performance counter stats for" "${stat_output}"
> +    then
> +      echo "stat -C <cpu> test [Failed - missing output for cpus 0-1]"
> +      cat "${stat_output}"
> +      err=1
> +      return
> +    fi
> +  fi
> +
> +  echo "stat -C <cpu> test [Success]"
> +}
> +
> +test_stat_no_aggr() {
> +  echo "stat -A test"
> +  if ! perf stat -A -a true > "${stat_output}" 2>&1
> +  then
> +    echo "stat -A test [Failed - command failed]"
> +    cat "${stat_output}"
> +    err=1
> +    return
> +  fi
> +
> +  if ! grep -E -q "CPU" "${stat_output}"
> +  then
> +    echo "stat -A test [Failed - missing CPU column]"
> +    cat "${stat_output}"
> +    err=1
> +    return
> +  fi
> +  echo "stat -A test [Success]"
> +}
> +
> +test_stat_detailed() {
> +  echo "stat -d test"
> +  if ! perf stat -d true > "${stat_output}" 2>&1
> +  then
> +    echo "stat -d test [Failed - command failed]"
> +    cat "${stat_output}"
> +    err=1
> +    return
> +  fi
> +
> +  if ! grep -E -q "Performance counter stats" "${stat_output}"
> +  then
> +    echo "stat -d test [Failed - missing output]"
> +    cat "${stat_output}"
> +    err=1
> +    return
> +  fi
> +
> +  if ! perf stat -dd true > "${stat_output}" 2>&1
> +  then
> +    echo "stat -dd test [Failed - command failed]"
> +    cat "${stat_output}"
> +    err=1
> +    return
> +  fi
> +
> +  if ! grep -E -q "Performance counter stats" "${stat_output}"
> +  then
> +    echo "stat -dd test [Failed - missing output]"
> +    cat "${stat_output}"
> +    err=1
> +    return
> +  fi
> +
> +  if ! perf stat -ddd true > "${stat_output}" 2>&1
> +  then
> +    echo "stat -ddd test [Failed - command failed]"
> +    cat "${stat_output}"
> +    err=1
> +    return
> +  fi
> +
> +  if ! grep -E -q "Performance counter stats" "${stat_output}"
> +  then
> +    echo "stat -ddd test [Failed - missing output]"
> +    cat "${stat_output}"
> +    err=1
> +    return
> +  fi
> +
> +  echo "stat -d test [Success]"
> +}
> +
> +test_stat_repeat() {
> +  echo "stat -r test"
> +  if ! perf stat -r 2 true > "${stat_output}" 2>&1
> +  then
> +    echo "stat -r test [Failed - command failed]"
> +    cat "${stat_output}"
> +    err=1
> +    return
> +  fi
> +
> +  if ! grep -E -q "\([[:space:]]*\+-.*%[[:space:]]*\)" "${stat_output}"
> +  then
> +    echo "stat -r test [Failed - missing variance]"
> +    cat "${stat_output}"
> +    err=1
> +    return
> +  fi
> +  echo "stat -r test [Success]"
> +}
> +
> +test_stat_pid() {
> +  echo "stat -p test"
> +  sleep 1 &
> +  pid=$!
> +  if ! perf stat -p $pid > "${stat_output}" 2>&1
> +  then
> +    echo "stat -p test [Failed - command failed]"
> +    cat "${stat_output}"
> +    err=1
> +    kill $pid 2>/dev/null || true
> +    wait $pid 2>/dev/null || true
> +    return
> +  fi
> +
> +  if ! grep -E -q "Performance counter stats" "${stat_output}"
> +  then
> +    echo "stat -p test [Failed - missing output]"
> +    cat "${stat_output}"
> +    err=1
> +  else
> +    echo "stat -p test [Success]"
> +  fi
> +  kill $pid 2>/dev/null || true
> +  wait $pid 2>/dev/null || true
> +}
> +
>  test_default_stat
>  test_null_stat
>  test_offline_cpu_stat
> @@ -258,4 +493,11 @@ test_topdown_groups
>  test_topdown_weak_groups
>  test_cputype
>  test_hybrid
> +test_stat_cpu
> +test_stat_no_aggr
> +test_stat_detailed
> +test_stat_repeat
> +test_stat_pid
> +
> +cleanup
>  exit $err
> -- 
> 2.53.0.rc2.204.g2597b5adb4-goog
> 
