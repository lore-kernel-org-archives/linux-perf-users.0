Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159116B3BF;
	Thu, 11 Jul 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703240; cv=none; b=JbHiJAqvju6B9qMiAsILZlwzlMvnqQw0ZxWkZkBaCPISvBJbSFnF2E9yetNPoorzCryzAiRnNbwCL0QIq6yadtOo2IliAHnpVeoSHoWrT6WY7KKRnGsYM4hcPdwyeIJFd64g6hmx9OGw46ct2n35JHgbJiFOiZkxInl401ucwYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703240; c=relaxed/simple;
	bh=Bw1CDs/sg/K1NvNb66K5hwELjtRSAbZQj0qWX4uUW7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1JW4oBVXFqTBtPDiYA2t2c62++8V34VWK/E0/N0gUccuGsRf899tzNvvB1BD4zjjDrf+zZMx6WEPBCAIB1yEwDXtGdIz/ShzAPsrZZK8E7BMbKTHTvl5PgprXzW8yGB5bb+CcifC6XbSgQzSN9Q8TnYbzRI79xVSdygJfVvCJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAJZDMTo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAJZDMTo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720703239; x=1752239239;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bw1CDs/sg/K1NvNb66K5hwELjtRSAbZQj0qWX4uUW7M=;
  b=lAJZDMTokRYcD5KbUIikutl8cONwllnF0K7jZ24RQAydSjWuAf0kqd74
   qAzh69svcX5KMS4E0jgTT60rwxWQmPPdHiPi0mL2FB2iq/ZuUqgkU4tAk
   5mjgAuDvwDLEPS8TuBd4g0ua9XulZ3M6iZ3bjXSD98y2Lif4H22PFm7qj
   p4kI4TDpP3OUqKcBhfe5S1ZNX3XjA02tfmlAlGzverAYfO2pHilV2gLu6
   4m/2ZKRAjTpNPx4gGCvwQP2dkeblJot9452CfWZ5VTH1GOpWwO/cjMT4H
   xou9fK6xSIypZpQD45nY6WyGoc9IMKcFH+SKqGqj8A1dh17AIoFS8829T
   A==;
X-CSE-ConnectionGUID: NHTUzXLxSbi4MYtNx8WTDA==
X-CSE-MsgGUID: EbMoiSYcTp2NuPmQ9AMTZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="17695198"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="17695198"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 06:07:06 -0700
X-CSE-ConnectionGUID: CwCrJuGJTc2wbQHB7kUnAQ==
X-CSE-MsgGUID: hbSYrspaSY2+5GgI4VzO1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="53727131"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 06:07:05 -0700
Received: from [10.212.47.156] (kliang2-mobl1.ccr.corp.intel.com [10.212.47.156])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7561820738F3;
	Thu, 11 Jul 2024 06:07:03 -0700 (PDT)
Message-ID: <98c73f1a-e5e3-4eba-ac52-ccf21e3a063c@linux.intel.com>
Date: Thu, 11 Jul 2024 09:07:02 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [perf vendor events] e2641db83f:
 perf-sanity-tests.perf_all_PMU_test.fail
To: Oliver Sang <oliver.sang@intel.com>
Cc: Ian Rogers <irogers@google.com>, oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 Namhyung Kim <namhyung@kernel.org>, Weilin Wang <weilin.wang@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202407101021.2c8baddb-oliver.sang@intel.com>
 <a0ac56fc-eedc-492b-884c-d68e0460f178@linux.intel.com>
 <Zo+SC/OORdGWXQ84@xsang-OptiPlex-9020>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Zo+SC/OORdGWXQ84@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-11 4:04 a.m., Oliver Sang wrote:
> hi, Kan,
> 
> On Wed, Jul 10, 2024 at 09:15:05AM -0400, Liang, Kan wrote:
>>
>>
>> On 2024-07-10 12:59 a.m., kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed "perf-sanity-tests.perf_all_PMU_test.fail" on:
>>>
>>> commit: e2641db83f18782f57a0e107c50d2d1731960fb8 ("perf vendor events: Add/update skylake events/metrics")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>
>>> [test failed on linux-next/master 82d01fe6ee52086035b201cfa1410a3b04384257]
>>>
>>> in testcase: perf-sanity-tests
>>> version: 
>>> with following parameters:
>>>
>>> 	perf_compiler: gcc
>>>
>>>
>>>
>>> compiler: gcc-13
>>> test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory
>>>
>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>>
>>>
>>> we also observed two cases which also failed on parent can pass on this commit.
>>> FYI.
>>>
>>>
>>> caccae3ce7b988b6 e2641db83f18782f57a0e107c50
>>> ---------------- ---------------------------
>>>        fail:runs  %reproduction    fail:runs
>>>            |             |             |
>>>            :6          100%           6:6     perf-sanity-tests.perf_all_PMU_test.fail
>>>            :6          100%           6:6     perf-sanity-tests.perf_all_metricgroups_test.pass
>>>            :6          100%           6:6     perf-sanity-tests.perf_all_metrics_test.pass
>>>
>>>
>>>
>>>
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>> | Closes: https://lore.kernel.org/oe-lkp/202407101021.2c8baddb-oliver.sang@intel.com
>>>
>>>
>>>
>>> 2024-07-09 07:09:53 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 105
>>> 105: perf all metricgroups test                                      : Ok
>>> 2024-07-09 07:10:11 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 106
>>> 106: perf all metrics test                                           : Ok
>>> 2024-07-09 07:10:23 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 107
>>> 107: perf all libpfm4 events test                                    : Ok
>>> 2024-07-09 07:10:47 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 108
>>> 108: perf all PMU test                                               : FAILED!
>>
>> Can you please try the -vvv option, which should tell the failed event?
>> perf test -vvv "perf all PMU test"
> 
> after add -vvv:
> 
> 2024-07-11 07:45:20 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test -v 108
> 108: perf all PMU test:
> --- start ---
> test child forked, pid 18989
> Testing (null)

The test cases use the "perf list --raw-dump pmu" to get a complete
event list. It seems the perf list command got nothing. That's weird.

The main change of e2641db83f18 is to add the "Counter" field and a few
events. It should not impact the perf list command.

What's the output of "perf list --raw-dump pmu" on your machine?

Thanks,
Kan
> ---- end(-1) ----
> 108: perf all PMU test                                               : FAILED!
> 
> 
>>
>> Thanks,
>> Kan
>>>
>>>
>>>
>>> The kernel config and materials to reproduce are available at:
>>> https://download.01.org/0day-ci/archive/20240710/202407101021.2c8baddb-oliver.sang@intel.com
>>>
>>>
>>>
>>
> 
