Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2969DC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  9 Oct 2022 03:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJIDJq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 8 Oct 2022 23:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJIDJn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 8 Oct 2022 23:09:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256B9D93
        for <linux-perf-users@vger.kernel.org>; Sat,  8 Oct 2022 20:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665284981; x=1696820981;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=yaH3l8m0ARoupoNvXpPuxUBNqNWC9pL4yWq/2O5kq3g=;
  b=GEC3gn40yqNMNC0VBffTOr2cJpD9GlhZzQ8G/0N2yB6fGPBacT0VNjBT
   cLIQR7+AjvEWllzWmp5pr/b/dFQNhKrUV/Ph4RVT28Al2gAUk87P22Jcm
   ruigTyiga9C+0G9pfbG8RdIat7hriZu/8Kys7s/PLe+Jkv4gwBfQ18rbo
   nuKzKFWdiZ7XCbXF6k0ePH6IMkloe+exObyD2p4g32HgeJsHeKlMuIrZ6
   iO1NiqBb6wc4OKxc+7iu26I1N8XYAhOczwf160nkF0ooWAM+R29aRpR2b
   jEXBI6oXD653Ntsn8YhGcGpEpwI7bLXxWKFIYQ+LKLpWro0kM4mAyFx2L
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="365967956"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="365967956"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 20:09:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="603328191"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="603328191"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.31.146]) ([10.255.31.146])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 20:09:39 -0700
Message-ID: <39655f8f-5526-e75f-a133-7696f3e718a5@linux.intel.com>
Date:   Sun, 9 Oct 2022 11:09:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: perf :: intel hybrid events (fwd)
To:     Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org
References: <alpine.LRH.2.20.2204131302230.29735@Diego>
Content-Language: en-US
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <alpine.LRH.2.20.2204131302230.29735@Diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



I tried the will-it-scale write1 workload,  mem-stores:p works OK on 
ADL, it looks like the issue is related to the test workload.

will-it-scale:  https://github.com/antonblanchard/will-it-scale.git

# perf record -e mem-stores:p -- ./runtest.py write1
tasks,processes,processes_idle,threads,threads_idle,linear
0,0,100,0,100,0
1,2346709,96.88,2257694,96.88,2346709
^C[ perf record: Woken up 6 times to write data ]
[ perf record: Captured and wrote 1.491 MB perf.data (31612 samples) ]


On 4/13/2022 7:16 PM, Michael Petlan wrote:
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
> Thanks.
> Michael
> 
> ---------- Forwarded message ----------
> Date: Tue, 12 Apr 2022 22:59:11
> From: Michael Petlan <mpetlan@redhat.com>
> To: yao.jin@linux.intel.com
> Subject: perf :: intel hybrid events
> 
> Hello Jin Yao,
> 
> I have a few questions/ideas about hybrid events on Alderlake...
> 
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
>   Performance counter stats for 'system wide':
>             146,566      cpu_core/L1-icache-load-misses/
>             164,971      cpu_atom/L1-icache-load-misses/
> 
> On my Alderlake testing box with RHEL-9 I see the following support pattern:
> 
>                           |  cpu_core  |  cpu_atom  |
> L1-dcache-load-misses    |     OK     |     N/A    |
> L1-dcache-loads          |     OK     |     OK     |
> L1-icache-load-misses    |     OK     |     OK     |
> L1-icache-loads          |     N/A    |     OK     |
> 
> For dcache, loads are supported on both, while misses do not work on atom.
> That can be, atom is simpler, thus I can expect it missing some events...
> 
> For icache, misses are supported on both, while loads do not work on core.
> This looks weird, is that really the wanted behavior? Isn't there a bug in
> the drivers/event specifications?
> 
> 
> 2) You added --cputype switch to perf-stat via e69dc84282fb474cb87097c6c94
> so one can restrict the expansion and keep only one cpu type used. Doesn't
> perf-record need the same?
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
> What are your ideas?
> Thanks...
> 
> Michael
> 

-- 
Zhengjun Xing
