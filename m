From: taeung <treeze.taeung@gmail.com>
Subject: Re: [PATCH] modified error code when perf_session__new() fail
Date: Tue, 23 Sep 2014 15:23:38 +0900
Message-ID: <542111EA.7000405@gmail.com>
References: <541946D8.1080209@gmail.com> <1411227895.1690.23.camel@leonhard>	 <20140922134616.GC18187@krava.brq.redhat.com> <1411398687.1665.2.camel@leonhard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:46894 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbaIWGXx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 23 Sep 2014 02:23:53 -0400
Received: by mail-pa0-f41.google.com with SMTP id ey11so6688822pad.28
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2014 23:23:52 -0700 (PDT)
Received: from [192.168.1.43] ([106.245.241.10])
        by mx.google.com with ESMTPSA id i10sm11085365pdn.26.2014.09.22.23.23.51
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 22 Sep 2014 23:23:52 -0700 (PDT)
In-Reply-To: <1411398687.1665.2.camel@leonhard>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I forwarded the email according to 'git format-patch'.
Sorry for my terrible patch format. :-)
Because I didn't know how to send patch, I did it.

Thanks,
Taeung

On 09/23/2014 12:11 AM, Namhyung Kim wrote:
> Hi Jiri,
>
> 2014-09-22 (=EC=9B=94), 15:46 +0200, Jiri Olsa:
>> On Sun, Sep 21, 2014 at 12:44:55AM +0900, Namhyung Kim wrote:
>>> That being said I'm okay with the patch itself.  Jiri, this is what=
 you
>>> wanted to do, right?
>> I have some vague memories about this.. any link to refresh my memor=
y? ;-)
> This is it: https://lkml.org/lkml/2014/8/13/331
>
> Thanks,
> Namhyung
>
>
>> but right, the change seems ok
>>
>> jirka
>
>
