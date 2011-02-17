From: David Ahern <dsahern@gmail.com>
Subject: Re: perf record: mmap fails when specifying process/thread
Date: Wed, 16 Feb 2011 17:01:33 -0700
Message-ID: <4D5C655D.2000403@gmail.com>
References: <4D5BF0B1.7080602@gmail.com> <20110216235331.GC26039@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49585 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab1BQABh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Feb 2011 19:01:37 -0500
Received: by pwj3 with SMTP id 3so332791pwj.19
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Feb 2011 16:01:37 -0800 (PST)
In-Reply-To: <20110216235331.GC26039@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org



On 02/16/11 16:53, Arnaldo Carvalho de Melo wrote:
> Em Wed, Feb 16, 2011 at 08:43:45AM -0700, David Ahern escreveu:
>> Latest perf-core (pulled 5 minutes ago):
>>
>> # ps -C sshd
>>   PID TTY          TIME CMD
>>   961 ?        00:00:00 sshd
>>  1042 ?        00:00:00 sshd
>>
>> # /tmp/build-perf/perf record -v -fo/tmp/perf.data -p 1042
>>   Warning:  ... trying to fall back to cpu-clock-ticks
>>
>>   Fatal: failed to mmap with 22 (Invalid argument)
>>
>>
>> It works fine with -a argument and when a command is given, but fails
>> with the -p or -t argument.
> 
> In my radar, perf/urgent works tho, kinda made me lazy due to compound with
> unrelated company work :-\ Need to fix that ASAP.
> 
> - Arnaldo

Works in latest kernel git too. I looked at a diff of the tools between
the kernel tree and perf-core -- too many changes for me to wade through
right now.

BTW, it fails running the Fedora 14 kernel too, so my guess is a
userspace change.

David
