From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Sample memory references with at least a given latency?
Date: Thu, 05 Feb 2015 08:58:40 -0800
Message-ID: <87bnl8jnwf.fsf@tassilo.jf.intel.com>
References: <54D21524.8010305@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44519 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758267AbbBEQ6l (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 5 Feb 2015 11:58:41 -0500
In-Reply-To: <54D21524.8010305@bsc.es> (Harald Servat's message of "Wed, 04
	Feb 2015 13:48:36 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harald Servat <harald.servat@bsc.es>
Cc: linux-perf-users@vger.kernel.org

Harald Servat <harald.servat@bsc.es> writes:

>   is there any way to configure perf to sample memory references
> through PEBS and enable the Load Latency Performance Monitoring
> Facility (section 18.7.1.2 from the Intel 64 and IA-32 Architectures
> Software Developer's Manual).

$ ocperf.py record -e mem_trans_retired.load_latency_gt_128 -a sleep 1
perf record -e
cpu/event=0xcd,umask=0x1,ldlat=0x80,name=mem_trans_retired_load_latency_gt_128/
-a sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.438 MB perf.data (~19125 samples) ]

-- 
ak@linux.intel.com -- Speaking for myself only
