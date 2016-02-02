From: Andreas Hollmann <hollmann@in.tum.de>
Subject: Re: User defined metrics for perf stat?
Date: Tue, 2 Feb 2016 17:24:16 +0100
Message-ID: <CAGz0_-0HtuVf9XV1NZduHEtwz4nKJb8+Jib6_AksgAdG=pL=TA@mail.gmail.com>
References: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
	<20160201171540.GB20817@kernel.org>
	<20160201172755.GA27366@krava.redhat.com>
	<CAGz0_-0k93OvSNgtnDMMTwYWxQuVnABqjfKC-KdmhGqv5H=C3A@mail.gmail.com>
	<20160202085802.GA4257@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:42148 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755592AbcBBQYU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 2 Feb 2016 11:24:20 -0500
Received: (Authenticated sender: hollmann)
	by mail.in.tum.de (Postfix) with ESMTPSA id 6D77B1C2489
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Feb 2016 17:24:18 +0100 (CET)
Received: by mail-qg0-f46.google.com with SMTP id e32so153159988qgf.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Feb 2016 08:24:18 -0800 (PST)
In-Reply-To: <20160202085802.GA4257@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Jiri, how do you handle raw counters with this python stat__*
callback? What is the name of the callback?

Is there any documentation on that? Thanks!

./perf stat -e cycles,"cpu/config=0x6530160/" record kill
kill: not enough arguments

 Performance counter stats for 'kill':

         1,016,510      cycles
             3,445      cpu/config=0x6530160/

       0.001278590 seconds time elapsed

./perf script
CPU   THREAD             VAL             ENA             RUN
 TIME EVENT
 -1    18827         1016510          747877          747877
1278590 cycles
 -1    18827            3445          747877          747877
1278590 cpu/config=0x6530160/

2016-02-02 9:58 GMT+01:00 Jiri Olsa <jolsa@redhat.com>:
> On Tue, Feb 02, 2016 at 12:33:51AM +0100, Andreas Hollmann wrote:
>> Thanks, this is what I was looking for!
>>
>> Why was the formula language abandoned? To restricted?
>> It would be still useful for interval prints.
>
> yea the python script interface is way more powerful
> then whatever we would come with
>
>>
>> perf stat record und perf stat report work,
>> but I get with perf script the following output/error. (Kernel 4.4,
>> perf 4.5-rc2)
>>
>> $ perf script -s scripts/python/stat-cpi.py
>> Display of symbols requested but neither sample IP nor sample address
>> is selected. Hence, no addresses to convert to symbols.
>
> hum, what was the record command? so I could recreate..
>
> thanks,
> jirka
