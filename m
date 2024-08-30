Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751D444C7C;
	Fri, 30 Aug 2024 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724999538; cv=none; b=s8PoXj/hIXDunaKUn8yvUZNCwSmeYskbowujI+b0+a2yH2GMihxvM3wJJiUwRZQor//Ec7iZhmBoZSAgkHUqq1nOJlGzPZcoADYNJCCud9ZZ+tAGgw2Lu2278mxqAemkrTYGrJaUSBW0oBo7AYMy9RKymcnx+pdX2ktJFAoKQxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724999538; c=relaxed/simple;
	bh=UoC7Tqt2sZoHI4+CzQrsZWia+6J+z2QR8hiT2dGYBog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY4PYlxJ5ploJXj3iE5HuVK+EAdH331LDJvMWvHlO6cJ6wyE055FSR2AUuh75mC4niXRdgMPNaGMMLBpL0K9jh2A0ADiavgcKo36na9M1SvriFyBc5tXKMV2g3iAXT0UV9W+S0YFkLvCcygFdzyP5LVlkx9FYqtC4iMSULu+GE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1RmxXhm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1RmxXhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13394C4CEC4;
	Fri, 30 Aug 2024 06:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724999538;
	bh=UoC7Tqt2sZoHI4+CzQrsZWia+6J+z2QR8hiT2dGYBog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1RmxXhmsX7dEydMo2oMZ0r8rPBpus9eB6kPwhlQxtyOxAuWbZ6KGoMEJE3dCRkrK
	 kkp+Z6zwnUbf6fBV9lV7YbyTaUdvvFHLThJltopij3KtMrp41GuNoRvXU/8IJlKlMB
	 D7ZsF+D2mrCxFVn6IJk2nqeYXGQnVmEdrFkvWlJ76NTLnNyFx7tbQNBgO1gTbXz++y
	 i7j8ukuaBiMOHhy/FNDGa48b7K6AgA1b1OflIfE2AkUnU0GPCPY6TOmFb0INg9mueh
	 3xJGd7UkvuPK+BmKAsWRgtL8Fvh45DDKHAEiY6YjXfH2eUXZLIXEvtvof759Wkffip
	 auVcH29/F4nlA==
Date: Thu, 29 Aug 2024 23:32:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com, ak@linux.intel.com,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Ze Gao <zegao2021@gmail.com>, Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] perf test: Add a test for default perf stat
 command
Message-ID: <ZtFnbq_158fxttmW@google.com>
References: <20240828140736.156703-1-james.clark@linaro.org>
 <20240828140736.156703-8-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828140736.156703-8-james.clark@linaro.org>

Hello,

On Wed, Aug 28, 2024 at 03:07:21PM +0100, James Clark wrote:
> Test that one cycles event is opened for each core PMU when "perf stat"
> is run without arguments.
> 
> The event line can either be output as "pmu/cycles/" or just "cycles" if
> there is only one PMU. Include 2 spaces for padding in the one PMU case
> to avoid matching when the word cycles is included in metric
> descriptions.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/tests/shell/stat.sh | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> index 525d0c44fdc6..24ace1de71cc 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -148,6 +148,26 @@ test_cputype() {
>    echo "cputype test [Success]"
>  }
>  
> +test_hybrid() {
> +  # Test the default stat command on hybrid devices opens one cycles event for
> +  # each CPU type.
> +  echo "hybrid test"
> +
> +  # Count the number of core PMUs
> +  pmus=$(ls /sys/bus/event_source/devices/*/cpus 2>/dev/null | wc -l)

Is it working on non-hybrid systems?  I don't think they have cpus file
in the core PMU.

Thanks,
Namhyung

> +
> +  # Run default Perf stat
> +  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles  " | wc -l)
> +
> +  if [ "$pmus" -ne "$cycles_events" ]
> +  then
> +    echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
> +    err=1
> +    return
> +  fi
> +  echo "hybrid test [Success]"
> +}
> +
>  test_default_stat
>  test_stat_record_report
>  test_stat_record_script
> @@ -155,4 +175,5 @@ test_stat_repeat_weak_groups
>  test_topdown_groups
>  test_topdown_weak_groups
>  test_cputype
> +test_hybrid
>  exit $err
> -- 
> 2.34.1
> 
