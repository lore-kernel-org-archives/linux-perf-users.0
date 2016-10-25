From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: perf bpf-output example program
Date: Tue, 25 Oct 2016 11:20:02 +0800
Message-ID: <580ECF62.8020900@huawei.com>
References: <alpine.DEB.2.20.1610231302040.27722@macbook-air>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:57565 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbcJYDXp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2016 23:23:45 -0400
In-Reply-To: <alpine.DEB.2.20.1610231302040.27722@macbook-air>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>, linux-perf-users@vger.kernel.org



On 2016/10/24 1:10, Vince Weaver wrote:
> Does anyone have a working perf bpf-output example program?
>
> The one from the original commit to the kernel
> 03e0a7df3efd959e40cd7ff40b1fabddc234ec5a
> does not work for me:
>
> sudo perf record -a -e bpf-output/no-inherit,name=evt/ -e
> ./test_bpf_output.c/map:channel:event=evt/ ls /

Sorry. the API has changed. You should use map:channel.event=evt,
not ...channel:event...

> WARNING:	unable to get correct kernel building directory.
> Hint:	Set correct kbuild directory using 'kbuild-dir' option in [llvm]
>       	section of ~/.perfconfig or set it to "" to suppress kbuild
>       	detection.
>
> event syntax error: './test_bpf_output.c/map:channel:event=evt/'
>                       \___ Failed to load program for unknown reason
>
> Vince
>

This is my test result:
  $ cat ~/.perfconfig
  [llvm]
    clang-path = "/tmp/oxygen_root/usr/bin/clang"
  $ sudo ./perf record -a -e bpf-output/no-inherit,name=evt/ -e 
./test_bpf_output.c/map:channel.event=evt/ ls /
  bin   cdrom  etc   initrd.img  lib32  libx32      media  opt root  
sbin  sys    usr  vmlinuz
  boot  dev    home  lib           lib64  lost+found  mnt     proc run   
srv   tmp    var
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Captured and wrote 0.772 MB perf.data (501 samples) ]

  $ sudo ~/perf script
             perf 15478 [001] 6571474.169705: 0                       
evt:  ffffffff81238c41 sys_write+0x1 (/lib/module
       BPF output: 0000: 23 b3 78 d3 b6 58 17 00  #.x..X..
                   0008: 01 00 00 00
  ....


But in your case it reports can't locate kbuild dir. Please fix it, or the
  #include <uapi/linux/bpf.h>
at the head of test-bpf-output.c causes failure.

Thank you.
