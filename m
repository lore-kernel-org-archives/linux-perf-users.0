Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB69258CD8;
	Wed, 10 Sep 2025 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525985; cv=none; b=c/Sq/1YE6X6aupGQ84P5hCPToJJEZG3AGZvkCeUQzEIdwnOOy8LTjiQhfodTdOXTLH/5KECJeLZGqkCCAsNYGi0e4IEXtVlgtZKpLd/TgFEqM/VtY2K+DX+t/beHeYAzC89dA18vNXVRvniNXqCSN5wRdOY+6Q0nf5Unj9XuQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525985; c=relaxed/simple;
	bh=9NYPXM8rN6ZU04YuT+J0cq4PyeCc2Pt6HtA8XSCm9us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s70VY/aDDtbPh7cXaOOLhraPa5FC/S2bJHFZ7Z0qU9wbcyJUk/e4MqZ+ovEkOtME+JIuYiNsFw3FxUjj6r07cZM6RxzVkNfTGuCEwjNpYzloUDj5aQp29oNKkABOuNXgD1Ze25aesafqnOmJCKagGiI9fQ3LVGonhB+rfSuwde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU0wCdD1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU0wCdD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E41EC4CEEB;
	Wed, 10 Sep 2025 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757525984;
	bh=9NYPXM8rN6ZU04YuT+J0cq4PyeCc2Pt6HtA8XSCm9us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LU0wCdD1/NtlPZTNZ75T4EWOv1EHk8/TsU+F1e5uL470ftUl6ESQt08Wez+cbJJ4B
	 6rsADo8CZRieeFO85WPE5QWH+WB7Tb0BItNhWxFWGUBiJsTakOdx6F7rLXh+ekMfHq
	 jO8Q1KNsROLsQFuHJrpsw9k4MAcC9RFfJTpgkEgdIowPED9nvR6jK0qo1vCzFTUSg7
	 eeEOH5u7iNG6CnP/YcRhmCTiwqa86YXaPyR7z9jE6bTZvfVFUFKUj634XM/Df9W6E3
	 AAtkfNEXpwSdy26dtJXnBsu38ssLD5lu/v0bfIYQDww8AUzJiIDTMoIzH+V8mkO3Nj
	 richMcesv2stA==
Date: Wed, 10 Sep 2025 10:39:42 -0700
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
Subject: Re: [PATCH v2] perf test: AMD IBS swfilt skip kernel tests if
 paranoia is >1
Message-ID: <aMG33krB2PGJNZKu@google.com>
References: <20250910155635.46187-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910155635.46187-1-irogers@google.com>

On Wed, Sep 10, 2025 at 08:56:35AM -0700, Ian Rogers wrote:
> If not root and the perf_event_paranoid is set >1 swfilt will fail to
> open the event failing the test. Add check to skip the test in that
> case.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> Remove incorrect sample count corrections
> ---
>  tools/perf/tests/shell/amd-ibs-swfilt.sh | 51 ++++++++++++++++++------
>  1 file changed, 38 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/amd-ibs-swfilt.sh b/tools/perf/tests/shell/amd-ibs-swfilt.sh
> index 7045ec72ba4c..ebe1fedb897b 100755
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
> +if ! ParanoidAndNotRoot 1

Using CPU events (-a) requires paranoid level 0.

Thanks,
Namhyung


> +then
> +    perf record -aB --synth=no -e ibs_op/swfilt/k -o /dev/null true
> +    if [ $? -ne 0 ]; then
> +        echo "[FAIL] IBS op PMU cannot handle swfilt in system-wide mode"
> +        exit 1
> +    fi
> +else
> +    echo "[SKIP] not root and perf_event_paranoid too high for exclude_user"
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
