From: Alen Stojanov <astojanov@inf.ethz.ch>
Subject: Re: Some troubles with perf and measuring flops
Date: Thu, 6 Mar 2014 02:53:03 +0100
Message-ID: <5317D4FF.1030302@inf.ethz.ch>
References: <5317C76A.4050103@inf.ethz.ch> <alpine.DEB.2.10.1403052036580.22262@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from edge20.ethz.ch ([82.130.99.26]:5258 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932093AbaCFBsE (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Mar 2014 20:48:04 -0500
In-Reply-To: <alpine.DEB.2.10.1403052036580.22262@vincent-weaver-1.um.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org

On 06/03/14 02:40, Vince Weaver wrote:
> On Thu, 6 Mar 2014, Alen Stojanov wrote:
>
>> However, whenever I try to run matrices of bigger size, the reported flops are
>> not even close to the flops that I am supposed to obtain (anticipated results:
>> 600 * 600 * 600 * 2 = 432'000'000):
>>
>> perf stat -e r538010 ./mmmtest 600
>>
>>   Performance counter stats for './mmmtest 600':
>>
>>       2,348,148,851 r538010
>>
>>         0.955511968 seconds time elapsed
>>
> ...
>> CPU: Intel(R) Xeon(R) CPU E5-2643 0 @ 3.30GHz, 8 cores
>> Linux Kernel: 3.11.0-12-generic
>> GCC Version: gcc version 4.8.1 (Ubuntu/Linaro 4.8.1-10ubuntu8)
>> Monitored events: FP_COMP_OPS_EXE:SSE_SCALAR_DOUBLE - Raw event: 0x538010
>> (converted using libpfm4)
> ...
>> Do you know why does this happens ? How can I instruct perf to obtain accurate
>> results ?
> one thing you might want to do is put :u on your event name so you are
> only measuring user space accesses not kernel too.
Well, even if the perf is measuring kernel events, I really doubt that 
the kernel is doing any double precision floating point operations. 
Nevertheless, I tried the :u option, and this does not change anything:

perf stat -e r538010:u ./mmmtest 100

  Performance counter stats for './mmmtest 100':

          2,079,002 r538010:u

        0.003887873 seconds time elapsed


perf stat -e r538010:u ./mmmtest 600

  Performance counter stats for './mmmtest 600':

      2,349,426,507 r538010:u

        0.956538237 seconds time elapsed

>
> floating point events are notoriously unreliable on modern intel
> processors.
>
> The event might also be counting speculative events or uops and it gets
> more complicated with AVX in the mix.  What does the intel documentation
> say for the event for your architecture?
I agree on this. However, if you would look at the .s file, you can see 
that it does not have any AVX instructions inside. And if I would 
monitor any other event on the CPU that counts any flop operations, I 
get 0s. It seems that the FP_COMP_OPS_EXE:SSE_SCALAR_DOUBLE is the only 
one that occurs. I don't think that FP_COMP_OPS_EXE:SSE_SCALAR_DOUBLE 
counts speculative events.
>
> Vince
