From: Harald Servat <harald.servat@bsc.es>
Subject: Re: unable to get load latency info
Date: Fri, 28 Feb 2014 14:57:07 +0100
Message-ID: <531095B3.3070800@bsc.es>
References: <1393568679.86476.YahooMailNeo@web125402.mail.ne1.yahoo.com> <87bnxrcq0y.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:53017 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbaB1N5J (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Feb 2014 08:57:09 -0500
In-Reply-To: <87bnxrcq0y.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 28/02/14 14:42, Andi Kleen wrote:
> Muthusamy <muthu9283@yahoo.com> writes:
>> perf version 3.12.11
>> [root@rafa tmp]# ./perf stat -e r100b pwd  ### (I have tried with
>> other data intensive programs too)
>
> I don't think r100b is a valid event on Westmere. Not sure where you got
> that from. As others pointed out you need to use perf mem record/report
> with sampling (but note that it reports use-latency, not load-latency)
>
> -Andi
>

Andi,

   what do you mean by use-latency here? I understood that PEBS was able 
to report the number of core cycles that the load took to from some part 
of the memory hierarchy until it reached the CPU.

Thank you.

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
