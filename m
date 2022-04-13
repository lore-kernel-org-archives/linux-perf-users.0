Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACECC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Apr 2022 13:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiDMNaQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 09:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiDMNaP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Apr 2022 09:30:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A84E5D5F1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Apr 2022 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649856474; x=1681392474;
  h=message-id:date:mime-version:subject:references:from:to:
   cc:in-reply-to:content-transfer-encoding;
  bh=8uLKJ0RgAZrCb8ZgA4lTgS5BS3bNzi3e2dLPbHnL7xE=;
  b=CLWcZBwdUoTP5rq+2tJH/X73nC7H+NnbSw2cgZfvArk3G+TT2YF7aKQg
   qA4AiN5qf4EgH9KKevCfiqyefGd8cFQqZW9rtiEU42sQ2yiqv0UQKgph7
   oA99kLg3rFg9NViNwN0Tmehyq3buEuYXZ6Rhne/y9Xmtwww49VEkbzuJz
   iW77xKFXT6cjB2YF3sRJaSQEwGWm9qJhUbrfedfK8zMsKTYmxszYU5hIC
   Dky7gFRxCyhhM9LzKBhQ5E9T4NiGMSQEKyJdGx/4cikW3G9wcJ1l5ud7l
   9BXDGcNZAmxCfRbaTtAPP/8uMv10lFdTeZf9GyBWIzr9Cxg6qRLGx6qfW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262102430"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="262102430"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 06:27:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="623681083"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2022 06:27:53 -0700
Received: from [10.212.225.84] (kliang2-MOBL.ccr.corp.intel.com [10.212.225.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0DD1B5805BD;
        Wed, 13 Apr 2022 06:27:52 -0700 (PDT)
Message-ID: <0dcc7164-bbfe-0ff0-7c84-24eb07017022@linux.intel.com>
Date:   Wed, 13 Apr 2022 09:27:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Fwd: perf :: intel hybrid events (fwd)
Content-Language: en-US
References: <alpine.LRH.2.20.2204131302230.29735@Diego>
 <CA+JHD92zy1iOkok57goXrhjOmri+fZXRhOoNGzwBW+t_a84etw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
In-Reply-To: <CA+JHD92zy1iOkok57goXrhjOmri+fZXRhOoNGzwBW+t_a84etw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


Hi Michael,

Thanks for reporting the issues.
> 
> 
> Forwarding the questions to perf-users...
> 
> Also, I have found out that mem-stores:p event does not work on
> Intel Alderlake:
> 
> # perf record -e mem-stores -- ./examples/dummy > /dev/null
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.024 MB perf.data (64 samples) ]
> 
> While with precise, it records nothing:
> 
> # perf record -e mem-stores:p -- ./examples/dummy > /dev/null
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.021 MB perf.data ]
> 
> This makes the perf-mem and perf-c2c commands less useful.
> 
> Again, is this how it is supposed to work or do I miss some fixes?
> Or does upstream also miss some fixes?
> 

It looks like a perf tool bug.

Actually, we did the support for the perf mem record with patch 
4a9086adc329 ("perf mem: Support record for hybrid platform").
It seems we need some extra work for mem-stores:p as well.


> Thanks.
> Michael
> 
> ---------- Forwarded message ----------
> Date: Tue, 12 Apr 2022 22:59:11
> From: Michael Petlan <mpetlan@redhat.com <mailto:mpetlan@redhat.com>>
> To: yao.jin@linux.intel.com <mailto:yao.jin@linux.intel.com>
> Subject: perf :: intel hybrid events
> 
> Hello Jin Yao,
> 
> I have a few questions/ideas about hybrid events on Alderlake...
>

Now, Zhengjun focus on the userspace perf tool enabling.

Zhengjun, could you please take a look all the issues?

> 
> 1) L1-{d,i}cache-load{,-misse}s supported partially
> 
> Interestingly enough, perf offers the following events in the hwcache set:
> 
> L1-dcache-load-misses
> L1-dcache-loads
> L1-icache-load-misses
> L1-icache-loads
> 
> Of course, each expands to its cpu_core and cpu_atom version, as following:
> 
> # perf stat -e L1-icache-load-misses
> ^C
>   Performance counter stats for 'system wide':
>             146,566      cpu_core/L1-icache-load-misses/
>             164,971      cpu_atom/L1-icache-load-misses/
> 
> On my Alderlake testing box with RHEL-9 I see the following support pattern:
> 
>                           |  cpu_core  |  cpu_atom  |
> L1-dcache-load-misses    |     OK     |     N/A    |
> L1-dcache-loads          |     OK     |     OK     |
> L1-icache-load-misses    |     OK     |     OK     |
> L1-icache-loads          |     N/A    |     OK     |
> 
> For dcache, loads are supported on both, while misses do not work on atom.
> That can be, atom is simpler, thus I can expect it missing some events...
> 
> For icache, misses are supported on both, while loads do not work on core.
> This looks weird, is that really the wanted behavior? Isn't there a bug in
> the drivers/event specifications?

That's expected. We don't have a proper event for the L1-icache-loads on 
big core and L1-dcache-load-misses on Atom.
You can see the same behavior on the previous core platform SKL and atom 
platform GLP and TNT.

> 
> 
> 2) You added --cputype switch to perf-stat via e69dc84282fb474cb87097c6c94
> so one can restrict the expansion and keep only one cpu type used. Doesn't
> perf-record need the same?

Yes, I agree.

> 
> 
> 3) While perf-stat defaults to "use whatever we can" approach when not every
> event is supported, puts "<not supported>" into the results, perf-record
> fails. This is bad for the cases like above, since it fails when one of the
> events aren't supported. That might make sense if the unsupported event was
> specified explicitly by the user, e.g. `perf record -e AA -e BB -- ./load`
> and perf fails "sorry, I don't support event BB".
> 
> However, what if the user just wants L1-dcache-load-misses and encounters
> perf-record failing just because the event is not supported on Atom?
> 
> Shouldn't this behavior be fixed by some --tolerant switch that would ignore
> the problems and record what is going on on the Core at least?
> 
> 

Yes, I agree. I think we should collect anything we can collect. For the 
unsupported event, a warning should be printed.

BTW: Besides the cache events, the topdown events also have some issues 
(perf stat --topdown and perf stat defaults) on the hybrid platforms. 
Zhengjun is working on it. Some Topdown related patches for the hybrid 
platforms will be posted soon.


Thanks,
Kan
> What are your ideas?
> Thanks...
> 
> Michael
> 
