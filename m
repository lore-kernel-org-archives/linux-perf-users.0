From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: perf report feature request: folded stack output
Date: Tue, 20 Oct 2015 17:51:46 -0700
Message-ID: <CAE40pde2AtkVGM8ophK3y2Yu75Prbfr-YsroPC4pvZienk2R6w@mail.gmail.com>
References: <CAE40pddHkm_SB4mpOBeSfTe8BcfU1js5fiEK96xA95gbjPa1bg@mail.gmail.com>
 <2844120.msKGatE6uD@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34375 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbbJUAwH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 20 Oct 2015 20:52:07 -0400
Received: by igbni9 with SMTP id ni9so83971091igb.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2015 17:52:05 -0700 (PDT)
In-Reply-To: <2844120.msKGatE6uD@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Fri, Oct 9, 2015 at 4:33 PM, Milian Wolff <milian.wolff@kdab.com> wrote:
> On Freitag, 9. Oktober 2015 14:24:17 CEST Brendan Gregg wrote:
>> G'Day,
>>
>> Maybe someone would like to code this (if not I hope to find the
>> time); perf report already has the capability to print captured stacks
>> as a call tree. I'd like a new output mode: folded.
>>
>> Flame graphs[1] consume folded stacks. Eg:
>>
>> # git clone https://github.com/brendangregg/FlameGraph
>> # cd FlameGraph
>> # perf record -F 99 -a -g -- sleep 60
>> # perf script | ./stackcollapse-perf.pl | ./flamegraph.pl
>> out.perf-folded > flame.svg
>>
>> The last line is inefficient, and should really be something like:
>>
>> # perf report --folded | ./flamegraph.pl out.perf-folded > flame.svg
>>
>> The folded format is function names separated by semicolons, a space,
>> then the count of occurrences. Eg:
>
> <snip>
>
> Hey Brendan,
>
> did you consider writing a python script to do the folding? It's pretty simple
> nowadays, once you cross the initial bar.
>
> I wrote this for stack collapsing futex locks:
> https://paste.kde.org/p61qxah7d
>
> And this to convert samples to callgrind format to open it in KCacheGrind:
> https://paste.kde.org/pjfwd1e8f
>
> If you combine the stack collapsing in the former with the generic
> process_event hook used in the latter, you should be all set. In my tests, it
> was pretty quick to convert stuff, certainly better than creating strings,
> pushing them to the console, and then parsing that again in perl.
>
> perf script fold | flamegraph.pl > flame.svg
>
> gets pretty close. If you want to test locally, make sure you use `perf script
> -s fold.py` or similar.

Thanks, I did check them out (those links since expired), and that is
an improvement! But I can't help but think that perf report already
has the logic for creating a call tree, and it would be more efficient
if perf could just dump in folded output directly -- without a python
coprocess.

Brendan
