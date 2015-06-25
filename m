From: Harald Servat <harald.servat@bsc.es>
Subject: Re: About using PEBS from the user space
Date: Thu, 25 Jun 2015 18:00:46 +0200
Message-ID: <558C25AE.9040601@bsc.es>
References: <55469B90.1090903@bsc.es> <alpine.DEB.2.11.1505031816450.4940@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:38474 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579AbbFYQG1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 25 Jun 2015 12:06:27 -0400
In-Reply-To: <alpine.DEB.2.11.1505031816450.4940@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 04/05/15 00:19, Vince Weaver wrote:
> On Mon, 4 May 2015, Harald Servat wrote:
>
>> Dear list,
>>
>>    I'd like to use the perf library to access PEBS so as to collect referenced
>> memory addresses from the user space. I think I've successfully setup the perf
>> structures (struct perf_event_attr) to configure the performance counters, but
>> I don't see what should I do to access to the captured memory addresses. I've
>> seen that within arch/x86/kernel/cpu/perf_event_intel_ds.c there are the
>> routines alloc_pebs_buffer, alloc_ds_buffer which seems to allocate and setup
>> the necessary buffers using kmalloc_node calls. Question is, how can replicate
>> this from the user space? And how we should connect these buffers to the PEBS
>> infrastructure using perf calls?
>
> You can try looking at the example code in my perf_event_tests code.
> 	https://github.com/deater/perf_event_tests
>
> The stuff you are looking for is probably covered in the
> 	test/record_sample/samples_data_src
> 	test/record_sample/sample_weight
> and especially the
> 	test/record_sample/sample_regs_intr
> tests, although that last one requires a fairly recent kernel to work.
>
> Vince

Hello,

   is there a way to setup PEBS to collect information from loads that 
take at least X cycles to complete using MSR_PEBS_LD_LAT_THRESHOLD 
through this approach?

Thank you!

WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.

http://www.bsc.es/disclaimer
