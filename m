From: Andreas Hollmann <hollmann@in.tum.de>
Subject: Re: User defined metrics for perf stat?
Date: Fri, 5 Feb 2016 15:12:04 +0100
Message-ID: <CAGz0_-2Rs9DqfRhP2mWm6CQvoQtC385VeE+cYKJnJinx5nkpSQ@mail.gmail.com>
References: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
	<20160201171540.GB20817@kernel.org>
	<20160201172755.GA27366@krava.redhat.com>
	<CAGz0_-0k93OvSNgtnDMMTwYWxQuVnABqjfKC-KdmhGqv5H=C3A@mail.gmail.com>
	<20160202085802.GA4257@krava.brq.redhat.com>
	<CAGz0_-0HtuVf9XV1NZduHEtwz4nKJb8+Jib6_AksgAdG=pL=TA@mail.gmail.com>
	<20160203074804.GA16045@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:38644 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754229AbcBEOMJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 5 Feb 2016 09:12:09 -0500
Received: (Authenticated sender: hollmann)
	by mail.in.tum.de (Postfix) with ESMTPSA id 2504A1C112D
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Feb 2016 15:12:07 +0100 (CET)
Received: by mail-qg0-f54.google.com with SMTP id b35so67846683qge.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Feb 2016 06:12:07 -0800 (PST)
In-Reply-To: <20160203074804.GA16045@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Jiri, this method does not work when you pipe data to perf script.

Works with perf.data file:

./perf stat -a -I 1000 -e cycles,"cpu/config=0x6530160,name=krava/" record

/perf script -s test.py
event krava cpu -1, thread -1, time 1029898211, val 10959, ena
81192094638, run 81192094638
event krava cpu -1, thread -1, time 2043671594, val 10753, ena
81094362809, run 81094362809

does not work when using pipe

./perf stat -a -I 1000 -e cycles,"cpu/config=0x6530160,name=krava/"
record | ./perf script -s test.py

--- no output

Here the test.py

cat test.py
#!/usr/bin/env python

def stat__krava(cpu, thread, time, val, ena, run):
    print "event %s cpu %d, thread %d, time %d, val %d, ena %d, run %d" % \
          ("krava", cpu, thread, time, val, ena, run)


2016-02-03 8:48 GMT+01:00 Jiri Olsa <jolsa@redhat.com>:
> On Tue, Feb 02, 2016 at 05:24:16PM +0100, Andreas Hollmann wrote:
>> Jiri, how do you handle raw counters with this python stat__*
>> callback? What is the name of the callback?
>
> you can use 'name' term like:
>   perf stat -e cycles,"cpu/config=0x6530160,name=krava/"
>
> and use following callback in your script:
>   def stat__krava(cpu, thread, time, val, ena, run):
>
>>
>> Is there any documentation on that? Thanks!
>
> no.. ;-)
>
> I'll try to come up with something.. meanwhile please just ask,
> I'd be happy to help you
>
> thanks,
> jirka
