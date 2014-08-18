From: Tommy <tommy24@gatech.edu>
Subject: Re: Problems with perf
Date: Mon, 18 Aug 2014 18:55:02 +0000 (UTC)
Message-ID: <loom.20140818T205057-420@post.gmane.org>
References: <CABooUW2QDE_zRMyNzSEvWMEy+c-yrMvm+rSoASsx7ctBTijvFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42341 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705AbaHRTAJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 18 Aug 2014 15:00:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1XJSA1-0008Pn-7g
	for linux-perf-users@vger.kernel.org; Mon, 18 Aug 2014 21:00:05 +0200
Received: from parisdaisy.cc.gt.atl.ga.us ([143.215.128.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2014 21:00:05 +0200
Received: from tommy24 by parisdaisy.cc.gt.atl.ga.us with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2014 21:00:05 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Jen-Cheng(Tommy) Huang <tommy24 <at> gatech.edu> writes:
> 
> Hi
> 
> I am trying to use perf with event grouping to profile Java apps.
> My kernel is 3.16.1-1.el6.elrepo.x86_64
> perf version 3.16.1-1.el6.elrepo.x86_64
> The Java app I use is hadoop TaskTracker, which spawns multiple child 
JVMs.
> There seems to be something wrong with event group, since very few
> samples were collected if I use more than one event in a group.
> The following shows an example
> 
> I used
> perf record -e '{instructions}:S' -c 100000 [TaskTracker command]
> This one works fine and it collects a reasonable amount of samples and
> several threads are sampled.
> 
> However, the following command does not work.
> perf record -e '{instructions,cycles}:S' -c 100000 [TaskTracker command]
> Less than 1000 samples were collected and only one thread was sampled
> 
> If I don't use :S to read samples, the sample counts are reasonable,
> but the event grouping is gone. (both events were sampled, no leader
> event.)
> perf record -e '{instructions,cycles}' -c 100000 [TaskTracker command]
> 
> I tested single-threaded app, such as SPEC CPU.
> Everything works fine. The event grouping works fine, so as the :S flag.
> However, the Java app that I tested does not.
> Please let me know if any suggestions on this issue.
> 
> Thanks.
> 
To make it clear about the sample count difference, this is the stats 
collected from a few seconds run of the same app: With only one event in a 
group, it has ~362339 samples while 2 events in a group, it has only 938 
samples (only 1 thread was profiled). I think the sample recording is 
somehow stopped.
Thanks.
