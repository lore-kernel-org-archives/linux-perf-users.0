Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E23596D;
	Sat, 13 Sep 2025 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724094; cv=none; b=CKQBiooSFidwjwY3kypb2wUS9NpwsYMrSNDD1dXe397L2MbRH/TQEXNEbnf+axrs1IzgJRvGwtvlZeDuhiK+5DHWizkXQBn32p1YowRvY/o2m9EHPDiydTt3E338U6Sqxbw3JJl3qS0Jvgua5geUtl1uiOJ+ZuvRCLzXv2FQVs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724094; c=relaxed/simple;
	bh=/rNAc2m5gb+2P89wJKtQXpuNBBY/agWHXrgRO2VrLbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opWI0u8kVHMBlyb2ElgmFQ4fY0EXGJgeFO/x1HIPcyekfpcgvDoLwyGiEJcJxBMg+uBVWG1xuwuOyQUnGdLwE4IRct2Vra94a/zFCrSyNvR8z7bP8MGjoUip+3EPE5bs+2ser4p0ifzb2jawY+308LRHUc1w8nMYGnut4CCK8Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbwtEboM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbwtEboM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62548C4CEF1;
	Sat, 13 Sep 2025 00:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757724092;
	bh=/rNAc2m5gb+2P89wJKtQXpuNBBY/agWHXrgRO2VrLbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbwtEboMck+NtkVbbMhbYOQjLzVfuvsLokMHZ1uuDYf01OE3QBeMbOlmcGLET2WXO
	 YRwMKf2TTs1CHx4SGA81qCT5hxhycozRcMxY3xPWaPwFxYEBcRq7FS0L+B4r4cNWWL
	 ei3DqaO5l8HfgNvtmbW34TEoIen9cFS8WyzeRO8r/JxLM8eMysRUFiTqf9NUJd0TFL
	 vk3FMGIPpBaUx98jHIgb5mUkVHggcb+yN+t35Xu/Yh3Z/x1fcPx5nyUOKlmIxXmMEn
	 2d3wuNWRaU3KXwrs8TNMeHZ2Aqp9aFSBuDfZLTmrPCoBuOTrDmIwvj/CHVlWyflv0O
	 Uep/hh2yb21kA==
Date: Fri, 12 Sep 2025 17:41:31 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Collin Funk <collin.funk1@gmail.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf test: AMD IBS swfilt skip kernel tests if
 paranoia is >1
Message-ID: <aMS9uykyD5u5gqWf@google.com>
References: <20250913000350.1306948-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250913000350.1306948-1-irogers@google.com>

Hi Ian,

On Fri, Sep 12, 2025 at 05:03:50PM -0700, Ian Rogers wrote:
> If not root and the perf_event_paranoid is set >1 swfilt will fail to
> open the event failing the test. Add check to skip the test in that
> case.
> 

Fixes: 0e71bcdcf1f0b10b ("perf test: Add AMD IBS sw filter test")

> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/shell/amd-ibs-swfilt.sh | 51 ++++++++++++++++++------
>  1 file changed, 38 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/amd-ibs-swfilt.sh b/tools/perf/tests/shell/amd-ibs-swfilt.sh
> index 7045ec72ba4c..e7f66df05c4b 100755
> --- a/tools/perf/tests/shell/amd-ibs-swfilt.sh
> +++ b/tools/perf/tests/shell/amd-ibs-swfilt.sh
> @@ -1,6 +1,10 @@
>  #!/bin/bash
>  # AMD IBS software filtering
>  
> +ParanoidAndNotRoot() {
> +  [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
> +}
> +
>  echo "check availability of IBS swfilt"
>  
>  # check if IBS PMU is available
> @@ -16,6 +20,7 @@ if [ ! -f /sys/bus/event_source/devices/ibs_op/format/swfilt ]; then
>  fi
>  
>  echo "run perf record with modifier and swfilt"
> +err=0
>  
>  # setting any modifiers should fail
>  perf record -B -e ibs_op//u -o /dev/null true 2> /dev/null
> @@ -31,11 +36,17 @@ if [ $? -ne 0 ]; then
>      exit 1
>  fi
>  
> -# setting it with swfilt=1 should be fine
> -perf record -B -e ibs_op/swfilt=1/k -o /dev/null true
> -if [ $? -ne 0 ]; then
> -    echo "[FAIL] IBS op PMU cannot handle swfilt for exclude_user"
> -    exit 1
> +if ! ParanoidAndNotRoot 1
> +then
> +    # setting it with swfilt=1 should be fine
> +    perf record -B -e ibs_op/swfilt=1/k -o /dev/null true
> +    if [ $? -ne 0 ]; then
> +        echo "[FAIL] IBS op PMU cannot handle swfilt for exclude_user"
> +        exit 1
> +    fi
> +else
> +    echo "[SKIP] not root and perf_event_paranoid too high for exclude_user"
> +    err=2
>  fi
>  
>  # check ibs_fetch PMU as well
> @@ -46,10 +57,16 @@ if [ $? -ne 0 ]; then
>  fi
>  
>  # check system wide recording
> -perf record -aB --synth=no -e ibs_op/swfilt/k -o /dev/null true
> -if [ $? -ne 0 ]; then
> -    echo "[FAIL] IBS op PMU cannot handle swfilt in system-wide mode"
> -    exit 1
> +if ! ParanoidAndNotRoot 0
> +then
> +    perf record -aB --synth=no -e ibs_op/swfilt/k -o /dev/null true
> +    if [ $? -ne 0 ]; then
> +        echo "[FAIL] IBS op PMU cannot handle swfilt in system-wide mode"
> +        exit 1
> +    fi
> +else
> +    echo "[SKIP] not root and perf_event_paranoid too high for system-wide/exclude_user"
> +    err=2
>  fi
>  
>  echo "check number of samples with swfilt"
> @@ -60,8 +77,16 @@ if [ ${kernel_sample} -ne 0 ]; then
>      exit 1
>  fi
>  
> -user_sample=$(perf record -e ibs_fetch/swfilt/k -o- true | perf script -i- -F misc | grep -c ^U)
> -if [ ${user_sample} -ne 0 ]; then
> -    echo "[FAIL] unexpected user samples: " ${user_sample}
> -    exit 1
> +if ! ParanoidAndNotRoot 1
> +then
> +    user_sample=$(perf record -e ibs_fetch/swfilt/k -o- true | perf script -i- -F misc | grep -c ^U)
> +    if [ ${user_sample} -ne 0 ]; then
> +        echo "[FAIL] unexpected user samples: " ${user_sample}
> +        exit 1
> +    fi
> +else
> +    echo "[SKIP] not root and perf_event_paranoid too high for exclude_user"
> +    err=2
>  fi
> +
> +exit $err
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 
