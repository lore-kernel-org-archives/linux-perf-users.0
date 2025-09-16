Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BB22DAFD2;
	Tue, 16 Sep 2025 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049207; cv=none; b=Qr7fV1KXE4SqVMxo9l3twBsKiFFMtLr+aJT0gEkvb9BtYi/WWCBj5XqAPpKD8z+nuCMg6G/MgiyxkF5C0q8FEFjh0Q/jVN0QCVj3U99z8wiRDbgqJTGHBVxERafgbq0oFtBQwchhUohUZOXAPz/SikCHsmkYddPpGFLFkwvwoTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049207; c=relaxed/simple;
	bh=95l9pr64ynrwi244Oy9sUnhLG2jGgpcru4un1rfIZTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJhXlVDLAEpaWCvyMG2dYVQkN7RcQnq01K7XYCCE9TEwQjVYaqBUE2uyDF6I0Q/T0Ge6f1m14+BHNofBFynApcfEIK8rsNYziOu4Y1eBWm5H3rthybr1OBGt44WcgeKjdXL6sv8lDIUtwmBFbVHK3O1gAllbAzX98NhDPaFRK8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vD/KuB1c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vD/KuB1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCE9C4CEEB;
	Tue, 16 Sep 2025 19:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758049207;
	bh=95l9pr64ynrwi244Oy9sUnhLG2jGgpcru4un1rfIZTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vD/KuB1cLG7frNkpzca7V6XivhD+WriLeTqzeKRCcKjD+169sahMAf9+SPhfgXhWz
	 mN+tyeQIFI/za346w/oGwv9o7YUWqHrVsR6ZeAxVAaaNp73SwwDv3+kSWp5LBmjhgp
	 hQ/nmklBAQdsFikN/JFcZpGpZbYrhNOpyXJOEfxYudpS7yfknBtrQabMVqtbSah9dp
	 pdw/QbZNJpfWNTvw2F/487xp9DWp0+x2BpRI4N+6aVjwbzbktcfVyZq7frMhVeZ/VG
	 yPVAyWhUR709AEENjzoX4YbFbp/KpI2keCE33hJ/jjo+3AZrMDObSJkj9oGr8FOZqY
	 yfva2OSLMTIrQ==
Date: Tue, 16 Sep 2025 16:00:04 -0300
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
Subject: Re: [PATCH v1 1/4] perf test shell lbr: Avoid failures with perf
 event paranoia
Message-ID: <aMmztG_F1KuAKKq9@x1>
References: <20250821221834.1312002-1-irogers@google.com>
 <20250821221834.1312002-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821221834.1312002-2-irogers@google.com>

On Thu, Aug 21, 2025 at 03:18:31PM -0700, Ian Rogers wrote:
> When not running as root and with higher perf event paranoia values
> the perf record LBR tests could fail rather than skipping the
> problematic tests. Add the sensitivity to the test and confirm it
> passes with paranoia values from -1 to 2.

Thanks, applied to perf-tools-next,

Committer testing:

Testing with '$ perf test -vv lbr', i.e. as non root, and then comparing
the output shows the mentioned errors before this patch:

  acme@x1:~$ grep -m1 "model name" /proc/cpuinfo
  model name    : 13th Gen Intel(R) Core(TM) i7-1365U
  acme@x1:~$ 

Before:

 132: perf record LBR tests            : Skip

After:

 132: perf record LBR tests            : Ok

- Arnaldo
 
> Fixes: 32559b99e0f5 ("perf test: Add set of perf record LBR tests")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/record_lbr.sh | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
> index 6fcb5e52b9b4..78a02e90ece1 100755
> --- a/tools/perf/tests/shell/record_lbr.sh
> +++ b/tools/perf/tests/shell/record_lbr.sh
> @@ -4,6 +4,10 @@
>  
>  set -e
>  
> +ParanoidAndNotRoot() {
> +  [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
> +}
> +
>  if [ ! -f /sys/bus/event_source/devices/cpu/caps/branches ] &&
>     [ ! -f /sys/bus/event_source/devices/cpu_core/caps/branches ]
>  then
> @@ -23,6 +27,7 @@ cleanup() {
>  }
>  
>  trap_cleanup() {
> +  echo "Unexpected signal in ${FUNCNAME[1]}"
>    cleanup
>    exit 1
>  }
> @@ -123,8 +128,11 @@ lbr_test "-j ind_call" "any indirect call" 2
>  lbr_test "-j ind_jmp" "any indirect jump" 100
>  lbr_test "-j call" "direct calls" 2
>  lbr_test "-j ind_call,u" "any indirect user call" 100
> -lbr_test "-a -b" "system wide any branch" 2
> -lbr_test "-a -j any_call" "system wide any call" 2
> +if ! ParanoidAndNotRoot 1
> +then
> +  lbr_test "-a -b" "system wide any branch" 2
> +  lbr_test "-a -j any_call" "system wide any call" 2
> +fi
>  
>  # Parallel
>  parallel_lbr_test "-b" "parallel any branch" 100 &
> @@ -141,10 +149,16 @@ parallel_lbr_test "-j call" "parallel direct calls" 100 &
>  pid6=$!
>  parallel_lbr_test "-j ind_call,u" "parallel any indirect user call" 100 &
>  pid7=$!
> -parallel_lbr_test "-a -b" "parallel system wide any branch" 100 &
> -pid8=$!
> -parallel_lbr_test "-a -j any_call" "parallel system wide any call" 100 &
> -pid9=$!
> +if ParanoidAndNotRoot 1
> +then
> +  pid8=
> +  pid9=
> +else
> +  parallel_lbr_test "-a -b" "parallel system wide any branch" 100 &
> +  pid8=$!
> +  parallel_lbr_test "-a -j any_call" "parallel system wide any call" 100 &
> +  pid9=$!
> +fi
>  
>  for pid in $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9
>  do
> -- 
> 2.51.0.rc2.233.g662b1ed5c5-goog
