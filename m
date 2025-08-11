Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1E1DF98F;
	Mon, 11 Aug 2025 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890544; cv=none; b=lpS+v4ecM3daXAJcbTQOeQTxrJ3hJcRoIYajRe+ulKltXL9pzleOtnR5mZGUPcChjyde6NHGKQCsptZJ1XF25mLSptOeatSonXBq2MBdUa3qhjA/WYLdsu952gN99Qzqfldz4jFZXLk+ZMfQs79zdi6F8dloCp1JYG7xNaGaVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890544; c=relaxed/simple;
	bh=CgnpQJDp35+7yJ8e+t0ZWHvTAN3cVTjQGaI66k5AzaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMq7hIVmrX5iYwrsgAuTy4U1TyORfiS+bIxzazl4CUfHs2K+76ay87k9NCp1FZK6bX2nQVDzdWwZhESTti8TbKIoCVlbIeJXW0eJJdlSG61bswK9Vh0AKAUIBJm9C3Y1o9zrbdtI2TAvNCnn2KpUdzXv1bJ/Hxw9r9GyTl0GjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PwK4pVcd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwK4pVcd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754890543; x=1786426543;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CgnpQJDp35+7yJ8e+t0ZWHvTAN3cVTjQGaI66k5AzaM=;
  b=PwK4pVcdV/YjcVPPGu7VgkacVDk4RxVTv+VXsUzCCWbtNldCWR5tLLDt
   WRz4gF2/vEDkG52TwTbB2lNJRcRwDhSt1sCRRVU6EKIVTzViLORj43gtZ
   acejAYRJ8IEpDB3xvkHyrQr9xaSgHuUJJsCTLJKocmQhOMtioLbNsJ2/a
   ibclg9Lq/if78OsctD9ov7M8nYCxm1wPZAlUUFc5NALgd6opPPxyByGNp
   nUMM/IvIFE+3Ojx/NZsbXSrYzTjKhLUAl5XAEDimb3mePjg/8Q+4leYBn
   TtZFeE/0ajl7kV3bzcBAQkN6xJDSIGSzgKWVqK/3/5HAarKh8VDKaqCBF
   A==;
X-CSE-ConnectionGUID: dxXgwY22Q2iJS0wLUpNn4A==
X-CSE-MsgGUID: bHlXsM5mSy+rTob6JqsLgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57093290"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57093290"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:35:42 -0700
X-CSE-ConnectionGUID: NsK0+QoxQ/uwXoOXbmhH7g==
X-CSE-MsgGUID: kLUmAcXWTQC4HGA8ZtrqYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="171178693"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.106]) ([10.124.240.106])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:35:39 -0700
Message-ID: <3bce547c-cde8-4779-b7cc-2da025db9484@linux.intel.com>
Date: Mon, 11 Aug 2025 13:35:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] perf tools kvm: Use "cycles" to sample guest for "kvm
 record" on Intel
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
 <20250805004633.135904-5-dapeng1.mi@linux.intel.com>
 <aJPuhpFK_ZjLk-ct@google.com>
 <154b59ee-0858-4caf-9972-3679db0a0c49@linux.intel.com>
 <aJZ16DZXNI1pvt5-@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aJZ16DZXNI1pvt5-@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/9/2025 6:10 AM, Namhyung Kim wrote:
> On Thu, Aug 07, 2025 at 11:08:11AM +0800, Mi, Dapeng wrote:
>> On 8/7/2025 8:08 AM, Namhyung Kim wrote:
>>> On Tue, Aug 05, 2025 at 08:46:32AM +0800, Dapeng Mi wrote:
>>>> After KVM supports PEBS for guest on Intel platforms
>>>> (https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.com/),
>>>> host loses the capability to sample guest with PEBS since all PEBS related
>>>> MSRs are switched to guest value after vm-entry, like IA32_DS_AREA MSR is
>>>> switched to guest GVA at vm-entry. This would lead to "perf kvm record"
>>>> fails to sample guest on Intel platforms since "cycles:P" event is used to
>>>> sample guest by default as below case shows.
>>> Do you mean we cannot use "cycles:PG" for perf kvm record?
>> Yes. Here is the output on Intel Sapphire rapids.
>>
>> sudo ./perf record -e cycles:PG -a
>> ^C[ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.801 MB perf.data ]
>>
>> No guest records are captured with PEBS, and guest PEBS records can be
>> sampled only without PEBS.
>>
>> sudo ./perf record -e cycles:G -a
>> ^C[ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.798 MB perf.data (60 samples) ]
>>
>>
>>>> sudo perf kvm record -a
>>>> ^C[ perf record: Woken up 1 times to write data ]
>>>> [ perf record: Captured and wrote 0.787 MB perf.data.guest ]
>>>>
>>>> So to ensure guest record can be sampled successfully, use "cycles"
>>>> instead of "cycles:P" to sample guest record by default on Intel
>>>> platforms. With this patch, the guest record can be sampled
>>>> successfully.
>>>>
>>>> sudo perf kvm record -a
>>>> ^C[ perf record: Woken up 1 times to write data ]
>>>> [ perf record: Captured and wrote 0.783 MB perf.data.guest (23 samples) ]
>>> What if user already gave some events in the command line?  I think you
>>> need to check if "-e" or "--event" (and "--pfm-events" too) is in the
>>> argv[] before adding these.
>> kvm_add_default_arch_event() would detect if user already sets events explicitly. If so, it won't add "cycles" event any more. Thanks.
> Oh, ok.  I can see you called parse_options to check the option.
> You'd better to check "--pfm-events" as well.

Sure. Thanks.


>
> Thanks,
> Namhyung
>
>
