From: David Ahern <dsahern@gmail.com>
Subject: Re: Perf event for Wall-time based sampling?
Date: Fri, 19 Sep 2014 08:17:47 -0600
Message-ID: <541C3B0B.3030706@gmail.com>
References: <2221771.b2oSN5LR6X@milian-kdab2> <2297882.Vc1x1zOfA6@milian-kdab2> <20140918155745.GH2770@kernel.org> <45528931.El8SOGvs6Z@milian-kdab2> <20140918191713.GK2770@kernel.org> <541B3DED.1010306@gmail.com> <20140918203625.GM2770@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:55781 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146AbaISORu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 19 Sep 2014 10:17:50 -0400
Received: by mail-pa0-f49.google.com with SMTP id lf10so196376pab.22
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Sep 2014 07:17:49 -0700 (PDT)
In-Reply-To: <20140918203625.GM2770@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Milian Wolff <mail@milianw.de>, linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@gmail.com>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>

On 9/18/14, 2:36 PM, Arnaldo Carvalho de Melo wrote:

> Ok, so you want to see what is the wait channel and unwind the stack
> from there? Is that the case? I.e. again, a sysrq-t equivalent?
>
>> Milian want is to grab samples every timer expiration even if process is not
>> running.
>
> What for? And by "grab samples" you want to know where it is waiting for
> something, together with its callchain?
>
>> Any limitations that would prevent doing this with a sw event? e.g, mimic
>> task-clock just don't disable the timer when the task is scheduled out.
>
> I'm just trying to figure out if what people want is a complete
> backtrace of all threads in a process, no matter what they are doing, at
> some given time, i.e. at "sysrq-t" time, is that the case?

This has been discussed before:
    http://thread.gmane.org/gmane.linux.kernel/1307306

Example on the perf wiki:
     https://perf.wiki.kernel.org/index.php/Tutorial#Profiling_sleep_times


David
