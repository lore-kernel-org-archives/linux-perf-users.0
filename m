From: Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: kernel/perf: Sample data being lost
Date: Wed, 22 Apr 2020 16:42:06 +0200
Message-ID: <89099efe-638e-e4e4-e008-b475bf064d99@linux.ibm.com>
References: <f09e62d0-af40-683a-648f-3c3b7137369b@linux.ibm.com>
 <20200421155946.GB12295@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200421155946.GB12295@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On 4/21/20 5:59 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Apr 21, 2020 at 05:54:29PM +0200, Thomas Richter escreveu:
>> Since a couple of days I see this warning popping up very often:
>>
>> [root@m35lp76 perf]# ./perf record --call-graph dwarf -e rb0000 -- find /
>> [ perf record: Woken up 282 times to write data ]
>> Warning:
>> Processed 16999 events and lost 382 chunks!
>>
>> Check IO/CPU overload!
>>
>> [ perf record: Captured and wrote 125.730 MB perf.data (16219 samples) ]
>> [root@m35lp76 perf]#
>>
>> The machine is idle, its my development system, so not much going on.
>> It also happens using a software event, for example cycles. It shows
>> up more often, the larger the sample size is. So for example:
>>
>> [root@m35lp76 perf]# pwd
>> /root/linux/tools/perf
>> [root@m35lp76 perf]#  ./perf record  --call-graph dwarf -- find
>> [ perf record: Woken up 2 times to write data ]
>> Warning:
>> Processed 231 events and lost 7 chunks!
>>
>> Check IO/CPU overload!
>>
>> [ perf record: Captured and wrote 1.000 MB perf.data (130 samples) ]
>> [root@m35lp76 perf]#
>>
>> I have very seldom observed this before, only in extremely rare cases with
>> a heavily loaded machine. I am wondering what has changed, I haven't
>> changed anything in the s390 PMU device drivers.
>> It could be
>>  - common kernel code when writing into the ringbuffer.
>>  - the perf tool too slow to read data from the mapped buffer
>>    However I have not come across changes in this area.
>>
>> Has anybody observed similar issue?
>>
>> PS: I have added some printk messages into my PMU devices drivers.
>> I have seen messages that the 16384 pages for auxilary buffers are full
>> and that samples have been dropped.
> 
> Can you try to bisect tools/perf?
> 
> Something like:
> 
> git checkout v5.4
> 
> build it, no problems? Use it as the 'git bisect good' starting point.
> 
> - Arnaldo
> 

I think this was my fault. The samples with call-graphs are large and I forgot
to increase the mapped ringbuffer with the -m option.
So the buffer default size is 128 pages (516kb) which fills quite quickly.

Sorry for the noise.

I also realized this status line running perf top

Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)

It shows up after ca 1 minutes on an idle system.
I guess this is the sane root cause?
-- 
Thomas Richter, Dept 3252, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
