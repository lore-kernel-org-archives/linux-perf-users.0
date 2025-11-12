Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EACDC2E0;
	Wed, 12 Nov 2025 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762909598; cv=none; b=eEcw/Vi/4oIqCZSi7ZHxrbMwlAnLqQl0SE+mwrC3CCRU9Xx4lS4apbKF2x7nshwN/ZAsGwhOZl+lHWRkORnhjNqpm7snSaFYuaSP23zihAUR9lceCXrlXnRItAZxvnIGIidlG5LBIuC+VIO1Q/B79c8pi8yDhbApCMiiBsm8HM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762909598; c=relaxed/simple;
	bh=EUbR/re2ASt9Vb5FItFEba60HxhgOFWy9gdqo3b4Wj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9AoMb2xyRBTpn+vQ5337pihMc5FjSqLVNWbaXYkQSP5YWmpfjaoE4LJtHBaieznrC8ZjFBYAsBfc3YYBdmldfcsuWbKM3sN/PAlgH8tmED1NQtGY+4xgNj8t5eCTgUE9gAOg4A4KBfL3wKS46UDYvitu/zt6yw2S4NVGisEE+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA7rcaSx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA7rcaSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A882C4CEF5;
	Wed, 12 Nov 2025 01:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762909598;
	bh=EUbR/re2ASt9Vb5FItFEba60HxhgOFWy9gdqo3b4Wj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LA7rcaSxBfCntsSZb963NAhPYDrH4LbzZFq+NNjeQO9ZU7nUAdf47dRX8huD8gknf
	 n0Bjctx88ehvcI4tnSHMo5r4bhXng5uziws5qk2LYDk92ERHLIORXvzG+6EfhsWYMD
	 LbE2wJ8ujS141Bdn6fsWgocVBt8/mDpVeyRhk4ifXYKxpxRktjiKHrbOzM8deF5Ms3
	 w7tOOY57siGHWZqH5mDk3TYTmhayVuOLxeNjzffb5/vTgL+TRHphmozLK+z6IVGP7I
	 T1ggTypUCvcI1vUJJSeOi7m1dMxzz++bJcVpAXmBNFCiiX94IYM9W6lztRJ8lPR0m8
	 ZJEq1RktndZIA==
Date: Tue, 11 Nov 2025 17:06:34 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	thomas.falcon@intel.com, dapeng1.mi@linux.intel.com,
	xudong.hao@intel.com
Subject: Re: [PATCH] perf test: Add a perf event fallback test
Message-ID: <aRPdmoNdUWIlWhJU@google.com>
References: <20251111224246.73673-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111224246.73673-1-zide.chen@intel.com>

On Tue, Nov 11, 2025 at 02:42:46PM -0800, Zide Chen wrote:
> This adds test cases to verify the precise ip fallback logic:
> 
> - If the system supports precise ip, for an event given with the maximum
>   precision level, it should be able to decrease precise_ip to find a
>   supported level.
> - The same fallback behavior should also work in more complex scenarios,
>   such as event groups or when PEBS is involved
> 
> Additional fallback tests, such as those covering missing feature cases,
> can be added in the future.
> 
> Suggested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  .../tests/shell/test_event_open_fallback.sh   | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_event_open_fallback.sh
> 
> diff --git a/tools/perf/tests/shell/test_event_open_fallback.sh b/tools/perf/tests/shell/test_event_open_fallback.sh
> new file mode 100755
> index 000000000000..72c1ac32c785
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_event_open_fallback.sh
> @@ -0,0 +1,86 @@
> +#!/bin/bash
> +# Perf event open fallback test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +skip_cnt=0
> +ok_cnt=0
> +err_cnt=0
> +
> +cleanup()
> +{
> +	rm -f perf.data
> +	rm -f perf.data.old
> +	trap - EXIT TERM INT
> +}
> +
> +trap_cleanup()
> +{
> +	cleanup
> +	exit 1
> +}
> +
> +trap trap_cleanup EXIT TERM INT
> +
> +perf_record()
> +{
> +	perf record "$@" -- true 1>/dev/null 2>&1
> +}
> +
> +test_decrease_precise_ip()
> +{
> +	echo "Decrease precise ip test"
> +
> +	perf list pmu | grep -q 'cycles' || return 2
> +
> +	if ! perf_record -e cycles; then
> +		return 2
> +	fi
> +
> +	# It should reduce precision level down to 0 if needed.
> +	if ! perf_record -e cycles:ppp; then

I think you need 'P' instead of 'ppp' for automatic precision.

Thanks,
Namhyung


> +		return 1
> +	fi
> +	return 0
> +}
> +
> +test_decrease_precise_ip_complicated()
> +{
> +	echo "Decrease precise ip test (complicated case)"
> +
> +	perf list pmu | grep -q 'mem-loads-aux' || return 2
> +
> +	if ! perf_record -e '{cpu/mem-loads-aux/S,cpu/mem-loads/PS}'; then
> +		return 1
> +	fi
> +	return 0
> +}
> +
> +count_result()
> +{
> +	if [ "$1" -eq 2 ] ; then
> +		skip_cnt=$((skip_cnt + 1))
> +		return
> +	fi
> +	if [ "$1" -eq 0 ] ; then
> +		ok_cnt=$((ok_cnt + 1))
> +		return
> +	fi
> +	err_cnt=$((err_cnt + 1))
> +}
> +
> +ret=0
> +test_decrease_precise_ip		|| ret=$? ; count_result $ret ; ret=0
> +test_decrease_precise_ip_complicated	|| ret=$? ; count_result $ret ; ret=0
> +
> +cleanup
> +
> +if [ ${err_cnt} -gt 0 ] ; then
> +	exit 1
> +fi
> +
> +if [ ${ok_cnt} -gt 0 ] ; then
> +	exit 0
> +fi
> +
> +# Skip
> +exit 2
> -- 
> 2.51.1
> 
