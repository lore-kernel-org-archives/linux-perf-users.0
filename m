From: Jean-Jacques Hiblot <jjhiblot@gmail.com>
Subject: Re: Measuring worst case interrupt processing time
Date: Mon, 9 Dec 2013 17:53:15 +0100
Message-ID: <CACh+v5Ng-knegF+86rOEYJGY5b1veqG1uiLB7ptEBoV92grQNA@mail.gmail.com>
References: <CAL7o8itUf0wOj-f7LEF=EfydzimOkpi1VrTZXVE0VvECNP0VPQ@mail.gmail.com>
	<52A5A8D6.6020401@gmail.com>
	<CAL7o8iu+cM1x+NnNWvtjVjJLRdB2q5f==-0nmzfhX02BjUxcjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:46335 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933851Ab3LIQxQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 Dec 2013 11:53:16 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so5545208pde.13
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2013 08:53:16 -0800 (PST)
In-Reply-To: <CAL7o8iu+cM1x+NnNWvtjVjJLRdB2q5f==-0nmzfhX02BjUxcjA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mohammed Riyaz <riyaz.list@gmail.com>
Cc: linux-perf-users@vger.kernel.org

I use that a lot in my day to day job.
Lately I've been toying with the idea of adding this kind of GPIO
debugging/profiling in the krpobe_events interface.
I'll post a draft when I've something working

Jean-Jacques

2013/12/9 Mohammed Riyaz <riyaz.list@gmail.com>:
> On Mon, Dec 9, 2013 at 3:26 AM, JJ Hiblot <jjhiblot@gmail.com> wrote:
>> I used to do this kind of measurement with a GPIO and an oscilloscope set up
>> in persistence mode. In this case ,the precision of  the measure doesn't
>> depend of the timer's resolution.
>
> Though not suitable for my setup, never thought of using h/w for such
> measurements. Interesting.
>
> Thanks
> Riyaz
