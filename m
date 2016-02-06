From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: User defined metrics for perf stat?
Date: Sat, 6 Feb 2016 22:54:48 +0100
Message-ID: <20160206215448.GA6025@krava.redhat.com>
References: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
 <20160201171540.GB20817@kernel.org>
 <20160201172755.GA27366@krava.redhat.com>
 <CAGz0_-0k93OvSNgtnDMMTwYWxQuVnABqjfKC-KdmhGqv5H=C3A@mail.gmail.com>
 <20160202085802.GA4257@krava.brq.redhat.com>
 <CAGz0_-0HtuVf9XV1NZduHEtwz4nKJb8+Jib6_AksgAdG=pL=TA@mail.gmail.com>
 <20160203074804.GA16045@krava.brq.redhat.com>
 <CAGz0_-2Rs9DqfRhP2mWm6CQvoQtC385VeE+cYKJnJinx5nkpSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49704 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbcBFVyx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 6 Feb 2016 16:54:53 -0500
Content-Disposition: inline
In-Reply-To: <CAGz0_-2Rs9DqfRhP2mWm6CQvoQtC385VeE+cYKJnJinx5nkpSQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andreas Hollmann <hollmann@in.tum.de>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Fri, Feb 05, 2016 at 03:12:04PM +0100, Andreas Hollmann wrote:
> Jiri, this method does not work when you pipe data to perf script.
> 
> Works with perf.data file:
> 
> ./perf stat -a -I 1000 -e cycles,"cpu/config=0x6530160,name=krava/" record
> 
> /perf script -s test.py
> event krava cpu -1, thread -1, time 1029898211, val 10959, ena
> 81192094638, run 81192094638
> event krava cpu -1, thread -1, time 2043671594, val 10753, ena
> 81094362809, run 81094362809
> 
> does not work when using pipe
> 
> ./perf stat -a -I 1000 -e cycles,"cpu/config=0x6530160,name=krava/"
> record | ./perf script -s test.py
> 
> --- no output
> 
> Here the test.py
> 
> cat test.py
> #!/usr/bin/env python
> 
> def stat__krava(cpu, thread, time, val, ena, run):
>     print "event %s cpu %d, thread %d, time %d, val %d, ena %d, run %d" % \
>           ("krava", cpu, thread, time, val, ena, run)

right, we probably don't transfer the name term through the pipe,
I'll check on that..

jirka
