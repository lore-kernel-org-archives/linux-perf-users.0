From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Adding a recording delay interferes with symbols/call-stack
Date: Thu, 2 Nov 2017 16:07:43 +0900
Message-ID: <20171102070743.GC23303@sejong>
References: <CABYXEksdehm6S9-WGO6MV1wQaWHCsk-Ofp-sDaxY+qwQSNPp8Q@mail.gmail.com>
 <20171031142537.GT7045@kernel.org>
 <CABYXEktUSaLrT4Ajp17D4i93o1Sia+Jd5vpSAydEPNOw6nTFiA@mail.gmail.com>
 <20171031191411.GB3531@kernel.org>
 <CABYXEktgnCoc7tTzeOaT-e=ggYPAVHRk=R2tc64NgCtphL1-aw@mail.gmail.com>
 <20171102062052.GB23303@sejong>
 <CABYXEksfK4CwgrogBZ=EZWQubOWb8UDxzw22o_pH3TQmmk6Htg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:54903 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752865AbdKBHHs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Nov 2017 03:07:48 -0400
Content-Disposition: inline
In-Reply-To: <CABYXEksfK4CwgrogBZ=EZWQubOWb8UDxzw22o_pH3TQmmk6Htg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Bram Stolk <b.stolk@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-perf-users@vger.kernel.org, kernel-team@lge.com

On Thu, Nov 02, 2017 at 12:01:24AM -0700, Bram Stolk wrote:
> Thanks Namhyung,
> 
> I tried the patch, but still no app symbols:
> 
> perf record --delay=1000 --freq 2000 --call-graph dwarf ./bench
> ...
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.347 MB perf.data (41 samples) ]
> 
> perf report -g 'graph,0.25,callee'

Hmmm... could you please show me whether MMAP2 events are recorded?

  $ perf report -D | tail

Thanks,
Namhyung
