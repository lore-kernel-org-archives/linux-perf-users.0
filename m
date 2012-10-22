From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Re: perf top -z not working?
Date: Mon, 22 Oct 2012 23:15:30 +0900
Message-ID: <50855502.1030405@core.kaist.ac.kr>
References: <507EA40D.60206@cs.utoronto.ca> <507EB776.9030304@core.kaist.ac.kr> <20121022014618.GA7924@ghostprotocols.net> <50853311.3040707@cs.utoronto.ca> <50854633.30206@gmail.com> <508553D1.8040603@cs.utoronto.ca> <50855496.8080202@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:56396 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426Ab2JVOPf (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Oct 2012 10:15:35 -0400
Received: from [143.248.165.115] (az.kaist.ac.kr [143.248.165.115])
	by core.kaist.ac.kr (8.14.4/8.14.4) with ESMTP id q9MEEEU4008835
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Oct 2012 23:14:14 +0900
In-Reply-To: <50855496.8080202@core.kaist.ac.kr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

2012-10-22 =EC=98=A4=ED=9B=84 11:13, Chulmin Kim =EC=93=B4 =EA=B8=80:
> 2012-10-22 =EC=98=A4=ED=9B=84 11:10, Ryan Johnson =EC=93=B4 =EA=B8=80=
:
>> On 22/10/2012 9:12 AM, David Ahern wrote:
>>> On 10/22/12 5:50 AM, Ryan Johnson wrote:
>>>>>>> It seems that `perf top -z' does not behave as advertized, at
>>>>>>> least not on the 3.2.0-25 kernel (Ubuntu) that I'm running. The
>>>>>>> man page states that it should "zero history across display
>>>>>>> updates" but the counts still seem to accumulate (the total
>>>>>>> samples reported rises monotonically) and processes still show =
up
>>>>>>> in the display long after they have exited. Pressing `z' or `Z'
>>>>>>> seems to have no effect, either.
>>>>> Are you using the --tui or --stdio interface? Try with both and
>>>>> check if
>>>>> it works in one of them, I bet the problem is with --tui.
>>>> --stdio does the same, so I'll have to try updating my kernel like
>>>> Chulmin suggested (haven't had time to do that yet)
>>>
>>> The kernel has nothing to do with the feature. From builtin-top.c,
>>> this part is either not happening or more likely not happening
>>> correctly.
>>>
>>>     if (top->zero)
>>>         symbol__annotate_zero_histogram(symbol, top->sym_evsel->idx=
);
>>>     else
>>>         symbol__annotate_decay_histogram(symbol, top->sym_evsel->id=
x);
>>>
>>> I recall it working recently - last year or so. Can you try
>>> different versions -- say 3.0, 3.2, 3.4 and latest? If you have a
>>> copy of Linus' tree or Arnaldo's git tree it should not take much t=
ime.
>> Chulmin says his 3.0 version works. My 3.2.18 doesn't. I don't have =
a
>> copy of the git tree on that machine, but I'll try building 3.4.x an=
d
>> tip when I get a chance. I have never built perf-tools before,
>> though, so I'd appreciate tips on what might be different for
>> building perf-tools compared to the kernel, and how to avoid buildin=
g
>> the standard kernel along the way. Hopefully it's just
>> configure-make-install?
>>
>
> How about checking your "top" version first?
>
> According to David's suggestion, it is the matter of top version.
>
> Mine was 3.2.8. (top --version).
>
>

=46orget this message. My misunderstanding. :)


>
>
>> Regards,
>> Ryan
>>
