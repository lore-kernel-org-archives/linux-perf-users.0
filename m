From: Daniel Speyer <dspeyer@gmail.com>
Subject: Re: How to read the perf report output
Date: Tue, 21 Apr 2015 18:44:17 +0000 (UTC)
Message-ID: <loom.20150421T203602-458@post.gmane.org>
References: <CA+res+Qw26_URgzDGWOriDDqpc6G6tqqEYfHe-9nO1gonOzkWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40619 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbbDUSpF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 21 Apr 2015 14:45:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1YkdAM-0005c9-Ed
	for linux-perf-users@vger.kernel.org; Tue, 21 Apr 2015 20:45:02 +0200
Received: from cpe-74-65-228-248.nyc.res.rr.com ([74.65.228.248])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2015 20:45:02 +0200
Received: from dspeyer by cpe-74-65-228-248.nyc.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2015 20:45:02 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

My copy of perf doesn't do that, but from looking at some stacks, I think
the first percentage is time spent in that function *including* children and
the second is *excluding*.  For example, cpu_startup_entry calls
arch_cpu_idle, and the latter accounts for most of the former's run time, so
they both have high inclusive time but the former has very low exclusive.

You might find things clearer using perf script instead of perf report.  It
doesn't analyze, but just dumps the results in an easy-to-read format
(intended to be the input to a script you would write, hence the name, but
you can also read it by hand).  You may need to specify a format.  I
generally use:

  sudo perf script -f trace:tid,comm,time,event,trace,sym,ip,dso
