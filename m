Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696EDC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Apr 2022 03:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiDODQi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Apr 2022 23:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349049AbiDODQg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Apr 2022 23:16:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BDB9D0E6
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Apr 2022 20:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649992447; x=1681528447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NTWPu8DICpIQoIWgcdTMt1fL2PvXCnUYMogJxeeK5Uc=;
  b=a/iVwR9SvJyvugBwukcScgOrdtZ9FwoFLTMYH3iZT1yo0bD35sM8cp5r
   2J0rBv+4dZwl+4b1xhxYtPcjwE/6Vtr0D/lSb0IbE3mdvH9DFNkQod0xC
   RP/zRZDRKwKAM+ZC/Ks9VpfFysaIG/xuQnwH5coP+3vJLzCpSKzPRbB2B
   IyjeSmlCqG2GdEk7K53KXH9p1ouos8QBYDc81+tKbSRHF5ElDT39mmMES
   Aq7WUIcN7XM4f32NJIpNI1HZfKGGasxO8AeET2v7qvWvFwXqZ3zUAAhBU
   cVbFGhiTYoaEe5orJ10d1CknkxYUB9lbFDg2XvDYakzyjHJpP92QVqHI9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="260679028"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="260679028"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 20:14:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="574129606"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.30.200]) ([10.255.30.200])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 20:14:05 -0700
Message-ID: <3ba5609b-2e39-8e22-d72d-e114adea9109@linux.intel.com>
Date:   Fri, 15 Apr 2022 11:14:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Fwd: perf :: intel hybrid events (fwd)
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
References: <alpine.LRH.2.20.2204131302230.29735@Diego>
 <CA+JHD92zy1iOkok57goXrhjOmri+fZXRhOoNGzwBW+t_a84etw@mail.gmail.com>
 <0dcc7164-bbfe-0ff0-7c84-24eb07017022@linux.intel.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <0dcc7164-bbfe-0ff0-7c84-24eb07017022@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 4/13/2022 9:27 PM, Liang, Kan wrote:
> 
> Hi Michael,
> 
> Thanks for reporting the issues.
>>
>>
>> Forwarding the questions to perf-users...
>>
>> Also, I have found out that mem-stores:p event does not work on
>> Intel Alderlake:
>>
>> # perf record -e mem-stores -- ./examples/dummy > /dev/null
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.024 MB perf.data (64 samples) ]
>>
>> While with precise, it records nothing:
>>
>> # perf record -e mem-stores:p -- ./examples/dummy > /dev/null
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.021 MB perf.data ]
>>
>> This makes the perf-mem and perf-c2c commands less useful.
>>
>> Again, is this how it is supposed to work or do I miss some fixes?
>> Or does upstream also miss some fixes?
>>
> 
> It looks like a perf tool bug.
> 
> Actually, we did the support for the perf mem record with patch 
> 4a9086adc329 ("perf mem: Support record for hybrid platform").
> It seems we need some extra work for mem-stores:p as well.
> 
> 
>> Thanks.
>> Michael
>>
>> ---------- Forwarded message ----------
>> Date: Tue, 12 Apr 2022 22:59:11
>> From: Michael Petlan <mpetlan@redhat.com <mailto:mpetlan@redhat.com>>
>> To: yao.jin@linux.intel.com <mailto:yao.jin@linux.intel.com>
>> Subject: perf :: intel hybrid events
>>
>> Hello Jin Yao,
>>
>> I have a few questions/ideas about hybrid events on Alderlake...
>>
> 
> Now, Zhengjun focus on the userspace perf tool enabling.
> 
> Zhengjun, could you please take a look all the issues?
> 
Sure. I will fix the issues.
>>
>> 1) L1-{d,i}cache-load{,-misse}s supported partially
>>
>> Interestingly enough, perf offers the following events in the hwcache 
>> set:
>>
>> L1-dcache-load-misses
>> L1-dcache-loads
>> L1-icache-load-misses
>> L1-icache-loads
>>
>> Of course, each expands to its cpu_core and cpu_atom version, as 
>> following:
>>
>> # perf stat -e L1-icache-load-misses
>> ^C
>>   Performance counter stats for 'system wide':
>>             146,566      cpu_core/L1-icache-load-misses/
>>             164,971      cpu_atom/L1-icache-load-misses/
>>
>> On my Alderlake testing box with RHEL-9 I see the following support 
>> pattern:
>>
>>                           |  cpu_core  |  cpu_atom  |
>> L1-dcache-load-misses    |     OK     |     N/A    |
>> L1-dcache-loads          |     OK     |     OK     |
>> L1-icache-load-misses    |     OK     |     OK     |
>> L1-icache-loads          |     N/A    |     OK     |
>>
>> For dcache, loads are supported on both, while misses do not work on 
>> atom.
>> That can be, atom is simpler, thus I can expect it missing some events...
>>
>> For icache, misses are supported on both, while loads do not work on 
>> core.
>> This looks weird, is that really the wanted behavior? Isn't there a 
>> bug in
>> the drivers/event specifications?
> 
> That's expected. We don't have a proper event for the L1-icache-loads on 
> big core and L1-dcache-load-misses on Atom.
> You can see the same behavior on the previous core platform SKL and atom 
> platform GLP and TNT.
> 
>>
>>
>> 2) You added --cputype switch to perf-stat via 
>> e69dc84282fb474cb87097c6c94
>> so one can restrict the expansion and keep only one cpu type used. 
>> Doesn't
>> perf-record need the same?
> 
> Yes, I agree.
> 
>>
>>
>> 3) While perf-stat defaults to "use whatever we can" approach when not 
>> every
>> event is supported, puts "<not supported>" into the results, perf-record
>> fails. This is bad for the cases like above, since it fails when one 
>> of the
>> events aren't supported. That might make sense if the unsupported 
>> event was
>> specified explicitly by the user, e.g. `perf record -e AA -e BB -- 
>> ./load`
>> and perf fails "sorry, I don't support event BB".
>>
>> However, what if the user just wants L1-dcache-load-misses and encounters
>> perf-record failing just because the event is not supported on Atom?
>>
>> Shouldn't this behavior be fixed by some --tolerant switch that would 
>> ignore
>> the problems and record what is going on on the Core at least?
>>
>>
> 
> Yes, I agree. I think we should collect anything we can collect. For the 
> unsupported event, a warning should be printed.
> 
> BTW: Besides the cache events, the topdown events also have some issues 
> (perf stat --topdown and perf stat defaults) on the hybrid platforms. 
> Zhengjun is working on it. Some Topdown related patches for the hybrid 
> platforms will be posted soon.
> 
> 
> Thanks,
> Kan
>> What are your ideas?
>> Thanks...
>>
>> Michael
>>

-- 
Zhengjun Xing
