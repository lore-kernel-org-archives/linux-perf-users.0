From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: perf user SDT markers
Date: Mon, 13 Apr 2015 10:19:50 -0700
Message-ID: <CAE40pde4qwGdz0pGocxMkieF6xaS2nizyehc-GDQ4J1+K_KeyQ@mail.gmail.com>
References: <CAE40pdf1Y3mQMnVi7jSBMg8ovg7x3L17jCf_yGemM_PLLG_k1g@mail.gmail.com>
 <CAE40pdcCMaO6Lih7enhkxLFdwsbSyDuPjoRbBJLa6arPEz5qYQ@mail.gmail.com> <552B8C1A.8030606@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37153 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932545AbbDMRUM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Apr 2015 13:20:12 -0400
Received: by igblo3 with SMTP id lo3so50010041igb.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2015 10:20:11 -0700 (PDT)
In-Reply-To: <552B8C1A.8030606@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day Hemant,

Thanks for testing; here's how I compiled node.js:

# apt-get install -y systemtap-sdt-dev            # provides "dtrace"
# git clone --depth 1 https://github.com/joyent/node
# cd node
# ./configure --with-dtrace
# make

node readelf:

# readelf -n node

Notes at offset 0x00000254 with length 0x00000020:
  Owner                 Data size    Description
  GNU                  0x00000010    NT_GNU_ABI_TAG (ABI version tag)
    OS: Linux, ABI: 2.6.24

Notes at offset 0x00000274 with length 0x00000024:
  Owner                 Data size    Description
  GNU                  0x00000014    NT_GNU_BUILD_ID (unique build ID bitstring)
    Build ID: 85dd5ef00ffde124f220b94c8a2b552d9274a89f

Notes at offset 0x00c45fd8 with length 0x000004e4:
  Owner                 Data size    Description
  stapsdt              0x0000003c    NT_STAPSDT (SystemTap probe descriptors)
    Provider: node
    Name: gc__start
    Location: 0x0000000000bf7894, Base: 0x0000000000f252de, Semaphore:
0x0000000001245fa8
    Arguments: 4@%esi 4@%edx 8@%rdi
  stapsdt              0x0000003a    NT_STAPSDT (SystemTap probe descriptors)
    Provider: node
    Name: gcstart
    Location: 0x0000000000bf7895, Base: 0x0000000000f252de, Semaphore:
0x0000000001245faa
    Arguments: 4@%esi 4@%edx 8@%rdi
  stapsdt              0x0000003b    NT_STAPSDT (SystemTap probe descriptors)
    Provider: node
    Name: gc__done
    Location: 0x0000000000bf78a4, Base: 0x0000000000f252de, Semaphore:
0x0000000001245fac
    Arguments: 4@%esi 4@%edx 8@%rdi
  stapsdt              0x0000005c    NT_STAPSDT (SystemTap probe descriptors)
[...etc...]

(the "gcstart" probe is one I added to test the underscore theory.)

Here's also the event files:

# ls /sys/kernel/debug/tracing/events/node/
enable        gc__start_11  gc__start_2  gcstart_5    http__server__request
filter        gcstart_1_1   gcstart_2    gc__start_6  http__server__request_1
gcstart       gc__start_12  gc__start_3  gcstart_6    http__server__request_2
gc__start     gc__start_13  gcstart_3    gc__start_7  http__server__request_3
gc__start_1   gc__start_14  gc__start_4  gcstart_7    http__server__request_4
gcstart_1     gc__start_15  gcstart_4    gc__start_8  net__server__connection
gc__start_10  gc__start_16  gc__start_5  gc__start_9  net__server__connection_1

This is after several iterations of --add and --del. Something seems
to be going wrong there. Thanks,

Brendan



On Mon, Apr 13, 2015 at 2:27 AM, Hemant Kumar <hemant@linux.vnet.ibm.com> wrote:
> Hi Brendan,
>
>
> On 04/13/2015 01:35 AM, Brendan Gregg wrote:
>>
>> On Sat, Apr 11, 2015 at 7:13 PM, Brendan Gregg
>> <brendan.d.gregg@gmail.com> wrote:
>>>
>>> G'Day,
>>>
>>> I was just trying Hemant Kumar's user SDT patch
>>> (http://lwn.net/Articles/618956/); anyone else tried it recently? I
>>> applied it to 4.0.0-rc6, and it creates instrumentation, but doesn't
>>> record the probes.
>>>
>>> This works (it finds the Node.js probes):
>>>
>>> # ./perf sdt-cache --dump
>>> /home/bgregg-testtest/node-standard/out/Release/node:
>>>     %node:net__server__connection
>>>     %node:net__stream__end
>>>     %node:net__socket__read
>>>     %node:net__socket__write
>>>     %node:http__server__request
>>>     %node:http__server__response
>>>     %node:http__client__request
>>>     %node:http__client__response
>>>     %node:gc__done
>>>     %node:gc__start
>>>
>>> But I can't "perf list" or record them:
>>>
>>> # ./perf record -e '%node:http__server__request' -aR
>>> invalid or unsupported event: '%node:http__server__request'
>>> Run 'perf list' for a list of valid events
>>> [...]
>>>
>>> stap works:
>>>
>>> # /root/systemtap-2.8/bin/stap -e 'probe
>>>
>>> process("/home/bgregg-testtest/node-standard/out/Release/node").mark("http__server__request")
>>> { println("hit"); }'
>>> hit
>>> hit
>>>
>>> Brendan
>>
>> Some more digging... So a simple C program with a DTRACE_PROBE1()
>> works, where the marker ends up being "%tick:loop":
>>
>> # ./perf record -e '%tick:loop' -a -g
>> [...]
>> ^C
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.334 MB perf.data (2 samples) ]
>>
>> But the %node markers don't work (eg, "%node:gc__start"). Maybe the
>> presence of underscores is breaking it? By adding some debug
>> statements, I dug this message out of yyparse(), which was failing:
>>
>> yyparse() yymsgbuf: syntax error, unexpected PE_NAME, expecting $end
>
>
> I rebased and tried the patches with perf for the latest tip:
>
> # ./perf sdt-cache --add /lib64/libc.so.6
>    8 events added for /lib64/libc.so.6
>
> # ./perf sdt-cache --dump
> /usr/lib64/libc-2.16.so:
>    %libc:setjmp
>    %libc:longjmp
>    %libc:longjmp_target
>    %libc:lll_futex_wake
>    %libc:lll_lock_wait_private
>    %libc:longjmp
>    %libc:longjmp_target
>    %libc:lll_futex_wake
>
>
> # ./perf record -e %libc:longjmp_target -aR sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.286 MB perf.data ]
>
> Its able to probe and record on %libc:longjmp_target with an underscore.
>
> Also, can you please point me to the node.js with SDT markers you are using
> and can you dump me the readelf -n /path/to/node.js o/p?
>
> --
> Thanks,
> Hemant Kumar
>
