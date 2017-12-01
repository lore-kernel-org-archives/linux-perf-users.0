From: "Wangnan (F)" <wangnan0@huawei.com>
Subject: Re: Question to perf spending a large amount of time monitoring a
 java process
Date: Fri, 1 Dec 2017 16:03:25 +0800
Message-ID: <fdd35498-4678-7e0a-79b2-9a8ea604a0e0@huawei.com>
References: <20d3fa12-295c-84d3-2eae-aa32b5757d19@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:2242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750891AbdLAIDq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 1 Dec 2017 03:03:46 -0500
In-Reply-To: <20d3fa12-295c-84d3-2eae-aa32b5757d19@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: zhangmengting <zhangmengting@huawei.com>, linux-perf-users@vger.kernel.org
Cc: acme@redhat.com, namhyung@kernel.org, jolsa@redhat.com, huawei.libin@huawei.com, cj.chengjian@huawei.com, Andi Kleen <andi@firstfloor.org>

I have contacted Mengting by phone. My suggestion is listed below.

I think what she wants is generating data to do a top-down analysis on 
ARM64. Append Andi Kleen to cc list to see if he has any suggestion on it.

On 2017/12/1 15:32, zhangmengting wrote:
> Hi all,
>
> I found that perf spends a large amount of time attaching and monitoring
> a java process with lock, although the execution time of the java process
> is below 1 minute.
>
> Attachment 1(ContextSwitchTest.java) is the java source code used to
> reproduce the problem. The code is compiled and run with the following
> commands. The arguments of the process are <number of RUNS>
> (how many times the test code will be excuated) and <lock ITERATES>
> (how many times the thread acquires lock).
> With arguments <1, 1000000>, the execution time of the process is just 
> one minute.
>
> $javac ContextSwitchTest.java
>
> $java ContextSwitchTest
> Usage:
> java -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints 
> ContextSwitchTest  <number of RUNS>  <lock ITERATES>
> Example:
> java -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints 
> ContextSwitchTest 1 1000000
>
> I've tested the problem on both x86 and ARM64 platform with 4.14 
> kernel and 4.14 perf.
> And for convenience, I've add time check code to detect the execution 
> time for perf record.
> Attachment 2 is the time check patch 
> (0001-perf-record-add-execution-time-check-code.patch)
>
> The test result is shown below:
> 1) On x86 platform
> a. The execution time of this java process
> $java -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints 
> ContextSwitchTest 1 1000000
> RUNS : 1, ITERATES : 1000000
> Name : Thread-0, 21
> Name : Thread-1, 22
> parks: 979010
> parks: 978929
> Average time: 28642ns
> Total time: 56081313428ns = 56s
> b. The execution time of perf monitoring this process with several 
> event groups
> $perf record -N -B -T -g -e 
> '{cycles,r008,r01b,r10c,r009},{cycles,r100,r102,r107,r108},\
> {cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108},\ 
>
> {cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108},\ 
>
> {cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108},\ 
>
> {cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108}'\ 
>

There are too many event groups. It introduce heavy overhead to context 
switch, which
is the benchmark you are using. A '-a' may help to reduce event group 
switching
overhead.

> java -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints 
> ContextSwitchTest 1 1000000
> record_open_RUN is 0.235386s
> RUNS : 1, ITERATES : 1000000
> Name : Thread-0, 21
> Name : Thread-1, 22
> parks: 997895
> parks: 998116
> Average time: 72197ns
> Total time: 144107437593ns = 144s
> pollfd_RUN is 169.4294951967s
> [ perf record: Woken up 148 times to write data ]
> [ perf record: Captured and wrote 0.060 MB perf.data ]
> Record_RUN is 170.4294783665s
>
> 2) On ARM64 platform
> a. The execution time of this java process
> $java -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints 
> ContextSwitchTest 1 1000000
> RUNS : 1, ITERATES : 1000000
> Name : Thread-0, 24
> Name : Thread-1, 25
> parks: 977285
> parks: 977279
> Average time: 4708ns
> Total time: 9203640720ns = 9s
> b. The execution time of perf monitoring this process with several 
> event groups
> $perf record -N -B -T -g -e'{cycles,r008,r01b,r10c,r009,r010,r012},\
> {cycles,r100,r102,r107,r108,r076,r078},{cycles,r001,r002,r014,r179,r177},\ 
>
> {cycles,r121,r122,r123,r124,r125,r126},{cycles,r040,r042,r050,r052,r060,r061},\ 
>
> {cycles,r003,r004,r005,r016,r017},{cycles,r070,r071,r073,r074,r075,r077},\ 
>
> {cycles,r112,r113,r12c,r111,r120},{cycles,r06c,r06d,r06e,r07c,r07d,r07e},\ 
>
> {cycles,r150,r151,r152,r16a,r079,r07a}' \
> java -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints 
> ContextSwitchTest 1 1000000
> record_open_RUN is 0.40954s
> RUNS : 1, ITERATES : 1000000
> Name : Thread-0, 24
> Name : Thread-1, 25
> parks: 1008468
> parks: 1003826
> Average time: 1154505ns
> Total time: 2323208237220ns = 2323s
> pollfd_RUN is 2326.645806s
> [ perf record: Woken up 18463 times to write data ]
> [ perf record: Captured and wrote 6263.982 MB perf.data ]

Event frequency seems too high. Please try -F or -C to control data
rate. When using '-a', you need '--exclude-perf' to filter out those
events generated by perf itself.

To reduce IO overhead, you can increase ring buffer using '-m' or switch
to overwrite mode.

> Record_RUN is 2328.4294867157s
>
> The test result shows that perf consumes most of the time polling fds.
> In addtion, it seems that when tracing a great amount of events, perf may
> extend the execution time of the traced process, especially on ARM64 
> platform.
> A process that runs only 10 seconds now needs an hour execution time, 
> which is
> somewhat insane.
>
> I confuses that how perf affects the traced process and whether the
> final perf.data is still accurate since perf has affected the traced 
> process?
> Is there something wrong with perf?
>
> Thanks,
> Mengting Zhang
>
