From: David Ahern <dsahern@gmail.com>
Subject: Re: BUG: perf kvm top --callgraph not showing callgraph
Date: Thu, 13 Jun 2013 19:10:46 -0600
Message-ID: <51BA6D96.5050004@gmail.com>
References: <CAPoQQ-2Xqms+FL=sfGKftgyMJsRKbS4+Fh8dV6Th-XjoqCBRjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39398 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab3FNBKy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 13 Jun 2013 21:10:54 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so46966iee.34
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2013 18:10:54 -0700 (PDT)
In-Reply-To: <CAPoQQ-2Xqms+FL=sfGKftgyMJsRKbS4+Fh8dV6Th-XjoqCBRjw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Cody P Schafer <devel-lists@codyps.com>
Cc: linux-perf-users@vger.kernel.org

On 6/13/13 7:04 PM, Cody P Schafer wrote:
> Hi all, I'm trying to use perf kvm to profile linux early boot.
>
> However, perf kvm top always appears to behave as though it's in
> non-callgraph mode.

During event collection perf kernel side does not walk the guest 
callchain. I believe it only collects IP.

David

>
> I dug through the code a bit, and it looks as though
> machine__resolve_challchain_sample() is getting called with an
> ip_callchain consistently containing only 2 entries:
> PERF_CONTEXT_KERNEL followed by PERF_CONTEXT_USER. This makes it
> appear that the perf_sample is not getting any callchain info from the
> kernel.
>
> System setup:
>
> I'm running qemu as follows:
>
> $ qemu-system-x86_64 -M pc -kernel ./bzImage  -drive
> file=./rootfs.ext2,if=virtio -append "root=/dev/vda console=ttyS0
> earlyprintk=ttyS0 debug numa=fake=2 kmemleak=on extra_nr_node_ids=100"
> -smp 8 -nographic -enable-kvm -s -m 64G
>
> And perf kvm top as follows:
> $  sudo ./perf kvm --guestvmlinux ~/vmlinux top --call-graph
>
> The host `uname -a` is
>       Linux pizza 3.7.10-gentoo-r1 #1 SMP Thu Apr 25 15:11:18 PDT 2013
> x86_64 Intel(R) Core(TM) i7-2720QM CPU @ 2.20GHz GenuineIntel
> GNU/Linux
>
> (And I've gotten the same results with 3.8.0-22-generic #33~precise1-Ubuntu).
>
> The guest kernel is v3.10-rc5 with some additional patches mostly to mm/*
>
> The version of the perf tool is 3.9.rc8.g25e33e (the version in
> linus's tree today).
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
