From: Bram Stolk <b.stolk@gmail.com>
Subject: Re: Adding a recording delay interferes with symbols/call-stack
Date: Thu, 2 Nov 2017 00:10:48 -0700
Message-ID: <CABYXEks+c02Ev=hdXO+tQSEypqXQvr0y8jm2Zt1m19Yi0UcULA@mail.gmail.com>
References: <CABYXEksdehm6S9-WGO6MV1wQaWHCsk-Ofp-sDaxY+qwQSNPp8Q@mail.gmail.com>
 <20171031142537.GT7045@kernel.org> <CABYXEktUSaLrT4Ajp17D4i93o1Sia+Jd5vpSAydEPNOw6nTFiA@mail.gmail.com>
 <20171031191411.GB3531@kernel.org> <CABYXEktgnCoc7tTzeOaT-e=ggYPAVHRk=R2tc64NgCtphL1-aw@mail.gmail.com>
 <20171102062052.GB23303@sejong> <CABYXEksfK4CwgrogBZ=EZWQubOWb8UDxzw22o_pH3TQmmk6Htg@mail.gmail.com>
 <20171102070743.GC23303@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:50198 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755097AbdKBHKt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Nov 2017 03:10:49 -0400
Received: by mail-ua0-f182.google.com with SMTP id v27so3253541uav.7
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2017 00:10:49 -0700 (PDT)
In-Reply-To: <20171102070743.GC23303@sejong>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-perf-users@vger.kernel.org, kernel-team@lge.com

$ perf report -D | tail
            COMM events:          2
            EXIT events:          5
            FORK events:          4
          SAMPLE events:         62
           MMAP2 events:         93
  FINISHED_ROUND events:          2
       TIME_CONV events:          1
cycles:uppp stats:
           TOTAL events:         62
          SAMPLE events:         62

This is with patched perf.

Bed time on west coast, I'll do more testing tomorrow. Thanks for the help!


On Thu, Nov 2, 2017 at 12:07 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> On Thu, Nov 02, 2017 at 12:01:24AM -0700, Bram Stolk wrote:
>> Thanks Namhyung,
>>
>> I tried the patch, but still no app symbols:
>>
>> perf record --delay=1000 --freq 2000 --call-graph dwarf ./bench
>> ...
>> [ perf record: Woken up 2 times to write data ]
>> [ perf record: Captured and wrote 0.347 MB perf.data (41 samples) ]
>>
>> perf report -g 'graph,0.25,callee'
>
> Hmmm... could you please show me whether MMAP2 events are recorded?
>
>   $ perf report -D | tail
>
> Thanks,
> Namhyung



-- 
Owner/Director of Game Studio Abraham Stolk Inc.
Vancouver BC, Canada
b.stolk@gmail.com
