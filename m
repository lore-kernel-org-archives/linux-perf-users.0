Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CD72EAF7;
	Tue,  1 Apr 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743527055; cv=none; b=tpzjcX6ULNwo0EfiCJzxB0Ux1WX1fwS4h2lViLYOf35zo9VZ5PjuaM5sk/nlZ4wX9yOg/8ztC5YKyaRDtO6rQml+TWoFXb21RsqdY0o9Ym7EUZ4Z56walG93Vxcsk2Dyu2ic/0VK99V/OBogZvjMA8vgFddzBLV3Zg4jGBkuI4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743527055; c=relaxed/simple;
	bh=QZkI/9nN8Pt2povYASNmI98sveqSrFcfVuZCi04/YzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLsF1FwL4uLPB1yPAM7nnmNMAo/vI2srggRCzD5jtD7JZrLfhTR5lviK17BZIDq2y4WdvDoqWasXdlTopHSy6DMMBaX511ggyEIRsvtATGYRKbU8nkavPb9F3MnEGdVuDHH51c/XuHS+85qyKjYVqctECt9z4E14Brb30qgsMUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MoXjQ7PP; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MoXjQ7PP"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531A4Xqa025275;
	Tue, 1 Apr 2025 09:59:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
	15Qz97sCZyxPGijF6bG8eZXzNEdvC6VQVKLILEpSFI=; b=MoXjQ7PP9I1YKS4z3
	E7qlN+ghXTh6+7nVN9KRHcWIXh1SuHCDfPja9LvSvca76KRNH84A3ehRXFkHywDC
	8cvpOJuQ85lLbRSrKOzYgYip9p9fhzRZjdqmKd4gTL8Vd4jyVBiSYt7BkiUNHOiL
	Lo/lk6AwLQ6FPd+Fq2yUZ1VZ46W+Ed8M7plZJGrQXyzUJsljwecaEkn6VAl8+gPz
	VOiSQM1szi1ePWR/s0sjKeluTC7clVpC62NREL/yHLvEyPX+CZ+SbLfciXiKXw4Q
	4AtJ5IGxrF5m5jIs01MCMgHCAbDKJ8AEVEZTaFhCdD5xsnnxK8M1T9A8QZlT4YvC
	4LCzw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45re27106d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 09:59:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Apr 2025 09:59:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Apr 2025 09:59:06 -0700
Received: from BG-LT92791.marvell.com (BG-LT92791.marvell.com [10.28.160.93])
	by maili.marvell.com (Postfix) with ESMTP id 823E25C68EB;
	Tue,  1 Apr 2025 09:59:01 -0700 (PDT)
From: Tanmay Jagdale <tanmay@marvell.com>
To: <leo.yan@arm.com>, Tanmay Jagdale <tanmay@marvell.com>
CC: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@linaro.org>, <john.g.garry@oracle.com>,
        <leo.yan@linux.dev>, <will@kernel.org>, <acme@kernel.org>,
        <adrian.hunter@intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>
Subject: Re: [PATCH V3 1/2] perf: cs-etm: Fixes in instruction sample synthesis
Date: Tue, 1 Apr 2025 22:28:45 +0530
Message-ID: <20250327153530.GF604566@e132581.arm.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250327111149.461012-2-tanmay@marvell.com>
References: <20250327111149.461012-1-tanmay@marvell.com> <20250327111149.461012-2-tanmay@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=crybk04i c=1 sm=1 tr=0 ts=67ec1b5a cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=XR8D0OoHHMoA:10 a=7CQSdrXTAAAA:8 a=M5GUcnROAAAA:8 a=Z4zB58jBWo-q_rlER6QA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: o7gZDp58OvZQYShkfzDARx0NziC33BKb
X-Proofpoint-ORIG-GUID: o7gZDp58OvZQYShkfzDARx0NziC33BKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_06,2025-04-01_01,2024-11-22_01
Message-ID: <20250401165845.FSFZOeApFpD3i5d47cIieM2-5QRNtNSGk5FIJMUC7Y8@z>

From: Leo Yan <leo.yan@arm.com>

Hi Leo,

I was on vacation so could not get back earlier.
> 
> > Hi Tanmay,
> > 
> > On Thu, Mar 27, 2025 at 04:41:48PM +0530, Tanmay Jagdale wrote:
>>> The existing method to synthesize instruction samples has the
>>> following issues:
>>> 1. Branch instruction mnemonics were being added to non-branch
>>>    instructions too.
>>> 2. Branch target address was missing
>>> 
>>> To fix the issues, start synthesizing the instructions from the
>>> previous packet (tidq->prev_packet) instead of current packet
>>> (tidq->packet). This way it's easy to figure out the target
>>> address of the branch instruction in tidq->prev_packet which
>>> is the current packet's (tidq->packet) first executed instruction.
>>> 
>>> Since we have now switched to processing the previous packet
>>> first, we need not swap the packets during cs_etm__flush().
>>> 
>>> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
>>> Reviewed-by: James Clark <james.clark@arm.com>
>>
>> I saw James's reviewed tag.  However, I have several comments.
>> 
>> Sorry I jumped in too late.
No problem, thanks for the review.

> 
>>> ---
>>>  tools/perf/util/cs-etm.c | 32 +++++++++++++++++++++++++-------
>>>  1 file changed, 25 insertions(+), 7 deletions(-)
>>> 
>>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>>> index 0bf9e5c27b59..ebed5b98860e 100644
>>> --- a/tools/perf/util/cs-etm.c
>>> +++ b/tools/perf/util/cs-etm.c
>>> @@ -1576,10 +1576,26 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
> 
> Seems to me, the problem is cs_etm__synth_instruction_sample() is
> invoked from multiple callers.
> 
> Both the previous packet and packet are valid fo the flow:
>   cs_etm__sample()
>     `> cs_etm__synth_instruction_sample()
> 
> Only the previous packet is valid and the current packet stores stale
> data for the flows:
> 
>   cs_etm__flush()
>     `> cs_etm__synth_instruction_sample()
> 
>  cs_etm__end_block()
>    `> cs_etm__synth_instruction_sample()
> 
> First, as a prerequisite, I think we should resolve the stale data in
> the packet.  So we need a fix like:
Agree.

> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c                
> index 0bf9e5c27b59..b7b17c0e4806 100644                                         
> --- a/tools/perf/util/cs-etm.c                                                  
> +++ b/tools/perf/util/cs-etm.c                                                  
> @@ -741,6 +741,9 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>                                                                                 
>         if (etm->synth_opts.branches || etm->synth_opts.last_branch ||          
>             etm->synth_opts.instructions) {                                     
> +               /* The previous packet will not be used, cleanup it */          
> +               memset(tidq->prev_packet, 0x0, sizeof(*tidq->packet));          
> +                                                                               
>                 /*                                                              
>                  * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for 
>                  * the next incoming packet.                                    
> 
Thanks for pointing out, I'll include this fix.

>>>  	sample.stream_id = etmq->etm->instructions_id;
>>>  	sample.period = period;
>>>  	sample.cpu = tidq->packet->cpu;
> 
> Should we use "prev_packet->cpu" at here?
> 
> Even for a branch instruction, as its IP address is from the previous
> packet, we should use "prev_packet->cpu" for CPU ID as well.
ACK.

> 
>>> -	sample.flags = tidq->prev_packet->flags;
>>>  	sample.cpumode = event->sample.header.misc;
>>>  
>>> -	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
>>> +	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->prev_packet, &sample);
>>> +
>>> +	/* Populate branch target information only when we encounter
>>> +	 * branch instruction, which is at the end of tidq->prev_packet.
>>> +	 */
>>> +	if (addr == (tidq->prev_packet->end_addr - 4)) {
> 
>   if (!addr && addr == cs_etm__last_executed_instr(tidq->prev_packet))
> 
>>> +		/* Update the perf_sample flags using the prev_packet
>>> +		 * since that is the queue we are synthesizing.
>>> +		 */
>>> +		sample.flags = tidq->prev_packet->flags;
>>> +
>>> +		/* The last instruction of the previous queue would be a
>>> +		 * branch operation. Get the target of that branch by looking
>>> +		 * into the first executed instruction of the current packet
>>> +		 * queue.
>>> +		 */
>>> +		sample.addr = cs_etm__first_executed_instr(tidq->packet);
> 
> If connected to the change suggested for cleaning up packet in
> cs_etm__packet_swap(), when run at here, if "tidq->packet" is a valid
> packet, then it will return a branch target address, otherwise, it
> will return 0.
> 
>>> +	}
>>>  
>>>  	if (etm->synth_opts.last_branch)
>>>  		sample.branch_stack = tidq->last_branch;
>>> @@ -1771,7 +1787,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>>>  	/* Get instructions remainder from previous packet */
>>>  	instrs_prev = tidq->period_instructions;
>>>  
>>> -	tidq->period_instructions += tidq->packet->instr_count;
>>> +	tidq->period_instructions += tidq->prev_packet->instr_count;
> 
> A side effect for this change is we will defer to synthesize instruction
> samples for _current_ packet, either the packet will be handled after
> a new packet incoming, or at the end of a trace chunk.
> 
> The problem is for the later one, we can see cs_etm__end_block() and
> cs_etm__flush() both only handle the previous packet. As a result, the
> last packet will be ignored.
Yes I agree, this is a side effect of the patch. The last packet's instructions
are not handled.

> 
> I would suggest we need to firstly fix this issue in
> cs_etm__end_block() and cs_etm__flush() (maybe we need to consider to
> consolidate the code with cs_etm__sample()).
Okay sure. I will take a look at consolidating the code and post them in
the next version.

> 
>>>  	/*
>>>  	 * Record a branch when the last instruction in
>>> @@ -1851,8 +1867,11 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>>>  			 * been executed, but PC has not advanced to next
>>>  			 * instruction)
>>>  			 */
>>> +			/* Get address from prev_packet since we are synthesizing
>>> +			 * that in cs_etm__synth_instruction_sample()
>>> +			 */
>>>  			addr = cs_etm__instr_addr(etmq, trace_chan_id,
>>> -						  tidq->packet, offset - 1);
>>> +						  tidq->prev_packet, offset - 1);
>>>  			ret = cs_etm__synth_instruction_sample(
>>>  				etmq, tidq, addr,
>>>  				etm->instructions_sample_period);
>>> @@ -1916,7 +1935,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>>>  
>>>  	/* Handle start tracing packet */
>>>  	if (tidq->prev_packet->sample_type == CS_ETM_EMPTY)
>>> -		goto swap_packet;
>>> +		goto reset_last_br;
>>>  
>>>  	if (etmq->etm->synth_opts.last_branch &&
>>>  	    etmq->etm->synth_opts.instructions &&
>>> @@ -1952,8 +1971,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>>>  			return err;
>>>  	}
>>>  
>>> -swap_packet:
>>> -	cs_etm__packet_swap(etm, tidq);
>>> +reset_last_br:
> 
> As said, if we consolidate cs_etm__flush() for processing both
> previous packet and current packet, then we don't need to remove
> cs_etm__packet_swap() at here, right?
Yes I think so too.

Thanks,
Tanmay
> 
> Thanks,
> Leo
> 
