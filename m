From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: How to trace threads created by a process after perf has started recording, using the -p PID flag?
Date: Tue, 04 Sep 2012 15:47:40 +0900
Message-ID: <87627ue12r.fsf@sejong.aot.lge.com>
References: <CAHFo2uodOOiTKRbeZvFFbGry8XK85unXz+_L6imgH6EeiROc0Q@mail.gmail.com>
	<CAKYOsXwF-Rk97BEWk_fEHhfVisPy_q439tdx7H9onAOyFi=-uA@mail.gmail.com>
	<CAHFo2up0cy4A8pSX5=dJ4k95ZtUTEzvzqcvfRoaoUjedpcvw5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:56851 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab2IDGzL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Sep 2012 02:55:11 -0400
In-Reply-To: <CAHFo2up0cy4A8pSX5=dJ4k95ZtUTEzvzqcvfRoaoUjedpcvw5Q@mail.gmail.com>
	(Mikolaj Konarski's message of "Tue, 4 Sep 2012 00:17:50 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mikolaj Konarski <mikolaj.konarski@gmail.com>
Cc: David Ahern <dsahern@gmail.com>, chenggang.qin@gmail.com, Bernie Pope <florbitous@gmail.com>, Duncan Coutts <duncan@well-typed.com>, linux-perf-users@vger.kernel.org

Hi, Mikolaj

On Tue, 4 Sep 2012 00:17:50 +0200, Mikolaj Konarski wrote:
>>> Could someone clarify the behaviour of the -p PID flag of perf-record?
>>> In our experiments (3.2.0-27 #43-Ubuntu SMP x86_64),
>>> it ignores events on threads spawned after perf-record is started.
>>> Is this the intended behaviour, and is there any work-around?
>
> Anybody? We'd love to use a proven, standard workaround
> for this issue, preferably without forcing our users to upgrade
> the kernel or wait for any future release. Do we even diagnose
> the problem correctly? The best workaround we can come up with
> right now is to use the "--filter 'pid==NNNN'" option, but it has
> a couple of downsides. Any help would be sincerely appreciated.
>

AFAIK perf events aren't inherited when -p, -t or -u option is used due
to a performance reason.  But if you start the process on the command
line with perf record, it'll be inherited and counted properly.

I guess your problem might be solved by using a cgroup:

  # mkdir ${cgroup_root}/mygroup
  # echo NNNN > ${cgroup_root}/mygroup/tasks
  # perf record -a -e cycles -G mygroup


>> Can you try perf from Linus' current tree? perf should be tracking threads
>> created after the record starts.
>
> Thanks for the tip, David. But are you sure there's
> anything new and relevant in the Linus' current tree?
> Could you perhaps point me to the commit that contains
> the relevant changes?
>
> The version of perf-record that we use already contains the separate
> -p PID and -t TID options, so the initial PID patch is already in.
> It's just that the -p PID option ignores all threads spawned
> after the process is started, AFAICT.
>
> OTOTH, chenggang qin, you say
>
>> I submitted a patch to fix this problem. and the patch is waitting for
>> reviewing.
>
> Could you give me a link to this patch? Does it improve
> the -p PID option or replace it or solve our problem
> in some other way? Thank you for your kind interest.
>

https://lkml.org/lkml/2012/8/22/340

But it only addresses a case of perf top.

Thanks,
Namhyung
