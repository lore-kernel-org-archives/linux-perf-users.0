From: Harald Servat <harald.servat@bsc.es>
Subject: Re: Information regarding the perf tool
Date: Thu, 31 Oct 2013 16:45:16 +0100
Message-ID: <52727B0C.5040402@bsc.es>
References: <5266A57F.2000201@bsc.es> <87y55krw6f.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:55419 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab3JaPpV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 31 Oct 2013 11:45:21 -0400
In-Reply-To: <87y55krw6f.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

On 23/10/13 14:47, Andi Kleen wrote:
> Harald Servat <harald.servat@bsc.es> writes:
>
>> Dear list,
>>
>>     I'm wondering whether it be possible to extend the "perf mem"
>> (tool) to emit the TSC of the sampling event?
>
> perf report -D reports everything, including time stamps.
>
> -Andi
>

Hello,

   returning to this topic, I'd like to mention that the time-stamps 
associated with the data samples seems to be a bit delayed from the 
actual computation.

   I tried to look at how are timestamps set in the perf samples and I 
took a look at

   arch/x86/kernel/cpu/perf_event_intel_ds.c

   and also at Intel Architectures Software Developer Manual [1].

   The first thing I notice is that pebs_record_core structure seems to 
be the same as the record of PEBS as indicated in Figure 17-10 of [1] 
(page 105), while pebs_record_nhm seems to be the record as indicated in 
Table 18-12 of [1] (page 147), but  neither Table 18-12 nor Figure 17-10 
provide the time when the record was generated, so the timestamp in the 
perf sample is generated elsewhere.

   In fact, I expected that for each entry into the PEBS a handler would 
be executed, but Intel documentations points that to use PEBS the tool 
(here perf) needs to allocate space for multiple PEBS entries, so the 
when the handler is invoked there may be multiple entries in the buffer, 
which makes things a little more obscure.

   Can anyone point me where and how is the timestamp calculated for 
every sample reported by perf?

Thank you very much.

[1] http://download.intel.com/products/processor/manual/253669.pdf

-- 


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
