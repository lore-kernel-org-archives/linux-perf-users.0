From: David Ahern <dsahern@gmail.com>
Subject: Re: Cross platform perf reporting
Date: Mon, 15 Aug 2016 10:08:44 -0600
Message-ID: <0b72dd07-0426-3542-a7f3-17d6ca3a0874@gmail.com>
References: <20160812153125.GK27651@kernel.org>
 <18625452.F1CIFXVKL2@milian-kdab2>
 <099059ce-5a77-b63e-679b-a6b4519f5ba7@gmail.com>
 <7508364.ZKHyXyzSjv@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36673 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbcHOQIs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 15 Aug 2016 12:08:48 -0400
Received: by mail-pf0-f193.google.com with SMTP id y134so3953447pfg.3
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Aug 2016 09:08:47 -0700 (PDT)
In-Reply-To: <7508364.ZKHyXyzSjv@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, hekuang@huawei.com, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>

On 8/15/16 9:22 AM, Milian Wolff wrote:
>> It should not open files outside of the symfs tree.
> 
> But apparently that is what happens.

sounds like a bug.

> 
>> If you note perf does find libc in the symfs 3 times but it is not finding
>> the symbol information it wants.
> 
> I only see that it fails to get addr2line debug information from paths 
> *outside* of the symfs: 
> 
> addr2line_init failed for /lib/arm-linux-gnueabihf/libc-2.19.so

that feature needs to handle symfs

> 
>>> To make things worse, it seems to break the buildid lookup, i.e. when you
>>> get samples in a file that you deployed manually to a target, which is
>>> not included in your sysroot that you pass to symfs:
>>>
>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> <snip>
>>> $ strace -e file -f perf report --symfs=/ssd/milian/projects/pandaboard/
>>> debian-8.5-minimal-armhf-2016-06-06/ --stdio -s sym,srcline |& grep
>>> particles
>>>
>>> open("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06/
>>> //
>>> root/particles", O_RDONLY) = -1 ENOENT (No such file or directory)
>>> stat("/root/particles", 0x7ffe7535bf40) = -1 EACCES (Permission denied)
>>> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06/
>>> //
>>> root/particles", 0x7ffe7535bec0) = -1 ENOENT (No such file or directory)
>>> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06/
>>> //
>>> usr/lib/debug/root/particles.debug", 0x7ffe7535bf40) = -1 ENOENT (No such
>>> file or directory)
>>> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06/
>>> //
>>> usr/lib/debug/root/particles", 0x7ffe7535bf40) = -1 ENOENT (No such file
>>> or
>>> directory)
>>> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06/
>>> //
>>> root/particles", 0x7ffe7535bf40) = -1 ENOENT (No such file or directory)
>>> stat("/ssd/milian/projects/pandaboard/debian-8.5-minimal-armhf-2016-06-06/
>>> //
>>> root/.debug/particles", 0x7ffe7535bf40) = -1 ENOENT (No such file or
>>> directory)
>>> /root/particles with build id 1c10a17afa25337ab368f8d9e690184e536c6563 not
>>> found, continuing without symbols
>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Note how the above does not look for the buildid in my ~/.debug anymore...
>>
>> With symfs every file should be below the symfs root directory, including
>> build id files.
> 
> So I should unpack the perf archive on top of my sysroot?

Not if it contains differences.

> 
> That sounds like a bad idea, considering that I would then get clashes between 
> e.g. the actual /lib/libc.so.6 in my sysroot and the debug info that is in a 
> folder called /lib/libc.so.6/ in ~/.debug. And from the strace output above, 
> it does not look like perf would look into a .debug folder directly in 
> $symfs/.

I thought someone just added support for that.

> It also does not seem to be possible to pass multiple symfs directories, which 
> could also solve the issue for me. I.e. pass both a path to the sysroot, and 
> an additional path to wherever I unpacked the perf archive to.

When I added the symfs option back in 2010 it was to support many, many versions of embedded images. The images may start with the same sysroot (e.g., system files from the OS vendor) but will differ dramatically with locally built files.

I had a script that took the Wind River sysroot and copied to a tmp directory, added debug files for the system binaries and libraries, and then overlayed the locally built files which contained symbols and kernel files. From there perf would only open files in that directory.

When done, rm -rf tmp_dir and all remnants of that image were gone. I specifically did not want to manage everything in ~/.debug when you consider N variants of images (images you build, co-workers builds, project builds, official builds, etc) and all of those changing on a nearly daily basis.
