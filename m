From: Nan Xiao <xiaonan830818@gmail.com>
Subject: Re: Why the stack frame in perf.data isn't displayed in FlameGraph?
Date: Tue, 23 May 2017 18:14:21 +0800
Message-ID: <CA+MhoaOu-Sp2FD2oYs+MzNaEUBCK=A2KPx4eYatRryMpAR5Lmg@mail.gmail.com>
References: <CA+MhoaM8o2yap8mMVvJsbB2iwXtn05uh+0am5aACbFV50Oud_g@mail.gmail.com>
 <2393730.W62ke2LKls@agathebauer> <CA+MhoaP=HR43P6PxPdVhW5_36Zo52hrNeP4_j05CwGb6__0xDg@mail.gmail.com>
 <4885592.kBH1JbPkZm@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35412 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967330AbdEWKOW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 May 2017 06:14:22 -0400
Received: by mail-pf0-f179.google.com with SMTP id n23so110212025pfb.2
        for <linux-perf-users@vger.kernel.org>; Tue, 23 May 2017 03:14:22 -0700 (PDT)
In-Reply-To: <4885592.kBH1JbPkZm@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Hi Milian,

Got it! Thanks very much for your total kind help! :-)
Best Regards
Nan Xiao


On Tue, May 23, 2017 at 5:32 PM, Milian Wolff <milian.wolff@kdab.com> wrote:
> On Friday, May 19, 2017 3:50:46 AM CEST Nan Xiao wrote:
>> Hi Milian,
>>
>> Thanks very much!
>>
>> So what is the difference between acme's perf/core and general perf
>> installed by pacman/yum? Is acme's perf/core more newer? Thx!
>
> Yes, acme is the maintainer of the perf subsystem and his perf/core branch is
> where all the latest work gets merged and tested before it lands in mainline.
> Once it's in mainline it takes some time until a kernel gets released with
> this version, and then a couple of months before distros start using that
> kernel version (or a newer one).
>
> So in general, if you rely on the distro packages for perf, most things are
> usually outdated by at least half a year or so, often times more. For the in-
> kernel recording features, that's often fine. But for the user-space analysis
> tools, that is often a difference between day and night in my eyes. YMMV.
>
> Cheers
>
> --
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
