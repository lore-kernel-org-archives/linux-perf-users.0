From: David Ahern <dsahern@gmail.com>
Subject: Re: How to trace threads created by a process after perf has started
 recording, using the -p PID flag?
Date: Tue, 04 Sep 2012 10:04:31 -0600
Message-ID: <5046268F.4050504@gmail.com>
References: <CAHFo2uodOOiTKRbeZvFFbGry8XK85unXz+_L6imgH6EeiROc0Q@mail.gmail.com> <CAKYOsXwF-Rk97BEWk_fEHhfVisPy_q439tdx7H9onAOyFi=-uA@mail.gmail.com> <CAHFo2up0cy4A8pSX5=dJ4k95ZtUTEzvzqcvfRoaoUjedpcvw5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49285 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757312Ab2IDQEe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Sep 2012 12:04:34 -0400
Received: by pbbrr13 with SMTP id rr13so9703443pbb.19
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Sep 2012 09:04:34 -0700 (PDT)
In-Reply-To: <CAHFo2up0cy4A8pSX5=dJ4k95ZtUTEzvzqcvfRoaoUjedpcvw5Q@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mikolaj Konarski <mikolaj.konarski@gmail.com>
Cc: chenggang.qin@gmail.com, Bernie Pope <florbitous@gmail.com>, Duncan Coutts <duncan@well-typed.com>, linux-perf-users@vger.kernel.org

On 9/3/12 4:17 PM, Mikolaj Konarski wrote:
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

I see the problem now. The perf tool gets FORK events as threads are 
created, but it does not respond to them and create new counters. Some 
refactoring is needed to make that happen.

David
