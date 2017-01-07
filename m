From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Sat, 7 Jan 2017 13:37:34 +0900
Message-ID: <CAM9d7cjdNdeUKge_LbSwWyCdnrvzP2VxKGLy3tAw3q03D5Jf3w@mail.gmail.com>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
 <87zij4nhvk.fsf@firstfloor.org> <CAPfS4Zx6ZzWWUsSEbstsd2En6bqo=z94NTWe6xh_tJ9eZd17+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36012 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754867AbdAGEhz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2017 23:37:55 -0500
Received: by mail-it0-f68.google.com with SMTP id n68so4001244itn.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jan 2017 20:37:55 -0800 (PST)
In-Reply-To: <CAPfS4Zx6ZzWWUsSEbstsd2En6bqo=z94NTWe6xh_tJ9eZd17+A@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Christian Convey <christian.convey@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users <linux-perf-users@vger.kernel.org>

Hello,

On Sat, Jan 7, 2017 at 4:07 AM, Christian Convey
<christian.convey@gmail.com> wrote:
>> Use the right tool for the job.
>>
>> On Intel, use a Broadwell or Skylake or Goldmont and use processor trace.
>>
>> perf record -e intel_pt//u foo
>> perf script --itrace=cr
>
> Hi Andi,
>
> Thanks for the idea.  It sounds promising.
>
> Unfortunately for my current situation, the CPU's on which I need to
> run this are too old to have intel_pt.

You can use uftrace for function tracing.  It doesn't have a hardware dependency
but you need to rebuild your program with instrumentation enabled (like -pg
or -finstrument-functions in gcc).

https://github.com/namhyung/uftrace

-- 
Thanks,
Namhyung Kim
