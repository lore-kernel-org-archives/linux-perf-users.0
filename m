From: David Ahern <dsahern@gmail.com>
Subject: Re: Perf event for Wall-time based sampling?
Date: Fri, 19 Sep 2014 08:55:43 -0600
Message-ID: <541C43EF.8090305@gmail.com>
References: <2221771.b2oSN5LR6X@milian-kdab2> <20140918203625.GM2770@kernel.org> <541C3B0B.3030706@gmail.com> <1423473.AV2A0F0SQn@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:48322 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbaISOzr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 19 Sep 2014 10:55:47 -0400
Received: by mail-pd0-f182.google.com with SMTP id g10so96029pdj.27
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Sep 2014 07:55:46 -0700 (PDT)
In-Reply-To: <1423473.AV2A0F0SQn@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@gmail.com>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>

On 9/19/14, 8:39 AM, Milian Wolff wrote:
>> This has been discussed before:
>> >     http://thread.gmane.org/gmane.linux.kernel/1307306
>> >
>> >Example on the perf wiki:
>> >      https://perf.wiki.kernel.org/index.php/Tutorial#Profiling_sleep_times
> Right, I also mentioned this in my initial email. This is_not_  what I want
> though:)

D'oh. missed that. And I did find a blurb on StackOverflow that distros 
are now disabling SCHEDSTATS so commands cannot rely on sched_stat 
tracepoints. Now I am glad I never converted my timehist command to rely 
on those.

David
