From: Nan Xiao <xiaonan830818@gmail.com>
Subject: Re: Why the stack frame in perf.data isn't displayed in FlameGraph?
Date: Fri, 19 May 2017 09:50:46 +0800
Message-ID: <CA+MhoaP=HR43P6PxPdVhW5_36Zo52hrNeP4_j05CwGb6__0xDg@mail.gmail.com>
References: <CA+MhoaM8o2yap8mMVvJsbB2iwXtn05uh+0am5aACbFV50Oud_g@mail.gmail.com>
 <9775568.X03CyG2sn6@agathebauer> <CA+MhoaOJkUe-EyP67F+YtNb04TjfteTSS=KHiN98ry4zK5WXWA@mail.gmail.com>
 <2393730.W62ke2LKls@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34346 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753200AbdESBur (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 May 2017 21:50:47 -0400
Received: by mail-pf0-f181.google.com with SMTP id 9so32167243pfj.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 May 2017 18:50:47 -0700 (PDT)
In-Reply-To: <2393730.W62ke2LKls@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Hi Milian,

Thanks very much!

So what is the difference between acme's perf/core and general perf
installed by pacman/yum? Is acme's perf/core more newer? Thx!
Best Regards
Nan Xiao


On Fri, May 19, 2017 at 3:01 AM, Milian Wolff <milian.wolff@kdab.com> wrote:
> On Donnerstag, 18. Mai 2017 15:24:04 CEST Nan Xiao wrote:
>> Hi Milian,
>>
>> Firstly, thanks very much for your kind and detailed help!
>>
>> (1) I recompile the program use "g++ -g -O2 ...", and use "perf record
>> --call-graph dwarf" to sample. The FlameGraph can display full stack
>> frames and "inner" function appears in both FlameGraph and "perf
>> record".
>>
>> (2) > Also, to see inline frames, try to build perf from git (acme's
>> perf/core) and use `perf report --inline`.
>>
>> I find my perf version doesn't support "--inline" option, and I can't
>> figure out what is the meaning of "build perf from git (acme's
>> perf/core)". Could you elaborate it? I just install perf tools using
>> "sudo pacman -S perf".
>
> Essentially it boils down to do this:
>
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux -b perf/
> core
> cd linux/tools/perf
> make
> ./perf report --inline ...
>
> Cheers
>
> --
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
