Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156219F;
	Wed, 14 Aug 2024 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723662116; cv=none; b=UllMxLIxAcp7M9fc+SETzFMsAGIZtEnJXUlXVNMJREpS5gTCeuF87jXJsOH9l90IEcjVPnh+OzSqfOj/c8hNafvlrwDaz3B4/QO9jRfJHW+Bw6Gf71jU+wWvN3UUlqtY1NkdOPCnc3CcpQABdIk4EMDlvj1FhosVwUUejEp/4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723662116; c=relaxed/simple;
	bh=rRGaH9XOiwfaCBuPZrUmXIVLuB+1Po3OcgoyhxZYTe8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mx6YqKXizSfzt6QoVANJeKFtACulRAIJAIChNXq2i7e/AitO4gBnNxiOaRoktB+U2Jgjfc3RQeVGkWPnsQFLz7k0xdvVCEY08KMk1kvXOnfhBKrAYxTJnMZaLhBZvvcwKYrfJASc/dSQ7ldtvZpUgGiBLrTLdS3+lgAuBQr84Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P0NZ3jC4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O8Dv4svJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P0NZ3jC4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O8Dv4svJ"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723662111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZUM0kRkhOnsvfziE1o6NjLdv+hbk3i1hQxzq2oKECk=;
	b=P0NZ3jC4K4dWEShKNDk54DWiJP4zi+MARlnd/Yg2QprI7VqAa6sYqtnPLYrKMTyetmhSuR
	uYqwRmZDoUpqA8505Al6d/Ipvi6ahFjiw0yc+1E7dSty/OUm1TNY33lx3G2dxoTNTwjCNf
	iKBMKyjjrkbiNF1Ahxh13DkPQG5OElb5Lxyl0FNvTxFf4lc7vBLwuoL5z9FQnlZZstoAPe
	mikFjtG/yaJmrOI/1ygbsAIbeIMGcVixzWpXeIygeniVFff+VrjWicJC5VJATWTglQkfVi
	X0Xp+9YE0Anxcl9J00irr4o/xcnDUYogF/BvZKWeACJAHLvBK2Nh5gbYYd/y1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723662111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZUM0kRkhOnsvfziE1o6NjLdv+hbk3i1hQxzq2oKECk=;
	b=O8Dv4svJTeFSZcLbZjXJJ9mQFBRUi38umoIH9CWd+booS/4tmyUSU2bGiwvNhoo8NBBVmX
	knRxiECH1pAEiUBw==
To: "Liang, Kan" <kan.liang@linux.intel.com>, Li Huafei
 <lihuafei1@huawei.com>, peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Restrict period on Haswell
In-Reply-To: <a42a3e35-2166-4539-930b-21ea0921e8d8@linux.intel.com>
References: <87sev7nom4.ffs@tglx>
 <a42a3e35-2166-4539-930b-21ea0921e8d8@linux.intel.com>
Date: Wed, 14 Aug 2024 21:01:51 +0200
Message-ID: <87frr7nd28.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 14 2024 at 14:15, Kan Liang wrote:
> On 2024-08-14 10:52 a.m., Thomas Gleixner wrote:
>> Now looking at the HSW specification update specifically erratum HSW11:
>> 
>>   Performance Monitor Precise Instruction Retired Event May Present
>>   Wrong Indications
>> 
>>   Problem:
>>          When the Precise Distribution for Instructions Retired (PDIR)
>>          mechanism is activated (INST_RETIRED.ALL (event C0H, umask
>>          value 00H) on Counter 1 programmed in PEBS mode), the processor
>>          may return wrong PEBS or Performance Monitoring Interrupt (PMI)
>>          interrupts and/or incorrect counter values if the counter is
>>          reset with a Sample- After-Value (SAV) below 100 (the SAV is
>>          the counter reset value software programs in the MSR
>>          IA32_PMC1[47:0] in order to control interrupt frequency).
>> 
>>   Implication:
>>          Due to this erratum, when using low SAV values, the program may
>>          get incorrect PEBS or PMI interrupts and/or an invalid counter
>>          state.
>> 
>>   Workaround:
>>          The sampling driver should avoid using SAV<100.
>> 
>> IOW, that's exactly the same issue as the BDM11 erratum.
>> 
>> Kan: Can you please go through the various specification updates and
>> identify which generations are affected by this and fix it once and
>> forever in a sane way instead of relying on 'tried until it works by
>> some definition of works' hacks. These errata are there for a reason.
>
> Sure. I will check all the related erratum and propose a fix.
>
>> But that does not explain the fallout with that cve test because that
>> does not use PEBS. It's using fixed counter 0.
>
> The errata also mentions about the PMI interrupts, which may imply
> non-PEBS case. I will double check with the architect.

Ah. Indeed.

> According to the description of the patch, if I understand correctly, it
> runs 100 CVE-2015-3290 tests at the same time. If so, all the GP
> counters are used. Huafei, could you please confirm?

I can reproduce that way on my quad socket HSW almost instantaneously:

[10473.376928] CPU#16: ctrl:       0000000000000000
[10473.376930] CPU#16: status:     0000000000000000
[10473.376931] CPU#16: overflow:   0000000000000000
[10473.376932] CPU#16: fixed:      00000000000000bb
[10473.376933] CPU#16: pebs:       0000000000000000
[10473.376934] CPU#16: debugctl:   0000000000004000
[10473.376935] CPU#16: active:     0000000300000000
[10473.376937] CPU#16:   gen-PMC0 ctrl:  0000000000134f2e
[10473.376938] CPU#16:   gen-PMC0 count: 0000ffffffffffca
[10473.376940] CPU#16:   gen-PMC0 left:  000000000000003b
[10473.376941] CPU#16:   gen-PMC1 ctrl:  0000000000000000
[10473.376943] CPU#16:   gen-PMC1 count: 0000000000000000
[10473.376944] CPU#16:   gen-PMC1 left:  0000000000000000
[10473.376946] CPU#16:   gen-PMC2 ctrl:  0000000000000000
[10473.376947] CPU#16:   gen-PMC2 count: 0000000000000000
[10473.376948] CPU#16:   gen-PMC2 left:  0000000000000000
[10473.376949] CPU#16:   gen-PMC3 ctrl:  0000000000000000
[10473.376950] CPU#16:   gen-PMC3 count: 0000000000000000
[10473.376952] CPU#16:   gen-PMC3 left:  0000000000000000
[10473.376953] CPU#16: fixed-PMC0 count: 0000fffffffffffe
[10473.376954] CPU#16: fixed-PMC1 count: 0000fffbabf57908
[10473.376955] CPU#16: fixed-PMC2 count: 0000000000000000

[10473.376928] CPU#88: ctrl:       0000000000000000
[10473.376930] CPU#88: status:     0000000000000000
[10473.376931] CPU#88: overflow:   0000000000000000
[10473.376932] CPU#88: fixed:      00000000000000bb
[10473.376933] CPU#88: pebs:       0000000000000000
[10473.376934] CPU#88: debugctl:   0000000000004000
[10473.376935] CPU#88: active:     0000000300000000
[10473.376937] CPU#88:   gen-PMC0 ctrl:  0000000000134f2e
[10473.376939] CPU#88:   gen-PMC0 count: 0000fffffffffff2
[10473.376940] CPU#88:   gen-PMC0 left:  00000000000000a8
[10473.376942] CPU#88:   gen-PMC1 ctrl:  0000000000000000
[10473.376944] CPU#88:   gen-PMC1 count: 0000000000000000
[10473.376945] CPU#88:   gen-PMC1 left:  0000000000000000
[10473.376946] CPU#88:   gen-PMC2 ctrl:  0000000000000000
[10473.376947] CPU#88:   gen-PMC2 count: 0000000000000000
[10473.376949] CPU#88:   gen-PMC2 left:  0000000000000000
[10473.376950] CPU#88:   gen-PMC3 ctrl:  0000000000000000
[10473.376951] CPU#88:   gen-PMC3 count: 0000000000000000
[10473.376952] CPU#88:   gen-PMC3 left:  0000000000000000
[10473.376953] CPU#88: fixed-PMC0 count: 0000fffffffffffe
[10473.376955] CPU#88: fixed-PMC1 count: 0000fffa79a83958
[10473.376956] CPU#88: fixed-PMC2 count: 0000000000000000

This happens at the very same time and CPU#88 is the HT sibling of
CPU#16

Thanks,

        tglx
