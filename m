From: Adrien BAK <adrien.bak@metascale.org>
Subject: Re: recording rapl/power events
Date: Wed, 30 Apr 2014 11:08:29 +0900
Message-ID: <53605B1D.2070901@metascale.org>
References: <5354D05C.8080201@metascale.org>	<alpine.DEB.2.10.1404211004570.10033@vincent-weaver-1.um.maine.edu>	<5355D46A.4090209@metascale.org> <87ppk9brcb.fsf@tassilo.jf.intel.com> <8761lxrevj.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:42845 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753770AbaD3IHb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 30 Apr 2014 04:07:31 -0400
Received: from mail438.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 6BA0DFF9434
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2014 04:08:35 +0200 (CEST)
In-Reply-To: <8761lxrevj.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Andi Kleen <andi@firstfloor.org>
Cc: Vince Weaver <vincent.weaver@maine.edu>, linux-perf-users@vger.kernel.org

hi  Namhyung,

yes it seems. However, when I run what you suggest, I get the following :

perf record -a -e '{cycles,power/energy-pkg/}:S' sleep 1
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) 
for event (power/energy-pkg/).
/bin/dmesg may provide additional information.
No CONFIG_PERF_EVENTS=y kernel support configured?

Once again, I'm pretty sure my kernel is correctly configured, as I can 
get power measurement using perf stat. Is this a bug somewhere ? Can you 
confirm that this works for you and that I should investigate what can 
go wrong with my system ?

A.


On 25/04/2014 17:29, Namhyung Kim wrote:
> Hi Andi,
>
> On Tue, 22 Apr 2014 03:17:56 -0700, Andi Kleen wrote:
>> Adrien BAK <adrien.bak@metascale.org> writes:
>>> This looks promising, although I couldn't find any useful
>>> documentation on this. Do you know if the perf userland tool allows
>>> for this kind of slave-sampling or if I have to build my own tool
>>> around the perf_event API ?
>> perf record supports it (with :S), but none of the reporting tools
>> unfortunately.
> It seems it's what --group option of perf report is for?
>
>    $ perf record -e '{cycles,power/energy-pkg/}:S' -a sleep 1
>
>    $ perf report --group --stdio
>
>
> Thanks,
> Namhyung
>
>> However keep in mind that very rapid sampling of RAPL is not
>> likely to give useful results. The data only really makes
>> sense over longer intervals.
>>
>> -Andi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
