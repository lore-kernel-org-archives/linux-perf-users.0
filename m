From: David Ahern <dsahern@gmail.com>
Subject: Re: How can I get the number of Generic counters and Fixed Counters
 in A computer
Date: Wed, 26 Jun 2013 13:18:15 -0600
Message-ID: <51CB3E77.7030704@gmail.com>
References: <CAEuYUep2MwCdvWxjJKqSjLvTWPPdE6QTzUS-0AXkSnHBFiYYfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:41506 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab3FZTST (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Jun 2013 15:18:19 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so14627035pad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2013 12:18:18 -0700 (PDT)
In-Reply-To: <CAEuYUep2MwCdvWxjJKqSjLvTWPPdE6QTzUS-0AXkSnHBFiYYfQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peipei Wang <wangpeipei.90@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

On 6/26/13 1:00 PM, Peipei Wang wrote:
> Hi all,
>
> I see from Perf wiki that if i put too many events in a perf stat,
> there will be something called multiplexing and scaling because of the
> number of counters provided by PMU. That wiki gives the Generic
> counter and Fixed counters For Intel Core and Nehalem.
>
> Does anybody know how to find the number of Both counters for Other
> processors?? Mine is Xelon.

Check the output of 'dmesg | grep -A 10 Perf'. e.g.,

[    0.140962] Performance Events: PEBS fmt1+, 16-deep LBR, Westmere 
events, Intel PMU driver.
[    0.141302] perf_event_intel: CPUID marked event: 'bus cycles' 
unavailable
[    0.141412] ... version:                3
[    0.141516] ... bit width:              48
[    0.141623] ... generic registers:      4
[    0.141732] ... value mask:             0000ffffffffffff
[    0.141842] ... max period:             000000007fffffff
[    0.141958] ... fixed-purpose events:   3
[    0.142065] ... event mask:             000000070000000f

David
