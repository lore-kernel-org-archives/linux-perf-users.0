Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE47B1DF72D;
	Mon, 10 Mar 2025 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641960; cv=none; b=IxrXWZhVfM9b9jdBjReDjCfLXsJR+SP/3oM6X3/vBBy6/QoN3qq9/0J0BxT1KRgBKEZm6NYBm+Nk4GmQfGiVgWGjnE8j7yd9fyN0ILpTVvE2kc3oY3VETLp1cODL7OlQjg8Ow7oXM4sfV1AYSUMB4czdyqbau9Mpd2xkcD+B6TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641960; c=relaxed/simple;
	bh=Kv0c7TF7OFif71V6NrQrCUDRqomHFlrAt/eJUIvztuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iReWZGowt/s/uK+a1dNqBBkwq6J/qn2eArUqZqfgp/XO4oJd4s/fxJ5WeXxvHdbtbmhn4koXvEaEXWCR8R82ycMTM583dSlRjm4L6h7tjL/o1JlVzjwL+Mo3BiwrqDJdj5i3+NU1wFCPwjdRlyyRyJOFUNxPU3MShQaA3ycbS2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuumVqI2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuumVqI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE14C4CEE5;
	Mon, 10 Mar 2025 21:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741641960;
	bh=Kv0c7TF7OFif71V6NrQrCUDRqomHFlrAt/eJUIvztuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EuumVqI24ObNvIM//JkwOhXbiD00ngIdjYrTUDpKcDOwsmFl8cnc7NIVpcmBxyUeG
	 9kCS73ynvCvsdqlZ85SfZz5hXSlQpRrDrJuSTYIcFQNNE9BAmiOjSgUO6LXrSGuSJe
	 +tqnQfxiVNMU1AkLbque7u0ZIhirsJIBXW1ZzI77Kmz9ME4u8ND63LK79otI0ecOSf
	 43aLcwVoPP3HFoFzZCHPv0yNxINGSDyoDZtftp9KsYrpBiJWFpcc0ejL3FACgIWh1p
	 Oa6VZoZjSe34qCKnLQqIt83Kb6mVKbHM0H4sObA+Dms2kMznneyp/jzfN1xX48JvKh
	 3XID2bLINNOyg==
Date: Mon, 10 Mar 2025 14:25:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: Re: [PATCH v2 4/5] perf x86 evlist: Update comments on topdown
 regrouping
Message-ID: <Z89Y5pUchAaJj4PY@google.com>
References: <20250307023906.1135613-1-irogers@google.com>
 <20250307023906.1135613-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307023906.1135613-4-irogers@google.com>

Hello,

On Thu, Mar 06, 2025 at 06:39:05PM -0800, Ian Rogers wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Update to remove comments about groupings not working and with the:
> ```
> perf stat -e "{instructions,slots},{cycles,topdown-retiring}"
> ```
> case that now works.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Dapeng, can I get your Signed-off-by here?

Thanks,
Namhyung

> ---
>  tools/perf/arch/x86/util/evlist.c | 27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index ed205d1b207d..7905a28d7734 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -39,28 +39,13 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>  	 *         26,319,024      slots
>  	 *          2,427,791      instructions
>  	 *          2,683,508      topdown-retiring
> -	 *
> -	 * If slots event and topdown metrics events are not in same group, the
> -	 * topdown metrics events must be first event after the slots event group,
> -	 * otherwise topdown metrics events can't be regrouped correctly, e.g.
> -	 *
> -	 * a. perf stat -e "{instructions,slots},cycles,topdown-retiring" -C0 sleep 1
> -	 *    WARNING: events were regrouped to match PMUs
> -	 *     Performance counter stats for 'CPU(s) 0':
> -	 *         17,923,134      slots
> -	 *          2,154,855      instructions
> -	 *          3,015,058      cycles
> -	 *    <not supported>      topdown-retiring
> -	 *
> -	 * If slots event and topdown metrics events are in two groups, the group which
> -	 * has topdown metrics events must contain only the topdown metrics event,
> -	 * otherwise topdown metrics event can't be regrouped correctly as well, e.g.
> -	 *
> -	 * a. perf stat -e "{instructions,slots},{topdown-retiring,cycles}" -C0 sleep 1
> +	 * e. slots event and metrics event are in a group and not adjacent
> +	 *    perf stat -e "{instructions,slots},cycles,topdown-retiring" -C0 sleep 1
>  	 *    WARNING: events were regrouped to match PMUs
> -	 *    Error:
> -	 *    The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
> -	 *    event (topdown-retiring)
> +	 *         68,433,522      slots
> +	 *          8,856,102      topdown-retiring
> +	 *          7,791,494      instructions
> +	 *         11,469,513      cycles
>  	 */
>  	if (topdown_sys_has_perf_metrics() &&
>  	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog
> 
