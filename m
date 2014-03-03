From: Harald Servat <harald.servat@bsc.es>
Subject: Re: unable to get load latency info
Date: Mon, 03 Mar 2014 15:24:44 +0100
Message-ID: <531490AC.70605@bsc.es>
References: <1393568679.86476.YahooMailNeo@web125402.mail.ne1.yahoo.com> <87bnxrcq0y.fsf@tassilo.jf.intel.com> <531095B3.3070800@bsc.es> <20140228164510.GU22728@two.firstfloor.org> <1393823578.5408.YahooMailNeo@web125402.mail.ne1.yahoo.com> <5314343E.803@bsc.es> <1393851732.26401.YahooMailNeo@web125404.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:55385 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754359AbaCCOYp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Mar 2014 09:24:45 -0500
In-Reply-To: <1393851732.26401.YahooMailNeo@web125404.mail.ne1.yahoo.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Muthusamy <muthu9283@yahoo.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 03/03/14 14:02, Muthusamy wrote:
>> On Monday, March 3, 2014 1:20 PM, Harald Servat <harald.servat@bsc.es> wrote:
>>    so I imagine that you're ok with respect to OS.
>>      Besides of that, the Intel Manual [1] says in section 18.7.1.1 that
>> Nehalem (and I'd would guess Westmere, as it is a Nehalem successor)
>> supports PEBS, so it should work.
>
>
> So, what am I missing. Is there something the kernel needs to be enabled for PEBS. If yes, how do I know if it is enabled.
>
> Regards,
> Muthusamy C
>

I notice that you provide on an earlier output a uname -a showed 
2.6.32-xxxx but perf --version showed version 3.12.11, and they don't 
match but should. Are you running on 2.6.x or on 3.12.x?

Regards


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
