From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: memory consumption information in perf stat?
Date: Thu, 28 Jan 2016 20:55:05 +0100
Message-ID: <56AA7219.4020803@gmail.com>
References: <53853116.DaB1LNLXKQ@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33706 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967346AbcA1TzI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 28 Jan 2016 14:55:08 -0500
Received: by mail-wm0-f45.google.com with SMTP id l66so40157332wml.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jan 2016 11:55:07 -0800 (PST)
In-Reply-To: <53853116.DaB1LNLXKQ@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org

Hi,

I am not sure perf stat can compute such information because it mainly 
count events (hardware or kernel). To compute the peak heap size, perf 
stat would require the knowledge of all heap memory allocations.

----
Manu

On 28/01/2016 18:11, Milian Wolff wrote:
> Hey all,
>
> for user-space profiling, it would be extremely useful to get memory
> consumption information such as peak heap size into the output of perf stat.
> Is this doable? I just learned that `command time -v` is able to output the
> maximum and average RSS. It would be extremely nice if `perf stat` could
> incorporate that as well somehow such that I only need a single application to
> look at that.
>
> If this is doable, then feel free to guide me to the code and I'm willing to
> supply a patch for perf stat.
>
> Thanks
