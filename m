From: David Ahern <dsahern@gmail.com>
Subject: Re: perf CPU profiling in Xen guest fail & workaround
Date: Wed, 29 Jul 2015 13:15:45 -0600
Message-ID: <55B92661.7010309@gmail.com>
References: <CAE40pdd6Ab9w1da7ztwed+h9NUbtLyqiC1-tarrGQsFo2MrmzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36721 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbbG2TPs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Jul 2015 15:15:48 -0400
Received: by pdjr16 with SMTP id r16so10773619pdj.3
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2015 12:15:48 -0700 (PDT)
In-Reply-To: <CAE40pdd6Ab9w1da7ztwed+h9NUbtLyqiC1-tarrGQsFo2MrmzQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 7/29/15 1:04 PM, Brendan Gregg wrote:
> G'Day perf users,
>
> I just debugged something and wanted to share in case others hit
> this... perf CPU profiling didn't work for this Linux 4.1 guest (AWS
> EC2):
>
> # ./perf record -F 99 -a -g -- sleep 5
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.300 MB perf.data ]
> # ./perf script
> #
>
> There are no CPU samples recorded (perf.data just has
> PERF_RECORD_MMAP, etc). I believe it's because it's using the "cycles"
> PMC event, and not "cpu-clock". And cycles is bogus:
>
> # ./perf stat -e cycles -a sleep 1 2>&1 | grep cycles
>      68,719,476,704      cycles
> # ./perf stat -e cycles -a sleep 2 2>&1 | grep cycles
>      68,719,476,704      cycles
>
> I can fix it by profiling cpu-clock:
>
> # ./perf record -e cpu-clock -a -g -- sleep 5
> [ perf record: Woken up 27 times to write data ]
> [ perf record: Captured and wrote 9.884 MB perf.data (105989 samples) ]
> # ./perf script
> [...data...]
>
> Which is what I think all my other systems are doing anyway; some perf
> -v -v output from those other systems:
>
> [...]
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -2
> Warning:
> The cycles event is not supported, trying to fall back to cpu-clock-ticks
> [...]
>
> This 4.1 system has these:
>
> # cat /sys/devices/cpu/events/cpu-cycles
> event=0x3c
>
> Which other systems don't. Profiling these (eg, -e r003c) also doesn't work.
>
> So I can use "-e cpu-clock", which is fine. It even lets me set the
> profile frequency:
>
> # ./perf record -F 99 -e cpu-clock -a -- sleep 1
>
> Maybe this issue is already known and fixed in latest. I couldn't find
> anything in a search...
>

It's a known problem with VMs (Solaris based ldoms and apparently xen 
guests as examples). The hypervisor tells perf it has a PMU (see dmesg | 
grep Performance) but does not really implement it (no NMIs for example).

David
