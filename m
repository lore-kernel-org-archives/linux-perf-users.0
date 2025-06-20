Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7388632B;
	Fri, 20 Jun 2025 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750448492; cv=none; b=nFZVWxEf1gJWc1xbwKM1Znw45/53SmCFPMX5Rr7ujDZadvvOFdWvs1LtPK0OSGZdCYD3M57YqIfxauJpbNxlZdIg95hDzB1a01/8Tn1h/jjP1rEHZDnHgCsdCBRkw0vB3R0p3/NGDVQjRIaP3aF1llmkWTAft1ECWQEh1XkZlTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750448492; c=relaxed/simple;
	bh=Wlykax6GaqbRLPBJAf/zoWMM2dVGBq8vOy1ORIg5Aak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEYLF1QqBTK4VUTc5QJ8mOWNU/7tHKb9slvL/fhBW6oAlxBByQbFYDE4qPh58Tse2wnw6nrH0CcEwlOx4GFBu28y+CtXAiPQw0bDGKpHt3c2/9JuhHYNvaQuTqDSibuR51exGxEDGVC6QA1likhgv+ThS+Vxu3q4KwA3Vmtzk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYa01Mu4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYa01Mu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FABC4CEE3;
	Fri, 20 Jun 2025 19:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750448492;
	bh=Wlykax6GaqbRLPBJAf/zoWMM2dVGBq8vOy1ORIg5Aak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYa01Mu4Jq6mnyvzkcLOa9dwbge4rRnm0mcQn3aHjEJ/qIAiC797yp3mZ5mskDpFi
	 LL8fFPXjpZMXOzs2tHtlI8EVJy98lPtXsH79wkM1Hn6yw6WtUeZ8sd574vMBBA8q0G
	 7hILma1/SAkWaGbbAsv+qz1hCFacATwm3T6zyYdZmst5LlHMJpcQCl534ykKLCrPVL
	 ms0UyWqE44gWpP+cyAdJ5P/zf76itMiCuDutoSfx4KNmCp7oHB8jtVLfy54a5f3jm5
	 cYKea+xQpJXs2FjoOz03tchbu5bnjpa/qRCug1KCH1LUBCpAVvYOXTcA88Nxezxl0V
	 EsIG03NGR3bSw==
Date: Fri, 20 Jun 2025 12:41:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf test: Add sched latency and script shell
 tests
Message-ID: <aFW5aknT69UR3CTV@google.com>
References: <20250619002034.97007-1-irogers@google.com>
 <20250619002034.97007-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250619002034.97007-2-irogers@google.com>

On Wed, Jun 18, 2025 at 05:20:34PM -0700, Ian Rogers wrote:
> Add shell tests covering the `perf sched latency` and `perf sched
> script` commands. The test creates 2 noploop processes on the same
> forced CPU, it then checks that the process appears in the `perf
> sched` output.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Skip the test if not root due to permissions.
> ---
>  tools/perf/tests/shell/sched.sh | 91 +++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100755 tools/perf/tests/shell/sched.sh
> 
> diff --git a/tools/perf/tests/shell/sched.sh b/tools/perf/tests/shell/sched.sh
> new file mode 100755
> index 000000000000..0a4fe3f414e1
> --- /dev/null
> +++ b/tools/perf/tests/shell/sched.sh
> @@ -0,0 +1,91 @@
> +#!/bin/bash
> +# perf sched tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +if [ "$(id -u)" != 0 ]; then
> +  echo "[Skip] No root permission"
> +  exit 2
> +fi
> +
> +err=0
> +perfdata=$(mktemp /tmp/__perf_test_sched.perf.data.XXXXX)
> +PID1=0
> +PID2=0
> +
> +cleanup() {
> +  rm -f "${perfdata}"
> +  rm -f "${perfdata}".old
> +
> +  trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +  echo "Unexpected signal in ${FUNCNAME[1]}"
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +start_noploops() {
> +  # Start two noploop workloads on CPU0 to trigger scheduling.
> +  taskset -c 0 perf test -w noploop 10 &
> +  PID1=$!
> +  taskset -c 0 perf test -w noploop 10 &
> +  PID2=$!

You can use 'thloop' workload which runs 2 threads at the same time.
Then you don't need to handle the background processes and run it
directly with perf test.

Thanks,
Namhyung

> +
> +  if ! grep -q 'Cpus_allowed_list:\s*0$' "/proc/$PID1/status"
> +  then
> +    echo "Sched [Error taskset did not work for the 1st noploop ($PID1)]"
> +    grep Cpus_allowed /proc/$PID1/status
> +    err=1
> +  fi
> +
> +  if ! grep -q 'Cpus_allowed_list:\s*0$' "/proc/$PID2/status"
> +  then
> +    echo "Sched [Error taskset did not work for the 2nd noploop ($PID2)]"
> +    grep Cpus_allowed /proc/$PID2/status
> +    err=1
> +  fi
> +}
> +
> +cleanup_noploops() {
> +  kill "$PID1" "$PID2"
> +}
> +
> +test_sched_latency() {
> +  echo "Sched latency"
> +
> +  start_noploops
> +
> +  perf sched record --no-inherit -o "${perfdata}" sleep 1
> +  if ! perf sched latency -i "${perfdata}" | grep -q perf-noploop
> +  then
> +    echo "Sched latency [Failed missing output]"
> +    err=1
> +  fi
> +
> +  cleanup_noploops
> +}
> +
> +test_sched_script() {
> +  echo "Sched script"
> +
> +  start_noploops
> +
> +  perf sched record --no-inherit -o "${perfdata}" sleep 1
> +  if ! perf sched script -i "${perfdata}" | grep -q perf-noploop
> +  then
> +    echo "Sched script [Failed missing output]"
> +    err=1
> +  fi
> +
> +  cleanup_noploops
> +}
> +
> +test_sched_latency
> +test_sched_script
> +
> +cleanup
> +exit $err
> -- 
> 2.50.0.rc2.701.gf1e915cc24-goog
> 
