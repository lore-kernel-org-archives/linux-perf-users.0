From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: perf record: mmap fails when specifying process/thread
Date: Wed, 16 Feb 2011 21:53:31 -0200
Message-ID: <20110216235331.GC26039@ghostprotocols.net>
References: <4D5BF0B1.7080602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60216 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab1BPXxg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Feb 2011 18:53:36 -0500
Received: by yxt3 with SMTP id 3so870244yxt.19
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Feb 2011 15:53:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D5BF0B1.7080602@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Wed, Feb 16, 2011 at 08:43:45AM -0700, David Ahern escreveu:
> Latest perf-core (pulled 5 minutes ago):
> 
> # ps -C sshd
>   PID TTY          TIME CMD
>   961 ?        00:00:00 sshd
>  1042 ?        00:00:00 sshd
> 
> # /tmp/build-perf/perf record -v -fo/tmp/perf.data -p 1042
>   Warning:  ... trying to fall back to cpu-clock-ticks
> 
>   Fatal: failed to mmap with 22 (Invalid argument)
> 
> 
> It works fine with -a argument and when a command is given, but fails
> with the -p or -t argument.

In my radar, perf/urgent works tho, kinda made me lazy due to compound with
unrelated company work :-\ Need to fix that ASAP.

- Arnaldo
