Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3098D126BFA;
	Thu, 27 Mar 2025 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089738; cv=none; b=s3LfcEcFMdUYlwGUdQJ0FH143bIhzBtg1X9CZAIdNFdK2rGvjdVhCH42QJ5vz6/Gw9Vh0ljbyNofLAYXO2F60S56cgO21qSp6SC4fb9o0gWVApoxvOXrI/O/AiFHFxnMwiIuUrpQQgmSYihjuSXjJax14jdMkb4KRqIumtsdYv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089738; c=relaxed/simple;
	bh=nT1B1mPebWIpYxQofVLlfS4I0Rkxf+rG+96hm/nsg6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RM6EIrYJmBFkk3dTMwIgjV0flWPPwjuliqMgQcjp1UojHz/XQDB8L/ubXID6UmGnGB0puXpyov4hJOMsgRaIPg8ixtWZ50JzuYNiUsYxEBpfWypXWi/OPoC5OdcGbUsemQn62OwuB3TWNP+bHSFmgOitKyN5WWgL++EUGD3Hz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 890D91063;
	Thu, 27 Mar 2025 08:35:40 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E98CF3F694;
	Thu, 27 Mar 2025 08:35:34 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:35:30 +0000
From: Leo Yan <leo.yan@arm.com>
To: Tanmay Jagdale <tanmay@marvell.com>
Cc: suzuki.poulose@arm.com, mike.leach@linaro.org, james.clark@linaro.org,
	john.g.garry@oracle.com, leo.yan@linux.dev, will@kernel.org,
	acme@kernel.org, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gcherian@marvell.com
Subject: Re: [PATCH V3 1/2] perf: cs-etm: Fixes in instruction sample
 synthesis
Message-ID: <20250327153530.GF604566@e132581.arm.com>
References: <20250327111149.461012-1-tanmay@marvell.com>
 <20250327111149.461012-2-tanmay@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327111149.461012-2-tanmay@marvell.com>

Hi Tanmay,

On Thu, Mar 27, 2025 at 04:41:48PM +0530, Tanmay Jagdale wrote:
> The existing method to synthesize instruction samples has the
> following issues:
> 1. Branch instruction mnemonics were being added to non-branch
>    instructions too.
> 2. Branch target address was missing
> 
> To fix the issues, start synthesizing the instructions from the
> previous packet (tidq->prev_packet) instead of current packet
> (tidq->packet). This way it's easy to figure out the target
> address of the branch instruction in tidq->prev_packet which
> is the current packet's (tidq->packet) first executed instruction.
> 
> Since we have now switched to processing the previous packet
> first, we need not swap the packets during cs_etm__flush().
> 
> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> Reviewed-by: James Clark <james.clark@arm.com>

I saw James's reviewed tag.  However, I have several comments.

Sorry I jumped in too late.

> ---
>  tools/perf/util/cs-etm.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 0bf9e5c27b59..ebed5b98860e 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1576,10 +1576,26 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,

Seems to me, the problem is cs_etm__synth_instruction_sample() is
invoked from multiple callers.

Both the previous packet and packet are valid fo the flow:
  cs_etm__sample()
    `> cs_etm__synth_instruction_sample()

Only the previous packet is valid and the current packet stores stale
data for the flows:

  cs_etm__flush()
    `> cs_etm__synth_instruction_sample()

  cs_etm__end_block()
    `> cs_etm__synth_instruction_sample()

First, as a prerequisite, I think we should resolve the stale data in
the packet.  So we need a fix like:

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c                
index 0bf9e5c27b59..b7b17c0e4806 100644                                         
--- a/tools/perf/util/cs-etm.c                                                  
+++ b/tools/perf/util/cs-etm.c                                                  
@@ -741,6 +741,9 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
                                                                                
        if (etm->synth_opts.branches || etm->synth_opts.last_branch ||          
            etm->synth_opts.instructions) {                                     
+               /* The previous packet will not be used, cleanup it */          
+               memset(tidq->prev_packet, 0x0, sizeof(*tidq->packet));          
+                                                                               
                /*                                                              
                 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for 
                 * the next incoming packet.                                    

>  	sample.stream_id = etmq->etm->instructions_id;
>  	sample.period = period;
>  	sample.cpu = tidq->packet->cpu;

Should we use "prev_packet->cpu" at here?

Even for a branch instruction, as its IP address is from the previous
packet, we should use "prev_packet->cpu" for CPU ID as well.

> -	sample.flags = tidq->prev_packet->flags;
>  	sample.cpumode = event->sample.header.misc;
>  
> -	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
> +	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->prev_packet, &sample);
> +
> +	/* Populate branch target information only when we encounter
> +	 * branch instruction, which is at the end of tidq->prev_packet.
> +	 */
> +	if (addr == (tidq->prev_packet->end_addr - 4)) {

  if (!addr && addr == cs_etm__last_executed_instr(tidq->prev_packet))

> +		/* Update the perf_sample flags using the prev_packet
> +		 * since that is the queue we are synthesizing.
> +		 */
> +		sample.flags = tidq->prev_packet->flags;
> +
> +		/* The last instruction of the previous queue would be a
> +		 * branch operation. Get the target of that branch by looking
> +		 * into the first executed instruction of the current packet
> +		 * queue.
> +		 */
> +		sample.addr = cs_etm__first_executed_instr(tidq->packet);

If connected to the change suggested for cleaning up packet in
cs_etm__packet_swap(), when run at here, if "tidq->packet" is a valid
packet, then it will return a branch target address, otherwise, it
will return 0.

> +	}
>  
>  	if (etm->synth_opts.last_branch)
>  		sample.branch_stack = tidq->last_branch;
> @@ -1771,7 +1787,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>  	/* Get instructions remainder from previous packet */
>  	instrs_prev = tidq->period_instructions;
>  
> -	tidq->period_instructions += tidq->packet->instr_count;
> +	tidq->period_instructions += tidq->prev_packet->instr_count;

A side effect for this change is we will defer to synthesize instruction
samples for _current_ packet, either the packet will be handled after
a new packet incoming, or at the end of a trace chunk.

The problem is for the later one, we can see cs_etm__end_block() and
cs_etm__flush() both only handle the previous packet. As a result, the
last packet will be ignored.

I would suggest we need to firstly fix this issue in
cs_etm__end_block() and cs_etm__flush() (maybe we need to consider to
consolidate the code with cs_etm__sample()).

>  	/*
>  	 * Record a branch when the last instruction in
> @@ -1851,8 +1867,11 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>  			 * been executed, but PC has not advanced to next
>  			 * instruction)
>  			 */
> +			/* Get address from prev_packet since we are synthesizing
> +			 * that in cs_etm__synth_instruction_sample()
> +			 */
>  			addr = cs_etm__instr_addr(etmq, trace_chan_id,
> -						  tidq->packet, offset - 1);
> +						  tidq->prev_packet, offset - 1);
>  			ret = cs_etm__synth_instruction_sample(
>  				etmq, tidq, addr,
>  				etm->instructions_sample_period);
> @@ -1916,7 +1935,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>  
>  	/* Handle start tracing packet */
>  	if (tidq->prev_packet->sample_type == CS_ETM_EMPTY)
> -		goto swap_packet;
> +		goto reset_last_br;
>  
>  	if (etmq->etm->synth_opts.last_branch &&
>  	    etmq->etm->synth_opts.instructions &&
> @@ -1952,8 +1971,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>  			return err;
>  	}
>  
> -swap_packet:
> -	cs_etm__packet_swap(etm, tidq);
> +reset_last_br:

As said, if we consolidate cs_etm__flush() for processing both
previous packet and current packet, then we don't need to remove
cs_etm__packet_swap() at here, right?

Thanks,
Leo

>  
>  	/* Reset last branches after flush the trace */
>  	if (etm->synth_opts.last_branch)
> -- 
> 2.43.0
> 
