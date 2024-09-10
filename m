Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC7B192D98;
	Tue, 10 Sep 2024 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000138; cv=none; b=pFESZXwDUBnPEx+iN7wqwV1TqhPYk1R+Oxh3mc/FRNVvb+HLVKZn1xMfXjqDiwFSIQcVYCz0GN/Yhn2Oaai081MBEHF93ADSajFaM97Xs8hVzRIbCF1LLcfVzqGDdxEqTZdJ1+N5tWK2+G1gZfWQIYMJtuJBsK5Mw9zovDNAYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000138; c=relaxed/simple;
	bh=9bgcggmusIyHaXrVjg2o/SN8el2ZykQHD9ew7dDqqcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGKOlfXZZJ0MTs4LApejf2oh2yv4ao9rSzjnqIAofSiSscRuELW2DMRzQix+9z0KaKvPOG7+Lg/u6HT+rNPnYLJ/ptuvfhSHF7Qum8X+waTOjPIunBuqapZqRLS+cQA/IFybOR+XEpBKcvZIFoOWrQnc2mGI0z/hwtl+A6u/K9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D825113E;
	Tue, 10 Sep 2024 13:29:23 -0700 (PDT)
Received: from [10.57.82.50] (unknown [10.57.82.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DE663F66E;
	Tue, 10 Sep 2024 13:28:48 -0700 (PDT)
Message-ID: <5a0d9510-eccb-4074-964e-ae068b4ee31e@arm.com>
Date: Tue, 10 Sep 2024 21:28:48 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] perf cs-etm: Don't flush when packet_queue fills up
To: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, coresight@lists.linaro.org,
 scclevenger@os.amperecomputing.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Ben Gainey <ben.gainey@arm.com>, Ruidong Tian
 <tianruidong@linux.alibaba.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240905105043.160225-1-james.clark@linaro.org>
 <20240905105043.160225-2-james.clark@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240905105043.160225-2-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/2024 11:50 AM, James Clark wrote:

[...]

> cs_etm__flush(), like cs_etm__sample() is an operation that generates a
> sample and then swaps the current with the previous packet. Calling
> flush after processing the queues results in two swaps which corrupts
> the next sample. Therefore it wasn't appropriate to call flush here so
> remove it.

In the cs_etm__sample(), if the period is not overflow, it is not necessarily
to generate instruction samples and copy back stack entries. This is why we
want to call cs_etm__flush() to make sure the last packet can be recorded
properly for instruction sample with back stacks.

We also need to take account into the case for the end of the session - in
this case we need to generate samples for the last packet for complete info.

I am wandering should we remove the cs_etm__packet_swap() from cs_etm__sample()?

Thanks,
Leo

> Flushing is still done on a discontinuity to explicitly clear the last
> branch buffer, but when the packet_queue fills up before reaching a
> timestamp, that's not a discontinuity and the call to
> cs_etm__process_traceid_queue() already generated samples and drained
> the buffers correctly.
> 
> This is visible by looking for a branch that has the same target as the
> previous branch and the following source is before the address of the
> last target, which is impossible as execution would have had to have
> gone backwards:
> 
>   ffff800080849d40 _find_next_and_bit+0x78 => ffff80008011cadc update_sg_lb_stats+0x94
>    (packet_queue fills here before a timestamp, resulting in a flush and
>     branch target ffff80008011cadc is duplicated.)
>   ffff80008011cb1c update_sg_lb_stats+0xd4 => ffff80008011cadc update_sg_lb_stats+0x94
>   ffff8000801117c4 cpu_util+0x24 => ffff8000801117d4 cpu_util+0x34
> 
> After removing the flush the correct branch target is used for the
> second sample, and ffff8000801117c4 is no longer before the previous
> address:
> 
>   ffff800080849d40 _find_next_and_bit+0x78 => ffff80008011cadc update_sg_lb_stats+0x94
>   ffff80008011cb1c update_sg_lb_stats+0xd4 => ffff8000801117a0 cpu_util+0x0
>   ffff8000801117c4 cpu_util+0x24 => ffff8000801117d4 cpu_util+0x34
> 
> Fixes: 21fe8dc1191a ("perf cs-etm: Add support for CPU-wide trace scenarios")
> Reported-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> Closes: https://lore.kernel.org/all/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 90f32f327b9b..602e791ff5ba 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2490,12 +2490,6 @@ static void cs_etm__clear_all_traceid_queues(struct cs_etm_queue *etmq)
> 
>                 /* Ignore return value */
>                 cs_etm__process_traceid_queue(etmq, tidq);
> -
> -               /*
> -                * Generate an instruction sample with the remaining
> -                * branchstack entries.
> -                */
> -               cs_etm__flush(etmq, tidq);
>         }
>  }
> 
> --
> 2.34.1
> 
