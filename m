From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: recording rapl/power events
Date: Fri, 25 Apr 2014 17:29:36 +0900
Message-ID: <8761lxrevj.fsf@sejong.aot.lge.com>
References: <5354D05C.8080201@metascale.org>
	<alpine.DEB.2.10.1404211004570.10033@vincent-weaver-1.um.maine.edu>
	<5355D46A.4090209@metascale.org> <87ppk9brcb.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lgeamrelo01.lge.com ([156.147.1.125]:37559 "EHLO
	lgeamrelo01.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaDYI3k (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 25 Apr 2014 04:29:40 -0400
In-Reply-To: <87ppk9brcb.fsf@tassilo.jf.intel.com> (Andi Kleen's message of
	"Tue, 22 Apr 2014 03:17:56 -0700")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Adrien BAK <adrien.bak@metascale.org>, Vince Weaver <vincent.weaver@maine.edu>, linux-perf-users@vger.kernel.org

Hi Andi,

On Tue, 22 Apr 2014 03:17:56 -0700, Andi Kleen wrote:
> Adrien BAK <adrien.bak@metascale.org> writes:
>>
>> This looks promising, although I couldn't find any useful
>> documentation on this. Do you know if the perf userland tool allows
>> for this kind of slave-sampling or if I have to build my own tool
>> around the perf_event API ?
>
> perf record supports it (with :S), but none of the reporting tools
> unfortunately.

It seems it's what --group option of perf report is for?

  $ perf record -e '{cycles,power/energy-pkg/}:S' -a sleep 1

  $ perf report --group --stdio


Thanks,
Namhyung

>
> However keep in mind that very rapid sampling of RAPL is not
> likely to give useful results. The data only really makes
> sense over longer intervals.
>
> -Andi
