Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFCC251784;
	Tue,  4 Mar 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101322; cv=none; b=owpEtCQvL+d1M+zSaj/hhViSJaA1FEQ7OZHgUxIxRA5eQJ5q361JnR6waJvd8JbNbT/bBoLWSF+w+2ye4/FspclmW7C6nWwxQI/r9eRGLZs85LZZlWBuWCVIrWghmvezlws1Ouv3hNZBTb/AE0kH29SFCrial8W3zHqFybCuHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101322; c=relaxed/simple;
	bh=zb4TEuxHQhDYk0nAldu9UM/9+rBUKEwwmacuoOlWE9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcHyqCpZfZZ/K0ARdHQCkbkH6PzIYCHvqg9uNGHZlCusU09uh+RSuyC7VwdED13AC4Avudr0yzX9CtXMiPthueE2CqM1kwpGg/bmbq9b+3Rkfswf9uJe2MK285dfOt+yWc6VizV7wPFp5IOs3+ilgghoyrXRR8SDipI3Igmkepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2B5DFEC;
	Tue,  4 Mar 2025 07:15:33 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D23323F66E;
	Tue,  4 Mar 2025 07:15:19 -0800 (PST)
Date: Tue, 4 Mar 2025 15:15:18 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH v2 6/6] perf test: Simplify data symbol test
Message-ID: <20250304151518.GA13418@e132581.arm.com>
References: <20250304022837.1877845-1-namhyung@kernel.org>
 <20250304022837.1877845-7-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304022837.1877845-7-namhyung@kernel.org>

On Mon, Mar 03, 2025 at 06:28:37PM -0800, Namhyung Kim wrote:
> Now the workload will end after 1 second.  Just run it with perf instead
> of waiting for the background process.
> 
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  tools/perf/tests/shell/test_data_symbol.sh | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
> index c86da02350596b35..1792b7ad4066f8cd 100755
> --- a/tools/perf/tests/shell/test_data_symbol.sh
> +++ b/tools/perf/tests/shell/test_data_symbol.sh
> @@ -5,8 +5,6 @@
>  # Leo Yan <leo.yan@linaro.org>, 2022
>  
>  shelldir=$(dirname "$0")
> -# shellcheck source=lib/waiting.sh
> -. "${shelldir}"/lib/waiting.sh
>  
>  # shellcheck source=lib/perf_has_symbol.sh
>  . "${shelldir}"/lib/perf_has_symbol.sh
> @@ -60,19 +58,10 @@ echo "Recording workload..."
>  # specific CPU and test in per-CPU mode.
>  is_amd=$(grep -E -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
>  if (($is_amd >= 1)); then
> -	perf mem record -vvv -o ${PERF_DATA} -C 0 -- taskset -c 0 $TEST_PROGRAM 2>"${ERR_FILE}" &
> +	perf mem record -vvv -o ${PERF_DATA} -C 0 -- taskset -c 0 $TEST_PROGRAM 2>"${ERR_FILE}"
>  else
> -	perf mem record -vvv --all-user -o ${PERF_DATA} -- $TEST_PROGRAM 2>"${ERR_FILE}" &
> +	perf mem record -vvv --all-user -o ${PERF_DATA} -- $TEST_PROGRAM 2>"${ERR_FILE}"
>  fi
>  
> -PERFPID=$!
> -
> -wait_for_perf_to_start ${PERFPID} "${ERR_FILE}"
> -
> -sleep 1
> -
> -kill $PERFPID
> -wait $PERFPID
> -
>  check_result
>  exit $?
> -- 
> 2.48.1.711.g2feabab25a-goog
> 
