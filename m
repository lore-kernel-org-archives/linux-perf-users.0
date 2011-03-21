From: Lin Ming <minggr@gmail.com>
Subject: Re: What perf_event_paranoid can do?
Date: Mon, 21 Mar 2011 21:46:35 +0800
Message-ID: <AANLkTik3FT02nBPoKRh66hGA+bT7dPe2Vc0DK9HNmu7C@mail.gmail.com>
References: <20110321061435.GA52815@cs.nctu.edu.tw>
	<AANLkTimJ36H76Z77AmauMWtZ9hOM62X1Y2jJa5H6fxWa@mail.gmail.com>
	<20110321095643.GA57074@cs.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38557 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab1CUNuk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Mar 2011 09:50:40 -0400
Received: by iwn34 with SMTP id 34so6398778iwn.19
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Mar 2011 06:50:40 -0700 (PDT)
In-Reply-To: <20110321095643.GA57074@cs.nctu.edu.tw>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, =?UTF-8?B?6Zmz6Z+L5Lu7?= <chenwj@iis.sinica.edu.tw>

2011/3/21 =B3=AF=AD=B3=A5=F4 <chenwj@iis.sinica.edu.tw>:
> Hi, Lin
>
>> It's used to control if some action is allowed or not for normal use=
r.
>> See comments at kernel/perf_event.c:
>>
>> /*
>>  * perf event paranoia level:
>>  *  -1 - not paranoid at all
>>  *   0 - disallow raw tracepoint access for unpriv
>>  *   1 - disallow cpu events for unpriv
>>  *   2 - disallow kernel profiling for unpriv
>>  */
>
>  I assume -1 give normal user the most high level privilege,
> but it doesn't work. I have tried -1 through 2, but none of
> them works. Any suggestion? Or maybe the event "branches" does
> not support PBES modifier (pp)?

In x86_setup_perfctr:

        /*
         * Branch tracing:
         */
        if ((attr->config =3D=3D PERF_COUNT_HW_BRANCH_INSTRUCTIONS) &&
            (hwc->sample_period =3D=3D 1)) {
                /* BTS is not supported by this architecture. */
                if (!x86_pmu.bts_active)
                        return -EOPNOTSUPP;

                /* BTS is currently only allowed for user-mode. */
                if (!attr->exclude_kernel)
                        return -EOPNOTSUPP;
        }

Does your CPU support PEBS? Please attach below output.

dmesg |grep "Performance Events"

Lin Ming

>
>  Thanks!
>
> Regards,
> chenwj
>
> --
> Wei-Ren Chen (=B3=AF=AD=B3=A5=F4)
> Parallel Processing Lab, Institute of Information Science,
> Academia Sinica, Taiwan (R.O.C.)
> Tel:886-2-2788-3799 #1667
>
