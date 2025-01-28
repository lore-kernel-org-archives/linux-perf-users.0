Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F91D4335;
	Tue, 28 Jan 2025 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086127; cv=none; b=nYl1a788fEjit3LhZEBFkmzcxdhPN2QWfCdwWxOmIBydGnjGE40vxakF/DMaiyg5XkT1ihllVqHrupL5Q7cXznKZrvoSHmvOfoPYR25laorF8t8070VeC1y3T8j3ldub4EVVacBqb9hrzDdTA9gmqAPOQhdhw/eiiEYpXoBXSdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086127; c=relaxed/simple;
	bh=XOQiXpKZNKq3D5+zEEJI9wNDR3rZq2f2vO/USpRJQPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tt8JBZJWMfX6uWYxCxH8DKA00shomG1HizMF1PfDlJ0BfMWOLWf6gQSCFV29TfzZ8IBCK6agdw6I0PbNVMGhw86X+KUCORB0NNszXkBpT9MLEOFTHcNwqe3+MRHzIxJfl+k7SRox88agDoy3XWZJP2K2m1I3sUL7kWXxhG1OMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfuaPf2S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfuaPf2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20E2C4CED3;
	Tue, 28 Jan 2025 17:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738086125;
	bh=XOQiXpKZNKq3D5+zEEJI9wNDR3rZq2f2vO/USpRJQPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NfuaPf2SbQcF0nqVI2SkqFCnKoSr0lgr81idNZskfxhUJoBvM8M9XDfMgx3G76Nud
	 2t2pRTE66yPYnXTsxzU9FeeMUrC6jGP3COT5Z63harDXRU8pO351/SAUC7sMwcKEaO
	 LFA12HE0x84ZypOnrz/fkGCJRMSSkSw4rFZTfcpmSudZ42a1cVUZxGOgLrLWZ6yRpj
	 9G2po2tsHiGPfPzSuDOkJ5g+inuyA6NtmrKz9y4Or/HUnRxHLhkLyGfvlJ1sztW+/f
	 1O9jV22LWUNFvE5ujmhFPDy0WTbjSwnxEWQ0WO015s3x94HErHVcRYAk4AX/MpzBgV
	 ErNDMJ8B2xj7w==
Date: Tue, 28 Jan 2025 09:42:03 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test: Skip Intel TPEBS under hypervisor
Message-ID: <Z5kW69biAERrAFxe@google.com>
References: <20250128043739.256305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250128043739.256305-1-irogers@google.com>

On Mon, Jan 27, 2025 at 08:37:39PM -0800, Ian Rogers wrote:
> Intel TPEBS test skips on non-Intel CPUs. On Intel CPUs under a
> hypervisor the cache-misses event may not be present. Skip the test
> under this condition.
> 
> Refactor the output code to be placed in a file so that on a signal
> the file can be dumped. This was necessary to catch the issue above as
> the failing perf record command would fail without output.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Fix lost :R and use :p with record as it is ignored by perf stat.
> ---
>  .../perf/tests/shell/test_stat_intel_tpebs.sh | 36 +++++++++++--------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> index 695dcb93bb5e..a330ecdb7ba5 100755
> --- a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> @@ -20,31 +20,39 @@ then
>    exit 2
>  fi
>  
> +stat_output=$(mktemp /tmp/__perf_stat_tpebs_output.XXXXX)
> +
>  cleanup() {
> +  rm -rf "${stat_output}"
>    trap - EXIT TERM INT
>  }
>  
>  trap_cleanup() {
>    echo "Unexpected signal in ${FUNCNAME[1]}"
> +  cat "${stat_output}"
>    cleanup
>    exit 1
>  }
>  trap trap_cleanup EXIT TERM INT
>  
> -# Use this event for testing because it should exist in all platforms
> -event=cache-misses:R
> -
> -# Hybrid platforms output like "cpu_atom/cache-misses/R", rather than as above
> -alt_name=/cache-misses/R
> +# Event to be used in tests
> +event=cache-misses
>  
> -# Without this cmd option, default value or zero is returned
> -#echo "Testing without --record-tpebs"
> -#result=$(perf stat -e "$event" true 2>&1)
> -#[[ "$result" =~ $event || "$result" =~ $alt_name ]] || exit 1
> +if ! perf record -e "${event}:p" -a -o /dev/null sleep 0.01 > "${stat_output}" 2>&1

Shouldn't it simply be

  if ! perf list hw | grep -q cache-misses

?  Doesn't it work on hybrid?

Thanks,
Namhyung


> +then
> +  echo "Missing ${event} support"
> +  cleanup
> +  exit 2
> +fi
>  
>  test_with_record_tpebs() {
>    echo "Testing with --record-tpebs"
> -  result=$(perf stat -e "$event" --record-tpebs -a sleep 0.01 2>&1)
> +  if ! perf stat -e "${event}:R" --record-tpebs -a sleep 0.01 > "${stat_output}" 2>&1
> +  then
> +    echo "Testing with --record-tpebs [Failed perf stat]"
> +    cat "${stat_output}"
> +    exit 1
> +  fi
>  
>    # Expected output:
>    # $ perf stat --record-tpebs -e cache-misses:R -a sleep 0.01
> @@ -57,16 +65,16 @@ test_with_record_tpebs() {
>    #                  0      cache-misses:R
>    #
>    #        0.013963299 seconds time elapsed
> -  if [[ ! "$result" =~ "perf record" ]]
> +  if ! grep "perf record" "${stat_output}"
>    then
>      echo "Testing with --record-tpebs [Failed missing perf record]"
> -    echo "$result"
> +    cat "${stat_output}"
>      exit 1
>    fi
> -  if [[ ! "$result" =~ $event && ! "$result" =~ $alt_name ]]
> +  if ! grep "${event}:R" "${stat_output}" && ! grep "/${event}/R" "${stat_output}"
>    then
>      echo "Testing with --record-tpebs [Failed missing event name]"
> -    echo "$result"
> +    cat "${stat_output}"
>      exit 1
>    fi
>    echo "Testing with --record-tpebs [Success]"
> -- 
> 2.48.1.262.g85cc9f2d1e-goog
> 
