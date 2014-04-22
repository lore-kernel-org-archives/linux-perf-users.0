From: Adrien BAK <adrien.bak@metascale.org>
Subject: Re: recording rapl/power events
Date: Tue, 22 Apr 2014 11:31:06 +0900
Message-ID: <5355D46A.4090209@metascale.org>
References: <5354D05C.8080201@metascale.org> <alpine.DEB.2.10.1404211004570.10033@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:35486 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751361AbaDVDsR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Apr 2014 23:48:17 -0400
Received: from mail402.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 50479FF8C1D
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Apr 2014 04:31:10 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.10.1404211004570.10033@vincent-weaver-1.um.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org


On 21/04/2014 23:07, Vince Weaver wrote:
> On Mon, 21 Apr 2014, Adrien BAK wrote:
>
>> However, it seems that I can't record a sequence of power events :
>>
>> perf record -a -e power/energy-pkg/ sleep 1
>> Error:
>> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
>> event (power/energy-pkg/).
>> /bin/dmesg may provide additional information.
>> No CONFIG_PERF_EVENTS=y kernel support configured?
> RAPL events cannot generate interrupts, so I don't think you can sample
> like this.
>
> You can possibly sample using some other event (like one of the software
> clock events) and include the RAPL event in the list of events to record,
> not sure if that will accomplish what you're trying to do.
>
> Vince

This looks promising, although I couldn't find any useful documentation 
on this. Do you know if the perf userland tool allows for this kind of 
slave-sampling or if I have to build my own tool around the perf_event API ?
