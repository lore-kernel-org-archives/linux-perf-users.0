Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6372C859;
	Mon,  1 Jul 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719827477; cv=none; b=d/KfX7x4NOmrF4BNOJtL9pA8/ymHJ3PR5WqHWuGbWzuJCXsCEn3ycyY301lY9NwtsJmRWQ+BdUam+Nrm4GsKz35MH2JNvRfVaP7q1z1SHAi8fbpbprQGNoBf8cV8/oeNGz1Orhoif8gZEH8vT2C2qjSblxiK6QSAbgS5mn4+Lig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719827477; c=relaxed/simple;
	bh=yKWtYTbS3qpNtS6WsmHfq2eHCxVi3Q8AxVnwoo5d3eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sudtd20hhwJoG8rjz+EuxnDdeBxAz3/w4MUNR2leAB79lzZxazxh8QrQaJhWbumap7n0lXB4a++rWZu5XaMMDXd8h7WCiRGz5H4iH+RGXX7SPm0bRJ+/wY5Ca3MpOGRM8XuJJhTa9OLM86SkKaRMdL/qxtt9Kqjlk4KcMm54LZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TeqbyRSS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TeqbyRSS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719827477; x=1751363477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yKWtYTbS3qpNtS6WsmHfq2eHCxVi3Q8AxVnwoo5d3eI=;
  b=TeqbyRSSVzw4pxzhZUlwrD1L9LeF+fEsgt45NBh2nZAXGCpMdxVJ9uZG
   ZUO+jCKLiI3haYTHlGe/kjm3urH/A1kBVlP9WKQgV2fUrSrCn7Ple/1Uk
   dMKYSpANjQ+DobKzWCWmV7Za/M5GjGbTzP5qncqQJ5b8p9Pn2bWqXznvj
   IzvVkap3kMtOdAkZ43diqcKKsfFH4Dt3K3tnMtFFTyhC719h9+QjNcKFb
   nTnk/zdrr7/uyto1Vm9ZhID1WArw6DsNN1lixWIiVsAldaOnaGKg7r5AH
   R9J0ApeT2SD8UYnMOI6SBoIpzsId0lF+2LesLTNu4Z5rbcqpRPmbMJcqz
   g==;
X-CSE-ConnectionGUID: AVioUNiFSIynu2XC7g5zuw==
X-CSE-MsgGUID: TFPIBzx+RWOkYQJtiXpitA==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="20759822"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="20759822"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 02:51:16 -0700
X-CSE-ConnectionGUID: 6uIx7oc+RGy+i9SpXNbhwA==
X-CSE-MsgGUID: Ngzqc+JQTQm4LLX2pO3UoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="49795701"
Received: from xfang-mobl1.ccr.corp.intel.com (HELO [10.124.225.1]) ([10.124.225.1])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 02:51:11 -0700
Message-ID: <c0a9ffb6-e6ea-4159-9cc0-a23df5e59429@linux.intel.com>
Date: Mon, 1 Jul 2024 17:51:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf topdown: Correct leader selection with sample_read
 enabled
To: "Liang, Kan" <kan.liang@linux.intel.com>, Ian Rogers <irogers@google.com>
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
 <350e5bf7-23ee-4a7f-8b62-e3d07604cbe1@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <350e5bf7-23ee-4a7f-8b62-e3d07604cbe1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/29/2024 4:27 AM, Liang, Kan wrote:
>
> On 2024-06-28 2:28 p.m., Ian Rogers wrote:
>> On Thu, Jun 27, 2024 at 11:17 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>> On 6/27/2024 11:11 PM, Liang, Kan wrote:
>>>> On 2024-06-14 5:39 p.m., Dapeng Mi wrote:
>>>>
>>>> Besides, we need a test for the sampling read as well.
>>>> Ian has provided a very good base. Please add a topdown sampling read
>>>> case on top of it as well.
>>>> https://lore.kernel.org/lkml/CAP-5=fUkg-cAXTb+3wbFOQCfdXgpQeZw40XHjfrNFbnBD=NMXg@mail.gmail.com/
>>> Sure. I would look at it and add a test case.
>> Thanks Dapeng and thanks Kan too! I wonder if we can do a regular
>> counter and a leader sample counter then compare the counts are
>> reasonably consistent. Something like this:
>>
>> ```
>> $ perf stat -e instructions perf test -w noploop
>>
>> Performance counter stats for '/tmp/perf/perf test -w noploop':
>>
>>    25,779,785,496      instructions
>>
>>       1.008047696 seconds time elapsed
>>
>>       1.003754000 seconds user
>>       0.003999000 seconds sys
>> ```
>>
>> ```
>> cat << "_end_of_file_" > a.py
>> last_count = None
>>
>> def process_event(param_dict):
>>    if ("ev_name" in param_dict and "sample" in param_dict and
>>        param_dict["ev_name"] == "instructions"):
>>        sample = param_dict["sample"]
>>        if "values" in sample:
>>            global last_count
>>            last_count = sample["values"][1][1]
>>
>> def trace_end():
>>    global last_count
>>    print(last_count)
>> _end_of_file_
>> $ sudo perf record -o -  -e "{cycles,instructions}:S" perf test -w
>> noploop|perf script -i - -s ./a.py
>> [ perf record: Woken up 2 times to write data ]
>> [ perf record: Captured and wrote 0.459 MB - ]
>> 22195356100
>> ```
>>
>> I didn't see a simpler way to get count and I don't think it is right.
> The perf stat can cover the whole life cycle of a workload. But I think
> the result of perf record can only give the sum from the beginning to
> the last sample.
> There are some differences.
>
>> There's some similar perf script checking of data in
>> tools/perf/tests/shell/test_intel_pt.sh.
>>
> I think the case should be to test the output of the perf script, rather
> than verify the accuracy of an event.
>
> If so, we may run two same events. They should show the exact same
> results in a sample.
>
> For example,
>
> perf record  -e "{branches,branches}:Su" -c 1000000 ./perf test -w brstack
> perf script
> perf  752598 349300.123884:    1000002 branches:      7f18676a875a
> do_lookup_x+0x2fa (/usr/lib64/l>
> perf  752598 349300.123884:    1000002 branches:      7f18676a875a
> do_lookup_x+0x2fa (/usr/lib64/l>
> perf  752598 349300.124854:    1000005 branches:      7f18676a90b6
> _dl_lookup_symbol_x+0x56 (/usr/>
> perf  752598 349300.124854:    1000005 branches:      7f18676a90b6
> _dl_lookup_symbol_x+0x56 (/usr/>
> perf  752598 349300.125914:     999998 branches:      7f18676a8556
> do_lookup_x+0xf6 (/usr/lib64/ld>
> perf  752598 349300.125914:     999998 branches:      7f18676a8556
> do_lookup_x+0xf6 (/usr/lib64/ld>
> perf  752598 349300.127401:    1000009 branches:            4c1adf
> brstack_bench+0x15 (/home/kan/o>
> perf  752598 349300.127401:    1000009 branches:            4c1adf
> brstack_bench+0x15 (/home/kan/o>

This looks a more accurate validation. I would add this test.


>
> Thanks,
> Kan
>
>> Thanks,
>> Ian
>>
