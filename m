From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Sample memory references with at least a given latency?
Date: Thu, 05 Feb 2015 19:54:13 +0100
Message-ID: <54D3BC55.1050302@gmail.com>
References: <54D21524.8010305@bsc.es> <87bnl8jnwf.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:61844 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbbBESyR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 5 Feb 2015 13:54:17 -0500
Received: by mail-wi0-f178.google.com with SMTP id bs8so12596699wib.5
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2015 10:54:15 -0800 (PST)
In-Reply-To: <87bnl8jnwf.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>, Harald Servat <harald.servat@bsc.es>
Cc: linux-perf-users@vger.kernel.org

What information is present in the samples recorded by perf record (on 
which ocperf relies) ?

Manu

On 02/05/2015 05:58 PM, Andi Kleen wrote:
> Harald Servat <harald.servat@bsc.es> writes:
>
>>    is there any way to configure perf to sample memory references
>> through PEBS and enable the Load Latency Performance Monitoring
>> Facility (section 18.7.1.2 from the Intel 64 and IA-32 Architectures
>> Software Developer's Manual).
>
> $ ocperf.py record -e mem_trans_retired.load_latency_gt_128 -a sleep 1
> perf record -e
> cpu/event=0xcd,umask=0x1,ldlat=0x80,name=mem_trans_retired_load_latency_gt_128/
> -a sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.438 MB perf.data (~19125 samples) ]
>
