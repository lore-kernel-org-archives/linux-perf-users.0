From: Manuel Selva <manuel.selva@insa-lyon.fr>
Subject: Re: Load latency sampling on Sandy Bridge
Date: Wed, 29 Oct 2014 19:50:23 +0100
Message-ID: <545136EF.9030503@insa-lyon.fr>
References: <5450A049.3040803@insa-lyon.fr> <alpine.DEB.2.11.1410291207160.21291@vincent-weaver-1.umelst.maine.edu> <90E64847-211C-4331-82D1-763FC17C03CE@insa-lyon.fr> <alpine.DEB.2.11.1410291452280.895@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp.insa-lyon.fr ([134.214.182.244]:41816 "EHLO
	smtp.insa-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbaJ2Suk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Oct 2014 14:50:40 -0400
In-Reply-To: <alpine.DEB.2.11.1410291452280.895@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Yes, perf mem doesn't work on my Sandy Bridge. I should be missing 
something, maybe a kernel parameter somewhere, or something like that, 
but I don't know where searching ...

Manu

On 10/29/2014 07:53 PM, Vince Weaver wrote:
> On Wed, 29 Oct 2014, Manuel Selva wrote:
>
>> The same event as the one you mentionned (I also checked that it's the
>> same event than the one used by perf mem record)
>
> so perf mem record doesn't work for you either?
>
> I checked on my sandybridge-ep machine running Linux 3.14 and latency
> measurement seems to be working fine there too.
>
> Vince
>
