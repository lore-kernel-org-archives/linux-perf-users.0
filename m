Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93D1D88B3;
	Fri, 13 Sep 2024 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226284; cv=none; b=Cy2i+Lq3U9fgb5PQ8/wM6tW5THC5fTNDzPzlQGllxvSrsVbIFLSMLUXmEsHUNRg/b7jIpJg2FM9I56jJYmNoDWy78fQC4a2r5b4hc0WrZ2adp6xDCYno3f8xOBR+6qlYbtr0PcEpQJQjTsZ/LlBY4J1sjcScCjlFQljwa8SAV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226284; c=relaxed/simple;
	bh=hNF10EU/tNZ8IqoAtsml7wSe8q7heDmGQxZa2y5rL80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVW5ZEg4f5iQhfJABL528dyhcO/pni9q+i52Q+u2p+YvIcsU929Js5Qc264c+0cZ8Q19whE0znsjD0oCPsjLlxd1IV5weRXyI3pS7yI0SARNtI2YjaW5GAZ6pc/QK2Smh50o6KNZyEMOCZcLW9G/lfjTHTEgelYMsGW9EwSZGA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A703613D5;
	Fri, 13 Sep 2024 04:18:30 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 594EE3F64C;
	Fri, 13 Sep 2024 04:17:58 -0700 (PDT)
Message-ID: <b376ad7e-020e-40a2-b26d-f70184753a50@arm.com>
Date: Fri, 13 Sep 2024 12:17:56 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] perf cs-etm: Don't flush when packet_queue fills
 up
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
References: <20240912151143.1264483-1-james.clark@linaro.org>
 <20240912151143.1264483-2-james.clark@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240912151143.1264483-2-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 16:11, James Clark wrote:> 
> cs_etm__flush(), like cs_etm__sample() is an operation that generates a
> sample and then swaps the current with the previous packet. Calling
> flush after processing the queues results in two swaps which corrupts
> the next sample. Therefore it wasn't appropriate to call flush here so
> remove it.
> 
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
>    ffff800080849d40 _find_next_and_bit+0x78 => ffff80008011cadc update_sg_lb_stats+0x94
>     (packet_queue fills here before a timestamp, resulting in a flush and
>      branch target ffff80008011cadc is duplicated.)
>    ffff80008011cb1c update_sg_lb_stats+0xd4 => ffff80008011cadc update_sg_lb_stats+0x94
>    ffff8000801117c4 cpu_util+0x24 => ffff8000801117d4 cpu_util+0x34
> 
> After removing the flush the correct branch target is used for the
> second sample, and ffff8000801117c4 is no longer before the previous
> address:
> 
>    ffff800080849d40 _find_next_and_bit+0x78 => ffff80008011cadc update_sg_lb_stats+0x94
>    ffff80008011cb1c update_sg_lb_stats+0xd4 => ffff8000801117a0 cpu_util+0x0
>    ffff8000801117c4 cpu_util+0x24 => ffff8000801117d4 cpu_util+0x34
> 
> Make sure that a final branch stack is output at the end of the trace
> by calling cs_etm__end_block(). This is already done for both the
> timeless decode paths.

It is right to call cs_etm__flush() for only discontinuity packet and use
cs_etm__end_block() for flushing the end of data block. Thanks for
distinguishing these two different things.

> Fixes: 21fe8dc1191a ("perf cs-etm: Add support for CPU-wide trace scenarios")
> Reported-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> Closes: https://lore.kernel.org/all/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>   tools/perf/util/cs-etm.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 90f32f327b9b..242788ac9625 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2490,12 +2490,6 @@ static void cs_etm__clear_all_traceid_queues(struct cs_etm_queue *etmq)
> 
>                  /* Ignore return value */
>                  cs_etm__process_traceid_queue(etmq, tidq);
> -
> -               /*
> -                * Generate an instruction sample with the remaining
> -                * branchstack entries.
> -                */
> -               cs_etm__flush(etmq, tidq);
>          }
>   }
> 
> @@ -2638,7 +2632,7 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
> 
>          while (1) {
>                  if (!etm->heap.heap_cnt)
> -                       goto out;
> +                       break;
> 
>                  /* Take the entry at the top of the min heap */
>                  cs_queue_nr = etm->heap.heap_array[0].queue_nr;
> @@ -2721,6 +2715,23 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
>                  ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
>          }
> 
> +       for (i = 0; i < etm->queues.nr_queues; i++) {
> +               struct int_node *inode;
> +
> +               etmq = etm->queues.queue_array[i].priv;
> +               if (!etmq)
> +                       continue;
> +
> +               intlist__for_each_entry(inode, etmq->traceid_queues_list) {
> +                       int idx = (int)(intptr_t)inode->priv;
> +
> +                       /* Flush any remaining branch stack entries */
> +                       tidq = etmq->traceid_queues[idx];
> +                       ret = cs_etm__end_block(etmq, tidq);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
>   out:
>          return ret;
>   }
> --
> 2.34.1
> 
