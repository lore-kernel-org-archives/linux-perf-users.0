From: David Ahern <dsahern@gmail.com>
Subject: Re: How does perf collects per thread/process events ?
Date: Mon, 22 Jul 2013 07:44:35 -0600
Message-ID: <51ED3743.4010802@gmail.com>
References: <51E566DD.1070006@insa-lyon.fr> <1374466784.17730.12.camel@concordia> <51ECD63E.5070305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34775 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab3GVNoi (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Jul 2013 09:44:38 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so6860070pdj.17
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2013 06:44:38 -0700 (PDT)
In-Reply-To: <51ECD63E.5070305@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>

On 7/22/13 12:50 AM, Manuel Selva wrote:
> Thanks for the answer Michael.
>
> I just created an account to be able to edit the perf wiki page. Before
> doing that, I am asking here if someone knows the policy to update this
> wiki or who are the maintainers to ask them ?

Arnaldo is the current one I believe.
David


>
> On 07/22/2013 06:19 AM, Michael Ellerman wrote:
>> On Tue, 2013-07-16 at 17:29 +0200, Manuel Selva wrote:
>>> Hi,
>>>
>>> My question regards a platform equipped with 2 Intel Xeon X5650.
>>> According to the perf wiki page
>>> (https://perf.wiki.kernel.org/index.php/Tutorial), "by default perf stat
>>> counts for all threads of the process and subsequent child processes and
>>> threads" and "By default, perf stat counts in per-thread mode".
>>>
>>> So a first question is what is the default: per thread or per process ?
>>
>> It's per process, which is as described in the first quote above. The
>> second quote is just wrong AFAICS.
>>
>>> Then, independently of the answer, I am wondering how does perf handles
>>> per thread or per process regarding the scheduler and migrations. I
>>> didn't find it explicitly in the Intel documentation but it seems
>>> natural that hardware performance counters located on a given core are
>>> only capable of counting event on this core and not on other cores. Is
>>> it true ?
>>>
>>> Moreover, the wiki page says that "When a thread migrated from one
>>> processor to another, counters are saved on the current processor and
>>> are restored on the new one" (this seems to confirm the answer to my
>>> previous question above). It means that the scheduler is aware about
>>> "perf" or that perf is able to register a hook into the scheduler. So I
>>> guess this is done in the kernel part of perf (in the implementation of
>>> the perf_event_open system call) and not in the user land part, is it
>>> true ?
>>
>> Yes.
>>
>> cheers
>>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
