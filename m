From: Andreas Hollmann <hollmann@in.tum.de>
Subject: Re: User defined metrics for perf stat?
Date: Tue, 2 Feb 2016 10:42:06 +0100
Message-ID: <CAGz0_-1LicwyHVCGVyOLbmdyqAPv3dn_ZNCCuckYO9_7rpMpUg@mail.gmail.com>
References: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
	<20160201171540.GB20817@kernel.org>
	<20160201172755.GA27366@krava.redhat.com>
	<CAGz0_-0k93OvSNgtnDMMTwYWxQuVnABqjfKC-KdmhGqv5H=C3A@mail.gmail.com>
	<20160202085802.GA4257@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:52989 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754087AbcBBJmL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 2 Feb 2016 04:42:11 -0500
Received: (Authenticated sender: hollmann)
	by mail.in.tum.de (Postfix) with ESMTPSA id 082871C248C
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Feb 2016 10:42:09 +0100 (CET)
Received: by mail-qg0-f53.google.com with SMTP id b35so142743562qge.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Feb 2016 01:42:08 -0800 (PST)
In-Reply-To: <20160202085802.GA4257@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

It works! It was my fault I called the system wide version of perf
(4.4) with perf script and not (4.5-rc2).

Thanks!

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
