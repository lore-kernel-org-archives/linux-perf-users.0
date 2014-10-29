From: Manuel Selva <manuel.selva@insa-lyon.fr>
Subject: Re: Load latency sampling on Sandy Bridge
Date: Wed, 29 Oct 2014 21:15:30 +0100
Message-ID: <54514AE2.9010702@insa-lyon.fr>
References: <5450A049.3040803@insa-lyon.fr> <alpine.DEB.2.11.1410291207160.21291@vincent-weaver-1.umelst.maine.edu> <90E64847-211C-4331-82D1-763FC17C03CE@insa-lyon.fr> <alpine.DEB.2.11.1410291452280.895@vincent-weaver-1.umelst.maine.edu> <545136EF.9030503@insa-lyon.fr> <alpine.DEB.2.11.1410291509160.895@vincent-weaver-1.umelst.maine.edu> <54513E55.9060503@insa-lyon.fr> <alpine.DEB.2.11.1410291601080.895@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.insa-lyon.fr ([134.214.182.244]:42931 "EHLO
	smtp.insa-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465AbaJ2UPm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Oct 2014 16:15:42 -0400
In-Reply-To: <alpine.DEB.2.11.1410291601080.895@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

many thanks, it works !!!

On ubuntu: sudo apt-get install intel-microcode

-----
Manu

On 10/29/2014 09:02 PM, Vince Weaver wrote:
> On Wed, 29 Oct 2014, Manuel Selva wrote:
>
>> perf_event_intel: PEBS disabled due to CPU errata, please upgrade microcode
>>
>> Does it mean that I must "upgrade my hardware" through the upgrade of
>> microcode ? I never did such a thing.
>
> Usually the microcode is updated at boot time.  Usually your distribution
> will have some sort of microcode update package you can install that will
> do this for you automatically.
>
> Vince
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
