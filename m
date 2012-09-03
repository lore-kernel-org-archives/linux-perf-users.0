From: Mikolaj Konarski <mikolaj.konarski@gmail.com>
Subject: Re: How to trace threads created by a process after perf has started
 recording, using the -p PID flag?
Date: Tue, 4 Sep 2012 00:17:50 +0200
Message-ID: <CAHFo2up0cy4A8pSX5=dJ4k95ZtUTEzvzqcvfRoaoUjedpcvw5Q@mail.gmail.com>
References: <CAHFo2uodOOiTKRbeZvFFbGry8XK85unXz+_L6imgH6EeiROc0Q@mail.gmail.com>
	<CAKYOsXwF-Rk97BEWk_fEHhfVisPy_q439tdx7H9onAOyFi=-uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38725 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854Ab2ICWRv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Sep 2012 18:17:51 -0400
Received: by wgbdr13 with SMTP id dr13so5001292wgb.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Sep 2012 15:17:50 -0700 (PDT)
In-Reply-To: <CAKYOsXwF-Rk97BEWk_fEHhfVisPy_q439tdx7H9onAOyFi=-uA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>, chenggang.qin@gmail.com
Cc: Bernie Pope <florbitous@gmail.com>, Duncan Coutts <duncan@well-typed.com>, linux-perf-users@vger.kernel.org

>> Could someone clarify the behaviour of the -p PID flag of perf-record?
>> In our experiments (3.2.0-27 #43-Ubuntu SMP x86_64),
>> it ignores events on threads spawned after perf-record is started.
>> Is this the intended behaviour, and is there any work-around?

Anybody? We'd love to use a proven, standard workaround
for this issue, preferably without forcing our users to upgrade
the kernel or wait for any future release. Do we even diagnose
the problem correctly? The best workaround we can come up with
right now is to use the "--filter 'pid==NNNN'" option, but it has
a couple of downsides. Any help would be sincerely appreciated.

> Can you try perf from Linus' current tree? perf should be tracking threads
> created after the record starts.

Thanks for the tip, David. But are you sure there's
anything new and relevant in the Linus' current tree?
Could you perhaps point me to the commit that contains
the relevant changes?

The version of perf-record that we use already contains the separate
-p PID and -t TID options, so the initial PID patch is already in.
It's just that the -p PID option ignores all threads spawned
after the process is started, AFAICT.

OTOTH, chenggang qin, you say

> I submitted a patch to fix this problem. and the patch is waitting for
> reviewing.

Could you give me a link to this patch? Does it improve
the -p PID option or replace it or solve our problem
in some other way? Thank you for your kind interest.

Cheers,
Mikolaj
