Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D2427A917;
	Tue, 11 Nov 2025 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762891299; cv=none; b=XBiqKaDK17YUleunc8KKgJSImNQB12bJkWSYgLgA5XX7SbhQSWxNSXZxROAYjbtmzShZaMhWKI3J0jwlptDfYKy+D8t7dbISczs3uUw1iBGThjJgx5+Fe2zCirD2a789fm76X8c/tYSbl1WGNazgP25U57K4CKhGEOYLJkoD0mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762891299; c=relaxed/simple;
	bh=bIgxj6tsW2gXzHC4yOUbUnjX1qh2NiifQnGM0+JrDkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYbIzIMzbmgIr+ydSyb25RbC7NyuBtsLNegnBTyB/zeWfqYR0TFQ6VJVNIbbDgw61U7M5oPhjvC+8R5ldhowuPJ8tkmlp2bDwjhGPMPHkREg+L95LVNRJuVHJ8ZjKXjCaHG3eV/LZpgoBNY1xtvl8UM/cqBkXHDnkQVz12NBxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXBa4OIJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXBa4OIJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762891298; x=1794427298;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bIgxj6tsW2gXzHC4yOUbUnjX1qh2NiifQnGM0+JrDkI=;
  b=dXBa4OIJtbIt8j8epv9XDauk5/TTs7K7OgDwFIHb+t1u+hxopjBS/Zs6
   8ybdwfJpaJDxIzb8PifuCe2jmkNrgBzCy0xxsY5LjQ5e6pUbGfw4dgYUa
   fhyoaJCR5X8q8IsuKAnS6zn2B1/NCYix2obK1/cpgWmifbb4bagHGInVU
   Tm+Po7/co3ESrcLqKB6tnJwfZDdhdCi8B6nlgrS1zV7PVrF7vG75izVvt
   XpqRvIJl2EUBX/cfXrN+G3LEiLbvhVl790HM3LeP8FVLssO/y3N0AGzER
   /z3zomkwszOXvuPvbe7EWxoJyHutyAUhpRBKSipzOX7007ogjKcswanpG
   g==;
X-CSE-ConnectionGUID: GHSz5gAfSSynL5i6OSe29Q==
X-CSE-MsgGUID: yo3ss4ceRnO2dUwY3fSloA==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="76305742"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="76305742"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 12:01:37 -0800
X-CSE-ConnectionGUID: DQ20mfd0RYa3uQt00C/ANg==
X-CSE-MsgGUID: Q8AD/NA5StupJ+h4idY1mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="219769155"
Received: from aksajnan-mobl1.amr.corp.intel.com (HELO [10.125.50.87]) ([10.125.50.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 12:01:36 -0800
Message-ID: <b097dc88-f66c-4f0d-b694-aefb73128fad@intel.com>
Date: Tue, 11 Nov 2025 12:01:36 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Refactor precise_ip fallback logic
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 thomas.falcon@intel.com, dapeng1.mi@linux.intel.com, xudong.hao@intel.com
References: <aP1ucJiJYBavTHV7@google.com>
 <e10d671a-eb89-4e06-a1eb-e2f12ee41d70@intel.com>
 <aQl3qfyTdAb68l1l@google.com>
 <652bf158-ba9e-4a97-b4c3-3a7f7e39fe85@intel.com>
 <aQzugcpRvOcPEEro@google.com>
 <5f84fe4f-90ef-42d6-8a3a-c1f515a7832a@intel.com>
 <aQ5n4ML9lxY4VAxi@google.com>
 <eb41cde1-9611-4998-a82f-5d6efb80b0d1@intel.com>
 <aRLq0isFxDJlsHlL@google.com>
 <42bafd4d-ff6e-4529-95f7-9c4c963fc49c@intel.com>
 <aROPrA02BU1uafrD@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aROPrA02BU1uafrD@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/2025 11:34 AM, Namhyung Kim wrote:
> On Tue, Nov 11, 2025 at 11:11:45AM -0800, Chen, Zide wrote:
>>
>>
>> On 11/10/2025 11:50 PM, Namhyung Kim wrote:
>>> On Fri, Nov 07, 2025 at 02:31:23PM -0800, Chen, Zide wrote:
>>>>
>>>>
>>>> On 11/7/2025 1:42 PM, Namhyung Kim wrote:
>>>>> On Thu, Nov 06, 2025 at 05:23:09PM -0800, Chen, Zide wrote:
>>>>>>
>>>>>>
>>>>>> On 11/6/2025 10:52 AM, Namhyung Kim wrote:
> 
>>>>> Can you run these commands and show the output here?
>>>>>
>>>>>   $ perf record -e task-clock:S  true
>>>>>   $ perf evlist -v
>>>>
>>>> On 6.18.0-rc4:
>>>>
>>>> $ perf record -e task-clock:S  true
>>>> [ perf record: Woken up 2 times to write data ]
>>>> [ perf record: Captured and wrote 0.006 MB perf.data ]
>>>>
>>>> $ perf evlist -v
>>>> task-clock:Su: type: 1 (PERF_TYPE_SOFTWARE), size: 136, config: 0x1
>>>> (PERF_COUNT_SW_TASK_CLOCK), { sample_period, sample_freq }: 4000,
>>>> sample_type: IP|TID|TIME|READ|ID|PERIOD, read_format: ID|LOST, disabled:
>>>> 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, freq:
>>>> 1, enable_on_exec: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1,
>>>> ksymbol: 1, bpf_event: 1, build_id: 1
>>>
>>> Thanks for sharing this.  Yep, it has the inherit bit.
>>>
>>> I think there's a bug in the missing feature test.  Indeed, it should
>>> also have PERF_SAMPLE_TID for the test according to the kernel comment.
>>>
>>> 	/*
>>> 	 * We do not support PERF_SAMPLE_READ on inherited events unless
>>> 	 * PERF_SAMPLE_TID is also selected, which allows inherited events to
>>> 	 * collect per-thread samples.
>>> 	 * See perf_output_read().
>>> 	 */
>>> 	if (has_inherit_and_sample_read(attr) && !(attr->sample_type & PERF_SAMPLE_TID))
>>> 		return ERR_PTR(-EINVAL);
>>
>> It seems that the purpose of the inherit_sample_read fallback is to
>> remove the inherit attribute when both PERF_SAMPLE_READ and inherit are
>> present, but PERF_SAMPLE_TID is not. The new change may not be able to
>> accomplish this?
> 
> No, the purpose of the missing feature check is to detect whether the
> current kernel supports this feature or not.  The correct check should
> pass both READ and TID together.


OK, thanks!

> Thanks,
> Namhyung
> 

