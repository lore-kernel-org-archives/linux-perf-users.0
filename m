From: Taeung Song <treeze.taeung@gmail.com>
Subject: Re: What unit is used by "period" for sleep time profiling?
Date: Wed, 24 Feb 2016 02:45:26 +0900
Message-ID: <56CC9AB6.1080902@gmail.com>
References: <2312924.dtc4z5l04H@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34146 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbcBWRpa (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 23 Feb 2016 12:45:30 -0500
Received: by mail-pf0-f170.google.com with SMTP id x65so115801928pfb.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Feb 2016 09:45:29 -0800 (PST)
In-Reply-To: <2312924.dtc4z5l04H@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>, perf group <linux-perf-users@vger.kernel.org>

Hi, Milian

On 02/23/2016 11:08 PM, Milian Wolff wrote:
> Hey all,
>
> following the "profiling sleep times" steps on the perf wiki at [1], we can
> get some "Period" numbers. The wiki e.g. shows a number of "502408738".

AFAIK,
When it comes to perf, "Period" means the number of occurrences
of an event, not the number of timer ticks.

The period is raw number of event count of sample.

Perf can collect partial samples from a lot of event
information(who/how much/when/etc.) or get all available samples.
(of course, there are some limits using actual hardware counters)

For example,

# perf record -e cycles -c 1000 sleep 5

As above, if -c option is used,
perf-record can collect a sample every 1000 occurrences
of event 'cycles' for 5 seconds. (sampling period = 1000)


Thanks,
Taeung
