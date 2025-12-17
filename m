Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F532459F7;
	Wed, 17 Dec 2025 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765957976; cv=none; b=sSR9eb148RJJsEt2kQoR7yVmmpY8xkWU1k/GMST/7R0I+F2kTNHYY3FV+WvWtPfuQFrRvL8ILUiPosRpF/B3pBqznDcDEpwfOAjrUDbZFGX7VwpfqYZPEJKpJOB9Aj6Z7u4bKcuvWb7HWUeWoTFYxy7+geYIjIabTMH9rCUcJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765957976; c=relaxed/simple;
	bh=pekZVnAsA5VLHIam1lnUI9MsgkBX0Fb2JtCLMhnAPlI=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=kJAOpigNNBDvbNsZJqZpvKp8cB+xh+BKswdVy8IPs2Ahv0crsFUjYvfYo+AKmHRCRko9XFvwRJZESrVlgeY8WJAVJikUrylt+V0BYSCHyiMRBPlsWHWjzKIOZKW9LosIkMRc/kwo4SpiyTHS81D8IzCI+X8GVSYmcedQsoBsV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=wTU+TRfy; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="wTU+TRfy"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=24608ce8ee=ms@dev.tdt.de>)
	id 1vVm2f-007HV7-QK; Wed, 17 Dec 2025 08:33:49 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1vVm2e-007eB8-KE; Wed, 17 Dec 2025 08:33:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1765956828;
	bh=aHb4W3m5qftbxBwVYzQvmGWN81Vpo3GPVghGUuhsYWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wTU+TRfyGA29SPT9bhBtqAlu+Fz5/vqQIqiSz68QeweADbGnKH7ekBd+2yTtqAE54
	 uqVg6wyt3Zug3wfqIb8YOL3tiO73AcrxdkclMWG1q+5xcYMYrgPI1JaBT7WYqKuOaN
	 SYH6mwmwPHL7N8P0PBieFcnqXgMJ+mwB4diLo1t4kVzd+jlTqUJ+U47qc2hMFWyk66
	 cgGq62aec085dDPWuhOwwSB/W9036TfUOp+iPuchmO3ZWSMR4OBbaWX5jdXruEZRiF
	 uqW128aZHqwM7bi11oECNv4e3L7vkrn8jOczEp3QDg0QOXlXTtrjMryY1wH+vWwVNR
	 /kZWVUqW9LShA==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 1F3E0240042;
	Wed, 17 Dec 2025 08:33:48 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 09123240040;
	Wed, 17 Dec 2025 08:33:48 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id B1E4F20589;
	Wed, 17 Dec 2025 08:33:47 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 17 Dec 2025 08:33:47 +0100
From: Martin Schiller <ms@dev.tdt.de>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: tony.luck@intel.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, fe@dev.tdt.de
Subject: Re: [PATCH 0/3] perf/x86: Add Airmont NP
Organization: TDT AG
In-Reply-To: <e224b118-6595-4f03-8aad-862e47fde5fa@linux.intel.com>
References: <20251124074846.9653-1-ms@dev.tdt.de>
 <e224b118-6595-4f03-8aad-862e47fde5fa@linux.intel.com>
Message-ID: <eaaa8b65c7ad8570c4d55eb4162a9d5d@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1765956829-B9E76CC1-6D7BB595/0/0
X-purgate: clean
X-purgate-type: clean

On 2025-11-25 08:44, Mi, Dapeng wrote:
> On 11/24/2025 3:48 PM, Martin Schiller wrote:
>> From the perspective of Intel cstate, PMU and MSR the Airmont NP
>> (aka Lightning Mountain) is identical to Airmont.
>> 
>> This changes are taken from patched kernel sources of the MaxLinear 
>> SDK
>> which can be found at https://github.com/maxlinear/linux
>> 
>> Martin Schiller (3):
>>   perf/x86/msr: Add Airmont NP
>>   perf/x86/intel: Add Airmont NP
>>   perf/x86/cstate: Add Airmont NP
>> 
>>  arch/x86/events/intel/core.c   | 1 +
>>  arch/x86/events/intel/cstate.c | 1 +
>>  arch/x86/events/msr.c          | 1 +
>>  3 files changed, 3 insertions(+)
> 
> The whole patch-set looks good to me.
> 
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thanks for your review.

Is there anything left I need to do to ensure that these changes get
merged?

Regards,
Martin
