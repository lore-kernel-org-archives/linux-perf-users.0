Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ECC1917F1;
	Thu, 19 Dec 2024 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587312; cv=none; b=aGRm4c4Xl+Ey6UcxNpEQ2o9aRIr76AQSu3Mveo0O3z+l99zsLPHNFw7SxgnQomoOiuJnlwEkq+1ilEsD7N2TDO0brh959gI+LglILgr3wHKtvdXhUyRG6dkFepAs1Mf2Pf22Sr0P4idbFqulcsGtnETyKm9bvbtuvVOGyOSM3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587312; c=relaxed/simple;
	bh=5Xj3Up9XP9UelnN4ePQmTVs4Z9YVeW22pZctLuEhWtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Neq8wLg818cww9kCQLP08N0KBpykLMb/FWILz/d2OVtsWsjklHQ+IwwNvQ41cU3hRsoNeAhf9zlHTgfIvP6y1AFusjknasu37MWV/jEli6cG94WWEQdRt7WttAQl104JDjzNFojs8gpkPaNqDgAxJomLgDpwzSbdOKnmB2RuIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmFmEjDh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmFmEjDh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610F7C4CECE;
	Thu, 19 Dec 2024 05:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734587311;
	bh=5Xj3Up9XP9UelnN4ePQmTVs4Z9YVeW22pZctLuEhWtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hmFmEjDh25ldQyYzuRRWwNfwY/1s/byJShB9ImV9A5PHIFaxUNfwWGX43ueHGxgb0
	 NIxPNoq2dAteZ+1pHtKdcVZ3FxMe9xKDgZO6S0VA1ibC6q0ZXeRcgSIHdwGlmPnX6d
	 n9P+z381MXj0leHzTQ+MsMtWsl5+PznsndzIFN2G1mdKRAuoejPhn0C3j5367lZ5ac
	 q8I+3g3EPo5pl2HcgzrN2BaDMpfLpdZkteZOv49hhengm7AbZgnU85hhq9MxNh/lfw
	 Y3y0l1vQC5hajZgLcIyN2c3PrZVnQaRs17am4qQeyEw9iPZ7Dchn1zXBOG6Kpz+UlV
	 /bgNTsXy52GTA==
Date: Wed, 18 Dec 2024 21:48:29 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: test: Speed up running brstack test
Message-ID: <Z2OzrfsiTaHagLt-@google.com>
References: <20241213231312.2640687-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213231312.2640687-2-robh@kernel.org>

On Fri, Dec 13, 2024 at 05:13:12PM -0600, Rob Herring (Arm) wrote:
> From: James Clark <james.clark@arm.com>
> 
> The brstack test runs quite slowly in software models. Part of the reason
> is "xargs -n1" is quite inefficient in replacing spaces with newlines.
> While that's not noticeable on normal machines, it is on software models.
> Use "tr -s ' ' '\n'" instead which can do the same transformation, but is
> much faster. For comparison on an M1 Macbook Pro:
> 
> $ time seq -s ' ' 10000 | xargs -n1 > /dev/null
> 
> real    0m2.729s
> user    0m2.009s
> sys     0m0.914s
> $ time seq -s ' ' 10000 | tr -s ' ' '\n' | grep '.' > /dev/null
> 
> real    0m0.002s
> user    0m0.001s
> sys     0m0.001s
> 
> The "grep '.'" is also needed to remove any remaining blank lines.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> [robh: Drop changing loop iterations on arm64. Squash blank line fix and redo commit msg]
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> Originally part of this series[1], but I've dropped any Arm specifics, 
> and it stands on its own. No reason this needs to wait on Arm BRBE 
> support (which I'm working on now). I don't expect to have other changes 
> to this test related to BRBE anymore.
> 
> [1] https://lore.kernel.org/all/20240613061731.3109448-8-anshuman.khandual@arm.com/
> 
>  tools/perf/tests/shell/test_brstack.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> index 5f14d0cb013f..e01df7581393 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -30,7 +30,7 @@ test_user_branches() {
>  	echo "Testing user branch stack sampling"
>  
>  	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- ${TESTPROG} > /dev/null 2>&1
> -	perf script -i $TMPDIR/perf.data --fields brstacksym | xargs -n1 > $TMPDIR/perf.script
> +	perf script -i $TMPDIR/perf.data --fields brstacksym | tr -s ' ' '\n' > $TMPDIR/perf.script
>  
>  	# example of branch entries:
>  	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
> @@ -59,7 +59,7 @@ test_filter() {
>  	echo "Testing branch stack filtering permutation ($test_filter_filter,$test_filter_expect)"
>  
>  	perf record -o $TMPDIR/perf.data --branch-filter $test_filter_filter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
> -	perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $TMPDIR/perf.script
> +	perf script -i $TMPDIR/perf.data --fields brstack | tr -s ' ' '\n' | grep '.' > $TMPDIR/perf.script
>  
>  	# fail if we find any branch type that doesn't match any of the expected ones
>  	# also consider UNKNOWN branch types (-)
> -- 
> 2.45.2
> 
