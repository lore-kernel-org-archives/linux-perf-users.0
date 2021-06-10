Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6C3C47094
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 15:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EEE8613D9
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 15:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhFJPlD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:41:03 -0400
Received: from foss.arm.com ([217.140.110.172]:34812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231658AbhFJPk6 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Jun 2021 11:40:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B7BF106F;
        Thu, 10 Jun 2021 08:39:01 -0700 (PDT)
Received: from [10.57.74.218] (unknown [10.57.74.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C4FB3F719;
        Thu, 10 Jun 2021 08:38:58 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] coresight: tmc-etr: Use perf_output_handle::head
 for AUX ring buffer
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20210528161552.654907-1-leo.yan@linaro.org>
 <20210528161552.654907-3-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <68f0fb5e-6f91-66c3-855a-9473bee7de15@arm.com>
Date:   Thu, 10 Jun 2021 16:38:57 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210528161552.654907-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo

On 28/05/2021 17:15, Leo Yan wrote:
> When enable the Arm CoreSight PMU event, the context for AUX ring buffer
> is prepared in the structure perf_output_handle, and its field "head"
> points the head of the AUX ring buffer and it is updated after filling
> AUX trace data into buffer.
> 
> Current code uses an extra field etr_perf_buffer::head to maintain the
> header for the AUX ring buffer, thus it's not necessary and it's better
> to directly perf_output_handle::head.
> 
> This patch removes the header etr_perf_buffer::head and directly used
> perf_output_handle::head as the header for AUX ring buffer.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index acdb59e0e661..b22823d67680 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -32,7 +32,6 @@ struct etr_flat_buf {
>    * @etr_buf		- Actual buffer used by the ETR
>    * @pid			- The PID this etr_perf_buffer belongs to.
>    * @snaphost		- Perf session mode
> - * @head		- handle->head at the beginning of the session.
>    * @nr_pages		- Number of pages in the ring buffer.
>    * @pages		- Array of Pages in the ring buffer.
>    */
> @@ -41,7 +40,6 @@ struct etr_perf_buffer {
>   	struct etr_buf		*etr_buf;
>   	pid_t			pid;
>   	bool			snapshot;
> -	unsigned long		head;
>   	int			nr_pages;
>   	void			**pages;
>   };
> @@ -1437,16 +1435,16 @@ static void tmc_free_etr_buffer(void *config)
>    * buffer to the perf ring buffer.
>    */
>   static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf,
> +				     unsigned long head,
>   				     unsigned long src_offset,
>   				     unsigned long to_copy)
>   {
>   	long bytes;
>   	long pg_idx, pg_offset;
> -	unsigned long head = etr_perf->head;
>   	char **dst_pages, *src_buf;
>   	struct etr_buf *etr_buf = etr_perf->etr_buf;
>   
> -	head = etr_perf->head;
> +	head = PERF_IDX2OFF(head, etr_perf);
>   	pg_idx = head >> PAGE_SHIFT;
>   	pg_offset = head & (PAGE_SIZE - 1);
>   	dst_pages = (char **)etr_perf->pages;
> @@ -1553,7 +1551,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>   	/* Insert barrier packets at the beginning, if there was an overflow */
>   	if (lost)
>   		tmc_etr_buf_insert_barrier_packet(etr_buf, offset);
> -	tmc_etr_sync_perf_buffer(etr_perf, offset, size);
> +	tmc_etr_sync_perf_buffer(etr_perf, handle->head, offset, size);
>   
>   	/*
>   	 * In snapshot mode we simply increment the head by the number of byte
> @@ -1605,8 +1603,6 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>   		goto unlock_out;
>   	}
>   
> -	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
> -
>   	/*
>   	 * No HW configuration is needed if the sink is already in
>   	 * use for this session.
> 

This looks good to me and could avoid any potential issues
with stale offset cached in the etr_perf_buffer.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

