From: Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: Re: perf user SDT markers
Date: Tue, 14 Apr 2015 15:55:44 +0530
Message-ID: <552CEB28.80704@linux.vnet.ibm.com>
References: <CAE40pdf1Y3mQMnVi7jSBMg8ovg7x3L17jCf_yGemM_PLLG_k1g@mail.gmail.com> <CAE40pdcCMaO6Lih7enhkxLFdwsbSyDuPjoRbBJLa6arPEz5qYQ@mail.gmail.com> <552B8C1A.8030606@linux.vnet.ibm.com> <CAE40pde4qwGdz0pGocxMkieF6xaS2nizyehc-GDQ4J1+K_KeyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:34896 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276AbbDNK0j (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 14 Apr 2015 06:26:39 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <hemant@linux.vnet.ibm.com>;
	Tue, 14 Apr 2015 20:26:36 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5CB6E2CE8040
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2015 20:26:34 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3EAQQ2v46858260
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2015 20:26:34 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3EAQ0jY032508
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2015 20:26:00 +1000
In-Reply-To: <CAE40pde4qwGdz0pGocxMkieF6xaS2nizyehc-GDQ4J1+K_KeyQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Hi Brendan,

Thanks for the data.

On 04/13/2015 10:49 PM, Brendan Gregg wrote:
> G'Day Hemant,
>
> Thanks for testing; here's how I compiled node.js:
>
> # apt-get install -y systemtap-sdt-dev            # provides "dtrace"
> # git clone --depth 1 https://github.com/joyent/node
> # cd node
> # ./configure --with-dtrace
> # make

Thanks, I was able to see the error in my case too.
Will look into this as to why its failing to record on these using perf 
record -e "%node:gc__done", even after it creates an entry into the 
uprobe_events file :

# cat /sys/kernel/debug/tracing/uprobe_events
p:node/gc__done /home/hemant/node/out/Release/node:0x000000000081d354

> node readelf:
>
> # readelf -n node
>
> Notes at offset 0x00000254 with length 0x00000020:
>    Owner                 Data size    Description
>    GNU                  0x00000010    NT_GNU_ABI_TAG (ABI version tag)
>      OS: Linux, ABI: 2.6.24
>
> Notes at offset 0x00000274 with length 0x00000024:
>    Owner                 Data size    Description
>    GNU                  0x00000014    NT_GNU_BUILD_ID (unique build ID bitstring)
>      Build ID: 85dd5ef00ffde124f220b94c8a2b552d9274a89f
>
> Notes at offset 0x00c45fd8 with length 0x000004e4:
>    Owner                 Data size    Description
>    stapsdt              0x0000003c    NT_STAPSDT (SystemTap probe descriptors)
>      Provider: node
>      Name: gc__start
>      Location: 0x0000000000bf7894, Base: 0x0000000000f252de, Semaphore:
> 0x0000000001245fa8
>      Arguments: 4@%esi 4@%edx 8@%rdi
>    stapsdt              0x0000003a    NT_STAPSDT (SystemTap probe descriptors)
>      Provider: node
>      Name: gcstart
>      Location: 0x0000000000bf7895, Base: 0x0000000000f252de, Semaphore:
> 0x0000000001245faa
>      Arguments: 4@%esi 4@%edx 8@%rdi
>    stapsdt              0x0000003b    NT_STAPSDT (SystemTap probe descriptors)
>      Provider: node
>      Name: gc__done
>      Location: 0x0000000000bf78a4, Base: 0x0000000000f252de, Semaphore:
> 0x0000000001245fac
>      Arguments: 4@%esi 4@%edx 8@%rdi
>    stapsdt              0x0000005c    NT_STAPSDT (SystemTap probe descriptors)
> [...etc...]
>
> (the "gcstart" probe is one I added to test the underscore theory.)

On a separate issue, all the SDT markers here are using semaphore. And 
there is no support for markers with semaphores currently. Here is some 
old discussion on this:
https://sourceware.org/ml/systemtap/2013-q3/msg00236.html

We need to discuss this issue in more detail and find out a way to 
support those too.
So, even if the error wasn't being shown with the current patchset, perf 
wouldn't record any hit on the markers.

> Here's also the event files:
>
> # ls /sys/kernel/debug/tracing/events/node/
> enable        gc__start_11  gc__start_2  gcstart_5    http__server__request
> filter        gcstart_1_1   gcstart_2    gc__start_6  http__server__request_1
> gcstart       gc__start_12  gc__start_3  gcstart_6    http__server__request_2
> gc__start     gc__start_13  gcstart_3    gc__start_7  http__server__request_3
> gc__start_1   gc__start_14  gc__start_4  gcstart_7    http__server__request_4
> gcstart_1     gc__start_15  gcstart_4    gc__start_8  net__server__connection
> gc__start_10  gc__start_16  gc__start_5  gc__start_9  net__server__connection_1
>
> This is after several iterations of --add and --del. Something seems
> to be going wrong there. Thanks,

This is because perf is able to make an entry into the uprobe_events 
file, but since its throwing an error just after this, its not deleting 
that entry from the uprobe_events (which will delete the corresponding 
events from /sys/kernel/debug/tracing/events/node too).
Will certainly look into this.

> [SNIP]
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Thanks,
Hemant Kumar
