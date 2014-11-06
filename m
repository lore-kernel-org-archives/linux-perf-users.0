From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Perf mem report Data Object
Date: Thu, 06 Nov 2014 15:06:01 +0100
Message-ID: <545B8049.4050207@gmail.com>
References: <CALbiyZzdM84Cy+sodbuxPxT1jRZs4W94-N0KCjyaw3K89Edh3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:65442 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbaKFOGH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 6 Nov 2014 09:06:07 -0500
Received: by mail-wg0-f53.google.com with SMTP id b13so1274489wgh.12
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2014 06:06:04 -0800 (PST)
Received: from [134.214.61.216] (anyconnect216.insa-lyon.fr. [134.214.61.216])
        by mx.google.com with ESMTPSA id hu3sm7955189wjb.17.2014.11.06.06.06.02
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Nov 2014 06:06:02 -0800 (PST)
In-Reply-To: <CALbiyZzdM84Cy+sodbuxPxT1jRZs4W94-N0KCjyaw3K89Edh3w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I am again wondering why I have this issue about /tmp/perf-pid.map file. 
Can anyone explain why it's not there and what this file should contain ?

Thanks,

----
Manu

On 01/29/2014 02:53 PM, Manuel Selva wrote:
> Hi all,
>
> The perf mem report tools shows me a warning before printing results:
>
> Failed to open /tmp/perf-8741.map, continuing without symbols
>
> Then it seems that all the memory accesses which source address (Data
> Symbol field in perf mem rep output) is located in the heap of the
> profiled process is reported as "perf-8741.map" in the Data Object
> field.
>
> I am not sure to understand what this file is, what it should contain,
> and why it's not created when my process is profiled ?
>
> Moreover, I am wondering what perf mem could report for heap data
> object in addition to the fact that the object is in the heap ?
>
> Thanks,
>
> -------
> Manu
>
