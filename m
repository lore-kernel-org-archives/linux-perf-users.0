Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85C46F2E9;
	Fri, 28 Jun 2024 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606462; cv=none; b=Em5UPCPSlZfXCTAPH95ME+TgZ78xwUbO7XtPpYkbUw+dKuQ2FBg3mWxvGwi5K6hRXVrxGCOdnF/0sGr7QMH3DZdKxeY9inWSBodhKglT/+E2/pzO6wFaIgCc0uU+pd4KXFHwifG9BsXFjMdHsGOVKgnF8XFj9VlJ+ODglKWg7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606462; c=relaxed/simple;
	bh=Us54NdZBLL9uoG+/Ak/v/dZ5UZ7mtgXS7aFpwxX7P3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kf+wS5p8J7lT+kwDEubtddgnBJE5oLDR1FGEyEBOj9fca4BXfax87wHt7WLwaLjOgYecEcK3bV7qIBoL+1qqD2Q4RqZfwI6YxDzKEMTFrrNAcLpZB5Ze2ZwZIjoqTXmOTUazTy3cuaoEQdf9XLVxoHQT40G8FFOA9KKasQPIx0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVq5uRba; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVq5uRba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719606461; x=1751142461;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Us54NdZBLL9uoG+/Ak/v/dZ5UZ7mtgXS7aFpwxX7P3I=;
  b=CVq5uRbaANbw07D2eeQdbE8b+A2f3mCloKGfuIcJlCYPUkHUeCZ5t9Cg
   Xy7GlnHUBLNSBoHwpJtgKtr/Buijhk6gWTLNC72FSskrN9SGw12eaGg7B
   w4cxfQNZoP+QHF3EFSOLoQYeE3yi5JEOmgPbtHIOVnm0oNPBSB8SEtm3Y
   Ntv/CKD8HpVuRqIvfgFeaySjaGJhHUtC/fCKFdT0Ja8vkrCoZBZY8X5Cg
   0S+KB4gZUoo81X0Uk0SUQnSTJ6NIO5UibPZ6Ebg1a3XXiRQIn10SH4xgl
   Pmpedu3EFIv5MdLkDUN0mpbTSjH+FdKMa0mb2G2uFW2/KpbeRmW0XEcuG
   Q==;
X-CSE-ConnectionGUID: fSV8cqexSAmREcc1GhC+uA==
X-CSE-MsgGUID: ss0Fqa7uRjCaue5XA3DhWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="34341887"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="34341887"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:27:40 -0700
X-CSE-ConnectionGUID: hHioXxSTRpKKugq5f+EKbQ==
X-CSE-MsgGUID: GD1zjEu7QIWE0yvvCTHpEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49738798"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:27:41 -0700
Received: from [10.212.75.30] (kliang2-mobl1.ccr.corp.intel.com [10.212.75.30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id BFD6220B5702;
	Fri, 28 Jun 2024 13:27:38 -0700 (PDT)
Message-ID: <350e5bf7-23ee-4a7f-8b62-e3d07604cbe1@linux.intel.com>
Date: Fri, 28 Jun 2024 16:27:37 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf topdown: Correct leader selection with sample_read
 enabled
To: Ian Rogers <irogers@google.com>, "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20240614213908.352840-1-dapeng1.mi@linux.intel.com>
 <df56c6e1-5d99-4cbe-abd4-772e7ff948af@linux.intel.com>
 <4f5dbf6f-3805-43b6-867c-2503ccec7c1a@linux.intel.com>
 <CAP-5=fVYmUvYawOBtUc_-PVzsTQhpOuMx4wxA7bHjwaZejii8Q@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVYmUvYawOBtUc_-PVzsTQhpOuMx4wxA7bHjwaZejii8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-06-28 2:28 p.m., Ian Rogers wrote:
> On Thu, Jun 27, 2024 at 11:17 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>> On 6/27/2024 11:11 PM, Liang, Kan wrote:
>>> On 2024-06-14 5:39 p.m., Dapeng Mi wrote:
>>>
>>> Besides, we need a test for the sampling read as well.
>>> Ian has provided a very good base. Please add a topdown sampling read
>>> case on top of it as well.
>>> https://lore.kernel.org/lkml/CAP-5=fUkg-cAXTb+3wbFOQCfdXgpQeZw40XHjfrNFbnBD=NMXg@mail.gmail.com/
>>
>> Sure. I would look at it and add a test case.
> 
> Thanks Dapeng and thanks Kan too! I wonder if we can do a regular
> counter and a leader sample counter then compare the counts are
> reasonably consistent. Something like this:
> 
> ```
> $ perf stat -e instructions perf test -w noploop
> 
> Performance counter stats for '/tmp/perf/perf test -w noploop':
> 
>    25,779,785,496      instructions
> 
>       1.008047696 seconds time elapsed
> 
>       1.003754000 seconds user
>       0.003999000 seconds sys
> ```
> 
> ```
> cat << "_end_of_file_" > a.py
> last_count = None
> 
> def process_event(param_dict):
>    if ("ev_name" in param_dict and "sample" in param_dict and
>        param_dict["ev_name"] == "instructions"):
>        sample = param_dict["sample"]
>        if "values" in sample:
>            global last_count
>            last_count = sample["values"][1][1]
> 
> def trace_end():
>    global last_count
>    print(last_count)
> _end_of_file_
> $ sudo perf record -o -  -e "{cycles,instructions}:S" perf test -w
> noploop|perf script -i - -s ./a.py
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.459 MB - ]
> 22195356100
> ```
> 
> I didn't see a simpler way to get count and I don't think it is right.

The perf stat can cover the whole life cycle of a workload. But I think
the result of perf record can only give the sum from the beginning to
the last sample.
There are some differences.

> There's some similar perf script checking of data in
> tools/perf/tests/shell/test_intel_pt.sh.
>

I think the case should be to test the output of the perf script, rather
than verify the accuracy of an event.

If so, we may run two same events. They should show the exact same
results in a sample.

For example,

perf record  -e "{branches,branches}:Su" -c 1000000 ./perf test -w brstack
perf script
perf  752598 349300.123884:    1000002 branches:      7f18676a875a
do_lookup_x+0x2fa (/usr/lib64/l>
perf  752598 349300.123884:    1000002 branches:      7f18676a875a
do_lookup_x+0x2fa (/usr/lib64/l>
perf  752598 349300.124854:    1000005 branches:      7f18676a90b6
_dl_lookup_symbol_x+0x56 (/usr/>
perf  752598 349300.124854:    1000005 branches:      7f18676a90b6
_dl_lookup_symbol_x+0x56 (/usr/>
perf  752598 349300.125914:     999998 branches:      7f18676a8556
do_lookup_x+0xf6 (/usr/lib64/ld>
perf  752598 349300.125914:     999998 branches:      7f18676a8556
do_lookup_x+0xf6 (/usr/lib64/ld>
perf  752598 349300.127401:    1000009 branches:            4c1adf
brstack_bench+0x15 (/home/kan/o>
perf  752598 349300.127401:    1000009 branches:            4c1adf
brstack_bench+0x15 (/home/kan/o>

Thanks,
Kan

> Thanks,
> Ian
> 
