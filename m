From: Andreas Hollmann <hollmann@in.tum.de>
Subject: Re: User defined metrics for perf stat?
Date: Tue, 2 Feb 2016 00:33:51 +0100
Message-ID: <CAGz0_-0k93OvSNgtnDMMTwYWxQuVnABqjfKC-KdmhGqv5H=C3A@mail.gmail.com>
References: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
	<20160201171540.GB20817@kernel.org>
	<20160201172755.GA27366@krava.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:48716 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750857AbcBAXd4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 1 Feb 2016 18:33:56 -0500
Received: (Authenticated sender: hollmann)
	by mail.in.tum.de (Postfix) with ESMTPSA id 48C911C248B
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Feb 2016 00:33:54 +0100 (CET)
Received: by mail-qk0-f179.google.com with SMTP id s5so58772130qkd.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Feb 2016 15:33:54 -0800 (PST)
In-Reply-To: <20160201172755.GA27366@krava.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Thanks, this is what I was looking for!

Why was the formula language abandoned? To restricted?
It would be still useful for interval prints.

perf stat record und perf stat report work,
but I get with perf script the following output/error. (Kernel 4.4,
perf 4.5-rc2)

$ perf script -s scripts/python/stat-cpi.py
Display of symbols requested but neither sample IP nor sample address
is selected. Hence, no addresses to convert to symbols.

2016-02-01 18:27 GMT+01:00 Jiri Olsa <jolsa@redhat.com>:
> On Mon, Feb 01, 2016 at 02:15:40PM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Sun, Jan 31, 2016 at 05:53:49PM +0100, Andreas Hollmann escreveu:
>> > Hi,
>> >
>> > is there any way to create user defined metrics in perf stat?
>> >
>> > Many hardware performance counters make only sense if you relate them
>> > to other counters, so it would be nice to have it in perf.
>>
>> I think what you want is the 'perf stat recording' feature that was
>> recently merged, contributed by Jiri Olsa, that I am CCing this reply.
>> Jiri, is there something still to be merged in that series?
>
> heya,
> nope.. everything is in ;-)
>
> Andreas,
> please check on the series changelog:
>   http://marc.info/?l=linux-kernel&m=145207742329050&w=2
>
> it describes the scripting usage together with
> stat recording/reporting
>
> let me know if you have other questions,
>
> thanks,
> jirka
