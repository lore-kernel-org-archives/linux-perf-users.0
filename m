From: David Ahern <dsahern@gmail.com>
Subject: Re: Cross platform perf reporting
Date: Mon, 15 Aug 2016 08:42:12 -0600
Message-ID: <099059ce-5a77-b63e-679b-a6b4519f5ba7@gmail.com>
References: <20160812153125.GK27651@kernel.org>
 <18625452.F1CIFXVKL2@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35180 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbcHOOm0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 15 Aug 2016 10:42:26 -0400
Received: by mail-pf0-f196.google.com with SMTP id h186so3841239pfg.2
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Aug 2016 07:42:25 -0700 (PDT)
In-Reply-To: <18625452.F1CIFXVKL2@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, hekuang@huawei.com

On 8/15/16 6:20 AM, Milian Wolff wrote:
>> That is the --symfs David talked about, no?
>>
>> [acme@jouet linux]$ perf report -h symfs
>>
>>  Usage: perf report [<options>]
>>
>>         --symfs <directory>
>>                           Look for files with symbols relative to this
>> directory
> 
> Yes, symfs sounds exactly like what I was looking for. I have now tested this, 
> and seem to hit some issues with it:

-----8<-----

> 
> Setting symfs:
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> milian@milian-kdab2:/tmp$ locate libc-2.19.so
> /home/milian/.debug/lib/arm-linux-gnueabihf/libc-2.19.so
> /home/milian/.debug/lib/arm-linux-gnueabihf/libc-2.19.so/
> 457c5918872338e1b82bf8bf41ae9f55b34604ea
> /home/milian/.debug/lib/arm-linux-gnueabihf/libc-2.19.so/
> 457c5918872338e1b82bf8bf41ae9f55b34604ea/elf
> /home/milian/.debug/lib/arm-linux-gnueabihf/libc-2.19.so/
> 457c5918872338e1b82bf8bf41ae9f55b34604ea/probes
> /ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06/lib/arm-
> linux-gnueabihf/libc-2.19.so
> milian@milian-kdab2:/tmp$ strace -e file -f perf report --symfs=/ssd/milian/
> projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06/ --stdio -s 
> sym,srcline |& grep libc-2.19
> open("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = 8
> stat("/lib/arm-linux-gnueabihf/libc-2.19.so", 0x7ffc4da5e740) = -1 ENOENT (No 
> such file or directory)
> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> lib/arm-linux-gnueabihf/libc-2.19.so", {st_mode=S_IFREG|0755, st_size=911068, 
> ...}) = 0
> open("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = 9
> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> lib/arm-linux-gnueabihf/libc-2.19.so", {st_mode=S_IFREG|0755, st_size=911068, 
> ...}) = 0
> open("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = 9
> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> usr/lib/debug/lib/arm-linux-gnueabihf/libc-2.19.so.debug", 0x7ffc4da5e740) = 
> -1 ENOENT (No such file or directory)
> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> usr/lib/debug/lib/arm-linux-gnueabihf/libc-2.19.so", 0x7ffc4da5e740) = -1 
> ENOENT (No such file or directory)
> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> lib/arm-linux-gnueabihf/libc-2.19.so", {st_mode=S_IFREG|0755, st_size=911068, 
> ...}) = 0
> open("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = 10
> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> lib/arm-linux-gnueabihf/.debug/libc-2.19.so", 0x7ffc4da5e740) = -1 ENOENT (No 
> such file or directory)
> open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
> file or directory)
> addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
> open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
> file or directory)
> addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
> open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
> file or directory)
> addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
> open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
> file or directory)
> addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
> open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
> file or directory)
> addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
> open("/lib/arm-linux-gnueabihf/libc-2.19.so", O_RDONLY) = -1 ENOENT (No such 
> file or directory)
> addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so
>      0.25%     0.25%  [.] 0x000000000005336c  libc-2.19.so[5336c]
>      0.25%     0.00%  [.] 0xffffffff4936136c  libc-2.19.so[ffffffff4936136
>      0.24%     0.24%  [.] 0x0000000000053422  libc-2.19.so[53422]
>      0.24%     0.00%  [.] 0xffffffff49361422  libc-2.19.so[ffffffff4936142
>      0.21%     0.21%  [.] 0x0000000000053664  libc-2.19.so[53664]
>      0.21%     0.00%  [.] 0xffffffff49361664  libc-2.19.so[ffffffff4936166
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Note how it does look into symfs sometimes, but not everywhere...

It should not open files outside of the symfs tree.

If you note perf does find libc in the symfs 3 times but it is not finding the symbol information it wants.


> 
> To make things worse, it seems to break the buildid lookup, i.e. when you get 
> samples in a file that you deployed manually to a target, which is not 
> included in your sysroot that you pass to symfs:
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> $ perf report --stdio -s sym,srcline |& grep particles
>     34.79%    34.79%  [.] main                     particles.cpp:34
>     32.62%    32.62%  [.] main                     particles.cpp:33
>      9.85%     9.85%  [.] main                     particles.cpp:32
> $ perf report --symfs=/ssd/milian/projects/pandaboard/debian-8.5-minimal-
> armhf-2016-06-06/ --stdio -s sym,srcline |& grep particles
> /root/particles with build id 1c10a17afa25337ab368f8d9e690184e536c6563 not 
> found, continuing without symbols
> addr2line_init failed for /root/particles
> # above line is repeated a lot
>     26.99%    26.99%  [.] 0x00000000000005a4  particles[5a4]
>     26.99%     0.00%  [.] 0xffffffffffff05a4  particles[ffffffffffff05a4]
>     21.83%    21.83%  [.] 0x00000000000005a6  particles[5a6]
>     21.83%     0.00%  [.] 0xffffffffffff05a6  particles[ffffffffffff05a6]
>     14.55%     0.00%  [.] 0xffffffffffff0596  particles[ffffffffffff0596]
>     14.54%    14.54%  [.] 0x0000000000000596  particles[596]
> ...
> $ strace -e file -f perf report --symfs=/ssd/milian/projects/pandaboard/
> debian-8.5-minimal-armhf-2016-06-06/ --stdio -s sym,srcline |& grep particles 
> 
> open("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> root/particles", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat("/root/particles", 0x7ffe7535bf40) = -1 EACCES (Permission denied)
> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> root/particles", 0x7ffe7535bec0) = -1 ENOENT (No such file or directory)
> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> usr/lib/debug/root/particles.debug", 0x7ffe7535bf40) = -1 ENOENT (No such file 
> or directory)
> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> usr/lib/debug/root/particles", 0x7ffe7535bf40) = -1 ENOENT (No such file or 
> directory)
> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> root/particles", 0x7ffe7535bf40) = -1 ENOENT (No such file or directory)
> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06///
> root/.debug/particles", 0x7ffe7535bf40) = -1 ENOENT (No such file or 
> directory)
> /root/particles with build id 1c10a17afa25337ab368f8d9e690184e536c6563 not 
> found, continuing without symbols
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Note how the above does not look for the buildid in my ~/.debug anymore...

With symfs every file should be below the symfs root directory, including build id files.
