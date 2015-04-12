From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: perf user SDT markers
Date: Sun, 12 Apr 2015 13:05:24 -0700
Message-ID: <CAE40pdcCMaO6Lih7enhkxLFdwsbSyDuPjoRbBJLa6arPEz5qYQ@mail.gmail.com>
References: <CAE40pdf1Y3mQMnVi7jSBMg8ovg7x3L17jCf_yGemM_PLLG_k1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35450 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbbDLUFp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 12 Apr 2015 16:05:45 -0400
Received: by iggg4 with SMTP id g4so31363294igg.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2015 13:05:45 -0700 (PDT)
In-Reply-To: <CAE40pdf1Y3mQMnVi7jSBMg8ovg7x3L17jCf_yGemM_PLLG_k1g@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>, hemant@linux.vnet.ibm.com

On Sat, Apr 11, 2015 at 7:13 PM, Brendan Gregg
<brendan.d.gregg@gmail.com> wrote:
> G'Day,
>
> I was just trying Hemant Kumar's user SDT patch
> (http://lwn.net/Articles/618956/); anyone else tried it recently? I
> applied it to 4.0.0-rc6, and it creates instrumentation, but doesn't
> record the probes.
>
> This works (it finds the Node.js probes):
>
> # ./perf sdt-cache --dump
> /home/bgregg-testtest/node-standard/out/Release/node:
>    %node:net__server__connection
>    %node:net__stream__end
>    %node:net__socket__read
>    %node:net__socket__write
>    %node:http__server__request
>    %node:http__server__response
>    %node:http__client__request
>    %node:http__client__response
>    %node:gc__done
>    %node:gc__start
>
> But I can't "perf list" or record them:
>
> # ./perf record -e '%node:http__server__request' -aR
> invalid or unsupported event: '%node:http__server__request'
> Run 'perf list' for a list of valid events
> [...]
>
> stap works:
>
> # /root/systemtap-2.8/bin/stap -e 'probe
> process("/home/bgregg-testtest/node-standard/out/Release/node").mark("http__server__request")
> { println("hit"); }'
> hit
> hit
>
> Brendan

Some more digging... So a simple C program with a DTRACE_PROBE1()
works, where the marker ends up being "%tick:loop":

# ./perf record -e '%tick:loop' -a -g
[...]
^C
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.334 MB perf.data (2 samples) ]

But the %node markers don't work (eg, "%node:gc__start"). Maybe the
presence of underscores is breaking it? By adding some debug
statements, I dug this message out of yyparse(), which was failing:

yyparse() yymsgbuf: syntax error, unexpected PE_NAME, expecting $end

Brendan
