From: Christian Convey <christian.convey@gmail.com>
Subject: Re: newbie question: tracing userspace call/return sequences
Date: Sat, 7 Jan 2017 13:26:47 -0500
Message-ID: <CAPfS4ZzJUUdD-WGgoZ=ZTyDvQHZa322DeYMeJYBHj6PjMQcG2A@mail.gmail.com>
References: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
 <87zij4nhvk.fsf@firstfloor.org> <CAPfS4Zx6ZzWWUsSEbstsd2En6bqo=z94NTWe6xh_tJ9eZd17+A@mail.gmail.com>
 <CAM9d7cjdNdeUKge_LbSwWyCdnrvzP2VxKGLy3tAw3q03D5Jf3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34219 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932653AbdAGS0s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 7 Jan 2017 13:26:48 -0500
Received: by mail-qk0-f180.google.com with SMTP id a20so105983674qkc.1
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Jan 2017 10:26:48 -0800 (PST)
In-Reply-To: <CAM9d7cjdNdeUKge_LbSwWyCdnrvzP2VxKGLy3tAw3q03D5Jf3w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@gmail.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

On Fri, Jan 6, 2017 at 11:37 PM, Namhyung Kim <namhyung@gmail.com> wrote:
...
> You can use uftrace for function tracing.  It doesn't have a hardware dependency
> but you need to rebuild your program with instrumentation enabled (like -pg
> or -finstrument-functions in gcc).
>
> https://github.com/namhyung/uftrace

Thanks Namhyung.

For one of my current projects, I'm limited to tools which don't
require me to recompile / relink the target program.  So I'm limited
to options such as Perf, Systemtap, Gdb, or Intel Pin.

- Christian
