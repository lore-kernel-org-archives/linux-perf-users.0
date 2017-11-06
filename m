From: Bram Stolk <b.stolk@gmail.com>
Subject: Re: Wildly different output sizes between subsequent perf record runs.
Date: Mon, 6 Nov 2017 09:38:18 -0800
Message-ID: <CABYXEku6=bTkrK96E25JTMYJkH4R0_2XLrGuZDpZwboeV_RTJw@mail.gmail.com>
References: <CABYXEkvrMhd9+P01k94AE97YHooDcs8Nxn4UfuvKfzzq88foVA@mail.gmail.com>
 <5922369.x0IdO5xPIl@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:51918 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdKFRiT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Nov 2017 12:38:19 -0500
Received: by mail-vk0-f47.google.com with SMTP id v3so6250610vkb.8
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Nov 2017 09:38:19 -0800 (PST)
In-Reply-To: <5922369.x0IdO5xPIl@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho <acme@kernel.org>

Thanks Milian,

This issue is too elusive.
Today I can no longer reproduce the issue with short data runs, even
though I use the same perf binary on the same system with same
arguments.
Not sure what has changed.

I'll try to reboot and try again, see if I can trigger it on a 'colder' machine.


On Mon, Nov 6, 2017 at 4:06 AM, Milian Wolff <milian.wolff@kdab.com> wrote:
> On Samstag, 4. November 2017 02:57:01 CET Bram Stolk wrote:
>> If I do subsequent runs of 'perf record', both of which are identical,
>> I sometimes get wildly different output sizes.
>>
>>
>> https://gist.github.com/stolk/3666b2b4d4319764fdff4a2d4c619782
>>
>> The binary did the same amount of work, and took the same amount of
>> time to execute.
>> This is with using perf from Ubuntu LTS.
>
> I think this is the same bug that I have raised before. See https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1479712.html and below.
>
> Can you try to run your command with a constant period (`-c 3000000` or
> similar), instead of using a dynamic period (i.e. `--freq`)? Does the issue go
> away then? If yes, then it's the same issue that I described earlier, which
> noone else from the perf team has acknowledged so far. I know multiple people
> who are affected by this though...
>
> --
> Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
>
>



-- 
Owner/Director of Game Studio Abraham Stolk Inc.
Vancouver BC, Canada
b.stolk@gmail.com
