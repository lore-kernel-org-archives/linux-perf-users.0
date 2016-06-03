From: Jose <jose.sgarcia.aldonza@gmail.com>
Subject: Re: IPC sampling
Date: Fri, 3 Jun 2016 15:23:52 +0000 (UTC)
Message-ID: <loom.20160603T171204-784@post.gmane.org>
References: <loom.20160603T134548-395@post.gmane.org> <87oa7imiyt.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34598 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147AbcFCPYO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 3 Jun 2016 11:24:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1b8qxH-0000Ih-75
	for linux-perf-users@vger.kernel.org; Fri, 03 Jun 2016 17:24:11 +0200
Received: from 90.168.7.87 ([90.168.7.87])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2016 17:24:11 +0200
Received: from jose.sgarcia.aldonza by 90.168.7.87 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2016 17:24:11 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Andi Kleen <andi <at> firstfloor.org> writes:

> 
> Jose <jose.sgarcia.aldonza <at> gmail.com> writes:
> >
> > My problem now is that I don't know how to obtain "cycles" and
> > "instructions" from perf.data file. I have tried several options using "perf
> > report" and "perf script" but I don't achieve it.
> 
> perf record -e '{instructions,cycles}:S' ...
> perf script
> 
> This means sample on cycles, but always read instructions too during the
sample.
> Then match up the values with the same time stamp from perf script and
> calculate ipc, or use a perf script interpreted script to do so.
> 
> -Andi
> 


Good! 

Two additional questions:

- If using '{cycles,instructions}:S', is sampling on instructions? Sometimes
I'm interested to sample on number of instructions.

I don't find information about option :S from man pages. Is there a manual
with much more information?

- Could you provide more information (links, an example, ...) on "perf
script interpreted script"

Thanks
Jose
