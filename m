Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A7C19D093;
	Mon,  8 Sep 2025 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757374514; cv=none; b=A/MdRU+ty9sPM2h5ZUD/PWFAsED480+aigep9MiaEKT17Luxg37fP9Vg5pwJxweDztlPKYt6y08te8evj0rvthiPIh2oQSZsddblCC3WLrCuFYUjKPaX877+m2ojcln2ehTJyXxfGoDNa38Wvfo6eVoRk4B5AjzxSTgqwyQQvpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757374514; c=relaxed/simple;
	bh=ObGim7UGY/Gqo+55a2h+UbBIJQQ5lfF4BRj1q/BpMz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHSKnZqYHHptPVREX5VzoJDMS2zTqensSep1BhfwvIVz+bEhKr+P6IcIX5R2PWzPfmYrtZTs/ZSe6V/tK/OQiAwPOkKCGkFDfoB0oViy+XXlyT0LXmFdDR4E9/gq+agg5A3NiGtLXeuw1SNe+IRrdMIytDWk3yQQq5LTk/QwZpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vB2VB/YW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB2VB/YW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C03C4CEF1;
	Mon,  8 Sep 2025 23:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757374513;
	bh=ObGim7UGY/Gqo+55a2h+UbBIJQQ5lfF4BRj1q/BpMz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vB2VB/YWMV+D2JpxoXNTig8qW/5IyhS3mHiU18W62SSs3sTpySTi92oN4lSOkKqIJ
	 gZusPGKTq3LfNbvvwrgByQGM7pXcr++vAODKQDO7CLyEejukTETl6NCo98d2vFj+U1
	 StqIV88ezTr7vSzMBXS3k020pXJKTD4NDoKuCgRfmBwF+wSTnK4s3xnPyrV/6DGLND
	 tgVLHmdGLswIha8tS42oPBqWVs/YqEWaI9WVsyIoAzbHeVskwyYXOExCPaex8DZ0nW
	 uT6iyoRKgNH3NJsE8CU5Tfr1rAuIXK1zUqs1gA7KhiABTOvsKacpqTjr6e2kcuS4UT
	 tvL68/Zq/nqKg==
Date: Mon, 8 Sep 2025 16:35:11 -0700
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
Subject: Re: [PATCH v1] perf test: AMD IBS swfilt skip kernel tests if
 paranoia is >1
Message-ID: <aL9oL8aAMam676Ra@google.com>
References: <20250908221727.3635572-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908221727.3635572-1-irogers@google.com>

Hi Ian,

On Mon, Sep 08, 2025 at 03:17:27PM -0700, Ian Rogers wrote:
> If not root and the perf_event_paranoid is set >1 swfilt will fail to
> open the event failing the test. Add check to skip the test in that
> case.

Thanks for the fix!

> 
> Some corrections to the kernel/user sample count test.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/amd-ibs-swfilt.sh | 57 +++++++++++++++++-------
>  1 file changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/amd-ibs-swfilt.sh b/tools/perf/tests/shell/amd-ibs-swfilt.sh
> index 7045ec72ba4c..80d5bf8db40c 100755
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
> @@ -46,22 +57,36 @@ if [ $? -ne 0 ]; then
>  fi
>  
>  # check system wide recording
> -perf record -aB --synth=no -e ibs_op/swfilt/k -o /dev/null true
> -if [ $? -ne 0 ]; then
> -    echo "[FAIL] IBS op PMU cannot handle swfilt in system-wide mode"
> -    exit 1
> +if ! ParanoidAndNotRoot 1
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
>  
> -kernel_sample=$(perf record -e ibs_op/swfilt/u -o- true | perf script -i- -F misc | grep -c ^K)
> -if [ ${kernel_sample} -ne 0 ]; then
> -    echo "[FAIL] unexpected kernel samples: " ${kernel_sample}
> -    exit 1
> -fi
> -
> -user_sample=$(perf record -e ibs_fetch/swfilt/k -o- true | perf script -i- -F misc | grep -c ^U)
> +user_sample=$(perf record -e ibs_op/swfilt/u -o- true | perf script -i- -F misc | grep -c ^U)

I think it should count kernel samples now (with ^K) as it sets 'u'
modifier (exclude_kernel).


>  if [ ${user_sample} -ne 0 ]; then
>      echo "[FAIL] unexpected user samples: " ${user_sample}

So that it should not have unexpected kernel samples.


>      exit 1
>  fi
> +
> +if ! ParanoidAndNotRoot 1
> +then
> +    kernel_sample=$(perf record -e ibs_fetch/swfilt/k -o- true | perf script -i- -F misc | grep -c ^K)
> +    if [ ${kernel_sample} -ne 0 ]; then
> +        echo "[FAIL] unexpected kernel samples: " ${kernel_sample}

Vice versa.  It should count unexpected user samples from 'k' modifier.

Thanks,
Namhyung


> +        exit 1
> +    fi
> +else
> +    echo "[SKIP] not root and perf_event_paranoid too high for exclude_user"
> +    err=2
> +fi
> +
> +exit $err
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 
