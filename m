From: Harald Servat <harald.servat@bsc.es>
Subject: Re: Changing frequency rate to perf mem
Date: Thu, 24 Oct 2013 09:48:09 +0200
Message-ID: <5268D0B9.50704@bsc.es>
References: <5267EE8E.3020306@bsc.es> <87ppqvs15r.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:58788 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753090Ab3JXHsO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 24 Oct 2013 03:48:14 -0400
In-Reply-To: <87ppqvs15r.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

On 24/10/13 07:12, Andi Kleen wrote:
> Harald Servat <harald.servat@bsc.es> writes:
>>
>>    BTW, I tried to change this value by adding "-F" and "200" into the
>> argv that is passed to cmd_report by adding
>>
>>          rec_argv[i++] = strdup("-F");
>>          rec_argv[i++] = strdup("200");
>>
>>    into line 42 of perf-mem.c - just after the
>> strdup("record").
>
> You would need to increase the array size too.

Ouch! You're right! I forgot that!

>
>> Unfortunately, this seems to break something and
>> perf segfaults often. Which is the most appropriate way to tune the
>> user frequency of perf mem?
>
> Best would be probably to fix it to pass through unknown
> options, then -F/-c could be just used. I'm not sure
> if this is possible easily with the git option parser.

Sorry, I'm not sure what is the "git option parser" here.
I think that this could be implemented extending the mem_options[] in 
file builtin-mem.c lines 205-221.

> Alternatively you can just specify the command line perf mem record
> would specify directly to perf record, plus -c/-F
>
> -andi
>

Thank you very much Andi.
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
