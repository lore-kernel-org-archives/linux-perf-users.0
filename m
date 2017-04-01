From: Benjamin King <benjaminking@web.de>
Subject: Re: How to sample memory usage cheaply?
Date: Sat, 1 Apr 2017 09:41:12 +0200
Message-ID: <20170401074112.GA8989@localhost>
References: <20170330200404.GA1915@localhost>
 <2288291.HPAjuFhd8F@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:61070 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbdDAHlQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 1 Apr 2017 03:41:16 -0400
Content-Disposition: inline
In-Reply-To: <2288291.HPAjuFhd8F@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Hi!

On Fri, Mar 31, 2017 at 02:06:28PM +0200, Milian Wolff wrote:
>> I'd love to analyze page faults a bit before continuing with the more
>> expensive tracing of malloc and friends.
>
>I suggest you try out my heaptrack tool.

I did! Also the heap profiler from google perftools and a homegrown approach
using uprobes on malloc, free, mmap and munmap. My bcc-fu is too weak to do
me any good right now. The workload that I am working with takes a few hours
to generate, however, so more overhead means a lot of latency to observe the
effect of changes that I do.

I guess that the issue I am facing currently is a bit more fundamental, since I
don't have a good way to trace/sample instances where my process is using a
page of physical memory *for the first time*. Bonus points to detect when the
use count on behalf of my process drops to zero.

I'd like to tell these events apart from instances where I am using the same
physical page from more than one virtual page. It feels like there should be
a way to do so, but I don't know how.

Also, the 'perf stat' output that I sent does not make much sense to me right
now. For example, when I add MAP_POPULATE to the flags for mmap, I only see
~40 minor page faults, which I do not understand at all.

>> This makes sense, but how can I measure physical memory properly, then?
>> Parsing the Pss-Rows in /proc/<pid>/smaps does work, but seems a bit clumsy.
>> Is there a better way (e.g. with callstacks) to measure physical memory
>> growth for a process?
>
From what I understand, wouldn't you get this by tracing sbrk + mmap with call
>stacks?

No, not quite, since different threads in my process mmap the same file. This
counts them twice in terms of virtual memory but I'm interested in the load
on physical memory.


> Do note that file-backed mmaps can be shared across processes, so
>you'll have to take that into account as done for Pss.  But in my experience,
>when you want to improve a single application's memory consumption, it usually
>boils down to non-shared heap memory anyways. I.e. sbrk and anon mmaps.

True, and that's what I'm after, eventually, but the multiple mappings skew
the picture a bit right now.

To make progress, I need to figure out how to properly measure physical
memory usage more.

>But if you look at the callstacks for these syscalls, they usually point at
>the obvious places (i.e. mempools), but you won't see what is _actually_ using
>the memory of these pools. Heaptrack or massif is much better in that regard.

>
>Hope that helps, happy profiling!

Thanks,
  Benjamin


>
>> PS:
>>  Here is some measurement with a leaky toy program. It uses a 1GB
>> zero-filled file and drops file system caches prior to the measurement to
>> encourage major page faults for the first mapping only. Does not work at
>> all: -----
>> $ gcc -O0 mmap_faults.c
>> $ fallocate -z -l $((1<<30)) 1gb_of_garbage.dat
>> $ sudo sysctl -w vm.drop_caches=3
>> vm.drop_caches = 3
>> $ perf stat -eminor-faults,major-faults ./a.out
>>
>>  Performance counter stats for './a.out':
>>
>>             327,726      minor-faults
>>                   1      major-faults
>> $ cat mmap_faults.c
>> #include <fcntl.h>
>> #include <sys/mman.h>
>> #include <unistd.h>
>>
>> #define numMaps 20
>> #define length 1u<<30
>> #define path "1gb_of_garbage.dat"
>>
>> int main()
>> {
>>   int sum = 0;
>>   for ( int j = 0; j < numMaps; ++j )
>>   {
>>     const char *result =
>>       (const char*)mmap( NULL, length, PROT_READ, MAP_PRIVATE,
>>           open( path, O_RDONLY ), 0 );
>>
>>     for ( int i = 0; i < length; i += 4096 )
>>       sum += result[ i ];
>>   }
>>   return sum;
>> }
>> -----
>> Shouldn't I see ~5 Million page faults (20GB/4K)?
>> Shouldn't I see more major page faults?
>> Same thing when garbage-file is filled from /dev/urandom
>> Even weirder when MAP_POPULATE'ing the file
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users"
>> in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>-- 
>Milian Wolff | milian.wolff@kdab.com | Software Engineer
>KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
>Tel: +49-30-521325470
>KDAB - The Qt Experts
