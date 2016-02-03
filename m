From: Andreas Hollmann <hollmann@in.tum.de>
Subject: Re: User defined metrics for perf stat?
Date: Wed, 3 Feb 2016 12:43:48 +0100
Message-ID: <CAGz0_-31qWb_0B2T_fpBwxGQkeg+PSATPS=uS5Ui1fKc8sVyiQ@mail.gmail.com>
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
Received: from mail-out2.informatik.tu-muenchen.de ([131.159.0.36]:45204 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751056AbcBCLnx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 3 Feb 2016 06:43:53 -0500
Received: (Authenticated sender: hollmann)
	by mail.in.tum.de (Postfix) with ESMTPSA id 3074D1C248C
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Feb 2016 12:43:51 +0100 (CET)
Received: by mail-qk0-f178.google.com with SMTP id x1so6873883qkc.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Feb 2016 03:43:51 -0800 (PST)
In-Reply-To: <20160203074804.GA16045@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Thanks! Now it works.

Are there any other callbacks specific to the new functionality?

I saw this:

def stat__interval(time):
   ...

The name suggests that it is called once for each interval event entry?

Anything else?

Would it make sense to extend "perf script -g" to generate the callbacks?

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
