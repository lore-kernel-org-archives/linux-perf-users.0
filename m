Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857322;
	b=SPJdWzMYDsPTWJPdVgc/tyzmjOZ10Qe6HLtFMWo4bwDGlxX3jpFlpQckPbrBLir5cfXM
	 qOti/Z+qSvMfBMIonk2NX8yyqMGKvxLSIyyCenFVK93dc9XdmnRHVHdMmDtOOlvm3drPC
	 XXAB4/3j4afykEIbUJHM1ow4NM7xHBDiRz1+dcJgYFeoOGGtbF03MaN26CTQudjNXcQh3
	 PsaoMbF3j5wXM5mOCUrJf88PWv/JkW50HB1UKCOA4GTl4qFy9DJQ2nlVdkUKgHJ8HxtVc
	 RAJts5vKCfvX6o8aiW0kdCazhhSa+9jz5IEfzio8DXsvKA2L8MkMi6QraQuIV5/CoVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857322;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9wlTg2Dr/LsFlagA3DtpGqNOCAVA82K6+eoM9BoGZ50=;
	b=fl62C7tviQuli6KN7PG2+doUTJEMMmbV86debnPm0SGdhdA8aSFwhmW+1tEU/TZ8bf+4
	 ogWtgu7cE9QqkRCVuwUXq4zq0UzIBQwbv2T8BtwMGccOoVQk7CLTmOJ10oVQ7S8kpAqKV
	 HdpH9rAQnBsh6c17TJxywjb70dWk3wcd0gyiIVC6iOveDJAdF6oX0hId5gV45Ld5h7VLC
	 1xzL71TDn7uDM1KZwNyaU4BiLpBJQAhDt3895ybykM+GtB/o2agk4pH0S2Du5tBRfGxgY
	 1phDpF5R3ZlUV3/Vm5klYttTDvts6MmVJrIHB2klR1QqzCqMAs1sSHsHaK85e0BAMwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FIvAoHki;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22150606A326;
	Thu,  5 Nov 2026 05:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22150606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FIvAoHki
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793857322; x=1825393322;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DJf4bTNPHkLVygRJnF6XNHKdcTG9QdbUCz5UjaoLfmM=;
  b=FIvAoHkizvI1n3/v/lbGYAq2MlS1hpmKrHIKQEnwgLqJ4wP+K1P0w8t5
   ASdvErTWYYhkmxSIEfOZ4Q2V7WVNd9f+sxvDDvgy4wwAKKFUboVjCH3fT
   l9y8/AQoCRqL8aTqyfuJmjjcLF7uybCz1XlreX4WQoUx5tZtNL2W6WrNT
   H0/X+9cNM4NaiVUL+ZtauGujuouok+T91DZ2obi35eq/5M8RKAOLMvwIP
   n17YBftmnMBC8ph7X9NVjdBH6U5kH1l5XnurujgfmS0IMjQz7Sjjqitqt
   Glkco7py6wHGPoWYG122AgwwCvFzrFXwGMWaE6KtlOMDL61bUHnJ48sNp
   w==;
X-CSE-ConnectionGUID: PtdEtMypTxiZATzIukLhfQ==
X-CSE-MsgGUID: hZ8pYdBQQGCCo3U+541zSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2667958"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2667958"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 21:42:01 -0800
X-CSE-ConnectionGUID: g4XYH+QNRBaBCIfS0JtifA==
X-CSE-MsgGUID: N0+cnYwkScmA2LHAHWG8JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7041297"
Received: from unknown (HELO [10.238.2.61]) ([10.238.2.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 21:41:56 -0800
Message-ID: <2d1a2dcb-f1db-4126-80b7-217a62cea136@linux.intel.com>
Date: Thu, 5 Nov 2026 13:41:53 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [perf vendor events intel] 31efbec216:
 perf-stat-tests.UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU.fail
To: Ian Rogers <irogers@google.com>, kernel test robot <yi1.lai@intel.com>,
 "Taylor, Perry" <perry.taylor@intel.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Edward <edward.baker@intel.com>,
 "Chen, Zide" <zide.chen@intel.com>, luis.f.recalde@intel.com
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
References: <202611050912.2cdf1ff5-lkp@intel.com>
 <CAP-5=fUk4Q3PxNiqwHtyM6XTt9LGZaTe9p7o9k2gL7f2LBRBHw@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fUk4Q3PxNiqwHtyM6XTt9LGZaTe9p7o9k2gL7f2LBRBHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/5/2026 12:22 PM, Ian Rogers wrote:
> On Wed, Nov 4, 2026 at 5:47 PM kernel test robot <yi1.lai@intel.com> wrote:
>>
>>
>> Hello,
>>
>> kernel test robot noticed "perf-stat-tests.UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU.fail" on:
>>
>> commit: 31efbec2161d2d31b020b086958e41f35f070a38 ("perf vendor events intel: Update sapphirerapids events from 1.39 to 1.40") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> [test failed on linux-next/master 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c]
>>
>> in testcase: perf-stat-tests
>> with following parameters:
>>
>>
>> config: x86_64-rhel-9.4-bpf
>> compiler: gcc-14
>> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <yi1.lai@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202611050912.2cdf1ff5-lkp@intel.com
>>
>>
>> EventName: UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU
>> 2026-10-05 17:15:24 perf stat -e UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU -a sleep 0.1
>> event syntax error: 'UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU'
>>                      \___ Bad event name
>>
>> Unable to find event on a PMU of 'UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU'
> Ok, this is an ugly issue. When we fixed the issue so that umasks of 0
> weren't dropped, we added new umasks:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=31efbec2161d2d31b020b086958e41f35f070a38
> ```
> ...
> @@ -1923,6 +1974,7 @@
>          "PerPkg": "1",
>          "PortMask": "0x0000",
>          "PublicDescription": "UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU",
> +        "UMask": "0x7000000",
> ...
> ```
> The umask calculation is odd:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#L361
> ```
>         # Combine the umask with the umask_ext. We don't know the
>         # width of the umask as we concatenate the strings, removing
>         # "0x"
>         if umask_ext:
>             self.umask = umask_ext + self.umask[2:] if self.umask else
> umask_ext + "00"
> ```
> For Sapphire Rapids the UMaskExt is:
> https://github.com/intel/perfmon/blob/main/SPR/events/sapphirerapids_uncore_experimental.json#L17422
> ```
> ...
>     {
>       "Unit": "IIO",
>       "EventCode": "0x8f",
>       "UMask": "0x00",
>       "PortMask": "0x0000",
>       "FCMask": "0x00",
>       "UMaskExt": "0x00070000",
>       "EventName": "UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU",
>       "BriefDescription": "ITC address map 1",
>       "PublicDescription": "UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU",
>       "Counter": "0,1,2,3",
>       "ELLC": "0",
>       "Filter": "na",
>       "ExtSel": "0",
>       "Deprecated": "0",
>       "FILTER_VALUE": "0",
>       "CounterType": "PGMABLE"
>     },
> ...
> ```
> So that's hex 7 followed by 4 zeros. In the generated perf json it is
> hex 7 followed by 6 zeros as we concatenated the UMask's 00 to the
> front.
>
>> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>>                                   \___ value too big for format (umask), maximum is 255
> This error indicates that the UMask for the IIO PMU only expects
> values from 0 to 255.

+ Zide, Luis

According to current uncore driver, SPR IIO supports the extended umask
field which locates at bits [50:32], so the UMaskExt data of
UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU looks correct. I suppose we should not
or could be very hard to check the valid range of umaskext in perf tools.
Currently different uncore PMUs may have different umaskext layout and the
umaskext of some uncore events could be very large.

Currently the Intel uncore driver would validate the umask/umaskext from
user space. It would be good enough.

@Luis, @Edward, please double confirm. Thanks.


>
> So something is wrong in how we interpret the UMask and UMaskExt for
> Sapphire Rapids' IIO. Could someone from Intel take a look? Is the
> problem in the original perfmon event json, is there a different way
> to encode the UMaskExt for the IIO on SPR or is the IIO PMU on SPR
> constraining the umask too much?
>
> Thanks,
> Ian
>
>
>> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>>                                   \___ value too big for format (umask), maximum is 255
>>
>> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>>                                   \___ value too big for format (umask), maximum is 255
>>
>> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>>                                   \___ value too big for format (umask), maximum is 255
>>
>> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>>                                   \___ value too big for format (umask), maximum is 255
>>
>> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>>                                   \___ value too big for format (umask), maximum is 255
>>
>> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>>                                   \___ value too big for format (umask), maximum is 255
>>
>> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>>                                   \___ value too big for format (umask), maximum is 255
>>
>> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>>                                   \___ value too big for format (umask), maximum is 255
>>
>> event syntax error: '..O_NUM_TGT_MATCHED_REQ_OF_CPU'
>>                                   \___ value too big for format (umask), maximum is 255
>> Run 'perf list' for a list of valid events
>>
>>  Usage: perf stat [<options>] [<command>]
>>
>>     -e, --event <event>   event selector. use 'perf list' to list available events
>>
>>
>> The kernel config and materials to reproduce are available at:
>> https://download.01.org/0day-ci/archive/20261105/202611050912.2cdf1ff5-lkp@intel.com
>>
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
>>
>>
