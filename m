From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Using perf with cgroups and containers
Date: Fri, 28 Nov 2014 19:00:15 +0100
Message-ID: <20141128180015.GZ12538@two.firstfloor.org>
References: <547606D8.3040601@redhat.com>
 <87wq6hhegq.fsf@tassilo.jf.intel.com>
 <54764629.9050601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:51103 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbaK1SAQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Nov 2014 13:00:16 -0500
Content-Disposition: inline
In-Reply-To: <54764629.9050601@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users <linux-perf-users@vger.kernel.org>

> Is there some where that explain use of the "{}" for event grouping? 

The only good description I know of is in the ucevent documentation.

https://github.com/andikleen/pmu-tools/tree/master/ucevent#grouping-event-scheduling-and-measurement-inaccuracy

Yes the documentation probably needs to be improved (as in many other
ways)

> 
>       -G name,..., --cgroup name,...
>            monitor only in the container (cgroup) called "name". This option
>            is available only in per-cpu mode. The cgroup filesystem must be
>            mounted. All threads belonging to container "name" are monitored
>            when they run on the monitored CPUs. Multiple cgroups can be
>            provided. Each cgroup is applied to the corresponding event, i.e.,
>            first cgroup to first event, second cgroup to second event and so
>            on. It is possible to provide an empty cgroup (monitor all the
>            time) using, e.g., -G foo,,bar. Cgroups must have corresponding
>            events, i.e., they always refer to events defined earlier on the
>            command line.
> 
> The results looks pretty questionable on my machine with the version of perf and kernel I am using:

You're right it doesn't work as I described. Should probably fix it,
my way would make a lot more sense :-)

I guess the current interface was more aimed at scripts.


-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
