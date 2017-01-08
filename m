From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Sun, 8 Jan 2017 17:08:19 +0900
Message-ID: <CAM9d7ci9FWrr8a7OtanKft2EmST0dtfWap1fdOcAQb+j+LkM6g@mail.gmail.com>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
 <87zij4nhvk.fsf@firstfloor.org> <CAPfS4Zx6ZzWWUsSEbstsd2En6bqo=z94NTWe6xh_tJ9eZd17+A@mail.gmail.com>
 <CAM9d7cjdNdeUKge_LbSwWyCdnrvzP2VxKGLy3tAw3q03D5Jf3w@mail.gmail.com> <20170107190835.GA26852@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34974 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdAHIIk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 8 Jan 2017 03:08:40 -0500
Received: by mail-io0-f193.google.com with SMTP id m98so4053394iod.2
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Jan 2017 00:08:40 -0800 (PST)
In-Reply-To: <20170107190835.GA26852@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Christian Convey <christian.convey@gmail.com>, linux-perf-users <linux-perf-users@vger.kernel.org>

Hi Andi,

On Sun, Jan 8, 2017 at 4:08 AM, Andi Kleen <andi@firstfloor.org> wrote:
>> You can use uftrace for function tracing.  It doesn't have a hardware dependency
>> but you need to rebuild your program with instrumentation enabled (like -pg
>> or -finstrument-functions in gcc).
>>
>> https://github.com/namhyung/uftrace
>
> I have a similar tool here.
>
> http://github.com/andikleen/ftracer

Cool!

>
> But it's really far inferior to hardware tracing. Use the right tool for the
> job.

I admit that hardware tracing is much better in terms of performance
and precision.  But I don't have such a recent CPU.

Also uftrace has various types of filters to reduce data and
some useful features like capturing argument/return value,
showing kernel functions (system call, page fault, ...) with root
privilege (using ftrace) and support analysis using external programs
like chrome or flamegraph.

Thanks,
Namhyung
