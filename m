From: Harald Servat <harald.servat@bsc.es>
Subject: Re: Sample memory references with at least a given latency?
Date: Wed, 18 Feb 2015 10:31:11 +0100
Message-ID: <54E45BDF.1060803@bsc.es>
References: <54D21524.8010305@bsc.es> <CALbiyZw=SqhFLtzse53SW_B-JMo-+AxPGDAE9C_aBmo4X88mrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:48043 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbbBRJbQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Feb 2015 04:31:16 -0500
In-Reply-To: <CALbiyZw=SqhFLtzse53SW_B-JMo-+AxPGDAE9C_aBmo4X88mrA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hello Manuel, et al,

   I've been digging a bit into the example code you mention below. It 
look like lines 246-271 setup the PEBS infrastructure given through perf.

   I notice, and correct if I'm wrong, that you don't setup any 
interrupt service, so you expect that the buffer for the PEBS entries is 
sufficiently large for the application run. Do you know how to program 
an interrupt service if the buffer cannot hold all the PEBS entries? And 
is that possible from user-space?

Best regards and thank you.

On 04/02/15 14:06, Manuel Selva wrote:
> Yes you can. I wrote a small "memory not" for how to do this while
> trying to enable memory sampling:
>
> https://manuelselva.wordpress.com/2013/10/31/how-to-use-the-linux-perf_event_open-system-call/
>
> I also wrote some code exampl here:
> https://github.com/ManuelSelva/c4fun/tree/master/pebs_tests
>
> 2015-02-04 13:48 GMT+01:00 Harald Servat <harald.servat@bsc.es
> <mailto:harald.servat@bsc.es>>:
>
>     Hello list,
>
>        is there any way to configure perf to sample memory references
>     through PEBS and enable the Load Latency Performance Monitoring
>     Facility (section 18.7.1.2 from the Intel 64 and IA-32 Architectures
>     Software Developer's Manual).
>
>     Thank you very much in advance.
>
>     WARNING / LEGAL TEXT: This message is intended only for the use of the
>     individual or entity to which it is addressed and may contain
>     information which is privileged, confidential, proprietary, or exempt
>     from disclosure under applicable law. If you are not the intended
>     recipient or the person responsible for delivering the message to the
>     intended recipient, you are strictly prohibited from disclosing,
>     distributing, copying, or in any way using this message. If you have
>     received this communication in error, please notify the sender and
>     destroy and delete any copies you may have received.
>
>     http://www.bsc.es/disclaimer
>     --
>     To unsubscribe from this list: send the line "unsubscribe
>     linux-perf-users" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at http://vger.kernel.org/__majordomo-info.html
>     <http://vger.kernel.org/majordomo-info.html>
>
>


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
