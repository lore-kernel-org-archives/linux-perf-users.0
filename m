Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D2A1D435F;
	Mon, 14 Sep 2026 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349471; cv=none; b=VR076DOkFCctc7xJj8EsIAOBQ3BiEFyEWaucTIpRtmB9h6Xua5ogKrUckoCCDtVd++WJkveJCreeyuQuwHp0jQqdBLwJzTRjvLgvYhwBB/l/it7gLfZEIDj11ZAGXB9M/dcGfeCS1k76f3S/EY2pznw/4eFDj2XUlXmTfS2gAV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349471; c=relaxed/simple;
	bh=gWVeFVlAKTKcweOwPOImfgNVQyZ1l+8DtB1SnjfHfmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKqCW2Lyuogrk+RZFIxLW7+T97l8nDBPRfXv11OEs2qQQ2VtxkqrWE7sRHd+/Aj5z1bmzreFoIAGD1PjqnygpY2QNFxdFbiyDXCWPF4YuMn2ZYyt2i9UusLsOfLJvEqHAV0F5/yJg6P+cOmc9Hg3hNd3xj2NT0VEQHx1czyqvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bf3WpViw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bf3WpViw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B479B1F000FF;
	Mon, 14 Sep 2026 01:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789349470;
	bh=Nc5c8UWQIlOUsS9yEKIrI3enYPLq2wcsLXxA3ky3j0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bf3WpViwi3Mgq/28u/ohKcwNiBgLVYqSRbCj0NoQ4Cp8QeImsm54TK2uPvt4wFhSu
	 lDigTpR+rNL/4BKpv6AW8eMGEX90KQ4z+/UGlVSulzsX8jFc5wuF0EuBOzSMBbRzX+
	 oCtXnaKCvHT8Bd3x2AIzhXHpMaQHZnMNaq/orokwoYczc1mroYbziPGcsqtOCqVTrU
	 VLh9nMOSZW/cmbbI2z7hXPwNtoTm7R7cjFLzPDc6Z0QC4bgaU4bn4wck26TPup7Dji
	 M6RE53llxQXUc22yBRXkL/xt1+/SUBpGFxYW4w66Sa+Nu8lYRyQQyqnK6KpNCOlHkH
	 wEUIH9vLRUb7A==
Date: Sun, 13 Sep 2026 18:31:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 1/8] perf test: Skip data_type_profiling when the PMU
 cannot record memory events
Message-ID: <aqdOXOH6KaBTT_b_@google.com>
References: <20260913222821.3353-1-acme@kernel.org>
 <20260913222821.3353-2-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260913222821.3353-2-acme@kernel.org>

On Sun, Sep 13, 2026 at 07:28:13PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> The test records with 'perf mem record' in per-thread mode and its only
> guard matches one specific message:
> 
>   perf mem record -o /dev/null -- true 2>&1 | \
>         grep -q "failed: no PMU supports the memory events" && exit 2
> 
> A PMU that has memory events but refuses them per-thread falls through
> it, and AMD IBS does:
> 
>   $ perf mem record -o /dev/null -- true
>   Error:
>   Failure to open event 'ibs_op/ldlat=0/u' on PMU 'ibs_op' which will be removed.
>   Invalid event (ibs_op/ldlat=0/u) in per-thread mode, enable system wide with '-a'.
>   Error:
>   Failure to open any events for recording.

Maybe we need to add a fallback logic to add 'swfilt' term for ibs_op.

> 
> What follows is not a skip either.  The script runs under 'set -e', so
> the bare 'perf mem record' in test_basic_annotate() aborts it through the
> EXIT trap, which reports a signal that never happened and exits 1:
> 
>   Basic Rust perf annotate test
>   Unexpected signal in test_basic_annotate
> 
> so 'perf test' turns "this PMU cannot record these events" into a test
> failure:
> 
>   $ perf test "data type profiling"
>    87: perf data type profiling tests             : FAILED!
> 
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/shell/data_type_profiling.sh | 46 +++++++++++++++----
>  1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
> index eca694600a0478d2..a916c410274aa888 100755
> --- a/tools/perf/tests/shell/data_type_profiling.sh
> +++ b/tools/perf/tests/shell/data_type_profiling.sh
> @@ -19,6 +19,15 @@ perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
>  perf mem record -o /dev/null -- true  2>&1 | \
>    		grep -q "failed: no PMU supports the memory events" && exit 2
>  
> +# Skip if per-thread mem record is not supported on this PMU (e.g. AMD IBS
> +# needs system-wide '-a'): it is what the test records with below, and a
> +# failing record must not be reported as a test failure.
> +if ! perf mem record -o /dev/null -- true 2>/dev/null
> +then
> +  echo "Skip: cannot record memory events on this PMU"
> +  exit 2
> +fi
> +
>  cleanup() {
>    rm -rf "${perfdata}" "${perfout}"
>    rm -rf "${perfdata}".old
> @@ -52,25 +61,42 @@ test_basic_annotate() {
>      index=1 ;;
>    esac
>  
> +  # Under 'set -e' a bare failing command aborts the script through the EXIT
> +  # trap, so the commands that report a failure have to be the condition of
> +  # an 'if' for that reporting to ever happen.
>    if [ "x${mode}" == "xBasic" ]
>    then
> -    perf mem record -o "${perfdata}" ${testprogs[$index]} 2> /dev/null
> +    if ! perf mem record -o "${perfdata}" ${testprogs[$index]} 2> /dev/null
> +    then
> +      echo "${mode} annotate [Failed: perf record]"
> +      err=1
> +      return
> +    fi
>    else
> -    perf mem record -o - ${testprogs[$index]} 2> /dev/null > "${perfdata}"
> -  fi
> -  if [ "x$?" != "x0" ]
> -  then
> -    echo "${mode} annotate [Failed: perf record]"
> -    err=1
> -    return
> +    if ! perf mem record -o - ${testprogs[$index]} 2> /dev/null > "${perfdata}"
> +    then
> +      echo "${mode} annotate [Failed: perf record]"
> +      err=1
> +      return
> +    fi
>    fi
>  
>    # Generate the annotated output file
>    if [ "x${mode}" == "xBasic" ]
>    then
> -    perf annotate --code-with-type -i "${perfdata}" --stdio --percent-limit 1 2> /dev/null > "${perfout}"
> +    if ! perf annotate --code-with-type -i "${perfdata}" --stdio --percent-limit 1 2> /dev/null > "${perfout}"
> +    then
> +      echo "${mode} annotate [Failed: perf annotate]"
> +      err=1
> +      return
> +    fi
>    else
> -    perf annotate --code-with-type -i - --stdio 2> /dev/null --percent-limit 1 < "${perfdata}" > "${perfout}"
> +    if ! perf annotate --code-with-type -i - --stdio 2> /dev/null --percent-limit 1 < "${perfdata}" > "${perfout}"
> +    then
> +      echo "${mode} annotate [Failed: perf annotate]"
> +      err=1
> +      return
> +    fi
>    fi
>  
>    # check if it has the target data type
> -- 
> 2.55.0
> 
